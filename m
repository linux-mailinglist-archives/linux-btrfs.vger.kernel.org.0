Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D98479469
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhLQSxP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:53:15 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31]:41770 "EHLO
        libero.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229830AbhLQSxP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:53:15 -0500
Received: from [192.168.1.27] ([78.12.25.242])
        by smtp-31.iol.local with ESMTPA
        id yILxm3MGZOKKIyILxmHxb4; Fri, 17 Dec 2021 19:53:13 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1639767193; bh=5Q9gO01n6mC7BKL0NcPhqTp5//VJP+nmcKEMUTVxUGk=;
        h=From;
        b=uccWskL5BIjuRC7jkjYhqLcz374FmU34YGQ9mu78tRkfecRSLzndpKIslUIWKICyJ
         cyX+FlTjb3Ew1EKuwBKAepQDBmVQddZUs0OaS7QHAQ4q1qsImO1zyR/jCTBu+zAfPX
         S2YsWpEDRYQY0qlry2y3rTfDO0P3+DnCMZEnHx9soX13792xJNQkf/GVoikfdgXfQK
         1cWJeOgdWB2hVibPKe9167UajQxK+6rfnbYoHJX/uZ+gRmGsafeIUvDIeBv9bJ/w/6
         pJD6U5SspnBAjyyUwuJcpL7mW0pHS6iQLAG2k0ukxjB1itkqqyX1tLegNb0qynx5yR
         EWvKISSjNF3lA==
X-CNFS-Analysis: v=2.4 cv=QuabYX+d c=1 sm=1 tr=0 ts=61bcdc99 cx=a_exe
 a=IXMPufAKhGEaWfwa3qtiyQ==:117 a=IXMPufAKhGEaWfwa3qtiyQ==:17
 a=IkcTkHD0fZMA:10 a=UoPfTRZ3Q3-To9W_8jwA:9 a=QEXdDO2ut3YA:10
Message-ID: <b2236689-fd1d-c5bb-0be9-4a62a308d938@libero.it>
Date:   Fri, 17 Dec 2021 19:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: kreijack@inwind.it
Subject: Script to test allocation_hint - [Was Re: [PATCH 0/2][V9]
 btrfs-progs: allocation_hint disk property]
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>
References: <cover.1639766708.git.kreijack@inwind.it>
From:   Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <cover.1639766708.git.kreijack@inwind.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMYJLaUrD6EtdtynT1n6KJ8pBGfTdqv58jdAAmt2yOpPSeY3fwCkjXmfir5DanqDbeR0qpOASuR25i0VlEf9pBdtyAMrn4ZIxLQtDf0nJgEh9HvJ21fD
 2PHz9wEKgKxj3BhgDd2+jo0XtR0cLgYDLIxRVb6/WO0ypqR4bFqKG4cyC7MHq5kcRuCa3O25LPELjfR7zqAuDIgLCiAzngjnmkZBC+ZFBuuvBDtdaUZh+z10
 xCwvn8UZNAj5jw+dQo/Ayj31SqsuQdfA+3D4GHXu/bZZrKSo5LDwmHD9pbwlhTV9+vdQ8gGYXux97upQcI7GtK2qcEhgumM9pNVskUpR56g=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/17/21 19:47, Goffredo Baroncelli wrote:
> From: Goffredo Baroncelli <kreijack@inwind.it>
> 
> This patches set is the userspace portion of the serie
> "[PATCH V9] btrfs: allocation_hint mode".
> 
> Look this patches set for further information.
> 
> G.Baroncelli
> 
> Goffredo Baroncelli (2):
>    btrfs-progs: new "allocation_hint" property.
>    Update man page for allocator_hint property.
> 
>   Documentation/btrfs-property.asciidoc |  17 +++
>   cmds/property.c                       | 204 ++++++++++++++++++++++++++
>   kernel-shared/ctree.h                 |  13 ++
>   3 files changed, 234 insertions(+)
> 


Below the script that I used to stress this patch. As is is not integrable in xfstest, but for now is better than nothing :-)

-----------
#!/bin/bash

#size of disk, smaller -> faster
MAXSIZE=$((1*1024*1024*1024))
MNT=mnt
BTRFS=./btrfs-hint
UUID=292afefb-6e8c-4fb3-9d12-8c4ecb1f237c

cleanup_all() {
	umount $MNT
	losetup -D
}

raise() {
	echo 1>&2 "$@"
	exit 100
}

xmount() {
	#mount -o allocation_hint=1 "$1" "$2"
	mount  "$1" "$2"
}

create_loops() {
	[ -n "$1" ] || {
		cleanup_all
		raise "Create_loops, missing an argument"
	}
	ret=""
	for i in $(seq "$1"); do
		disk=disk-$i.img
		rm -rf $disk
		truncate -s ${MAXSIZE} $disk
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

	res=$(dump_bg_data)
	echo $res | egrep $loop0 || raise "Data BG should contains $loop0"
	echo $res | egrep $loop1 || raise "Data BG should contains $loop1"
	echo $res | egrep $loop2 || raise "Data BG should contains $loop2"
	echo $res | egrep $loop3 || raise "Data BG should contains $loop3"

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

	res=$(dump_bg_data)
	echo $res | egrep $loop0 || raise "Data BG should contains $loop0"
	echo $res | egrep $loop1 || raise "Data BG should contains $loop1"

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

	$BTRFS prop set $loop0 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop1 allocation_hint PREFERRED_DATA
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	res=$(dump_bg_data)
	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}

test_single_preferred_metadata() {
	loops=$(create_loops 2)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -dsingle -msingle $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop1 allocation_hint PREFERRED_DATA
	
	$BTRFS balance start --full-balance $MNT

	fnsize=2048
	for i in $(seq $(( $MAXSIZE / $fnsize * 700 / 1000))); do
		dd if=/dev/zero of=$MNT/fn-$i bs=$fnsize count=1
	done

	#BTRFS fi us $MNT

	res=$(dump_bg_metadata)
	echo $res | egrep $loop0 &>/dev/null || raise "Metadata BG should contains $loop0"
	echo $res | egrep $loop1 &>/dev/null && raise "Metadata BG should contains $loop3"

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

	$BTRFS prop set $loop0 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop1 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop2 allocation_hint PREFERRED_DATA
	$BTRFS prop set $loop3 allocation_hint PREFERRED_DATA
	
	$BTRFS balance start --full-balance $MNT

	size=$(fill_1_file x $(($MAXSIZE / 2)) )

	res=$(dump_bg_data)
	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	echo $res | egrep $loop2 &>/dev/null || raise "Data BG should contains $loop2"
	echo $res | egrep $loop3 &>/dev/null || raise "Data BG should contains $loop3"

	cleanup_all
}

test_raid1_preferred_metadata() {
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	loop1=$(echo $loops | awk '{ print $2 }')
	loop2=$(echo $loops | awk '{ print $3 }')
	loop3=$(echo $loops | awk '{ print $4 }')
	$BTRFS dev scan -u
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT

	$BTRFS prop set $loop0 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop1 allocation_hint PREFERRED_METADATA
	$BTRFS prop set $loop2 allocation_hint PREFERRED_DATA
	$BTRFS prop set $loop3 allocation_hint PREFERRED_DATA
	
	$BTRFS balance start --full-balance $MNT

	fnsize=2048
	for i in $(seq $(( $MAXSIZE / $fnsize * 700 / 1000))); do
		dd if=/dev/zero of=$MNT/fn-$i bs=$fnsize count=1
	done

	#BTRFS fi us $MNT

	res=$(dump_bg_metadata)
	echo $res | egrep $loop0 &>/dev/null || raise "Metadata BG should contains $loop0"
	echo $res | egrep $loop1 &>/dev/null || raise "Metadata BG should contains $loop1"
	echo $res | egrep $loop2 &>/dev/null && raise "Metadata BG should contains $loop2"
	echo $res | egrep $loop3 &>/dev/null && raise "Metadata BG should contains $loop3"

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

	res=$(dump_bg_data)
	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	echo $res | egrep $loop2 &>/dev/null || raise "Data BG should contains $loop2"
	echo $res | egrep $loop3 &>/dev/null || raise "Data BG should contains $loop3"

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

	res=$(dump_bg_data)
	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop3"

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

	res=$(dump_bg_data)

	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop1"

	$BTRFS balance start --full-balance $MNT

	res=$(dump_bg_data)

	echo $res | egrep $loop0 &>/dev/null && raise "Data BG should not contains $loop0"
	echo $res | egrep $loop1 &>/dev/null || raise "Data BG should contains $loop1"


	$BTRFS prop set $loop1 allocation_hint METADATA_ONLY
	$BTRFS prop set $loop0 allocation_hint DATA_ONLY

	$BTRFS balance start --full-balance $MNT

	res=$(dump_bg_data)

	echo $res | egrep $loop1 &>/dev/null && raise "Data BG should not contains $loop1"
	echo $res | egrep $loop0 &>/dev/null || raise "Data BG should contains $loop0"
	cleanup_all
}








if [ "$1" = "cleanup" ]; then
	cleanup_all

	exit
elif [ "$1" = "makeraid1" ]; then
	loops=$(create_loops 4)
	loop0=$(echo $loops | awk '{ print $1 }')
	mkfs.btrfs -U $UUID -draid1 -mraid1 $loops
	xmount $loop0 $MNT

	exit
fi


cleanup_all &>/dev/null
cleanup_all &>/dev/null

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
	else
		break
	fi
done

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

-----------



-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
