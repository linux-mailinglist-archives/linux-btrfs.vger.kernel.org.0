Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA9225301
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Jul 2020 19:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGSRPD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Jul 2020 13:15:03 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:40859 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRPD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Jul 2020 13:15:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07567487|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0172471-0.00118252-0.98157;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03294;MF=guan@eryu.me;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.I4NDvDj_1595178898;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.I4NDvDj_1595178898)
          by smtp.aliyun-inc.com(10.147.42.253);
          Mon, 20 Jul 2020 01:14:59 +0800
Date:   Mon, 20 Jul 2020 01:14:58 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Boris Burkov <boris@bur.io>
Cc:     Josef Bacik <josef@toxicpanda.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2] generic: add a test for umount racing mount
Message-ID: <20200719171458.GD2557159@desktop>
References: <c8bfc2c7-4c13-72e4-3665-c2e2dec99dd4@toxicpanda.com>
 <20200710171836.127889-1-boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710171836.127889-1-boris@bur.io>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[ cc'ed Amir for failure on overlayfs ]

On Fri, Jul 10, 2020 at 10:18:36AM -0700, Boris Burkov wrote:
> Test if dirtying many inodes (which can delay umount) then
> unmounting and quickly mounting again causes the mount to fail.
> 
> A race, which breaks the test in btrfs, is fixed by the patch:
> "btrfs: fix mount failure caused by race with umount"
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/generic/604     | 52 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/604.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 55 insertions(+)
>  create mode 100755 tests/generic/604
>  create mode 100644 tests/generic/604.out
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> new file mode 100755
> index 00000000..e67899cb
> --- /dev/null
> +++ b/tests/generic/604
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Facebook  All Rights Reserved.
> +#
> +# FS QA Test 604
> +#
> +# Evicting dirty inodes can take a long time during umount.
> +# Check that a new mount racing with such a delayed umount succeeds.
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
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test

Test takes use of scratch dev, but required test dev here.

> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +for i in $(seq 0 500)
> +do
> +	dd if=/dev/zero of="$SCRATCH_MNT/$i" bs=1M count=1 > /dev/null 2>&1
> +done

The kernel patch describes that it only needs to make a bunch of inodes
dirty, so is it really necessary to write 500M data to the fs? Does
writing less files work (e.g. 50)? Or does writing less data work (e.g.
4k file)?

Also, fstests perfers code style like

for i in $(seq 0 500); do
	$XFS_IO_PROG -c "pwrite 0 1M" $SCRATCH_MNT/$i >/dev/null 2>&1
done

> +_scratch_unmount &
> +_scratch_mount

xfs and ext4 both passed this test, but overlayfs always fails the test.
I'm not sure if this is a valid test for overlay? Or it's just that
overlayfs should be fixed? Amir, any comments here?

Thanks,
Eryu

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/604.out b/tests/generic/604.out
> new file mode 100644
> index 00000000..6810da89
> --- /dev/null
> +++ b/tests/generic/604.out
> @@ -0,0 +1,2 @@
> +QA output created by 604
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index d9ab9a31..c0ace35b 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -605,3 +605,4 @@
>  601 auto quick quota
>  602 auto quick encrypt
>  603 auto quick quota
> +604 auto quick
> -- 
> 2.24.1
