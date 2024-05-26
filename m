Return-Path: <linux-btrfs+bounces-5293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3708CF420
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D0EB21134
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 May 2024 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE46D524;
	Sun, 26 May 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZzPxRb8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5968C1D;
	Sun, 26 May 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716724108; cv=none; b=r+B7JU7ShmuPihw6FJgwVLZHM7gTir/mTd8h4krmqaNUZShOnghSgHJLB7UHHIKzCcJoutoiUL0gLn4hnWKGae0+ofDwpFMyuIz3gv9dGXImKqP3rWfamniwYDZEAsl8MsTktuiysbyavBhvN2qJMSF+dXVRiwn8BwQNgLDADo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716724108; c=relaxed/simple;
	bh=WQ+HPlElvkl/Ez2zfyiK7lLhLsIU5yGlsyVlZUVUFZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqYHy+r1JjhjhlHdO6UXpArAXX0UirtdKOWUCqoUpkI7jT2ZEhH+MJkK61ywKsr/lMDSY6jsXIqKyhvpF2N48vXT7fHVMHu03o/LWY6UM6SI9TpAEouQxOnR470KcwxxRo8x9+mz4sk/8BDIUUYRkJJ/R+1ZX6v/mv5/ya3o3t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZzPxRb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5C7C4AF07;
	Sun, 26 May 2024 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716724107;
	bh=WQ+HPlElvkl/Ez2zfyiK7lLhLsIU5yGlsyVlZUVUFZI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MZzPxRb8dqldpZ7iSPRwsStVXDHjS4IOXVZESYGMZEfw3tOKUoDpIIxXxWZHJQsnV
	 H3EZ31JigddWX+knGTP3FyH4CJTi6IYImsb2FpTe+nqLFvJpvlzaek+s1gMo9/EVXK
	 Jvogz3UFnV/xXfDZN7jBMamzp2Zarb9NQzue1EA5yWf8vbve6KyonmpLk1GG7elrvh
	 QgQw1J3j5ft5wtRonFjAh60DLr0WOPqmgyYnV3dh9NlX/dMvJWS9EtQOGUfiqTPQu2
	 R0xaS0P/lWmGJ2mh4w/lMQety24ts24TQHZURR4bMjYW2Z8WycviNyTHFa2+8a+xVJ
	 dsU1pQI5amR8w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5238b7d0494so11054499e87.3;
        Sun, 26 May 2024 04:48:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/DK0fFwmu9Tuc4DfZwQayonqWxFsSD69SCVGPyt9HJLUKwbWM8u9LBh6w1D9fh9iEc2OiopayLKx7w0y3qCapUzM18hrRRDdCJiw=
X-Gm-Message-State: AOJu0Yy3dI6U6yt9+CKhoTdQnlqWoGxb38hm5pSHQRUFdAFhEOr1IPWU
	RqdaEhkS/iapmCcqQKfWpuuOIH4x/HDpSLKgf/QplA7Q1V7yfc2Zn8hMXGlPVGJylUIXQ7IKMrz
	YRUM/++hv8kOQut5MIZ4L0LYm6rc=
X-Google-Smtp-Source: AGHT+IFqrZbbUyO9SQxsUIAMPSruF/vc3GGmM4mWVyCtofVpwquQ46OOODDRT9pC2D7nADJ7iZ8vG+XNrOEmxiXJBDk=
X-Received: by 2002:a05:6512:794:b0:529:46e:b2a5 with SMTP id
 2adb3069b0e04-52964eac45fmr5474743e87.2.1716724106185; Sun, 26 May 2024
 04:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
In-Reply-To: <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 26 May 2024 12:47:49 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
Message-ID: <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 9:58=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> This is a regression test for a Btrfs bug, but there's nothing
> Btrfs-specific about it. Since it's a race, we just try to make the race
> happen in a loop and pass if it doesn't crash after all of our attempts.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Changes from v1 [1]:
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
> 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d=
0f392d.1716492850.git.osandov@osandov.com/
>
>  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/745.out |  2 ++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tests/generic/745
>  create mode 100644 tests/generic/745.out
>
> diff --git a/tests/generic/745 b/tests/generic/745
> new file mode 100755
> index 00000000..925adba9
> --- /dev/null
> +++ b/tests/generic/745

Btw, generic/745 already exists in the for-next branch (development is
based against that branch nowadays).

> @@ -0,0 +1,44 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Meta Platforms, Inc. and affiliates.
> +#
> +# FS QA Test 745
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
> +_require_xfs_io_command falloc -k

Since this is now a generic test and we're using direct IO, also:

_require_odirect

> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: fix crash on racing fsync and size-extending write into p=
realloc"

Because it's now a generic test, it should be:

[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit ....

Otherwise it looks good to me, so with that:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

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
> diff --git a/tests/generic/745.out b/tests/generic/745.out
> new file mode 100644
> index 00000000..fce6b7f5
> --- /dev/null
> +++ b/tests/generic/745.out
> @@ -0,0 +1,2 @@
> +QA output created by 745
> +Silence is golden
> --
> 2.45.1
>
>

