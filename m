Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7767E501
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jan 2023 13:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjA0MVC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 07:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjA0MU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 07:20:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9B8626A;
        Fri, 27 Jan 2023 04:17:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DAC61B76;
        Fri, 27 Jan 2023 12:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35ACC433EF;
        Fri, 27 Jan 2023 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674821837;
        bh=SDXjR/Uz9gvxlij58B8eJYGYu04rFY4AInu4uPqjaWI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Exq7pQz+TmUFdIAJx14HjCSo6jHmq7oNcALA5XTs8j0RKzlVnvc7vPHFVqjU5i+eu
         J4mBHNpfWWkLivcr5zBsBPQJq96xrlUhs9jCdF57G3iqRluPsgqiJ2+dK1UvG0lWLX
         zsa7mzEL9DZkX0A0NJ0Z3BGLCDInlWr9lo9Fig5cB+Uum+cH0tlKJBu+8DT20zbO8U
         3lcA+tX65O6ikFP6eDSM2nNA00fLLgf3b8W+vaw9joT8G4KEc7t9p+FIl7PgQjRiz5
         HIFPxP8gMno4zH7fyNwryVuPWSpsbvKATWPWtLwlxGqURvCQEQkDrrbOvhPsK0iZUD
         faGW5RkYkpDZg==
Received: by mail-oi1-f176.google.com with SMTP id r132so4042539oif.10;
        Fri, 27 Jan 2023 04:17:17 -0800 (PST)
X-Gm-Message-State: AFqh2kqHIi351GhpRLX4gZOJy6ng7/CifEe+E+V9Tz84kcqAh418Nh81
        nwjF8IKuH+IDz6EUOu1MRltAmSNXMrxSpufoLPA=
X-Google-Smtp-Source: AMrXdXs/bPR9r+Z1RYg7l0x8F8A81lKc2qxA8sjhf4e8jMipoz6D+TqGm0vy2bvaUmrbUTzeqcubADNkA1K3gzPvMdc=
X-Received: by 2002:a05:6808:1b28:b0:35e:ac60:2452 with SMTP id
 bx40-20020a0568081b2800b0035eac602452mr1857650oib.92.1674821836829; Fri, 27
 Jan 2023 04:17:16 -0800 (PST)
MIME-Version: 1.0
References: <fa66499531a46105f295af0f29d9fc253f361d78.1674755349.git.boris@bur.io>
In-Reply-To: <fa66499531a46105f295af0f29d9fc253f361d78.1674755349.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 27 Jan 2023 12:16:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Uc2=nZxCRkzMSd9DOH8DpsT1Lmac0mfXNDyS+7Vio7w@mail.gmail.com>
Message-ID: <CAL3q7H4Uc2=nZxCRkzMSd9DOH8DpsT1Lmac0mfXNDyS+7Vio7w@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: test block group size class loading logic
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 26, 2023 at 6:02 PM Boris Burkov <boris@bur.io> wrote:
>
> Add a new test which checks that size classes in freshly loaded block
> groups after a cycle mount match size classes before going down
>
> Depends on the kernel patch:
> btrfs: add size class stats to sysfs
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v4:
> Fix dump typo in _fixed_by_kernel_commit (left out leading underscore
> copy+pasting). Re-tested happy and sad case...
>
> v3:
> Re-add fixed_by_kernel_commit, but for the stats patch which is
> required, but not a fix in the strictest sense.
>
> v2:
> Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> development tree, so the fix is getting rolled in to the original broken
> commit. Modified the commit message to note the dependency on the new
> sysfs counters.
>
>
>  tests/btrfs/283     | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/283.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/btrfs/283
>  create mode 100644 tests/btrfs/283.out
>
> diff --git a/tests/btrfs/283 b/tests/btrfs/283
> new file mode 100755
> index 00000000..2176c8e4
> --- /dev/null
> +++ b/tests/btrfs/283
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 283
> +#
> +# Test that mounting a btrfs filesystem properly loads block group size classes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount

Why the mount group? We aren't testing mount options.
It's a bit odd to me.

> +_fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".

Should be _wants_kernel_commit here, because it's a new feature and
not a bug fix.

> +
> +sysfs_size_classes() {
> +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> +}
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_fs_sysfs

This alone is not enough.

What if we are running in a kernel with btrfs' sysfs support but
without the size classes?
I.e. the allocation/data/size_classes path does not exist.

Then the test fails with:

cat: /sys/fs/btrfs/95da1e36-8411-468a-abeb-71652dc2092b/allocation/data/size_classes:
No such file or directory

Instead the test just be skipped, i.e. calling:  _notrun "allocation
size classes not supported"

Thanks.

> +
> +f="$SCRATCH_MNT/f"
> +small=$((16 * 1024))
> +medium=$((1024 * 1024))
> +large=$((16 * 1024 * 1024))
> +
> +_scratch_mkfs >/dev/null
> +_scratch_mount
> +# Write files with extents in each size class
> +$XFS_IO_PROG -fc "pwrite -q 0 $small" $f.small
> +$XFS_IO_PROG -fc "pwrite -q 0 $medium" $f.medium
> +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large
> +# Sync to force the extent allocation
> +sync
> +pre=$(sysfs_size_classes)
> +
> +# cycle mount to drop the block group cache
> +_scratch_cycle_mount
> +
> +# Another write causes us to actually load the block groups
> +$XFS_IO_PROG -fc "pwrite -q 0 $large" $f.large.2
> +sync
> +
> +post=$(sysfs_size_classes)
> +diff <(echo $pre) <(echo $post)
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/283.out b/tests/btrfs/283.out
> new file mode 100644
> index 00000000..efb2c583
> --- /dev/null
> +++ b/tests/btrfs/283.out
> @@ -0,0 +1,2 @@
> +QA output created by 283
> +Silence is golden
> --
> 2.39.1
>
