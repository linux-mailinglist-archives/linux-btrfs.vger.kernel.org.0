Return-Path: <linux-btrfs+bounces-2432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA58563EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 14:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2881C1C23AAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9B712F58A;
	Thu, 15 Feb 2024 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx6E4KOf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F2A58ABC;
	Thu, 15 Feb 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002230; cv=none; b=tG0z0UrUM4o6mU+Raza1gHkKVj5qxRIRUicdyu3zQ1ux0eng0zkX4SokXCbKm/29ovmVsxwCN/OUkdc2BacPoHy6ZOxJp73kpLIERmhHcbbIXMJQJcxMJeB7K5//yuqG447EKWoBbfrR2GsEOsK2aqdBbtAS52FtWeVOh8ieqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002230; c=relaxed/simple;
	bh=cSiqPdkGsSl5r6mRmKhcO/Xcytc2FP/LhJihLhlLWpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9Y/A920iT7G8EJ7CWOPhZJkZe4m1Yfa5gTwZnIJOMjKdPcWjZ2ExJGylymGoZcRc3l2j6XUMEPyrw6wUkJpD6blCMJk7dBgRQQGXKxSyrtukzaD0EGor93cvEBG2toeaXwR0Zj72U7Tghj/K9KYgG3OYU0Tnm1pwD5wj28q77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx6E4KOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D844C433F1;
	Thu, 15 Feb 2024 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708002229;
	bh=cSiqPdkGsSl5r6mRmKhcO/Xcytc2FP/LhJihLhlLWpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qx6E4KOfljMTlXZOoiQfrlpyhCdAv+fF2RlZWf9mubVeFs/PolEhAUI5nyW7kGWHQ
	 dcIKBisxKcsQsMoMiJqpcbNDrn83jwvQCNITinf6Vbc5HzDb2XoyAVNhmMaNK7jWrb
	 /5wP1YKvgBeWDWSNMzJdnmnfwWHpUPwvl7hpBjImiNEmVU7WmJPTdv5fyUdbg9JS2l
	 HykDWQaWjLf1x67Fws1M5jVq1BJqQbYS+W+7I7LR2BzbapHK9uGcYGQJRKSGpJ+tB4
	 xaTCK0JdDzLjNhenFK43HnVMn4N7srv3bycGzB5OLEfG9huV9+ijoya4OfKRCknpxA
	 IdwcuDUP8POOA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso1165209a12.3;
        Thu, 15 Feb 2024 05:03:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCViX0ety8yDmlBuTZ5x386pASwl8x0phxr/vmvYpPeTmOvMgJ857kvh2mZf3ahE10h1tqf/4rDl+5dE6uoluf9ZQ6FnsrDhB2dt0OE=
X-Gm-Message-State: AOJu0YxgaoQzZmNHY9XcebeO9gef6ohgijXU4vPeXLyf7tBBwj1KehOV
	/+gdfG0Q3O3k6ucwHSqZI3Pli2mT3h1644uaAbQxedNX3vQfdYTBf4r/II1VBb6tiqsFNtyc0yo
	u3ZXSv9xfQ3IG297HVJ3E7kaH6rg=
X-Google-Smtp-Source: AGHT+IE6XqtyNUy5RgHToqWjbeCSja3zyxdUFeT16JMuR11Iz3fTdDz5P1hCUu1twYFbXczawvDxNqy+NjbYJdAy3QY=
X-Received: by 2002:a17:906:395b:b0:a3c:d7a5:6ab1 with SMTP id
 g27-20020a170906395b00b00a3cd7a56ab1mr1223256eje.0.1708002227971; Thu, 15 Feb
 2024 05:03:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <325a9476e06cebee3752d32fd06e75b2f478b8bc.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 13:03:11 +0000
X-Gmail-Original-Message-ID: <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com>
Message-ID: <CAL3q7H77SEYPongbHn9auS7jyvOetD-8gD3oyQ3e+7pJuPVbSQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] btrfs: test tempfsid with device add, seed, and balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Make sure that basic functions such as seeding and device add fail,
> while balance runs successfully with tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/filter.btrfs |  6 ++++
>  tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/315.out | 11 +++++++
>  3 files changed, 96 insertions(+)
>  create mode 100755 tests/btrfs/315
>  create mode 100644 tests/btrfs/315.out
>
> diff --git a/common/filter.btrfs b/common/filter.btrfs
> index 8ab76fcb193a..d48e96c6f66b 100644
> --- a/common/filter.btrfs
> +++ b/common/filter.btrfs
> @@ -68,6 +68,12 @@ _filter_btrfs_device_stats()
>         sed -e "s/ *$NUMDEVS /<NUMDEVS> /g"
>  }
>
> +_filter_btrfs_device_add()
> +{
> +       _filter_scratch_pool | \
> +               sed -E 's/\(([0-9]+(\.[0-9]+)?)[a-zA-Z]+B\)/\(NUM\)/'

Why do we need this new filter?
We are testing for a failure, where none of this is relevant except
filtering device names.

The test can just filter with  _filter_scratch_pool only.

> +}
> +
>  _filter_transaction_commit() {
>         sed -e "/Transaction commit: none (default)/d" \
>             -e "s/Delete subvolume [0-9]\+ (.*commit):/Delete subvolume/g=
" \
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> new file mode 100755
> index 000000000000..7ad0dfbc9c32
> --- /dev/null
> +++ b/tests/btrfs/315
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
> +#
> +# FS QA Test 315
> +#
> +# Verify if the seed and device add to a tempfsid filesystem fails.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume seed tempfsid
> +
> +_cleanup()
> +{
> +       cd /
> +       umount $tempfsid_mnt 2>/dev/null

$UMOUNT_PROG

> +       rm -r -f $tmp.*
> +       rm -r -f $tempfsid_mnt
> +}
> +
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_btrfs_sysfs_fsid
> +_require_scratch_dev_pool 3
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_mkfs_uuid_option
> +
> +_scratch_dev_pool_get 3
> +
> +# mount point for the tempfsid device
> +tempfsid_mnt=3D$TEST_DIR/$seq/tempfsid_mnt
> +
> +seed_device_must_fail()
> +{
> +       echo ---- $FUNCNAME ----
> +
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +
> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV}
> +       $BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
> +
> +       _scratch_mount 2>&1 | _filter_scratch
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_test=
_dir
> +}
> +
> +device_add_must_fail()
> +{
> +       echo ---- $FUNCNAME ----
> +
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +       _scratch_mount
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
> +                                                       _filter_xfs_io
> +
> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} 2>=
&1 |\
> +                                                       _filter_btrfs_dev=
ice_add

We are testing for failure, so no need for the new filter
_filter_btrfs_device_add.
Just filter through  _filter_scratch_pool here and nothing more.

Thanks.

> +
> +       echo Balance must be successful
> +       _run_btrfs_balance_start ${tempfsid_mnt}
> +}
> +
> +mkdir -p $tempfsid_mnt
> +
> +seed_device_must_fail
> +
> +_scratch_unmount
> +_cleanup
> +mkdir -p $tempfsid_mnt
> +
> +device_add_must_fail
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> new file mode 100644
> index 000000000000..32149972beb4
> --- /dev/null
> +++ b/tests/btrfs/315.out
> @@ -0,0 +1,11 @@
> +QA output created by 315
> +---- seed_device_must_fail ----
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exis=
ts.
> +---- device_add_must_fail ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +ERROR: error adding device 'SCRATCH_DEV': Invalid argument
> +Performing full device TRIM SCRATCH_DEV (NUM) ...
> +Balance must be successful
> +Done, had to relocate 3 out of 3 chunks
> --
> 2.39.3
>
>

