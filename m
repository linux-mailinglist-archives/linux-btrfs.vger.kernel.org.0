Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3162749F944
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 13:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348465AbiA1MUW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 07:20:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36578 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244625AbiA1MUV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 07:20:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C75F61AEC;
        Fri, 28 Jan 2022 12:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAF5C340E8;
        Fri, 28 Jan 2022 12:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643372420;
        bh=FtgPmB84ffDNMiZJY/FcEB++wC5fV+QDqDZ7DSsxcYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rvly7XS2aatOvxJGvKhIF7BO6v1E9MYZMv1eeeAwYdbakRMsOxwTZwjIEwCnl3Yzr
         157CVLdqB7ZibKXaVSrR1/Bwv8z9erDajrm8WnccHgiZpAkzDqUpMokot4vzEoecS4
         1ztGSD6rWlXptAo/jQ1qw5nnKDoNdgpj6Qm/kwtU6oLfmuHPOf2QrAI4aLoUDs8MSP
         H+KwqcuBEHqNdG1bHUv66xSpbsp+PDvWEEJy2rpH2sAMmmpjuN9Vr6ZC5gdZWDdYn6
         Ye1/Tr+/fvXyQrRyT+iRpFwXa0ubd7d0vUVqzb0R5EvFLE6+cuheQo8W2egZ7BEVhr
         je3ZFU5qBR2Ag==
Date:   Fri, 28 Jan 2022 12:20:17 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/3] btrfs: test defrag with compressed extents
Message-ID: <YfPfgaWLtKNJcVO3@debian9.Home>
References: <20220128002701.11971-1-wqu@suse.com>
 <20220128002701.11971-3-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002701.11971-3-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 08:27:01AM +0800, Qu Wenruo wrote:
> There is a long existing bug in btrfs defrag code that it will always
> try to defrag compressed extents, even they are already at max capacity.
> 
> This will not reduce the number of extents, but only waste IO/CPU.
> 
> The kernel fix is titled:
> 
>   btrfs: defrag: don't defrag extents which is already at its max capacity
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use fiemap output to compare the difference
>   Now no need to use _get_file_extent_sector() helper at all.
> 
> - Remove unnecessary mount options
> 
> - Enlarge the write size to 16M
>   To be future proof
> 
> - Shorten the subject
> ---
>  tests/btrfs/257     | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/257.out |  2 ++
>  2 files changed, 59 insertions(+)
>  create mode 100755 tests/btrfs/257
>  create mode 100644 tests/btrfs/257.out
> 
> diff --git a/tests/btrfs/257 b/tests/btrfs/257
> new file mode 100755
> index 00000000..bacd0c23
> --- /dev/null
> +++ b/tests/btrfs/257
> @@ -0,0 +1,57 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 257
> +#
> +# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
> +# at their max capacity.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag

Still missing the 'compress' group.

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/btrfs
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +
> +_scratch_mount -o compress
> +
> +# Btrfs uses 128K as max extent size for compressed extents, this would result
> +# several compressed extents all at their max size
> +$XFS_IO_PROG -f -c "pwrite -S 0xee 0 16m" -c sync \
> +	$SCRATCH_MNT/foobar >> $seqres.full
> +
> +old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +
> +echo "=== File extent layout before defrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.before
> +
> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
> +sync
> +
> +new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
> +
> +echo "=== File extent layout before defrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.after
> +
> +if [ $new_csum != $old_csum ]; then
> +	echo "file content changed"
> +fi
> +
> +diff -q $tmp.before $tmp.after || echo "compressed extents get defragged"

get -> got

Like patch 1/3, it can probably be fixed by Eryu when he picks it.

Minor things apart, it looks good, and it fails without the kernel patch
and passes with it, as expected.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
> new file mode 100644
> index 00000000..cc3693f3
> --- /dev/null
> +++ b/tests/btrfs/257.out
> @@ -0,0 +1,2 @@
> +QA output created by 257
> +Silence is golden
> -- 
> 2.34.1
> 
