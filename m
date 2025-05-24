Return-Path: <linux-btrfs+bounces-14209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B2AC2D1C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B80F4E6904
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D46183CB0;
	Sat, 24 May 2025 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cghFfOfS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B92F32
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748053309; cv=none; b=JIyiFIZn+T0vGN1uTdx412m1Ng1Dn1HCjDnRmDU6ynu3K2MVdjt5udEyjMktM5RZ8jZxEPrnxYXwmbWKljsWWOphSt1sJofNPFNWrw87BJfNrIhGQpHFDmPrz7qt0ue6B9KSux/QTtWoFwRwgxrIZNSQR1yxjtvh5WhUG7s2mG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748053309; c=relaxed/simple;
	bh=mKx6h4CykIdLUEBuXwYP5s1kOWZc9QOuBVOuU58Ym/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpR12YYt7qsGuCQ2I5wzqX6W+Mcs205qmjAOz//6Au5x+Kn4buLuG349qw/5bF9fjVCV3qIzpsrapf0OpjOGWQIZbs7ij8NbGydzQjYItSq/IxAE5+JJjTSDWjsL29RqkuSP9VW+WuGYPH2/57Ek5mM+fD04tH7yZ/QMi0lbBXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cghFfOfS; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87dd98f2038so148447241.0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748053307; x=1748658107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnmcpY0fF0zNyGlgkZtxCWfYYx70z4/MhcmzSQqUKgA=;
        b=cghFfOfS0KIopVfweGgnvbzSAX+XGCJ2I+6bEDVdcrj3rHvZyLIxQVZZesq7OQ/2vI
         Hl4/5oUlhUUWaYyqK/SZyx5a4aHgPzEDNmrL9jRKXTjZ5cj5YzTIA/7Fu6PaRiQySSry
         rYvqAxLd2zYKssm47OUqo4wSdibrWW7bDkPyCnRJrhWRTNRP5nEfUpBz6YpoqqJDPC/r
         jR4PFD7c6O2KR7Q6vhjARX+AAys+7skNC8Vn2Xxv/+Jx+GXAaX9T+ZxmHu95dHRlUOSJ
         m6mrAOjIJflDPQHpt5b8hx35a6HdJ9u0cN6O//AVuxtu5MbDHxdqGCbXEuFiFb3Vk+02
         +37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748053307; x=1748658107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnmcpY0fF0zNyGlgkZtxCWfYYx70z4/MhcmzSQqUKgA=;
        b=pWVZP945NGq7hW3RZ9Sf9i2qlqWShXW8kaRG7fztclWkSdo2NpwnI2uFWXDfre6zn1
         Q8xHelSLUEUEvcIiXXuPNJ1RYtTUR0XQdjfU/01Jfl8fI/x6qcKJybUh7Py152icuFse
         nd/kKPCfdlabQrNYRjQqLFjpbtusKie0eMwDOdO3mRpb3dEOEqSlT0CdAhiPcWhSo3AT
         nrD2eLjIanwielhFUfcFJ7WLqQNNN0oRR/QDe3qkbLkwSDr/HQlkZAKUVKbZUVklW+IC
         bq2KJVlsaVTqIduagnqm8OBhzOzdzIxV3rrJ2RtZbPjbb+6utRvExjJH9kQz8yJcFv/q
         ugiw==
X-Forwarded-Encrypted: i=1; AJvYcCXwLDUNHZn8wFLLn3JL2d0WcK6jQyFa2aK2HmRyhMoXY76/0eUeWhYA7zi+TTzu8ct6gob4bEk1rWLQwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGTGNx8mL5OqhIOMk7jZ7npPACxAUSkNUcJsgeJeWhc/avpWz
	J/b83V4OhpeftkPWgVnMzo2oW5iYIOWJsGAbkIKrqcZSjzEnIM9t7vhAvpG/ZVpX1qb2QuCovFv
	mqyLkwM6Rvyl9oAV5G8ZChMrl7tVTZyY=
X-Gm-Gg: ASbGncvgr9fei716a51pBi+xHu0fWOH+4Km9gziH8CCUdKk4hhFXKTY5TrZNk+lJQLD
	4pYJ1aAsbXbibwkTl28Q3G50RKs1qIERoqR0jZyKOV96tUk8keGvZl8nEPHseW5RrqViSHn4K4/
	timjY2dzEvXcRIaNGpU5oOO7Ul6A1gfVvq
X-Google-Smtp-Source: AGHT+IFwZpgN993vz7PwnxtANaEqO87ZSSWQsQruXbLj487zwx+Bs423wqqU8xU2NUtiU5RlOP+Km64bpzcsqQy4S18=
X-Received: by 2002:a05:6122:82a6:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-52f2c58ca11mr1633573e0c.9.1748053306953; Fri, 23 May 2025
 19:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
In-Reply-To: <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Sat, 24 May 2025 11:21:36 +0900
X-Gm-Features: AX0GCFu3c0skPj9UfqG-2e9nwH3mEkNCJr3rop6cN4Ugvz7565rzX-lGj-8y840
Message-ID: <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the explanation. I understand the issue with btrfs_parse_param()
being triggered multiple times.

If I move the log into btrfs_parse_param(), it would currently use
btrfs_info_if_set(),
resulting in an info level log.

Is an info level acceptable for this warning, or would you prefer a
warn level log?

If so, should I create a new helper function like btrfs_warn_if_set()?

2025=E5=B9=B45=E6=9C=8821=E6=97=A5(=E6=B0=B4) 13:13 Qu Wenruo <quwenruo.btr=
fs@gmx.com>:
>
>
>
> =E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> > From: Kyoji Ogasawara <sawara04.o@gmail.com>
> >
> > The nobarrier option disables barriers, improving performance at the co=
st
> > of potential data loss during crashes or power failures especially on d=
evices
> > without reliable write-back caching.
> > To better reflect this risk, the log level has been raised to warn.
> >
> > Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> > ---
> >   fs/btrfs/super.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 7310e2fa8526..012b63a07ab1 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_context *f=
c, struct fs_parameter *param)
> >               }
> >               break;
> >       case Opt_barrier:
> > -             if (result.negated)
> > +             if (result.negated) {
> >                       btrfs_set_opt(ctx->mount_opt, NOBARRIER);
> > -             else
> > +                     btrfs_warn(NULL, "turning off barriers, use with =
care");
> > +             } else {
> >                       btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
> > +             }
> >               break;
> >       case Opt_thread_pool:
> >               if (result.uint_32 =3D=3D 0) {
> > @@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_fs_in=
fo *info,
> >       btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> >       btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
> >       btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd alloca=
tion scheme");
> > -     btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
>
> I know you want to avoid duplicated messages about the nobarrier.
>
> But it is better to use btrfs_emit_options() to add the warning.
>
> The problem of showing the error in btrfs_parse_param() is, it can be
> triggered multiple times.
>
> E.g. mount -o nobarrier,nobarrier,nobarrier $dev $mnt
>
> Then there will be 3 lines of "turning of barrier, use with care".
> But inside btrfs_emit_options() it will be only once.
>
> In fact this also affect the warning for excessive commit mount option,
> but there is no better solution for that option, but we can do better her=
e.
>
> Thanks,
> Qu

