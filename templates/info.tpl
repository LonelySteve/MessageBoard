{* smarty *}
{include file="head.tpl"}
{if !isset($type)}
{$type="hint"}
{/if}
{if !isset($go_url)}
{$go_url="/"}
{/if}
{if !isset($time)}
{$time=5}
{/if}
<body>

<div class="container">
    <div class="panel main-panel">
        <div class="panel-body text-center">
            <div class="row">
                {if $type == "hint"}
                    <h1>提示</h1>
                {else}
                    <h1 class="text-danger">错误</h1>
                {/if}
            </div>
            <div class="row">
                <p>{$message}</p>
            </div>
            {if $go_url}
                <div class="row">
                    <span class="text-muted" id="time-hint">还有<mark id="countdown">{$time}</mark>秒将自动跳转</span>
                </div>
                <div class="row"> 
                    <span class="text-muted" id="manual-jump">如果未能成功跳转，请点击<a href='{$go_url}'>这里</a>手动跳转</span>
                </div>
            {/if}
        </div>
    </div>
</div>

{if $go_url}
    {include file="bootstrap.tpl"}
    <script>
        $(document).ready(
            function () {
                // 动态倒计时效果
                let remain_seconds = {$time};

                var int = setInterval(function () {
                    if(remain_seconds <= 0){
                        clearInterval(int);
                        window.location.href = "{$go_url}";
                        return;
                    }
                    remain_seconds--;
                    $("#countdown").text(remain_seconds);
                }, 1000);
            }
        );
    </script>
{/if}

</body>

</html>