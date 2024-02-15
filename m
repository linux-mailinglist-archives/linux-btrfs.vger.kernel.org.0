Return-Path: <linux-btrfs+bounces-2425-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E62856302
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B7F1F23A66
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361312BF3D;
	Thu, 15 Feb 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4DEwY9g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FA12C528;
	Thu, 15 Feb 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999656; cv=none; b=D2y1ILBeHqaNBKV3MQ5VtevAgathZSR5BIC/bMfamBNMWtm0MgfwNt21rxXfr+ukBrzoDv1ek52vFA2fLQ2DmKE+haefId1mSeAQ6nHORFm9ughEdon/ZFyPv8YIAuBKeDrbRZmas+TyWj1pvuxan5xs3XUcFbqWcSpVQK5kato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999656; c=relaxed/simple;
	bh=GWbF7kGo4/aucWgCFOoUkCxV2Pn5QHGBwklQeT8SANo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXwJj9+xdBgfC/iQ70xtSRvOQOzjGnBvIgKYxTJwmKrRhvRE5dzvhlYz/kSPRHOS6PhCLLTiMdSKMY9BenUenLfsZ18emA4N+Bky7q2cQMf2iZ9BRiiwMjBTx/yCA5ZWgA92BHik2dFdmtzK5yGEPh3oqigl/mIBdIoL4LpSv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4DEwY9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B14C433C7;
	Thu, 15 Feb 2024 12:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707999655;
	bh=GWbF7kGo4/aucWgCFOoUkCxV2Pn5QHGBwklQeT8SANo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l4DEwY9g/c13FWu5Q7YWmhWpXXdNmJQAY4XowL+o2755/N4Z3XzKMus0b3adHmpfC
	 KWhIZTVcki8B6wrjatIr2AfXuTv802YVL4deE8kmkej//jVBrEydDUXxSu7KfbNv/Z
	 VEui/Sn6PUXqHTIgNX/nXPaUDWYx/ObEn4h/LBlWwADkjBlMTigUJIbGT5RnAS70B/
	 o9fs2iB0wkt7nShsD5fXb0Z9NlYqZzMh/wheFi1apgBnGhwtryEXb1SeZc2pK+daEe
	 tXAL5T0lAWadRQMcySLizPB2VhhK9EX1mfWk3/7rjGoRoBmRU/rCIwieG3yM7GTbpy
	 79UuB5caFJOUw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso268570a12.2;
        Thu, 15 Feb 2024 04:20:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWqZ5CwctMEgpU15BwSri0LXErDN0gikVVQHqTPWhmPa1deV9Y6i6r2YPMHvHmZcQZ/Fx59PIC1kjMoEHE6RFUnWyU63Aavvpkk9rM=
X-Gm-Message-State: AOJu0Yyzx30w+nA2FHzCxEOc1/a3rlxLv/P2itvDTbUO9jVRxPW8+OGe
	2zC88v++UmGJnaRv2VEzU/6908PMU3rychPnl41YmLFd7ofEnW0rLRjk/jozMMUdngi56f8VwdF
	oV2by8J9RiqC8fljNoAWNjPP+fsk=
X-Google-Smtp-Source: AGHT+IEfZqnEFC+uujZcxY7OmDUGb5cpDorh+1t5ePPn051gLwRPMR3lmx8H+JyVJOw14xQzZdI76rpzQj84Q8ZRCzE=
X-Received: by 2002:a17:906:e088:b0:a38:9923:46da with SMTP id
 gh8-20020a170906e08800b00a38992346damr1295817ejb.20.1707999654361; Thu, 15
 Feb 2024 04:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <c5db412fcb3d6d7dedc2f75d1384f78a5bbc2cb5.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <c5db412fcb3d6d7dedc2f75d1384f78a5bbc2cb5.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:20:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4TN83FV+At=pp5n6AQGCUQ=WfOY9V81EPz63zoiqk-5A@mail.gmail.com>
Message-ID: <CAL3q7H4TN83FV+At=pp5n6AQGCUQ=WfOY9V81EPz63zoiqk-5A@mail.gmail.com>
Subject: Re: [PATCH 05/12] btrfs: verify that subvolume mounts are unaffected
 by tempfsid
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> The tempfsid logic must determine whether the incoming mount request
> is for a device already mounted or a new device mount. Verify that it
> recognizes the device already mounted well by creating reflink across
> the subvolume mount points.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/311     | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/311.out | 24 ++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100755 tests/btrfs/311
>  create mode 100644 tests/btrfs/311.out
>
> diff --git a/tests/btrfs/311 b/tests/btrfs/311
> new file mode 100755
> index 000000000000..71c26055fa1e
> --- /dev/null
> +++ b/tests/btrfs/311
> @@ -0,0 +1,91 @@
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
> +_begin_fstest auto quick tempfsid

Also 'subvol' group, as the test creates a subvolume and makes
something with it.

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       umount $mnt1 > /dev/null 2>&1

Use $UMOUNT_PROG please.

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
> +       _cp_reflink $SCRATCH_MNT/foo $mnt1/bar || \
> +               _fail "reflink failed, check if mounted as the same devic=
e"

What's the _fail for?
If cp fails it outputs an error and causes a mismatch with the golden
output, automatically failing the
test and in an easy way to notice the failure was due to a cp failure...

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
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo =
| \
> +                                                               _filter_x=
fs_io
> +
> +       echo Mounting a subvol
> +       _mount -o subvol=3Dsubvol $SCRATCH_DEV $mnt1
> +
> +       _cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar || \
> +                       _fail "reflink failed, not the same device?"

Same as above.

Thanks.

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
>

