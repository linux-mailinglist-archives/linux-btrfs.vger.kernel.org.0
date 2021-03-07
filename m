Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC933021A
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Mar 2021 15:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhCGOgp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 09:36:45 -0500
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:43169 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhCGOgB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 09:36:01 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1223581|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0673245-0.000366299-0.932309;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.Jhc3G1a_1615127757;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.Jhc3G1a_1615127757)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 07 Mar 2021 22:35:57 +0800
Date:   Sun, 7 Mar 2021 22:35:57 +0800
From:   Eryu Guan <guan@eryu.me>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: add test for cases when a dio write has to
 fallback to a buffered write
Message-ID: <YETkzeWJTB2C88ON@desktop>
References: <20210211170118.12551-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211170118.12551-1-fdmanana@kernel.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 11, 2021 at 05:01:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test cases where a direct IO write, with O_DSYNC, can not be done and has
> to fallback to a buffered write.
> 
> This is motivated by a regression that was introduced in kernel 5.10 by
> commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")) and was
> fixed in kernel 5.11 by commit ecfdc08b8cc65d ("btrfs: remove dio iomap
> DSYNC workaround").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Sorry for the late review..

So this is supposed to fail with v5.10 kernel, right? But I got it
passed

  [root@fedoravm xfstests]# ./check -s btrfs btrfs/231
  SECTION       -- btrfs
  RECREATING    -- btrfs on /dev/mapper/testvg-lv1
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 fedoravm 5.10.0 #6 SMP Sun Mar 7 22:25:35 CST 2021
  MKFS_OPTIONS  -- /dev/mapper/testvg-lv2
  MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
  
  btrfs/231 13s ...  8s
  Ran: btrfs/231
  Passed all 1 tests
  
  SECTION       -- btrfs
  =========================
  Ran: btrfs/231
  Passed all 1 tests

> ---
>  tests/btrfs/231     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/231.out | 21 ++++++++++++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/231
>  create mode 100644 tests/btrfs/231.out
> 
> diff --git a/tests/btrfs/231 b/tests/btrfs/231
> new file mode 100755
> index 00000000..9a404f57
> --- /dev/null
> +++ b/tests/btrfs/231
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/231
> +#
> +# Test cases where a direct IO write, with O_DSYNC, can not be done and has to
> +# fallback to a buffered write.
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
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
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch
> +_require_odirect
> +_require_chattr c
> +
> +rm -f $seqres.full
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# First lets test with an attempt to write into a file range with compressed
> +# extents.
> +touch $SCRATCH_MNT/foo
> +$CHATTR_PROG +c $SCRATCH_MNT/foo

It's not so clear to me why writing into a compressed file is required,
would you please add more comments?

Thanks,
Eryu

> +
> +$XFS_IO_PROG -s -c "pwrite -S 0xab -b 1M 0 1M" $SCRATCH_MNT/foo | _filter_xfs_io
> +# Now do the direct IO write...
> +$XFS_IO_PROG -d -s -c "pwrite -S 0xcd 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
> +
> +# Now try doing a write into an unaligned offset...
> +$XFS_IO_PROG -f -d -s -c "pwrite -S 0xef 1111 512K" $SCRATCH_MNT/bar | _filter_xfs_io
> +
> +# Unmount, mount again, and verify we have the expected data.
> +_scratch_cycle_mount
> +
> +echo "File foo data:"
> +od -A d -t x1 $SCRATCH_MNT/foo
> +echo "File bar data:"
> +od -A d -t x1 $SCRATCH_MNT/bar
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
> new file mode 100644
> index 00000000..def05769
> --- /dev/null
> +++ b/tests/btrfs/231.out
> @@ -0,0 +1,21 @@
> +QA output created by 231
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 524288/524288 bytes at offset 524288
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 524288/524288 bytes at offset 1111
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +File foo data:
> +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> +*
> +0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +1048576
> +File bar data:
> +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +*
> +0001104 00 00 00 00 00 00 00 ef ef ef ef ef ef ef ef ef
> +0001120 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
> +*
> +0525392 ef ef ef ef ef ef ef
> +0525399
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index a7c65983..9f63db69 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -233,3 +233,4 @@
>  228 auto quick volume
>  229 auto quick send clone
>  230 auto quick qgroup limit
> +231 auto quick compress rw
> -- 
> 2.28.0
