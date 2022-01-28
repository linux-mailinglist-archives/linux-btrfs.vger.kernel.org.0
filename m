Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7A49F8D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 12:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiA1L53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 06:57:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47158 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiA1L53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 06:57:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E075B8253E;
        Fri, 28 Jan 2022 11:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93EC340E0;
        Fri, 28 Jan 2022 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643371046;
        bh=SSXUZtyuGl/6lh6Qb44PlN5jgSHgebLB2U8ff++Q3Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFn4FH6vFLoGqOPBwX3rlJu2wi8aXfEhJQcDsrj4lKLt7worV9d/3xsYILCxEP0WQ
         EzONXrf3+sNUv/AZin+Y70ZbUEbzm2BeC3HksHbu3qoaahDj1u/1cZOWe+7zPTmhHB
         F71R/geNB7MbzounO6UQSjnY4E75asUj+G8lnd9tWgUYMEC/rZA/a69DKRgYaShg5I
         SS37UlYa31DV/fI1ZNt1R3Sca64/4wxfX8OFlQxlComz4Cr1rnJKCupbeftBL1NEve
         T43WwkmhDNYZ0xj//RThFyfiJsBoAKxmIsNWLxVQtldtCW3dRFJ7xt+guCawajJVV/
         Z1GGbE7m7yOTg==
Date:   Fri, 28 Jan 2022 11:57:24 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: test autodefrag with regular and hole
 extents
Message-ID: <YfPaJHzW4/KJoRAI@debian9.Home>
References: <20220128002701.11971-1-wqu@suse.com>
 <20220128002701.11971-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002701.11971-2-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 08:27:00AM +0800, Qu Wenruo wrote:
> In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
> cluster (up to 256K in size) has even a single hole, the whole cluster
> will be rejected.
> 
> This will greatly reduce the efficiency of autodefrag.
> 
> The behavior is fixed in v5.16 by a full rework, although the rework
> itself has other problems, it at least solves the problem.
> 
> Here we add a test case to reproduce the case, where we have a 128K
> cluster, the first half is fragmented extents which can be defragged.
> The second half is hole.
> 
> Make sure autodefrag can defrag the 64K part.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Tried the test, and it succeeds here without the kernel fix applied.
I've ran it 10 times, and it always passed without the kernel fix.

Thanks.

> ---
> Changelog:
> v2:
> - Use the previously define _get_file_extent_sector() helper
>   This also removed some out-of-sync error messages
> 
> - Trigger autodefrag using commit=1 mount option
>   No need for special purpose patch any more.
> 
> - Use xfs_io -s to skip several sync calls
> 
> - Shorten the subject of the commit
> ---
>  tests/btrfs/256     | 80 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/256.out |  2 ++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/btrfs/256
>  create mode 100644 tests/btrfs/256.out
> 
> diff --git a/tests/btrfs/256 b/tests/btrfs/256
> new file mode 100755
> index 00000000..def83a15
> --- /dev/null
> +++ b/tests/btrfs/256
> @@ -0,0 +1,80 @@
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
> +# Needs 4K sectorsize, as larger sectorsize can change the file layout.
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs >> $seqres.full
> +
> +# Need datacow to show which range is defragged, and we're testing
> +# autodefrag
> +_scratch_mount -o datacow,autodefrag
> +
> +# Create a layout where we have fragmented extents at [0, 64k) (sync write in
> +# reserve order), then a hole at [64k, 128k)
> +$XFS_IO_PROG -f -s -c "pwrite 48k 16k" -c "pwrite 32k 16k" \
> +		-c "pwrite 16k 16k" -c "pwrite 0 16k" \
> +		$SCRATCH_MNT/foobar >> $seqres.full
> +truncate -s 128k $SCRATCH_MNT/foobar
> +
> +old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +echo "=== File extent layout before autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +echo "old md5=$old_csum" >> $seqres.full
> +
> +old_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +old_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
> +
> +# Now trigger autodefrag, autodefrag is triggered in the cleaner thread,
> +# which will be woken up by commit thread
> +_scratch_remount commit=1
> +sleep 3
> +sync
> +
> +new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +new_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +new_hole=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 64k)
> +
> +echo "=== File extent layout after autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +echo "new md5=$new_csum" >> $seqres.full
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
