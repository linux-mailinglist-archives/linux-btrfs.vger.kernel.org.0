Return-Path: <linux-btrfs+bounces-18165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7922DBFBE34
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 14:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B43A5356FF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 12:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A72E343D8A;
	Wed, 22 Oct 2025 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9bEy5bP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEA33C52C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136670; cv=none; b=jSy7SbXyFRpG2rK+SCLM2/47bpPJAV3heCXq+TP/qNiRwhvvtMdQ0Vsm2r86/UyAJhwV1P91H6dygtLDV/jPr5cQUsFhkoKLUlt5gQIA8M+7gqjCSL5BY74vAudslM3oHaNa4zdCy1q84eNHwfic1Uzxu/Y7vjfbt3UwKrWGkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136670; c=relaxed/simple;
	bh=ijt5oSiP9dG77/Bs+kX7qagG2siRPeDmYnt8eMO9SfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx6eZWUojj3Fmb9T1+hNQYwf/peTIsn1wyXviYQ2hFp3iLSZ0Rt3QEgIuT8yrY4s0t3hz8jMFuPQij2QkLt7ij0I8vvHgpivHCW7gj2KVyue1TFBP+lo8h0gq9iy5A3Lls/yvwTnZlA8NbnEZlIOlhEfThm8VMoMJ0IesusHxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9bEy5bP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E698C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761136670;
	bh=ijt5oSiP9dG77/Bs+kX7qagG2siRPeDmYnt8eMO9SfE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b9bEy5bPvEF4Aviym3jgxxGiSVQFu8WAYG8v0uYmihDeb/1P2tFdgz8LJ1Lkr3b9I
	 gQ+GW3CUs4MvPwvZWeL5HbM9XFm0JVVGZhR5L3Mu7HXmGtHj0Peiwn4ozGp8XdyMpT
	 Qpj69gQRfE41z4CGd0o/175oBXAsDJJ6Xx+7WRD4ZEHmRwNihVJaiV9HUko8CH1JeC
	 kigVztD2bnInxFyo1yr9kPE/fTwCSvzRvcTvbzNLh7ldtw18vUEbnWg7HrTCEtYow0
	 V7cPb0HWjCa0NJcbiGRstLB7eyd2zthNi+XJHFtqDcNBdR9JRFZL5Ctcx4XIo+98pp
	 vmxe8kPnX4eMQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e9d633b78so233473566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 05:37:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YwS2lyDJbTtUoArcCyIGnZ3LRuUuzoEc6giVSQFw1kSM6Cs+PMm
	UVnnwm2AsqNyRwdgZuH4X4GQhKmJjcGuf4hsvwsuzGMGPxChmo9s/znmyb94+dPWbLD9OzaPEsG
	abZv+vluVHJHGGfFcA3c62qVw+jDVeaE=
X-Google-Smtp-Source: AGHT+IHM+j5vxre2A5VT7Rqx/Ksylyrber6dnDmLv1N37KJlzeGj1y2+uTbCimVMKyv9V0va7MLaxlFpcbKZBbWFTd4=
X-Received: by 2002:a17:906:794f:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b6d2c6dfe0cmr429712766b.7.1761136668689; Wed, 22 Oct 2025
 05:37:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <377fc6736bba9df49b7bdeeb80f36b17f610eeb2.1761018694.git.wqu@suse.com>
In-Reply-To: <377fc6736bba9df49b7bdeeb80f36b17f610eeb2.1761018694.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 Oct 2025 13:37:11 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4AK8woExMEprhBpQopgL2Rm-quOjOB1bmVJCFz4jUs-Q@mail.gmail.com>
X-Gm-Features: AS18NWDwthNmCXyRgMKFKzTRko1Qg0U745Xcxe5tqkHKSVPUN8bp9pSPjimqnWQ
Message-ID: <CAL3q7H4AK8woExMEprhBpQopgL2Rm-quOjOB1bmVJCFz4jUs-Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: subpage: simplify the PAGECACHE_TAG_TOWRITE handling
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:52=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> In function btrfs_subpage_set_writeback() we need to keep the
> PAGECACHE_TAG_TOWRITE tag if the folio is still dirty.
>
> This is a needed quirk for support async extents, as a subpage range can
> almost suddenly go writeback, without touching other subpage ranges in
> the same folio.
>
> However we can simplify the handling by replace the open-coded tag
> clearing by passing the @keep_write flag depending on if the folio is
> dirty.
>
> Since we're holding the subpage lock already, no one is able to change
> the dirty/writeback flag, thus it's safe to check the folio dirty before
> calling __folio_start_writeback().
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/subpage.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 0a4a1ee81e63..80cd27d3267f 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -440,6 +440,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_f=
s_info *fs_info,
>         unsigned int start_bit =3D subpage_calc_start_bit(fs_info, folio,
>                                                         writeback, start,=
 len);
>         unsigned long flags;
> +       bool keep_write;
>
>         spin_lock_irqsave(&bfs->lock, flags);
>         bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bi=
ts);
> @@ -450,18 +451,9 @@ void btrfs_subpage_set_writeback(const struct btrfs_=
fs_info *fs_info,
>          * assume writeback is complete, and exit too early =E2=80=94 vio=
lating sync
>          * ordering guarantees.
>          */
> +       keep_write =3D folio_test_dirty(folio);
>         if (!folio_test_writeback(folio))
> -               __folio_start_writeback(folio, true);
> -       if (!folio_test_dirty(folio)) {
> -               struct address_space *mapping =3D folio_mapping(folio);
> -               XA_STATE(xas, &mapping->i_pages, folio->index);
> -               unsigned long xa_flags;
> -
> -               xas_lock_irqsave(&xas, xa_flags);
> -               xas_load(&xas);
> -               xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> -               xas_unlock_irqrestore(&xas, xa_flags);
> -       }
> +               __folio_start_writeback(folio, keep_write);
>         spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>
> --
> 2.51.0
>
>

