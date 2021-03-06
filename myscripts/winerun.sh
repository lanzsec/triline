#!/bin/sh

# manager wine's programs, like qq, IE, etc...
# for wine programs which installed by winetricks-zh/winetricks.
# usage:
#     winerun.sh <clean|verbname>
#     verbnames:qqintl,TM2013P2,qqlight,qq...
#     more verb names: $HOME/opensource/winetricks-zh/verb/

### env
export WINEARCH=win32
export WINEPREFIX=$HOME/.wine32

### confgs
WTPREFIX=$HOME/.local/share/wineprefixes

### cmd arguments
act=$1

### simple wrapper functions
function cleanup_wine_programs()
{
    ### sufix .exe process
    ### like qq, meitu, etc...
    true

    pids=$(ps axu|grep "\.exe"|grep "C:"|awk '{print $2}')
    echo $pids
    if [ x"$pids" != x"" ] ; then
        for pid in $pids ; do
            true;
            kill -9 $pid;
            kill -9 $pid;
            kill -9 $pid;
        done
    fi

    pids=$(ps aux|grep "defunct"|grep -v grep|awk '{print $2}')
    echo $pids
    if [ x"$pids" != x"" ] ; then
        for pid in $pids ; do
            true;
            kill -9 $pid;
            kill -9 $pid;
            kill -9 $pid;
        done
    fi
}

function cleanup_wine_process()
{
    set -x;
    cleanup_wine_programs;

    ########
    killall -9 TXPlatform.exe
    killall -9 QQ.exe
    killall -9 MLogin

    killall -9 winedevice.exe
    killall -9 services.exe
    killall -9 msiexec.exe
    killall -9 plugplay.exe
    killall -9 explorer.exe
    killall -9 rpcss.exe
    killall rundll32.exe
    killall RunDll32.exe

    killall -9 wineserver
    set +x;
}


function runverb_qqintl()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/qqintl
    wine "C:/Program Files/Tencent/QQIntl/Bin/QQ.exe"
}

function runverb_TM2013P2()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/TM2013P2
    wine "C:/Program Files/Tencent/TM/Bin/TM.exe"
}

function runverb_qqlight()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/qqlight
    wine "C:/Program Files/Tencent/QQ/Bin/QQ.exe"
}

function runverb_qq()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/qq
    wine "C:/Program Files/Tencent/QQ/Bin/QQ.exe"
}

function runclean_qq()
{
    killall -9 TXPlatform.exe
    killall -9 QQ.exe
    killall -9 QQApp.exe
    killall -9 QQProtect.exe
    killall -9 Tencentdl.exe
    killall -9 bugreport
}

function runverb_weixin()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/qq
    wine "C:/Program Files/Tencent/WeChat/WeChat.exe"
}

function runverb_meitu()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/meitu
    wine "C:/Program Files/Meitu/XiuXiu/XiuXiu.exe"
}

function runverb_edraw()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/meitu
    wine "C:/abc/edraw.exe"
}

function runverb_THS()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/THS
    wine "C:/Program Files/Meitu/XiuXiu/XiuXiu.exe"
}

function runverb_QQGame()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/QQGame
    wine "C:/Program Files/Tencent/QQGame/QQGame.exe"
}

function runverb_evernote()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/evernote
    wine "C:/Program Files/Evernote/Evernote/Evernote.exe"
}

function runclean_evernote()
{
    killall -9 EvernoteClipper.exe
    killall -9 Evernote.exe
    killall -9 EvernoteTray.exe
}

function runverb_ynote()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/ynote
    wine "C:/Program Files/Youdao/YoudaoNote/YoudaoNote.exe"
}

function runverb_wechat()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/wechat
    wine "C:/Program Files/Tencent/WeChat/WeChat.exe"
}

function runclean_wechat()
{
    killall -9 WeChat.exe
}

function runverb_youku()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/youku
    wine "C:/Program Files/YouKu/YoukuClient/YoukuDesktop.exe"
}

function runclean_youku()
{
    killall -9 YoukuDesktop.exe
}

function runverb_iqiyi()
{
    export WINEPREFIX=$HOME/.local/share/wineprefixes/iqiyi
    wine "C:/Program Files/IQIYI Video/PStyle/QiyiClient.exe"
}

function runclean_iqiyi()
{
    killall -9 QyClient.exe
    killall -9 QyService.exe
    killall -9 QyPlayer.exe
    killall -9 QyFragment.exe
    killall -9 QyKernel.exe
    killall -9 mDNSResponder.exe
}

function runverb_list()
{
    lst="qqintl TM2013P2 qqlight qq weixin meitu edraw THS QQGame evernote ynote"
    nlst=$(echo $lst|wc -w)
    echo "wine verb list: ($nlst)"
    idx=0
    for verb in $lst; do
        idx=$(expr $idx + 1)
        echo -e "\t${idx}.\t${verb}"
    done
}

### main
if [ x"$act" == x"" ] ; then
    echo "Need least one argument";
elif [ x"$act" == x"clean" ] ; then
    verb=$2
    case $verb in
        'qq')
            runclean_qq;
        ;;
        'evernote')
            runclean_evernote;
        ;;
        'wechat')
            runclean_wechat;
        ;;
        'iqiyi')
            runclean_iqiyi;
            ;;
        *)
            read -p "Are you sure clean all verbs? (Y/N): " agree
            if [ x"$agree" == x"Y" ] || [ x"$agree" == x'y' ] ; then
                cleanup_wine_process;
            else
                echo "Usage:"
                echo -e "\twinerun clean [verb]"
            fi
        ;;
    esac

else
    fn="runverb_${act}";
    echo "runing ${fn}...";

    # TODO use case expression
    if [ x"$act" == x"list" ] ; then
        runverb_list;
    elif [ x"$act" == x"qqintl" ] ; then
        runverb_qqintl;
    elif [ x"$act" == x"TM2013P2" ] ; then
        runverb_TM2013P2;
    elif [ x"$act" == x"qqlight" ] ; then
        runverb_qqlight;
    elif [ x"$act" == x"qq" ] ; then
        runverb_qq;
    elif [ x"$act" == x"weixin" ] ; then
        runverb_weixin;
    elif [ x"$act" == x"meitu" ] ; then
        runverb_meitu;
    elif [ x"$act" == x"edraw" ] ; then
        runverb_edraw;
    elif [ x"$act" == x"THS" ] ; then
        runverb_THS;
    elif [ x"$act" == x"QQGame" ] ; then
        runverb_QQGame;
    elif [ x"$act" == x"evernote" ] ; then
        runverb_evernote;
    elif [ x"$act" == x"ynote" ] ; then
        runverb_ynote;
    elif [ x"$act" == x"wechat" ] ; then
        runverb_wechat;
    elif [ x"$act" == x"youku" ] ; then
        runverb_youku;
    elif [ x"$act" == x"iqiyi" ] ; then
        runverb_iqiyi;
    else
        echo "Not impled: $act";
    fi
fi

# exit;




