Return-Path: <linux-btrfs+bounces-6407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A292F2A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 01:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1B7282778
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB02615ADA1;
	Thu, 11 Jul 2024 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1E8Wl4A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030182488;
	Thu, 11 Jul 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740643; cv=none; b=ar6cQgieLf16TEkcNaH+Dkqdv08O6q96ZRqQvIXikEyvkDEqCqe5Fw5fbSM1kRh8Wf4n1J88vfkosFgsP2utsm4sb1z8eDooRQ68w9naIfqrOXrWBT3pe7aIGfnqobibXQHgcCZ89L5MQ3JPFy6mh3eBaC23o2He2vP7CgAKyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740643; c=relaxed/simple;
	bh=FuKNopu68ZbndalOthShdzPqKVDMe7Py0dYT5mn+dgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQnW/gDhqUzYCGN3OeQFrjkrOSN3E+SQenDtYPsBcVtp1nkopUYHSuJqZF7HM2tBjfJN60/c2G5eJ54LFKo+Hj07yUql/zj5Bz5r7QL0orYjIkJOZVimPp4xHB4y4PxRR2rnOdHJL3/l/JFQnETLcoOFvQeMy8enOwMQRm0FrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1E8Wl4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEBDC32782;
	Thu, 11 Jul 2024 23:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720740642;
	bh=FuKNopu68ZbndalOthShdzPqKVDMe7Py0dYT5mn+dgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o1E8Wl4A4K3Kn8nzJxMipV1ksNapcBQDWSXhVO1rbobGc0lUNIxN3gQA0IUrwbb4j
	 mH3LVWjOuocFwCsa4iXlCgWCNFsfoB7xOyptEDahoQenFhIS0JH+O+I0QO/znmdF1o
	 EUtv3Hp+EtrDE7+L18cqxkHMbyNo/x/4uT6btaydaK6P1Or7uAaeaQmB9JmAIZcsnB
	 DaF1i9U8D3eIsDv+usGn/V1oRC/2hj+vJsRHvIVZ7UeBNry7dWhzJ6BlXLyDbyJ8TC
	 cEY0mHcnWsSFA9iW2P5RDzEb/7lNxvZY6j1gX1iDeSturqc9+6JRGtfZ6Nw7CkK7Hy
	 fRKFcT8vXoOLQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52eafec1e84so1926532e87.0;
        Thu, 11 Jul 2024 16:30:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUnSHJDu+4xdNTvb24iZcSPEzY488XKFzqw+5I3+h9U611eMjZtIbP/5QaXA2INX0S7/fJee0Hm4wrkumVxB08C4LSu5YcMSQ==
X-Gm-Message-State: AOJu0YwCLeyhuBju1gnkf8WPG2Bn9dtO2IClgdy0ZwpxkaOMG5G5LcEt
	D2+ptV5lFDTA6sedIuQGGM9MitkySwckAHRuv7xfvcKxOLLZ+srEhjbuIn7PyZWmJqPLDuAvX0V
	yWQ/4JA7gf69Nu3nRtolHP2fnfbU=
X-Google-Smtp-Source: AGHT+IFT8iwMv578Sf46il7X6Zyxt5doHNPbSnzU/6gk5Q7z+5SRKtRcVm6HNp9BqjZ0CFcPY7hYXmoj5/HEj3ihYWw=
X-Received: by 2002:a05:6512:3e0a:b0:52c:8b03:99d6 with SMTP id
 2adb3069b0e04-52eb9990d03mr6705501e87.6.1720740640832; Thu, 11 Jul 2024
 16:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dadd378fcd6de83a566f1e587fa5d1a8337c3f6b.1720732930.git.boris@bur.io>
In-Reply-To: <dadd378fcd6de83a566f1e587fa5d1a8337c3f6b.1720732930.git.boris@bur.io>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Jul 2024 00:30:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H44L+6hhs69gmpk1woLkR7NY5dxHaR5GBeUyxAYKf2C8A@mail.gmail.com>
Message-ID: <CAL3q7H44L+6hhs69gmpk1woLkR7NY5dxHaR5GBeUyxAYKf2C8A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test for btrfstune squota enable/disable
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:23=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> btrfstune supports enabling simple quotas on a fleshed out filesystem
> (without adding owner refs) and clearing squotas entirely from a
> filesystem that ran under squotas (clearing the incompat bit)
>
> Test that these operations work on a relatively complicated filesystem
> populated by fsstress while preserving fssum.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  tests/btrfs/332     | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/332.out |  2 ++
>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/btrfs/332
>  create mode 100644 tests/btrfs/332.out
>
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> new file mode 100755
> index 000000000..efc2d4ec3
> --- /dev/null
> +++ b/tests/btrfs/332
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.

2024

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
> +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1

If this fails the test doesn't fail... it redirects both stdout and
stderr to the .full file and ignores the exit status of btrfstune.

> +$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1

Same here, the test doesn't fail if btrfs check detects problems.

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
> +$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1

Same here.

> +
> +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full 2>&1

Same here, it ignores if the command fails.

Furthermore, --remove-simple-quota is a new option that is being added
in a patchset you just sent for btrfs-progs.
So the test should be skipped if the available btrfstune program does
not implement that option, rather than cryptically failing.

See what we do for detecting support for "btrfs" commands at
_require_btrfs_command().

> +$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1

Same here, it's ignoring any failures rather than failing if btrfs
check finds any problems.

> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE=
_QUOTA'

Missing a _require_btrfs_dump_super at the top.

> +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUO=
TA' -e 'QGROUP'

Missing a _require_btrfs_command inspect-internal dump-tree at the top.

Thanks.

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

