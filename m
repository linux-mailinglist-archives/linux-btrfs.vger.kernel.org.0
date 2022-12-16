Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA164F392
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 22:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLPV5S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Dec 2022 16:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLPV5B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Dec 2022 16:57:01 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA23B12AC4;
        Fri, 16 Dec 2022 13:56:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C2325C0091;
        Fri, 16 Dec 2022 16:56:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Dec 2022 16:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1671227810; x=1671314210; bh=tDSIKMJKuo
        jqQXcRj7p8gKp9ncgmPbgw9LV1Ebux+mc=; b=VTWNnVTrDQRuQsSrN3jTy0XKb/
        nh9e64lFqSg3Vv/JAqjzKIir9Y+DY1e2yEjqSBv1wpOxtvW4XBPhDvBJvAKFk+S8
        mNLCkwoxyv3osZxiO9/ioOZBZ38yO4ZcQxmzFA81r259gZqBAsXwnEGNe5+8a4bh
        wE7HNwyMIOZ9Zpu+wteY2EgVMeQ0+3NNQlct+BQL3o+JO8UbbJTp7lYAnaVI8O7V
        3wSFO79OeZrvJcm3WzWPIBlpmGG8F4K3Spu6Zv3NlG9CP4VDcCCO5eUFYQDnvKq6
        bCuY4yAfR85Oq8swlMyLLtVfYHlZxhX1elwyZ8Kl9h9jM5lTEaWGlAsozZJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671227810; x=1671314210; bh=tDSIKMJKuojqQXcRj7p8gKp9ncgm
        Pbgw9LV1Ebux+mc=; b=tSFJmYaZcep9mGNHM3uP+EbMfZ5jhjfKE0OuA1jCxlvV
        AifbY/zhNUEYH9i5/M+Mxs7wmZ+cK9QXWVEQKN1Cuu3wTb0E+RixLofHnolvinaa
        rrJIMN0GlVzgILD+VVkzIS0GMIzCo5FwFbCN3MT71bZ75rdnah2earOEBJKRNhOb
        3s3No3sy4LXp2joP2etKecPsehTD1OMywNJz8f+NvxWOsnCTien7q1WwqZ0yTMiF
        wayv6ayrGmnsd2vga88gpGpepJAAkkbr3JaiEG6OhXZQxl4TXqBv9/N5imQ5n4PP
        MjNpxVCPWPGwC31qbk3N9t9VppXweYXBlHoJGIQRkg==
X-ME-Sender: <xms:oumcYz1EnC8pq8Ock2usL6CWqa4KAGSSoXUn33-ox76ktXs6G1NuJQ>
    <xme:oumcYyH4CcGBLfIAcy6QgNCFCBWA63YlADr3_pdrcRpDsGIVrEOGFHDM7ytTD1XwO
    Xs64uNQXHDXVvu0VOk>
X-ME-Received: <xmr:oumcYz6k-HkNu9SZy4IwFezu61l53XPNN1c-cBsJDjD74vmdFgXm_JfVKkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdduheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:oumcY40OecT4QwCAENXeE1pD6OVJmEK62MUELZb02yGd4oVKNGMJKw>
    <xmx:oumcY2Gk3VbuQEDhEa-0DLTzKrZJ61EilEVabs-tHBV-e3m4DQW_NQ>
    <xmx:oumcY5-_YEZTGWmNsNG6XEXHDaNE-xClqVkQsIBzUCZCA4KO99diQw>
    <xmx:oumcY7R8epkqb-GsRdvRbJuECjZcxsqBQZgfs4ojw974525nZ90zfg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Dec 2022 16:56:49 -0500 (EST)
Date:   Fri, 16 Dec 2022 13:56:43 -0800
From:   Boris Burkov <boris@bur.io>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] btrfs: new test for logical inode resolution panic
Message-ID: <Y5zpmxGWKrKpRpog@devvm9258.prn0.facebook.com>
References: <98d2055515cd765b0835a7f751a21cbb72c03621.1671059406.git.boris@bur.io>
 <CAL3q7H53SBc1uy8MAqAa0kTUxFPbPw8TqBcdunPQpNL70Q_5UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H53SBc1uy8MAqAa0kTUxFPbPw8TqBcdunPQpNL70Q_5UQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 16, 2022 at 11:10:26AM +0000, Filipe Manana wrote:
> On Wed, Dec 14, 2022 at 11:15 PM Boris Burkov <boris@bur.io> wrote:
> >
> > If we create a file that has an inline extent followed by a prealloc
> > extent, then attempt to use the logical to inode ioctl on the prealloc
> > extent, but in the overwritten range, backref resolution will process
> > the inline extent. Depending on the leaf eb layout, this can panic.
> > Add a new test for this condition. In the long run, we can add spew when
> > we read out-of-bounds fields of inline extent items and simplify this
> > test to look for dmesg warnings rather than trying to force a fairly
> > fragile panic (dependent on non-standardized details of leaf layout).
> >
> > The test causes a kernel panic unless:
> > btrfs: fix logical_ino ioctl panic
> > is applied to the kernel.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> So in addition to feedback already received from David and Zorro, I
> have some comments inlined below.
> 
> > ---
> >  tests/btrfs/279     | 95 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/279.out |  2 +
> >  2 files changed, 97 insertions(+)
> >  create mode 100755 tests/btrfs/279
> >  create mode 100644 tests/btrfs/279.out
> >
> > diff --git a/tests/btrfs/279 b/tests/btrfs/279
> > new file mode 100755
> > index 00000000..ef77f84b
> > --- /dev/null
> > +++ b/tests/btrfs/279
> > @@ -0,0 +1,95 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 279
> > +#
> > +# Given a file with extents:
> > +# [0 : 4096) (inline)
> > +# [4096 : N] (prealloc)
> > +# if a user uses the ioctl BTRFS_IOC_LOGICAL_INO[_V2] asking for the file of the
> > +# non-inline extent, it results in reading the offset field of the inline
> > +# extent, which is meaningless (it is full of user data..). If we are
> > +# particularly lucky, it can be past the end of the extent buffer, resulting in
> > +# a crash.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/dmlogwrites
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_require_scratch
> > +_require_xfs_io_command "falloc"
> 
> Here it should be:
> 
> _require_xfs_io_command "falloc" "-k"
> 
> > +_require_xfs_io_command "fsync"
> > +_require_xfs_io_command "pwrite"
> 
> This is the first time I'm seeing a test requiring xfs_io to support
> the pwrite and fsync commands.
> Presumably there aren't any because either these commands always
> existed or they have been around for a very long time.
> 
> > +
> > +dump_tree() {
> > +       $BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV
> > +}
> > +
> > +get_extent_data() {
> > +       local ino=$1
> > +       dump_tree $SCRATCH_DEV | grep -A4 "($ino EXTENT_DATA "
> > +}
> > +
> > +get_prealloc_offset() {
> > +       local ino=$1
> > +       get_extent_data $ino | grep "disk byte" | awk '{print $5}'
> 
> In fstests we use $AWK_PROG instead of bare 'awk'.
> 
> > +}
> > +
> > +# This test needs to create conditions s.t. the special inode's inline extent
> > +# is the first item in a leaf. Therefore, fix a leaf size and add
> > +# items that are otherwise not necessary to reproduce the inline-prealloc
> > +# condition to get to such a state.
> > +#
> > +# Roughly, the idea for getting the right item fill is to:
> > +# 1. create an extra file with a variable sized inline extent item
> > +# 2. create our evil file that will cause the panic
> > +# 3. create a whole bunch of files to create a bunch of dir/index items
> > +# 4. size the variable extent item s.t. the evil extent item is item 0 in the
> > +#    next leaf
> > +#
> > +# We do it in this somewhat convoluted way because the dir and index items all
> > +# come before any inode, inode_ref, or extent_data items. So we can predictably
> > +# create a bunch of them, then sneak in a funny sized extent to round out the
> > +# difference.
> > +
> > +_scratch_mkfs "--nodesize 16k" >/dev/null
> 
> So this will fail on a machine with a 64K page size (PPC for e.g.)
> using a kernel or btrfs-progs without subpage sector size support.
> That will make mkfs output an error to stderr and cause the test to fail.
> 
> Please use a 64K node size and adapt the number of files below so that
> we get the problematic leaf layout to trigger
> the bug.
> 
> Like this the test will be able to run, and reproduce the bug on an
> unpatched kernel, on machines with any page size
> and on kernels without subpage sector size support (thinking of SLE
> kernels for example).
> 
> That's generally what we do when we need to exercise a particular leaf
> layout and allow the test to run on machines
> with any page size. For example btrfs/239 and btrfs/154 do this.

Good point, I'll re-do it for 64k to make it fully general as that
was my intent in setting a fixed nodesize.

> 
> > +_scratch_mount
> > +
> > +f=$SCRATCH_MNT/f
> > +
> > +# the variable extra "leaf padding" file
> > +$XFS_IO_PROG -fc "pwrite -q 0 700" $f.pad
> > +
> > +# the evil file with an inline extent followed by a prealloc extent
> > +# created by falloc with keep-size, then two non-truncating writes to the front
> > +touch $f.evil
> > +$XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> > +$XFS_IO_PROG -fc fsync $f.evil
> > +ino=$(stat -c '%i' $f.evil)
> > +logical=$(get_prealloc_offset $ino)
> > +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> > +$XFS_IO_PROG -fc fsync $f.evil
> > +$XFS_IO_PROG -fc "pwrite -q 0 23" $f.evil
> > +$XFS_IO_PROG -fc fsync $f.evil
> > +sync
> 
> This is complex, and it doesn't provide any comments regarding:
> 
> 1) Why all this frenzy of fsync and a final sync (which makes the last
> fsync pointless)?
> 
> 2) Why do we need to write twice to the range [0, 23)?

Honestly, I'm not sure. A single write results in a regular extent while
two (separated by an fsync) results in an inline extent. Since we don't
consider the inline extent a bug (which I inferred from I think your
previous discussion with Qu for a similar case), I didn't prioritize
digging into that behavior while working on this fix/test.

> 
> Wouldn't something more simple like this work too:
> 
> $XFS_IO_PROG -fc "falloc -k 0 1m" $f.evil
> 
> # sync to commit the transaction and make sure dump-tree sees the fs tree with
> # the prealloc extent when we try to get its bytenr.
> sync
> ino=$(stat -c '%i' $f.evil)
> logical=$(get_prealloc_offset $ino)
> 
> # Do a write that will result in an inline extent.
> $XFS_IO_PROG -c "pwrite -q 0 23" $f.evil
> 
> # A bunch of inodes to stuff dir items in front of the file extent items.
> for i in $(seq 122); do
>      $XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
> done
> 
> # Flush all dealloc so we get all the file extent items inserted in the fs tree.
> sync
> 
> Please add comments about each necessary step, as I've done there.
> Otherwise it's very hard to understand why those steps are needed...
> 
> I'm surprised no one commented on this before.
> I'm comfortable with btrfs' internals and yet I can't understand why
> there are so many steps, and what exactly each one is supposed to
> accomplish.

I like fstests having a literate style, so I'm happy to do this, but I
must point out that it's far from universal in the repo...

> 
> > +
> > +# a bunch of inodes to stuff dir items in front of the extent items
> > +for i in $(seq 122); do
> > +       $XFS_IO_PROG -fc "pwrite -q 0 8192" $f.$i
> > +done
> > +sync
> > +
> > +btrfs inspect-internal logical-resolve $logical $SCRATCH_MNT | _filter_scratch
> > +_scratch_unmount
> 
> The unmount is pointless, fstests framework will do that for us.
> 
> Finally I would also like to see the _fixed_by_kernel_commit
> annotation in the test.
> Since the fix is not yet in Linus' tree, in IMO you can replace the
> commit hash with "xxxx..." and later update the test once it's merged
> in Linus' tree.
> 
> Thanks.

Thanks for the review.
> 
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/279.out b/tests/btrfs/279.out
> > new file mode 100644
> > index 00000000..c5906093
> > --- /dev/null
> > +++ b/tests/btrfs/279.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 279
> > +Silence is golden
> > --
> > 2.38.1
> >
