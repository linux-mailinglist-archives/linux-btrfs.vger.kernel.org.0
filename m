Return-Path: <linux-btrfs+bounces-3098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CEB8763B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 12:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE9028288B
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Mar 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E755647F;
	Fri,  8 Mar 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9XVWRYD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00156469;
	Fri,  8 Mar 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898961; cv=none; b=T0RqDtSYGAu82QSUFQqvfMeuBGu93BRXTge9ngwYrhQKc3nBCLf78e3eoLoLsQ2uU65dTMdoMe1M7j3edZHevAMnt0nznYTbsJg8NtOWRBH69vco666CpZro/9QeoQCS980LvWLr1bY5WF0pRzeTHio1iaWwSdqr3lpx3AqHRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898961; c=relaxed/simple;
	bh=o1KL2OUzDYLLHy0ZeKQ+tSRnHeVvEpLLb3s0xqTPeXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIR2To8y3Y31G7AXO9IAb91dqPuor475y0qn2hP6xhWEk9ypu4tr6A904hpT6+PE3aYASHWC07qN/rhkTbEAQv8KOxM1aFSLRYAWyFDp3/UlQzNQ7niQsMV4T9A4S25ZssKyW1b577ASLsPwiaduwT3fMFDah/hOhPXWm5d2tpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9XVWRYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E3DC43394;
	Fri,  8 Mar 2024 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709898960;
	bh=o1KL2OUzDYLLHy0ZeKQ+tSRnHeVvEpLLb3s0xqTPeXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9XVWRYDtgy+Y4JTrqGFkLAbH7sdbkSRDTbGyTP1OXvx1rozwF06A/sVVZDC/7mUC
	 SGlEIj//60CixgfYg+9MlkzLuKHBVrg73U8PyoGFiQJyu7ugBFQVt5/QCMCYNweT3k
	 qRFHDJylF424UyOjzVpwUUxnFQhW7tDYYx2TiNihAe5Z+/ivRERwUpze09BIdffT9o
	 xNUzDF2OcE4Cme8ERudrNlis7PNLZ8IGYNtyMIoP8j3Is2d/nMKBU+cmV4iUVB3cxP
	 8shKjdYiy+iySd+pbukK5tUYTd8AJHoyyTy+s2HFZvV+RWfZ7kWk9/7LP6eP1hAKnh
	 r1osRyf7Qrcqg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5682360e095so1113729a12.1;
        Fri, 08 Mar 2024 03:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5ycEQNcRixb1CUmp3Uh2cFR/32rhJmR80Dv2JoroxNEn/sIhszs1x1xv+xAK3ImyrvoeSrkH2Io2F74D7cy5eQ42M0xp+pg==
X-Gm-Message-State: AOJu0Yw6fJZfv74iEhFhEFans0fw+pOO6bWHDLrBYGyRK1Zs4GMjYcUR
	+uqL+oDqyh7VG43Mi6ZYl49HoTTJrpRNGNpk8xRJmFQO+6wcEawtd6raplAKse7G937AlCH12Rg
	H5w3ExuOQb7jHWHJNUYrKIgc8Q74=
X-Google-Smtp-Source: AGHT+IHyw4Q2qzBvN7i5TGj+BbDpIiYN8RI/y84Fz6F3OO21MgwdrCvdkU6leltouo1cbRzI/vsY9pU8ql+Olab5CFA=
X-Received: by 2002:a17:907:1708:b0:a43:dc5f:f271 with SMTP id
 le8-20020a170907170800b00a43dc5ff271mr13860523ejc.42.1709898959056; Fri, 08
 Mar 2024 03:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io>
 <CAL3q7H4rYdJidxKja2YZDdXcu3NtsYhKS--YhTUHRi5OqzwijQ@mail.gmail.com> <20240307204936.GA2446256@zen.localdomain>
In-Reply-To: <20240307204936.GA2446256@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 8 Mar 2024 11:55:22 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Es-_Zr+zcaGfky5ePET6k-_vJhhxk4WrhyUZGtkb7AA@mail.gmail.com>
Message-ID: <CAL3q7H6Es-_Zr+zcaGfky5ePET6k-_vJhhxk4WrhyUZGtkb7AA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/311: new test for devt change between mounts
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 8:48=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Mar 05, 2024 at 12:13:07PM +0000, Filipe Manana wrote:
> > On Fri, Mar 1, 2024 at 12:02=E2=80=AFAM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > It is possible to confuse the btrfs device cache (fs_devices) by
> > > starting with a multi-device filesystem, then removing and re-adding =
a
> > > device in a way which changes its dev_t while the filesystem is
> > > unmounted. After this procedure, if we remount, then we are in a funn=
y
> > > state where struct btrfs_device's "devt" field does not match the bd_=
dev
> > > of the "bdev" field. I would say this is bad enough, as we have viola=
ted
> > > a pretty clear invariant.
> > >
> > > But for style points, we can then remove the extra device from the fs=
,
> > > making it a single device fs, which enables the "temp_fsid" feature,
> > > which permits multiple separate mounts of different devices with the
> > > same fsid. Since btrfs is confused and *thinks* there are different
> > > devices (based on device->devt), it allows a second redundant mount o=
f
> > > the same device (not a bind mount!). This then allows us to corrupt t=
he
> > > original mount by doing stuff to the one that should be a bind mount.
> > >
> > > This is fixed by the combination of the kernel patch: > > btrfs: supp=
ort device name lookup in forget
> > > and the btrfs-progs patches:
> > > btrfs-progs: allow btrfs device scan -u on dead dev
> > > btrfs-progs: add udev rule to forget removed device
> >
> > May I suggest to make this more readable, easier to the eye?
> > My inserting blank lines and indenting the lines with the patch
> > subjects, like for example:
> >
> > """
> > This is fixed by the combination of the kernel patch:
> >
> >     btrfs: support device name lookup in forget
> >
> > and the btrfs-progs patches:
> >
> >    btrfs-progs: allow btrfs device scan -u on dead dev
> >    btrfs-progs: add udev rule to forget removed device
> > """
> >
> > And these should be placed in the test case itself with:
> >
> >    _fixed_by_git_commit btrfs-progs xxxxxxxxxx "btrfs-progs: allow
> > btrfs device scan -u on dead dev"
> >
> > For btrfs-progs commits, and for the kernel:
> >
> >    _fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: support device name
> > lookup in forget"
>
> I'll do so going forward, thanks.
>
> >
> > I see however that there's discussion for those patches between you,
> > Anand and David, and it
> > seems there's a chance those patches won't be merged to fix this bug,
> > especially the kernel one
> > for which Anand submitted an alternative. If those are added to the
> > test case itself, can always be
> > updated later if needed.
>
> I'm leaning towards omitting this part from the commit message and we
> can update the test case once we pick a winner. Is that OK with you?

Yes, thanks.

>
> >
> > Also avoid putting the test number in the subject - there's no
> > guarantee it will end up with that number when merged.
> >
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  common/config       |   1 +
> > >  common/rc           |   4 ++
> > >  tests/btrfs/311     | 101 ++++++++++++++++++++++++++++++++++++++++++=
++
> > >  tests/btrfs/311.out |   2 +
> > >  4 files changed, 108 insertions(+)
> > >  create mode 100755 tests/btrfs/311
> > >  create mode 100644 tests/btrfs/311.out
> > >
> > > diff --git a/common/config b/common/config
> > > index a3b15b96f..43b517fda 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -235,6 +235,7 @@ export BLKZONE_PROG=3D"$(type -P blkzone)"
> > >  export GZIP_PROG=3D"$(type -P gzip)"
> > >  export BTRFS_IMAGE_PROG=3D"$(type -P btrfs-image)"
> > >  export BTRFS_MAP_LOGICAL_PROG=3D$(type -P btrfs-map-logical)
> > > +export PARTED_PROG=3D"$(type -P parted)"
> > >
> > >  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> > >  # newer systems have udevadm command but older systems like RHEL5 do=
n't.
> > > diff --git a/common/rc b/common/rc
> > > index 30c44dddd..8e009aca9 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -5375,6 +5375,10 @@ _require_unshare() {
> > >                 _notrun "unshare $*: command not found, should be in =
util-linux"
> > >  }
> > >
> > > +_require_parted() {
> >
> > These three last functions from common/rc use that style, the { after
> > the function name in the same line,
> > but everywhere else the { is on a new line, and that's the most common
> > style in fstests.
> > I wish we had some consistency.
> >
> > > +       $PARTED_PROG --list &>/dev/null || _notrun "parted: command n=
ot found"
> >
> > Why not just call:
> >
> > _require_command "$PARTED_PROG" parted
> >
> > Could even do that in the test and no need for a common function in
> > this file, as we do in many other tests
> > (grep for "'_require_command'" in tests/generic for example).
> >
> > > +}
> > > +
> > >  # Return a random file in a directory. A directory is *not* followed
> > >  # recursively.
> > >  _random_file() {
> > > diff --git a/tests/btrfs/311 b/tests/btrfs/311
> > > new file mode 100755
> > > index 000000000..887c46ba0
> > > --- /dev/null
> > > +++ b/tests/btrfs/311
> > > @@ -0,0 +1,101 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> > > +#
> > > +# FS QA Test 311
> > > +#
> > > +# Test an edge case of multi device volume management in btrfs.
> > > +# If a device changes devt between mounts of a multi device fs, we c=
an trick
> > > +# btrfs into mounting the same device twice fully (not as a bind mou=
nt). From
> > > +# there, it is trivial to induce corruption.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick volume
> >
> > Missing 'scrub' group.
> >
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_require_test
> > > +_require_parted
> > > +
> > > +_cleanup() {
> > > +       cd /
> > > +       umount $MNT
> > > +       umount $BIND
> > > +       losetup -d $DEV0
> > > +       losetup -d $DEV1
> > > +       losetup -d $DEV2
> > > +       rm $IMG0
> > > +       rm $IMG1
> > > +       rm $IMG2
> > > +}
> > > +
> > > +IMG0=3D$TEST_DIR/$$.img0
> > > +IMG1=3D$TEST_DIR/$$.img1
> > > +IMG2=3D$TEST_DIR/$$.img2
> > > +truncate -s 1G $IMG0
> > > +truncate -s 1G $IMG1
> > > +truncate -s 1G $IMG2
> > > +DEV0=3D$(losetup -f $IMG0 --show)
> > > +DEV1=3D$(losetup -f $IMG1 --show)
> > > +DEV2=3D$(losetup -f $IMG2 --show)
> > > +D0P1=3D$DEV0"p1"
> > > +D1P1=3D$DEV1"p1"
> > > +MNT=3D$TEST_DIR/mnt
> > > +BIND=3D$TEST_DIR/bind
> > > +
> > > +# Setup partition table with one partition on each device.
> > > +$PARTED_PROG $DEV0 'mktable gpt' --script
> > > +$PARTED_PROG $DEV1 'mktable gpt' --script
> > > +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> > > +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> > > +
> > > +# mkfs with two devices to avoid clearing devices on close
> > > +# single raid to allow removing DEV2.
> > > +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null
> >
> > Please redirect to the $seqres.full instead, and _fail if mkfs fails.
> > That's what we do nowadays due to unpleasant surprises in the past.
> >
> > > +
> > > +# Cycle mount the two device fs to populate both devices into the
> > > +# stale device cache.
> > > +mkdir -p $MNT
> > > +mount $D0P1 $MNT
> >
> > Use the _mount() helper.
> >
> > > +umount $MNT
> >
> > We use $UMOUNT_PROG in fstests.
> >
> > > +
> > > +# Swap the partition dev_ts. This leaves the dev_t in the cache out =
of date.
> > > +$PARTED_PROG $DEV0 'rm 1' --script
> > > +$PARTED_PROG $DEV1 'rm 1' --script
> > > +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> > > +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> > > +
> > > +# Mount with mismatched dev_t!
> > > +mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do d=
angerous stuff on raw mount point"
> >
> > Same here.
> >
> > > +
> > > +# Remove the extra device to bring temp-fsid back in the fray.
> > > +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> > > +
> > > +# Create the would be bind mount.
> > > +mkdir -p $BIND
> > > +mount $D0P1 $BIND
> >
> > Same here.
> >
> > > +mount_show=3D$($BTRFS_UTIL_PROG filesystem show $MNT)
> > > +bind_show=3D$($BTRFS_UTIL_PROG filesystem show $BIND)
> > > +# If they're different, we are in trouble.
> > > +[ "$mount_show" =3D "$bind_show" ] || echo "$mount_show !=3D $bind_s=
how"
> > > +
> > > +# Now really prove it by corrupting the first mount with the second.
> > > +for i in $(seq 20); do
> > > +       $XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >$seqres.full 2=
>&1
> >
> > This is overriding the .full file, use >>
> >
> > > +done
> > > +for i in $(seq 20); do
> > > +       $XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >$seqres.full =
2>&1
> >
> > Same here, this is overriding the .full file, use >>
> >
> > > +done
> > > +sync
> >
> > Can we please have a comment mentioning why the sync is needed?
> >
> > > +find $BIND -type f -delete
> > > +sync
> >
> > Same here.
> >
> > > +
> > > +# This should blow up both mounts, if the writes somehow didn't over=
lap at all.
> > > +$FSTRIM_PROG $BIND
> >
> > Since it's using the fstrim program and needs trim to be supported,
> > the test misses a:
> >
> > _require_batched_discard "$TEST_DIR"
> >
> > at the top.
> >
> > > +echo 3 > /proc/sys/vm/drop_caches
> >
> > Please add a comment mentioning why we are dropping caches.
> >
> > > +$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1
> >
> > The test passes whether scrub fails or succeeds, as it's redirecting
> > stdout and stderr to the .full file and ignoring the exit status of
> > the command.
> >
> > The ideal fstests way is to put the expected output in the golden
> > output file and just call the command without redirecting anything.
> > If that's not doable for some reason, at the very least do a (...) ||
> > echo "Scrub failed, check $seqres.full for details."
> >
> > Thanks.
> >
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +status=3D0
> > > +exit
> > > diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> > > new file mode 100644
> > > index 000000000..62f253029
> > > --- /dev/null
> > > +++ b/tests/btrfs/311.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 311
> > > +Silence is golden
> > > --
> > > 2.43.0
> > >
> > >

