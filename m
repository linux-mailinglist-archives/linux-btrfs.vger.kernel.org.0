Return-Path: <linux-btrfs+bounces-13870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D807AB30B9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0057A26CF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 07:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A882571AB;
	Mon, 12 May 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOKsWgh9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1719E97C;
	Mon, 12 May 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035885; cv=none; b=HYpb/PNYftN3Bqp10RvGKIivg9OYO7OBwyUE4tJWwfB4s8ukFQet86UHMfuJURNdTJrMPo2FYswJmYWe6XtMFfGnWD7cId7rlJXkacALnw+uDwsxbodLp7Ceu+fgz6PmyYEfLNErqNh7fMwODyJxAX6T8IuyTAMD2MLjsh+ToDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035885; c=relaxed/simple;
	bh=Dnaticd4DVBeB/X1+gFdv0OYs/tYKPaCA8+XH+C1NXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bo5zDgEJn2AadmHTlrQ/l59OmbD19vStUgqrHAizY0b8NA4ze64Uu82NoCka09K+lWSpPnrrLXI1xN+CbLnvjaON9guLgQIV3aa0rCZncYIGBM+6FFGxOT7evHbIp1zYnXeKCTvVnFpoI8O94pTjWtXRLDkT8fHmrti3XUETWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOKsWgh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C82B2C4CEEF;
	Mon, 12 May 2025 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747035884;
	bh=Dnaticd4DVBeB/X1+gFdv0OYs/tYKPaCA8+XH+C1NXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HOKsWgh976ABSUCp3D47zbSV32DLPO0ChSJCN52tQgHWw2/lTdg6h7VxK59oz+FPo
	 i92OfZK5tnH0bWLF5AfmOakDAM/XvNZmw0e5kYmUY8nBlPNRyIpoo2TTLZetI8hKLC
	 SgLpF8ZDj0BzzLFN75sZBN/5R37frmPbM1UYzSHS3TKP2Kpqrq2piZob5j4Nbzs53+
	 bICdD39/Qxt8wDuMjGn4oZHJNJmz9bxBSP/F29TCzM5/iSx2axDHnbTFE4OU4JGbmn
	 CtNF+Xs8Ess3Uu1a4qCwCJswBHz10LFioqx8/Nw78esgG17rKSC229IZhx1lYjWioa
	 JhUTpJhfU6IJw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad21cc2594eso421849366b.1;
        Mon, 12 May 2025 00:44:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNHpeOcCujIgCbQEn0YxgPbaf2XDvYkUMDusxz4D4oNlT4fhpRNuVsBOqu4aFAY93DsGbpoSKm@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoDRJ/L1JTv29GCyDJNfZaisD8te8S3cVdGzwkriJayXOZsC4
	NyjtgvI9qYtK0V/0qgSFsR4tQqXo2/bzUyAUXn/fk1QGm5tG9KKdXtlGxlxFO+6MIcX8yvUnjNP
	mkGbXa+iDKXOAl02JR5i7azUhWLE=
X-Google-Smtp-Source: AGHT+IEBQKdQdn/bt57J/rNAcZBekQzBiDhiBsPXLiaWQnq450Ncx9vPv5gYz5RmJVN6XrCWpW6GK6KQb94/GWR5HcE=
X-Received: by 2002:a17:907:3fa2:b0:ad2:59c4:8c with SMTP id
 a640c23a62f3a-ad259c4b415mr144559466b.54.1747035883269; Mon, 12 May 2025
 00:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512052551.236243-1-wqu@suse.com>
In-Reply-To: <20250512052551.236243-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 May 2025 08:44:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
X-Gm-Features: AX0GCFuuqmwHg9L6vUi6tT_11C06O7SAa5VuLoy2mz_JAjwYaW1qfk2tKOP4pOA
Message-ID: <CAL3q7H7cqfhVNwEJ6dgXgZSmfUbOrSNZuua3MPWTs0LJ43BQXQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:26=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a kernel bug report that scrub will trigger a NULL pointer
> dereference when rescue=3Didatacsums mount option is provided.
>
> Add a test case for such situation, to verify kernel can gracefully
> reject scrub when  there is no csum tree.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/336     | 32 ++++++++++++++++++++++++++++++++
>  tests/btrfs/336.out |  2 ++
>  2 files changed, 34 insertions(+)
>  create mode 100755 tests/btrfs/336
>  create mode 100644 tests/btrfs/336.out
>
> diff --git a/tests/btrfs/336 b/tests/btrfs/336
> new file mode 100755
> index 00000000..f76a8e21
> --- /dev/null
> +++ b/tests/btrfs/336
> @@ -0,0 +1,32 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 336
> +#
> +# Make sure read-only scrub won't cause NULL pointer dereference with
> +# rescue=3Didatacsums mount option
> +#
> +. ./common/preamble
> +_begin_fstest auto scrub quick
> +
> +_fixed_by_kernel_commit 6aecd91a5c5b \
> +       "btrfs: avoid NULL pointer dereference if no valid extent tree"
> +
> +_require_scratch
> +_scratch_mkfs >> $seqres.full
> +
> +_try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2>&1 ||
> +       _notrun "rescue=3Dignoredatacsums mount option not supported"
> +
> +# For unpatched kernel this will cause NULL pointer dereference and cras=
h the kernel.
> +# For patched kernel scrub will be gracefully rejected.
> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1

If the scrub is supposed to fail, as the comment says, then we should
check that it fails.
Right now we're ignoring whether it succeeds or fails.

Otherwise it looks fine, thanks.

> +
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
> new file mode 100644
> index 00000000..9263628e
> --- /dev/null
> +++ b/tests/btrfs/336.out
> @@ -0,0 +1,2 @@
> +QA output created by 336
> +Silence is golden
> --
> 2.47.1
>
>

