Return-Path: <linux-btrfs+bounces-13555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA9AA505B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367AD17BAF9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB52620C9;
	Wed, 30 Apr 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXn2fO7N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD325A358
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027228; cv=none; b=Gc2D+ywPuZND77TpeUHsOrOUPqP9v7qL1JgPovymsxMMFiTRVjBdfvs5gTVfRFcJzFvd586kX9hVw6dvCaNTse9FwvEAgMIULOPo4tZHlDjlUoYrzSrTJU2oDc04Ud5+czJ+O2TL1NDsr1bsg8JrX2vxDoksUF1x7HiW2rHqVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027228; c=relaxed/simple;
	bh=3R877EkCbk7wtviMrH3OElpOIDoHr3+VU4FcWYUPvgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQ/TLSZFzJjY1ySiEIFKWUYUDf3UcAivxffhK+/ITzEo3NzZCbN4Waty88GP1XMI2RI1gazmsLG7MfMbpKuG/Kt1stwhXXwIaNTHZvtjpztvH4T8Cd0iFBbW5LJEGJ2d6yQxGhJB9p+LhVumYX1ssNqcmkeJH6V97BeDVQbY/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXn2fO7N; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523d8c024dfso2943806e0c.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746027225; x=1746632025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlSaLF1OI7UeQ3nZAhGPRyKNsP0Ro5ANzHWgthYp9s0=;
        b=AXn2fO7NnzO6zZa9+wug/m9UDbNJDHoNMWUlrcLP4SnufVmmAcsNeFp+mSc5j3wUG8
         ER6vr/+TiWX3kRy+7+9W/ieJu+OW8GOCbdZt6qoOMtJrG0N3MScL55fAGGLsEQzb15lm
         jvjAlj+ZG60qmSNaijifOiI4wjg4WomhOrUX2JYXOOq+YjK84PDAPSplbptaxB0W5AyX
         o4QoEcVUgZiAmXIitOhHbVbrh7JZTDVDRQDVFTHqQ7wBBWwKIjfWitjNto8/Wy5nWgw/
         +kHUEkxxkl+S5+vKx6+RlPI8fGrXPCOez0dlmSNlKGFfNU8m5e8OeTZvRGAMuqBLMYQC
         cV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746027225; x=1746632025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlSaLF1OI7UeQ3nZAhGPRyKNsP0Ro5ANzHWgthYp9s0=;
        b=t6SGaTaZOhFLMc0gMBELOZHz3GcjtibBzsE9b44ub59yK61yJoYu9KuR4kLEezyYme
         qM1J8+BSZ5Jb/vyi3985U193Z5+j0OO/PIguJ5QsteiK2dWVpTm+HiR/Ylrd5oVwSEPE
         5aV2Gev8ia7TUFF9mvmnKHaBFd4NLOTAsZ9kMK6QvGYMWEnyKxBDXNf/jFmVZ0wxXC7a
         WxmtEceIN5kUDRWnz3zwQJCFBx/9Ldy1hxwUlRvfj1V8XQzZN6OxHzfVgt6iPGhsl1ol
         wekJQZHHM8QWVY5XlsPZLjN8wOr7qs9edW2P2lKBNdv3EzldobCAPrEfQhtPQhxzdlVG
         WC0g==
X-Forwarded-Encrypted: i=1; AJvYcCVaOuxeozTwbVWJdzTA7mGOvnW7PFjMB+v1YHhSgZ9lcTJHAILSuDqQ2pLAEhtSkUW0LYu/rTBIW7J9WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAc4nA/n0EH7jF3qFbYvG7SeMxTf3xSzSjdcGROKW8Sg49qLO
	sZ/1ddymY5t4yxcjcCOmJcCFug4IPHiKcHVIjHG13f539d9OaTlE1gDL6+VY/MmjJVYF9/Q7XIY
	ieu6AB5mvNVL31s/+5O1s9UI6MuE=
X-Gm-Gg: ASbGncvs9jfIkvHSgYyflvpWb5IHsgj8FwS/QMaNt+UWiNKybuQy5UpLacR7mzhx/DE
	xpYHnpDaPNbUJ/pkhWNr37rBeNZsgk87DeJJwluYubychErVIst72Ws7elr2Mo+5d5GMHBidb+P
	CM0v2sdBCAmpu90lI9x30LrwVh
X-Google-Smtp-Source: AGHT+IFGVUnbX8Va5J+LwjGB59rcQUWzsD0B8lzYljC4zlTOxNzY8Py5620B/6YTxHEy3feHDXR1agFFGDOcI/1JHRk=
X-Received: by 2002:a05:6122:c87:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-52acec8a612mr2492024e0c.9.1746027225481; Wed, 30 Apr 2025
 08:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428044626.2371987-1-sawara04.o@gmail.com>
 <a95364ca-7903-4cbf-9f75-417fc0d26bbc@gmx.com> <20250428151259.GE7139@twin.jikos.cz>
 <CAKNDObASvhXH3F4jRBHQ2EA6CN+-L-qgg92D2GKAorMu2g9Aig@mail.gmail.com> <d479b722-f3c9-4882-9aa0-eb7f7f7272df@gmx.com>
In-Reply-To: <d479b722-f3c9-4882-9aa0-eb7f7f7272df@gmx.com>
From: =?UTF-8?B?5bCP56yg5Y6fIOWFseW/lw==?= <sawara04.o@gmail.com>
Date: Thu, 1 May 2025 00:33:32 +0900
X-Gm-Features: ATxdqUH9Lh49AY2cpfxUeKAlhQUnVjuGF-J2wmIzAA_eSlWfKXYZp0mwKGeRsqE
Message-ID: <CAKNDObBnpNsyXr4bJeCOQX+d0qrpKMt-LqpE=PMRpyzn=-vtbg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Implement warning for commit values exceeding 300
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sure, that sounds good to me.

Thank you.

I would like to confirm whether the warning message
"excessive commit interval %u, use with care" is acceptable.
Please let me know if you have any concerns or suggestions
for improvement.

2025=E5=B9=B44=E6=9C=8829=E6=97=A5(=E7=81=AB) 7:19 Qu Wenruo <quwenruo.btrf=
s@gmx.com>:
>
>
>
> =E5=9C=A8 2025/4/29 07:45, =E5=B0=8F=E7=AC=A0=E5=8E=9F =E5=85=B1=E5=BF=97=
 =E5=86=99=E9=81=93:
> > Thank you very much for your review and the helpful feedback.
> >
> > I will revise the patch according to your suggestions, replacing the
> > warning message with something less alarming such as "Use with care."
> >
> > Additionally, would it be okay if I also update the "nobarrier" message
> > to make it more informative?
>
> Sure, that sounds good to me.
>
> Thanks,
> Qu
>
> >
> > 2025=E5=B9=B44=E6=9C=8829=E6=97=A5(=E7=81=AB) 0:13 David Sterba <dsterb=
a@suse.cz
> > <mailto:dsterba@suse.cz>>:
> >
> >     On Mon, Apr 28, 2025 at 03:06:14PM +0930, Qu Wenruo wrote:
> >      > =E5=9C=A8 2025/4/28 14:16, sawara04.o@gmail.com
> >     <mailto:sawara04.o@gmail.com> =E5=86=99=E9=81=93:
> >      > > From: Kyoji Ogasawara <sawara04.o@gmail.com
> >     <mailto:sawara04.o@gmail.com>>
> >      > >
> >      > > The Btrfs documentation states that if the commit value is
> >     greater than 300
> >      > > a warning should be issued. This commit implements that
> >     functionality.
> >      > > For more details, visit:
> >      > > https://btrfs.readthedocs.io/en/latest/
> >     Administration.html#btrfs-specific-mount-options <https://
> >     btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-
> >     mount-options>
> >      > >
> >      > > Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com
> >     <mailto:sawara04.o@gmail.com>>
> >      > > ---
> >      > >   fs/btrfs/fs.h    | 1 +
> >      > >   fs/btrfs/super.c | 6 ++++++
> >      > >   2 files changed, 7 insertions(+)
> >      > >
> >      > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> >      > > index b572d6b9730b..f46fba127caa 100644
> >      > > --- a/fs/btrfs/fs.h
> >      > > +++ b/fs/btrfs/fs.h
> >      > > @@ -285,6 +285,7 @@ enum {
> >      > >   #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR         0ULL
> >      > >
> >      > >   #define BTRFS_DEFAULT_COMMIT_INTERVAL     (30)
> >      > > +#define BTRFS_WARNING_COMMIT_INTERVAL      (300)
> >      > >   #define BTRFS_DEFAULT_MAX_INLINE  (2048)
> >      > >
> >      > >   struct btrfs_dev_replace {
> >      > > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >      > > index dc4fee519ca6..c6911e9f17f2 100644
> >      > > --- a/fs/btrfs/super.c
> >      > > +++ b/fs/btrfs/super.c
> >      > > @@ -569,6 +569,12 @@ static int btrfs_parse_param(struct
> >     fs_context *fc, struct fs_parameter *param)
> >      > >             break;
> >      > >     case Opt_commit_interval:
> >      > >             ctx->commit_interval =3D result.uint_32;
> >      > > +           if (ctx->commit_interval >
> >     BTRFS_WARNING_COMMIT_INTERVAL) {
> >      > > +                   btrfs_warn(NULL,
> >      > > +"commit=3D%u is considerably high (> %u). Large amount of dat=
a
> >     can be lost when the system crashes.",
> >      >
> >      > I'd say the large commit value is not really going to cause a lo=
t of
> >      > data on crash.
> >      > It's really depending on the workload, e.g. if there no fs
> >     activity at
> >      > all for over 300s, there will be no data loss at all.
> >      >
> >      > Furthermore, we do not really to scare users to use a super low
> >     value,
> >      > which will cause tons of unnecessary transactions and fragments =
the
> >      > filesystem with too many small extents (if data cow is enabled).
> >      >
> >      > Another thing is, we do not even warn about more dangerous mount
> >      > options, like nobarrier, thus I'm not sure if we really want suc=
h
> >     a warning.
> >      >
> >      >
> >      > At least I'd prefer a less scary warning, maybe just "Use with c=
are"?
> >
> >     We used to have the warning there before the 6.8 mount option parse=
r
> >     rewrite and it got removed in 6941823cc87812 ("btrfs: remove old mo=
unt
> >     API code") without being properly implemented in the new API.
> >
> >     The wording of the message was not alarming or scarying,
> >     "excessive commit interval %u". The consequences of the large inter=
val
> >     could be data loss but this may not be suitable for the error messa=
ge as
> >     this is a corner case. I agree that 'use with care' (and read
> >     documentation) would be reasonable.
> >
> >     Regarding nobarrier, there's a message "turning off barriers" print=
ed in
> >     btrfs_emit_options(), we can possibly enhance that too.
> >
>

