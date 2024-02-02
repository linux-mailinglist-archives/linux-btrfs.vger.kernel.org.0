Return-Path: <linux-btrfs+bounces-2064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A735D846F4D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C601F289FB
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C3713E239;
	Fri,  2 Feb 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EswQ9ltq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65177650;
	Fri,  2 Feb 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874205; cv=none; b=u/8hGLPS8hEtwS1xRHFH7Nr73+ko8TgzyM3/yUglG6eY6egwo5zJ2z4oJMuX6Dsdi543maj41ndARAXcTUZNbXi+Vvn11UlXjNemJwr5tfAzsf9M/JVBEAr0Pc6dISUP5xST1YIoVAphVZm/DJhy1xIcCFtjvNIst/o3WjCM4uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874205; c=relaxed/simple;
	bh=Cwt+nlNJzx2VJHpSilkfvSpekG+LOGiW+i7PlxTL1c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/03WYUwIZQzXUWKjFembPsHq+scqLUZ10ecJYjWAciPdjjrQPW9huLIBurEacKckh2qNecc99CDEpS8bbWotHF6HKIybpTLD2zwIROhHnIAopVhUgP9G8i73j6GjkLI55vAC6XTqRTwe0tOUwocIwIa3m60lEBcVMPjhnGISv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EswQ9ltq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1378C43399;
	Fri,  2 Feb 2024 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706874204;
	bh=Cwt+nlNJzx2VJHpSilkfvSpekG+LOGiW+i7PlxTL1c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EswQ9ltq7LFNj3eu5TsSmIpvClW0vha7jKz6sVHU/xOVAmiwctpvaBIgIys3vU1li
	 gMMVghofYnB5PDYnAns+csOcwNpztn0mUHfZeUWSh31RpmHcj6uOb4cnKcbwAnfGbu
	 gmFz5oGd+2Cup079OOzrOsoyiR29NUEGjeXebPKPdUTe5bdwCzMVJ2V/eN3sTJeJMU
	 3GNOesbn+gF3XMkjHrjZZmM/OFMV3jxp0x6SUwJL2a1nVgYu7dNM/W2C5VjS6eBrSn
	 rRw3yW6GqxMAo8Mk+GSRco46650Wr9Ra/Oex3nLxw8RemTy8HyNKnwB5gb4NlC7/0P
	 qhiKfOZEFBo7g==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so294172666b.2;
        Fri, 02 Feb 2024 03:43:24 -0800 (PST)
X-Gm-Message-State: AOJu0YxkpWGwaQORIoiMPpBvaxrzc3qrcPBi6gLnpKjn2Z98ixgCDxSt
	vzcMnqyLcW30N0pEj0lwNkhnkKnMewDjfJ+hfBobJ6Fj46gWg6gZzp40YdJ4Nzn2V234lPFr7Qb
	sM52l4DPX2aUoRuHW7k7DwAUDGgA=
X-Google-Smtp-Source: AGHT+IE1faJiXlu3WGl/FVluvhrACJZM/jz+gyWvblcuH/zyfr3JZOHUVcGXNZl7vR2yvXJsYksq1oF8DRAH03M6Qfg=
X-Received: by 2002:a17:906:c52:b0:a36:3c59:3449 with SMTP id
 t18-20020a1709060c5200b00a363c593449mr3791364ejf.56.1706874203120; Fri, 02
 Feb 2024 03:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
In-Reply-To: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 2 Feb 2024 11:42:46 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4JsWsW2Ng2DzZj6zwg+qio86w48T9qCd7VXXfkv4nGMg@mail.gmail.com>
Message-ID: <CAL3q7H4JsWsW2Ng2DzZj6zwg+qio86w48T9qCd7VXXfkv4nGMg@mail.gmail.com>
Subject: Re: [PATCH] fstests: add a regression test for fiemap into an mmap range
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:37=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  src/Makefile          |  2 +-
>  tests/generic/740     | 41 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/740.out |  2 ++
>  3 files changed, 44 insertions(+), 1 deletion(-)
>  create mode 100644 tests/generic/740
>  create mode 100644 tests/generic/740.out
>
> diff --git a/src/Makefile b/src/Makefile
> index d79015ce..916f6755 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pre=
allo_rw_pattern_reader \
>         attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles=
 \
>         fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail=
 \
>         detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -       uuid_ioctl
> +       uuid_ioctl fiemap-fault
>
>  EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/tests/generic/740 b/tests/generic/740
> new file mode 100644
> index 00000000..46ec5820
> --- /dev/null
> +++ b/tests/generic/740
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test fiemap into an mmaped buffer of the same file
> +#
> +# Create a reasonably large file, then run a program which mmaps it and =
uses
> +# that as a buffer for an fiemap call.  This is a regression test for bt=
rfs
> +# where we used to hold a lock for the duration of the fiemap call which=
 would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto

Besides the missing C file, please also add the "fiemap" group to the test.

Thanks.

> +[ $FSTYP =3D=3D "btrfs" ] && \
> +       _fixed_by_kernel_commit xxxxxxxxxxxx \
> +               "btrfs: fix deadlock with fiemap and extent locking"
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=3D$TEST_DIR/fiemap-fault-$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +       $XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done
> +
> +$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
> +
> +rm -f $dst
> +
> +# success, all done
> +status=3D$?
> +exit
> +
> diff --git a/tests/generic/740.out b/tests/generic/740.out
> new file mode 100644
> index 00000000..3f841e60
> --- /dev/null
> +++ b/tests/generic/740.out
> @@ -0,0 +1,2 @@
> +QA output created by 740
> +Silence is golden
> --
> 2.43.0
>
>

