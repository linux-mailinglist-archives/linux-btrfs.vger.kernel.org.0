Return-Path: <linux-btrfs+bounces-19738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34868CBD44F
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F4B530178AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3983E314B84;
	Mon, 15 Dec 2025 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GF3wy+TJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BE1F03C5
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792210; cv=none; b=MTrRZPe19evm4BrYKG1fa1H7QIxFHk1Cj5PzrF3VCz7U+TzqRfW50skbdNpBl8+JLitPodNPKxdnGi09KJ/Ps7y5bzAqZZd1JMXhMN4NMV1qYkJH+VagRYywvSDo6SyIs16eAh1TwRurUZtAqcO5x/2huADc3nDEkhVcSD5GpYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792210; c=relaxed/simple;
	bh=XjYLWEptO9W8f9l3fsI/l+u4DFsr+RkCfDN0M950YAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0M1Rs4gWNwo4+TYFcD5jf2Scv1FsWeQpu3R/h1RHPhkbMAsMB8RbAECrh21JfSnBxMAe1CvgH46MABHwiQdunFyPLOYAZbZwAfpyhm5V5mkJwsrGxQXwK3t1Hpg2MieBIhqjH5AwpDDurhb5aOHqtMvE93Pe4GpII+JufEULIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GF3wy+TJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55EF9C4CEFB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765792206;
	bh=XjYLWEptO9W8f9l3fsI/l+u4DFsr+RkCfDN0M950YAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GF3wy+TJ2C4ZnCpIS1wq7NsPpX2vMY2X4hjxQFHeo2MQIVU46xJuo/icfk9S4kTl0
	 HTUwQJile2aksxdN4A3ANPlNRElUhLMbvT74FHpVN0IFZeRwuTy7Y5h+74RXj4ErN4
	 clUEcTO7eHCd68uuoolBuYplY1xFGeWfC4UeYYCiEY/UqT0lfN9Yk7IJFlm+6+8++p
	 O2QWhiMAth82pjDk5S8Xnx0kkMl4uGdcjkO4sm4d19BPLfKy1OiZdSEw2ERHKpcY7n
	 J2ormhd3m5aHeQ6LT5kpckTeUniiDCr7y/xzXU3SH2OJK+W+MZgzwxVYrlCVkEhmC0
	 VBr1BGv9uwaPQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7355f6ef12so575885666b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 01:50:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxOy7wD0aUr5HzaTt9aDji0yeTU3rsgYMwrNB7ho/Bcl4lipFN0
	HZBA3mTYzp2khGdAqQQIWxzh85LMPcbAl1p1CC3Z2G+Ait3H+qa+Jaes8y4T/Q9gKgPQTZEPWRk
	01IdtTqG3CtS5p8nda8GN6M7Ol29viDQ=
X-Google-Smtp-Source: AGHT+IFPHLUoQ5iX9eUzE31pbF2ir2Y+cKDakq25MYW3txEz1vq9rnf3zZdiBE5ngZNQSdomV36gWfcabr++UMNGmDk=
X-Received: by 2002:a17:907:2d20:b0:b76:49ae:6eea with SMTP id
 a640c23a62f3a-b7d23c5bcdamr996328966b.47.1765792204899; Mon, 15 Dec 2025
 01:50:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765743479.git.fdmanana@suse.com> <edd0445538783749845d7b1911737237a41595ff.1765743479.git.fdmanana@suse.com>
 <24e5d07f-322d-4eba-9aaf-e9f4be027bd6@gmx.com>
In-Reply-To: <24e5d07f-322d-4eba-9aaf-e9f4be027bd6@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 15 Dec 2025 09:49:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Vkz53Edf=i2+yKpqs7mQt_qqZiveV43L1qU8cK8WEvw@mail.gmail.com>
X-Gm-Features: AQt7F2ogtggOHXbLQzi9eUomKxgXLjhPQG9oEmm7haou4R_gPPotcNJSAyiddQA
Message-ID: <CAL3q7H6Vkz53Edf=i2+yKpqs7mQt_qqZiveV43L1qU8cK8WEvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: update stale comment in __cow_file_range_inline()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 9:47=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2025/12/15 20:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We mention that the reserved data space is page size aligned but that's
> > not true anymore, as it's sector size aligned instead.
> > In commit 0bb067ca64e3 ("btrfs: fix the qgroup data free range for inli=
ne
> > data extents") we updated the amount passed to btrfs_qgroup_free_data()
> > from page size to sector size, but forgot to update the comment.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index f1ead789146b..6ae36cc5bcda 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -676,7 +676,7 @@ static noinline int __cow_file_range_inline(struct =
btrfs_inode *inode,
> >       /*
> >        * Don't forget to free the reserved space, as for inlined extent
> >        * it won't count as data extent, free them directly here.
> > -      * And at reserve time, it's always aligned to page size, so
> > +      * And at reserve time, it's always aligned to sector size, so
> >        * just free one page here.
>
> There is still a "page" reference here.

Ah yes, I will update it before pushing to for-next, thanks.

>
> Other than that it looks good to me.
>
> Thanks,
> Qu
>
> >        *
> >        * If we fallback to non-inline (ret =3D=3D 1) due to -ENOSPC, th=
en we need
>

