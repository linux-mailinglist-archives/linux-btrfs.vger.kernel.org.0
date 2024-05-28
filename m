Return-Path: <linux-btrfs+bounces-5324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0638D2256
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C3C281B5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4601A17335E;
	Tue, 28 May 2024 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6c/WKEg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA37D07D;
	Tue, 28 May 2024 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916922; cv=none; b=R5i0nFOQHPKnN3uQpSgXzf5faMwBCLPghUEoJUrGdi0CsPg1+LJMFPsXfJkTjQMoSOAEDYpLoO84dYtNSFlNCYx4rvL+/dEzg2zXgA3xgHldXDsio/OB2vfMRoXkpnnFjF2B85bXOa2kbFjLpxMnmOkQhyxki8TEhV+QZIJhu7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916922; c=relaxed/simple;
	bh=qKmedDqluaE4ygpuEoF9FlpLgpXTGkZnUG60dxwFlcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m88DNctbi/x1YOjw///RVM3USZC4mCyw+cCDH99c5QVpJmma6mQtNO/s3ZlWVPyuhf8FEvH1PVlINUc26eKbBDVlrbdSkBLu57wZCb5eNIQgFtWIhv20WFUKAATAiW0/9hD2Qy3rilZ8Td4suY5+vWoyCkdOdHFxRNeJ0PFdIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6c/WKEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1778C32786;
	Tue, 28 May 2024 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916922;
	bh=qKmedDqluaE4ygpuEoF9FlpLgpXTGkZnUG60dxwFlcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l6c/WKEgdhDQTJDZiCdmVlvGzLztwULvFWEJ0dqA5imbr1ANnKix7fAS/IkalpyIM
	 cw6zc1u2cqsssKDo5X+qkZzpV/pZ3Zuin67alI5Gy7l6f8k5GWEPWkdPMgDtKd5QOk
	 SHPqeiUBSS31yuxxmUFLsE/iGqZf47IYBFZ+ONaZf9fp+idteGB7GGQTh4g1cyY1ow
	 oNZWV4Mw4m90ah2PwZ1YmiNYDqm88tKhF05fWpgCRx08Wew2PSc1Kn4EJRPiS05HtM
	 aCAE1nPxIWK643H5guoe05nG44T7rz4JbENGrgyd29URt6wiRFX+9nWCIWUGovYlEG
	 WGF5RinJouGNg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52961b77655so1323285e87.2;
        Tue, 28 May 2024 10:22:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtPmHbyyxMEAV7FADBf8+LuyNITMOcPtis0aWD6y7NXvz7g9ju0/NCtombTHdciCO1zLbYysGYEN6dgTEXtBmdA32tRpoSeV+vbbM=
X-Gm-Message-State: AOJu0Yz9IzncH4LPOkv6+xyzqXHYO6B/5vBr/exu7GDSvyaNIf+LClby
	NqzuW6Cw3+jiE3FZ3CuxOkHFmJ7ICF8ooPqOXjEPnl1Hnlo3JRdaF70NdgBTFnWNWfh3790s4pg
	M0SxoT5IjX87rrvfjKaggvP8YbU4=
X-Google-Smtp-Source: AGHT+IH52bzs3FxLI/zk8WNK+yQnpQ99P0kdRJ8yHgyOaDPTH9BcFrgHiWYiHj/MJNTr1svvXu3s5EnQIBx+7GAdKf4=
X-Received: by 2002:a05:6512:2350:b0:529:b6b4:7e3c with SMTP id
 2adb3069b0e04-529b6b48032mr3089620e87.45.1716916920355; Tue, 28 May 2024
 10:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>
In-Reply-To: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 28 May 2024 18:21:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5z_eYpx8e-J7xPzZMqCxv2xwq9H7ga=8EZdLk7gnT-jQ@mail.gmail.com>
Message-ID: <CAL3q7H5z_eYpx8e-J7xPzZMqCxv2xwq9H7ga=8EZdLk7gnT-jQ@mail.gmail.com>
Subject: Re: [PATCH fstests v3] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:13=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This is a regression test for a Btrfs bug, but there's nothing
> Btrfs-specific about it. Since it's a race, we just try to make the race
> happen in a loop and pass if it doesn't crash after all of our attempts.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> Changes from v2 [1]:
>
> - Rebased on for-next.
> - Added _require_odirect.
> - Added FSTYP check to _fixed_by_kernel_commit.
> - Added Filipe's Reviewed-by.

It's missing actually, so I replied with it :)

Thanks.

>
> Changes from v1 [2]:
>
> - Added missing groups and requires.
> - Simplified $XFS_IO_PROG calls.
> - Removed -i flag from $XFS_IO_PROG to make race reproduce more
>   reliably.
> - Removed all of the file creation and dump-tree parsing since the only
>   file on a fresh filesystem is guaranteed to be at the end of a leaf
>   anyways.
> - Rewrote to be a generic test.
>
> 1: https://lore.kernel.org/linux-btrfs/d032e0b964f163229b684c0ac72b656ec9=
bf7b48.1716584019.git.osandov@osandov.com/
> 2: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d=
0f392d.1716492850.git.osandov@osandov.com/
>
>  tests/generic/748     | 45 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/748.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/generic/748
>  create mode 100644 tests/generic/748.out
>
> diff --git a/tests/generic/748 b/tests/generic/748
> new file mode 100755
> index 00000000..2ec33694
> --- /dev/null
> +++ b/tests/generic/748
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Meta Platforms, Inc. and affiliates.
> +#
> +# FS QA Test 748
> +#
> +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> +# prealloc while extending i_size, then fdatasync. This is a regression =
test
> +# for a Btrfs crash.
> +#
> +. ./common/preamble
> +. ./common/attr
> +_begin_fstest auto quick log preallocrw dangerous
> +
> +_supported_fs generic
> +_require_scratch
> +_require_attrs
> +_require_odirect
> +_require_xfs_io_command falloc -k
> +[ "$FSTYP" =3D btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: fix crash on racing fsync and size-extending write into p=
realloc"
> +
> +# -i slows down xfs_io startup and makes the race much less reliable.
> +export XFS_IO_PROG=3D"$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +blksz=3D$(_get_block_size "$SCRATCH_MNT")
> +
> +# On Btrfs, since this is the only file on the filesystem, its metadata =
is at
> +# the end of a B-tree leaf. We want an ordered extent completion to add =
an
> +# extent item at the end of the leaf while we're logging prealloc extent=
s
> +# beyond i_size after an xattr was set.
> +for ((i =3D 0; i < 5000; i++)); do
> +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -=
w 0 $blksz" "$SCRATCH_MNT/file"
> +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/fil=
e"
> +done
> +
> +# If it didn't crash, we're good.
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/generic/748.out b/tests/generic/748.out
> new file mode 100644
> index 00000000..dc050a96
> --- /dev/null
> +++ b/tests/generic/748.out
> @@ -0,0 +1,2 @@
> +QA output created by 748
> +Silence is golden
> --
> 2.45.1
>
>

