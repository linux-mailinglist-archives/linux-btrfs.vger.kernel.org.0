Return-Path: <linux-btrfs+bounces-2794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F786742A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 13:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E21C28A70
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D88C5B5A5;
	Mon, 26 Feb 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK1/xK/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EEC5A792;
	Mon, 26 Feb 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948838; cv=none; b=aKCQnF9J72T4/T1BaXUm7dXwfn8LPsKJ6n7T3ZkcJEqS6e+0biiROuJZNfOSEym5T+svplpVBEO5ocHNAWrMVx7EJZuccRWFkcfkNPJpr6kROu2+mWkwu8O6+iEDprfuqfxSGVkZxHckMwwE3yPDKr5UEL57pSCo+t4C6iMwLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948838; c=relaxed/simple;
	bh=gMqghz6+4yc1mGDaSVAAdMjQ24hUBvLzBkk/wGM1r7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZqo45u8egYgL/VPmrhCBQ1V+iNbYr27Xgb6Pi/bfyA/7tW/a1jpbefQ994rKkJ+NzFnvGroCERHzWhKw6wZ00o15o6zqH1mQU9rWzNdJ27Mv6KvesmMbpePRJPKd2gmyPE1ePx68xt9rXMzwtzc3hUJO0pWwtbnZeJfQLDooC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK1/xK/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AECC43390;
	Mon, 26 Feb 2024 12:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708948837;
	bh=gMqghz6+4yc1mGDaSVAAdMjQ24hUBvLzBkk/wGM1r7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IK1/xK/9WGC7ibhxQsDN9emhHpT71Vz8BhnoXrNf9Ek/gCmAV1gJUR9HWtBTeSLsg
	 XUcO/38ldIqr6UtyOh45Fct7J2YHEs6Qr+e0JRjb4xUglrSA58ketM5bVEt6udz1dk
	 8iLyd9ZUqXXIHJAI4l6FCpfMOB2QoCIYYq86ncCSOwmYSRSud5CxJhN59FVY2s6sdQ
	 bbWNqTNsKxwb/Y/D48OEExzuhUqFfUET/wMLuSII3tQJac1vl7Ou4PWlbbUOIHoAkV
	 L5K4Jjbli23dbSuljXCCBb4TB7cIqiPUWAJX3kO82uFZmbFA77EwUVUFuz0tT/CXW6
	 FJ8EdZugK2B/w==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so3858370a12.3;
        Mon, 26 Feb 2024 04:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWflE+7vGFLKQ/ELU8cm+c1nRUWyRc5PqTCpM5qQTR627EzpHXf78/2Zi4Klj9PGfG+qjbVohLt1dflpQQH036A9SYPI+yjx9a2xCE=
X-Gm-Message-State: AOJu0Yyh0+Z9G4fuQcZzP/hfUffHHK1p8rG/1WVMJuBJCpkwr78i/zIr
	BBt5/WQVGDED4S+O9ymSXzcYgEvNE+mjRmBBy1djB4nAWgFlZcHf7exK+67VVMKsoFdVdERIgYV
	nWFeN53E8sGWZHycQIDtonRoD1pQ=
X-Google-Smtp-Source: AGHT+IGXCdfLA7xLrzPJ1dWPxa2qpiUIw7Na7HL5cbsdLn3+tvPSJpPqbabbHTPX3576gLMXQ28SZ+FUWhn38tBJ7yg=
X-Received: by 2002:a17:906:f899:b0:a3f:804f:c1a4 with SMTP id
 lg25-20020a170906f89900b00a3f804fc1a4mr4692800ejb.74.1708948836225; Mon, 26
 Feb 2024 04:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708772619.git.anand.jain@oracle.com> <b51143afd6776abf1741fda00a007c594e8d54f1.1708772619.git.anand.jain@oracle.com>
In-Reply-To: <b51143afd6776abf1741fda00a007c594e8d54f1.1708772619.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 26 Feb 2024 11:59:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5RaRyi4rPiMdDS3qjOScHxhxoCAieX8hM092XWP=RXOA@mail.gmail.com>
Message-ID: <CAL3q7H5RaRyi4rPiMdDS3qjOScHxhxoCAieX8hM092XWP=RXOA@mail.gmail.com>
Subject: Re: [PATCH v3 08/10] btrfs: verify tempfsid clones using mkfs
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 4:44=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Create appearing to be a clone using the mkfs.btrfs option and test if
> the tempfsid is active.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v3:
> prerequisite checks are in the function mkfs_clone(), remove from the
> testcase.
>
> v2:
>  Remove unnecessary function.
>  Add clone group
>  use $UMOUNT_PROG
>  Let _cp_reflink fail on the stdout.
>
>  tests/btrfs/313     | 53 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/313.out | 16 ++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/313
>  create mode 100644 tests/btrfs/313.out
>
> diff --git a/tests/btrfs/313 b/tests/btrfs/313
> new file mode 100755
> index 000000000000..1f50ee78ab99
> --- /dev/null
> +++ b/tests/btrfs/313
> @@ -0,0 +1,53 @@
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

This requirement should be inside the check_fsid() helper, as pointed befor=
e.

Thanks.

> +_require_scratch_dev_pool 2
> +_require_btrfs_fs_feature temp_fsid
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

