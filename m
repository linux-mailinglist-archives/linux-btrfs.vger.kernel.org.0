Return-Path: <linux-btrfs+bounces-18417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7783C203A3
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 14:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F9DD347D11
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 13:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E072FB977;
	Thu, 30 Oct 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3tXe3ok"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205028751A
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830721; cv=none; b=AvtH1QkN4QMVma3J2YUi2OU8m9KILEL9LiiUjf0giXO1PsmUDhcv5Tp+FMbzYVHreq9G3SdBnfBIcG3ObGvLOCe3OgvXDwVTW42o07e6HhSCob/tCqIjXTGXrohC9pxGMagSjrDaUVZHx2OG75rtuqzw7pmZRi7957ZYxMwNgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830721; c=relaxed/simple;
	bh=tSYaw20epef0xQFmrdjwt7AssLnRXOP4gzZuafdkDZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOxjR2BxP2syJ9ffCgL63wxkuAh+5Bv2F4PwgQOs/vowvTELHO6bzQZ5CB75ooOFVSwrNWcNbMAr0wM2oN05QuKuytBE4AKxnbja3DvxL6MWP1TJfwBSuWyJHmHZNEQfqGe3UNPLOTlpG3sxLkearw62I69qYZrXZaBA+Qp69e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3tXe3ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07B3C4CEF1
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761830720;
	bh=tSYaw20epef0xQFmrdjwt7AssLnRXOP4gzZuafdkDZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3tXe3oklXL6/oU59glUL6W7L5+FgXdJrC/dUPz5P0BSfi5UKI1+TY+pR4zgIk/k8
	 EJeLLpudnwiXrr25QkleZF/RGJQwCmf+1jbuxB3DCmcvUMjTtxe2/bDJAs4HxuXpjC
	 yvCBcOR5C2AmbbTXFCEWb8rIhzBDspS+20FrppubDtOhUow8J71w196HNklxf+aOCQ
	 wBn/+WVzYaHnL57+qzC1l3PHyRDnHXpQax+4KW6yJWObrRTLv3ceiPfykJ24vAza8W
	 PAXuq+rARgA9+IZwOzj1PEMt8+6dsFZ2zDWmQW1ilcmxwe1ykg0fpGcZ0hjWFBfu5M
	 orgCOT2r+xDjA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d78062424so73578166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 06:25:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/VO0NasL+1Ka1zBfymq3tMYvoOz97MuQ7ln+b2+A+mNIRELGklTOAzryXeeE+WuR/+F2U76bqO6pDYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTGR0hKS0c2sGAY9m6t2IS0TxLlw6Px/useJi+7P+WgI/JaHI
	lQ0hESPie1kAUdAd4h4vN5aqqbT45RgL4z6WRJDWrXJDQH+XMM4bIaoJ590CnVsO2y1nrlhne6v
	I8gsz34+gLIqx03hzAoz/ZFFDzvFhwvg=
X-Google-Smtp-Source: AGHT+IF1QYMNNzMgkL8cw0xf+U550ADAf5a9rXzvmqdOKg2SZ9XfdaQnaiZ0QZvIgTiJNLup0nQejsG7g9uk9NkZmLQ=
X-Received: by 2002:a17:907:3d0d:b0:b6d:55fe:a50f with SMTP id
 a640c23a62f3a-b7053e32af6mr326362866b.42.1761830719373; Thu, 30 Oct 2025
 06:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f88a750276cab164dc07fabe09b171307ce64e64.1761348631.git.wqu@suse.com>
 <FDBD17D73E911416+7ade80f6-f273-4190-83e9-61e98aeac808@bupt.moe>
In-Reply-To: <FDBD17D73E911416+7ade80f6-f273-4190-83e9-61e98aeac808@bupt.moe>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 30 Oct 2025 13:24:42 +0000
X-Gmail-Original-Message-ID: <CAL3q7H66j2NczLbXj6ZJmy_fu1uPHMHfG_Xit-Kgw7_V+0VSdw@mail.gmail.com>
X-Gm-Features: AWmQ_bkPVL5H3kNq2DrzlD8dfe10GGtOeYWT9WcsD6kPVNrnn94ybiGUEXFMoZ8
Message-ID: <CAL3q7H66j2NczLbXj6ZJmy_fu1uPHMHfG_Xit-Kgw7_V+0VSdw@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: convert: prevent data chunks to go beyond
 device size
To: Yuwei Han <hrx@bupt.moe>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:17=E2=80=AFAM Yuwei Han <hrx@bupt.moe> wrote:
>
>
>
> =E5=9C=A8 2025/10/25 07:30, Qu Wenruo =E5=86=99=E9=81=93:
> > [BUG]
> > There is a bug report that kernel is rejecting a converted btrfs that
> > has dev extents beyond device boundary.
> >
> > The invovled device extent is at 999627694980, length is 30924800,
> > meanwhile the device is 999658557440.
> >
> > The device is size not aligned to 64K, meanwhile the dev extent is
> > aligned to 64K.
> >
> > [CAUSE]
> > For converted btrfs, the source fs has all its freedom to choose its
> > size, as long as it's aligned to the fs block size.
> >
> > So when adding new converted data block groups we need to do extra
> > alignment, but in make_convert_data_block_groups() we are rounding up
> > the end, which can exceed the device size.
> >
> > [FIX]
> > Instead of rounding up to stripe boundary, rounding it down to prevent
> > going beyond the device boundary.
> >
> Reported-by: Andieqqq <zeige265975@gmail.com>

While at it, also add a Link tag pointing to the report....

> Signed-off-by: Qu Wenruo
> <wqu@suse.com>
> > ---
> >   convert/main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/convert/main.c b/convert/main.c
> > index e279e3d40c5f..5c40c08ddd72 100644
> > --- a/convert/main.c
> > +++ b/convert/main.c
> > @@ -948,8 +948,8 @@ static int make_convert_data_block_groups(struct bt=
rfs_trans_handle *trans,
> >                       u64 cur_backup =3D cur;
> >
> >                       len =3D min(max_chunk_size,
> > -                               round_up(cache->start + cache->size,
> > -                                        BTRFS_STRIPE_LEN) - cur);
> > +                               round_down(cache->start + cache->size,
> > +                                          BTRFS_STRIPE_LEN) - cur);
> >                       ret =3D btrfs_alloc_data_chunk(trans, fs_info, &c=
ur_backup, len);
> >                       if (ret < 0)
> >                               break;
>

