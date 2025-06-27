Return-Path: <linux-btrfs+bounces-15045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC8AEB72A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E413A6C41
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5F32D2397;
	Fri, 27 Jun 2025 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRqlaZeK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA742C324C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751026231; cv=none; b=HPSwGS+tpxo3Eo0cQ/KMgWIn51OVTeXgdrFmzcYq4F+7sUvwEc1CsXSi2oLaVW8pmNnu/+kUQdtX/8dg55q4LoefT4g2PGw6zRbyzc0Ib7mzNu7ha5DttBXsfvWMZGwGdotODwIqcjjhxIEq6uuCD5dmjK7Q3mQT0WhpOeuP1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751026231; c=relaxed/simple;
	bh=hNdZg8NdCypBcfukazGFR2HvJ3lpnDwtnAH/GdTtx6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLv5U2dSYn09qTh83oT6Ln1qwkJsRMToZAvCeOwpCeaSZH3dd5CyiPChKECBZ6ZrYEnKyeuILOo9Xkj2VFWrAws6IOh+VVySc4/TfqBEO+boT9a5BZKoHTdCeQHszXU3AX/HNHun//oOYzcwtnssdzTHOdNwIS0VHeHeqetHFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRqlaZeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A48CC4CEE3
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751026230;
	bh=hNdZg8NdCypBcfukazGFR2HvJ3lpnDwtnAH/GdTtx6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RRqlaZeKomX0qG7gaLjadle6L2+IXywlHuMQE0KaSzOL6M8a0JYr5TFYF83w25CZb
	 qO4U6TxVVlk3Hxm1eok2oO6Hpnakjl2cYZxdvKYd8cGU/4Yg9wberNAjCqbMSap28Y
	 KYf7zIOI7dxRwSlQIdwh+ow1qgHOc8AEwAXT6jMOtoA4OshZycPbHcKoOqOGZWt0C3
	 nYFFGsMzrJUNw9dZbdLktewDwDAC1pimNRNy9MX2FmqyoQFGAn9mlmM49FqrujqpbN
	 TtfxA3y/1zBcjeFEk9GBFpK91b19YWf8T9Satq4nl2scI5MbHbYwSNVmsq2JX8Hg5X
	 WwcIbbo1n48+g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so3440970a12.3
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 05:10:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YwUzB4KmKcgsXyJQ4dfxtlSw9dzcnuK3jaW6WDlDxVTLOpz5JWM
	lVckn2q/SjqJ/rQ9LCqM0loELzXNCzcy3osn8tOYf4/5ZplkxYY3aeTo5czor2lzDEVqsdPBpPe
	BmP6aQHAEa1MnYPFT9nnCclsMQpwLVQs=
X-Google-Smtp-Source: AGHT+IGfku74xzPAzb8Nx+j4k1kBdEFFP5qSrP4HkPRQGN/xdzL1g6JQ681ImaIXwGUNw6lX7xO6m1xs+ty9XkpWk14=
X-Received: by 2002:a17:906:68d2:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae3500e035emr284085766b.29.1751026229222; Fri, 27 Jun 2025
 05:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750709410.git.fdmanana@suse.com> <894622cd2bfaf3d1871f2d88ba0a212e7661e136.1750709410.git.fdmanana@suse.com>
 <2342e2ff-916c-45f8-9ac0-cb7b701e588e@gmx.com>
In-Reply-To: <2342e2ff-916c-45f8-9ac0-cb7b701e588e@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 27 Jun 2025 13:09:51 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Y9aQ_opn7ODWgBC_gYxShZVZb-cdET--Zbk-7ryiD1A@mail.gmail.com>
X-Gm-Features: Ac12FXxCpt9e8j3PT1bE7AwJcjVi5LM53QqbOy-cN2tlYOjhNj7DocvZYcHSDLA
Message-ID: <CAL3q7H6Y9aQ_opn7ODWgBC_gYxShZVZb-cdET--Zbk-7ryiD1A@mail.gmail.com>
Subject: Re: [PATCH 02/12] btrfs: fix iteration of extrefs during log replay
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 11:51=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2025/6/25 00:12, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At __inode_add_ref() when processing extrefs, if we jump into the next
> > label he have an undefined value of victim_name.len, since we haven't
>
>          ^^ he?

Ah, it was supposed to be "we". Will fix that up, thanks.

>
> Otherwise looks good to me.
>
> I'll give a reviewed-by to the cover-letter to avoid bombarding the
> mailing list.
>
> Thanks,
> Qu
>
> > initialized it before we did the goto. This results in an invalid memor=
y
> > access in the next iteration of the loop since victim_name.len was not
> > initialized to the length of the name of the current extref.
> >
> > Fix this by initializing victim_name.len with the current extref's name
> > length.
> >
> > Fixes: e43eec81c516 ("btrfs: use struct qstr instead of name and namele=
n pairs")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/tree-log.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 08948803c857..e862deaf27da 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -1146,13 +1146,13 @@ static inline int __add_inode_ref(struct btrfs_=
trans_handle *trans,
> >                       struct fscrypt_str victim_name;
> >
> >                       extref =3D (struct btrfs_inode_extref *)(base + c=
ur_offset);
> > +                     victim_name.len =3D btrfs_inode_extref_name_len(l=
eaf, extref);
> >
> >                       if (btrfs_inode_extref_parent(leaf, extref) !=3D =
parent_objectid)
> >                               goto next;
> >
> >                       ret =3D read_alloc_one_name(leaf, &extref->name,
> > -                              btrfs_inode_extref_name_len(leaf, extref=
),
> > -                              &victim_name);
> > +                                               victim_name.len, &victi=
m_name);
> >                       if (ret)
> >                               return ret;
> >
>

