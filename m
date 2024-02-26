Return-Path: <linux-btrfs+bounces-2790-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C89608673D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372351F2B321
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9AB22337;
	Mon, 26 Feb 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aym5UtqK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C982620DE5;
	Mon, 26 Feb 2024 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948212; cv=none; b=O/B7FQtlWOooHxYo6UPDoGeQ+XRwOo+FcUPCO073zc+2zAQHSZfiMyEYZnioQmN9BBPdEMX9Zl1gVdZXatLHYV0+/NBMoPYgb8fSGjFhS2zVkUJzCfyrqRL+CeYkzxIaBErne+OvuosO0fZ1CUljqsVwPwl4ZgfQT/0r5rfo2sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948212; c=relaxed/simple;
	bh=c9qIgEwaNkfs4WvH+MsFY5cAeNzBhONDNPwErBdCDMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxxjlDLCIq1iMIC8lnx/cMAbneImxmbvzwJEt6ZMDTKVVuCNfOYA6BfyipEUrvdfZWNmyIuVDLPBsVP+YRyl30VG7XmOWmNcwbCDBHD0kxUnIj/EMH0l/tkrttYiRk/XVcSZxjjf5nhSVYB+SontyAoofAVMZfAFn+HrcpfCaPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aym5UtqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5AFC433F1;
	Mon, 26 Feb 2024 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948212;
	bh=c9qIgEwaNkfs4WvH+MsFY5cAeNzBhONDNPwErBdCDMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aym5UtqKWRB0JyRa1wpoGEpXlWInuWjdZfAIdlCMVtY0Fkct7NOV1/k59DVVPJ4ng
	 uSnrtFxZkCLcPsUExClG5jqIYPDXwnPSM06CeAphcCKKnfka/CR/vVn+a3dvKrarwi
	 dctMW11a4zb6ZfNgmuobPFdN8Q2rdyDPgU+Sq04FV/lJx6tfYxsxqP9dgeAK5V9geE
	 uV7SQaKkdeVSQmW38ObMpHmSXn7QzF650ci7zh1AdJzy0NDITUbeWD2oNI39zGislc
	 KVKhk/T1Dz7ecuEQERiUGaxFkAm6qzmvzbqYe4wRxolr8lJn0/TIyenOSv9jSP2RZU
	 g9CqQkay6qjnQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so476377466b.2;
        Mon, 26 Feb 2024 03:50:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrFE72KDfKM7gUAj6EpXT7kG45euwQ04kcfavdOabj2Of+d3ORB6TRkhyHaA0Y0y2xnV97DRFVi3H4TMjak2hPhlMS9amZk2mNwGI=
X-Gm-Message-State: AOJu0YwA7GqAUAJjWrdaAFb9YaxPSNTGI7FJxh0cqEwRBrn0Bs3cbj3q
	WFyxfSXRGHCfRi6FlZDacAk5LcSj7L8o4RBkQ57p+NC2UB3SLQIB8EA0ce4tDN6aGvL/GDxz4Dd
	v+teeZ2yvvcWCl3/uTPZsGK1hslw=
X-Google-Smtp-Source: AGHT+IEwd0i2/s5viLdj/OKfqcYuxt40ABaA6T03EFS22+C3MrCAHrvBjzjVDSG4hp+GRVWXxZ9YqidURwqOLAjHPcQ=
X-Received: by 2002:a17:906:85b:b0:a3f:aacd:74b1 with SMTP id
 f27-20020a170906085b00b00a3faacd74b1mr4189138ejd.29.1708948210690; Mon, 26
 Feb 2024 03:50:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <0505c197e80e7f476c39a4a6ab31777c67ea818b.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <0505c197e80e7f476c39a4a6ab31777c67ea818b.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 11:49:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4z5wWUmcz39QCE3+YTQM+faq4BJuZ4fqF5Jotoezh9sQ@mail.gmail.com>
Message-ID: <CAL3q7H4z5wWUmcz39QCE3+YTQM+faq4BJuZ4fqF5Jotoezh9sQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] btrfs: verify that subvolume mounts are
 unaffected by tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
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
> ---
> v3:
> Fix subvolume create output with _filter_scratch and its golden output
> add rb
> remove  _require_btrfs_command inspect-internal dump-super
> v2:
> add subvol group
> use $UMOUNT_PROG
> remove _fail for _cp_reflink
>
>  tests/btrfs/311     | 88 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out | 24 +++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100755 tests/btrfs/311
>  create mode 100644 tests/btrfs/311.out
>
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000000..bdabcf6a9814
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,88 @@
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

This requirement should be inside the check_fsid() helper, as pointed befor=
e.

Thanks.

> +_require_btrfs_fs_feature temp_fsid
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

