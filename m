Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258044F7C1
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhKNMJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Nov 2021 07:09:30 -0500
Received: from out20-39.mail.aliyun.com ([115.124.20.39]:40734 "EHLO
        out20-39.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhKNMJ2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Nov 2021 07:09:28 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436291|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00747111-0.0124616-0.980067;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.LseRfn2_1636891592;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.LseRfn2_1636891592)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sun, 14 Nov 2021 20:06:32 +0800
Date:   Sun, 14 Nov 2021 20:06:32 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: Test proper interaction between skip_balance
 and paused balance
Message-ID: <YZD7yEhwsKRBm0IE@desktop>
References: <20211108142901.1003352-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108142901.1003352-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:29:01PM +0200, Nikolay Borisov wrote:
> Ensure a device can be added to a filesystem that has a paused balance
> operation and has been mounted with the 'skip_balance' mount option
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> V3:
>  * Added swapon to the list of exclusive ops
>  * Use _spare_dev_get
>  * Test balance resume via progs while balance is paused. I hit an assertion failure
>  outside of xfstest while doing this sequence of steps so let's add it to
>  ensure that's not regressed.
> 
>  tests/btrfs/049     | 92 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/049.out |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100755 tests/btrfs/049
> 
> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> new file mode 100755
> index 000000000000..d01ef05e5ead
> --- /dev/null
> +++ b/tests/btrfs/049
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 049
> +#
> +# Ensure that it's possible to add a device when we have a paused balance
> +# and the filesystem is mounted with skip_balance. The issue is fixed by a patch
> +# titled "btrfs: allow device add if balance is paused"

After looking at the kernel patch, it looks more like a bug fix not a
new feature, as adding device to a ENOSPC-but-paused balance seems to be
the only reasonable way to finish the balance. If that's the case,
there's no problem add this case that will fail on old kernels.

> +#
> +. ./common/preamble
> +_begin_fstest quick balance auto
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch_swapfile
> +_require_scratch_dev_pool 3
> +
> +_scratch_dev_pool_get 2
> +_spare_dev_get
> +
> +swapfile="$SCRATCH_MNT/swap"
> +_scratch_pool_mkfs >/dev/null
> +_scratch_mount
> +_format_swapfile "$swapfile" $(($(get_page_size) * 10))
> +
> +check_exclusive_ops()
> +{
> +	$BTRFS_UTIL_PROG device remove 2 $SCRATCH_MNT &>/dev/null
> +	[ $? -ne 0 ] || _fail "Successfully removed device"
> +	$BTRFS_UTIL_PROG filesystem resize -5m $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully resized filesystem"
> +	$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully replaced device"
> +	swapon "$swapfile" &> /dev/null
> +	[ $? -ne 0 ] || _fail "Successfully enabled a swap file"
> +}
> +
> +uuid=$(findmnt -n -o UUID $SCRATCH_MNT)

$uuid is not used anywhere, can be removed?

> +
> +# Create some files on the so that balance doesn't complete instantly

You mean "on the device"?

> +args=`_scale_fsstress_args -z \
> +	-f write=10 -f creat=10 \
> +	-n 1000 -p 2 -d $SCRATCH_MNT/stress_dir`
> +echo "Run fsstress $args" >>$seqres.full
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Start and pause balance to ensure it will be restored on remount
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
> +[ $? -eq 0 ] || _fail "Balance not paused"
> +
> +# Exclusive ops should be blocked on manual pause of balance
> +check_exclusive_ops
> +
> +# Balance is now placed in paused state during mount
> +_scratch_cycle_mount "skip_balance"
> +
> +# Exclusive ops should be blocked on balance pause due to 'skip_balance'
> +check_exclusive_ops
> +
> +# Device add is the only allowed operation
> +$BTRFS_UTIL_PROG device add -K -f $SPARE_DEV "$SCRATCH_MNT"
> +
> +# Exclusive ops should still be blocked on account that balance is still paused
> +check_exclusive_ops
> +
> +# Should be possible to resume balance after device add
> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
> +[ $? -eq 0 ] || _fail "Couldn't resume balance after device add"
> +
> +# Add more files so that new balance won't fish immediately
                                              ^^^^ finish ?
> +$FSSTRESS_PROG $args >/dev/null 2>&1
> +
> +# Now pause->resume balance. This ensures balance paused is properly set in
> +# the kernel and won't trigger an assertion failure.
> +echo "Start balance" >>$seqres.full
> +_run_btrfs_balance_start --bg "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance pause "$SCRATCH_MNT"
> +$BTRFS_UTIL_PROG balance status "$SCRATCH_MNT" | grep -q paused
> +[ $? -eq 0 ] || _fail "Balance not paused"
> +$BTRFS_UTIL_PROG balance resume "$SCRATCH_MNT" &>/dev/null
> +[ $? -eq 0 ] || _fail "Balance can't be resumed via IOCTL"
> +
> +_spare_dev_put
> +_scratch_dev_pool_put
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> index cb0061b33ff0..c69568ad9323 100644
> --- a/tests/btrfs/049.out
> +++ b/tests/btrfs/049.out
> @@ -1 +1,2 @@
>  QA output created by 049
> +Silence is golden

Ah, 049.out was forgotten to be removed by commit 668c859d37f2
("btrfs/049: remove the test"), so it's reused here.

Thanks,
Eryu
