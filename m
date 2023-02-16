Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5606999E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjBPQYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBPQYD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:24:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9996E3D92C;
        Thu, 16 Feb 2023 08:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39C53B8273D;
        Thu, 16 Feb 2023 16:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C42C4339B;
        Thu, 16 Feb 2023 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676564637;
        bh=qG9aT9Wrvd6So23bKWjivbNAzV0b+QMUihLhTO1c44M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IM+oRAO/YDFu/bJaR+EFaClmNttKNyDUgcLL/GM0zqVBbiu+e1ilspwCjEg7aQmAe
         1BX4KGX7IZ/EwjokVMJ3x1gwwyzf/oRX/jZqixECBqRAIyyhMlAncFfnrvtXlDwZ2a
         A3/PSd3aN+ry+k6+9S4ZFsKA7kwQ5C54zMhOLksJu+G/MrMxTmEHxy4wYwX5a8GE2Z
         oyq9etcoIFKI+z8UkfndL+CVCVV56ECnEsDRLDT+eTjuB36I+DQeAy1aUMm+2MkdbV
         tkRV4+Tj3oU6UwmAc6wCUCHmbZv46mIpjlxG778NCfUcVM51GD3uQup3aTcXM4Rdey
         +/mqbTRXBRzjA==
Received: by mail-oi1-f174.google.com with SMTP id bd6so2171788oib.6;
        Thu, 16 Feb 2023 08:23:56 -0800 (PST)
X-Gm-Message-State: AO0yUKVupp0QVvGv7fvQ1fYPzkteoxLdWX6NnxNntQJ0ad5OlIao0RSR
        1mh6bZPyliA8sgr1FcYvzLgWyA7gKijvNW/wWO0=
X-Google-Smtp-Source: AK7set+JYU3OT7RsAOpGMcou87JeqfYghePDx8FX+ptSWBcbr2n4HefKRfKKbx8sQJ61+q5p1U9sM9mHcja1YgxsdXk=
X-Received: by 2002:a05:6808:2394:b0:37d:5e52:6844 with SMTP id
 bp20-20020a056808239400b0037d5e526844mr216584oib.98.1676564636099; Thu, 16
 Feb 2023 08:23:56 -0800 (PST)
MIME-Version: 1.0
References: <a5d8e8988d8ea9c8ee81a96c69566a112527dccd.1676562365.git.boris@bur.io>
In-Reply-To: <a5d8e8988d8ea9c8ee81a96c69566a112527dccd.1676562365.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 Feb 2023 16:23:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7a_F1GMsFgmcL0cbsE1EVi8-asScYHD3C-9NiHC-p5+A@mail.gmail.com>
Message-ID: <CAL3q7H7a_F1GMsFgmcL0cbsE1EVi8-asScYHD3C-9NiHC-p5+A@mail.gmail.com>
Subject: Re: [PATCH v7] btrfs: test block group size class loading logic
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

On Thu, Feb 16, 2023 at 3:54 PM Boris Burkov <boris@bur.io> wrote:
>
> Add a new test which checks that size classes in freshly loaded block
> groups after a cycle mount match size classes before going down
>
> Depends on the kernel patch:
> btrfs: add size class stats to sysfs
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me now, thanks.

> ---
> Changelog:
> v7:
> Rebase, move to btrfs/284.
> Remove mount test group.
> v6:
> Actually include changes for v5 in the commit.
> v5:
> Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> the needed sysfs file. The test is skipped on kernels without the file
> and runs correctly on new ones.
> v4:
> Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
> copy+pasting). Re-tested happy and sad case...
> v3:
> Re-add fixed_by_kernel_commit, but for the stats patch which is
> required, but not a fix in the strictest sense.
> v2:
> Drop the fixed_by_kernel_commit since the fix is not out past the btrfs
> development tree, so the fix is getting rolled in to the original broken
> commit. Modified the commit message to note the dependency on the new
> sysfs counters.
>
>  tests/btrfs/284     | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/284.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/btrfs/284
>  create mode 100644 tests/btrfs/284.out
>
> diff --git a/tests/btrfs/284 b/tests/btrfs/284
> new file mode 100755
> index 00000000..340b3cd9
> --- /dev/null
> +++ b/tests/btrfs/284
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 284
> +#
> +# Test that mounting a btrfs filesystem properly loads block group size classes.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +sysfs_size_classes() {
> +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> +}
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_fs_sysfs
> +_require_fs_sysfs allocation/data/size_classes
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
> diff --git a/tests/btrfs/284.out b/tests/btrfs/284.out
> new file mode 100644
> index 00000000..931839fe
> --- /dev/null
> +++ b/tests/btrfs/284.out
> @@ -0,0 +1,2 @@
> +QA output created by 284
> +Silence is golden
> --
> 2.39.1
>
