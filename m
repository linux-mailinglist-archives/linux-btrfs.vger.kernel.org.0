Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111D664EA03
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 12:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLPLLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 06:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLPLLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 06:11:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3141DE02F;
        Fri, 16 Dec 2022 03:11:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 743BE62069;
        Fri, 16 Dec 2022 11:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19DEC433EF;
        Fri, 16 Dec 2022 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671189063;
        bh=VkPYQwmuEvl6Tt/hUcGzmhNbi4CuQ9bEwdH7yFzUlFI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LEjOBL4qx86zMyz99dDS2RkovbsN1Cqfmr5T4FxDJpF3zKakIxFK2GYpg6mOiVgoa
         K+HzQ9FcjBv7hFwQtZzNfY1Iwa53RMsPRiP2QPrC/NK7rfoMjLrW8aAFRpnhcCvVj/
         r9YsXN8zCD87An0sSOgg1jKCznWlgjTfFle8GEDQ+tJ2feuG0lFgk0zLs/Iw9lrlXN
         y4TM96H1Af8xULclMLH4P0gS5V4y9NBIXOyjLvSZ4LEdohV7j5VKHr3HZmacXlQygZ
         67n0kjDnvcyLwe4iTQOW9dG/ZaVDY5S0byn/up3OuQe/uScR7tJgkNjV3Xh03lpEVG
         RDhMvSpJEqIIg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-144b21f5e5fso2781967fac.12;
        Fri, 16 Dec 2022 03:11:03 -0800 (PST)
X-Gm-Message-State: AFqh2ko5IJnaDiYPC9vhprWrVxaPp21ZVn7w0uOzlZNMzqVB112wPU/h
        Tqh89d2jRqUiSh3vEoHzwaix+TETWXuxjnqodfY=
X-Google-Smtp-Source: AMrXdXvz66vZ73BK//Lq5cY03axVzBOfdDCo3nHqXGbReZ6nWsxZwpaYvt4uiIWMXMEPDVkyzTpUlWdSUANvF5atWng=
X-Received: by 2002:a05:6870:d0f:b0:144:6d8b:c318 with SMTP id
 mk15-20020a0568700d0f00b001446d8bc318mr949877oab.98.1671189062873; Fri, 16
 Dec 2022 03:11:02 -0800 (PST)
MIME-Version: 1.0
References: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
In-Reply-To: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 16 Dec 2022 11:10:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H53SBc1uy8MAqAa0kTUxFPbPw8TqBcdunPQpNL70Q_5UQ@mail.gmail.com>
Message-ID: <CAL3q7H53SBc1uy8MAqAa0kTUxFPbPw8TqBcdunPQpNL70Q_5UQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: new test for logical inode resolution panic
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 14, 2022 at 11:15 PM Boris Burkov <boris@bur.io> wrote:
>
> If we create a file that has an inline extent followed by a prealloc
> extent, then attempt to use the logical to inode ioctl on the prealloc
> extent, but in the overwritten range, backref resolution will process
> the inline extent. Depending on the leaf eb layout, this can panic.
> Add a new test for this condition. In the long run, we can add spew when
> we read out-of-bounds fields of inline extent items and simplify this
> test to look for dmesg warnings rather than trying to force a fairly
> fragile panic (dependent on non-standardized details of leaf layout).
>
> The test causes a kernel panic unless:
> btrfs: fix logical_ino ioctl panic
> is applied to the kernel.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

So in addition to feedback already received from David and Zorro, I
have some comments inlined below.

> ---
>  tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/279.out |  2 +
>  2 files changed, 97 insertions(+)
>  create mode 100755 tests/btrfs/279
>  create mode 100644 tests/btrfs/279.out
>
> diff --git a/tests/btrfs/279 b/tests/btrfs/279
> new file mode 100755
> index 00000000..ef77f84b
> --- /dev/null
> +++ b/tests/btrfs/279
> @@ -0,0 +1,95 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 279
> +#
> +# Given a file with extents:
> +# [0 : 4096) (inline)
> +# [4096 : N] (prealloc)
> +# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
> +# non-inline extent, it results in reading the offset field of the inline
> +# extent, which is meaningless (it is full of user data..). If we are
> +# particularly lucky, it can be past the end of the extent buffer, resulting in
> +# a crash.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/dmlogwrites
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "falloc"

Here it should be:

_require_xfs_io_command "falloc" "-k"

> +_require_xfs_io_command "fsync"
> +_require_xfs_io_command "pwrite"

This is the first time I'm seeing a test requiring xfs_io to support
the pwrite and fsync commands.
Presumably there aren't any because either these commands always
existed or they have been around for a very long time.

> +
> +dump_tree() {
> +       $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
> +}
> +
> +get_extent_data() {
> +       local ino=$1
> +       dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
> +}
> +
> +get_prealloc_offset() {
> +       local ino=$1
> +       get_extent_data $ino | grep "disk byte" | awk '{print $5}'

In fstests we use $AWK_PROG instead of bare 'awk'.

> +}
> +
> +# This test needs to create conditions s.t. the special inode's inline extent
> +# is the first item in a leaf. Therefore, fix a leaf size and add
> +# items that are otherwise not necessary to reproduce the inline-prealloc
> +# condition to get to such a state.
> +#
> +# Roughly, the idea for getting the right item fill is to:
> +# 1. create an extra file with a variable sized inline extent item
> +# 2. create our evil file that will cause the panic
> +# 3. create a whole bunch of files to create a bunch of dir/index items
> +# 4. size the variable extent item s.t. the evil extent item is item 0 in the
> +#    next leaf
> +#
> +# We do it in this somewhat convoluted way because the dir and index items all
> +# come before any inode, inode_ref, or extent_data items. So we can predictably
> +# create a bunch of them, then sneak in a funny sized extent to round out the
> +# difference.
> +
> +_scratch_mkfs "--nodesize 16k" >/dev/null

So this will fail on a machine with a 64K page size (PPC for e.g.)
using a kernel or btrfs-progs without subpage sector size support.
That will make mkfs output an error to stderr and cause the test to fail.

Please use a 64K node size and adapt the number of files below so that
we get the problematic leaf layout to trigger
the bug.

Like this the test will be able to run, and reproduce the bug on an
unpatched kernel, on machines with any page size
and on kernels without subpage sector size support (thinking of SLE
kernels for example).

That's generally what we do when we need to exercise a particular leaf
layout and allow the test to run on machines
with any page size. For example btrfs/239 and btrfs/154 do this.

> +_scratch_mount
> +
> +f=$SCRATCH_MNT/f
> +
> +# the variable extra "leaf padding" file
> +$XFS_IO_PROG -fc "pwrite -q 0 700" $f.pad
> +
> +# the evil file with an inline extent followed by a prealloc extent
> +# created by falloc with keep-size, then two non-truncating writes to the front
> +touch $f.evil
> +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +ino=$(stat -c '%i' $f.evil)
> +logical=$(get_prealloc_offset $ino)
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +sync

This is complex, and it doesn't provide any comments regarding:

1) Why all this frenzy of fsync and a final sync (which makes the last
fsync pointless)?

2) Why do we need to write twice to the range [0, 23)?

Wouldn't something more simple like this work too:

$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil

# sync to commit the transaction and make sure dump-tree sees the fs tree with
# the prealloc extent when we try to get its bytenr.
sync
ino=$(stat -c '%i' $f.evil)
logical=$(get_prealloc_offset $ino)

# Do a write that will result in an inline extent.
$XFS_IO_PROG -c "pwrite -q 0 23" $f.evil

# A bunch of inodes to stuff dir items in front of the file extent items.
for i in $(seq 122); do
     $XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
done

# Flush all dealloc so we get all the file extent items inserted in the fs tree.
sync

Please add comments about each necessary step, as I've done there.
Otherwise it's very hard to understand why those steps are needed...

I'm surprised no one commented on this before.
I'm comfortable with btrfs' internals and yet I can't understand why
there are so many steps, and what exactly each one is supposed to
accomplish.

> +
> +# a bunch of inodes to stuff dir items in front of the extent items
> +for i in $(seq 122); do
> +       $XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
> +done
> +sync
> +
> +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
> +_scratch_unmount

The unmount is pointless, fstests framework will do that for us.

Finally I would also like to see the _fixed_by_kernel_commit
annotation in the test.
Since the fix is not yet in Linus' tree, in IMO you can replace the
commit hash with "xxxx..." and later update the test once it's merged
in Linus' tree.

Thanks.

> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> new file mode 100644
> index 00000000..c5906093
> --- /dev/null
> +++ b/tests/btrfs/279.out
> @@ -0,0 +1,2 @@
> +QA output created by 279
> +Silence is golden
> --
> 2.38.1
>
