#!/bin/bash




MTDINFO=/usr/sbin/mtdinfo

#get_mtdinfo()
{
    $MTDINFO -V >> /dev/null 2>&1 || { echo >&2 "Can't find mtdinfo command!"; exit 1;}

    MTD_DEVICE=`$MTDINFO | awk -F '[:]' '/Present\ MTD\ devices:/  {print $2}'`

    echo $MTD_DEVICE

    IFS_TMP=$IFS

    IFS=' ,'
    for i in $MTD_DEVICE
    do
        i_BLOCKSIZE=`$MTDINFO /dev/$i | awk -F '[:()]' '/Amount of eraseblocks: /{print$2}'`

        i_BLOCKNAME=`$MTDINFO /dev/$i | awk -F '[:()]' '/Name:/{print $2}'`
        echo "$i_BLOCKNAME: $i  $i_BLOCKSIZE "
    done

    IFS=$IFS_TMP
}





