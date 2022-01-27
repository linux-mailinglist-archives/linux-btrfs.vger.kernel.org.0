Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5037449E0B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 12:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiA0LXb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 06:23:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60160 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235693AbiA0LXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 06:23:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B2A8617FE;
        Thu, 27 Jan 2022 11:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694E8C340E4;
        Thu, 27 Jan 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643282609;
        bh=1ZYCjhoZFXSRwpfUQZ+bT10rB/yIDtTpMr6xaRGi6WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ex2mrCE3GZSXqDJH2KW/6iNqP4bgCPc7ljifO2mZwTAPSh86Xpi3UAhHYov/Qz/h7
         MBRPFfSgB8zfoFC4LQJ8NJB7T3fgOUat9tNCBgRU80U5Ay1PoIK7zeAIqNyojxposW
         LUsv1TIRvmW5DnThcpMlj+mjEe9Xsh566l2BiJY1zR3IETw5L86uik1zdKUeAovYSX
         rKPCKQTtQUV2+Zw3hp70Wig2e26mczjLEicJhpT9qCV/LeOVbDjAaDUTEthQxlDgSm
         s4cQyZ6g6ARqiU5Eai+N49dXeHvI1HXIDDY7a4I5l1R0HuU5VoIeDLcYTODdicDCdJ
         GFhVzPC0fHxxQ==
Date:   Thu, 27 Jan 2022 11:23:27 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag won't give
 up the whole cluster when there is a hole in it
Message-ID: <YfKAr3AaFpzmY0LX@debian9.Home>
References: <20220127054543.28964-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127054543.28964-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 01:45:43PM +0800, Qu Wenruo wrote:
> In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
> cluster (up to 256K in size) has even a single hole, the whole cluster
> will be rejected.
> 
> This will greatly reduce the efficiency of autodefrag.
> 
> The behavior is fixed in v5.16 by a full rework, although the rework
> itself has other problems, it at least solves this particular
> regression.
> 
> Here we add a test case to reproduce the case, where we have a 128K
> cluster, the first half is fragmented extents which can be defragged.
> The second half is hole.
> 
> Make sure autodefrag can defrag the 64K part.
> 
> This test needs extra debug feature, which is titled:
> 
>   [RFC] btrfs: sysfs: introduce <uuid>/debug/cleaner_trigger
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/btrfs        |  11 +++++
>  tests/btrfs/256     | 112 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/256.out |   2 +
>  3 files changed, 125 insertions(+)
>  create mode 100755 tests/btrfs/256
>  create mode 100644 tests/btrfs/256.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index 5de926dd..4e6842d9 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -496,3 +496,14 @@ _require_btrfs_support_sectorsize()
>  	grep -wq $sectorsize /sys/fs/btrfs/features/supported_sectorsizes || \
>  		_notrun "sectorsize $sectorsize is not supported"
>  }
> +
> +# Require trigger for cleaner kthread
> +_require_btrfs_debug_cleaner_trigger()
> +{
> +	local fsid
> +
> +	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR | grep uuid: |\
> +	       $AWK_PROG '{print $NF}')
> +	test -f /sys/fs/btrfs/$fsid/debug/cleaner_trigger ||\
> +		_notrun "no cleaner kthread trigger"
> +}
> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> new file mode 100755
> index 00000000..86e6739e
> --- /dev/null
> +++ b/tests/btrfs/256
> @@ -0,0 +1,112 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 256
> +#
> +# Make sure btrfs auto defrag can properly defrag clusters which has hole
> +# in the middle
> +#
> +. ./common/preamble
> +_begin_fstest auto defrag quick
> +
> +. ./common/btrfs
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_scratch
> +
> +get_extent_disk_sector()
> +{
> +	local file=$1
> +	local offset=$2
> +
> +	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
> +		head -n1 | $AWK_PROG '{print $3}'
> +}
> +
> +# Needs 4K sectorsize, as larger sectorsize can change the file layout.
> +_require_btrfs_support_sectorsize 4096
> +
> +# We need a way to trigger autodefrag
> +_require_btrfs_debug_cleaner_trigger

In order to trigger the cleaner, we don't need another special purpose
RFC debug patch.

Just mount the fs with "-o commit=1", and then leave the "sleep 3" as it
is. We do this in other tests that expect the cleaner thread to do
something. Every time the transaction kthread wakes up, it will wake up
the cleaner kthread, even if it doesn't have any transaction to commit.

> +
> +_scratch_mkfs >> $seqres.full
> +
> +# Need datacow to show which range is defragged, and we're testing
> +# autodefrag
> +_scratch_mount -o datacow,autodefrag
> +
> +fsid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT |grep uuid: |\
> +       $AWK_PROG '{print $NF}')
> +
> +# Create a layout where we have fragmented extents at [0, 64k) (sync write in
> +# reserve order), then a hole at [64k, 128k)
> +$XFS_IO_PROG -f -c "pwrite 48k 16k" -c sync \
> +		-c "pwrite 32k 16k" -c sync \
> +		-c "pwrite 16k 16k" -c sync \
> +		-c "pwrite 0 16k" $SCRATCH_MNT/foobar >> $seqres.full

Instead of adding a bunch of "-c sync", you can pass -s to xfs_io:

xfs_io -f -s -c "pwrite ..." -c "pwrite ..." ...

It does exactly the same.

> +truncate -s 128k $SCRATCH_MNT/foobar
> +sync
> +
> +old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +echo "=== File extent layout before autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +echo "old md5=$old_csum" >> $seqres.full
> +
> +old_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> +old_hole=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
> +
> +# For hole only xfs_io fiemap, there will be no output at all.

You can get around that by not using _filter_xfs_io_fiemap at
get_extent_disk_sector.

> +# Re-fill it to "hole" for later comparison
> +if [ ! -z $old_hole ]; then
> +	echo "hole not at 128k"

128K -> 64K

> +else
> +	old_hole="hole"
> +fi
> +
> +# Now trigger autodefrag
> +echo 0 > /sys/fs/btrfs/$fsid/debug/cleaner_trigger
> +
> +# No good way to wait for autodefrag to finish yet
> +sleep 3
> +sync
> +
> +new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +new_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> +new_hole=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
> +
> +echo "=== File extent layout after autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +echo "new md5=$new_csum" >> $seqres.full
> +
> +if [ ! -z $new_hole ]; then
> +	echo "hole not at 128k"

64K

> +else
> +	new_hole="hole"
> +fi
> +
> +# In v5.11~v5.15 kernels, regular extents won't get defragged, and would trigger
> +# the following output
> +if [ $new_regular == $old_regular ]; then
> +	echo "regular extents didn't get defragged"
> +fi
> +
> +# In v5.10 and earlier kernel, autodefrag may choose to defrag holes,
> +# which should be avoided.
> +if [ "$new_hole" != "$old_hole" ]; then
> +	echo "hole extents got defragged"
> +fi
> +
> +# Defrag should not change file content
> +if [ "$new_csum" != "$old_csum" ]; then
> +	echo "file content changed"
> +fi
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
> new file mode 100644
> index 00000000..7ee8e2e5
> --- /dev/null
> +++ b/tests/btrfs/256.out
> @@ -0,0 +1,2 @@
> +QA output created by 256
> +Silence is golden
> -- 
> 2.34.1
> 
