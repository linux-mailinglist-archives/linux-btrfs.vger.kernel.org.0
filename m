Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E9A28A520
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 05:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgJKDPA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Oct 2020 23:15:00 -0400
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:41705 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJKDPA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Oct 2020 23:15:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439194|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0342363-0.00135174-0.964412;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Ihf-t6U_1602386097;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Ihf-t6U_1602386097)
          by smtp.aliyun-inc.com(10.147.42.16);
          Sun, 11 Oct 2020 11:14:57 +0800
Date:   Sun, 11 Oct 2020 11:14:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v5] btrfs: Add new test for qgroup assign functionality
Message-ID: <20201011031457.GT3853@desktop>
References: <20200927171512.1253-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927171512.1253-1-realwakka@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 27, 2020 at 05:15:12PM +0000, Sidong Yang wrote:
> This new test will test btrfs's qgroup assign functionality. The
> test has 3 cases.
> 
>  - assign, no shared extents
>  - assign, shared extents
>  - snapshot -i, shared extents
> 
> Each cases create subvolumes and assign qgroup in their own way
> and check with the command "btrfs check".
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Eryu Guan <guan@eryu.me>

Please don't add "Reviewed-by" tag before it's provided explicitly,
Qu and I have given review comments but that doesn't mean we provide a
"Reviewed-by" tag.

> 
> ---
> v2:
>  - Create new test and use the cases
> v3:
>  - Fix some minor mistakes
>  - Make that write some data before assign or snapshot in test
>  - Put mkfs & mount pair in test function
> v4:
>  - Add rescan command for assign no shared
>  - Use _check_scratch_fs for checking
> v5:
>  - Remove trailing whitespaces
> ---
>  tests/btrfs/221     | 116 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/221.out |   2 +
>  tests/btrfs/group   |   1 +
>  3 files changed, 119 insertions(+)
>  create mode 100755 tests/btrfs/221
>  create mode 100644 tests/btrfs/221.out
> 
> diff --git a/tests/btrfs/221 b/tests/btrfs/221
> new file mode 100755
> index 00000000..19b3740b
> --- /dev/null
> +++ b/tests/btrfs/221
> @@ -0,0 +1,116 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 221
> +#
> +# Test the assign functionality of qgroups
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
> +. ./common/reflink
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +
> +_require_scratch
> +_require_btrfs_qgroup_report
> +_require_cp_reflink
> +
> +# Test assign qgroup for submodule with shared extents by reflink
> +assign_shared_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=== qgroup assign shared test ===" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> +
> +	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> +	cp --reflink=always "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1

Seems you miss the comment about using "_cp_reflink" helper.

Thanks,
Eryu

> +
> +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> +
> +	_scratch_unmount
> +	_check_scratch_fs
> +}
> +
> +# Test assign qgroup for submodule without shared extents
> +assign_no_shared_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=== qgroup assign no shared test ===" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> +
> +	_scratch_unmount
> +	_check_scratch_fs
> +}
> +
> +# Test snapshot with assigning qgroup for submodule
> +snapshot_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=== qgroup snapshot test ===" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
> +
> +	_scratch_unmount
> +	_check_scratch_fs
> +}
> +
> +
> +assign_no_shared_test
> +
> +assign_shared_test
> +
> +snapshot_test
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
> new file mode 100644
> index 00000000..aa4351cd
> --- /dev/null
> +++ b/tests/btrfs/221.out
> @@ -0,0 +1,2 @@
> +QA output created by 221
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 1b5fa695..cdda38f3 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -222,3 +222,4 @@
>  218 auto quick volume
>  219 auto quick volume
>  220 auto quick
> +221 auto quick qgroup
> -- 
> 2.25.1
