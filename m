Return-Path: <linux-btrfs+bounces-12889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E0A8141B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539201BA60F5
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626BA23DEAD;
	Tue,  8 Apr 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfHJxXnT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2AB1B6CFE;
	Tue,  8 Apr 2025 17:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134774; cv=none; b=AlUSUoZrtGYE0bvkEA9EHKJvjHpQl7AtOEm0wCU66j2dPD+O/xls6lMOQ2kD+ly0Uc8ZtlEF/21T/sXBVxaqOX4NGQQpSUx/qpfQRG1PWtDjil64HvU1n2X/3TSc27Ddt+nqlkM0Yg8mp5U4erU6yFtgAxLDZy3lyA+HHg4GYsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134774; c=relaxed/simple;
	bh=jhFQN4n2+3BCxXUk6o/zTy4jcVT5r4gTUiwXyzT6UP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ttzouqAQwAKA4EDuxXI505PgrBb6ufIMkKzwJKJQLxHuWEM2+iRFeKKlgJiQ2osoNGxYO5aXvxc5FO0sFFPy1sZqzdeXQ8DpuOeVuk/DzBoV3IsPJo+owzrzcOwQbzk7mvVp7AzIArCNE99lf2CNfmRWPXMtb2S592Z9T5G7w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfHJxXnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE28C4CEE9;
	Tue,  8 Apr 2025 17:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744134774;
	bh=jhFQN4n2+3BCxXUk6o/zTy4jcVT5r4gTUiwXyzT6UP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KfHJxXnTTRwSnEBpt5o5jSm+jS4oYQETz9qWiXHHFyZ/0j5lr55D4gP9H5sWUpufS
	 HpQ36T8Ev2+ODQRDElC/lXDrMt1hTzE7NKpuOzXvyJSMjjowbzPPhyHaeqEqU50A3Z
	 eQvRW8QT2eFM2alRP5avlrXtFqTmCna2X1M4+ENH/pSCbMl29qhFXQlGUSIenmBrA/
	 TseUs4IdhC4/tIeibELH5iyaqFr1J3hSPJZ93N9En/4ndt3+P+lNV/ZVne1xrk0CJP
	 vNaKN2Zh2SaOTABcFzOV/h6WDhvHOl3m5OJgquvPSVZYLxpjjRCqqo7eogbFRezLOe
	 c2dP7s2FJSQsg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac28e66c0e1so890342066b.0;
        Tue, 08 Apr 2025 10:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUapI9SnkvAckrGAJ3SIqbSXNRF6K+cHHgAooM6IwiiE92CIptHiydn/TnBtWTWYnBHsppvUPn+IU7/cQPm@vger.kernel.org, AJvYcCWZHBFcNHUqA3Mu2lZCJn37FH0SmbqooCg7dUA3kG01npxafVCi5hbSBTyTpF7y1VBSwLIS+v/KKTcqSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNvguo8au8qQGZ9NnmWnup/abP4/GW4OVU6znoD6U0MpHQwxWg
	70Uzaf1jk6Kf0fcwZ0iGH03OEQQ4fFrJhhoJIhXfu48Se1vdja3yMwO7AEoV05BpKCJXNRwqe6+
	Vi2+1h7r+bTuMtmUTTcRG+p2cLTQ=
X-Google-Smtp-Source: AGHT+IEUY821H8E/1HCQbaWN87Ugcv7DetZfR/tmpFkjatz8CS6iGXM9MMrgDsx2iSZbMgFtpktuurQOUBQmeFhnK3w=
X-Received: by 2002:a17:907:d14:b0:ac7:3912:5ea8 with SMTP id
 a640c23a62f3a-aca9b7655famr8336166b.61.1744134772984; Tue, 08 Apr 2025
 10:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
 <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com>
 <CAL3q7H40yF8q78vZgd2c92LZMzBxqvU3XTrWMu86th1mGsGYDg@mail.gmail.com> <CAPjX3Fd275aj0g5CWVKyX2wu0Sjn3a3UdZBaOR5MqUV55e4ZXw@mail.gmail.com>
In-Reply-To: <CAPjX3Fd275aj0g5CWVKyX2wu0Sjn3a3UdZBaOR5MqUV55e4ZXw@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 8 Apr 2025 18:52:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5BGF6cnLd3-fbp_Szq4_DSekbcM_nz_ZSGnS40w90X6Q@mail.gmail.com>
X-Gm-Features: ATxdqUFWfBOJ268iOOm6tFiMaXkFTmuMhSwNEf-5nfKP_t825tO75ilS8PiUimU
Message-ID: <CAL3q7H5BGF6cnLd3-fbp_Szq4_DSekbcM_nz_ZSGnS40w90X6Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: Daniel Vacek <neelx@suse.com>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 6:47=E2=80=AFPM Daniel Vacek <neelx@suse.com> wrote:
>
> On Tue, 8 Apr 2025 at 19:41, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Tue, Apr 8, 2025 at 6:36=E2=80=AFPM Daniel Vacek <neelx@suse.com> wr=
ote:
> > >
> > > On Tue, 8 Apr 2025 at 16:47, Filipe Manana <fdmanana@kernel.org> wrot=
e:
> > > >
> > > > On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.co=
m> wrote:
> > > > >
> > > > > All cleanup paths lead to btrfs_path_free so we can define path w=
ith the
> > > > > automatic free callback.
> > > > >
> > > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > > ---
> > > > >  fs/btrfs/volumes.c | 7 ++-----
> > > > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > > index c8c21c55be53..a962efaec4ea 100644
> > > > > --- a/fs/btrfs/volumes.c
> > > > > +++ b/fs/btrfs/volumes.c
> > > > > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs=
_fs_info *fs_info,
> > > > >         struct btrfs_trans_handle *trans;
> > > > >         struct btrfs_balance_item *item;
> > > > >         struct btrfs_disk_balance_args disk_bargs;
> > > > > -       struct btrfs_path *path;
> > > > > +       BTRFS_PATH_AUTO_FREE(path);
> > > > >         struct extent_buffer *leaf;
> > > > >         struct btrfs_key key;
> > > > >         int ret, err;
> > > > > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrf=
s_fs_info *fs_info,
> > > > >                 return -ENOMEM;
> > > > >
> > > > >         trans =3D btrfs_start_transaction(root, 0);
> > > > > -       if (IS_ERR(trans)) {
> > > > > -               btrfs_free_path(path);
> > > > > +       if (IS_ERR(trans))
> > > > >                 return PTR_ERR(trans);
> > > > > -       }
> > > > >
> > > > >         key.objectid =3D BTRFS_BALANCE_OBJECTID;
> > > > >         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > > > > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs=
_fs_info *fs_info,
> > > > >         btrfs_set_balance_sys(leaf, item, &disk_bargs);
> > > > >         btrfs_set_balance_flags(leaf, item, bctl->flags);
> > > > >  out:
> > > > > -       btrfs_free_path(path);
> > > > >         err =3D btrfs_commit_transaction(trans);
> > > >
> > > > This isn't a good idea at all.
> > > > We're now committing a transaction while holding a write lock on so=
me
> > > > leaf of the tree root - this can result in a deadlock as the
> > > > transaction commit needs to update the tree root (see
> > > > update_cowonly_root()).
> > >
> > > I do not follow. This actually looks good to me.
> >
> > path->nodes[0] has a write locked leaf, returned by btrfs_insert_empty_=
item().
>
> Well, the first return is before calling this function and the final
> return is only after committing.
>
> Again, the function keeps it's former structure as it was before this
> patch. I still don't see any logical or functional change.

I don't know how to put it simpler to you. There's a path setup by
btrfs_insert_empty_item(), with a leaf locked in write mode.
You can't just do a transaction commit while holding it locked, as
this can deadlock because updating the tree root is part of the
critical section of a transaction commit.
It seems trivial to me...

>
> I'm lost. This still looks to me just as a straightforward cleanup.
>
> > > Is there really any functional change? What am I missing?
> >
> > Yes there is, a huge one. Even if a transaction commit didn't need to
> > update the root tree, it would be performance wise to commit a
> > transaction while holding a lock on a leaf unnecessarily.
> >
> > >
> > > --nX
> > >
> > > > Thanks.
> > > >
> > > >
> > > > >         if (err && !ret)
> > > > >                 ret =3D err;
> > > > > --
> > > > > 2.39.0
> > > > >
> > > > >
> > > >

