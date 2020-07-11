<?php

namespace App\Pages;

use App\Application as App;
use App\Helper as H;
use App\System;
use Zippy\Binding\PropertyBinding as Bind;
use Zippy\Html\DataList\DataView;
use Zippy\Html\Form\CheckBox;
use Zippy\Html\Form\DropDownChoice;
use Zippy\Html\Form\Form;
use Zippy\Html\Form\TextArea;
use Zippy\Html\Form\TextInput;
use Zippy\Html\Label;

class UserProfile extends \App\Pages\Base
{

    public $user;

    public function __construct() {
        parent::__construct();

        $this->user = System::getUser();

        if ($this->user->user_id == 0) {
            App::Redirect("\\App\\Pages\\Userlogin");
        }

        $form = new Form('profileform');
        $form->onSubmit($this, 'onsubmit');
        $form->add(new Label('userlogin', $this->user->userlogin));
        $form->add(new TextInput('email', $this->user->email));
        $form->add(new CheckBox('hidesidebar', $this->user->hidesidebar));
        
        $form->add(new DropDownChoice('defstore', \App\Entity\Store::getList(), $this->user->defstore));
        $form->add(new DropDownChoice('defmf', \App\Entity\MoneyFund::getList(), $this->user->defmf));
        $form->add(new DropDownChoice('pagesize', array(15 => 15, 25 => 25, 50 => 50, 100 => 100), $this->user->pagesize));


        $this->add($form);


        //форма   пароля

        $form = new Form('passwordform');
        $form->add(new TextInput('userpassword'));
        $form->add(new TextInput('confirmpassword'));
        $form->onSubmit($this, 'onsubmitpass');
        $this->add($form);

        $this->add(new Form('msgform'))->onSubmit($this, 'OnSend');
        $this->msgform->add(new TextArea('msgtext'));
        $this->msgform->add(new DropDownChoice('users', \App\Entity\User::findArray('username', 'disabled <> 1 and user_id <>' . $this->user->user_id, 'username'), 0));
        $this->msgform->add(new CheckBox('sendall'))->setVisible($this->user->rolename == 'admins');
    }

    public function onsubmit($sender) {

        $this->user->email = $sender->email->getText();
        $this->user->hidesidebar = $sender->hidesidebar->isChecked() ? 1 : 0;
        
        $this->user->defstore = $sender->defstore->getValue();
        $this->user->defmf = $sender->defmf->getValue();
        $this->user->pagesize = $sender->pagesize->getValue();


        if (!$this->isError()) {
            $this->user->save();
            $this->setSuccess('saved');
            System::setUser($this->user);
        }
    }

    //записать  пароль
    public function onsubmitpass($sender) {

        $pass = $sender->userpassword->getText();
        $confirm = $sender->confirmpassword->getText();

        if ($pass == '') {
            $this->setError('enterpassword');
        } else {
            if ($confirm == '') {
                $this->setError('confirmpass');

            } else {
                if ($confirm != $pass) {

                    $this->setError('invalidconfirm');
                }
            }
        }


        if (!$this->isError()) {
            $this->user->userpass = (\password_hash($pass, PASSWORD_DEFAULT));
            $this->user->save();
            $this->setSuccess('saved');
        }

        if ($this->user->userlogin != 'admin') {
            $admin = \App\Entity\User::getByLogin('admin');
            $n = new \App\Entity\Notify();
            $n->user_id = $admin->user_id;

            $n->dateshow = time();
            $n->message = H::l('passchanged', $this->user->username, $pass);


            $n->save();
        }


        $sender->userpassword->setText('');
        $sender->confirmpassword->setText('');
    }

    public function OnSend($sender) {
        $msg = trim($sender->msgtext->getText());

        if (strlen($msg) == 0) {
            return;
        }


        $all = $sender->sendall->isChecked();

        $list = array();
        if ($all) {
            foreach ($sender->users->getOptionList() as $id => $n) {
                $list[] = $id;
            }
        } else {
            $id = $sender->users->getValue();
            if ($id == 0) {

                $this->setError('noselreciever');
                return;
            }
            $list[] = $id;
        }


        foreach ($list as $id) {
            $n = new \App\Entity\Notify();
            $n->user_id = $id;
            $n->message = $msg;
            $n->sender_name = $this->user->username;
            $n->save();
        }
        $this->setSuccess('sent');
        $sender->clean();
    }


}
