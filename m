Return-Path: <linux-btrfs+bounces-2595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E3C85C1D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7E81C2390B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C921D768F5;
	Tue, 20 Feb 2024 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjS+QaNq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22A1C2E;
	Tue, 20 Feb 2024 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448198; cv=none; b=VUswjRWtx0JErARsx+wTpoElwQFFGsJQFSr4quQ7A3ihzkd8Ba4kB0d2Ov0wZcYAmSZwFiWj2CMN3Ic39/+fHZdYkICebgSI5GfEgyZWGuW+ClKxXYwk1wYWLjHJWk1VcH/oA2Cww3idDAYWLsrkfS4hZ1QBbN8D6fEIwSkzsLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448198; c=relaxed/simple;
	bh=4u3MOmfj5CdsVIPIrdcxGxN8UiQyIcsDVw3TA0yWrEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHi8oePKWNzbtzsJ4sTuYfDdwnrxm3IlsPou091cOL1MLfQGPg7G95LqIXFNKn97TUdduQRQORbBvezpnr5rqKhpaIeZWd2oKr2acRTSzA4vx2+S3Mu64y8xdsll2H6YFDuvi5em6kCKoNy2qUsPt0qlpJ0jxomJuxEjN63AGFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjS+QaNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C885C43390;
	Tue, 20 Feb 2024 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448197;
	bh=4u3MOmfj5CdsVIPIrdcxGxN8UiQyIcsDVw3TA0yWrEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TjS+QaNq/QUzMuchCSeANfsHOWXnQrsfZpbmQFaiosLf8EmV/agGD76SPU3Ky/OA7
	 +PcHiqAVPn09K32EY+3K+scFZ5r4K+EfYTTmwdnMbNGzWVlyLhOstvPWOZh5LfUlC7
	 c6TjgNgLEzYGGji95Zvhuc1KDQ9nEWljSG4lG3Uv3boyX2o/xFuvunS8THaA1Xntk0
	 ZRQzYnpify7IgC5XmajSRZUiP3xdFCKn+9AoSd+qEsX0XVpUQ1kdJxeDjAJj0YqHV/
	 VljmL6ik2ouokJunUfMIfB08XoxdZDtJmUPPzwpTqyDrAt35jv5Xd/3OV9Tvmz3OaV
	 F+A7Gob4ZoiKA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so3932763a12.3;
        Tue, 20 Feb 2024 08:56:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNM74Rsfrpl1eX0ux6MEdzYawD/TOJkJUYWjGsCwLhnOhSrxqaEu7uXuoZRxzSXkjP6P83vHPLWOmWhwWH69BnsHBW0JpTHe4h4rA=
X-Gm-Message-State: AOJu0YyqLZRQBmGN+GvKyldbfo8OQcQQt6DTPagqYdKO4RFIxeLMCJaU
	Aaae+kuOpTv+a8dZcU1s5KTgIb/UHSXQGmDtszCTyFe/DLhItsWYPS1xxLg9HMeGgY1aOl7Cbbs
	DeM8NNnBUddnYmVKABP6wCGE0RjQ=
X-Google-Smtp-Source: AGHT+IF6iEmNfFz7h1TudvtU3JFqurYV8zusv/HvUvHXte20Sf64BVMOMubUBwvAdlTX3d9U0lhfdUy3372k4YKzrFQ=
X-Received: by 2002:a17:906:f8c8:b0:a3f:cf7:c978 with SMTP id
 lh8-20020a170906f8c800b00a3f0cf7c978mr1692488ejb.18.1708448195811; Tue, 20
 Feb 2024 08:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <44ccd4eef48ef7a8fbe863bdd7b13b2ce8fa642e.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <44ccd4eef48ef7a8fbe863bdd7b13b2ce8fa642e.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 16:55:58 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4Si2u730Lzk6gcX0WAvidNux9Zrtcvi9W4yKaPCj+93Q@mail.gmail.com>
Message-ID: <CAL3q7H4Si2u730Lzk6gcX0WAvidNux9Zrtcvi9W4yKaPCj+93Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] btrfs: verify tempfsid clones using mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:50=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Create appearing to be a clone using the mkfs.btrfs option and test if
> the tempfsid is active.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Remove unnecessary function.
>  Add clone group
>  use $UMOUNT_PROG
>  Let _cp_reflink fail on the stdout.
>
>  tests/btrfs/313     | 55 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/313.out | 16 +++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100755 tests/btrfs/313
>  create mode 100644 tests/btrfs/313.out
>
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> new file mode 100755
> index 000000000000..c495a770c212
> --- /dev/null
> +++ b/tests/btrfs/313
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 313
> +#
> +# Functional test for the tempfsid, clone devices created using the mkfs=
 option.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone tempfsid
> +
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
> +_supported_fs btrfs
> +_require_cp_reflink
> +_require_btrfs_sysfs_fsid
> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
> +_require_btrfs_command inspect-internal dump-super
> +_require_btrfs_mkfs_uuid_option

So same as before, these last 2 _require_* are because of the
check_fsid() function,
defined at common/btrfs, so they should be in the function and not
spread over every test case that calls it.

Thanks.

> +
> +_scratch_dev_pool_get 2
> +
> +mnt1=3D$TEST_DIR/$seq/mnt1
> +mkdir -p $mnt1
> +
> +echo ---- clone_uuids_verify_tempfsid ----
> +mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
> +
> +echo Mounting original device
> +_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
> +check_fsid ${SCRATCH_DEV_NAME[0]}
> +
> +echo Mounting cloned device
> +_mount ${SCRATCH_DEV_NAME[1]} $mnt1
> +check_fsid ${SCRATCH_DEV_NAME[1]}
> +
> +$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_=
io
> +echo cp reflink must fail
> +_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratc=
h
> +
> +_scratch_dev_pool_put
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
> new file mode 100644
> index 000000000000..7a089d2c29c5
> --- /dev/null
> +++ b/tests/btrfs/313.out
> @@ -0,0 +1,16 @@
> +QA output created by 313
> +---- clone_uuids_verify_tempfsid ----
> +Mounting original device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             FSID
> +Tempfsid status:       0
> +Mounting cloned device
> +On disk fsid:          FSID
> +Metadata uuid:         FSID
> +Temp fsid:             TEMPFSID
> +Tempfsid status:       1
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +cp reflink must fail
> +cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Inva=
lid cross-device link
> --
> 2.39.3
>

