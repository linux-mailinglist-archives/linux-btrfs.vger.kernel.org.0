Return-Path: <linux-btrfs+bounces-5278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFD8CE624
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 15:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3354C1F2187A
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644F12BF2A;
	Fri, 24 May 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAU3/0Wm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F084D3FBB7
	for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557132; cv=none; b=lnsEHwi5kZHhOjrXKjst9mivsK5jgJeHlGl7lNn6WVeMplztrOkhByZ4U6shZsdVKkTJZb9fFOw4qUmWXLcNengFE8WtGDkwXPZ87GS7tOz1UDRSjZK9hhedS4kPyHxY5RLhbNh4Ijc8yk4CrpjxF4jTzr/SW6ofzb3+OGEZ7Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557132; c=relaxed/simple;
	bh=gPPYQJQOdERHU20ItqXrzpPUTRwwA7oonU/1bCfDF9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCIqW+lydVNjAKu6BN90XzKEr0A8wFeJtDRbIHNTblJOsH684a8W015BqcJIRgd+yaqWTDDPzMzbRSOsBbzfzBa7d6sc0JfWE3rGlmzsbDR/tBv2/+QqoF9L0vYIgfXoG8Prb6Jzh+RVEKMDV7rBVu1xSAy1MazHu2TG9Lba+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAU3/0Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F5EC2BBFC
	for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716557131;
	bh=gPPYQJQOdERHU20ItqXrzpPUTRwwA7oonU/1bCfDF9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cAU3/0WmU5Ji2xJfu1zq8kugFGFiURvyKX/SPwVxvfBC/mMAgtf9/z8wSYgn94Ryq
	 4/1/VTpMKSspIN56yhhQghkmAmbuto30scSSbmJUs1n5fNXbiIcaIcgwMGc2FvTnkI
	 bE+j74ttTTfoCcIhHPG5PykZ9OH4Lp1cPgpPbxgdzKKZASpwvFkMP23SQHw/cSyLs4
	 BtSt80dW1lWySBe0ZjGWmTm4AYObf6Ck09+fioqzQUR1GCyFS1BBlgI4k4D5Asu6tB
	 PMGqx2ikc0DglnMZV4aMmXhC/+A5+mQENzCy34S3fgR31F+/nI3R/WHTMpgwMiJshW
	 M5GdUfhvaDBDA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d3ccf7so101783466b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 06:25:31 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyer+lxS/Kyf1MMBjsaParUoF88XiWUhil6Qa8wj7aEngwVK3wq
	XRI0lfVu40jTyaqf5PNWliI6Qo8esfpAnz0+85fptb9g2Bph/JdSFp/2erF5TLM+6tlFebgJnKV
	A3hFk/bvywYu23Lqhlge2SyFn0NA=
X-Google-Smtp-Source: AGHT+IGxAhBaOa9SdpynGLmRvWksBRAe+wjhB7Wz8bFT+XeDgkAzsfId4a2XRyFzxBjCfM1j37oSk6+n1eQbMvU/D68=
X-Received: by 2002:a17:906:11d3:b0:a5c:de12:5fbb with SMTP id
 a640c23a62f3a-a6264f0ec99mr147712766b.50.1716557130134; Fri, 24 May 2024
 06:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <101430650a35b55b7a32d895fd292226d13346eb.1716486455.git.osandov@fb.com>
 <297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com>
In-Reply-To: <297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 24 May 2024 14:24:53 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4f2TCU1vX_6HJUF9s0Tc2dcTciB9HfFK74CduUM1s4KA@mail.gmail.com>
Message-ID: <CAL3q7H4f2TCU1vX_6HJUF9s0Tc2dcTciB9HfFK74CduUM1s4KA@mail.gmail.com>
Subject: Re: [PATCH fstests] btrfs: add regression test for fsync vs.
 size-extending direct I/O into prealloc crash
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:43=E2=80=AFPM Omar Sandoval <osandov@osandov.com>=
 wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Since this is a race, we just try to make the race happen in a loop and
> pass if it doesn't crash after all of our attempts.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/btrfs/312     | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/312.out |  2 ++
>  2 files changed, 68 insertions(+)
>  create mode 100755 tests/btrfs/312
>  create mode 100644 tests/btrfs/312.out
>
> diff --git a/tests/btrfs/312 b/tests/btrfs/312
> new file mode 100755
> index 00000000..aaca0e3e
> --- /dev/null
> +++ b/tests/btrfs/312
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Meta Platforms, Inc. and affiliates.
> +#
> +# FS QA Test 312
> +#
> +# Repeatedly fsync after size-extending direct I/O into a preallocated e=
xtent.
> +#
> +. ./common/preamble
> +_begin_fstest dangerous log prealloc

Can also add in the "quick group".
A since this is writing into a prealloc extent, the correct group is
"preallocrw".

> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_btrfs_command inspect-internal dump-tree
> +_require_btrfs_command inspect-internal inode-resolve

Missing a _require_attrs because $SETFATTR_PROG is needed/used.

Also missing a:

_require_xfs_io_command falloc -k

> +_fixed_by_kernel_commit XXXXXXXXXXXX \
> +       "btrfs: fix crash on racing fsync and size-extending direct I/O i=
nto prealloc"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +sectorsize=3D$(_scratch_btrfs_sectorsize)
> +
> +# Create a bunch of files so that we hopefully get one whose items are a=
t the
> +# end of a leaf.
> +for ((i =3D 0; i < 1000; i++)); do
> +       $XFS_IO_PROG -c "open -f -d $SCRATCH_MNT/$i" -c "falloc -k 0 $((s=
ectorsize * 3))" -c "pwrite -q 0 $sectorsize"

You can pass -d to $XFS_IO_PROG and make this a bit shorter:

$XFS_IO_PROG -f -d -c "falloc -k 0 $((sectorsize * 3))" -c "pwrite -q
0 $sectorsize"  "$SCRATCH_MNT/$i"

> +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/$i"
> +done
> +touch "$SCRATCH_MNT/$i"

Why is this touch needed here?
I can trigger the bug without it - it's confusing, if it's really
needed then add a comment explaining why please.

So now this works with the default leaf size of 16K on x86.
But what about in case we run with MKFS_OPTIONS=3D"-n 64K", or on a PPC
machine where default leaf/node size is 64K?

The 1000 iterations aren't enough, so I would suggest making the test
always create a fs with a 64K node size and adjusting the iterations
to be enough to trigger the bug.

> +
> +_scratch_unmount
> +
> +ino=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree "$SCRATCH_DEV" -t 5 =
|
> +      $AWK_PROG -v sectorsize=3D"$sectorsize" '
> +match($0, /^leaf [0-9]+ items ([0-9]+)/, arr) {
> +       nritems =3D arr[1]
> +}
> +match($0, /item ([0-9]+) key \(([0-9]+) EXTENT_DATA ([0-9]+)\)/, arr) {
> +       if (arr[1] =3D=3D nritems - 1 && arr[3] =3D=3D sectorsize) {
> +               print arr[2]
> +               exit
> +       }
> +}
> +')
> +
> +if [ -z "$ino" ]; then
> +       _fail "Extent at end of leaf not found"
> +fi
> +
> +_scratch_mount
> +path=3D$($BTRFS_UTIL_PROG inspect-internal inode-resolve "$ino" "$SCRATC=
H_MNT")
> +
> +# Try repeatedly to reproduce the race of an ordered extent finishing wh=
ile
> +# we're logging prealloc extents beyond i_size.
> +for ((i =3D 0; i < 1000; i++)); do
> +       $XFS_IO_PROG -c "open -t -d $path" -c "falloc -k 0 $((sectorsize =
* 3))" -c "pwrite -q -w 0 $sectorsize"
> +       $SETFATTR_PROG -n user.a -v a "$path"
> +       $XFS_IO_PROG -c "open -d $path" -c "pwrite -q -w $sectorsize $sec=
torsize" || exit 1

the || exit 1 is odd here.
Normally we do || _fail "some reason" or just don't do anything at
all, as a golden output mismatch due to an error will make the test
fail.

Also don't forget to cc the fstests mailing list.

Thanks.

> +done
> +
> +# If it didn't crash, we're good.
> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
> new file mode 100644
> index 00000000..6e72aa94
> --- /dev/null
> +++ b/tests/btrfs/312.out
> @@ -0,0 +1,2 @@
> +QA output created by 312
> +Silence is golden
> --
> 2.45.1
>
>

