Return-Path: <linux-btrfs+bounces-12684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5777DA763D2
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5D2166F20
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723C1DF27D;
	Mon, 31 Mar 2025 10:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VHn7t6T+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF711DED40
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415590; cv=none; b=ocpr1LcWRMNzeFoM49IgYs3pDpIYxOxbygzMJpyTWRnZEnx4fLfu9Nid1TNu4WHfvCX1JoDME6r+lO5ivo+AuageITm3AqetdVJCZDatc8qz2rH2fEobzYg8z3lp9WXwWhktKxS46R7IkQYSXkGAJnnd3TfyPq9NQVS33Vl6X+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415590; c=relaxed/simple;
	bh=j3gsOeQ0J9+h4s5tv+MEM7+H2Ks6tViGWPgQEYxS5yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFKbEhU2H1PO/rUA//7redBmP3J+tMXk82EGULqlMOVw37OXRzEvJs10d0zH9qNb4sax27OA2KUI6OsQdiC+WkipdTtCSO+HeUEPXDij5mV8S7UiH8xqxUkEg9v0LZD439hX6MPfPaMetmqsZIvcRm+DR9EKSgZ/7DiXzH/B7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VHn7t6T+; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso7022378a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743415587; x=1744020387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrMN6LZWukOmN0j90Re+qVcywcRqKb8H+Y3qDOVIMVY=;
        b=VHn7t6T+nmF/wANvZ2lSQBW04ipnnR8CtYUH4V5tY9zBvWTOXHzC1BrW2YdECd/OLs
         1efTKIUKvWAap9hWhrD+Q5HcNH9s5JrwW3vT9WzcwEZ81oXCnKxcKre0L5FXRPT4YwgT
         4C12ddLK/LnfO0dyx9EnK46w6jLyTq0Ry5411dVqn57ZxCw3+dZ8+pHBJ+4jGaLwNWm4
         lTc2bVMWzu2qM1OnPZUyG5HZdTblI4jnqWYMXrOS3ZeE3kUAGh3Dc9TP1GgX5D7n8+m5
         C0xP2ixduom22pMsyVDpJu7VNd6nCM48zV9os9lGe4cwmVvyN2OWYC3ttxAK0qo+kypT
         qgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743415587; x=1744020387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrMN6LZWukOmN0j90Re+qVcywcRqKb8H+Y3qDOVIMVY=;
        b=P3jE97ajzRzSgbeSTYxXSQ/ncm22BUpoK8KnO1ixPzECbXmbH//vDJf6G6yMnVZSGO
         XNNk1e40VP1vSkcYJRd8RaJKspfjyT1AAekNjTQRowwwKr9TbjFatZ1IHKDgwbbj+qbb
         i5I3iVUbH33I3FpKbmQSMSO26+FuzvtNy8lziB3DKuU9NGt2MkBe0hugUdP1NNY0LvA8
         A8kE8Crv9EJc8vbkuppaUc5AbIe3AY98pvxu/6b1qNKpOuchT55bW1A9YP82piqelc3C
         U/6cCXtoI49YpE3jgDn7GTolOmR8ABPjyvHNh/+ZuLQJzQOHHT/dE5ue/oXPUleqMw12
         Pm3w==
X-Forwarded-Encrypted: i=1; AJvYcCWTT+1VbpVJprBJB7b0u7nvabXKLHc0g3+pvncXwy8dM3MFmv/+qrLm4pXatVYsHQmjbl0HmZzWeukZoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIGY2+e0PHRWNS9uOztRet65fsBCitZcqxgtbpWWuKTan4+on
	eqsEmPLlJnvB6GQeIPuWoVOTz48G5uBKosCfOUA0jKdtxVHXKB6qnBWlGsS/eI90JtaFuLKzdFd
	84JB79wSF+lEDrqnjgg5Ne4U/HjUPttPq77qu6g==
X-Gm-Gg: ASbGnct/N3nIn7/rEtADcBbbXl3NXZGmiPmGnU49gGx3XXJeRM746Xo0/FSLpphitv8
	lxy+gcQXQ1tgyhCqYB+0Kdvi69p72Y4hLP1Wg71Nc6kswFCInBw0Azl49WMPxKGQEkBYP2N8WhT
	drZLzL4ur8B76Go+y2Vi8R6L4W
X-Google-Smtp-Source: AGHT+IFjoxRROSQJ2QQqf9HRlr+wmpb/KClLSvPvp1nnV8qvUH1qPNSLpAY2JcZAclvPhNIvsCQu1LAjYR7TxgXQO58=
X-Received: by 2002:a17:906:4a94:b0:ac7:a2:b6d6 with SMTP id
 a640c23a62f3a-ac738bae0eemr656150266b.57.1743415586921; Mon, 31 Mar 2025
 03:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082347.1407151-1-neelx@suse.com> <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
In-Reply-To: <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 31 Mar 2025 12:06:15 +0200
X-Gm-Features: AQ5f1JqutY5B58lKkBXLsgmMnOxey8gmhV-G874E52O3tluKYg9BOIh6iYZZcLU
Message-ID: <CAPjX3Fdru3v6vezwzgSgkBcQ28uYvjsEquWHBHPFGNFOE8arjQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
To: Qu Wenruo <wqu@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Mar 2025 at 10:49, Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2025/3/31 18:53, Daniel Vacek =E5=86=99=E9=81=93:
> > Now that zstd fast compression levels are allowed with `compress=3Dzstd=
:-N`
> > mount option, allow also specifying the same using the `compress=3Dzstd=
-fast:N`
> > alias.
> >
> > Upstream zstd deprecated the negative levels in favor of the `zstd-fast=
`
> > label anyways so this is actually the preferred way now. And indeed it =
also
> > looks more human friendly.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >   fs/btrfs/super.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 40709e2a44fce..c1bc8d4db440a 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -368,6 +368,16 @@ static int btrfs_parse_param(struct fs_context *fc=
, struct fs_parameter *param)
> >                       btrfs_set_opt(ctx->mount_opt, COMPRESS);
> >                       btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> >                       btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> > +             } else if (strncmp(param->string, "zstd-fast", 9) =3D=3D =
0) {
> > +                     ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
> > +                     ctx->compress_level =3D
> > +                             -btrfs_compress_str2level(BTRFS_COMPRESS_=
ZSTD,
> > +                                                       param->string +=
 9
>
> Can we just use some temporary variable to save the return value of
> btrfs_compress_str2level()?

I don't see any added value. Isn't `ctx->compress_level` temporary
enough at this point? Note that the FS is not mounted yet so there's
no other consumer of `ctx`.

Or did you mean just for readability?

> );
> > +                     if (ctx->compress_level > 0)
> > +                             ctx->compress_level =3D -ctx->compress_le=
vel;
>
> This also means, if we pass something like "compress=3Dzstd-fast:-9", it
> will still set the level to the correct -9.
>
> Not some weird double negative, which is good.
>
> But I'm also wondering, should we even allow minus value for "zstd-fast".

It was meant as a safety in a sense that `s/zstd:-/zstd-fast:-/` still
works the same. Hence it defines that "fast level -3 <=3D=3D=3D> fast level
3" (which is still level -3 in internal zstd representation).
So if you mounted `compress=3Dzstd-fast:-9` it's understood you actually
meant `compress=3Dzstd-fast:9` in the same way as if you did
`compress=3Dzstd:-9`.

I thought this was solid. Or would you rather bail out with -EINVAL?

> > +                     btrfs_set_opt(ctx->mount_opt, COMPRESS);
> > +                     btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> > +                     btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> >               } else if (strncmp(param->string, "zstd", 4) =3D=3D 0) {
> >                       ctx->compress_type =3D BTRFS_COMPRESS_ZSTD;
> >                       ctx->compress_level =3D
>
> Another thing is, if we want to prefer using zstd-fast:9 other than
> zstd:-9, should we also change our compress handling in
> btrfs_show_options() to show zstd-fast:9 instead?

At this point it's not about preference but about compatibility. I
actually tested changing this but as a side-effect it also had an
influence on `btrfs.compression` xattr (our `compression` property)
which is rather an incompatible on-disk format change. Hence I falled
back keeping it simple. Showing `zstd:-9` is still a valid output.

--nX

> Thanks,
> Qu

