Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B751A245857
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgHPPYq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Aug 2020 11:24:46 -0400
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:49258 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgHPPYh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07452709|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0229668-0.0003908-0.976642;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03300;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IIZu.nw_1597591466;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IIZu.nw_1597591466)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 16 Aug 2020 23:24:26 +0800
Date:   Sun, 16 Aug 2020 23:24:26 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/217 add a test for btrfs seed device stats
Message-ID: <20200816152426.GM2557159@desktop>
References: <20200803192559.18330-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803192559.18330-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 03, 2020 at 03:25:59PM -0400, Josef Bacik wrote:
> This is a regression test for the issue fixed by
> 
>   btrfs: init device stats for seed devices
> 
> We create a seed device, add a sprout device, and then check the device
> stats after a remount to make sure it succeeds.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  tests/btrfs/217     | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/217.out | 25 ++++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/217
>  create mode 100644 tests/btrfs/217.out
> 
> diff --git a/tests/btrfs/217 b/tests/btrfs/217
> new file mode 100755
> index 00000000..204298bd
> --- /dev/null
> +++ b/tests/btrfs/217
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test 217
> +#
> +# Regression test for the problem fixed by the patch
> +#
> +#  btrfs: init device stats for seed devices
> +#
> +# Make a seed device, add a sprout to it, and then make sure we can still read
> +# the device stats for both devices after we remount with the new sprout device.
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
> +. ./common/filter.btrfs
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_test
> +_require_scratch_dev_pool 2
> +
> +_scratch_dev_pool_get 2
> +
> +dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
> +dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
> +
> +# Create the seed device
> +_mkfs_dev $dev_seed
> +run_check _mount $dev_seed $SCRATCH_MNT

We should avoid using run_check in new tests, as it hides too many
details and make debug much harder.

Otherwise test looks fine. But I'd like to see a review from other btrfs
folks.

Thanks,
Eryu

> +$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
> +$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
> +	_filter_btrfs_filesystem_show
> +_scratch_unmount
> +$BTRFS_TUNE_PROG -S 1 $dev_seed
> +
> +# Mount the seed device and add the rw device
> +run_check _mount $dev_seed $SCRATCH_MNT
> +_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
> +_scratch_unmount
> +
> +# Now remount, validate the device stats do not fail
> +run_check _mount $dev_sprout $SCRATCH_MNT
> +$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/217.out b/tests/btrfs/217.out
> new file mode 100644
> index 00000000..86c6e775
> --- /dev/null
> +++ b/tests/btrfs/217.out
> @@ -0,0 +1,25 @@
> +QA output created by 217
> +Label: none  uuid: <UUID>
> +	Total devices <NUM> FS bytes used <SIZE>
> +	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> +
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> +[SCRATCH_DEV].write_io_errs    0
> +[SCRATCH_DEV].read_io_errs     0
> +[SCRATCH_DEV].flush_io_errs    0
> +[SCRATCH_DEV].corruption_errs  0
> +[SCRATCH_DEV].generation_errs  0
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index ca90818b..32604e25 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -219,3 +219,4 @@
>  214 auto quick send snapshot
>  215 auto quick
>  216 auto quick seed
> +217 auto quick volume
> -- 
> 2.24.1
