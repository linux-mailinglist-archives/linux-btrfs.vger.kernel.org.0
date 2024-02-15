Return-Path: <linux-btrfs+bounces-2431-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219B8563C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D8B1C23560
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523DE12F39E;
	Thu, 15 Feb 2024 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWzAiua+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F318EA2;
	Thu, 15 Feb 2024 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001811; cv=none; b=qP9Wt9530P/IFrTNLC0GilQy74fVDREDubmTeNj2EtopUGNdNDu6DJzN91B9kzrn6czfhDk95blcJ5sr/MvyL6J8twHemTysY9N2XgEMLJYbnkk44brPjHAEBnTqXoT9z68eFSuGRgL191TWZh37gQ1uk9IAhWakONj3fXbl/IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001811; c=relaxed/simple;
	bh=Ml5tgvV8ughg2IkbRxrNo2xyQ1bMfC3yj1lm3BEUyRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp7nzjMW2NLWe97lt7sjO2a8W3P2fmRFF55+4FX7keJoA2Co5Cki1d4Plj1wGRjp1yvTEIdyUoPdyonthIKRsodVLF3NHIdWu/Bs+hescNW6LNACl3pvQ7JaJ5yTt+3CSdzRXlq2XzCyJvhJss05tQ/pe9VXP+sTC7dBCcWhV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWzAiua+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0995C433C7;
	Thu, 15 Feb 2024 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708001810;
	bh=Ml5tgvV8ughg2IkbRxrNo2xyQ1bMfC3yj1lm3BEUyRI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UWzAiua+CW273C+SUWq27TlaGDaJng0c3YxvoTKhk64OhvpeCxaRB5hxOqFbHjq1U
	 Ap1fw2fKCLaazWOfy8U4EyHVqzmBJlcV1r+DwRqq6vXVH1/yGqVzD+1RcdNfzSolir
	 NOu99B5MTP96NUvvyeHLb2l7tDKLcWHyVpbDr29oQkbaKE39mtKAuCXKdCiwyDZOY9
	 Ez2AKHAHnkAbQLuPFBgkHDw3pRBQJECweRVIm3kqoeNC8gPuv5zImWqIRhLstkm/ER
	 5EdKcGk+W59HtKj6f6xtYhldTOs6HS7yKxomEv5aCJHqhXSYVvxSF/+sBJBy9XwMh6
	 Qa5P3qi6gkpXQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1064409e87.1;
        Thu, 15 Feb 2024 04:56:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQHnCkmbeDzDKTq0X9pK5yI5QbIIrFTpnTM9Q8WK4B7dG7OOwkTEXujbd+0n1rPYlprMAIBSEGVDkCQoVxBM0JjV2+5KmcODvK4ak=
X-Gm-Message-State: AOJu0YzHvEfR2LYrF9fQytctL7gDbhYmQmt/E16Rhbr98TPneonSpgD3
	Zg43cO0CtFLSLf46SJ9C5m6Ijs5cyWnruKE+lUrPSwdkRI3/Clba3f07E2bp5Bm5XHBTXuFFIxp
	ZzF2xIQrHW0fLmdBu7IebfIzWutk=
X-Google-Smtp-Source: AGHT+IEP4ZLvfSnLZHe2WFgoKtaT1VQd2+jsXj4+AN2PRW+yyvhdmWJH3XBoRn07ad+m52RQ4x2HELA4aQGqMwnbt/M=
X-Received: by 2002:a05:6512:3ca5:b0:511:87c6:3060 with SMTP id
 h37-20020a0565123ca500b0051187c63060mr1958061lfv.12.1708001809101; Thu, 15
 Feb 2024 04:56:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707969354.git.anand.jain@oracle.com> <cc3da235204c07e79e3655bad1692e1928c11002.1707969354.git.anand.jain@oracle.com>
In-Reply-To: <cc3da235204c07e79e3655bad1692e1928c11002.1707969354.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 12:56:12 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5eyD53Vv=p07wCZhJgoKmtGC0dF-nEqcP8Mh+HmAG7JQ@mail.gmail.com>
Message-ID: <CAL3q7H5eyD53Vv=p07wCZhJgoKmtGC0dF-nEqcP8Mh+HmAG7JQ@mail.gmail.com>
Subject: Re: [PATCH 11/12] btrfs: validate send-receive operation with tempfsid.
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:35=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Given concurrent mounting of both the original and its clone device on
> the same system, this test confirms the integrity of send and receive
> operations in the presence of active tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/314     | 85 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/314.out | 30 ++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100755 tests/btrfs/314
>  create mode 100644 tests/btrfs/314.out
>
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> new file mode 100755
> index 000000000000..1ceb448d2a5e
> --- /dev/null
> +++ b/tests/btrfs/314
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 314
> +#
> +# Send and receive functionality test between a normal and
> +# tempfsid filesystem.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick snapshot tempfsid

Missing 'send' group.

> +
> +_cleanup()
> +{
> +       cd /
> +       umount $tempfsid_mnt 2>/dev/null

$UMOUNT_PROG

> +       rm -r -f $tmp.*
> +       rm -r -f $sendfile
> +       rm -r -f $tempfsid_mnt
> +}
> +
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_btrfs_sysfs_fsid
> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_mkfs_uuid_option
> +
> +_scratch_dev_pool_get 2
> +
> +# mount point for the tempfsid device
> +tempfsid_mnt=3D$TEST_DIR/$seq/tempfsid_mnt
> +sendfile=3D$TEST_DIR/$seq/replicate.send
> +
> +send_receive_tempfsid()
> +{
> +       local src=3D$1
> +       local dst=3D$2
> +
> +       echo ---- $FUNCNAME ----

What value do we get from echoing the function's name?
It's the only test function, plus the callers of the function already
echo something more useful.
Can be removed.

> +
> +       # Use first 2 devices from the SCRATCH_DEV_POOL
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +       _scratch_mount
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +
> +
> +       $XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs=
_io
> +       $BTRFS_UTIL_PROG subvolume snapshot -r ${src} ${src}/snap1 | \
> +                                               _filter_testdir_and_scrat=
ch
> +
> +       echo Send ${src} | _filter_testdir_and_scratch
> +       $BTRFS_UTIL_PROG send -f ${sendfile} ${src}/snap1 2>&1 | \
> +                                               _filter_testdir_and_scrat=
ch
> +       echo Receive ${dst} | _filter_testdir_and_scratch
> +       $BTRFS_UTIL_PROG receive -f ${sendfile} ${dst} | \
> +                                               _filter_testdir_and_scrat=
ch
> +       echo -e -n "Send:\n"

What's -e and -n for?
This could be just:

echo Send:


> +       sha256sum ${src}/foo | _filter_testdir_and_scratch

Previous tests use md5... here sha256.
What's the reason? This is highly inconsistent...

Also we have _md5_checksum(), which prints just the checksum and
filters out the file path.
Or  just call _hexdump and match with the golden output.


> +       echo -e -n "Receive:\n"

Same here. This can be just:

echo Receive:

> +       sha256sum ${dst}/snap1/foo | _filter_testdir_and_scratch
> +}
> +
> +mkdir -p $tempfsid_mnt
> +
> +echo Test Send and Receive

Useless message too, we know this is a send/receive test, doesn't test
other features.

Thanks.

> +echo -e \\nFrom non-tempfsid ${SCRATCH_MNT} to tempfsid ${tempfsid_mnt} =
| \
> +                                               _filter_testdir_and_scrat=
ch
> +send_receive_tempfsid $SCRATCH_MNT $tempfsid_mnt
> +
> +_scratch_unmount
> +_cleanup
> +mkdir -p $tempfsid_mnt
> +
> +echo -e \\nFrom tempfsid ${tempfsid_mnt} to non-tempfsid ${SCRATCH_MNT} =
| \
> +                                               _filter_testdir_and_scrat=
ch
> +send_receive_tempfsid $tempfsid_mnt $SCRATCH_MNT
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/314.out b/tests/btrfs/314.out
> new file mode 100644
> index 000000000000..eb0010da264e
> --- /dev/null
> +++ b/tests/btrfs/314.out
> @@ -0,0 +1,30 @@
> +QA output created by 314
> +Test Send and Receive
> +
> +From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
> +---- send_receive_tempfsid ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Send SCRATCH_MNT
> +At subvol SCRATCH_MNT/snap1
> +Receive TEST_DIR/314/tempfsid_mnt
> +At subvol snap1
> +Send:
> +0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  SCRATC=
H_MNT/foo
> +Receive:
> +0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  TEST_D=
IR/314/tempfsid_mnt/snap1/foo
> +
> +From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
> +---- send_receive_tempfsid ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/3=
14/tempfsid_mnt/snap1'
> +Send TEST_DIR/314/tempfsid_mnt
> +At subvol TEST_DIR/314/tempfsid_mnt/snap1
> +Receive SCRATCH_MNT
> +At subvol snap1
> +Send:
> +0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  TEST_D=
IR/314/tempfsid_mnt/foo
> +Receive:
> +0598aa54768194ade580b9806ac98ace43a0310aeceae95762f62491625eee52  SCRATC=
H_MNT/snap1/foo
> --
> 2.39.3
>
>

