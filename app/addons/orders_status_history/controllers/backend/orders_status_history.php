<?php

use Tygh\Registry;

if (!defined('BOOTSTRAP')) { die('Access denied'); }

if ($mode == 'manage') {
    
    $params = array_merge(
        ['items_per_page' => Registry::get('settings.Appearance.admin_elements_per_page')],
        $_REQUEST
    );
    
    list($order_status_logs, $params) = fn_get_orders_status_history($_REQUEST, DESCR_SL, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign(array(
        'order_status_logs'  => $order_status_logs,
        'search' => $params,
    ));
}