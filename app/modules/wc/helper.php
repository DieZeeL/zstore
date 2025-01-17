<?php

namespace App\Modules\WC;

use App\System;
use App\Helper as H;

/**
 * Вспомагательный  класс
 */
class Helper
{

    public static function getClient() {

        $modules = \App\System::getOptions("modules");

        $site = $modules['wcsite'];
        $keyc = $modules['wckeyc'];
        $keys = $modules['wckeys'];
        $api = $modules['wcapi'];
        //  $ssl = $modules['wcssl'];

        $ssl = \App\System::getSession()->wcssl == 1;

        $site = trim($site, '/') . '/';

        $woocommerce = new \Automattic\WooCommerce\Client(
            $site,
            $keyc,
            $keys,
            [
                'version'    => 'wc/' . $api,
                'verify_ssl' => $ssl
            ]
        );

        return $woocommerce;
    }

    
   public static function connect(){
  
       $modules = System::getOptions("modules");
 
        $site = $modules['wcsite'];
        $keyc = $modules['wckeyc'];
        $keys = $modules['wckeys'];
        $api = $modules['wcapi'];
        $site = trim($site, '/') . '/';
        $ssl = $modules['wcssl'];

        System::getSession()->wcssl = $ssl;

        $woocommerce = new \Automattic\WooCommerce\Client(
            $site,
            $keyc,
            $keys,
            [
                'version'    => 'wc/' . $api,
                'wp_api'     => true,
                'verify_ssl' => $ssl == 1
            ]
        );
        try {
            $woocommerce->get('');
        } catch(\Exception $ee) {
            System::setErrorMsg($ee->getMessage());
            return;
        }


        System::setSuccessMsg( H::l('connected'));
 
  
   }
}
