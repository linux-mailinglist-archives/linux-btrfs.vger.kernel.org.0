Return-Path: <linux-btrfs+bounces-12887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2E0A813E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEB6189C0CF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108823E328;
	Tue,  8 Apr 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbd0X5fE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06823A99F;
	Tue,  8 Apr 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134066; cv=none; b=o/JIlWs9NrUiz0Al6/00X18xKVHONfLCOe6WgSjLGKch4stT7Rp70YTBPCRs1ZA87LnpdHZolI5CEzQkGvizI7dopvTnqjbuG/3aOX6r0iH7JxatGOrrfJOo6PyxHuf54Zx3+yOmeEqz82Z1zJ83kO4W+vJT12kPOr0Bwl+B1uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134066; c=relaxed/simple;
	bh=02pmvrfA+8yr2SiWunOxPrEwLXXVIWWOkzb67Wj2jPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agA76ea1Rf39RUxfSLsAABOWC8sYrOQJCzbU6w3hAZ+fgihcXBysmAl6cmvo9ZAIPNmW8FaYYUaLKGMMNQ4EK7Mcy4OA7GpT+Df4wkOgivxI8rALa0zW0p8scw/J2p32Tgxfv0LUeLPuLx6n+mKqvu7Oug5101NymWOz0ox+DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbd0X5fE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E572BC4CEE5;
	Tue,  8 Apr 2025 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134064;
	bh=02pmvrfA+8yr2SiWunOxPrEwLXXVIWWOkzb67Wj2jPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hbd0X5fEyEIJ4T2NJOcPLZJSHMzm+ONzOaXbPIqBtnk9JcG7wININUVa3MkmMIV3O
	 hYi2FUb0y1zivB0aZUaXcVaZ3tU8hntJx8fs60o2Jq3M3Gocsd6+RfwUMh4PNN0oxw
	 GwZq06lIb2M1oM1x5bxTuJ9G2zbD3NW5y22szUbJxjGzrPfJq/tV79/trE+JCpfK5I
	 cz+gLO+ihhx7tWlWup1eHgICFWzR4uXP4FnxeqsTMcK9GBb54rAoq3jH5oI1aN+x6n
	 npMtrAsCgVt6VKoiYznBErPJX0tZ3IUaJTXl3RYEfmTg885jTG041bXVcFr33FHjfz
	 06Q1icbUCedBA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso1045266166b.1;
        Tue, 08 Apr 2025 10:41:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0UKbAd7w26vkzSniSeWjMyzcOLu4qSXR/rHvtP4cCs8tLF4GaGXiBss6Yh726yK4b5O3cL2lEX9XES9Uy@vger.kernel.org, AJvYcCWPZkLx6OyDXGp9Ibx0gIeV6IsdbzMMDMv0klYKtpl66n+kAFswHK6ghiRanevvfWe6KORp8Th8o6dENg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1so+UcT8+coJCtNRVtHtEA+3ujpUnQ+kuis6hvr9UhAPHNcp
	qZk5z0Yc9R0mX3I11uaoG1QP0PBtIrWTaDB37up6n7F5Z1ltyxAKjaYuwm+Rn3fL4/hEvO+fVZ8
	6wqtZQ9N2LQD52uoJY+j2qDoE66s=
X-Google-Smtp-Source: AGHT+IEw/6KK5mBVt+31O1ud67nf66W1xwBYyP6agFClYHexIfsBQWVGmBg8FnRwZLbR5lokJjqEgKtDr7n5sBKhE10=
X-Received: by 2002:a17:907:60d3:b0:ac3:8895:2775 with SMTP id
 a640c23a62f3a-ac81a645616mr388562566b.13.1744134063555; Tue, 08 Apr 2025
 10:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
 <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com>
In-Reply-To: <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 18:40:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com>
X-Gm-Features: ATxdqUFN74pyiDnNAqNcXbdYvwzLF9lkS_sF2tFGzLDev0eYHMu1jRa4B9406QQ
Message-ID: <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: Daniel Vacek <neelx@suse.com>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:36=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote:
>
> On Tue, 8 Apr 2025 at 16:47, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.com> w=
rote:
> > >
> > > All cleanup paths lead to btrfs_path_free so we can define path with =
the
> > > automatic free callback.
> > >
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > ---
> > >  fs/btrfs/volumes.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index c8c21c55be53..a962efaec4ea 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_=
info *fs_info,
> > >         struct btrfs_trans_handle *trans;
> > >         struct btrfs_balance_item *item;
> > >         struct btrfs_disk_balance_args disk_bargs;
> > > -       struct btrfs_path *path;
> > > +       BTRFS_PATH_AUTO_FREE(path);
> > >         struct extent_buffer *leaf;
> > >         struct btrfs_key key;
> > >         int ret, err;
> > > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs=
_info *fs_info,
> > >                 return -ENOMEM;
> > >
> > >         trans =3D btrfs_start_transaction(root, 0);
> > > -       if (IS_ERR(trans)) {
> > > -               btrfs_free_path(path);
> > > +       if (IS_ERR(trans))
> > >                 return PTR_ERR(trans);
> > > -       }
> > >
> > >         key.objectid =3D BTRFS_BALANCE_OBJECTID;
> > >         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_=
info *fs_info,
> > >         btrfs_set_balance_sys(leaf, item, &disk_bargs);
> > >         btrfs_set_balance_flags(leaf, item, bctl->flags);
> > >  out:
> > > -       btrfs_free_path(path);
> > >         err =3D btrfs_commit_transaction(trans);
> >
> > This isn't a good idea at all.
> > We're now committing a transaction while holding a write lock on some
> > leaf of the tree root - this can result in a deadlock as the
> > transaction commit needs to update the tree root (see
> > update_cowonly_root()).
>
> I do not follow. This actually looks good to me.

path->nodes[0] has a write locked leaf, returned by btrfs_insert_empty_item=
().

> Is there really any functional change? What am I missing?

Yes there is, a huge one. Even if a transaction commit didn't need to
update the root tree, it would be performance wise to commit a
transaction while holding a lock on a leaf unnecessarily.

>
> --nX
>
> > Thanks.
> >
> >
> > >         if (err && !ret)
> > >                 ret =3D err;
> > > --
> > > 2.39.0
> > >
> > >
> >

