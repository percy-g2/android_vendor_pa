#!/bin/bash

# Version 2.0.4, Adapted for AOSPAL.

if [ "pa$1" == "pa" ]
then
   echo "Usage: './mk [Device] {Variable}'"
   echo "   Device - your device name"
   echo "   Variable - functions"
   echo "      fix   :start build without any cleanning for fix build"
   echo "      clean :run 'make installclean' before build"
   echo "      sync  :run 'repo sync' before build"
   echo " "
   exit 0
fi

# We don't allow scrollback buffer
echo -e '\0033\0143'
clear

# Get current path
DIR="$(cd `dirname $0`; pwd)"
OUT="$(readlink $DIR/out)"
[ -z "${OUT}" ] && OUT="${DIR}/out"

# Prepare output customization commands
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
blu=$(tput setaf 4)             #  blue
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

# Local defaults, can be overriden by environment
: ${PREFS_FROM_SOURCE:="false"}
: ${THREADS:="$(cat /proc/cpuinfo | grep "^processor" | wc -l)"}

# If there is more than one jdk installed, use latest 6.x
if [ "`update-alternatives --list javac | wc -l`" -gt 1 ]; then
        JDK6=$(dirname `update-alternatives --list javac | grep "\-6\-"` | tail -n1)
        JRE6=$(dirname ${JDK6}/../jre/bin/java)
        export PATH=${JDK6}:${JRE6}:$PATH
fi
JVER=$(javac -version  2>&1 | head -n1 | cut -f2 -d' ')

# Import command line parameters
THREADS="4"
DEVICE="$1"

# Get build version
MAJOR=$(cat $DIR/vendor/pa/vendor.mk | grep 'ROM_VERSION_MAJOR := *' | sed  's/ROM_VERSION_MAJOR := //g')
MINOR=$(cat $DIR/vendor/pa/vendor.mk | grep 'ROM_VERSION_MINOR := *' | sed  's/ROM_VERSION_MINOR := //g')
MAINTENANCE=$(cat $DIR/vendor/pa/vendor.mk | grep 'ROM_VERSION_MAINTENANCE := *' | sed  's/ROM_VERSION_MAINTENANCE := //g')

VERSION=$MAJOR.$MINOR$MAINTENANCE


# Get start time
res1=$(date +%s.%N)

echo -e "${cya}Building ${bldcya}AOSPA $VERSION for $DEVICE ${txtrst}";
echo -e "${bldgrn}Start time: $(date) ${txtrst}"

if [ ! -r "${DIR}/out/versions_checked.mk" ] && [ -n "$(java -version 2>&1 | grep -i openjdk)" ]; then
        echo -e "${bldcya}Your java version still not checked and is candidate to fail, masquerading.${txtrst}"
        JAVA_VERSION="java_version=${JVER}"
fi

makeme=0
if [ -n "${INTERACTIVE}" ]; then
        echo -e "${bldblu}Dropping to interactive shell${txtrst}"
        echo -en "${bldblu}Remeber to lunch you device:"
        if [ "${VENDOR}" == "pa" ]; then
                echo -e "[${bldgrn}lunch pa_$DEVICE-userdebug${bldblu}]${txtrst}"
        else
                echo -e "[${bldgrn}lunch full_$DEVICE-userdebug${bldblu}]${txtrst}"
        fi
        bash --init-file build/envsetup.sh -i
else
        # Setup environment
        echo -e ""
        echo -e "${bldblu}Setting up environment${txtrst}"
        export USE_CCACHE=1
        export CCACHE_DIR=~/.ccache
        # set ccache due to your disk space,set it at your own risk
        prebuilts/misc/linux-x86/ccache/ccache -M 15G
        . build/envsetup.sh
        echo -e ""

        # lunch/brunch device
        echo -e "${bldblu}Lunching device [$DEVICE] ${cya}(Includes dependencies sync)${txtrst}"
        export PREFS_FROM_SOURCE
        lunch "pa_$DEVICE-userdebug";
        
        makeme=1
fi

# Decide what command to execute
fix_count=0
for var in $* ; do
if [ "$var" == "sync" ]
then
   echo -e "${bldblu}Fetching latest sources ${txtrst}"
   repo sync
   echo -e ""
elif [ "$var" == "clean" ]
then
   echo -e "${bldblu}Clearing previous build info ${txtrst}"
   mka installclean
elif [ "$var" == "allclean" ]
then
   echo -e "${bldblu}Clearing build path ${txtrst}"
   mka clean
elif [ "$var" == "fix" ]
then
   echo -e "skip for remove build.prop"
   fix_count=1
else
   echo -e "running..."
fi
done

if [ "$fix_count" == "0" ]
then
   echo -e "removing build.prop..."
   rm $OUT/system/build.prop
fi

echo -e ""

if [ "$makeme" == "1" ]
then
        echo -e "${bldblu}Starting compilation${txtrst}"
        mka bacon
fi
echo -e ""

# Get elapsed time
res2=$(date +%s.%N)
echo -e "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds)${txtrst}"
