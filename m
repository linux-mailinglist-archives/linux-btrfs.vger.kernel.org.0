Return-Path: <linux-btrfs+bounces-19500-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E47CA1CD0
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 23:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A2D302A390
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D522FFFA9;
	Wed,  3 Dec 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jll0hNxH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFA2E889C
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800193; cv=none; b=oHvOVkvbMb8qVziB/5zGIZJa6QthCl9SAfVltpSN57PV7fU41gCxqYaNuv7sV3di2B3A9C+fN/sgqgkWhR/hVjp7hBaliCmlDGtclUkISWQNEKIKZj/mGUbwgosIrfEi5rBPlNoOkpc4G6x8afkxqDWrCwOqEnVQhWFpDZVSUw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800193; c=relaxed/simple;
	bh=UgOFwOD8B7f+42/sCO81Ys1pZRS+x+Z/gS59qZZc2Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgv+MT/DxhpkYeqHiBQsuzTEuDIQyKMtMkVy5XFBqHJoid+BKeJksdZgzMIx6IBgpUIpzjrlffTq0R7J+SeAiuywUBMfadq3ifOwfh/J0PIFEG3UmvpdxoiwsWDtTrEb8mp5d4FDCzOy7nlWDvU/5PwfA79TCE9MD5z8KzB20gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jll0hNxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432FEC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764800193;
	bh=UgOFwOD8B7f+42/sCO81Ys1pZRS+x+Z/gS59qZZc2Q4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jll0hNxHu1ifWTqkwUAKtobPEuWu0gDWPHy6FgeceiEqaYvtQywxxSgEZry0YWVc9
	 rlHgxTntXFm04FaR6Fowl6UTs4pkCrG9ugVOf/GcP3E9VLg9eIvqYXDBXHPdfbmMBA
	 XuzR8v4aixvNdKAvLHAvoezupZHFu0zUIVV3ci+8WlMTzC/VgjzE7vYLpa8JKib50U
	 eI3xV4IC09yavaX9l13Bz8DdMKid3CMpS4aQwPpvS+aM9D6Onz+zYvRlKE0QTkGPD/
	 +P5E40/on8Y+GdvqP5aK0yLOvMSB5yz5qAhLE8/2MUti97AMQgOhnm5Njs3wOHLClX
	 HL8ElIx+U8lFQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b77030ffad9so38198166b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 14:16:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxJlfaoxHxJEJ1M/6JTackSxj+xFEglzqTzWzyXeyfUYHHNaddR
	WpDOJQr1A/k9cCrdh0qkkhPfa64Ev/T9yun2LIn/8GmigWKszY4z9WDG0Dx7FFadDH7CcWJ64FH
	97LqOKFNO+AwI8d/Lh7ZNuXBxGHfdPP8=
X-Google-Smtp-Source: AGHT+IF7cbaqBeeq6sUg8EJpVWWvHk0Kv1ItTv2JVEFMnSnhUsh2XjgzynUMB96IDIYEAThsr3UNs0iGfmb2peL+9/k=
X-Received: by 2002:a17:907:7e9a:b0:b75:8b9f:de3a with SMTP id
 a640c23a62f3a-b79dc7823a7mr350913166b.59.1764800191849; Wed, 03 Dec 2025
 14:16:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
 <20251203211758.GA3589713@zen.localdomain>
In-Reply-To: <20251203211758.GA3589713@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Dec 2025 22:15:54 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7JVeAyOvcrs1D3CL56MMSf+0QVnYs91euABukgCKgBPQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl0tCbaycHcW9eoHoyEb1PKvwAuCoVmPQLOz6dQwCM42PXrDX-6RdhD5Iw
Message-ID: <CAL3q7H7JVeAyOvcrs1D3CL56MMSf+0QVnYs91euABukgCKgBPQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: do not skip logging new dentries when logging a
 new name
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 9:17=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Dec 03, 2025 at 05:38:05PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When we are logging a directory and the log context indicates that we
> > are logging a new name for some other file (that is or was inside that
> > directory), we skip logging the inodes for new dentries in the director=
y.
> >
> > This is ok most of the time, but if after the rename or link operation
> > that triggered the logging of that directory, we have an explicit fsync
> > of that directory without the directory inode being evicted and reloade=
d,
> > we end up never logging the inodes for the new dentries that we found
> > during the new name logging, as the next directory fsync will only proc=
ess
> > dentries that were added after the last time we logged the directory (w=
e
> > are doing an incremental directory logging).
> >
> > So make sure we always log new dentries for a directory even if we are
> > in a context of logging a new name.
> >
> > A test case for fstests will follow soon.
> >
>
> At first I was confused why it wasn't more clear that it was a revert of
> the original patch, but that one was from 2021 so I think that this more
> "natural" undo makes more sense.

It's an old commit yes and a simple revert would actually not be
possible because the function was moved around a few years later. But
it was actually a correct change for a while, it became incorrect
shortly after due to support for incremental directory logging.

I've updated the changelog with those details in v2.

>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/84c4e713-85d6-42b9-8dcf-0722e=
d26cb05@gmail.com/
> > Fixes: c48792c6ee7a ("btrfs: do not log new dentries when logging that =
a new name exists")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 8 --------
> >  1 file changed, 8 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 64c1155160a2..31edc93a383e 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -5865,14 +5865,6 @@ static int log_new_dir_dentries(struct btrfs_tra=
ns_handle *trans,
> >       struct btrfs_inode *curr_inode =3D start_inode;
> >       int ret =3D 0;
> >
> > -     /*
> > -      * If we are logging a new name, as part of a link or rename oper=
ation,
> > -      * don't bother logging new dentries, as we just want to log the =
names
> > -      * of an inode and that any new parents exist.
> > -      */
> > -     if (ctx->logging_new_name)
> > -             return 0;
> > -
> >       path =3D btrfs_alloc_path();
> >       if (!path)
> >               return -ENOMEM;
> > --
> > 2.47.2
> >

