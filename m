Return-Path: <linux-btrfs+bounces-12980-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61727A87840
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73573AF5F6
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05301B4227;
	Mon, 14 Apr 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DsNgH2Vm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B1B0434
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613618; cv=none; b=FcyTT9OrikC8406R+6E4kwcn6hpVq3mNJv1bpdf0pWLW1vVZiCL8l3BMTAmFdP3bsB1/hjulIqGbWUlDQGHEr2K0/p92Pg2KnsPKzkVdrI3tsDcsRViHPdbmB+GYXsPbLk8675Cv71sf8QEtjjF9V4p6ySYaZdT7PIdEVkPsCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613618; c=relaxed/simple;
	bh=Agoq23bDUAXqo9AaPPRQFYVTVNaPa5Zc5OdDh/SbrY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mze5XaqxNyGxU8lpK/LF5broMpatJgA9cEBkvrPM5CRMjWbLeJ+CPcopl1pQdUmuprcnODGOOD2x/xvXLICu7fg5HUZfR8b68K2XroTAGBRny4JIwTAkHHL0/oy7pLvOnXHfUGpRtd/MnTHfY/7r1os45BRnM7rYV9CF2Klc8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DsNgH2Vm; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so716282366b.1
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Apr 2025 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744613613; x=1745218413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQbNREGYurDkVhqmrR2KiVmvUT/jocZ+TY4xPaBX+u4=;
        b=DsNgH2VmcqbrylbmwMb3S9C/JplqP6gTFpVD2w0rQpKjQ/lrkew+P4fSRm+ddCRKZ6
         ny71qUnb3C4podJaR9nr6eQyrpilHyyeMTuvVvLnk6Fan1mfXcmdHJxv6llZ4PUBQp0z
         gQarS9gTENjfZ4tKGn0QFYQ6bBRT3SzBOqvAi0CaSTdfWcPRSgqL5vesfwcZfvspYRa+
         Cx6TL18rBQUFqTVDJOSlhbnLYxufKzPd7HTjXC/B/RO14QQcJWkVuTabJzvM3oXVie1V
         vGWNG6Vt1zGqqAJcg5Z8Y0A2tMzBn6ujkpkW6ouD8TDqCcyJpK+qQsQaDw83sX0CjpjL
         ZdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744613613; x=1745218413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQbNREGYurDkVhqmrR2KiVmvUT/jocZ+TY4xPaBX+u4=;
        b=tvPV3x/d0UP/hbkQnLVM8QM8LOhA+8ZfqcFOoMDop6vvIm5+1xXPQfUeBUH2z7xpDZ
         g9RrnccXQr2CtWbDbVmb60hF9V3X5V9JWP91fEGSQrht6vJEyo2dsFmH6xjlSDROqTaW
         J4VjXyEM6BBDSf7Vba3FvGiQ0as0ozjZKyCaC/DQ74TwZTCLj6XkbcLOEM1gU5c66VIL
         ghenRN49ldm9quOHVC/R9MF9E730Q4JlrKiPZoDjuOdhdDazJdkfAvBWBVVKipguzM+/
         yiQ60FQdbNndXfzEjo554zhwZmaC6EKlyWmP83lojmk821g/m2wXS64pnut1pQB5H36E
         G9cA==
X-Forwarded-Encrypted: i=1; AJvYcCVPjOlWqEY4JAkReGU4bkRujxsa0hhjxlJlfgDHSUBBkIFe9q4EdyFe1v+9n5OJeiivRLKcTR2MWKItNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqgOu4riu5bAYXaVukQ24X1W45tFyUP9HJHZ7rFBXH+OXezF7E
	YnHtFstmtvfAyPPpm18gfOD5NRUHhaQt66st1eNHUGLXrw7zcvJV7voMXVc9lFDcFzivNU5rXz9
	rnBGIs9oHBr7JBByn3wg8m7MJjxcCpPkPOXn4iQ==
X-Gm-Gg: ASbGnct3/A+XIW/TBYYPiUowTiQxdfkhmX/W9TIyhIufosbY24W3od7XVU3/SP5iy2b
	fEyImE+Vp6un7Kt0NSjp6jReGDAvsVdlVBuLFWK7xj8p+4j/5RAUmargF8bKwcnCgTpqekxw+X0
	12PHIMD30BjP8U6NzlkdbGxgMbBYJSCAk=
X-Google-Smtp-Source: AGHT+IH4trRZYgVHR0ualPPj/jVwcxdOfEGnoWxbXqXWi2EIvLcKnEFRknYx4vOWQBhOcyoslaT+/L7G3bzJKKzGRY8=
X-Received: by 2002:a17:907:9810:b0:aca:b720:f158 with SMTP id
 a640c23a62f3a-acad348a128mr1012156166b.13.1744613612720; Sun, 13 Apr 2025
 23:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082347.1407151-1-neelx@suse.com> <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
 <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
 <b1437d32-8c85-4e5d-9c68-76938dcf6573@gmx.com> <20250331225705.GN32661@twin.jikos.cz>
 <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
In-Reply-To: <CAPjX3FfVgmmqbT2O0mg9YyMnNf3z7mN5ShnXiN1cL9P=4iUrTg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 14 Apr 2025 08:53:21 +0200
X-Gm-Features: ATxdqUHak9AiMMSwlhClElvAYjPSN7_Sx5iFmhNZVEvfe4TE6-tM8bxa8iRg7XI
Message-ID: <CAPjX3FfOJMFC8cXCqLa2yS1qSYmhu5cjV__+7xVRFGuKu=RqiA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Apr 2025 at 16:31, Daniel Vacek <neelx@suse.com> wrote:
>
> On Tue, 1 Apr 2025 at 00:57, David Sterba <dsterba@suse.cz> wrote:
> >
> > On Tue, Apr 01, 2025 at 07:44:01AM +1030, Qu Wenruo wrote:
> > >
> > >
> > > =E5=9C=A8 2025/3/31 20:36, Daniel Vacek =E5=86=99=E9=81=93:
> > > [...]
> > > >>>                        btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATACOW)=
;
> > > >>>                        btrfs_clear_opt(ctx->mount_opt, NODATASUM)=
;
> > > >>> +             } else if (strncmp(param->string, "zstd-fast", 9) =
=3D=3D 0) {
> > > >>> +                     ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
> > > >>> +                     ctx->compress_level =3D
> > > >>> +                             -btrfs_compress_str2level(BTRFS_COM=
PRESS_ZSTD,
> > > >>> +                                                       param->st=
ring + 9
> > > >>
> > > >> Can we just use some temporary variable to save the return value o=
f
> > > >> btrfs_compress_str2level()?
> > > >
> > > > I don't see any added value. Isn't `ctx->compress_level` temporary
> > > > enough at this point? Note that the FS is not mounted yet so there'=
s
> > > > no other consumer of `ctx`.
> > > >
> > > > Or did you mean just for readability?
> > >
> > > Doing all the same checks and flipping the sign of ctx->compress_leve=
l
> > > is already cursed to me.
> > >
> > > Isn't something like this easier to understand?
> > >
> > >       level =3D btrfs_compress_str2level();
> > >       if (level > 0)
> > >               ctx->compress_level =3D -level;
> > >       else
> > >               ctx->compress_level =3D level;
> > >
> > > >
> > > >> );
> > > >>> +                     if (ctx->compress_level > 0)
> > > >>> +                             ctx->compress_level =3D -ctx->compr=
ess_level;
> > > >>
> > > >> This also means, if we pass something like "compress=3Dzstd-fast:-=
9", it
> > > >> will still set the level to the correct -9.
> > > >>
> > > >> Not some weird double negative, which is good.
> > > >>
> > > >> But I'm also wondering, should we even allow minus value for "zstd=
-fast".
> > > >
> > > > It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` st=
ill
> > > > works the same. Hence it defines that "fast level -3 <=3D=3D=3D> fa=
st level
> > > > 3" (which is still level -3 in internal zstd representation).
> > > > So if you mounted `compress=3Dzstd-fast:-9` it's understood you act=
ually
> > > > meant `compress=3Dzstd-fast:9` in the same way as if you did
> > > > `compress=3Dzstd:-9`.
> > > >
> > > > I thought this was solid. Or would you rather bail out with -EINVAL=
?
> > >
> > > I prefer to bail out with -EINVAL, but it's only my personal choice.
> >
> > I tend to agree with you, the idea for the alias was based on feedback
> > that upstream zstd calls the levels fast, not by the negative numbers.
> > So I think we stick to the zstd: and zstd-fast: prefixes followed only
> > by the positive numbers.
>
> I'd still opt for keeping full range and functionality including
> negative levels using the plain `zstd:N` option and having the other
> just as an additional alias (for maybe being a bit nicer to some
> humans, but not a big deal really and a matter of preference).
> Checking the official documentation, it still mentions "negative
> compression levels" being the fast option.
>
> https://facebook.github.io/zstd/
> https://facebook.github.io/zstd/zstd_manual.html
>
> The deprecation part looks like just some gossip. It looks more about
> the cli tool api and we are defining a kernel mount api - perfectly
> unrelated.

Any feedback, Dave? I tend to drop this ida of `zstd-fast` alias.

> > We can make this change before 6.15 final so it's not in any released
> > kernel and we don't have to deal with compatibility.

