Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8326A36A5BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhDYIeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 04:34:13 -0400
Received: from out20-63.mail.aliyun.com ([115.124.20.63]:35833 "EHLO
        out20-63.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYIeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 04:34:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436375|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0517042-0.000869976-0.947426;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.K3mXRVc_1619339611;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K3mXRVc_1619339611)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 25 Apr 2021 16:33:31 +0800
Date:   Sun, 25 Apr 2021 16:33:31 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 4/4] btrfs: add test for zone auto reclaim
Message-ID: <YIUpW1x9TxfZtY+G@desktop>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
 <20210423112634.6067-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423112634.6067-5-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 23, 2021 at 08:26:34PM +0900, Johannes Thumshirn wrote:
> Add a test for the patch titled "btrfs: zoned: automatically reclaim
> zones".
> 
> This test creates a two file on a newly created FS in a way that when we
> delete the first one, an auto reclaim process will be triggered by the FS.
> 
> After the reclaim process, it verifies that the data was moved to another
> zone and old zone was successfully reset.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Test looks fine to me from fstests' perspective, some minor issues
inline. But I'm not familiar with zoned btrfs, I'd like btrfs folks help
review the patch as well.

> ---
>  common/config       |   1 +
>  tests/btrfs/236     | 102 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/236.out |   2 +
>  tests/btrfs/group   |   1 +
>  4 files changed, 106 insertions(+)
>  create mode 100755 tests/btrfs/236
>  create mode 100644 tests/btrfs/236.out
> 
> diff --git a/common/config b/common/config
> index a47e462c7792..1a26934985dd 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,6 +226,7 @@ export FSVERITY_PROG="$(type -P fsverity)"
>  export OPENSSL_PROG="$(type -P openssl)"
>  export ACCTON_PROG="$(type -P accton)"
>  export E2IMAGE_PROG="$(type -P e2image)"
> +export BLKZONE_PROG="$(type -P blkzone)"
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/tests/btrfs/236 b/tests/btrfs/236
> new file mode 100755
> index 000000000000..18964699f68e
> --- /dev/null
> +++ b/tests/btrfs/236
> @@ -0,0 +1,102 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 236
> +#
> +# Test that zone autoreclaim works as expected, that is: if the dirty
> +# threashold is exceeded the data gets relocated to new block group and the
> +# old block group gets deleted. On block group deletion, the underlying device
> +# zone also needs to be reset.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_command "$BLKZONE_PROG" blkzone
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +get_data_bg()
> +{
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
> +		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
> +		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
> +}
> +
> +zonesize=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/chunk_sectors)
> +zonesize=$((zonesize << 9))
> +
> +_scratch_mkfs >/dev/null 2>&1
> +_scratch_mount -o commit=5

Any reason to use "-o commit=5" mount option? A comment would be good.

> +
> +uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
> +reclaim_threshold=75
> +echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> +fill_percent=$((reclaim_threshold + 2))
> +rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
> +fill_size=$((zonesize * fill_percent / 100))
> +rest=$((zonesize * rest_percent / 100))
> +
> +# step 1, fill FS over $fillsize
> +$XFS_IO_PROG -fdc "pwrite -W 0 $fill_size" $SCRATCH_MNT/$seq.test1 >> $seqres.full
> +$XFS_IO_PROG -fdc "pwrite -W 0 $rest" $SCRATCH_MNT/$seq.test2 >> $seqres.full
> +sleep 5
> +
> +zones_before=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
> +echo "Before reclaim: $zones_before zones open" >> $seqres.full
> +old_data_zone=$(get_data_bg)
> +old_data_zone=$((old_data_zone >> 9))
> +printf "Old data zone 0x%x\n" $old_data_zone >> $seqres.full
> +
> +# step 2, delete the 1st $fill_size sized file to trigger reclaim
> +rm $SCRATCH_MNT/$seq.test1
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +sleep 10

Why are above two sleeps needed? They make test time longer. Remove them
if they're not required, otherwise adding some comments would be good.

> +
> +# check that we don't have more zones open than before
> +zones_after=$($BLKZONE_PROG report $SCRATCH_DEV | grep -v -e em -e nw | wc -l)
> +echo "After reclaim: $zones_after zones open" >> $seqres.full
> +
> +# Check that old data zone was reset
> +old_wptr=$($BLKZONE_PROG report -o $old_data_zone -c 1 $SCRATCH_DEV |\
> +	grep -Eo "wptr 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> +if [ "$old_wptr" != "0x000000" ]; then
> +	_fail "Old wptr still at $old_wptr"
> +fi
> +
> +new_data_zone=$(get_data_bg)
> +new_data_zone=$((new_data_zone >> 9))
> +printf "New data zone 0x%x\n" $new_data_zone >> $seqres.full
> +
> +# Check that data was really relocated to a different zone
> +if [ $old_data_zone -eq $new_data_zone ]; then
> +	_fail "New zone same as old zone"
> +fi
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
> new file mode 100644
> index 000000000000..b6b6e0cad9a7
> --- /dev/null
> +++ b/tests/btrfs/236.out
> @@ -0,0 +1,2 @@
> +QA output created by 236
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 331dd432fac3..62c9c761e974 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -238,3 +238,4 @@
>  233 auto quick subvolume
>  234 auto quick compress rw
>  235 auto quick send
> +236 auto quick balance

I don't see a balance operation, does it fit into balance group?

Thanks,
Eryu

P.S. I've applied the first patch in this patchset.
> -- 
> 2.30.0
