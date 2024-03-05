Return-Path: <linux-btrfs+bounces-3014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEE871EB7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B0B1F23696
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AB5A11B;
	Tue,  5 Mar 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1crNso9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5C959B5E;
	Tue,  5 Mar 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640826; cv=none; b=gyHOr0QkCEDrvtK5d2Lf5gFOT/v70N5oAMFoYQACEZYpdCFWXfTnUStmQndcl3FDyXq78Vfl0IKEF6S2d47dqSwNV1hJShtj6JuIGvb3JRIAE1HByxHKJRiajHmK/4LHtoy2oXV6NF1QjpDQVeRASTfMxGC0W6P7rHJiVzSib1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640826; c=relaxed/simple;
	bh=tk1PzqBKjnQr+HzxIeuaLfWQGg4edV3ZqHMTlOMAHu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c99Ml/0SH/gsPvjXoqWWOlZ0nbOTYAD2ygNoEVkwMI/RzkPGUsmBwuKOL2tMWfzmbISYBHYbG6od/4MB/s4UZCh01scm9QNl8s6DxCySUZqhp67kwatvaYJg0GrKjJilQD6ZCtjcXNq0F4rAWPCel7wvAnMQUcYvFDeYpsCG1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1crNso9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB52C433C7;
	Tue,  5 Mar 2024 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709640826;
	bh=tk1PzqBKjnQr+HzxIeuaLfWQGg4edV3ZqHMTlOMAHu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g1crNso9BATPmFoBoRFiSBjNoCatpcemDAkv2urH9xfu18y7RqJ4lgfaSw9DJqmE9
	 4rA1mt6tGjBDsTLTV9mD7ovLMHinI1m3qbj/DIRUyxokEiIVruYHNsiJp+RqoCU2kI
	 bNzX1ExViLlhcV0hv8Y1/2DPyAaOVVk3JV97A+ytqujVUf6l9Y9k0ljjUQyLfR2vjj
	 6GFSNBw38zRw9upeOfzOXOkxP82Khy8zB5pB5QfXJvXj2IRA6puRA5SH3ksR3BE1aY
	 EnjPqhCAvP4BSUawqO/4vNeaVkCwDzy3S6b5LgnhgR3ly5Peh5PiyjbKawfd9So/g4
	 TJQEYOGWd0qCw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44e3176120so340375066b.1;
        Tue, 05 Mar 2024 04:13:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIkIwRVK5+/7QvEhu5FDqZqm2g8nYMokRRGodaRlqRQWOhhJcZTM8ycQkzqr5+bV93/7h5K6+99xxpFv7+BGsx0CmZxPI8bw==
X-Gm-Message-State: AOJu0YxHIpFn8sFVCvkUj/fYM0gX0KhtxpHd10niOvh8pM8DGajP5sG0
	TIcBy+NfYcKD8w3RqTi7fAV5leBA0I3eoywTSQ7Ah96p6o651qH0oBpimn3+nr1qDB96ccb0PHf
	IBZp7v3zITmF+Q8x5xydUuHJfOEM=
X-Google-Smtp-Source: AGHT+IFl6Cu4XlVaoSwyKzj2OmkGNOnrlyrAWK+cQRbMz0zCbM6wONXOh6VDNKJPNa1W2ZnZcGx9R0q7+QEicH33TCM=
X-Received: by 2002:a17:906:560b:b0:a45:7dc6:5bb with SMTP id
 f11-20020a170906560b00b00a457dc605bbmr2625236ejq.71.1709640824731; Tue, 05
 Mar 2024 04:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io>
In-Reply-To: <f40e347d5a4b4b28201b1a088d38a3c75dd10ebd.1709251328.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Mar 2024 12:13:07 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4rYdJidxKja2YZDdXcu3NtsYhKS--YhTUHRi5OqzwijQ@mail.gmail.com>
Message-ID: <CAL3q7H4rYdJidxKja2YZDdXcu3NtsYhKS--YhTUHRi5OqzwijQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs/311: new test for devt change between mounts
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:02=E2=80=AFAM Boris Burkov <boris@bur.io> wrote:
>
> It is possible to confuse the btrfs device cache (fs_devices) by
> starting with a multi-device filesystem, then removing and re-adding a
> device in a way which changes its dev_t while the filesystem is
> unmounted. After this procedure, if we remount, then we are in a funny
> state where struct btrfs_device's "devt" field does not match the bd_dev
> of the "bdev" field. I would say this is bad enough, as we have violated
> a pretty clear invariant.
>
> But for style points, we can then remove the extra device from the fs,
> making it a single device fs, which enables the "temp_fsid" feature,
> which permits multiple separate mounts of different devices with the
> same fsid. Since btrfs is confused and *thinks* there are different
> devices (based on device->devt), it allows a second redundant mount of
> the same device (not a bind mount!). This then allows us to corrupt the
> original mount by doing stuff to the one that should be a bind mount.
>
> This is fixed by the combination of the kernel patch:
> btrfs: support device name lookup in forget
> and the btrfs-progs patches:
> btrfs-progs: allow btrfs device scan -u on dead dev
> btrfs-progs: add udev rule to forget removed device

May I suggest to make this more readable, easier to the eye?
My inserting blank lines and indenting the lines with the patch
subjects, like for example:

"""
This is fixed by the combination of the kernel patch:

    btrfs: support device name lookup in forget

and the btrfs-progs patches:

   btrfs-progs: allow btrfs device scan -u on dead dev
   btrfs-progs: add udev rule to forget removed device
"""

And these should be placed in the test case itself with:

   _fixed_by_git_commit btrfs-progs xxxxxxxxxx "btrfs-progs: allow
btrfs device scan -u on dead dev"

For btrfs-progs commits, and for the kernel:

   _fixed_by_kernel_commit xxxxxxxxxxxx "btrfs: support device name
lookup in forget"

I see however that there's discussion for those patches between you,
Anand and David, and it
seems there's a chance those patches won't be merged to fix this bug,
especially the kernel one
for which Anand submitted an alternative. If those are added to the
test case itself, can always be
updated later if needed.

Also avoid putting the test number in the subject - there's no
guarantee it will end up with that number when merged.

>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/config       |   1 +
>  common/rc           |   4 ++
>  tests/btrfs/311     | 101 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out |   2 +
>  4 files changed, 108 insertions(+)
>  create mode 100755 tests/btrfs/311
>  create mode 100644 tests/btrfs/311.out
>
> diff --git a/common/config b/common/config
> index a3b15b96f..43b517fda 100644
> --- a/common/config
> +++ b/common/config
> @@ -235,6 +235,7 @@ export BLKZONE_PROG=3D"$(type -P blkzone)"
>  export GZIP_PROG=3D"$(type -P gzip)"
>  export BTRFS_IMAGE_PROG=3D"$(type -P btrfs-image)"
>  export BTRFS_MAP_LOGICAL_PROG=3D$(type -P btrfs-map-logical)
> +export PARTED_PROG=3D"$(type -P parted)"
>
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> diff --git a/common/rc b/common/rc
> index 30c44dddd..8e009aca9 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5375,6 +5375,10 @@ _require_unshare() {
>                 _notrun "unshare $*: command not found, should be in util=
-linux"
>  }
>
> +_require_parted() {

These three last functions from common/rc use that style, the { after
the function name in the same line,
but everywhere else the { is on a new line, and that's the most common
style in fstests.
I wish we had some consistency.

> +       $PARTED_PROG --list &>/dev/null || _notrun "parted: command not f=
ound"

Why not just call:

_require_command "$PARTED_PROG" parted

Could even do that in the test and no need for a common function in
this file, as we do in many other tests
(grep for "'_require_command'" in tests/generic for example).

> +}
> +
>  # Return a random file in a directory. A directory is *not* followed
>  # recursively.
>  _random_file() {
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000..887c46ba0
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Meta, Inc. All Rights Reserved.
> +#
> +# FS QA Test 311
> +#
> +# Test an edge case of multi device volume management in btrfs.
> +# If a device changes devt between mounts of a multi device fs, we can t=
rick
> +# btrfs into mounting the same device twice fully (not as a bind mount).=
 From
> +# there, it is trivial to induce corruption.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume

Missing 'scrub' group.

> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_parted
> +
> +_cleanup() {
> +       cd /
> +       umount $MNT
> +       umount $BIND
> +       losetup -d $DEV0
> +       losetup -d $DEV1
> +       losetup -d $DEV2
> +       rm $IMG0
> +       rm $IMG1
> +       rm $IMG2
> +}
> +
> +IMG0=3D$TEST_DIR/$$.img0
> +IMG1=3D$TEST_DIR/$$.img1
> +IMG2=3D$TEST_DIR/$$.img2
> +truncate -s 1G $IMG0
> +truncate -s 1G $IMG1
> +truncate -s 1G $IMG2
> +DEV0=3D$(losetup -f $IMG0 --show)
> +DEV1=3D$(losetup -f $IMG1 --show)
> +DEV2=3D$(losetup -f $IMG2 --show)
> +D0P1=3D$DEV0"p1"
> +D1P1=3D$DEV1"p1"
> +MNT=3D$TEST_DIR/mnt
> +BIND=3D$TEST_DIR/bind
> +
> +# Setup partition table with one partition on each device.
> +$PARTED_PROG $DEV0 'mktable gpt' --script
> +$PARTED_PROG $DEV1 'mktable gpt' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +
> +# mkfs with two devices to avoid clearing devices on close
> +# single raid to allow removing DEV2.
> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null

Please redirect to the $seqres.full instead, and _fail if mkfs fails.
That's what we do nowadays due to unpleasant surprises in the past.

> +
> +# Cycle mount the two device fs to populate both devices into the
> +# stale device cache.
> +mkdir -p $MNT
> +mount $D0P1 $MNT

Use the _mount() helper.

> +umount $MNT

We use $UMOUNT_PROG in fstests.

> +
> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of d=
ate.
> +$PARTED_PROG $DEV0 'rm 1' --script
> +$PARTED_PROG $DEV1 'rm 1' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +
> +# Mount with mismatched dev_t!
> +mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dange=
rous stuff on raw mount point"

Same here.

> +
> +# Remove the extra device to bring temp-fsid back in the fray.
> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> +
> +# Create the would be bind mount.
> +mkdir -p $BIND
> +mount $D0P1 $BIND

Same here.

> +mount_show=3D$($BTRFS_UTIL_PROG filesystem show $MNT)
> +bind_show=3D$($BTRFS_UTIL_PROG filesystem show $BIND)
> +# If they're different, we are in trouble.
> +[ "$mount_show" =3D "$bind_show" ] || echo "$mount_show !=3D $bind_show"
> +
> +# Now really prove it by corrupting the first mount with the second.
> +for i in $(seq 20); do
> +       $XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >$seqres.full 2>&1

This is overriding the .full file, use >>

> +done
> +for i in $(seq 20); do
> +       $XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >$seqres.full 2>&1

Same here, this is overriding the .full file, use >>

> +done
> +sync

Can we please have a comment mentioning why the sync is needed?

> +find $BIND -type f -delete
> +sync

Same here.

> +
> +# This should blow up both mounts, if the writes somehow didn't overlap =
at all.
> +$FSTRIM_PROG $BIND

Since it's using the fstrim program and needs trim to be supported,
the test misses a:

_require_batched_discard "$TEST_DIR"

at the top.

> +echo 3 > /proc/sys/vm/drop_caches

Please add a comment mentioning why we are dropping caches.

> +$BTRFS_UTIL_PROG scrub start -B $MNT >>$seqres.full 2>&1

The test passes whether scrub fails or succeeds, as it's redirecting
stdout and stderr to the .full file and ignoring the exit status of
the command.

The ideal fstests way is to put the expected output in the golden
output file and just call the command without redirecting anything.
If that's not doable for some reason, at the very least do a (...) ||
echo "Scrub failed, check $seqres.full for details."

Thanks.

> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> new file mode 100644
> index 000000000..62f253029
> --- /dev/null
> +++ b/tests/btrfs/311.out
> @@ -0,0 +1,2 @@
> +QA output created by 311
> +Silence is golden
> --
> 2.43.0
>
>

