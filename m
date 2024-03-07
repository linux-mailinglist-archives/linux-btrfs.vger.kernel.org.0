Return-Path: <linux-btrfs+bounces-3080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02898758C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 21:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E306F1C21032
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Mar 2024 20:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9534213A256;
	Thu,  7 Mar 2024 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GVknZviU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PRjI8OBk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FD2376A;
	Thu,  7 Mar 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709844520; cv=none; b=LLDGvSciLOoyBXn1mjACE0S3i8OwJ+/Qwf+9qTvuxHXmq5WYQcBErtea+sOm7C7/DP7fKiC33s8fD9UXupiBGldf7Z6ITMH4aaw0O85zWCV2xNcbbnFG/jaFknUcJgOidTIR1sh2Wu+q+7I9nxufITLW0fLnttkYytgxQvlvgnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709844520; c=relaxed/simple;
	bh=O+/xdU5kdABEYqBeKDnPh9///aUE54ke2IVgXoROB9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj9qtVOjT1rHMLkcB0VZuBs8pfvr3v7pocpkeF4d3ZrRdAUZS+JjG0owna9az64xC2UozyankWyOOLmGGjcF3ReqTcvpOD0RWDsvHIv1EHYCSCIQeu0JooaviDHJSAU0WFAueOMjcpYfA732L/U6tFLxamG/l7LNbvkuLUgs3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GVknZviU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PRjI8OBk; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 207AA5C007F;
	Thu,  7 Mar 2024 15:48:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Mar 2024 15:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1709844516;
	 x=1709930916; bh=MCeuLcxS4qhKZxI+5/IHg5M1colzKBxm3ypO0OzJDQc=; b=
	GVknZviUgj2NqKrTZfEl36Od+MrK1xFe2PRRZTucXrM07A1K/xsLW+cB23Vov3lQ
	FuqWlx9O1UKzuGIpsyEP32UvSbcPXPbHikOUIdKcT5Ky+6pkyLiWNK9MKTK4KP/L
	bN1F/S6hBZFeUguhdLZSQP/oYKUE7pit9s12iwZ4hvMJy46K1wKgaupg1hFtUOH3
	OagL/HELySy/WC7vjvzXD2B7eFKpO1MO3rpFremWiAyE5OEpbt+4C2gK9HftFFPT
	yBKibuk7X1zjZTVxnKiYXZJ9CjU3kx1hlaNFRC9bxFwuv8lO4t1Wpqr+WD9OpShI
	qmCREKg1s8gkJjAjELclyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709844516; x=
	1709930916; bh=MCeuLcxS4qhKZxI+5/IHg5M1colzKBxm3ypO0OzJDQc=; b=P
	RjI8OBkrOKl2WYLQOVd3Wbqkxj0S0fbOVlyGK3twfNx+NTExaRPaYbtsplAEeUPS
	xC6AAwpmGPApDMJkz7wrUQyVCHl22YovOE2OC2kmHnUuiIuEuGBLRsx0olWYClcu
	7I6034aFo9S+ZjMYupSvlGq9WP2aE7Cc/c4EiPx8Z9RHam1pw+aeOGm1ZjmATMIr
	fi3FfJehxIlYmJJF2vAEGraVyP/NVeF9mgPMFydbB+fStIMr5/qlndccJ8pgSIJB
	XgHMuNFD/0blon9RPX9HYXtEkpW6DmmGXYohWEWFKbJmE3lNVUajiiAVDI8gEVws
	GHnFF8yE6/hzfWj6eVgIQ==
X-ME-Sender: <xms:IyjqZUOTvFcqy40bXLBNqXOfpt9GQkYYIKZ83LTKg-H63lUoIIb5DA>
    <xme:IyjqZa8BU-ttOAjSPzyM91MHqbz2ch4ApswvW6WWeEfxQVQPx_6NSmtqm83UI0a_3
    -uSgrn2oW4XolUY-HU>
X-ME-Received: <xmr:IyjqZbRJjwwMjtZzFA_gQCjzzoh4RRHId6MGmnSizi3NzLqJf37HCkcox69oOU9Sqn3-x4QLOJGFQT7kaKvVLAgwVB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieefgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epudelhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:IyjqZcuFDWT6snua4CGKsnDlNUUnJGwNz8_I1KoH14KI133fM---Sw>
    <xmx:IyjqZccdXl0DT_1W7aJ5rU2u13xhdHP_YPUuAQrTttTfcYmrrH1MJA>
    <xmx:IyjqZQ0ULtaGld8Q0LugLtglZABpar0DO5ILAY3NsgRbqhwNTjrZXQ>
    <xmx:JCjqZdp8LiE-9FCIbE3H87CsSIcD7rUcdtLYToWFV1bT3MTULfyZGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Mar 2024 15:48:35 -0500 (EST)
Date: Thu, 7 Mar 2024 12:49:36 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/311: new test for devt change between mounts
Message-ID: <20240307204936.GA2446256@zen.localdomain>
References: <f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io>
 <CAL3q7H4rYdJidxKja2YZDdXcu3NtsYhKS--YhTUHRi5OqzwijQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4rYdJidxKja2YZDdXcu3NtsYhKS--YhTUHRi5OqzwijQ@mail.gmail.com>

On Tue, Mar 05, 2024 at 12:13:07PM +0000, Filipe Manana wrote:
> On Fri, Mar 1, 2024 at 12:02 AM Boris Burkov <boris@bur.io> wrote:
> >
> > It is possible to confuse the btrfs device cache (fs_devices) by
> > starting with a multi-device filesystem, then removing and re-adding a
> > device in a way which changes its dev_t while the filesystem is
> > unmounted. After this procedure, if we remount, then we are in a funny
> > state where struct btrfs_device's "devt" field does not match the bd_dev
> > of the "bdev" field. I would say this is bad enough, as we have violated
> > a pretty clear invariant.
> >
> > But for style points, we can then remove the extra device from the fs,
> > making it a single device fs, which enables the "temp_fsid" feature,
> > which permits multiple separate mounts of different devices with the
> > same fsid. Since btrfs is confused and *thinks* there are different
> > devices (based on device->devt), it allows a second redundant mount of
> > the same device (not a bind mount!). This then allows us to corrupt the
> > original mount by doing stuff to the one that should be a bind mount.
> >
> > This is fixed by the combination of the kernel patch: > > btrfs: support device name lookup in forget
> > and the btrfs-progs patches:
> > btrfs-progs: allow btrfs device scan -u on dead dev
> > btrfs-progs: add udev rule to forget removed device
> 
> May I suggest to make this more readable, easier to the eye?
> My inserting blank lines and indenting the lines with the patch
> subjects, like for example:
> 
> """
> This is fixed by the combination of the kernel patch:
> 
>     btrfs: support device name lookup in forget
> 
> and the btrfs-progs patches:
> 
>    btrfs-progs: allow btrfs device scan -u on dead dev
>    btrfs-progs: add udev rule to forget removed device
> """
> 
> And these should be placed in the test case itself with:
> 
>    _fixed_by_git_commit btrfs-progs xxxxxxxxxx "btrfs-progs: allow
> btrfs device scan -u on dead dev"
> 
> For btrfs-progs commits, and for the kernel:
> 
>    _fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: support device name
> lookup in forget"

I'll do so going forward, thanks.

> 
> I see however that there's discussion for those patches between you,
> Anand and David, and it
> seems there's a chance those patches won't be merged to fix this bug,
> especially the kernel one
> for which Anand submitted an alternative. If those are added to the
> test case itself, can always be
> updated later if needed.

I'm leaning towards omitting this part from the commit message and we
can update the test case once we pick a winner. Is that OK with you?

> 
> Also avoid putting the test number in the subject - there's no
> guarantee it will end up with that number when merged.
> 
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  common/config       |   1 +
> >  common/rc           |   4 ++
> >  tests/btrfs/311     | 101 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/311.out |   2 +
> >  4 files changed, 108 insertions(+)
> >  create mode 100755 tests/btrfs/311
> >  create mode 100644 tests/btrfs/311.out
> >
> > diff --git a/common/config b/common/config
> > index a3b15b96f..43b517fda 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
> >  export GZIP_PROG="$(type -P gzip)"
> >  export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
> >  export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> > +export PARTED_PROG="$(type -P parted)"
> >
> >  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> >  # newer systems have udevadm command but older systems like RHEL5 don't.
> > diff --git a/common/rc b/common/rc
> > index 30c44dddd..8e009aca9 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -5375,6 +5375,10 @@ _require_unshare() {
> >                 _notrun "unshare $*: command not found, should be in util-linux"
> >  }
> >
> > +_require_parted() {
> 
> These three last functions from common/rc use that style, the { after
> the function name in the same line,
> but everywhere else the { is on a new line, and that's the most common
> style in fstests.
> I wish we had some consistency.
> 
> > +       $PARTED_PROG --list &>/dev/null || _notrun "parted: command not found"
> 
> Why not just call:
> 
> _require_command "$PARTED_PROG" parted
> 
> Could even do that in the test and no need for a common function in
> this file, as we do in many other tests
> (grep for "'_require_command'" in tests/generic for example).
> 
> > +}
> > +
> >  # Return a random file in a directory. A directory is *not* followed
> >  # recursively.
> >  _random_file() {
> > diff --git a/tests/btrfs/311 b/tests/btrfs/311
> > new file mode 100755
> > index 000000000..887c46ba0
> > --- /dev/null
> > +++ b/tests/btrfs/311
> > @@ -0,0 +1,101 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 311
> > +#
> > +# Test an edge case of multi device volume management in btrfs.
> > +# If a device changes devt between mounts of a multi device fs, we can trick
> > +# btrfs into mounting the same device twice fully (not as a bind mount). From
> > +# there, it is trivial to induce corruption.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick volume
> 
> Missing 'scrub' group.
> 
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_test
> > +_require_parted
> > +
> > +_cleanup() {
> > +       cd /
> > +       umount $MNT
> > +       umount $BIND
> > +       losetup -d $DEV0
> > +       losetup -d $DEV1
> > +       losetup -d $DEV2
> > +       rm $IMG0
> > +       rm $IMG1
> > +       rm $IMG2
> > +}
> > +
> > +IMG0=$TEST_DIR/$$.img0
> > +IMG1=$TEST_DIR/$$.img1
> > +IMG2=$TEST_DIR/$$.img2
> > +truncate -s 1G $IMG0
> > +truncate -s 1G $IMG1
> > +truncate -s 1G $IMG2
> > +DEV0=$(losetup -f $IMG0 --show)
> > +DEV1=$(losetup -f $IMG1 --show)
> > +DEV2=$(losetup -f $IMG2 --show)
> > +D0P1=$DEV0"p1"
> > +D1P1=$DEV1"p1"
> > +MNT=$TEST_DIR/mnt
> > +BIND=$TEST_DIR/bind
> > +
> > +# Setup partition table with one partition on each device.
> > +$PARTED_PROG $DEV0 'mktable gpt' --script
> > +$PARTED_PROG $DEV1 'mktable gpt' --script
> > +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> > +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> > +
> > +# mkfs with two devices to avoid clearing devices on close
> > +# single raid to allow removing DEV2.
> > +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
> 
> Please redirect to the $seqres.full instead, and _fail if mkfs fails.
> That's what we do nowadays due to unpleasant surprises in the past.
> 
> > +
> > +# Cycle mount the two device fs to populate both devices into the
> > +# stale device cache.
> > +mkdir -p $MNT
> > +mount $D0P1 $MNT
> 
> Use the _mount() helper.
> 
> > +umount $MNT
> 
> We use $UMOUNT_PROG in fstests.
> 
> > +
> > +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
> > +$PARTED_PROG $DEV0 'rm 1' --script
> > +$PARTED_PROG $DEV1 'rm 1' --script
> > +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> > +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> > +
> > +# Mount with mismatched dev_t!
> > +mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
> 
> Same here.
> 
> > +
> > +# Remove the extra device to bring temp-fsid back in the fray.
> > +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> > +
> > +# Create the would be bind mount.
> > +mkdir -p $BIND
> > +mount $D0P1 $BIND
> 
> Same here.
> 
> > +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
> > +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
> > +# If they're different, we are in trouble.
> > +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
> > +
> > +# Now really prove it by corrupting the first mount with the second.
> > +for i in $(seq 20); do
> > +       $XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >$seqres.full 2>&1
> 
> This is overriding the .full file, use >>
> 
> > +done
> > +for i in $(seq 20); do
> > +       $XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >$seqres.full 2>&1
> 
> Same here, this is overriding the .full file, use >>
> 
> > +done
> > +sync
> 
> Can we please have a comment mentioning why the sync is needed?
> 
> > +find $BIND -type f -delete
> > +sync
> 
> Same here.
> 
> > +
> > +# This should blow up both mounts, if the writes somehow didn't overlap at all.
> > +$FSTRIM_PROG $BIND
> 
> Since it's using the fstrim program and needs trim to be supported,
> the test misses a:
> 
> _require_batched_discard "$TEST_DIR"
> 
> at the top.
> 
> > +echo 3 > /proc/sys/vm/drop_caches
> 
> Please add a comment mentioning why we are dropping caches.
> 
> > +$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1
> 
> The test passes whether scrub fails or succeeds, as it's redirecting
> stdout and stderr to the .full file and ignoring the exit status of
> the command.
> 
> The ideal fstests way is to put the expected output in the golden
> output file and just call the command without redirecting anything.
> If that's not doable for some reason, at the very least do a (...) ||
> echo "Scrub failed, check $seqres.full for details."
> 
> Thanks.
> 
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> > new file mode 100644
> > index 000000000..62f253029
> > --- /dev/null
> > +++ b/tests/btrfs/311.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 311
> > +Silence is golden
> > --
> > 2.43.0
> >
> >

