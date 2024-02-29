Return-Path: <linux-btrfs+bounces-2913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3186C811
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026431C21ED4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0427BB13;
	Thu, 29 Feb 2024 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJVwyEvn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AC64A9B;
	Thu, 29 Feb 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709206378; cv=none; b=RMbQIHRPiK+WwCkCiJSccHZwLOl8O9YY+ZveS1/yEzUpF4lltsTtXg0kNwic/2LGCE+pN3DboM1IYNmyTEoP3EXEH7yfohlp9JKBN1duB9se8Yndbchb58hwXbQb/5Bi2nmXxPzIrxQ6FqQGZE0tuZ6cqBneS9Bl4me644Heui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709206378; c=relaxed/simple;
	bh=BbtK8iru2+pSvzfMwmi4IDjl3uJyRutjYxO+xynpIts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CteDnhAzDCpNy4lfoaMto6BaSMyyp2+muEljLfge2BfxaJrfk4fdiC62vZNN9oUTiac4ZA6gTfeh5Z1nXEraPjt/1a0yqLoUQnSp0pT7gCSe0Tq7RGBNv1y0/rhCvY5+S6UaxDXB95qYk2Baqp1iM4hJ2FmEDhSQ3T2UJ0mjqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJVwyEvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1AFC433F1;
	Thu, 29 Feb 2024 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709206378;
	bh=BbtK8iru2+pSvzfMwmi4IDjl3uJyRutjYxO+xynpIts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aJVwyEvn3zjIneGxqXgo38MiHk3rtZC9w/RN0iRXcJV8/KfEDtGNAKX16+l5BnxAP
	 /fRU5mgg/xS1PYLc9y13VfqrR7DzhOxOdYOJ5wWo76+cvNFkUuDVWGqGKTUBFwhAIL
	 jVEexhU/waUnUOvPF6vk/DtkEBoexaWNIzKXDWI4tGrp7hOGTZwqnSbGd2O7w/3Y4S
	 hXEi6b+Sqlj4D4RsP0muwjmMMFz9i3leH2uMwSKuNcHc6ZY4nR/I91HWk/YKxXBdlz
	 Hc5eSFu/KmoF3xle+g+x3KSVvRo3L80ZFl2m4txRM2tNsZtL12s/AqTTvK7vISF3dC
	 siK5ofFfW0UXQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e85a76fa8so109465266b.1;
        Thu, 29 Feb 2024 03:32:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdDdiq4Is1QZvpyVVmihfFxazbCmXU6eXu+IZyow8mjmmSasRD5SIfykx2Gl35+CQOlDjnHFc4d03FMr/3jOqsUN8UXnZ8Niffo2Q=
X-Gm-Message-State: AOJu0YyEsLUfVrD9hwe72xElrZLyrDaJLFd/OOCcsQ0fPbLoGDly1P0H
	GYBAredH3xSeyPGX5A2zbvRv8fsSlU+hlpOv1zboE5BNLhJWu/fEsLePt8UZwCoD7UpFmkEjHP6
	8d35ouLF6f1pa+5jKLqz6+UZFCT0=
X-Google-Smtp-Source: AGHT+IH2nS0xXrUwUcCj7+8+mAUsB/raXOIGsnpVJ9nopNsnxqCS0x8315J+whswVhIlbukLvTSiEmm9QvW+2HQYKhk=
X-Received: by 2002:a17:906:44d:b0:a44:f89:a04e with SMTP id
 e13-20020a170906044d00b00a440f89a04emr1526092eja.35.1709206376438; Thu, 29
 Feb 2024 03:32:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709162170.git.anand.jain@oracle.com> <9c7e30b26d07ef53849d780d4c5f3b8d0d88dae2.1709162170.git.anand.jain@oracle.com>
In-Reply-To: <9c7e30b26d07ef53849d780d4c5f3b8d0d88dae2.1709162170.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 11:32:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6N6ijvrOkK4r1qz_F-k_4Yx9KqHke4knbUew5W7CA8xg@mail.gmail.com>
Message-ID: <CAL3q7H6N6ijvrOkK4r1qz_F-k_4Yx9KqHke4knbUew5W7CA8xg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] btrfs: verify that subvolume mounts are
 unaffected by tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:50=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> The tempfsid logic must determine whether the incoming mount request
> is for a device already mounted or a new device mount. Verify that it
> recognizes the device already mounted well by creating reflink across
> the subvolume mount points.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Double SOB line. You might want to correct that before sending the pull req=
uest.

> ---
>  tests/btrfs/311     | 87 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out | 24 +++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100755 tests/btrfs/311
>  create mode 100644 tests/btrfs/311.out
>
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000000..7de8f0512489
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,87 @@
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
> +_require_scratch
> +_require_btrfs_fs_feature temp_fsid
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
> +       $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_s=
cratch
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
> index 000000000000..4ea46eab3c72
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
> +Create subvolume 'SCRATCH_MNT/subvol'
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

