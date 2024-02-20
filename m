Return-Path: <linux-btrfs+bounces-2597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F342585C1FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 18:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A952B2856E6
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Feb 2024 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D176908;
	Tue, 20 Feb 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YndGKXkR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E122768F3;
	Tue, 20 Feb 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448740; cv=none; b=MEn2+LVvnhW4jJUnWP6uYFFoPrUdJxpYaatvu0onC6B/isJDRyNKRPkxT/570YUl1y5cYmIcqOPUL08szA5HLyFj0Csa4YMUD2rY3cvwmPbV9M19zyQwRwa6bHarQx08p+EG/FVS0lS3n31DVjEXRSiwS6GwhVU9hbauvb/e2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448740; c=relaxed/simple;
	bh=RnU3sWGshZPuiiFG3B6xS1J9IoNHulqhv/N+LIER66k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7YM3X7Ro/x+ayfSvGzD2zBZ6E1tL4CZCeSu7q31GGYgw0oUSd+bG4IUaLNxMAqEJQbxQPuKOBOPHapjIe19feyiQqg06pyTfI0OozET6cYudh0E4+ZFylx61OE3FywN3bTNtfDyWy3DlUAf1wf8ai/vOUtnAjbUR/KcV8f42ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YndGKXkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7D2C43394;
	Tue, 20 Feb 2024 17:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448740;
	bh=RnU3sWGshZPuiiFG3B6xS1J9IoNHulqhv/N+LIER66k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YndGKXkRSKa1lYfn7L7CpMa1arjG+nizzN8MxNI7NaKQhL+L1STdsAvZxTYAWm9gb
	 AnqJUfaOI6NMYd1hVSqF/+fz2iW5ii+8L+2+wtiN6om6s3STkwL6IUTl2U4CHvROKJ
	 2UhgWP/bSQ9YvxYAwZIvw3EGztdKB9ia8bTWoC0ug/qr8P0oWbCbZobKtCqqRf6sIX
	 522SZgQP+I6JV3hQoB8C5z2dlZeLeX4XibV4Nt37aD40W/JiSZjEZpvpF3M9KaDpMp
	 rateIq9R3qV8dFSLbh2Bi7LEOa+XA5PJPvq9TGlGDpBb11P77H95embJPp0yLe3jRP
	 /IUm9ffcDVm6w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so792623666b.0;
        Tue, 20 Feb 2024 09:05:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2VtGNBOs+kAmph3omoxJOAEKd4CMSUy8n92j92luqlxfzsIain6H9P5dDZBQ6YrdubSs+4Tz8QAP4DkA4P4LfCwrSQsKFYT7trSk=
X-Gm-Message-State: AOJu0YwFeRw80NuhHLWYWGJBDKAD0ACrKOcN5Ra1MV18FH97LWTbbs4y
	qucE09FnOzZjgMPvXpNeiYf9bPqAWZywZ53Busm5lUbtaS10NEgcWyKV1R4agiInaC/9Wfj5EGL
	GUzEs6dIzYA6DPpVGIQGCNtYdTp8=
X-Google-Smtp-Source: AGHT+IEL1iR/UBTMnQNNYTpcxwRNTpOFGFxwPdSokNnWX+qQyqwQViC4YPRrGTrdSIoGkX6T6Z7hPoeV02Rxs6XDCIo=
X-Received: by 2002:a17:906:1c02:b0:a3e:4cfc:2186 with SMTP id
 k2-20020a1709061c0200b00a3e4cfc2186mr7234014ejg.17.1708448738485; Tue, 20 Feb
 2024 09:05:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708362842.git.anand.jain@oracle.com> <bd72599f2b44e4062262421ca52f83c3dedca1c8.1708362842.git.anand.jain@oracle.com>
In-Reply-To: <bd72599f2b44e4062262421ca52f83c3dedca1c8.1708362842.git.anand.jain@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 20 Feb 2024 17:05:01 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4tNZ5uLzyojf3rU36Pnsz3sWPVgQ6H1y+Vw8PtFCV50A@mail.gmail.com>
Message-ID: <CAL3q7H4tNZ5uLzyojf3rU36Pnsz3sWPVgQ6H1y+Vw8PtFCV50A@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] btrfs: test tempfsid with device add, seed, and balance
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, zlang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:50=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> Make sure that basic functions such as seeding and device add fail,
> while balance runs successfully with tempfsid.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2:
>  Remove unnecessary function.
>  Add clone group
>  use $UMOUNT_PROG
>  Let _cp_reflink fail on the stdout.
>
>  tests/btrfs/315     | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/315.out |  9 ++++++
>  2 files changed, 88 insertions(+)
>  create mode 100755 tests/btrfs/315
>  create mode 100644 tests/btrfs/315.out
>
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> new file mode 100755
> index 000000000000..4376c7f1849c
> --- /dev/null
> +++ b/tests/btrfs/315
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.

Your name here...

> +#
> +# FS QA Test 315
> +#
> +# Verify if the seed and device add to a tempfsid filesystem fails.

And balance too...

> +#
> +. ./common/preamble
> +_begin_fstest auto quick volume seed tempfsid

Missing 'balance' group.

> +
> +_cleanup()
> +{
> +       cd /
> +       $UMOUNT_PROG $tempfsid_mnt 2>/dev/null
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

So same as before, these last 2 _require_* are because of the
mkfs_clone() function,
defined at common/btrfs, so they should be in the function and not
spread over every test case that calls it.

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
> +$BTRFS_UTIL_PROG device add -f ${SCRATCH_DEV_NAME[2]} ${tempfsid_mnt} >>=
 \
> +                       $seqres.full 2>&1 && _fail "Failed to file device=
 add"

Can't we do without the && _fail?
Just call device add and put the expected error message in the golden outpu=
t.
It's the preferred pattern in fstests in general, and makes everything
shorter and easier to read.

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
> index 000000000000..e882fe41146d
> --- /dev/null
> +++ b/tests/btrfs/315.out
> @@ -0,0 +1,9 @@
> +QA output created by 315
> +---- seed_device_must_fail ----
> +mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> +mount: TEST_DIR/315/tempfsid_mnt: mount(2) system call failed: File exis=
ts.
> +---- device_add_must_fail ----
> +wrote 9000/9000 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Balance must be successful
> +Done, had to relocate 3 out of 3 chunks
> --
> 2.39.3
>

