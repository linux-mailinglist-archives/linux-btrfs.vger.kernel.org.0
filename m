Return-Path: <linux-btrfs+bounces-2591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A5885C170
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF842858CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82676411;
	Tue, 20 Feb 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcA+wCI+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B102E84E;
	Tue, 20 Feb 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446682; cv=none; b=OM77j/GEqTUoeluuHi/vOdMk8gMud05IsSO42cRVy9Qw4ta8iKVJLGuWYnsCWdVNxGmsSAqDEIK+bSEO24zWFzyn9OfRFIgFfHl6cM1GVI0thdWuBJAW4GG6kszHCZ2FhqKTKroLfZthlA4x2ljBCJfhkLvA8Qu8MOELdVyYOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446682; c=relaxed/simple;
	bh=WJsWmfMZy0QT5+6Dmb5jBfUDnfmzCXv97qo8gEpQCh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGgCO1Y1+AnvwsPYPCV172u1slbRAcycT0rdKJmhelQbCV2md/ZETSbbk9cRIpo2TmAbrd7hDx1x3G2p5DyvaeIfUAA4e1ZzOGm6OCN7dH8hTdPCd3+/wDn3TFeMxYRl3h4DMqekp3ghlQQ4z35iWvPhKvsvtDuR915a3TtoTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcA+wCI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068F0C433C7;
	Tue, 20 Feb 2024 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708446682;
	bh=WJsWmfMZy0QT5+6Dmb5jBfUDnfmzCXv97qo8gEpQCh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tcA+wCI+mOOozyWJ+MXWoVwhWJLfpOadaz+MEz/o+P2SA52OqXR7Go3lQa90p3Ym7
	 d7XGw0thtQI9I3v3sKCeRACCl+2BgJEoKfBLVAV+Dmn82/ySdSEpLqQTBvDLCUkoyi
	 kEsGehybE0ay900GMy/OgBXZLCzTTZWmbr85BoWq95FYN0TwVJKcDwrskF69EyOTJM
	 caA0est1GRowXyqmiJPkWYom9iosoaH4vD68+LGpSOMyXGqkNOf7oDDfbclMo/d6t+
	 NVv7SW8j4Bxjn0v48rWMpzhw6lAcDREzwLthozrUTnONAhLxp/tK93bsLAhPcJ7bBm
	 hQbJjR2w6KoEg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so3890602a12.3;
        Tue, 20 Feb 2024 08:31:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXitmYmnMb7J4erOf5+XQQZsuT/FbyfatvU5QcwWx3dwL4PpQlmm9rCECNCpkdqsQrBPTqSpnSb847tT6IJ4W2/fQ77eB1m6fYTZN8=
X-Gm-Message-State: AOJu0Yzkb8W39k5ywRxbOr1ozAkkvP3zZWv1yiB8p1GGU6VnqF4Yut7u
	bBPni9XYU/PtOygZt84oFPVnVV2StZ7Y8OmR2g+PPOcTwCQxDQo2EnAqjMk7x9XJlx5E9BbBfcr
	wf3mGfwW0fRA+Hij4GZOpkq3VmMs=
X-Google-Smtp-Source: AGHT+IG6Euf3+uu3tjmLhPz4nqYyLyGaRhFnw5BPatjWjLGoeWAE80kvnoBZlXJEufqzAcuRkl8lRvTwzCQVAzo7RmY=
X-Received: by 2002:a17:906:c284:b0:a3e:d1c1:ae0c with SMTP id
 r4-20020a170906c28400b00a3ed1c1ae0cmr3114775ejz.29.1708446680354; Tue, 20 Feb
 2024 08:31:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <5c5a57b1f937b7a6470976643fad1c147c682e80.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <5c5a57b1f937b7a6470976643fad1c147c682e80.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:30:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4qTrGrSuWys8rTRnQNdYFBJL=RZjsg3k_kVuU01Lf3Kw@mail.gmail.com>
Message-ID: <CAL3q7H4qTrGrSuWys8rTRnQNdYFBJL=RZjsg3k_kVuU01Lf3Kw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] btrfs: verify that subvolume mounts are
 unaffected by tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:49=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> The tempfsid logic must determine whether the incoming mount request
> is for a device already mounted or a new device mount. Verify that it
> recognizes the device already mounted well by creating reflink across
> the subvolume mount points.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
> add subvol group
> use $UMOUNT_PROG
> remove _fail for _cp_reflink
>
>  tests/btrfs/311     | 89 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out | 24 ++++++++++++
>  2 files changed, 113 insertions(+)
>  create mode 100755 tests/btrfs/311
>  create mode 100644 tests/btrfs/311.out
>
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000000..cebbc3a59e6a
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle. All Rights Reserved.
> +#
> +# FS QA Test 311
> +#
> +# Mount the device twice check if the reflink works, this helps to
> +# ensure device is mounted as the same device.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick subvol tempfsid
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $mnt1 > /dev/null 2>&1
> +       rm -r -f $tmp.*
> +       rm -r -f $mnt1
> +}
> +
> +. ./common/filter.btrfs
> +. ./common/reflink
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_cp_reflink
> +_require_btrfs_sysfs_fsid
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_scratch
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +same_dev_mount()
> +{
> +       echo ---- $FUNCNAME ----
> +
> +       _scratch_mkfs >> $seqres.full 2>&1
> +
> +       _scratch_mount
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                               _filter_x=
fs_io
> +
> +       echo Mount the device again to a different mount point
> +       _mount $SCRATCH_DEV $mnt1
> +
> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar
> +       echo Checksum of reflinked files
> +       md5sum $SCRATCH_MNT/foo | _filter_scratch
> +       md5sum $mnt1/bar | _filter_test_dir
> +
> +       check_fsid $SCRATCH_DEV
> +}
> +
> +same_dev_subvol_mount()
> +{
> +       echo ---- $FUNCNAME ----
> +       _scratch_mkfs >> $seqres.full 2>&1
> +
> +       _scratch_mount
> +       $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol

Need to use: | _filter_scratch
See the golden output below.

> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo =
| \
> +                                                               _filter_x=
fs_io
> +
> +       echo Mounting a subvol
> +       _mount -o subvol=3Dsubvol $SCRATCH_DEV $mnt1
> +
> +       _cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar
> +       echo Checksum of reflinked files
> +       md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
> +       md5sum $mnt1/bar | _filter_test_dir
> +
> +       check_fsid $SCRATCH_DEV
> +}
> +
> +same_dev_mount
> +
> +_scratch_unmount
> +_cleanup
> +mkdir -p $mnt1
> +
> +same_dev_subvol_mount
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
> new file mode 100644
> index 000000000000..8787f24ab867
> --- /dev/null
> +++ b/tests/btrfs/311.out
> @@ -0,0 +1,24 @@
> +QA output created by 311
> +---- same_dev_mount ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Mount the device again to a different mount point
> +Checksum of reflinked files
> +42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
> +42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> +---- same_dev_subvol_mount ----
> +Create subvolume '/mnt/scratch/subvol'

Because of this...

Otherwise it looks fine.

With that corrected:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Mounting a subvol
> +Checksum of reflinked files
> +42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/subvol/foo
> +42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> --
> 2.39.3
>

