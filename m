Return-Path: <linux-btrfs+bounces-15589-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A9AB0C20C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 13:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674D13A657B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209B928DB74;
	Mon, 21 Jul 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQPAveBI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19221421D
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095660; cv=none; b=Ixj7yIdKBeOQP45zLbzYfcGGaO4tCpqQ5m2rS4g8Bo45/SnoRwFugU34UyzmG8Q7E0iMVhFkuwY1I/Wlz0PzAkmcUWaWD4aO+Un3CYRRXWtxWJfBsoB11rb/iVWqSBUIey0AHilcjXbBHHiW/7QcFW3g1wZ3rLJCpKdbXvS3gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095660; c=relaxed/simple;
	bh=LbMgg4Vw2gj22YAVUC4pHooz9lRgkH6tOBsExIlkNPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e03ZP7TK22VQm1zBWxfh3DTr2KxOsLQtPSy0pdzpjCQiwbgVPmsGGdt7Y6G96mgGcICfdIc42xRu5mauYlAQECb/f0t+KNwXO+z0T1vaq7DYvVDLO3P0Am1xIhluwJc+GvKkqZRG6L0dSM4Q+wxZfaOTu9q7JDsUUbOPEQqBe7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQPAveBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BDFC4CEF7
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753095659;
	bh=LbMgg4Vw2gj22YAVUC4pHooz9lRgkH6tOBsExIlkNPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pQPAveBI1CHK3kl4Z75hVxyotSRFfdrzAYTa8UtXuhfTnfE5p+GXPgmHIJ/0k9s2I
	 dVZ6nW3ZXoxDMk890M6eB+08h7R9EJiMX+Sv+LzseE7REREWN8q7Db69xFkPjRc0bv
	 N0AqOXNbI6N28uH2I5rGUh2PIvgSW6NfTQYSBhp0xCHpXs+zdOk7r0rL85i1l2pLru
	 GZkmKpOFFOr3k/Fqqa9jcRnELP4fC0NWY2Vt/dILVsGvQWw3Y1HviIYJ+FE+a74FcE
	 NGDU9yPQ97bzzAjzuwFuu7T1DDc5SahJQRPVpm4pgXx4z6GxiQfLUjhV/2xI8EknEE
	 2K7xMTDdsDoYQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso730201466b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 04:00:59 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxdx7Y9GvSA/3C/0PjBlw+OOOOV/kvjTSQk9bK+WnY2vTfBtm1U
	z8YuTLKGq+/nOgL9t1rXTIV2Vr4GfkekLUSK/r/uAiE4wV911q0QfNZyt7rL2DcSB/kpK1RGPJk
	sZ+Mp7KWZoirSEvVy/RHpyCHlWsE7ffM=
X-Google-Smtp-Source: AGHT+IG9vzgB++wl4kKunGm9AhZF+S6QhFUGr/BaW0IWq78MzWYbQEn/6gXyiK+uCYgSDFoFEtOLE4Xdw6uy4mM93js=
X-Received: by 2002:a17:907:e2c7:b0:acb:37ae:619c with SMTP id
 a640c23a62f3a-aec4de62d50mr1508239266b.15.1753095658346; Mon, 21 Jul 2025
 04:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721070216.701986-1-jth@kernel.org> <20250721070216.701986-2-jth@kernel.org>
In-Reply-To: <20250721070216.701986-2-jth@kernel.org>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 21 Jul 2025 12:00:20 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4zSGnHHvLVLJuRpmKKdBJ3VAQJLZ=SCJbNTRyOEowstw@mail.gmail.com>
X-Gm-Features: Ac12FXxPJNdeMny8G1s9II9VJdTREpuZmHN5exFOMkDqqYMvKOoAgnFfCDvaJVk
Message-ID: <CAL3q7H4zSGnHHvLVLJuRpmKKdBJ3VAQJLZ=SCJbNTRyOEowstw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: directly call do_zone_finish() from btrfs_zone_finish_endio_workfn()
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 8:02=E2=80=AFAM Johannes Thumshirn <jth@kernel.org>=
 wrote:
>
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When btrfs_zone_finish_endio_workfn() is calling btrfs_zone_finish_endio(=
)
> it already has a pointer to the block group. Furthermore
> btrfs_zone_finish_endio() does additional checks if the block group can b=
e
> finished or not.
>
> But in the context of btrfs_zone_finish_endio_workfn() only the actual
> call to do_zone_finish() is of interest, as the skipping condition when
> there is still room to allocate from the block group cannot be checked.
>
> Directly call do_zone_finish() on the block group.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/zoned.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 245e813ecd78..4444a667c71e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2466,7 +2466,8 @@ static void btrfs_zone_finish_endio_workfn(struct w=
ork_struct *work)
>
>         wait_on_extent_buffer_writeback(bg->last_eb);
>         free_extent_buffer(bg->last_eb);
> -       btrfs_zone_finish_endio(bg->fs_info, bg->start, bg->length);
> +       bg->last_eb =3D NULL;

Setting bg->last_eb to NULL is something new, and it's not done in
btrfs_zone_finish_endio() as well.
Isn't this a separate change that should have its own changelog? Do we
have the potential for some use-after-free without this change?

> +       do_zone_finish(bg, true);

This part looks good.
This can return errors but we are ignoring them here, as well as in
btrfs_zone_finish_endio(). Can we at least assert that it's returning
0?

Thanks.

>         btrfs_put_block_group(bg);
>  }
>
> --
> 2.50.0
>
>

