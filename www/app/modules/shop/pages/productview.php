<?php

namespace App\Modules\Shop\Pages;

use App\Application as App;
use App\Modules\Shop\Entity\Product;
use App\Modules\Shop\Entity\ProductComment;
use App\Modules\Shop\Helper;
use App\System;
use Zippy\Binding\PropertyBinding;
use Zippy\Html\DataList\ArrayDataSource;
use Zippy\Html\DataList\DataView;
use Zippy\Html\Form\TextArea;
use Zippy\Html\Form\TextInput;
use Zippy\Html\Label;
use Zippy\Html\Link\ClickLink;
use Zippy\Html\Link\RedirectLink;

//детализация  по товару, отзывы
class ProductView extends Base
{

    public $msg, $attrlist, $clist;
    protected               $product_id, $gotocomment;

    public function __construct($product_id = 0) {
        parent::__construct();

        $this->product_id = $product_id;
        $product = Product::load($product_id);
        if ($product == null) {
            App::Redirect404();
        }
        $this->add(new Label("breadcrumb", Helper::getBreadScrumbs($product->cat_id), true));

        $this->_title = $product->itemname;
        $this->_description = $product->getDesc();
        //  $this->_keywords = $product->description;
        $this->add(new \Zippy\Html\Link\BookmarkableLink('product_image'))->setValue("/loadshopimage.php?id={$product->image_id}&t=t");
        $this->product_image->setAttribute('href', "/loadshopimage.php?id={$product->image_id}");

        $this->add(new Label('productname', $product->itemname));
        $this->add(new Label('onstore'));
        $this->add(new \Zippy\Html\Label('manufacturername', $product->manufacturer))->SetVisible(strlen($product->manufacturer) > 0);

        $this->add(new Label("topsold"))->setVisible($product->topsold == 1);
        $this->add(new Label("novelty"))->setVisible($product->novelty == 1);

        $this->add(new Label('price', $product->price));

        $this->add(new Label('description', $product->getDesc()));
        $this->add(new Label('fulldescription', $product->getDesc()));
        $this->add(new Label('arrowup'))->setVisible($product->chprice == 'up');
        $this->add(new Label('arrowdown'))->setVisible($product->chprice == 'down');
        $this->add(new TextInput('rated'))->setText($product->rating);
        $this->add(new Label('comments', "Отзывов({$product->comments})"));

        $list = Helper::getAttributeValuesByProduct($product);
        $this->add(new \Zippy\Html\DataList\DataView('attributelist', new \Zippy\Html\DataList\ArrayDataSource($list), $this, 'OnAddAttributeRow'))->Reload();
        $this->add(new ClickLink('buy', $this, 'OnBuy'));
        $this->add(new ClickLink('addtocompare', $this, 'OnAddCompare'));
        $this->add(new RedirectLink('compare', "\\App\\Modules\\Shop\\Pages\\Compare"))->setVisible(false);

        $form = $this->add(new \Zippy\Html\Form\Form('formcomment'));
        $form->onSubmit($this, 'OnComment');
        $form->add(new TextInput('nick'));
        $form->add(new TextInput('rating'));
        $form->add(new TextArea('comment'));
        $this->clist = ProductComment::findByProduct($product->product_id);
        $this->add(new \Zippy\Html\DataList\DataView('commentlist', new \Zippy\Html\DataList\ArrayDataSource(new PropertyBinding($this, 'clist')), $this, 'OnAddCommentRow'));
        $this->commentlist->setPageSize(5);
        $this->add(new \Zippy\Html\DataList\Pager("pag", $this->commentlist));
        $this->commentlist->Reload();

        if ($product->deleted == 1) {
            $this->onstore = \App\Helper::l('cancelsell');
            $this->buy->setVisible(false);
        } else {
            $op = \App\System::getOptions("shop");
            if ($product->getQuantity($op['defstore']) > 0) {
                $this->onstore->setText(\App\Helper::l('isonstore'));
                $this->buy->setValue(\App\Helper::l('tobay'));
            } else {
                $this->onstore->setText(\App\Helper::l('fororder'));
                $this->buy->setValue(\App\Helper::l('toorder'));
            }
        }

        $imglist = array();

        foreach ($product->getImages(true) as $id) {
            $imglist[] = \App\Entity\Image::load($id);
        }
        $this->add(new DataView('imagelist', new ArrayDataSource($imglist), $this, 'imglistOnRow'))->Reload();
        $this->_tvars['islistimage'] = count($imglist) > 1;

        $recently = \App\Session::getSession()->recently;
        if (!is_array($recently)) {
            $recently = array();
        }
        $recently[$product->product_id] = $product->product_id;
        \App\Session::getSession()->recently = $recently;
    }

    public function OnAddAttributeRow(\Zippy\Html\DataList\DataRow $datarow) {
        $item = $datarow->getDataItem();
        $datarow->add(new Label("attrname", $item->attributename));
        $meashure = "";
        $value = $item->attributevalue;
        if ($item->attributetype == 2) {
            $meashure = $item->valueslist;
        }
        if ($item->attributetype == 1) {
            $value = $item->attributevalue == 1 ? "Есть" : "Нет";
        }
        $value = $value . $meashure;
        if ($item->attributevalue == '') {
            $value = "Н/Д";
        }
        $datarow->add(new Label("attrvalue", $value));
    }

    //добавление в корзину
    public function OnBuy($sender) {
        $product = Product::load($this->product_id);
        $product->quantity = 1;
        \App\Modules\Shop\Basket::getBasket()->addProduct($product);
        $this->setSuccess("addedtocart");
        //$this->resetURL();
        App::RedirectURI('/pcat/' . $product->group_id);
    }

    //добавить к форме сравнения
    public function OnAddCompare($sender) {
        $product = Product::load($this->product_id);
        $comparelist = \App\Modules\Shop\CompareList::getCompareList();
        if (false == $comparelist->addProduct($product)) {

            $this->setWarn('onlythesamecategory');
            return;
        }
        // App::RedirectURI('/pcat/'.$product->group_id)  ;
    }

    //добавать комментарий 
    public function OnComment($sender) {


        $comment = new \App\Modules\Shop\Entity\ProductComment();
        $comment->product_id = $this->product_id;
        $comment->author = $this->formcomment->nick->getText();
        $comment->comment = $this->formcomment->comment->getText();
        $comment->rating = $this->formcomment->rating->getText();
        $comment->created = time();
        $comment->Save();
        $this->formcomment->nick->setText('');
        $this->formcomment->comment->setText('');
        $this->formcomment->rating->setText('0');
        $this->clist = ProductComment::findByProduct($this->product_id);
        $this->commentlist->Reload();


        $this->gotocomment = true;
        $this->updateComments();
    }

    protected function beforeRender() {
        parent::beforeRender();

        if ($this->gotocomment == true) {
            App::addJavaScript("openComments();", true);
            $this->gotocomment = false;
        }
        if (\App\Modules\Shop\CompareList::getCompareList()->hasProsuct($this->product_id)) {
            $this->compare->setVisible(true);
            $this->addtocompare->setVisible(false);
        } else {
            $this->compare->setVisible(false);
            $this->addtocompare->setVisible(true);
        }
    }

    public function OnAddCommentRow(\Zippy\Html\DataList\DataRow $datarow) {
        $item = $datarow->getDataItem();
        if ($item->moderated == 1) {
            $item->comment = "Отменено  модератором";
        }
        $datarow->add(new Label("nick", $item->author));
        $datarow->add(new Label("comment", $item->comment));
        $datarow->add(new Label("created", \App\Helper::fdt($item->created)));
        $datarow->add(new TextInput("rate"))->setText($item->rating);
        $datarow->add(new ClickLink('deletecomment', $this, 'OnDeleteComment'))->SetVisible(System::getUser()->userlogin == 'admin' && $item->moderated != 1);
    }

    //удалить коментарий
    public function OnDeleteComment($sender) {
        $comment = $sender->owner->getDataItem();
        $comment->moderated = 1;
        $comment->rating = 0;
        $comment->Save();
        // App::$app->getResponse()->addJavaScript("window.location='#{$comment->comment_id}'", true);
        //\Application::getApplication()->Redirect('\\ZippyCMS\\Modules\\Articles\\Pages\\ArticleList');
        $this->clist = ProductComment::findByProduct($this->product_id);
        $this->commentlist->Reload();
        $this->updateComments();
    }

    private function updateComments() {
        $conn = \ZDB\DB::getConnect();

        $product = Product::load($this->product_id);

        $product->rating = $conn->GetOne("select sum(rating)/count(*) from `shop_prod_comments`where  product_id ={$this->product_id} and moderated <> 1 and  rating >0");
        $product->rating = round($product->rating);
        $product->comments = $conn->GetOne("select count(*) from `shop_prod_comments`where  product_id ={$this->product_id} and moderated <> 1");
        $product->save();
        $this->rated->setText($product->rating);
        $this->comments->setText("Отзывов({$product->comments})");
    }

    public function imglistOnRow($row) {
        $image = $row->getDataItem();

        $row->add(new \Zippy\Html\Link\BookmarkableLink('product_thumb'))->setValue("/loadshopimage.php?id={$image->image_id}&t=t");
        $row->product_thumb->setAttribute('href', "/loadshopimage.php?id={$image->image_id}");
    }

}
