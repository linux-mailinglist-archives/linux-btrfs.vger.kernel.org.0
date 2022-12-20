Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15DE651FC2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Dec 2022 12:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLTLeA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Dec 2022 06:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLTLeA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Dec 2022 06:34:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C2B04;
        Tue, 20 Dec 2022 03:33:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6183361343;
        Tue, 20 Dec 2022 11:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A74C433D2;
        Tue, 20 Dec 2022 11:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671536037;
        bh=e4J0RZISPwzBTiddfHwQ1muQ8GQSYRAmQckxRmWT/A0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WRhqkEOHiUjhN5ounvlKJQmjuSblQX9hFVGMsJf3eS8huUkFqVgzmR70WHZwJoQN/
         n0r92JLlDBuIiEvnSG3biUo3k6ftXdk3Q+ZmsxV9DJBCuyNaqb2W3rO18M1xbTIPfb
         WcJW7hp1AR6gHEjoph10cIDLsGX16Jm67UTuz6CyZzfiSeTDBcFAZVxOJGiQD/Vgwg
         jrx69jNaCOENis1ubmP53oRDXfOl64K03cib+lDhKU5XCiyY02DizLM+SmVVwtBzDV
         bgmWAEBKqwHdKCjTbO16bLXiy99eBPm71n/y+vjt8ZChm3Cy1KlVccvlqRSD4vm0b3
         SFCMsTo0LgeOg==
Received: by mail-ot1-f50.google.com with SMTP id l8-20020a056830054800b006705fd35eceso6960879otb.12;
        Tue, 20 Dec 2022 03:33:57 -0800 (PST)
X-Gm-Message-State: ANoB5pkIQgUe7+cJv7ycJRDlfqevOYFo2/VsCGVtUQGMH1aEGIw3x8C0
        go0EfnUrH1p7E3ea04EuvFMWLVglwqI0R2k4NqY=
X-Google-Smtp-Source: AA0mqf7yDXzS495hE58O9b6GSZSRBlwpC348mrcv+tYcOVMG8nhGO/PuOBZOmbEv6lA+YI9prZm88pAluB4mXK0sFxg=
X-Received: by 2002:a9d:6858:0:b0:670:9502:cc87 with SMTP id
 c24-20020a9d6858000000b006709502cc87mr2340271oto.363.1671536036882; Tue, 20
 Dec 2022 03:33:56 -0800 (PST)
MIME-Version: 1.0
References: <4d2045a13be9bb2931c4755aa4b558c60f698f78.1671481303.git.boris@bur.io>
In-Reply-To: <4d2045a13be9bb2931c4755aa4b558c60f698f78.1671481303.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 20 Dec 2022 11:33:20 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4zyxnXDE8_ez3jKJs-ap1U5MGq67TD5-eM=Kj_=MB9Dg@mail.gmail.com>
Message-ID: <CAL3q7H4zyxnXDE8_ez3jKJs-ap1U5MGq67TD5-eM=Kj_=MB9Dg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: new test for logical inode resolution panic
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

On Mon, Dec 19, 2022 at 8:28 PM Boris Burkov <boris@bur.io> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> Changes for V2:
> - move to btrfs/299
> - change to 64k extent buffers
> - improve comments
> - cut down on unneeded fsyncs
> - various cleanups to requires/includes
>
>  tests/btrfs/299     | 103 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/299.out |   2 +
>  2 files changed, 105 insertions(+)
>  create mode 100755 tests/btrfs/299
>  create mode 100644 tests/btrfs/299.out
>
> diff --git a/tests/btrfs/299 b/tests/btrfs/299
> new file mode 100755
> index 00000000..42a08317
> --- /dev/null
> +++ b/tests/btrfs/299
> @@ -0,0 +1,103 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 299
> +#
> +# Given a file with extents:
> +# [0 : 4096) (inline)
> +# [4096 : N] (prealloc)
> +# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
> +# non-inline extent, it results in reading the offset field of the inline
> +# extent, which is meaningless (it is full of user data..). If we are
> +# particularly lucky, it can be past the end of the extent buffer, resulting in
> +# a crash. This test creates that circumstance and asserts that logical inode
> +# resolution is still successful.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick preallocrw
> +
> +# real QA test starts here
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "falloc" "-k"
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_command inspect-internal logical-resolve
> +_fixed_by_kernel_commit xxxxxxxx "btrfs: fix logical_ino ioctl panic"
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
> +       get_extent_data $ino | grep "disk byte" | $AWK_PROG '{print $5}'
> +}
> +
> +# This test needs to create conditions s.t. the special inode's inline extent
> +# is the first item in a leaf. Therefore, fix a leaf size and add
> +# items that are otherwise not necessary to reproduce the inline-prealloc
> +# condition to get to such a state.
> +#
> +# Roughly, the idea for getting the right item fill is to:
> +# 1. create extra inline items to cause leaf splitting.
> +# 2. put the target item in the middle so it is likely to catch the split
> +# 3. add an extra variable inline item to tweak any final adjustments
> +#
> +# It took a bit of trial and error to hit working counts of inline items, since
> +# it also had to account for dir and index items all going to the front.
> +
> +# use a 64k nodesize so that an fs with 64k pages and no subpage sector size
> +# support will correctly reproduce the problem.
> +_scratch_mkfs "--nodesize 64k" >> $seqres.full || _fail "mkfs failed"
> +_scratch_mount
> +
> +f=$SCRATCH_MNT/f
> +# write extra files before the evil file to use up the leaf and
> +# help trick leaf balancing
> +for i in {1..41}; do
> +       $XFS_IO_PROG -fc "pwrite -q 0 1024" $f.inl.$i
> +done
> +
> +# write a variable inline file to help pad the preceeding leaf
> +$XFS_IO_PROG -fc "pwrite -q 0 1" $f.inl-var.$i
> +
> +# falloc the evil file whose inline extent will start a leaf
> +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +
> +# write extra files after the evil file to use up the leaf and
> +# help trick leaf balancing
> +for i in {1..42}; do
> +       $XFS_IO_PROG -fc "pwrite -q 0 1024" $f.inl.2.$i
> +done
> +
> +# grab the prealloc offset from dump tree while it's still the only
> +# extent data item for the inode
> +ino=$(stat -c '%i' $f.evil)
> +logical=$(get_prealloc_offset $ino)
> +
> +# do the "small write; fsync; small write" pattern which reproduces the desired
> +# item pattern of an inline extent followed by a preallocated extent. The 23
> +# size is somewhat arbitrary, but ensures that the offset field is past the eb
> +# when we are item 0 (borrowed from the actual crash this reproduces).
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +$XFS_IO_PROG -fc fsync $f.evil
> +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> +
> +# ensure we have all the extent_data items for when we do logical to inode
> +# resolution
> +sync
> +
> +# trigger the backref walk which accesses the bad inline extent
> +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/299.out b/tests/btrfs/299.out
> new file mode 100644
> index 00000000..0fcc0304
> --- /dev/null
> +++ b/tests/btrfs/299.out
> @@ -0,0 +1,2 @@
> +QA output created by 299
> +Silence is golden
> --
> 2.38.1
>
