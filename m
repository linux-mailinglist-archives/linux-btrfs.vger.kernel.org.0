Return-Path: <linux-btrfs+bounces-14435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92620ACCEE4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36EF1896C07
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D935225761;
	Tue,  3 Jun 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cO3uP3NM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0330223DEC
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985699; cv=none; b=DlWwwWaTgaaQdEEQ3xc4jS1UZFm+et+Y7vEMQ9aE8GoEYLIYCZGtIzyFtGDZWFI1L/Yy0PZZy3N3OTlQ/vgdIQPUdps7rKDZCupIYAsrlOTq+wrS/kp3FtpvHL9/DlxVy8Xw2WotzR7V48g/XHHKJhoajp+McQU/UwUcDCsfKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985699; c=relaxed/simple;
	bh=vC0xUDjLRT2vqdPkZ5xkJ1toTZ5yuHw/5cOKLIrJOh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwmf84eZTyGIgYA/exxhYkPeJWy2XtIWeMSD0kqt8tjw6sPJPBfqu/rOIq5dwhaEyDyq8NMv6d2Geyy35V7f3PMDiFOSyh4g651hs7sXZoFR1Dsh+pSdUrflph4TI+QJzy99/X/3/t9fYeSuwMU6KpTtktssZnlzGnpxXpFDlM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cO3uP3NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A1C4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985699;
	bh=vC0xUDjLRT2vqdPkZ5xkJ1toTZ5yuHw/5cOKLIrJOh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cO3uP3NMOLG2yGMkpyshM7i8kVGzxLFCb0vqlpaX/Vw6iyr0CPtLOKxMYo/6ccja9
	 I6J6BBuIfw9W27LRDMUAdAzIj3IPRLc/q6Zby/53NTbjNhm6Ndmg4SkuFxAOddCGVk
	 OgpPTjw1cwIz8hCFdmjaeeypNTRBxJN4BUEeNJHfFmjKY19GgK3E4JlU6+8ZJI+ZuO
	 EIMp8YOJ7aXh4AHS3cP8QzfAYY3kU7ffM1++bZdGKvq079YAYo+3Epu+k13zRcq3uD
	 I1Yqzb3feZ4VkRMj+xUEhnkqoNHXG0ywu21Xj6erWFHv9WZEPp6bg0Jw4IQ7jOjAid
	 ZaRh+PGzeH5gA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad88105874aso965968466b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Jun 2025 14:21:39 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzris0Q0/8I/2pgHBBR/llNRws0YuYrUvS+wakePXZvsZ56Ce9j
	OA4l2ZlPW3Wnm2scNQfguzs1H2TaZuYFA32uFxjMvx1rkEipWjoivhZHkdlXa+Uu2izao77AXaZ
	LLp7kJnpoPZbCgMjl778bFiNOR4zadPE=
X-Google-Smtp-Source: AGHT+IG2YelufFC2la76M5/vAh8lcWAESZyP643NP+RJpXhwpBk/e1e69Xxwg5/EDQ9NX5aKyVWEafORmO+VO7kU2CU=
X-Received: by 2002:a17:906:4fca:b0:ad8:8364:d4ab with SMTP id
 a640c23a62f3a-addf8fe0b18mr10472766b.49.1748985697762; Tue, 03 Jun 2025
 14:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
 <20250603203727.GN4037@twin.jikos.cz>
In-Reply-To: <20250603203727.GN4037@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Jun 2025 22:21:00 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7rMzs_RgYxpfdEDeSmEMB45hMvmOP56Xx82gM61-O16Q@mail.gmail.com>
X-Gm-Features: AX0GCFtULXnveJR_uxwAAOamXXdXUuWYzU8SGzi358nvlXANN92zHnFAENHpQsI
Message-ID: <CAL3q7H7rMzs_RgYxpfdEDeSmEMB45hMvmOP56Xx82gM61-O16Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix invalid inode pointer dereferences during log replay
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 9:37=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Tue, Jun 03, 2025 at 07:55:06PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > In a few places where we call read_one_inode(), if we get a NULL pointe=
r
> > we end up jumping into an error path, or fallthrough in case of
> > __add_inode_ref(), where we then do something like this:
> >
> >    iput(&inode->vfs_inode);
> >
> > which results in an invalid inode pointer that triggers an invalid memo=
ry
> > access, resulting in a crash.
> >
> > Fix this by making sure we don't do such dereferences.
> >
> > Fixes: b4c50cbb01a1 ("btrfs: return a btrfs_inode from read_one_inode()=
")
> > CC: stable@vger.kernel.org # 6.15+
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 34ed9b2b1b83..1e0042787be7 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -673,10 +673,8 @@ static noinline int replay_one_extent(struct btrfs=
_trans_handle *trans,
> >       }
> >
> I think it would make the code flow a bit better with
>
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -668,8 +668,7 @@ static noinline int replay_one_extent(struct btrfs_tr=
ans_handle *trans,
>                 extent_end =3D ALIGN(start + size,
>                                    fs_info->sectorsize);
>         } else {
> -               ret =3D 0;
> -               goto out;
> +               return 0;

This else statement is actually "impossible", for an unknown extent
type, meaning some sort of corruption, shouldn't return 0 but a
-EUCLEAN and an error message.

I'll add that separately, but first avoid the null dereference anyway.

Thanks.



>         }
>
>         inode =3D read_one_inode(root, key->objectid);
> ---
>
> as there's only the iput() at the label out: and at this point inode is
> still initial NULL so it's a no op.
>
> >       inode =3D read_one_inode(root, key->objectid);
> > -     if (!inode) {
> > -             ret =3D -EIO;
> > -             goto out;
> > -     }
> > +     if (!inode)
> > +             return -EIO;
> >
> >       /*
> >        * first check to see if we already have this extent in the

