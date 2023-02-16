Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151BD6993F6
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 13:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBPMMV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 07:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjBPMMU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 07:12:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E127355E5A;
        Thu, 16 Feb 2023 04:12:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90211B8272A;
        Thu, 16 Feb 2023 12:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFABC4339B;
        Thu, 16 Feb 2023 12:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676549536;
        bh=nw3pJCjnIROuGxw+k9KwhkO81lcnyQJc4+iT2eJC/sw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uGgTiQse+9hqkSlJeANUh4g3stusNcFiI778416rBmgXkIrCkXVQiVucbloTYmoYN
         4vPPn1oL9MXVRehkKjGI+3xBq0ZjXZHwLlNoEkV8i+8Q5NlBqa6ulgl4VRzS0Ee6f3
         jBzFyFkwffgDzU5GRETr1T8GS8+CcaRw0ig26+7fENhoy1GS3YTLcfpV1+djeZWttJ
         toJCzSkbX6zcHabvM5zS5VpAUzwPyt6mIhkPqGV+OxVTcJe7oF8E9Kg+B50Dhq57eU
         4V/UGoJYcVhHTvoOIAtFA53Cw6PGyUvO6AgzWRRjhozvJtm5foU7haN/OnEk9L4GM6
         VWTN5csZ4kPEA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-16e2c22c3baso2268964fac.8;
        Thu, 16 Feb 2023 04:12:16 -0800 (PST)
X-Gm-Message-State: AO0yUKUuUrASx/MYVUxgl6pMl6Bx0oQ7gaRXnkuPv4b/ej4oBSseLWyZ
        lGMfFF7tFISN+KAeblxfNxg5hgFQkJaATQ4b/d0=
X-Google-Smtp-Source: AK7set/9s6I5FIll7EHrTgxvmWyK5RJsMg/7LFPk5Inw8O/IY9GlLrfnaaso/KGxPQzgUYFAphmEIcCg272qOxXz+jc=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr174759oac.98.1676549535358; Thu, 16 Feb
 2023 04:12:15 -0800 (PST)
MIME-Version: 1.0
References: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
In-Reply-To: <160e7557f66a6a34fd052d6834909aa02a702956.1676503163.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 16 Feb 2023 12:11:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
Message-ID: <CAL3q7H42GK2xu9ZSAKiDUG8ZRJzgudk-3DHE9f95Sqwc0iPKyQ@mail.gmail.com>
Subject: Re: [PATCH v6] btrfs: test block group size class loading logic
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

On Wed, Feb 15, 2023 at 11:37 PM Boris Burkov <boris@bur.io> wrote:
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
> v6:
> Actually include changes for v5 in the commit.
> v5:
> Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> the needed sysfs file. The test is skipped on kernels without the file
> and runs correctly on new ones.
> v4:
> Fix dumb typo in _fixed_by_kernel_commit (left out leading underscore
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
> index 00000000..2c26b41e
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

I'm still curious why the 'mount' group, and I've asked for that before.

We aren't testing a new mount option, so it feels weird for me.

Otherwise, it looks fine now. Thanks.

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
