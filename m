Return-Path: <linux-btrfs+bounces-6434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E328F9300F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132881C216A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26602E822;
	Fri, 12 Jul 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuIzF0vo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041E129402;
	Fri, 12 Jul 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812312; cv=none; b=SM+bRvWO+3EDxngosUrHBGheCWsTabAB6rgQ8i3hYhwY0TB/reBD8N7ecXlxj5L1qG9GEpGpezUF+y3Ud3a7UhGcX0EDrin1llzuzcpYs0pHhjj7Ns6Pqc/IDg2AxO4QbbBg0oowY2S33JTGDQxZQvtch8uATyQ6WnGiu/Q1ETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812312; c=relaxed/simple;
	bh=bE7cJjlqpgOK2rfH9GtYvyVKSwBO+mD+zT2Iii6Mh+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwyOELr2vsVui58qbjh3m8amM0MIKoKhvyqDV05TNiP3aN8PzrNC/P7f4ZKeRgzoatyEVjaNhNZ7MqANCDgIR+BnIkPq4efE9+TUzntl/vqzvpYGu0au/rYyROd7HBMB47fy9QmQmtPh4Ibv65kmuZi8i120gu2MgkUN71YGBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuIzF0vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CFFC32782;
	Fri, 12 Jul 2024 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720812311;
	bh=bE7cJjlqpgOK2rfH9GtYvyVKSwBO+mD+zT2Iii6Mh+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PuIzF0vohRi/DQmjAfSkzvM9FOEV5vXVFDUx0g99gTXnCgOs+2Uv1WJT2xKrTZ4HY
	 AiTVjvYW/k8rFIM6FNfP3ThxksllbXjaXa8cM9DtXYceO4sXfXqzTKkSScCqUFd4vb
	 DEnkPXXT3M/XpjDLuFFRMEkpDgvAOzalawxn4FLMiL7kd6atqVAjEfilVleqndkNo/
	 aZn8t5CY0HOhQ/pqeKBmINjotGfzj9kFICyatrHuwRTrICvuUDnIqsdtTsswLGwMg+
	 RUh7D0t8/dRQzGyfJBAO/0owjF02NuksmX416YBHtv4w699eBk4JnLxR2O8zZKYAB0
	 AInES6359bGeQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so2533817e87.0;
        Fri, 12 Jul 2024 12:25:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXRjE3DzkCwwwvzt0Jo5/L3m0MUHA4l/3uJPdCk51nHnahrEHRE4ILG6k/KkEYyh5JmS1ERs6bLrj+VJohWTd3ueq72lpm73A==
X-Gm-Message-State: AOJu0Yx/jwwa1JS22R3wOKEkyLuPC6Si4DjPuxMlxOyVvY3cNpoEePhG
	MTh50v+x/PN7nKx1JYeNTxk6CaDCxGHI9G9Ex+3r1KZIRELjYvGQ+ECtmj0ZTouQ8FOkwVmLkQl
	+8wgqqy+dl4wC9OnJWoAAq26xPFQ=
X-Google-Smtp-Source: AGHT+IHCxKHkXYH0+S1MPD0UvkDQkKj2ycegdHC5H0cniYT/8DrCq+EU0x/5Axj2s1EDmPbw1GUdcvUEuBWF49fDejo=
X-Received: by 2002:a05:6512:b1d:b0:52c:952a:67da with SMTP id
 2adb3069b0e04-52eb99d4aeemr9595464e87.55.1720812309813; Fri, 12 Jul 2024
 12:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>
In-Reply-To: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jul 2024 20:24:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5HheGCqn+gmCjcVqoLbag4pRA0f6a7+t80y+d2FOTMxw@mail.gmail.com>
Message-ID: <CAL3q7H5HheGCqn+gmCjcVqoLbag4pRA0f6a7+t80y+d2FOTMxw@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: add test for btrfstune squota enable/disable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:53=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfstune supports enabling simple quotas on a fleshed out filesystem
> (without adding owner refs) and clearing squotas entirely from a
> filesystem that ran under squotas (clearing the incompat bit)
>
> Test that these operations work on a relatively complicated filesystem
> populated by fsstress while preserving fssum.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks Boris.

> ---
> Changelog:
> v4:
> - redirected stdout of both btrfstune commands to .full file. Re-tested
>   on 1. correct progs (passes) and 2a. buggy progs with a leaked eb and
>   2b. buggy progs that hits a uptodatebuffer error while committing the
>   txn. Everything behaved as expected.
> v3:
> - switched btrfstune commands from '|| _fail' to filtered golden output.
>   Got rid of redirecting stderr to .full because some aberrant output
>   (like eb leaks) shows up in stderr and I think it is helpful to treat
>   those as errors.
> v2:
> - added needed requires invocations
> - made fsck and btrfstune command failures matter
>
>
>  tests/btrfs/332     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/332.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/332
>  create mode 100644 tests/btrfs/332.out
>
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> new file mode 100755
> index 000000000..7f2c2ff9c
> --- /dev/null
> +++ b/tests/btrfs/332
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/332
> +#
> +# Test tune enabling and removing squotas on a live filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fssum
> +_require_btrfs_dump_super
> +_require_btrfs_command inspect-internal dump-tree
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> +       _notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-q=
uota)"
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> +       _notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-q=
uota)"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# do some stuff
> +d1=3D$SCRATCH_MNT/d1
> +d2=3D$SCRATCH_MNT/d2
> +mkdir $d1
> +mkdir $d2
> +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +
> +# enable squotas
> +_scratch_unmount
> +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +_scratch_mount
> +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> +       || echo "fssum $fssum_pre does not match $fssum_post after enabli=
ng squota"
> +
> +# do some more stuff
> +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +_check_btrfs_filesystem $SCRATCH_DEV
> +
> +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE=
_QUOTA'
> +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUO=
TA' -e 'QGROUP'
> +
> +_scratch_mount
> +fssum_post=3D$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +[ "$fssum_pre" =3D=3D "$fssum_post" ] \
> +       || echo "fssum $fssum_pre does not match $fssum_post after disabl=
ing squota"
> +
> +echo Silence is golden
> +status=3D0
> +exit
> diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> new file mode 100644
> index 000000000..adb316136
> --- /dev/null
> +++ b/tests/btrfs/332.out
> @@ -0,0 +1,2 @@
> +QA output created by 332
> +Silence is golden
> --
> 2.45.2
>
>

