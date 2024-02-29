Return-Path: <linux-btrfs+bounces-2917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF8886C84E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E10A28997F
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29F7CF0D;
	Thu, 29 Feb 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwR7tEEj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3857C6E0;
	Thu, 29 Feb 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207073; cv=none; b=LXf3anslvZlV8lFU5FUw0glzFh/zGUSlaNpAyStbW7hRCw4SRGZIDsNM/0InrmYwKTGGkdvOVIvxZ+hZtSfRknN2qQX4+eJwoJM0d5DaLqpPK7H3CmIp6nWqattqcPNaclDQ2+XI3uJDsywd+yyGQfnD32KIG2RYRg2GdJfSDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207073; c=relaxed/simple;
	bh=NFfObFfGIhL54H9d3WHAoqv+5eTbg84/cEkUHQE7PQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv5IDieIZDy6WlvJq5TtTffVLLDmc6WGFnOJ62T74qAqVkDPRMXYwZQYEs66TnrCsrC6FN9FLrnmGDcZawlzMQFh0SttB3x+fO3M7wTJhMbTPX1G9EsKrEIwsGUEXRhjYtJujFXMNXX4z1vBs/PnFxXJoQn2AxFjloSamkjrZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwR7tEEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3EFC43390;
	Thu, 29 Feb 2024 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709207072;
	bh=NFfObFfGIhL54H9d3WHAoqv+5eTbg84/cEkUHQE7PQI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UwR7tEEjII1ZYVU9Tvr3Lbn0NMM/fRpPqwAcBfjccOxJ4K/4N8ot4D1cMXwFrbnxm
	 mIq669CbxBUc1TmhAcNAZyZaKqTQ/5riPwHxyYTWwT19B30X9vJ+b7LrnrXvP6lxQc
	 7FhsPqr+D6rFEH5sBCz90FmxD18d6AyLE1+vYr+WAR1jTDfr49QfZKVtLrSXtIxxWT
	 PYPncANSlfReLWtD7f8uN/itkjQ/css2Yw1+JJwF4bM7oeI8Ffs7EqAxMyUEsCXqMW
	 Z+XerloCvJgCgqpRNwR3TGPJFBXODQrs/QDRB5A9c21/XCRzC9w5yxSC8udV+I1BBY
	 +EPLCmszJI+rw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a444205f764so72331866b.2;
        Thu, 29 Feb 2024 03:44:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5TfYpZfKqKTAtM1o/BKmXtlRwFx21PlSQw2qN2fkJbHPpqXbwT4jZPNIOw4p8xmQ2+N84M9gJs6X6HfusgJorzTDFuejxtPGfFlk=
X-Gm-Message-State: AOJu0YzlvE9y6CVjZjjkeGeNcaEgPFlU4SUtSTplZpKTYf/h1ZhdsDD9
	2ZqSUuKyaB2mzHHzCTkuqfVfD8spEJzlEvf4ta3FAu+g8HquZOCLRqIIqOHWz+QAzGgrndACxK9
	qdJqa0e8b0vnpobibJpylzgsMO8k=
X-Google-Smtp-Source: AGHT+IGKJcf/4ZgjDijcZWHELwEGA4YjyovccF3Qg7wWac6tu0wkUgcBSyXcKmgvFny84vKlIW7N33kTRl79x+NQXrY=
X-Received: by 2002:a17:906:dfca:b0:a3f:2b6f:6d57 with SMTP id
 jt10-20020a170906dfca00b00a3f2b6f6d57mr1183511ejc.29.1709207071195; Thu, 29
 Feb 2024 03:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709162170.git.anand.jain@oracle.com> <3fbe8aba0a33574e4932dc2e1f3c8fc9f39be56c.1709162170.git.anand.jain@oracle.com>
In-Reply-To: <3fbe8aba0a33574e4932dc2e1f3c8fc9f39be56c.1709162170.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 29 Feb 2024 11:43:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7ZwCM63EJ7KskdgWpmHQhHHBrpcdPZcx_6VPeZ1D+NUA@mail.gmail.com>
Message-ID: <CAL3q7H7ZwCM63EJ7KskdgWpmHQhHHBrpcdPZcx_6VPeZ1D+NUA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] btrfs: validate send-receive operation with tempfsid.
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:51=E2=80=AFAM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Given concurrent mounting of both the original and its clone device on
> the same system, this test confirms the integrity of send and receive
> operations in the presence of active tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  tests/btrfs/314     | 78 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/314.out | 23 +++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/314
>  create mode 100644 tests/btrfs/314.out
>
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> new file mode 100755
> index 000000000000..887cb69eb79c
> --- /dev/null
> +++ b/tests/btrfs/314
> @@ -0,0 +1,78 @@
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
>

