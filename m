Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53DA46071A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 16:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358035AbhK1P15 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 10:27:57 -0500
Received: from out20-15.mail.aliyun.com ([115.124.20.15]:47507 "EHLO
        out20-15.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK1PZ5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 10:25:57 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436496|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00657456-0.0001044-0.993321;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.M-gwaKn_1638112959;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-gwaKn_1638112959)
          by smtp.aliyun-inc.com(10.147.41.120);
          Sun, 28 Nov 2021 23:22:39 +0800
Date:   Sun, 28 Nov 2021 23:22:39 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: test normal qgroup operations in a compress
 friendly way
Message-ID: <YaOev+6wmuvBkfLW@desktop>
References: <86cf6bb2f19f0681e1b7b9fd88774e517848be04.1637678662.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cf6bb2f19f0681e1b7b9fd88774e517848be04.1637678662.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 23, 2021 at 09:44:53AM -0500, Josef Bacik wrote:
> We fail btrfs/022 with -o compress because we test qgroup limits for one
> of the variations.  However this test also tests rescan and a few other
> things that pass fine with compression enabled.  Handle this by using
> the _require_no_compress helper for btrfs/022, and then creating a new
> test that is a copy of 022 without the limit exceed test.  This will

Then should we just remove the duplicated part from btrfs/022?

> allow us to still be able to test the basic functionality with
> compression enabled, and keep us from failing the limit check.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Thanks,
Eryu

> ---
>  tests/btrfs/022     |   3 ++
>  tests/btrfs/251     | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/251.out |   2 +
>  3 files changed, 113 insertions(+)
>  create mode 100755 tests/btrfs/251
>  create mode 100644 tests/btrfs/251.out
> 
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index bfd6ac7f..e126e82a 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -16,6 +16,9 @@ _supported_fs btrfs
>  _require_scratch
>  _require_btrfs_qgroup_report
>  
> +# This test requires specific data usage, skip if we have compression enabled
> +_require_no_compress
> +
>  # Test to make sure we can actually turn it on and it makes sense
>  _basic_test()
>  {
> diff --git a/tests/btrfs/251 b/tests/btrfs/251
> new file mode 100755
> index 00000000..ba23cdce
> --- /dev/null
> +++ b/tests/btrfs/251
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Facebook.  All Rights Reserved.
> +#
> +# FS QA Test No. 251
> +#
> +# Test the basic functionality of qgroups except for the limit enforcement,
> +# this is just btrfs/022 without the limit check so we can test it with
> +# compression enabled.
> +#
> +. ./common/preamble
> +_begin_fstest auto qgroup limit
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_qgroup_report
> +
> +# Test to make sure we can actually turn it on and it makes sense
> +_basic_test()
> +{
> +	echo "=== basic test ===" >> $seqres.full
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
> +		$seqres.full 2>&1
> +	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
> +	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
> +		$FSSTRESS_AVOID
> +	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
> +		$SCRATCH_MNT/b
> +
> +	# the shared values of both the original subvol and snapshot should
> +	# match
> +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
> +	a_shared=$(echo $a_shared | awk '{ print $2 }')
> +	echo "subvol a id=$subvolid" >> $seqres.full
> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> +	echo "subvol b id=$subvolid" >> $seqres.full
> +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
> +	b_shared=$(echo $b_shared | awk '{ print $2 }')
> +	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
> +	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
> +}
> +
> +#enable quotas, do some work, check our values and then rescan and make sure we
> +#come up with the same answer
> +_rescan_test()
> +{
> +	echo "=== rescan test ===" >> $seqres.full
> +	# first with a blank subvol
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
> +		$FSSTRESS_AVOID
> +	sync
> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
> +	echo "qgroup values before rescan: $output" >> $seqres.full
> +	refer=$(echo $output | awk '{ print $2 }')
> +	excl=$(echo $output | awk '{ print $3 }')
> +	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
> +	echo "qgroup values after rescan: $output" >> $seqres.full
> +	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
> +		_fail "reference values don't match after rescan"
> +	[ $excl -eq $(echo $output | awk '{ print $3 }') ] || \
> +		_fail "exclusive values don't match after rescan"
> +}
> +
> +#basic noexceed limit testing
> +_limit_test_noexceed()
> +{
> +	echo "=== limit not exceed test ===" >> $seqres.full
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
> +	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
> +	[ $? -eq 0 ] || _fail "should have been allowed to write"
> +}
> +
> +units=`_btrfs_qgroup_units`
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +_basic_test
> +_scratch_unmount
> +_check_scratch_fs
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +_rescan_test
> +_scratch_unmount
> +_check_scratch_fs
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +_limit_test_noexceed
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/251.out b/tests/btrfs/251.out
> new file mode 100644
> index 00000000..e5cd36a9
> --- /dev/null
> +++ b/tests/btrfs/251.out
> @@ -0,0 +1,2 @@
> +QA output created by 251
> +Silence is golden
> -- 
> 2.26.3
