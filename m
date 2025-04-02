Return-Path: <linux-btrfs+bounces-12752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 357D4A79137
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506B83A7A93
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1C923A9A0;
	Wed,  2 Apr 2025 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L+P3yVcU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70513234
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743604276; cv=none; b=J80fbdrVKrhdFHsmWnfaEMJDW/IGxQMp8aRuh08aPIMl6GWYn10pEKSfse9R3a09vZxLho0GqsHtYhSKWjdcqNYuWU9jQhTxxZi1y+bfjJ9X2qKcL/5PSgI3wlag+cYjGzvrZqk2ox6T2ngnog4xE8tz55GaCGyMJqrN5mGAFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743604276; c=relaxed/simple;
	bh=YpYJRk1fqwew8uO6OLpw+y5a+3bMGS6IUxUD4ARDgMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUmeUtSEWB/mBxHOYwx0Sv1nCIO+QL4y13Yf9D6SXh23sD8G/2PHCUE8bwbBuempncJrcjmFTETOUFVO511G068aMQSj4cMvntLah8w96Q3ETKNKCSHXnmDbvNAf90asbQf/VaU9oCcoWx0nmB2PI0RrFQNDHo9QrO3L+vU+xKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L+P3yVcU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab78e6edb99so975156866b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Apr 2025 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743604273; x=1744209073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZXeR3AOyrqMIL/S02Uc1Qq3QuVgipSFuMWKMSod7OE=;
        b=L+P3yVcU7dyeLJdXcooeAPTlPK0X0AWQ1AJ73KzbMP42iOPIer/LR3J/vo8TCFvJxK
         QGHZ1bhXTkHXAPgcsSJHUMxJ75HG7aDkRT4UjkIIZ8B9MnEr/aad/P58dx9eqSeP0FgK
         5bpTvYnkGuNhsFkghBZGWIOWqnk1QvRMEyq3lWrFHTF/jY5AVUjNaII2IFJJNX6Oltyu
         bV7B/+vLQQtQA0nDRh1XsqNTBr4ZhgIRpiNNxt9pzTMY6Y4E8da6i7O7+gq5UhO1vOaW
         APtJ2mwty7Lvm7Z8D5JzbnVWxCE/q03AegjtmB70s3dGf9o6arnbm2zJyA3mWmEW3aLT
         kvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743604273; x=1744209073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZXeR3AOyrqMIL/S02Uc1Qq3QuVgipSFuMWKMSod7OE=;
        b=KOHipE4TWoGJJ6YqRv9aVMKsMx9m9qyw8ElsWpP8AX6jawnOOEr1thuH6avlX6FBZi
         Gf/Basmwv6HMTi7Q9lYE+Ojn7Kk6gYjrzLcphXWwFTxYOLRApMfuwAn522XYhGJZ/M8G
         ikk2WC9cVm+XLRr7x5IGaKeKXXBakPo3f35Tf3fc7yN2+t3AxM7+OYyzHopxaONNhxAe
         huwUfBxX4EKA1bb9SLeomWZCHINseVCGNH0cGDF1LPSGjwowvKbjfsfFHiLfbibL8sKW
         +lzkW1AmkUSOuhB3bXmsLA4YhJnEwwOeB2PIQMxhmQK6VZXxzzGeUUBxoYTXXPeUgrbI
         RGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhkEItLxXXi7GbTJ+vs+vHkCkCZJLEjve2n5V+Rh3Y8YE/OQarAZYB3GnUCRq3AzBXmXLA+7ETnlN6bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqiT1aFIxexAn4wg+nvyeNEJ4pPXWb1bhkS8Emm64s2NWtIRoM
	KLQ2WE4zmiwEAUp+vpEUdGKPNAjZluWOfiqu6H3vJVeMDeNpRiVMk0+wapsPMFgZHQ7EbnLXmEv
	tXicrBlfsZoMUOklE3qd0OWTbic4vphpepE4x4g==
X-Gm-Gg: ASbGncsF+s2I/ZIfmoUy1F3VGsgTG28lSpsP9/rVM/W4CTcydbjcnI2kL60VgvQdqJv
	NaVmM0oyzNBfRtZwMsLa0Ks3E5Nw5JDI+JzpvTdz8HQRjuCzGjzNmMsXUK4EvtzU1CQ8QX2SEse
	vJC1VewDL7vVprgiOLOX/FmUQQhzRMMI8g/fc=
X-Google-Smtp-Source: AGHT+IGQQr6tSI/y6KGq/mkyeb3dIgsskInkIrWoOxeRv/LNuwn85mZmYAfm1T0V3zZqekUev9RiElshHrZ88+BpJ8w=
X-Received: by 2002:a17:907:9625:b0:ac2:a5c7:7fc9 with SMTP id
 a640c23a62f3a-ac738c13711mr1500877066b.51.1743604272919; Wed, 02 Apr 2025
 07:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082347.1407151-1-neelx@suse.com> <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com> <20250331225705.GN32661@twin.jikos.cz>
In-Reply-To: <20250331225705.GN32661@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 2 Apr 2025 16:31:01 +0200
X-Gm-Features: AQ5f1JreI7_MwIaFFCGj7DmjbzaZf2psYvmmr8gsj6fcp71_gIbVniN6_ARIJgs
Message-ID: <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 at 00:57, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Apr 01, 2025 at 07:44:01AM +1030, Qu Wenruo wrote:
> >
> >
> > =E5=9C=A8 2025/3/31 20:36, Daniel Vacek =E5=86=99=E9=81=93:
> > [...]
> > >>>                        btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > >>> +             } else if (strncmp(param->string, "zstd-fast", 9) =3D=
=3D 0) {
> > >>> +                     ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
> > >>> +                     ctx->compress_level =3D
> > >>> +                             -btrfs_compress_str2level(BTRFS_COMPR=
ESS_ZSTD,
> > >>> +                                                       param->stri=
ng + 9
> > >>
> > >> Can we just use some temporary variable to save the return value of
> > >> btrfs_compress_str2level()?
> > >
> > > I don't see any added value. Isn't `ctx->compress_level` temporary
> > > enough at this point? Note that the FS is not mounted yet so there's
> > > no other consumer of `ctx`.
> > >
> > > Or did you mean just for readability?
> >
> > Doing all the same checks and flipping the sign of ctx->compress_level
> > is already cursed to me.
> >
> > Isn't something like this easier to understand?
> >
> >       level =3D btrfs_compress_str2level();
> >       if (level > 0)
> >               ctx->compress_level =3D -level;
> >       else
> >               ctx->compress_level =3D level;
> >
> > >
> > >> );
> > >>> +                     if (ctx->compress_level > 0)
> > >>> +                             ctx->compress_level =3D -ctx->compres=
s_level;
> > >>
> > >> This also means, if we pass something like "compress=3Dzstd-fast:-9"=
, it
> > >> will still set the level to the correct -9.
> > >>
> > >> Not some weird double negative, which is good.
> > >>
> > >> But I'm also wondering, should we even allow minus value for "zstd-f=
ast".
> > >
> > > It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` stil=
l
> > > works the same. Hence it defines that "fast level -3 <=3D=3D=3D> fast=
 level
> > > 3" (which is still level -3 in internal zstd representation).
> > > So if you mounted `compress=3Dzstd-fast:-9` it's understood you actua=
lly
> > > meant `compress=3Dzstd-fast:9` in the same way as if you did
> > > `compress=3Dzstd:-9`.
> > >
> > > I thought this was solid. Or would you rather bail out with -EINVAL?
> >
> > I prefer to bail out with -EINVAL, but it's only my personal choice.
>
> I tend to agree with you, the idea for the alias was based on feedback
> that upstream zstd calls the levels fast, not by the negative numbers.
> So I think we stick to the zstd: and zstd-fast: prefixes followed only
> by the positive numbers.

I'd still opt for keeping full range and functionality including
negative levels using the plain `zstd:N` option and having the other
just as an additional alias (for maybe being a bit nicer to some
humans, but not a big deal really and a matter of preference).
Checking the official documentation, it still mentions "negative
compression levels" being the fast option.

https://facebook.github.io/zstd/
https://facebook.github.io/zstd/zstd_manual.html

The deprecation part looks like just some gossip. It looks more about
the cli tool api and we are defining a kernel mount api - perfectly
unrelated.

> We can make this change before 6.15 final so it's not in any released
> kernel and we don't have to deal with compatibility.

