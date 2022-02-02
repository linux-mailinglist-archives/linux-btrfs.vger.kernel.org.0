Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8754A6F38
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Feb 2022 11:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbiBBKxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Feb 2022 05:53:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56236 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245607AbiBBKxO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Feb 2022 05:53:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 952B8B83081;
        Wed,  2 Feb 2022 10:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF8EC340E4;
        Wed,  2 Feb 2022 10:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643799192;
        bh=it/OZlDw0ePg1Hjwi0cGnUI0yGNVe8LGErcp4VcRbas=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MMXo2417zplUE2QfnmcybTGn/ZA74uiBvp+KW7ZlBH+KRIZhl2f4+hMCfKuQPPdAt
         h9apOJqBUoFONzMw7UngcF7A45H4nBQEf4s6/a8+BvIRGzl9xksTlEPNK4G2Hz1LME
         B3gUQCIYZ5LrbixYCf51tqs7aJcJ0USVKxXuYodSw4n/39cqyPbwdVQQ8u0EdoO7KK
         xfSzvhXC84QgN0GRM56RaFGDMZdolEcLh7MN9OaleU2CmNOJexaGmwsG0X1XFEQRCm
         EQKkf7JpENUgQiYYQlGGLqdM16s7eRmYLoY07CgT1hr0kvjObtfCagvnv78yD7/yKU
         HKot6u8tXsrUg==
Received: by mail-qk1-f181.google.com with SMTP id w8so17703543qkw.8;
        Wed, 02 Feb 2022 02:53:12 -0800 (PST)
X-Gm-Message-State: AOAM531vWhclsDt2aXT54vX7KF/AxJ2Bb8Q+3B/AkxezgMXlKEB5d80R
        gNtO68enCWb+5JE/mvk68jiAt7oLWuqQb+n4WSU=
X-Google-Smtp-Source: ABdhPJwJ6a3HxmRQAlobm4jwkxhHG4i7YeSR0zA2a1IMUq6p/4PzW0tNceAx+RZI89/bBn/eeM5FluHU8ydD+55kuzo=
X-Received: by 2002:a37:a409:: with SMTP id n9mr19657006qke.120.1643799191327;
 Wed, 02 Feb 2022 02:53:11 -0800 (PST)
MIME-Version: 1.0
References: <20220202083158.68262-1-wqu@suse.com>
In-Reply-To: <20220202083158.68262-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 2 Feb 2022 10:52:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6uc8qHnMTW1S5mQf=sL5GEW5rJjYJHge8WKsdvhxQ88Q@mail.gmail.com>
Message-ID: <CAL3q7H6uc8qHnMTW1S5mQf=sL5GEW5rJjYJHge8WKsdvhxQ88Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test case to verify "btrfs filesystem defrag
 -c" behavior
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 2, 2022 at 10:13 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Despite the regular file defragging, "btrfs filesystem defrag" provides
> an option, -c, to convert all data extents (except holes and
> preallocated ranges) to a new compression algorithm.
>
> The special behavior here is, unlike defrag which is not going to touch
> extents which are adajacent to preallocated/hole ranges, with -c, all

adajacent -> adjacent

> non-hole/non-preallocated extents should be defragged and converted to
> the new compression algorithm.
>
> This test case will ensure the old behavior is properly kept.
>
> Currently both old kernels (v5.15 and older) and newer kernel with
> refactored defrag (v5.16 and newer) can pass the tests.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/258     | 153 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/258.out |   2 +
>  2 files changed, 155 insertions(+)
>  create mode 100755 tests/btrfs/258
>  create mode 100644 tests/btrfs/258.out
>
> diff --git a/tests/btrfs/258 b/tests/btrfs/258
> new file mode 100755
> index 00000000..a82e5af9
> --- /dev/null
> +++ b/tests/btrfs/258
> @@ -0,0 +1,153 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 258
> +#
> +# Make sure "btrfs filesystem defrag" can still convert the compression
> +# algorithm of all regular extents.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag compress

Missing 'prealloc' group, as the test uses fallocate.

> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +#      cd /
> +#      rm -r -f $tmp.*
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
> +get_inode_number()
> +{
> +       local file="$1"
> +
> +       stat -c "%i" "$file"
> +}
> +
> +get_file_extent()
> +{
> +       local file="$1"
> +       local offset="$2"
> +       local ino=$(get_inode_number "$file")
> +       local file_extent_key="($ino EXTENT_DATA $offset)"
> +
> +       $BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
> +               grep -A4 "$file_extent_key"

Misses a "_require_btrfs_command inspect-internal dump-tree" at the top.

> +}
> +
> +check_file_extent()
> +{
> +       local file="$1"
> +       local offset="$2"
> +       local expected="$3"
> +
> +       echo "=== file extent at file '$file' offset $offset ===" >> $seqres.full
> +       get_file_extent "$file" "$offset" > $tmp.output
> +       cat $tmp.output >> $seqres.full
> +       grep -q "$expected" $tmp.output ||\
> +               echo "file \"$file\" offset $offset doesn't have expected string \"$expected\""
> +}
> +
> +# Unlike file extents whose btrfs specific attributes need to be grabbed from
> +# dump-tree, we can check holes by fiemap. In fact recent no-holes feature

no-holes was added in 2013, so I wouldn't call it recent.
What you can say is that mkfs enables it by default in new versions of
btrfs-progs.

> +# even makes it unable to grab holes from dump-tree.
> +check_hole()
> +{
> +       local file="$1"
> +       local offset="$2"
> +       local len="$3"
> +
> +       output=$($XFS_IO_PROG -c "fiemap $offset $len" "$file" |\
> +                _filter_xfs_io_fiemap | head -n1)

As the test is using ranged fiemap, it should add:

_require_xfs_io_command "fiemap" "ranged"

At the top.

> +       if [ -z $output ]; then
> +               echo "=== file extent at file '$file' offset $offset is a hole ===" \
> +                       >> $seqres.full
> +       else
> +               echo "=== file extent at file '$file' offset $offset is not a hole ==="
> +       fi
> +}
> +
> +# Needs 4K sectorsize as the test is crafted using that sectorsize
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs -s 4k >> $seqres.full 2>&1
> +
> +# Initial data is compressed using lzo
> +_scratch_mount -o compress=lzo,compress-force=lzo

Why both compress options? Why isn't only compress-force enough?
It's redundant to use compress when using compress-force, or did I
miss something?

> +
> +# file 'large' has all of its compressed extents at their maximum size
> +$XFS_IO_PROG -f -c "pwrite 0 1m" "$SCRATCH_MNT/large" >> $seqres.full
> +
> +# file 'fragment' has all of its compressed extents adjacent to
> +# preallocated/hole ranges, which should not be defragged with regular
> +# defrag ioctl, but should still be defragged by "btrfs fi defrag -c"
> +$XFS_IO_PROG -f -c "pwrite 0 16k" \
> +               -c "pwrite 32k 16k" -c "pwrite 64k 16k" \
> +               "$SCRATCH_MNT/fragment" >> $seqres.full
> +sync
> +# We only do the falloc after the compressed data reached disk.
> +# Or the inode could have PREALLOC flag, and prevent the
> +# data from being compressed.
> +$XFS_IO_PROG -f -c "falloc 16k 16k" "$SCRATCH_MNT/fragment"

-f should go away, the file already exists.

Also, missing a:

_require_xfs_io_command "falloc"

at the top.

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
> +$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/large" -czstd \

Tests should use the full name of btrfs commands and no abbreviations.
So it should use "defragment" and not "defrag", even if it seems very
unlikely the shorter name
will ever be unsupported.

Thanks.

> +       "$SCRATCH_MNT/fragment" >> $seqres.full
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
