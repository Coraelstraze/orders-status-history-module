{capture name="mainbox"}

{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id=$smarty.request.content_id}

{$c_url=$config.current_url|fn_query_remove:"sort_by":"sort_order"}
{$c_icon="<i class=\"icon-`$search.sort_order_rev`\"></i>"}
{$rev=$smarty.request.content_id|default:"pagination_contents"}
{$page_title=__("orders_status_history")}
            
{if $order_status_logs}
    {capture name="orders_status_history_table"}
        <div class="table-responsive-wrapper">
            <table width="100%" class="table table-middle table--relative table-responsive">
            <tr>
                <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=order_id&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("id")}{if $search.sort_by == "order_id"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status_from&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status_from")}{if $search.sort_by == "status_from"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=status_to&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("status_to")}{if $search.sort_by == "status_to"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
                <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=user&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("user")}{if $search.sort_by == "user"}{$c_icon nofilter}{/if}</a></th>
                <th width="20%"><a class="cm-ajax" href="{"`$c_url`&sort_by=date&sort_order=`$search.sort_order_rev`"|fn_url}" data-ca-target-id={$rev}>{__("date")}{if $search.sort_by == "date"}{$c_icon nofilter}{else}{$c_dummy nofilter}{/if}</a></th>
            </tr>
            </thead>
            {foreach from=$order_status_logs item="h"}
            <tr class="cm-longtap-target">
                <td width="20%" data-th="{__("id")}">#{$h.order_id}</td>
                <td width="20%" data-th="{__("status_from")}">
                    {include file="common/status.tpl"
                            status=$h.status_from
                            display="view"
                    }
                </td>
                <td width="20%" data-th="{__("status_to")}">
                    {include file="common/status.tpl"
                            status=$h.status_to
                            display="view"
                    }
                </td>
                <td width="20%" data-th="{__("user")}">
                    {if $h.user_id}<a href="{"profiles.update?user_id=`$h.user_id`"|fn_url}">{/if}{$h.lastname} {$h.firstname}{if $h.user_id}</a>{/if}
                    {if $h.company}<p class="muted">{$h.company}</p>{/if}
                </td>
                <td width="20%" class="nowrap" data-th="{__("date")}">{$h.timestamp|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}</td>
            </tr>
            {/foreach}
            </table>
        </div>
    {/capture}

    {include file="common/context_menu_wrapper.tpl"
        object="orders_status_history"
        items=$smarty.capture.orders_status_history_table
    }
{else}
    <p class="no-items">{__("no_data")}</p>
{/if}

{include file="common/pagination.tpl" div_id=$smarty.request.content_id}

{/capture}

{include file="common/mainbox.tpl"
    title=$page_title
    content=$smarty.capture.mainbox
    content_id="orders_status_history"
}
