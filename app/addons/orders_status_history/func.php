<?php
if (!defined('BOOTSTRAP')) { die('Access denied'); }

/**
 * Gets orders status history
 *
 * @param array  $params         Orders status history search params
 * @param int    $items_per_page Items per page
 *
 * @return array Orders status history list and Search params
 */
function fn_get_orders_status_history($params = array(), $items_per_page = 0)
{
    
    $default_params = array(
        'page' => 1,
        'items_per_page' => $items_per_page
    );

    $params = array_merge($default_params, $params);

    $fields = array(
        'h.*',
        'u.user_id',
        'u.lastname',
        'u.firstname',
        'u.company'
    );
    
    $sortings = array (
        'order_id' => 'h.order_id',
        'date' => 'h.timestamp',
        'status_from' => 'h.status_from',
        'status_to' => 'h.status_to',
        'user' => array('u.lastname', 'u.firstname'),
    );
    
    $join = db_quote("LEFT JOIN ?:users u ON u.user_id = h.user");

    $fields_str = implode(', ', $fields);
    $sorting_str = db_sort($params, $sortings, 'date', 'desc');
    
    $limit = '';
    if (!empty($params['items_per_page'])) {
        $params['total_items'] = db_get_field(
            "SELECT COUNT(*) FROM ?:orders_status_history h " . $join
        );
        $limit = db_paginate($params['page'], $params['items_per_page'], $params['total_items']);
    }

    $items = db_get_array(
        "SELECT " . $fields_str
        . " FROM ?:orders_status_history h "
        . $join
        . $sorting_str
        . $limit
    );

    return array($items, $params);
}

/**
 * Add orders status history logs to database
 *
 * @param int       $order_id      Order identificator
 * @param string    $status_to     Previous order status
 * @param string    $status_from   New order status
 * 
 * @return void
 */
function fn_orders_status_history_change_order_status_post($order_id, $status_to, $status_from) 
{
    $_data = array (
        'order_id' => $order_id,
        'status_from' => $status_from,
        'status_to' => $status_to,
        'user' => $_SESSION['auth']['user_id'],
        'timestamp' => TIME
    );
    $status_id = db_query("INSERT INTO ?:orders_status_history ?e", $_data);
}