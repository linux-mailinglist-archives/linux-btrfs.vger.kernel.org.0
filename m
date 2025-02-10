Return-Path: <linux-btrfs+bounces-11358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA7A2E62F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 09:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374297A39BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDE21BEF83;
	Mon, 10 Feb 2025 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FH7kDVQZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D91BEF7E
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739175500; cv=none; b=E/LbAgGs7qA8nFm/3oCcBijuzyIWaXclTqApHgEdGz0DAkWgmQMcNNCU1/EwIcXjrel+xR3uZAsaAGCxMhVcsZ6BBWlX1CYoFZK0IRZR4h65lWOVKCBP3NCrR8FMJGmhjxkA/1ciXwwtr78gDl8/903g0lNPoLINiyAwKVg+AU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739175500; c=relaxed/simple;
	bh=9/xJajeP2FVKMoXyonkzE3TFDAFOhuTedQ56pyx1gz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIXLsOg+jYtTT1QJJtfnQUctSf9uYsKMjXxonuHk3RLXh7oQp3qFxqJORABmvDWlPeN2WW45qf2GPWij5DoEJ2+fMMryuU1L5NwoeQywTYuySZjDZiQ8GTkKCgE+HDQt7An4c5Xh9j7YtrrMS0eTf9sopqsGX0P4UOnybxscK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FH7kDVQZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaecf50578eso804531666b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 00:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739175496; x=1739780296; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9/xJajeP2FVKMoXyonkzE3TFDAFOhuTedQ56pyx1gz4=;
        b=FH7kDVQZ0IgjNtrq8KMcakAmquzVwNT0Tz+YYEBZdB94sQrt0MQZb1lfC3CUqMWtgv
         9Av9jqBO8efoFvqdOLnIn8zh4d0ar10rgS4kK2FSKEPhRNwhICC4zkkeg32PQMnVD7QP
         7BE5Nbfy3fX7CmXmAhfgIS+HYsrhWHSTXgj2OUjoBals7pc046GXQpks6/bcnI7DQbAo
         55t0EjE0tRiwfLlo68ux12f61AfPN2bCdLnUKwSQsbzcSdP55RQQ/jpMxwjuA2D7a5+s
         jyQGfIKU2bRoSbFHNZgpiX/rDFKkDWy+UxNxr64rslh8bR4Tywxq/KNHu7xoqs1MmjaH
         WVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739175496; x=1739780296;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/xJajeP2FVKMoXyonkzE3TFDAFOhuTedQ56pyx1gz4=;
        b=HuLKRnYlwq3b1TEo/RjAyHeqkiSrAilWWR/+CTJSSlISSYgn1AtCqKPeJSi9pQk391
         uXMQucFJF69swwBmA5nH3HUfrHTuT10fOaboRG8NWnsPp8HE1io6RQkE1hQsk2blk3BH
         b5lTfpmUWjeDUXxeVL24PnqTGRdh+UACXYF++je74OgtLSnAyVHB52IW4ktbonHhryWV
         elr1szCmlOlWJSbB94sE19+AJH2nGBjkqm+xNeqaEJcCyfiwpXypGt+w31frkylvfrzg
         IJ48RTy1RjNjVVDSCJN+B4hBwuMP50pAz0WMKKbfaiXXpyN3SfMoyIAKR/5lZ/Auz3lK
         +ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWelniMO9fpVtZsbhCgm9IOJveMx6g8NyM6iATSDXo+bsZhNOa8gOb5ATcqtHslnKFYukyqmnONWmn7zg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe2ITaNuDUTAsM07JsN73xvsieShcNMZ36FmYbBB7rB4o6Rmoe
	6qSOHAqoJCX8Xe5UQj4q0Q2bMUhUNANKkwdX4BKZO64ohsDfCFlxnxwaxBovzvLdOp9oJQuZRkv
	M55DdtSm6VxSxOQUT+p7Rj9W3K537KG3wtZmDYE2c/P39uvAu
X-Gm-Gg: ASbGncsN1L12zzgpbgjrpaPkbWzXCGUnsCIhPaBQA74lKLxTymVRI51BYXj/6dmyMqs
	BUEhmt+gj/8+vl4KMCT2aEqFRA/bbQdeRXuTKN6HCMLeUkEN2F77x3F+l3ACmgcmYyVLiNe4=
X-Google-Smtp-Source: AGHT+IEnj1BcpJ/vf+pAvC7rpjR14xcF+qi7ppnzbWyoFsJ7umwlzIjI3S89j5znVdpJyi84NnWD9aI7J8X7UYSc4JI=
X-Received: by 2002:a17:907:1c22:b0:ab7:647:d52d with SMTP id
 a640c23a62f3a-ab789c6e8c9mr1295169566b.51.1739175495909; Mon, 10 Feb 2025
 00:18:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124075558.530088-1-neelx@suse.com> <20250127180250.GQ5777@twin.jikos.cz>
 <CAPjX3FdaxfzULnRjN7TqyS9uK_ZJSk2PRzLgQCLVGBrR0yKLGw@mail.gmail.com>
 <20250129224253.GF5777@twin.jikos.cz> <CAPjX3FdJynRY91N-1aJ0wOrMJY+cKvSuhLDPGAuCybEvSzS0KA@mail.gmail.com>
 <20250205164012.GJ5777@suse.cz>
In-Reply-To: <20250205164012.GJ5777@suse.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 10 Feb 2025 09:18:05 +0100
X-Gm-Features: AWEUYZkc_Fpv8JjNosljHxiWCONTtiR4ZS2YuiasqWFtTORikRUsjwqzlAensY8
Message-ID: <CAPjX3FfCgtUcrTiui8VW=bPC9fdrUqa65dCDeymk+=jnFOYWFA@mail.gmail.com>
Subject: Re: [PATCH] btrfs/zstd: enable negative compression levels mount option
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Feb 2025 at 17:40, David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Jan 30, 2025 at 10:13:36AM +0100, Daniel Vacek wrote:
> > On Wed, 29 Jan 2025 at 23:42, David Sterba <dsterba@suse.cz> wrote:
> > > Up to -15 it's 3x improvement which translates to about 33% of the
> > > original size. And this is only for rough estimate, kernel compression
> > > could be slightly worse due to slightly different parameters.
> > >
> > > We can let it to -15, so it's same number as the upper limit.
> >
> > I was getting less favorable results with my testing which leads me to
> > the ultimate rhetorical question:
> >
> > What do we know about the dataset users are possibly going to apply?
>
> This does not need to be a rhetorical question, this is what needs to be
> asked when adding a new feature or use case. We do not know exactly but
> in this case we can evaluate expected types of data regarding
> compressibility, run benchmarks and do some predictions.
>
> > And how do you want to assess the right cut-off having incomplete
> > information about the nature of the data?
>
> Analyze typical use cases, suggest a solution, evaluate and either take
> it or repeat.

OK.

> > Why doesn't zstd enforce any limit itself?
>
> That can be answered by ZSTD people, that the realtime level number
> translates to the internal parameters may be an outlier because the
> normal level are defined in a big table that specifically defines what
> each level should do so there's not predictable pattern.
>
> https://elixir.bootlin.com/linux/v6.13.1/source/lib/zstd/compress/clevels.h#L23

Yeah, I'm aware of this.

> > Is this even a matter (or responsibility) of the filesystem to force
> > some arbitrary limit here? Maybe yes?
>
> Yes and this is for practical reasons.
>
> > As mentioned before, personally I'd leave it to the users so that they
> > can freely choose whatever suits them the best. I don't see any
> > technical or maintenance issues opening this limit.
>
> As a user I see an unbounded number for relatime limit level and have no
> idea which one to use. So I go to the documentation and see that
> somebody evaluated the levels on various data sets with description of
> compressibility and says that levels -1 and -15 can give some reasonable
> results. I can also reevaluate it for my own data set or take some
> recommendation.
>
> What would IMHO look really strange is to see another 1000 levels
> allowed by the parameter but docuented as "no obvious benefit, only
> extra overhead".
>
> If somebody comes later with a concrete numbers that it would be good to
> have a few more levels allowed we can talk about it and adjust it again.

Right, agreed.

> The level is currently not stored anywhere but we will want that
> eventually for the properties so limiting the number is necessay anyway.
> So this is a technical and compatibility reason.

I was looking into properties as well and I have a draft using 8 bits
for the level value. I think we can stick to that for now.

