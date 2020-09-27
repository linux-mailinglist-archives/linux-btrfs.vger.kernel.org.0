Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679A427A063
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 11:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgI0J5N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Sep 2020 05:57:13 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:53692 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0J5N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Sep 2020 05:57:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0743787|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0314969-0.00109733-0.967406;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07447;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Icq6gc7_1601200628;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Icq6gc7_1601200628)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 27 Sep 2020 17:57:08 +0800
Date:   Sun, 27 Sep 2020 17:57:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4] btrfs: Add new test for qgroup assign functionality
Message-ID: <20200927095707.GS3853@desktop>
References: <20200924144348.46203-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924144348.46203-1-realwakka@gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 24, 2020 at 02:43:48PM +0000, Sidong Yang wrote:
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
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Eryu Guan <guan@eryu.me>
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
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
> index 00000000..6b7c9674
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

There's a helper to do this, _cp_reflink.

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

Trailing whitespace in above line.

> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> +	

Trailing whitespace in above line.

> +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> +	

Trailing whitespace in above line.

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

Trailing whitespace in above line.

> +	_scratch_unmount
> +	_check_scratch_fs	

Trailing whitespace in above line.

Otherwise looks fine.

Thanks,
Eryu

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
