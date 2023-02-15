Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D20698794
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 22:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBOV6q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 16:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBOV6p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 16:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F87A81;
        Wed, 15 Feb 2023 13:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D284B823D7;
        Wed, 15 Feb 2023 21:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC6FC433D2;
        Wed, 15 Feb 2023 21:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676498321;
        bh=VNwb7ZC/CeFkIlb+LNzcr8n251uC4XSICBzs7XmzxjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxnLmmAfpXrrHEJHdRu29PFCaChI4nV3UHR+jZHass3wMW5WFod/0dz0MhP8oCdI/
         RAhSNwco/460Fvl/ewu3cJdbK+D6pi9f9xUeDikieepnGHBDD1coazH0qi1i2Yt/0x
         4ldENXc0BOONNVyno+XqiwMvmVsZgU2QOhEuDvnL0+WZnL05GuFhxN+GGgPmf1XwWd
         C7gFU9naO/NZKmk3BClw2IrewgpdLROqe3Xk2bbJqVBnIF45workZ4kbhtchTdgq3F
         1bH3oTYOq6VwGt1ZGObk/UwJkIsEzi9EGm1cETg+w4j4SMA6clkbLTVf0nvQ3s9OZY
         rUS5bkHCJgENg==
Received: by mail-oi1-f171.google.com with SMTP id bd6so17129701oib.6;
        Wed, 15 Feb 2023 13:58:41 -0800 (PST)
X-Gm-Message-State: AO0yUKVYkUHoWE5VmIkSvCeEuBGMOcMTi8HL2gmAs1Aq2B9jtiNWhZVW
        7I2UQSP2kAgXlT8rmiStnidCXj/jgS2UujF1g4U=
X-Google-Smtp-Source: AK7set89WbjIZPuf+ixvTxqclTMZeuIURue5csXnxX20/BQv2JrYE1dQZyqFmqVUDzlfNke63lGIpcu9isGv9y+K8GE=
X-Received: by 2002:a05:6808:2394:b0:37d:5e52:6844 with SMTP id
 bp20-20020a056808239400b0037d5e526844mr5401oib.98.1676498320367; Wed, 15 Feb
 2023 13:58:40 -0800 (PST)
MIME-Version: 1.0
References: <fa66499531a46105f295af0f29d9fc253f361d78.1676495310.git.boris@bur.io>
In-Reply-To: <fa66499531a46105f295af0f29d9fc253f361d78.1676495310.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 15 Feb 2023 21:58:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5GoVDhbah5DWBbC0gicvEtqjdYNBAo_OyHhajeppRJ3A@mail.gmail.com>
Message-ID: <CAL3q7H5GoVDhbah5DWBbC0gicvEtqjdYNBAo_OyHhajeppRJ3A@mail.gmail.com>
Subject: Re: [PATCH v5] btrfs: test block group size class loading logic
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 9:15 PM Boris Burkov <boris@bur.io> wrote:
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
> v5:
> Instead of using _fixed_by_kernel_commit, use require_fs_sysfs to handle
> the needed sysfs file. The test is skipped on kernels without the file
> and runs correctly on new ones.

v5 seems exactly the same as v4 to me, and my comments on v4 still stand:

https://lore.kernel.org/fstests/CAL3q7H4Uc2=nZxCRkzMSd9DOH8DpsT1Lmac0mfXNDyS+7Vio7w@mail.gmail.com/T/#m1f000df64a2dd73d5f4a2fdf7722649949d4aaa9

Thanks.

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
> +_fixed_by_kernel_commit xxxxxxxx "btrfs: add size class stats to sysfs".
> +
> +sysfs_size_classes() {
> +       local uuid="$(findmnt -n -o UUID "$SCRATCH_MNT")"
> +       cat "/sys/fs/btrfs/$uuid/allocation/data/size_classes"
> +}
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_fs_sysfs
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
