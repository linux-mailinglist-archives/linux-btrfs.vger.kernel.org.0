Return-Path: <linux-btrfs+bounces-3193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9ED87887C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 20:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098221F2344A
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F054BE0;
	Mon, 11 Mar 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LqGkFXoI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UAD+w5Xn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607C3F8F6;
	Mon, 11 Mar 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183926; cv=none; b=bQ/QdA1nk4wWHsD8pBNvus57yFzpY4U02mH0qBIuMDFcwaMxY2caL7QHOO0HyouoKU+B07qHEP6C6Y8LcUg7O/gN4kwf/G0NWPQGRcIqAnYTzu2a4xz9ixjSTTWyQxrqSpTmTDtCuGffHqWWpzPSdooL4ugeMULF5vEhc5/YS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183926; c=relaxed/simple;
	bh=P+Y0b83tbczIzyPrZqG5UuKzSWfsBggHRgKw7IgoxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG9vuKd0IkiANmnIBkmtb9OSC1pW7cKmR6cuL5whbi3o2OC0fEnc9lWH0mvKglce0JjDlzxE193TKS+oRlcLJoC5d2vnRYcmCc+SRO3gURcexZ6l6fukG6Fzc1i2rXMNzFj6Qi5NhYWDZ8mridGUTV/bHiebLAsF1Ufg7qWYa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LqGkFXoI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UAD+w5Xn; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id B9AF45C0063;
	Mon, 11 Mar 2024 15:05:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 15:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710183922; x=1710270322; bh=LY2uBWhw68
	eiiovYe0bXZjT6qfh2PJ1/e7UtyzyvxoQ=; b=LqGkFXoIhD3ShUWn+1tAcxbpHU
	Ev/iflOkRwEW+w+u9D9gSunha4QlHBNsnpodn1KhnU8eaorRfzIisLAMDKsF5CX6
	+Q8dH/eJHdulsU886mtr/Zf0WQJqTN03dv2pNLtJVhNydtNaiTonDegR7tG+59AZ
	YwACsMT7yXDasOV9ndM3tNZsmkgVwk8X9E4G7jJ5O7vTfi4pWOj+UczMjdzJqanC
	ggXXrgE247MVPIquzHvMvNWPjuHcB4Q16LpHrwYYmvcmvqThMbQ09QetZVXqLqK+
	Ggf1kh7Akv4Yco7+2EeLvcApjyS4QmAxE31EtI3XwKBh91kcWZuxjHMNr4UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710183922; x=1710270322; bh=LY2uBWhw68eiiovYe0bXZjT6qfh2
	PJ1/e7UtyzyvxoQ=; b=UAD+w5XncK0Jub64j3Oe5UUUYsdhka5MIOlIVenWK3rQ
	JtrhFUp1Bc6u2AeK8D0g2r7ed2MdSNz2jBothSmucYu7Ybq/D1lUfdIMxq4XhX0q
	JDxiuwmqM7Z8XbztqYNk4OZ0Ds+fhG4e0JRu4rafsLxyKIP+QIKgZmWs5mYP1JP/
	2EF6fLinZ0GR0pYT2HQENV+cqoVBU/JkfDWbWkVd1S902N7t2H0Ck/T9Caosj1Nc
	O97+oHzUW4LM6rzc+4IsY32Z73KN7ti4LMSkSIelLKbaEulETz/cm5OUBiJdrNI2
	9apQWt7StYKS1ZOi610/0K8Dl/xaK+AJOeDKxyUv3w==
X-ME-Sender: <xms:8lXvZfMi-bAJFiuBr_WqzpiYwE_eaVYNXfiWxPaJqtR9cqVYawWCmg>
    <xme:8lXvZZ9PdGmNgtkfntXbMVgEjJreofJbcqDcYtup_j3qQzkO7FNx3JHOPOu0EZQNg
    EGXBlAmxBdURyTZfmY>
X-ME-Received: <xmr:8lXvZeQYA6YrmTa6k9EV_UjsIwDV2yoWrUz-pcvkCvX5XcP30hEQvHEAkqDsXHShIMCY5T8RjEsXVIMTmLQrNBsPCQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:8lXvZTvdwWatSkJ-RrMZktVpZ2KNnalkxyO8_rQvo7x0bBJBjP_0Sg>
    <xmx:8lXvZXf49UXBSfc-lmt_YXQDe4TVEdMGDgbygBcbtFFIiJivlOr_Tg>
    <xmx:8lXvZf1QkIdZpr3tLkAfOTVlSoP4ehsj90SIITUUDKeSzU7cL04vSA>
    <xmx:8lXvZYr9BFmHtp9Br13RU-UaHnt75J8M-cPFxYGpKuLb-VLnlhMX9w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:05:22 -0400 (EDT)
Date: Mon, 11 Mar 2024 12:06:17 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v3] btrfs: new test for devt change between mounts
Message-ID: <20240311190617.GA2738765@zen.localdomain>
References: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
 <5997ae6b-1214-4476-a75a-183e485b50b7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5997ae6b-1214-4476-a75a-183e485b50b7@oracle.com>

On Mon, Mar 11, 2024 at 10:14:15PM +0530, Anand Jain wrote:
> On 3/8/24 23:13, Boris Burkov wrote:
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
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> > Changelog:
> > v3:
> > - fstests convention improvements (helpers, output, comments, etc...)
> > v2:
> > - fix numerous fundamental issues, v1 wasn't really ready
> > 
> >   common/config       |   1 +
> >   tests/btrfs/311     | 105 ++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/311.out |   2 +
> >   3 files changed, 108 insertions(+)
> >   create mode 100755 tests/btrfs/311
> >   create mode 100644 tests/btrfs/311.out
> > 
> > diff --git a/common/config b/common/config
> > index a3b15b96f..43b517fda 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -235,6 +235,7 @@ export BLKZONE_PROG="$(type -P blkzone)"
> >   export GZIP_PROG="$(type -P gzip)"
> >   export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
> >   export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
> > +export PARTED_PROG="$(type -P parted)"
> >   # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> >   # newer systems have udevadm command but older systems like RHEL5 don't.
> > diff --git a/tests/btrfs/311 b/tests/btrfs/311
> > new file mode 100755
> > index 000000000..a7fa541c4
> > --- /dev/null
> > +++ b/tests/btrfs/311
> > @@ -0,0 +1,105 @@
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
> > +_begin_fstest auto quick volume scrub
> 
> Please add tmpfsid as well, because this test is about when not to activate
> the tmpfsid.
> 
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_test
> > +_require_command "$PARTED_PROG" parted
> > +_require_batched_discard "$TEST_DIR"
> > +
> 
> _fixed_by_kernel_commit XXXXXXXXXXXX \
> 		btrfs: validate device maj:min during open
> 
> > +_cleanup() {
> > +	cd /
> > +	$UMOUNT_PROG $MNT
> > +	$UMOUNT_PROG $BIND
> > +	losetup -d $DEV0
> > +	losetup -d $DEV1
> > +	losetup -d $DEV2
> > +	rm $IMG0
> > +	rm $IMG1
> > +	rm $IMG2
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
> > +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 || _fail "failed to mkfs.btrfs"
> 
> Error out is already sufficient here.
> 

I don't understand, but I think Filipe asked for this one.

> > +
> > +# Cycle mount the two device fs to populate both devices into the
> > +# stale device cache.
> > +mkdir -p $MNT
> > +_mount $D0P1 $MNT
> > +$UMOUNT_PROG $MNT
> > +
> > +# Swap the partition dev_ts. This leaves the dev_t in the cache out of date.
> > +$PARTED_PROG $DEV0 'rm 1' --script
> > +$PARTED_PROG $DEV1 'rm 1' --script
> > +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> > +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> > +
> > +# Mount with mismatched dev_t!
> > +_mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dangerous stuff on raw mount point"
> > +
> 
> On a system where the kernel bug is fixed, the mount is expected to pass.
> 
> On a system without the kernel bug fix, the mount is still expected to pass.
> 
> However, the failure message indicates that it is advisable to fail the
> mount in this scenario.
> 
> I believe this will be the case once the btrfs-progs patch below is
> integrated:
> 
> [PATCH 0/2] btrfs-progs: forget removed devices
> 
> So, we need to update the test case logic based on whether the above
> btrfs-progs patch is integrated.
> 
> 

The point of this was just to do our best to avoid doing a bunch of
writes/scrubbing/trimming on the fs under all the loopdevs and stuff in
an earlier version outside fstests. It would stink to run the script
without set -e and blow up your root drive or whatever.

With that said, this is running in TEST_DIR, so I think we can forget
about the precaution now.

> > +# Remove the extra device to bring temp-fsid back in the fray.
> > +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> > +
> > +# Create the would be bind mount.
> > +mkdir -p $BIND
> > +_mount $D0P1 $BIND
> > +mount_show=$($BTRFS_UTIL_PROG filesystem show $MNT)
> > +bind_show=$($BTRFS_UTIL_PROG filesystem show $BIND)
> > +# If they're different, we are in trouble.
> > +[ "$mount_show" = "$bind_show" ] || echo "$mount_show != $bind_show"
> > +
> 
> 
> > +# Now really prove it by corrupting the first mount with the second.
> > +for i in $(seq 20); do
> > +	$XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
> > +done
> > +for i in $(seq 20); do
> > +	$XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&1
> > +done
> > +
> 
> > +# sync so that we really write the large file data out to the shared device
> > +sync
> > +
> > +# now delete from one view of the shared device
> > +find $BIND -type f -delete
> > +# sync so that fstrim definitely has deleted data to trim
> > +sync
> > +# This should blow up both mounts, if the writes somehow didn't overlap at all.
> > +$FSTRIM_PROG $BIND
> > +# drop caches to improve the odds we read from the corrupted device while scrubbing.
> > +echo 3 > /proc/sys/vm/drop_caches
> > +$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
> > +
> 
> 
> The rest appears to be fine.
> 
> Question: Why didn't you choose a cp --reflink=always across $MNT and $BIND
> to prove how kernel think about $MNT and $BIND.

Didn't occur to me. Who knows, maybe one day cross-fs reflink will work ;)

Demonstrating a corruption felt "elemental" to me.

> 
> Thanks, Anand
> 
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> > new file mode 100644
> > index 000000000..70a6db809
> > --- /dev/null
> > +++ b/tests/btrfs/311.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 311
> > +Error summary:    no errors found
> 

