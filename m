Return-Path: <linux-btrfs+bounces-2596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7985C1DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EC9282485
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0765768F9;
	Tue, 20 Feb 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng5fU9FI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FF762EC;
	Tue, 20 Feb 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448312; cv=none; b=DZenHq5RRcIEw2DUibQoK0TiKu4jOW9g/L/bNzRSUyS6nSrgBhXR866tbOohD3bHnQqEEoiOPzTnW3OO5PlZ+57mp8eOBl1KKpklAx3JVxiheTiMYfjefTVjmV4tfEywGSLq6PoUvFmAI6eMfPCgjdYPbjGdIyzB36/T05onSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448312; c=relaxed/simple;
	bh=CkZ2aKLmzXGOG0gxJBpIiNHI6qnJYjWhFaZtvCxQ9uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWpGEj+EKNYCGy3LOLkc3a8TNqwP6oeXkSaEuOc0DPdNZea3EMfamFrhZYbTBTGWRa5uVa4RI1kPOjArezCyJpClMjZktzV32LpKihHNBUI3B+HjoxfOWiLbn/Xq5Hf98fA076ouoM6ur3sIz1MSaO/+PRkbrCWyTYA+LMNm8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng5fU9FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B7CC433C7;
	Tue, 20 Feb 2024 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448312;
	bh=CkZ2aKLmzXGOG0gxJBpIiNHI6qnJYjWhFaZtvCxQ9uw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ng5fU9FIrooGcBDpe6S6Ruj7zc7vEeqjhcdfnIGuVtc9nT+byg6q+haHFhugPjtPc
	 HSqHNhvex+lMTyYet/MTKYGbtkJh2/gPquEN+3nfnNbTl3OFlj4bMQFeDKJ2g+l/JO
	 RXZ+TqcRfPo0aMW3qFrgpEQCA3nqCnHFQdn8W00vN+dN6BYwpaHoJhaHb/M0Qhkdq9
	 DJ5pYlWwNtPHy7WWzlU6JrjTFF8qg5mUFQgjvxu/38lVrdKB0AmBhd89+YbCXtOrLF
	 VjK59ECO1BDqbfCfbwWeiDOknv1PKs7AzLW1YjCrh3mSmlukSfxMKQNaPX5JAevRBU
	 +8DNI1uHud+nQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5649c25369aso3276076a12.2;
        Tue, 20 Feb 2024 08:58:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4If7K1rxH4rRZdCibLZIMNxX4sKamNSb41K/2guHEfbj70BVvjMcXyAuGcM5chSxGF7Uae0CIxBQa93OVJy08RdDAwbmUEDl5FSk=
X-Gm-Message-State: AOJu0YwPGhgAK5+ScL4jKGN4RBek5Lsi5T1yZOj74ja6TD8qWubUWHfy
	0Q0byOuZlf2SNiqV/NE8nEFvyvHwvQz5H0zWg5v548OLBiOB/mLsp8rIXyEBnmU9awq2VSfqU2m
	LCMgBmgW3sZt2k++GSnF/+HEruGQ=
X-Google-Smtp-Source: AGHT+IEyD9q6FMLwi/Nd2dIjL3zPUbZXdxh6pgII5lcKMcuEiCvkcZOZYqIzbrUAwMdzl3l6H+t1c3DRXPFzQj0YVzY=
X-Received: by 2002:a17:906:b0d9:b0:a36:5079:d6cb with SMTP id
 bk25-20020a170906b0d900b00a365079d6cbmr11055830ejb.56.1708448310703; Tue, 20
 Feb 2024 08:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <7d0b939fdcb0052c184e18226fcbbc4454508243.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <7d0b939fdcb0052c184e18226fcbbc4454508243.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:57:53 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6JwgSbcnN4fs8poyOj_z8P9HxqBEUUduiuLqUdnWK_0w@mail.gmail.com>
Message-ID: <CAL3q7H6JwgSbcnN4fs8poyOj_z8P9HxqBEUUduiuLqUdnWK_0w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] btrfs: validate send-receive operation with tempfsid.
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:50=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Given concurrent mounting of both the original and its clone device on
> the same system, this test confirms the integrity of send and receive
> operations in the presence of active tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Organize changes to its right patch.
>  Fix _fail erorr message.
>  Declare local variables for fsid and uuid.
>
>  tests/btrfs/314     | 81 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/314.out | 23 +++++++++++++
>  2 files changed, 104 insertions(+)
>  create mode 100755 tests/btrfs/314
>  create mode 100644 tests/btrfs/314.out
>
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> new file mode 100755
> index 000000000000..59c6359a2ad8
> --- /dev/null
> +++ b/tests/btrfs/314
> @@ -0,0 +1,81 @@
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
> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_mkfs_uuid_option

So same as before, these last 2 _require_* are because of the
mkfs_clone() function,
defined at common/btrfs, so they should be in the function and not
spread over every test case that calls it.

Thanks.

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

