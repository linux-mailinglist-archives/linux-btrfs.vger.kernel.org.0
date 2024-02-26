Return-Path: <linux-btrfs+bounces-2796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2495867457
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58474286FE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA66A5FDAC;
	Mon, 26 Feb 2024 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2TPGvI4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2D5B1F6;
	Mon, 26 Feb 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949240; cv=none; b=Mbhkpy70HY70XDA44rY0C1Pj6SnSAnUIsIonHqMp96tLx4q9iBS01G0THh0xSjGkItJEbIjiRmAuYtmapsBMqRYGYgYcXl46u2ILhTbdhCfHSxbKN39/s+Vzk8NMxrlpa7Pxj+45mT0e4MYhuI4djwziFCEmCivoPgY2TWFl9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949240; c=relaxed/simple;
	bh=ZrFpr2mlIM2plcM+1aB+JVIIoirbM/ogUVRtLtjJCWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDoiNkmfgiTbDxfK6agJwGLJvXQ/tMdQ7bZX+THaOaMAi09WXg5jzKUrFf0fNPrgO3x2ttYUTvC52HP+GIKo+ZR8WyO/TFRH5vQ87tgbvusRRWc4qIO4KAFcxH/6dtQE/hTQ6TFVNVq85baTNWnSKEvdNX8jyFLWjxAQOTPHhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2TPGvI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD37C433F1;
	Mon, 26 Feb 2024 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708949240;
	bh=ZrFpr2mlIM2plcM+1aB+JVIIoirbM/ogUVRtLtjJCWc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B2TPGvI49iL4cXIcAlF0bAb7qeLycLYhlUlKQBPT9oC5w17EnnJivUiRwsop85DyW
	 Zro2znSyIfQldoW6giKMw16RIiWR3MYcChACGQ1hnkQsceZZtWxIjoWbI5xt4hO+vk
	 5m4pn/TwVSu/mMzWNf+cQRL8NegHeS9XNVOttGDeQ/LnXT/o4Gohh6W2FhnCqy59yP
	 ULhKpxUBgDsab4NIrn+0xjSKqAzpoV68IeZgNT9dE2zcsmS/2ihj6wFTv0jSNkln2m
	 PHcIuz+l0iSFR9dKGoe485s3X3RPj6OWp+j/8FKWuUwOz4fmm29rgrugNaBbEF7Igm
	 b3ACbWWZwMrig==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a43037e40dcso201271766b.3;
        Mon, 26 Feb 2024 04:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVP32wymPAlGq9WWE1mABW9qxpuBoY6p+5Sdc7ZRR0o0EiBPzp9kZR7kw/x3YlvJwdzkMV6uc+ctsDvjDMLqjbfHOd/8ar+WAR6AN0=
X-Gm-Message-State: AOJu0YyVynQrL8LmX0cuagXBwf5dKdn1Ptger//nBy714HKWsp7/owCm
	FRk5iHHFwYzkiQLwVHd2jknfZsWlDBVskdzH3CSt9XEDKomH6dRFhTm27+JEjtCk0j1TMoKF/iX
	5Cq1EzFIoRv/giord0/89zfmB0k4=
X-Google-Smtp-Source: AGHT+IFzSBHVR/CJU/Ebdjm7dU1iIEV4mIBPeK5YUvaoePvTj80o98GSGOXfazOcgAEpYxVCI85KgrV6EZ5uj1HutSg=
X-Received: by 2002:a17:906:6701:b0:a3e:d7fe:4c4d with SMTP id
 a1-20020a170906670100b00a3ed7fe4c4dmr4372809ejp.57.1708949238911; Mon, 26 Feb
 2024 04:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <afc075746adfa6c6c9b6cdc73387606bc33b6933.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <afc075746adfa6c6c9b6cdc73387606bc33b6933.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 12:06:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H48P5NFqvihh2MJWrSEz_Kuup7VXMBSTmeGer4Gy788sg@mail.gmail.com>
Message-ID: <CAL3q7H48P5NFqvihh2MJWrSEz_Kuup7VXMBSTmeGer4Gy788sg@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] btrfs: validate send-receive operation with tempfsid.
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Given concurrent mounting of both the original and its clone device on
> the same system, this test confirms the integrity of send and receive
> operations in the presence of active tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
>  Drop prerequisite check in the testcase
>
> v2:
>  Organize changes to its right patch.
>  Fix _fail erorr message.
>  Declare local variables for fsid and uuid.
>
>  tests/btrfs/314     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/314.out | 23 +++++++++++++
>  2 files changed, 102 insertions(+)
>  create mode 100755 tests/btrfs/314
>  create mode 100644 tests/btrfs/314.out
>
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> new file mode 100755
> index 000000000000..4a5b1ed2c06f
> --- /dev/null
> +++ b/tests/btrfs/314
> @@ -0,0 +1,79 @@
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
> +_begin_fstest auto quick snapshot send tempfsid
> +
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
> +       rm -r -f $tmp.*
> +       rm -r -f $sendfile
> +       rm -r -f $tempfsid_mnt
> +}
> +
> +. ./common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_btrfs_sysfs_fsid

This requirement of the sysfs fsid path is not needed in the test, as
it's not used anywhere in this test (likely copy-pasted from other
tests in this patchset).

Thanks.

> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
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
> +       # Use first 2 devices from the SCRATCH_DEV_POOL
> +       mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> +       _scratch_mount
> +       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
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
> +       echo -e -n "Send:\t"
> +       md5sum  ${src}/foo | _filter_testdir_and_scratch
> +       echo -e -n "Recv:\t"
> +       md5sum ${dst}/snap1/foo | _filter_testdir_and_scratch
> +}
> +
> +mkdir -p $tempfsid_mnt
> +
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
> index 000000000000..21963899c2b2
> --- /dev/null
> +++ b/tests/btrfs/314.out
> @@ -0,0 +1,23 @@
> +QA output created by 314
> +
> +From non-tempfsid SCRATCH_MNT to tempfsid TEST_DIR/314/tempfsid_mnt
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
> +Send SCRATCH_MNT
> +At subvol SCRATCH_MNT/snap1
> +Receive TEST_DIR/314/tempfsid_mnt
> +At subvol snap1
> +Send:  42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
> +Recv:  42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/snap1=
/foo
> +
> +From tempfsid TEST_DIR/314/tempfsid_mnt to non-tempfsid SCRATCH_MNT
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Create a readonly snapshot of 'TEST_DIR/314/tempfsid_mnt' in 'TEST_DIR/3=
14/tempfsid_mnt/snap1'
> +Send TEST_DIR/314/tempfsid_mnt
> +At subvol TEST_DIR/314/tempfsid_mnt/snap1
> +Receive SCRATCH_MNT
> +At subvol snap1
> +Send:  42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> +Recv:  42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> --
> 2.39.3
>

