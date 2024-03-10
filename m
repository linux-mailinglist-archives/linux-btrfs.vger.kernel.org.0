Return-Path: <linux-btrfs+bounces-3160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238218777B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838491F21682
	for <lists+linux-btrfs@lfdr.de>; Sun, 10 Mar 2024 17:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC3383A1;
	Sun, 10 Mar 2024 17:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8/XCi4B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FC734CD5;
	Sun, 10 Mar 2024 17:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710091025; cv=none; b=riPtjISybmZ1X9+EN6wMy1qbImGxOn6piVqGvOoJhdLuAe1RuJlUTmOCKvbO7rqiGKyWlYR8iNjhWw+091i7ly9A56BaV5eeqvssj/Mf/tM9dyr+Mv3rFD6ojDREQBBWQuuQC0pQ8D8Ga0HxYTSIOkWuELVhyLzZaXVP83E0pGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710091025; c=relaxed/simple;
	bh=R5st3OtZPxFq6/X1mhigQsYpUvB5OFFyd7hUwnjq4ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gICRCPdHIElfPc9Yg4YtDD1OzMri3Oc5qseembznnjKXN44mWPqyH41B05MTwsqIB4HIlt+MScW4/8HaMnXhl0KffZuhWJCWitLFrAzRaPcQXUi5UN5cHF/xwgsZEfGuONoh0JN3IEHN2UoOEqZHePYX9USExc2xSyt2gF7dfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8/XCi4B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0E7C433C7;
	Sun, 10 Mar 2024 17:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710091024;
	bh=R5st3OtZPxFq6/X1mhigQsYpUvB5OFFyd7hUwnjq4ME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c8/XCi4BmgquN48G4veBMZrCmU+Uc2CwWwNgQqdWVZ494ywFUD6qM2tP2YVCX1c5h
	 bURdkRyFUyYS4JvZQ4K7Jhb1qVlvxPScvwi2CN08/J0D4OBlux/kRxEwdgGxsf3iZK
	 f9Bs7DyIKwYEQ2Z85v8WC0B9eLs5OHSDTpd0lhFdQmpSGIkU2pYep0vzpPILXMsVyv
	 TVeM2RUzdFJ+yZdfJYvvJ2FX7Nrs142Ih59z6fNzVrUurbyqHDhJmsL9Wq/KGxfDOd
	 IvBbGH9hTTxZSzm4mruNmLqxaVY7F/P9N/WuW7dB97w/vuXHbbwZ4hROWAjLXNrr0u
	 D1ln9ZfDLhhSQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a461c50deccso54174766b.0;
        Sun, 10 Mar 2024 10:17:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWADhQSNWPyUzaIAtyjtMFv1HecfBVZmh2DF9fQCEUVxdAPY7pQb26hTFVhoH/KJgnosrSwJUIEnXeeZS6f8tnWbAcmskZuIA==
X-Gm-Message-State: AOJu0YyA+iHK6/VIc5zy7W1H92f4ATc0Vkz7TrTK57cUzDv2kn6/CiR5
	/WV7CUfQV9pE2v1QRIl9yexBv1g/UqaCzHikojvlcV2epyaqNz2dRvOWlMNV7Q4Ela+RUC8D4k1
	F/ra7XO66PM7QzYd0QWPmWMSL/6E=
X-Google-Smtp-Source: AGHT+IGfsIqhCETYcuLnWMEMicOfiaJKPyMkeBi+9a3G86Dq/T4ykuYLXOhKKZKQ2rrBzFk9D+0S6HYJStlBB/Ko98U=
X-Received: by 2002:a17:906:5947:b0:a45:c931:5703 with SMTP id
 g7-20020a170906594700b00a45c9315703mr2139521ejr.70.1710091023242; Sun, 10 Mar
 2024 10:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
In-Reply-To: <9dde3b18f00a30cae78197c9069db503f720fe71.1709844612.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 10 Mar 2024 17:16:26 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5FPa8336s3ZXtScvjTnUHjBaFETBa3eUDAtxzb46jBcw@mail.gmail.com>
Message-ID: <CAL3q7H5FPa8336s3ZXtScvjTnUHjBaFETBa3eUDAtxzb46jBcw@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: new test for devt change between mounts
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 5:42=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
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
> Signed-off-by: Boris Burkov <boris@bur.io>

It fails on for-next (as expected) and it passes with the following
patch applied:

    "btrfs: validate device maj:min during open"

If the consensus is to use that patch as a fix, we can later add the
_fixed_by_kernel_commit call to the test.
Also, the test number 311 has been taken for a week now.

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
> Changelog:
> v3:
> - fstests convention improvements (helpers, output, comments, etc...)
> v2:
> - fix numerous fundamental issues, v1 wasn't really ready
>
>  common/config       |   1 +
>  tests/btrfs/311     | 105 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out |   2 +
>  3 files changed, 108 insertions(+)
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
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000..a7fa541c4
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,105 @@
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
> +_begin_fstest auto quick volume scrub
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_test
> +_require_command "$PARTED_PROG" parted
> +_require_batched_discard "$TEST_DIR"
> +
> +_cleanup() {
> +       cd /
> +       $UMOUNT_PROG $MNT
> +       $UMOUNT_PROG $BIND
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
> +$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 >>$seqres.full 2>&1 ||=
 _fail "failed to mkfs.btrfs"
> +
> +# Cycle mount the two device fs to populate both devices into the
> +# stale device cache.
> +mkdir -p $MNT
> +_mount $D0P1 $MNT
> +$UMOUNT_PROG $MNT
> +
> +# Swap the partition dev_ts. This leaves the dev_t in the cache out of d=
ate.
> +$PARTED_PROG $DEV0 'rm 1' --script
> +$PARTED_PROG $DEV1 'rm 1' --script
> +$PARTED_PROG $DEV1 'mkpart mypart 1M 100%' --script
> +$PARTED_PROG $DEV0 'mkpart mypart 1M 100%' --script
> +
> +# Mount with mismatched dev_t!
> +_mount $D0P1 $MNT || _fail "failed to remount; don't proceed and do dang=
erous stuff on raw mount point"
> +
> +# Remove the extra device to bring temp-fsid back in the fray.
> +$BTRFS_UTIL_PROG device remove $DEV2 $MNT
> +
> +# Create the would be bind mount.
> +mkdir -p $BIND
> +_mount $D0P1 $BIND
> +mount_show=3D$($BTRFS_UTIL_PROG filesystem show $MNT)
> +bind_show=3D$($BTRFS_UTIL_PROG filesystem show $BIND)
> +# If they're different, we are in trouble.
> +[ "$mount_show" =3D "$bind_show" ] || echo "$mount_show !=3D $bind_show"
> +
> +# Now really prove it by corrupting the first mount with the second.
> +for i in $(seq 20); do
> +       $XFS_IO_PROG -f -c "pwrite 0 50M" $MNT/foo.$i >>$seqres.full 2>&1
> +done
> +for i in $(seq 20); do
> +       $XFS_IO_PROG -f -c "pwrite 0 50M" $BIND/foo.$i >>$seqres.full 2>&=
1
> +done
> +
> +# sync so that we really write the large file data out to the shared dev=
ice
> +sync
> +
> +# now delete from one view of the shared device
> +find $BIND -type f -delete
> +# sync so that fstrim definitely has deleted data to trim
> +sync
> +# This should blow up both mounts, if the writes somehow didn't overlap =
at all.
> +$FSTRIM_PROG $BIND
> +# drop caches to improve the odds we read from the corrupted device whil=
e scrubbing.
> +echo 3 > /proc/sys/vm/drop_caches
> +$BTRFS_UTIL_PROG scrub start -B $MNT | grep "Error summary:"
> +
> +status=3D0
> +exit
> diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> new file mode 100644
> index 000000000..70a6db809
> --- /dev/null
> +++ b/tests/btrfs/311.out
> @@ -0,0 +1,2 @@
> +QA output created by 311
> +Error summary:    no errors found
> --
> 2.43.0
>
>

