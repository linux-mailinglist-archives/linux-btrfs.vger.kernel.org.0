Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5B486932
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbiAFRwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:52:07 -0500
Received: from smtp-33.italiaonline.it ([213.209.10.33]:60784 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241987AbiAFRwG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jan 2022 12:52:06 -0500
Received: from [192.168.1.27] ([84.220.25.125])
        by smtp-33.iol.local with ESMTPA
        id 5WvhnzM1906Tn5WvhnOhUl; Thu, 06 Jan 2022 18:52:04 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1641491524; bh=KOynYN3T2LZtIIfIzt1Rl91DWitNG5/sWvNqfVxtTpQ=;
        h=From;
        b=XH4E25k5wGzKdAZVefhI7xJdt/efvjDMUwXsnr9o5dhhOMHYJkCrjVOEBXhU3I3Y7
         LNQigXf3Kk1nlhjI3ROoRmYj2mTNrPGuAysrKcBS7ZPajOhN9aHXrjKun/gBj0yX0a
         jJR2y55yTqJ2LKF08gquCNLMTe9zsSCJ/O5hhw4YPJ4gZtAzIENIhs6YhtcuJvJ5ux
         iqNCNk5qmb4panwD6WEyPJIvKtp5Pcud0INQN8CUpJyI+v9M2p5DGyyv4/7UQdcM1J
         6BjO67bK0lkjXkUHd4rhxYWDc1u6E36IpCBfDGQrvRDCOPjxZb5p5rbDrPjVKTUsSD
         mQOkItJv/G+dA==
X-CNFS-Analysis: v=2.4 cv=YqbK+6UX c=1 sm=1 tr=0 ts=61d72c44 cx=a_exe
 a=hx1hjU+azB0cnDRRU3Lo+Q==:117 a=hx1hjU+azB0cnDRRU3Lo+Q==:17
 a=IkcTkHD0fZMA:10 a=5yVJNmfTEiUqZEVpMVkA:9 a=QEXdDO2ut3YA:10
Message-ID: <e4a31f0b-1866-cea7-2c99-580a2056b83a@inwind.it>
Date:   Thu, 6 Jan 2022 18:52:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH 0/2][V10] btrfs-progs: allocation_hint disk property
Content-Language: en-US
To:     Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>
References: <cover.1641491043.git.kreijack@inwind.it>
From:   Goffredo Baroncelli <kreijack@inwind.it>
In-Reply-To: <cover.1641491043.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCZc2Irvksb8Dlnf78mPI6qRfOFTZZ2MaLNSPLBd0qWw7R7gNNGwJFHXtoxluhBtK2AAWs6W4NyViiJoICD7L/5koekpBd4lKoGAd/Z50FZm8Ges571h
 vYZGZrL3Erub73syhQd2QtXvFyhiEMEYNMg4HubSl/K1siAGb8nhv2vbADlkU7muUfsJtm4f/EoYUkPlSg+gbBKOEpiuA4JMzggPCtrcc+DRdnonK1GV4eOx
 K4vKtwDjZGWmqkvw++u3AqPTtq8kZQQzt2Mkl2JzItkQFkO/T/ymQrr0Lx9s+HphkD747NGG1NWIloqEFYKF4usd7srRiurgtPIbxVxUNkyrMQUvMYIY4oh2
 3ffbljOx0YTllWyiImnh/IAbziddWqzSolhcJYUoBjkIav680zBGY3AYLtFWGyoZ9nvdc6op
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Below the script that I use to test this patch

----
#!/bin/bash

#size of disk, smaller -> faster
MAXSIZE=$((1*1024*1024*1024))
MNT=mnt
BTRFS=./btrfs-hint
UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f237c

cleanup_all() {
	while losetup | egrep loop; do
		umount $MNT
		losetup -D
		sleep 1s
	done
}

raise() {
	echo 1>&2 "$@"
	exit 100
}

xmount() {
	mount -o allocation_hint=1 "$1" "$2"
	#mount  "$1" "$2"
}

create_loops() {
	[ -n "$1" ] || {
		raise "Create_loops, missing an argument"
	}

	cleanup_all
	
	size=$MAXSIZE
	[ -n "$2" ] && size=$2
	ret=""
	for i in $(seq "$1"); do
		disk=disk-$i.img
		rm -rf $disk
		truncate -s $size $disk
		losetup /dev/loop$i $disk
		ret="$ret /dev/loop$i"
	done

	echo "$ret"
}


fill_1_file() {
	fn=$MNT/giant-file-$1
	if [ -n "$2" ]; then
		size=count=$(($2 / 16 / 1024 / 1024 ))
	else
		size=
	fi
	dd if=/dev/zero of=$fn bs=16M oflag=direct $size
	ls -l $fn | awk '{ print $5 }'
}

dump_bg_data() {
	$BTRFS fi us -b $MNT | awk '
		/^$/    { flag=0 }
		        { if(flag) print $0 }
		/^Data/ { flag=1 }
	'
}

dump_bg_metadata() {
	$BTRFS fi us -b $MNT | awk '
		/^$/        { flag=0 }
		            { if(flag) print $0 }
		/^Metadata/ { flag=1 }
	'
}

# check if a disk conrain data and/or metadata
check_data_bg() {
	res=$(dump_bg_data)
	while [ -n "$1" ]; do
		if ! echo $res | egrep -q $1 ; then
			btrfs fil us $MNT
			raise "Data BG should contains $1"
		fi
		shift
	done
}

check_data_not_bg() {
	res=$(dump_bg_data)
	while [ -n "$1" ]; do
		if echo $res | egrep -q $1 ; then
			btrfs fil us $MNT
			raise "Data BG should not contains $1"
		fi
		shift
	done
}

check_metadata_bg() {
	res=$(dump_bg_metadata)
	while [ -n "$1" ]; do
		if ! echo $res | egrep -q $1 ; then
			btrfs fil us $MNT
			raise "Metadata BG should contains $1"
		fi
		shift
	done
}

check_metadata_not_bg() {
	res=$(dump_bg_metadata)
	while [ -n "$1" ]; do
		if echo $res | egrep -q $1 ; then
			btrfs fil us $MNT
			raise "Metadata BG should not contains $1"
		fi
		shift
	done
}


test_default_raid1() {
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT
	
	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	check_data_bg $loop0 $loop1 $loop2 $loop3
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 || raise "Data BG should contains $loop0"
	#echo $res | egrep $loop1 || raise "Data BG should contains $loop1"
	#echo $res | egrep $loop2 || raise "Data BG should contains $loop2"
	#echo $res | egrep $loop3 || raise "Data BG should contains $loop3"

	size1=$(fill_1_file y )

	size=$(($size + $size1))

	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] || raise "File too small: check mnt/"
	[ $size -lt $(($MAXSIZE * 2 * 3 / 2 )) ] || raise "File too big: check mnt/"

	cleanup_all
}

test_default_single() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT
	
	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	check_data_bg $loop0 $loop1
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 || raise "Data BG should contains $loop0"
	#echo $res | egrep $loop1 || raise "Data BG should contains $loop1"

	size1=$(fill_1_file y )

	size=$(($size + $size1))

	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] || raise "File too small: check mnt/"
	[ $size -lt $(($MAXSIZE * 2 * 3 / 2 )) ] || raise "File too big: check mnt/"

	cleanup_all
}

test_single_preferred_data() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop1 allocation_hint DATA_PREFERRED
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	check_data_bg $loop1
	check_data_not_bg $loop0
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}

test_single_preferred_metadata_slow() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop1 allocation_hint DATA_PREFERRED
	
	$BTRFS balance start --full-balance $MNT

	fnsize=2048
	for i in $(seq $(( $MAXSIZE / $fnsize * 700 / 1000))); do
		dd if=/dev/zero of=$MNT/fn-$i bs=$fnsize count=1
	done

	#BTRFS fi us $MNT

	check_metadata_bg  $loop0
	check_metadata_not_bg  $loop1
	#res=$(dump_bg_metadata)
	#echo $res | egrep $loop0 &>/dev/null || raise "Metadata BG should contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null && raise "Metadata BG should not contains $loop3"

	cleanup_all
}



test_raid1_preferred_data() {
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop1 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop2 allocation_hint DATA_PREFERRED
	$BTRFS prop set $loop3 allocation_hint DATA_PREFERRED
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	check_data_bg  $loop2 $loop3
	check_data_not_bg $loop0 $loop1
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	#echo $res | egrep $loop2 &>/dev/null || raise "Data BG should contains $loop2"
	#echo $res | egrep $loop3 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}

test_raid1_preferred_metadata_slow() {
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop1 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop2 allocation_hint DATA_PREFERRED
	$BTRFS prop set $loop3 allocation_hint DATA_PREFERRED
	
	$BTRFS balance start --full-balance $MNT

	fnsize=2048
	for i in $(seq $(( $MAXSIZE / $fnsize * 700 / 1000))); do
		dd if=/dev/zero of=$MNT/fn-$i bs=$fnsize count=1
	done

	#BTRFS fi us $MNT

	check_metadata_bg $loop0 $loop1
	check_metadata_not_bg $loop2 $loop3
	#res=$(dump_bg_metadata)
	#echo $res | egrep $loop0 &>/dev/null || raise "Metadata BG should contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null || raise "Metadata BG should contains $loop1"
	#echo $res | egrep $loop2 &>/dev/null && raise "Metadata BG should not contains $loop2"
	#echo $res | egrep $loop3 &>/dev/null && raise "Metadata BG should not contains $loop3"

	cleanup_all
}

test_raid1_data_only() {
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop1 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop2 allocation_hint DATA_ONLY
	$BTRFS prop set $loop3 allocation_hint DATA_ONLY
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x  )

	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] && raise "File too big: check mnt/"
	[ $size -lt $(($MAXSIZE * 2 / 3 )) ] && raise "File too small: check mnt/"

	check_data_bg $loop2 $loop3
	check_data_not_bg $loop0 $loop1
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	#echo $res | egrep $loop2 &>/dev/null || raise "Data BG should contains $loop2"
	#echo $res | egrep $loop3 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}

test_single_data_only() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop1 allocation_hint DATA_ONLY
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x  )

	[ $size -gt $(($MAXSIZE * 2 * 2 / 3 )) ] && raise "File too big: check mnt/"
	[ $size -lt $(($MAXSIZE * 2 / 3 )) ] && raise "File too small: check mnt/"

	check_data_bg $loop1
	check_data_not_bg $loop0
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}


test_single_data_bouncing() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop1 allocation_hint DATA_ONLY
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x  $(($MAXSIZE * 2 / 4 )))

	[ $size -gt $(($MAXSIZE * 2 / 3 )) ] && raise "File too big: check mnt/"
	[ $size -lt $(($MAXSIZE * 1 / 3 )) ] && raise "File too small: check mnt/"

	check_data_bg $loop1
	check_data_not_bg $loop0
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop1"

	$BTRFS balance start --full-balance $MNT

	check_data_bg $loop1
	check_data_not_bg $loop0
	#res=$(dump_bg_data)
	#echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	#echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop1"


	$BTRFS prop set $loop1 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop0 allocation_hint DATA_ONLY

	$BTRFS balance start --full-balance $MNT

	check_data_bg $loop0
	check_data_not_bg $loop1
	#res=$(dump_bg_data)
	#echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	#echo $res | egrep $loop0 &>/dev/null || raise "Data BG should contains $loop0"
	cleanup_all
}

test_single_progressive_fill_data() {

	xsize=$MAXSIZE

	loops=$(create_loops 4 $xsize)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop1 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop2 allocation_hint DATA_PREFERRED
	$BTRFS prop set $loop3 allocation_hint DATA_ONLY
	$BTRFS balance start --full-balance $MNT	
	
	# fill $loop3
	
	size=$(fill_1_file x  $(( $xsize / 3 )))

	for i in 1 2 3; do
		check_data_bg $loop3
		check_data_not_bg $loop1 $loop2 $loop0
		$BTRFS balance start --full-balance $MNT
	done
		
	# fill $loop3 then $loop2

     	size=$(fill_1_file y  $(( $xsize )))

	for i in 1 2 3; do
		check_data_bg $loop3 $loop2
		check_data_not_bg $loop1 $loop0
		$BTRFS balance start --full-balance $MNT
	done
		
	# fill $loop3 then $loop2, then $loop1

     	size=$(fill_1_file z  $(( $xsize )))

	for i in 1 2 3; do
		check_data_bg $loop3 $loop2 $loop1
		check_data_not_bg $loop0
		$BTRFS balance start --full-balance $MNT
	done

	# fill the disk

     	size=$(fill_1_file w  )

	# when the disk is filled not balance is possible
	check_data_bg $loop3 $loop2 $loop1
	check_data_not_bg $loop0

	cleanup_all
}

test_raid1_progressive_fill_data() {

	xsize=$MAXSIZE

	loops=$(create_loops 5 $xsize)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	loop4=$(echo $loops | awk '{ print $5 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dRAID1 -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop1 allocation_hint METADATA_PREFERRED
	$BTRFS prop set $loop2 allocation_hint DATA_PREFERRED
	$BTRFS prop set $loop3 allocation_hint DATA_ONLY
	$BTRFS prop set $loop4 allocation_hint DATA_ONLY
	$BTRFS balance start --full-balance $MNT	
	
	# fill $loop3 $loop4
	
	size=$(fill_1_file x  $(( $xsize / 6 )))

	for i in 1 2 3; do
		check_data_bg $loop3 $loop4
		check_data_not_bg $loop1 $loop0 $loop2
		$BTRFS balance start --full-balance $MNT
	done
		
	# fill $loop3, $loop4 then $loop2, $loop1

     	size=$(fill_1_file y  $(( $xsize )))

	for i in 1 2 3; do
		check_data_bg $loop3 $loop2 $loop1 $loop4
		check_data_not_bg  $loop0
		$BTRFS balance start --full-balance $MNT
	done
		
	cleanup_all
}



SETV=""
SETX=""

while true; do
	if [ "$1" = "-x" ]; then
		SETX="set -x"
		shift
	elif [ "$1" = "-v" ]; then
		SETV="-v"
		shift
	elif [ "$1" = "--list" ]; then
		declare -F | awk '{ print $3 }' | egrep ^test_ | sort
		exit
     elif [ "$1" = "cleanup" ]; then
	    cleanup_all

	    exit
     elif [ "$1" = "makeraid1" ]; then
	    loops=$(create_loops 4)
	    loop0=$(echo $loops | awk '{ print $1 }')
	    mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	    xmount $loop0 $MNT

	    exit
	else
		break
	fi
done

cleanup_all &>/dev/null
cleanup_all &>/dev/null

ARG="$1"

$SETX

[ -z "$ARG" ] && ARG="."
declare -F | awk '{ print $3 }' | egrep ^test_ | sort |
	egrep $SETV "$ARG" | while read func; do

	echo -n "TEST '$func' "
	(
		$SETX
		$func >.out.log 2>.err.log
	)|| raise "Error !!!; read .out.log, .err.log"
	echo "OK"
done

----
-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
