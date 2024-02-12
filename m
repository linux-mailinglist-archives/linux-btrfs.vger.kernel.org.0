Return-Path: <linux-btrfs+bounces-2328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A31851762
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD1E1F22BEC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 14:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479BB3B791;
	Mon, 12 Feb 2024 14:55:52 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAF3B297
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749751; cv=none; b=RFxQ2AWJx8A2CFKQTrJ3h3v1a7WpM6zK8+gi0pfswm4IeUpptkjgK81/yk39y1f8cM81MCUDGwNl28ISMTC+c0nscKAKwTWrBKuoCjF364hql2TK2rXTBuodIvx62djE+UqDRdnUGeqLVF7VCHpTvUk6LUIGTVkgmEWmIX0yDOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749751; c=relaxed/simple;
	bh=y3JbgKdngiF01Ecc8KGn0Xt/B7gpGxyAWzRBtyjeie0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk71dUeYGltuZnNygV8Z0bkzbe/0LyIpeC5kmmHvbpWNCnfrKX2ljEcEMl81KpnDgEh6h7xMeengAQ7zE4NeEfMemJkOuMNteu02Za0RvTGL1VxdBgXfN5LB5+us+ut+yxfF9TgeYRwAduHtyju1/TmSKp+BMnDrPRBcta7ZKAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2a17f3217aso425942966b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 06:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707749748; x=1708354548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnqWmLfr1abKiwARzeQVO7bk2g1husS9E0yyt8v8+98=;
        b=V/zwulRS+ETjJWwCmk6NltGpaWgvDU2mXBUi9HWNBwmFeYVwXhj99HJwvvaGLkcPLp
         n6W6Y1gGahEFL/kxA/yFhvlt8cKc+ecCeDXk8n7rimwR4CG1Xw6f2vRRIFQjsOMdSNH0
         VOW7RjxDrAaBo5d/XdkuBX72vwwKuuO5b+bZshhYWZQjoEHFjYMuQPN7f07zVUXw0U+1
         TRdf9K/hpl25aIejWTwxOogg3da70jzWcKITmLADlxSF1p565XNDlx0YmUEi8fiwnhFx
         zKB64aIrfEZaqVf+WD6dB+Zlt5IbRP7Kic+NaVm/jMrCt/KvahzbSTOG1QfswoIwu4iH
         YF2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTiyvwQe7uA8aBVPFz0T2dSfuKMuZwhFnLCWPySavzG7m4hJX9mIChccUtXK2Q5ZAlveMhpD0r8SrCb5FRvTkrzPBpGY897PYDqVM=
X-Gm-Message-State: AOJu0YxKm74k6VWSv7l6aqmTA6qkhYAgD7sEzifeaZKs+mxpr00Q/+7X
	b2xO57UR70p6fs2RYJlFqicpBsSNC/u2AKfx2O6rZsegSb8yMmmhpPnhk0rDrwQ=
X-Google-Smtp-Source: AGHT+IFWyIrw98efeBoUzXwgtBgGUwVj/ZfqPRgRGnCZxhGHijXxmQdrWgSH4S8LeP/pGHpH+yJM+g==
X-Received: by 2002:a17:906:2287:b0:a38:53df:4c5d with SMTP id p7-20020a170906228700b00a3853df4c5dmr4862294eja.34.1707749747559;
        Mon, 12 Feb 2024 06:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRlsm5iW/DpPG+p48MFkbBC1H25cvosd4B1hiOmWOAIbPkRA/0Wa8hLDMZCPcolOA/GMnkQmYVdwb5gTJmfG2S+BCvWrusc0xaAb0=
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id u15-20020a170906408f00b00a3bc368ca7esm287351ejj.53.2024.02.12.06.55.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:55:47 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso4561126a12.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 06:55:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX8SlThu7js0hN1FRzWnQo0yN0Jt7uVPrDYwFo+gESnc+9jVkWTIWOn7y1RpPmzglP4fqwjznWBxXauLhx4YfWAR7lLK+gzRAgnv4=
X-Received: by 2002:aa7:d8c7:0:b0:561:4460:6726 with SMTP id
 k7-20020aa7d8c7000000b0056144606726mr4621592eds.26.1707749747286; Mon, 12 Feb
 2024 06:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f679cbd1b09fff494b58f37520a9ab727c3ff313.1707716170.git.wqu@suse.com>
 <20240212120708.GB355@twin.jikos.cz>
In-Reply-To: <20240212120708.GB355@twin.jikos.cz>
From: Neal Gompa <neal@gompa.dev>
Date: Mon, 12 Feb 2024 09:55:10 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-XG5F1Tx=XqRQdL7MYGon_F96vRtZia_qyah=J20-jwA@mail.gmail.com>
Message-ID: <CAEg-Je-XG5F1Tx=XqRQdL7MYGon_F96vRtZia_qyah=J20-jwA@mail.gmail.com>
Subject: Re: [PATCH] btrfs-progs: mkfs: do not default to 4K sectorsize if the
 fs is zoned
To: dsterba@suse.cz
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:37=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Mon, Feb 12, 2024 at 04:06:30PM +1030, Qu Wenruo wrote:
> > With some help from a reporter using loongson (with 16K page size), and
> > a zoned device, it turns out that, zoned code is not compatible with
> > subpage's requirement.
> >
> > Mostly conflicts on the multiple re-entry into the same @locked_page
> > using extent_write_locked_range().
> >
> > The function is only utilized by compression for non-zoned btrfs, but
> > would be the default entry for all writes for zoned btrfs.
> >
> > So we can not default to 4K for subpage zoned combination.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  mkfs/main.c | 32 +++++++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/mkfs/main.c b/mkfs/main.c
> > index b50b78b5665a..f54c1a055ae2 100644
> > --- a/mkfs/main.c
> > +++ b/mkfs/main.c
> > @@ -1383,15 +1383,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >               printf("See %s for more information.\n\n", PACKAGE_URL);
> >       }
> >
> > -     if (!sectorsize)
> > -             sectorsize =3D (u32)SZ_4K;
> > -     if (btrfs_check_sectorsize(sectorsize))
> > -             goto error;
> > -
> > -     if (!nodesize)
> > -             nodesize =3D max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NO=
DE_SIZE);
> > -
> > -     stripesize =3D sectorsize;
> >       saved_optind =3D optind;
> >       device_count =3D argc - optind;
> >       if (device_count =3D=3D 0)
> > @@ -1470,6 +1461,29 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
> >               features.incompat_flags |=3D BTRFS_FEATURE_INCOMPAT_ZONED=
;
> >       }
> >
> > +     if (!sectorsize) {
> > +             /*
> > +              * Zoned btrfs utilize extent_write_locked_range(), which=
 can not
> > +              * handle multiple entries into the same locked page.
> > +              *
> > +              * For non-zoned btrfs, subpage workaround the problem by=
 requiring
> > +              * full page alignment for compression (the only path uti=
lizing
> > +              * that path).
> > +              * But since zoned btrfs always goes that path, kernel ca=
n not support
> > +              * writes into subpage zoned btrfs.
> > +              */
> > +             if (!opt_zoned)
> > +                     sectorsize =3D (u32)SZ_4K;
> > +             else
> > +                     sectorsize =3D (u32)getpagesize();
> > +     }
>
> 6.7 did the change to 4k instead of the auto detection of sectorsize,
> yet this adds the logic back. I'd rather not do that. We had
> compatibility issues with zoned when some of the profiles were not
> supported initially and collided with mkfs defaults, so I'd rather
> exit mkfs with a message what works with subpage and zoned.
>

This should also be an impetus for zoned to get subpage support
working, which throwing an error will hopefully do.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

