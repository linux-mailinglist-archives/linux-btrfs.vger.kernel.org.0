Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A0497F90
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 13:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiAXMaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 07:30:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52430 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241430AbiAXMaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 07:30:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C64360FE0;
        Mon, 24 Jan 2022 12:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1447C340E1;
        Mon, 24 Jan 2022 12:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643027411;
        bh=OVqPUbqWg40WptkSrBN9gmjqvNRzFSqVdjeTSSQZlR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d9W4ipTBkIiPV0+D/VjAaNWUcIMarxeoTxnam1LMPyImtVzk0Fxlt4FLuEUd7BOMm
         n/0NXrLpuJyKKjVjicSy5yrIVlf00ewkjDhNNs2p/MM5VFgI+N32ODwVcPkiuoAvHE
         FYxYDAnCSE0vl7gUJdILW2/px7jfEmdEPFbgdZsZ1SctHzD3ab0wIdBcdhhN9hLP5J
         OmN/tK6eoLttVo1V8Ft3PGsAlhGKccH5i7ZXs4t8pzdfX4PFzm/XnK4MjsZctKyQZH
         Xqy/y1eyxSjDLG8TENTiDsW70uKTCdQyTnbLWk11mTgwGxSuT+phQNXRvvF4BLMv8q
         JXFJ3P9SHHAiQ==
Date:   Mon, 24 Jan 2022 12:30:08 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add test to verify the defrag behavior around
 preallocated extents
Message-ID: <Ye6b0LrAcjs04256@debian9.Home>
References: <20220123053133.26664-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123053133.26664-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 23, 2022 at 01:31:33PM +0800, Qu Wenruo wrote:
> Recent v5.16 has some regression around btrfs autodefrag mount option,
> and the extra scrutiny around defrag code exposes some questionable
> behavior from the old code.
> 
> One behavior is to defrag extents along with the next preallocated
> extent.
> 
> This behavior will cause extra IO and convert all the preallocated
> extent to regular zero filled extents, rendering the preallocated extent
> useless.
> 
> The kernel fix is titled:
> 
>   btrfs: defrag: don't try to merge regular extents with preallocated extents
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/255     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/255.out |  2 ++
>  2 files changed, 83 insertions(+)
>  create mode 100755 tests/btrfs/255
>  create mode 100644 tests/btrfs/255.out
> 
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> new file mode 100755
> index 00000000..3d952c1f
> --- /dev/null
> +++ b/tests/btrfs/255
> @@ -0,0 +1,81 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 255
> +#
> +# Make sure btrfs doesn't defrag preallocated extents, nor lone extents
> +# before preallocated extents.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick defrag
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +get_extent_disk_sector()
> +{
> +	local file=$1
> +	local offset=$2
> +
> +	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
> +	       	head -n1 | awk '{print $3}'

awk -> $AWK_PROG

> +}
> +# Needs 4K sectorsize
> +_scratch_mkfs -s 4k >> $seqres.full 2>&1

Shouldn't it be a require rule so that it doesn't fail in some weird way
in case it's running a machine with a page size > 4K and on a kernel without
subpage size support?

> +
> +# Need datacow to make the defragged extents to have different bytenr
> +_scratch_mount -o datacow
> +
> +# Create a file with the following layout:
> +# 0       4K        8K        16K
> +# |<- R ->|<-- Preallocated ->|
> +# R is regular extents.
> +#
> +# In this case it makes no sense to defrag any extent.
> +$XFS_IO_PROG -f -c "pwrite 0 4k" -c sync -c "falloc 4k 12k" \
> +	"$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +echo "=== Initial file extent layout ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Save the bytenr of both extents
> +old_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> +old_prealloc=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 4096)
> +
> +# Now defrag and write the defragged range back to disk
> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
> +sync
> +
> +echo "=== File extent layout after defrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +new_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
> +new_prealloc=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 4096)
> +
> +if [ "$old_regular" -ne "$new_regular" ]; then
> +	echo "the single lone sector get defragged"

get -> got

> +fi
> +if [ "$old_prealloc" -ne "$new_prealloc" ]; then
> +	echo "the preallocated extent get defragged"

get -> got

Otherwise it looks good, thanks.

> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
> new file mode 100644
> index 00000000..7eefb828
> --- /dev/null
> +++ b/tests/btrfs/255.out
> @@ -0,0 +1,2 @@
> +QA output created by 255
> +Silence is golden
> -- 
> 2.34.1
> 
