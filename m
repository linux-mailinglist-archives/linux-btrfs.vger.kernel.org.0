Return-Path: <linux-btrfs+bounces-14628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DDEAD7205
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 15:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5143717B28E
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Jun 2025 13:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF6024678F;
	Thu, 12 Jun 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N7QTZ2sl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5E1F3FF8
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734977; cv=none; b=T+DOec/d6m2n7Wfg/nnnm1qxeErQrD0qCWOYHU70+mv0EADYjP1LGR8YYxznxaFJQPRlvpJueNejb1jQzUbuEkYXTnUzm99sn/HWnZ/OFZ3n+RqsQZ5+2U83xH64rMUwp/MPpZUwYXiAIWbioVC5Yz2azE8/IU30L2HATbuof18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734977; c=relaxed/simple;
	bh=tyaWXuJEscIM/pRJvevrANS+YajaEw5h4VbmA0cjUGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFqrs6sJ4qZHUjLXzKtWCiU+m/4kRwzJYTamb92QndYgSylxs4FkdU1PrC5SaxTpVBH2bgkNUaD9wMhXDp7glBJ1lFgqUKm0sEfYWi6/zb/cWbnbL3HMlT7oNa0Lf7/eTua3IVPPj2DIQ6MwOF+XJAM6QJWupjrczcxa5WY91X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N7QTZ2sl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad88d77314bso209260866b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jun 2025 06:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749734973; x=1750339773; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaCbwYcyztgsQSk4M0vxeNKM8wXA6XHC0XWXp5bFZsc=;
        b=N7QTZ2sl2heJpBsAnlU70B3xw5MkCUVa2MvooNCUhE7Ln74hN5Lc+G1rCcPnc/LHuV
         IuJwAqMvqFfqg1NeOMIoS3HMXSPyDg87dvTKRUdA1NbEj8Kz3lLhdscP2+z6eFkpD3vi
         8rDMzQ/0PMfD74Ck1F20lzQAQWo/ajiyft6XINiThKOOTBBxh/7se28A3wNUdo6ez72I
         slNe3nW7UvTVGOIWd1ryncu+5tBXvNGnNNXxZpmSTmErX0hGjtE3aoG0PrlvIZD4tynP
         brCAClikq8iRuhxBoEjlalPkospjrnH5HfpGeIwr/xpQFyIF7fqVcvh+lkXpKZtUZqXL
         5fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749734973; x=1750339773;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaCbwYcyztgsQSk4M0vxeNKM8wXA6XHC0XWXp5bFZsc=;
        b=RmF3o+BaBfUs8U0Z6VCpjBIcNAz7Df1zkItFrYzjA3jDA0YoFeFZYPmQfAZbOCBh4I
         eTqk+CLFXKj2kaXOGnwi/nGgRBO5zETC3GRJFe/+GhNkGXv8GV0E1qocECeU3QXxYJOz
         Xzrgx65un/wLUbvcx2FXrNh9PjU9G4xKFvCqixfDxf5StVfK6bgGaCkRwDW7xYGXe6BX
         J5vUgF8FVcOj7pFurbvaLvAo1pkNYK+EsdvwCqisz4sTnXQIxGGqOJ3jOmmrpeP4dRUN
         O0NbRxNk23qxyukQm4bt7Ze5bixa6RqIUnuNLleCk+q+cNUVdrSHvg4OjC2ctqpovd+S
         5NSA==
X-Forwarded-Encrypted: i=1; AJvYcCW/1cjxhTTmxV6ANJanxemVa7raGYf0Yd879q1anwJitGZ9wjOqEnxdkOj+6aaUSGBG0HhmIGnOIZkSVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwybSmbOo/9uLWsakc6rNc2VIH6NtnOsu1pHNENGup6FDUsVM8d
	J0xDoahHv4DJ2HaQ40BfAzR5G4l55xF+eyIoTvCGmrlp1fIgYZfjeCKWGn1D+7D/hlW0Tx4gj4E
	UwqbHsgSC1DFRBvgzbgINOZImiq6q7oi55AhZmhyNSQ==
X-Gm-Gg: ASbGncs8fkJe5oHn92UrJieMd3GMnUNhca4Ll8FgHibBMkpzm8yKN+mMkSnxVXb48xm
	CGvbp9FeurFLMWKnB9t1WE45zLZ0VLw3fw/dwZdulTAJfoaEV5CxihPXbv2677O4f66YoHOAMMM
	MDRiQDlqaBwneGQrHTBKG5rzJpEGuEkoaOJSW09DygRA==
X-Google-Smtp-Source: AGHT+IFGzGuDldvCwIGTPyVY/Q1f+5J2pGNKIoR0uw4vF1eEfVN2+qQHJPAY5DSSkd6e4ABDxQQq7ZK6AMhN3exyrJM=
X-Received: by 2002:a17:906:4796:b0:ad5:78ca:2126 with SMTP id
 a640c23a62f3a-ade89855d42mr727863366b.59.1749734973378; Thu, 12 Jun 2025
 06:29:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602155320.1854888-1-neelx@suse.com> <20250602155320.1854888-3-neelx@suse.com>
 <20250602172904.GE4037@twin.jikos.cz>
In-Reply-To: <20250602172904.GE4037@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 12 Jun 2025 15:29:21 +0200
X-Gm-Features: AX0GCFsfTbBiHDmM72eeEGEjMZ4pxvPRrfO66llnHwT1xiVFoRv5Mu6oDVr90v0
Message-ID: <CAPjX3FdyMGKGFch-k=CmOD7wP_as_iaB9hmnbbui5=off+m+iQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] btrfs: harden parsing of compress mount options
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Jun 2025 at 19:29, David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Jun 02, 2025 at 05:53:19PM +0200, Daniel Vacek wrote:
> > Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> > options with any random suffix.
> >
> > Fix that by explicitly checking the end of the strings.
> >
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> > v3 changes: Split into two patches to ease backporting,
> >             no functional changes.
> >
> >  fs/btrfs/super.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 6291ab45ab2a5..4510c5f7a785e 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -270,9 +270,20 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
> >       return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
> >  }
> >
> > +static bool btrfs_match_compress_type(char *string, char *type, bool may_have_level)
>
> const also here, string, type
>
> > +{
> > +     int len = strlen(type);
> > +
> > +     return strncmp(string, type, len) == 0 &&
> > +             ((may_have_level && string[len] == ':') ||
> > +                                 string[len] == '\0');
> > +}
> > +
> >  static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> >                               struct fs_parameter *param, int opt)
> >  {
> > +     char *string = param->string;
>
> and here

Can be done at merge time. Or do you want a re-send?


> > +
> >       /*
> >        * Provide the same semantics as older kernels that don't use fs
> >        * context, specifying the "compress" option clears

