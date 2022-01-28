Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B64F49F8A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348219AbiA1LtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 06:49:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44092 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiA1LtN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 06:49:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14235B82521;
        Fri, 28 Jan 2022 11:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6AEC340E0;
        Fri, 28 Jan 2022 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643370550;
        bh=ZSvHouefU7Hs3Pcbq5alxSpDJVdlG3DxHHLbYNgXMs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gPTC/jX8jqFYrqZbBIXIjIZDP2gygAJ6y04xyhGQaLYE3VKIsW/qm4C+73vTbgm3E
         31QFOBwf5FOLzuxPte9c98OH4pZ1X6crUWAOs6CZ2VkRfUsjA4U8vz106GS3fyNCGp
         62OiUn1X6mC+krPp4prNUqxBUzazI70L5U86ZC7EZE1cMegJDiUegpVk/Or5wy8CjI
         3n8y7eDlroRAwZS5PFuPzWoEJOMkK0KHktO6pGTxeV5Eq1c8R3+fPmAlstxqo2y8qQ
         nXry5f/+NoanwOjKEDR1ixxRjbKlwUmT5PBNIe/GuaZPc+H0sd1fYSfmlaLYi6DLpz
         gQsHPY4Ky0ckQ==
Date:   Fri, 28 Jan 2022 11:49:07 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 1/3] btrfs: test defrag with regular and preallocated
 extents
Message-ID: <YfPYM2ACKBEs5b9i@debian9.Home>
References: <20220128002701.11971-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002701.11971-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 08:26:59AM +0800, Qu Wenruo wrote:
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
> Changelog:
> v2:
> - Add _require_btrfs_support_sectorsize() helper
>   And use it to make sure the platform supports 4k sectorsize
> 
> - Use $AWK_PROG to replace awk
> 
> v3:
> - Move _get_file_extent_sector() into common/rc
> ---
>  common/btrfs        | 16 ++++++++++
>  common/rc           | 18 +++++++++++
>  tests/btrfs/255     | 75 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/255.out |  2 ++
>  4 files changed, 111 insertions(+)
>  create mode 100755 tests/btrfs/255
>  create mode 100644 tests/btrfs/255.out
> 
> diff --git a/common/btrfs b/common/btrfs
> index 4afe81eb..5de926dd 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -480,3 +480,19 @@ _btrfs_no_v1_cache_opt()
>  	fi
>  	echo -n "-onospace_cache"
>  }
> +
> +# Require certain sectorsize support
> +_require_btrfs_support_sectorsize()
> +{
> +	local sectorsize=$1
> +
> +	# PAGE_SIZE as sectorsize is always supported
> +	if [ $sectorsize -eq $(get_page_size) ]; then
> +		return
> +	fi
> +
> +	test -f /sys/fs/btrfs/features/supported_sectorsizes || \
> +		_notrun "no subpage support found"
> +	grep -wq $sectorsize /sys/fs/btrfs/features/supported_sectorsizes || \
> +		_notrun "sectorsize $sectorsize is not supported"
> +}
> diff --git a/common/rc b/common/rc
> index b3289de9..8fbb32f8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3767,6 +3767,24 @@ _count_attr_extents()
>  	$XFS_IO_PROG -c "fiemap -a" $1 | tail -n +2 | grep -v hole | wc -l
>  }
>  
> +# Get the sector number of the extent at @offset of @file
> +_get_file_extent_sector()
> +{
> +	local file=$1
> +	local offset=$2
> +	local result
> +
> +	result=$($XFS_IO_PROG -c "fiemap $offset" "$file" | \
> +		 _filter_xfs_io_fiemap | head -n1 | $AWK_PROG '{print $3}')
> +
> +	# xfs_io fiemap will output nothing if there is only hole, so here
> +	# to replace the empty string with "hole" instead
> +	if [ -z "$result" ]; then
> +		result="hole"
> +	fi
> +	echo "$result"
> +}
> +
>  # arg 1 is dev to remove and is output of the below eg.
>  # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
>  _devmgt_remove()
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> new file mode 100755
> index 00000000..fb80359c
> --- /dev/null
> +++ b/tests/btrfs/255
> @@ -0,0 +1,75 @@
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

Missing the 'prealloc' group.

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
> +# Needs 4K sectorsize
> +_require_btrfs_support_sectorsize 4096

We use the falloc command of xfs_io, so missing:

_require_xfs_io_command "falloc"

> +
> +_scratch_mkfs -s 4k >> $seqres.full 2>&1
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
> +old_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +old_prealloc=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 4096)
> +
> +# Now defrag and write the defragged range back to disk
> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
> +sync
> +
> +echo "=== File extent layout after defrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +new_regular=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +new_prealloc=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 4096)
> +
> +if [ "$old_regular" -ne "$new_regular" ]; then
> +	echo "the single lone sector get defragged"

get -> got

> +fi
> +if [ "$old_prealloc" -ne "$new_prealloc" ]; then
> +	echo "the preallocated extent get defragged"

get -> got

I don't want to make you send yet another patch version, and those
are minor things that Eryu can probably change when picks the patch,
so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

The test fails as expected without the btrfs fix, and passes with
it with.

Thanks.

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
