Return-Path: <linux-btrfs+bounces-19487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02894C9F5AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4A1C03000752
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50D302CAA;
	Wed,  3 Dec 2025 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaWhvKFD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CA30498F
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773411; cv=none; b=EUp/PJOgKdMpEvCZaZXhJ3fymh1v/BR0KN++UnSsTzBa32qZ+tN6W2QN+EWpt1OUfzWiTyawEJ6TvBQIzdow6o5JMe5SD9H7AtJB7DIbAoMl0+1EJVsEZhhgDCShv7FnJf2JIt2EuZqUNcdS3pzkPTmMBWZybd2mIzhK44UskBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773411; c=relaxed/simple;
	bh=oLrDHvoObHuGVFCnx9d5iq+V0OJdGrYmDmNE6P88dSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIX7rg6V/E7GQkJeVwewQfyf+I+5ctgFupCgQhZrZLpmq826IbXCx6TDmm2IMzfQFhZDhSMX7Yrz1r9WdA9KOkfAYHmqKLX0qk19p+P0Hk9ZyBQe09+Q4BAjS5OuGTNxcHP4mFlj5/Fuf3THcYSuBZTFky9LmiTsJ6FepREb1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaWhvKFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F040C4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773410;
	bh=oLrDHvoObHuGVFCnx9d5iq+V0OJdGrYmDmNE6P88dSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PaWhvKFDeLgXl9B/oUy2ds8QjUd+01FlstPxN88+JNs/X2wCXhMzoI7iVGc1IpTd6
	 3B/zalYjKobDhf7DNC19cCxCP9njz7c/KBejuoeEfrmhyCa3jqpa18QFBAQ6e+EQg0
	 0qAWk79skz0gtuzgq9W7F2m+GsOQiCw93+BFMuDsSAAvkrWlgtI6Of6kFgcFby6jNU
	 2XHeWr0/y6Hn3HuOu1ecKT0Xm3rRmxwmTlyYHrOVGxG3jfZ9qUQaSIwkU9jNvKsaLn
	 PBEZ96NuZj3CXMRm5XgLYdZZqZt93MIwOWMbowXVCriGM1t+ex+0MelUrijW3pwOO5
	 EFpVfSnFkMhgA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b735487129fso990623966b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 06:50:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYR1TfxWoeW2PiZrF0zEJ+l39Mcf7CHEYKyEp9HsxvYLpCvOMbRqLuhNu7nxOs8LCJzJjxRs4RqWQafQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx07hQNsB1IDaTkJFESxIOapcF/t+DvTD74Wzk1OPW4QMRHCtm
	sGv0UL0g35/jxhcYjs8Uaj4N2HE5fdgWSYA+Ea59ROiDIQyrCaWbzPbPhBtya0ckLXVMD293qNp
	vY0vCwQsh+6Zsbk3WPp7SPyLUudP0O4w=
X-Google-Smtp-Source: AGHT+IGTFMTsB8asxhVz5VyMiXJsY+jI1MHwOI7PlM1iei9uoj9bvoeupHmpoB6HeN6fSNKnIg8mctTL8VWFRFCnnX8=
X-Received: by 2002:a17:907:c10:b0:b72:7cd3:d55b with SMTP id
 a640c23a62f3a-b79dbe71a4amr271601966b.12.1764773408913; Wed, 03 Dec 2025
 06:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203114328.10386-1-realwakka@gmail.com>
In-Reply-To: <20251203114328.10386-1-realwakka@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Dec 2025 14:49:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H678q0xFPZN2LqA6PD-akb0Zs_OeQSPdm_p+JS-9Bc96g@mail.gmail.com>
X-Gm-Features: AWmQ_bk9CMyqAPCPwtrlBx8x0--L9yU4NMTOygMecdYh9sa-oQSGcc0JeRfdZtY
Message-ID: <CAL3q7H678q0xFPZN2LqA6PD-akb0Zs_OeQSPdm_p+JS-9Bc96g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] btrfs/339: test receive dump stream for different user
To: Sidong Yang <realwakka@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:43=E2=80=AFAM Sidong Yang <realwakka@gmail.com> w=
rote:
>
> Test receive to dump stream file from different user.
>
> This is a regression test for the btrfs-progs commit cd933616d485
> ("btrfs-progs: receive: don't use O_NOATIME to open stream for
> dumping").
>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> v2:
> - forward to $seqres.full rather than -q
> - use $tmp for stream file
> v3:
> - use _btrfs than $BTRFS_UTIL_PROG
> - remove unnecessary cleanup, requirement
> ---
>  tests/btrfs/339     | 32 ++++++++++++++++++++++++++++++++
>  tests/btrfs/339.out |  2 ++
>  2 files changed, 34 insertions(+)
>  create mode 100755 tests/btrfs/339
>  create mode 100644 tests/btrfs/339.out
>
> diff --git a/tests/btrfs/339 b/tests/btrfs/339
> new file mode 100755
> index 00000000..234a9ea0
> --- /dev/null
> +++ b/tests/btrfs/339
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Sidong Yang.  All Rights Reserved.
> +#
> +# FS QA Test 339
> +#
> +# Test btrfs receive dump stream from different user
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send snapshot
> +
> +. ./common/filter
> +
> +_require_scratch
> +_require_user
> +
> +_fixed_by_git_commit btrfs-progs cd933616d485 \
> +       "btrfs-progs: receive: don't use O_NOATIME to open stream for dum=
ping"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +stream=3D$tmp.fsv.ss
> +
> +_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
> +_btrfs send -f $stream $SCRATCH_MNT/snap
> +chmod a+r $stream
> +_su $qa_user -c "$BTRFS_UTIL_PROG receive --dump -f $stream" >> $seqres.=
full
> +
> +# success, all done
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
> new file mode 100644
> index 00000000..293ea808
> --- /dev/null
> +++ b/tests/btrfs/339.out
> @@ -0,0 +1,2 @@
> +QA output created by 339
> +Silence is golden
> --
> 2.43.0
>

