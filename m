Return-Path: <linux-btrfs+bounces-11787-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE393A44994
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5EE189A5F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810A119D090;
	Tue, 25 Feb 2025 18:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPlT9ZFF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C3CEEA9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506635; cv=none; b=q9WFZI7HiMXna3Nu4dEk3B2CgBUd947tM0jtigKVFwiNc8lHFq9JWdwqbHTJnfZUX9nxl07ap4LSkT2iY6wGRuRp3/DymyhCJ3AMBjSGJWA3UxgKlzfs6BpwrtbXdxyMNtV7kIAq4YzzGVX97SdGSoMoZ5bURfOmo7ti4Qa/m6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506635; c=relaxed/simple;
	bh=yrg/D9Y6gq43mD4DfnClM9Y7mUgc1Ayn4YHYGbD30Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8WBjSr/mfo0Qfq7/bkEPUTdz8AAHKEv2aQbL8vR3G8gfziCHnHbCu7ar13vMulAJHB5c0Q2qxDwnBqCgnm8vpqPQNR+yUrt8RfEYjm+YfW/6hmP3DLEI+iQqwsg5d2+5j0uHyOJcx4Q8bISmLpklt6pg2MvaP9ed7QftD3FSF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPlT9ZFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0AFC4CEDD
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506635;
	bh=yrg/D9Y6gq43mD4DfnClM9Y7mUgc1Ayn4YHYGbD30Pg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CPlT9ZFFgMS+2RnC0MOeY3Ne7fNpAyUUtRngsuu1d1S7JzvCY5Cl3zZSlZ302Xp5o
	 cApBPqDW2HnYpXJCCuOr8czR+FNlptISJvTabOIggca8E8GrlkDwIdZwpnphlqxQxs
	 nnoifZUHJAg3TUw0x0ghOISrLGWFwjfaHByZCsCsfHKDT02aL1vxzSQqHDeMlAX53x
	 Fea+Sg0xDW6Shs2BFaaV8E+JqErxIGHkQVpzrKjBTnwdLj+vfSPO7wSSs0etjNQNfS
	 /O09SSdhlYvuynBMsew8opodYaturRMWXm3qYPqapEEKFBahiGC27NqFoHv5GuZiZO
	 BD7GoZs1Xf4OQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec8b750ebso269231066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:03:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yx41eA3plTtzoBdr/F8QPKko+Hzmz8X3+VA3kZQxbTVy0Z/F74t
	haM2mGO0ED0d7y5rOlBXJCTXX4gfdkqdED/ytV+mcJYo9S5ubtLW+SmSKt2vXOhS268+esB479d
	hg9AoZGilFXdiJSW7PMrByFVuanw=
X-Google-Smtp-Source: AGHT+IEuGNeyKJaJzdSEkAFzN6jwQnFIspKqB7nHpOrvIJbJnfxvg5YzjWvULcId5WorlDvJISU+Sk26BRUo5CeiynY=
X-Received: by 2002:a17:906:3296:b0:abb:b1ae:173b with SMTP id
 a640c23a62f3a-abc0d994e4emr1642974166b.11.1740506633797; Tue, 25 Feb 2025
 10:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <592f1b35af2c203e4bb6dd6431b6bb0c880e81aa.1740354271.git.wqu@suse.com>
In-Reply-To: <592f1b35af2c203e4bb6dd6431b6bb0c880e81aa.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 18:03:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fJA_rr-xuRY2pJqdLa9fxiKKwoGHyrxe_Bp0d-fcQRg@mail.gmail.com>
X-Gm-Features: AWEUYZlEcfvBryl-6vgYGGSI2UzF2ObG7s6XUUaY3P0Enyefsw521b5mJQ6jxmE
Message-ID: <CAL3q7H5fJA_rr-xuRY2pJqdLa9fxiKKwoGHyrxe_Bp0d-fcQRg@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: allow inline data extents creation if block
 size < page size
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Previously inline data extents creation is disable if the block size
> (previously called sector size) is smaller than the page size, for the
> following reasons:
>
> - Possible mixed inline and regular data extents
>   However this is also the same if the block size matches the page size,
>   thus we do not treat mixed inline and regular extents as an error.
>
>   And the chance to cause mixed inline and regular data extents are not
>   even increased, it has the same requirement (compressed inline data
>   extent covering the whole first block, followed by regular extents).
>
> - Unable to handle async/inline delalloc range for block size < page
>   size cases
>   This is already fixed since commit 1d2fbb7f1f9e ("btrfs: allow
>   compression even if the range is not page aligned").
>
>   This was the major technical blockage, but it's no longer a blockage
>   anymore.
>
> With the major technical blockage already removed, we can enable inline
> data extents creation no matter the block size nor the page size,
> allowing the btrfs to have the same capacity for all block sizes.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/inode.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e99cb5109967..a1ea93bad80e 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -566,19 +566,6 @@ static bool can_cow_file_range_inline(struct btrfs_i=
node *inode,
>         if (offset !=3D 0)
>                 return false;
>
> -       /*
> -        * Due to the page size limit, for subpage we can only trigger th=
e
> -        * writeback for the dirty sectors of page, that means data write=
back
> -        * is doing more writeback than what we want.
> -        *
> -        * This is especially unexpected for some call sites like falloca=
te,
> -        * where we only increase i_size after everything is done.
> -        * This means we can trigger inline extent even if we didn't want=
 to.
> -        * So here we skip inline extent creation completely.
> -        */
> -       if (fs_info->sectorsize !=3D PAGE_SIZE)
> -               return false;
> -
>         /* Inline extents are limited to sectorsize. */
>         if (size > fs_info->sectorsize)
>                 return false;
> --
> 2.48.1
>
>

