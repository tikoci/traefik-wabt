/system script
add dont-require-permissions=yes name=traefik-proxy-cmds source=":global proxyid [/container/find tag~\"traefik\"]\r\
    \n:global proxylogs do={/log print  proplist=message as-value where topics~\"container\" [:if (\$message~\"(ERR|INF|DBG|WRN|traefik)\") do={:put [:pick \"\$message\\1B[0K\" 25 999]}] }\r\
    \n:global proxytail do={:global proxylogs; \$proxylogs; /log print follow-only proplist=message as-value where topics~\"container\" [:if (\$message~\"(ERR|INF|DBG|WRN|traefik)\") do={:put [:pick \"\$message\\1B[0K\" 25 999]}] \
    }\r\
    \n:global proxysh do={/container/shell [find tag~\"traefik\"]}\r\
    \n:global proxyscript do={:do { /system/script/edit [find name=\"traefik-proxy-cmds\"] source } on-error={}; /log debug \"edit traefik functions completed, re-loading...\"; /system/script/run [find name=\"traefik-proxy-cmds\"]\
    }\r\
    \n:global proxyrestart do={\r\
    \n    :global proxyid\r\
    \n    /container/stop \$proxyid\r\
    \n    :while ([/container/get \$proxyid status]!=\"stopped\") do={ /terminal/cuu; :put \"\\tstatus:\\t\$[/container/get \$proxyid status]\"; :delay 1s }\r\
    \n    /container/start \$proxyid\r\
    \n    :while ([/container/get \$proxyid status]!=\"running\") do={ /terminal/cuu; :put \"\\tstatus:\\t\$[/container/get \$proxyid status]\"; :delay 1s }\r\
    \n    :put \"\\tstatus:\\t\$[/container/get \$proxyid status]\"\r\
    \n}\r\
    \n:global proxyconf do={\r\
    \n    :global proxyid\r\
    \n    /file edit \"\$[:pick [/container/mount get [find name=\"traefik-proxy\"] src] 1 255]/routeros.yaml\" contents\r\
    \n}\r\
    \n\r\
    \n"

/system/scheduler/add name=traefik-proxy-cron start-time=startup on-event=traefik-proxy-cmds
