Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1824A706D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbiBBMAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 07:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiBBMAg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 07:00:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FB1C061714;
        Wed,  2 Feb 2022 04:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EEEA61716;
        Wed,  2 Feb 2022 12:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92C7C004E1;
        Wed,  2 Feb 2022 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643803235;
        bh=AnQRl8GnRvjTh7D09LoyRrP0x0G8iw29D1VuYTD4Gjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YM0ZdwFi+esGPIo2hwTY8jpVRTade9k6oMpp0BpUW/WBwdvXNDDS6PLq+s3oggNi5
         F4tgqhiuSX6z2DhqvbbdIiIQWaSamzlbEoYHNfOFdvJPvt+AQOvM9bVX4JL0ZEri1e
         4oNVhNgJ4ewyWVE2aqRI9c0be4mPj1NWJOK8Y+ullfLURFsLpkq1/RrvbV6mnzrkVO
         RHPM0TpJOr4t1NKrz34FD0lyaf8ZnmVh+6YtR0yIWjAZG+xb3vmCRlD8kmGaGEEdNF
         DKlg7aIL4MFEXtnqq+tg3vS/bMz8RnV1MAohy4+veAIb4/C/EIT8VUqNgLWR7oYMac
         geiljweDBiehg==
Date:   Wed, 2 Feb 2022 12:00:31 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add test case to verify "btrfs filesystem
 defragment -c" behavior
Message-ID: <YfpyXz0uaoZKOQdT@debian9.Home>
References: <20220202111508.81263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202111508.81263-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 02, 2022 at 07:15:08PM +0800, Qu Wenruo wrote:
> Despite the regular file defragging, "btrfs filesystem defragment" provides
> an option, -c, to convert all data extents (except holes and
> preallocated ranges) to a new compression algorithm.
> 
> The special behavior here is, unlike regular defrag which is not going to
> touch extents which are adjacent to preallocated/hole ranges, with -c, all
> non-hole/non-preallocated extents should be defragged and converted to
> the new compression algorithm.
> 
> This test case will ensure the old behavior is properly kept.
> 
> Currently both old kernels (v5.15 and older) and newer kernel with
> refactored defrag (v5.16 and newer) can pass the tests.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> Changelog:
> v2:
> - Add the test into prealloc group
> - Add explicit requirement for ranged fiemap and prealloc of xfs_io
> - Fix a typo in commit message
> - Use full "btrfs filesystem defragment" in the test case
> - Remove unnecessary compress-force mount option
> - Remove unnecessary -f option for xfs_io falloc command
>   Which is working on an existing file.
> ---
>  tests/btrfs/258     | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/258.out |   2 +
>  2 files changed, 160 insertions(+)
>  create mode 100755 tests/btrfs/258
>  create mode 100644 tests/btrfs/258.out
> 
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> new file mode 100755
> index 00000000..360bb5f5
> --- /dev/null
> +++ b/tests/btrfs/258
> @@ -0,0 +1,158 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 258
> +#
> +# Make sure "btrfs filesystem defragment" can still convert the compression
> +# algorithm of all regular extents.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag compress prealloc
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
> +_require_xfs_io_command "fiemap" "ranged"
> +_require_xfs_io_command "falloc"
> +_require_btrfs_command inspect-internal dump-tree
> +
> +get_inode_number()
> +{
> +	local file="$1"
> +
> +	stat -c "%i" "$file"
> +}
> +
> +get_file_extent()
> +{
> +	local file="$1"
> +	local offset="$2"
> +	local ino=$(get_inode_number "$file")
> +	local file_extent_key="($ino EXTENT_DATA $offset)"
> +
> +	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +		grep -A4 "$file_extent_key"
> +}
> +
> +check_file_extent()
> +{
> +	local file="$1"
> +	local offset="$2"
> +	local expected="$3"
> +
> +	echo "=== file extent at file '$file' offset $offset ===" >> $seqres.full
> +	get_file_extent "$file" "$offset" > $tmp.output
> +	cat $tmp.output >> $seqres.full
> +	grep -q "$expected" $tmp.output ||\
> +		echo "file \"$file\" offset $offset doesn't have expected string \"$expected\""
> +}
> +
> +# Unlike file extents whose btrfs specific attributes need to be grabbed from
> +# dump-tree, we can check holes by fiemap. And mkfs enables no-holes feature by
> +# default in recent versions of btrfs-progs, preventing us from grabbing holes
> +# from dump-tree.
> +check_hole()
> +{
> +	local file="$1"
> +	local offset="$2"
> +	local len="$3"
> +
> +	output=$($XFS_IO_PROG -c "fiemap $offset $len" "$file" |\
> +		 _filter_xfs_io_fiemap | head -n1)
> +	if [ -z $output ]; then
> +		echo "=== file extent at file '$file' offset $offset is a hole ===" \
> +			>> $seqres.full
> +	else
> +		echo "=== file extent at file '$file' offset $offset is not a hole ==="
> +	fi
> +}
> +
> +# Needs 4K sectorsize as the test is crafted using that sectorsize
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs -s 4k >> $seqres.full 2>&1
> +
> +# Initial data is compressed using lzo
> +_scratch_mount -o compress=lzo
> +
> +# file 'large' has all of its compressed extents at their maximum size
> +$XFS_IO_PROG -f -c "pwrite 0 1m" "$SCRATCH_MNT/large" >> $seqres.full
> +
> +# file 'fragment' has all of its compressed extents adjacent to
> +# preallocated/hole ranges, which should not be defragged with regular
> +# defrag ioctl, but should still be defragged by
> +# "btrfs filesystem defragment -c"
> +$XFS_IO_PROG -f -c "pwrite 0 16k" \
> +		-c "pwrite 32k 16k" -c "pwrite 64k 16k" \
> +		"$SCRATCH_MNT/fragment" >> $seqres.full
> +sync
> +# We only do the falloc after the compressed data reached disk.
> +# Or the inode could have PREALLOC flag, and prevent the
> +# data from being compressed.
> +$XFS_IO_PROG -c "falloc 16k 16k" "$SCRATCH_MNT/fragment"
> +sync
> +
> +echo "====== Before the defrag ======" >> $seqres.full
> +
> +# Should be lzo compressed 
> +check_file_extent "$SCRATCH_MNT/large" 0 "compression 2"
> +
> +# Should be lzo compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 2"
> +
> +# Should be preallocated
> +check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
> +
> +# Should be lzo compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 2"
> +
> +# Should be hole
> +check_hole "$SCRATCH_MNT/fragment" 49152 16384
> +
> +# Should be lzo compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 2"
> +
> +$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/large" -czstd \
> +	"$SCRATCH_MNT/fragment" >> $seqres.full
> +# Need to commit the transaction or dump-tree won't grab the new
> +# metadata on-disk.
> +sync
> +
> +echo "====== After the defrag ======" >> $seqres.full
> +
> +# Should be zstd compressed 
> +check_file_extent "$SCRATCH_MNT/large" 0 "compression 3"
> +
> +# Should be zstd compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 0 "compression 3"
> +
> +# Should be preallocated
> +check_file_extent "$SCRATCH_MNT/fragment" 16384 "type 2"
> +
> +# Should be zstd compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 32768 "compression 3"
> +
> +# Should be hole
> +check_hole "$SCRATCH_MNT/fragment" 49152 16384
> +
> +# Should be zstd compressed 
> +check_file_extent "$SCRATCH_MNT/fragment" 65536 "compression 3"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/258.out b/tests/btrfs/258.out
> new file mode 100644
> index 00000000..9d47016c
> --- /dev/null
> +++ b/tests/btrfs/258.out
> @@ -0,0 +1,2 @@
> +QA output created by 258
> +Silence is golden
> -- 
> 2.34.1
> 
