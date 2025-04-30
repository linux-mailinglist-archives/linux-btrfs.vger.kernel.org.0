Return-Path: <linux-btrfs+bounces-13545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9317AAA4AC1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 14:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5D6E3A66D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33F225A62D;
	Wed, 30 Apr 2025 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hBoCpDVJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BA25A331
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014983; cv=none; b=PVtqiywisTd8lNk+gjx3/zRXEb6mSdtPwHOraEPQp0R1aNrznYklahhOM/zpImjzZJ+YlTv3W6nhfrQo/t7xttueIWKi11kkfwByJJ3LQi9HbPgu7uMEJqcLCysQ7DBHb5KRKWfOCYa+b8Rzv6ZH+TQxZLhz3pOURjxZ7RaRctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014983; c=relaxed/simple;
	bh=8KldIvPyeyrNxgTI0ZsvmXUIoixPtf61rxatBYhk6W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYwlnMK137o0nBmfxhmqWfCwqkRjLD/IBAOLfKZShwXpQJdD7rpJ5nCbL5LbqHjei06EqfVbGnqCL+19JJhOmZzoGCBUWjG+HNO63l7JGiTx2Hy9PnLWrSA84aY/r5oeocUKITxG47oVVSx9mxO0oUI6snEJqeKnahE1JKiBXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hBoCpDVJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e677f59438so11295937a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746014979; x=1746619779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yomRrib/ec+S+xnoz6mogpRGq964XEY/6Terik8eUrY=;
        b=hBoCpDVJmgXyJNqRnv5u11KkvKGC5kD5oLl6jEdhu0UB5CVSwp5S50aMwdx5yKMysv
         lR/hdsmAtvX1XnSgZ6bWsI2l23r+RvhmZrQBn/X67aRZhy917Iu6aoKdhYk7wQBMiwat
         RV8ibiNpOs3eKGgAI+Lh3Ru/RjkH5QZjZTqay/VNlrO1//523F0mtwS1C0o36mbIjNNV
         +gWayRe8o+wM7qOMgANlnLl7mV0tpnX1Dh9FedwLxQ9sQRzNE7tVZLOBhhyQW4/PH0lI
         VFKYhJDYOqU0AswwBRnjapU6GB8eMgW7bHXEiGvNEoFKo79fgYJLAdRbY8wxBPxWyD3t
         yDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746014979; x=1746619779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yomRrib/ec+S+xnoz6mogpRGq964XEY/6Terik8eUrY=;
        b=k0aIs3iM5nW+PftvbNYwZlurSsLjZ0IYj67QZ9dl9oDvYS7KFiz4/erziq8nZi6oPL
         9v7cXsxOzDYnYFJ1SlGO15OsgRWIu7+UntHf4PBtaR1cAiih8q+7C1vyDxV0Iw1Fr6QU
         LUFTeVp5hU6Z6OeDLrrBZIr0UyONa69R0Cb4I5IwjOFYiOM7aoHuz395vW37+ndEB89A
         73FUMpywj2WDOrhTrmuZzr80I9iBilbzjNPLN1/BZRbSPc3HbveLnve/2ULEAnCdudSe
         yrc4ACIA2uNVwHiCFJm0q8iihlyK0gcPb/LI3myinA/53IJUPDRYAuzQN/uNohsZUQOG
         TsMg==
X-Forwarded-Encrypted: i=1; AJvYcCVFE+ekHebor6p0J7qJMUGvRhfc6lBer/Sn8uYCgkcH9Ze9ND63RKnzLEcHlXeTj/kgDgb+VlLhdA5HsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBl5mh3Gtql/0I7M0c+IwyYIxfrKsxR0znZXXNd7mParRF7auM
	W00KY3O0nJjfTsb6PpE7UzBNeen1LJ/kMqjFH5U+gi5gyzW5ljVX3wTwfgv9xrzitq84kAf1Jli
	StJjJO43B24qLbv5Al3g18GGIwe+UEIywNyuGKo3j2pTQTwUJ
X-Gm-Gg: ASbGncvCuoeecgvyTH2M2DnisqvSKHae/e+yKpbnK+3dfN6wyuh/QicUvirSHcf+nfz
	LPoSkdxpKsSeVk2rAR8uXNaImaJ8bafExwirdK+rYfFtQExf4q/AtIFQCrbOd1NjedKhI6k0Y/P
	cksCt/z+SWhp9RMBjywgFZ
X-Google-Smtp-Source: AGHT+IF582B4BNpnAWPeBIgXyE1DCKVvQmVItfAo4T9ZANlKsGl3EhfCKe59cp3JmShenfkdYaGJGiTgLiPA+rnFf7I=
X-Received: by 2002:a17:907:2da3:b0:ace:3a1b:d3d with SMTP id
 a640c23a62f3a-acedc57504amr337067266b.2.1746014979210; Wed, 30 Apr 2025
 05:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429151800.649010-1-neelx@suse.com> <CAL3q7H7WPE+26v1uCKa5C=BwcGpUN3OjnaPUkexPGD=mpJbkSA@mail.gmail.com>
 <CAPjX3FevwHRzyHzgLjcZ8reHtJ3isw3eREYrMvNCPLMDR=NJ4g@mail.gmail.com>
 <CAL3q7H56LC5ro+oshGaVVCV9Gvxfnz4dLaq6bwVW=t0P=tLUCg@mail.gmail.com>
 <CAPjX3Fe3BZ8OB2ZVMn58pY5E9k9j=uNAmuqM4R1tO=sPvx7-pA@mail.gmail.com>
 <CAL3q7H5Bzvew9kGXBRLJNtZm+0_eMOyrgUvC1ZK544DunAPEsA@mail.gmail.com> <aBIE28WHbC2jPkpz@fedora>
In-Reply-To: <aBIE28WHbC2jPkpz@fedora>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 30 Apr 2025 14:09:28 +0200
X-Gm-Features: ATxdqUHxbZOqrlJ4zSj6vUkQey8LaW6Z-7BefegTh3VgTrkADgDumoGT3bZ8PZc
Message-ID: <CAPjX3FctaJkUwv3ZsEfuamBhLwD5=MzoyWAotV2CN9-eJrxWZQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member field
To: Johannes Thumshirn <morbidrsa@gmail.com>
Cc: Filipe Manana <fdmanana@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 at 13:09, Johannes Thumshirn <morbidrsa@gmail.com> wrot=
e:
>
> On Wed, Apr 30, 2025 at 11:26:08AM +0100, Filipe Manana wrote:
> > On Wed, Apr 30, 2025 at 9:50=E2=80=AFAM Daniel Vacek <neelx@suse.com> w=
rote:
> > >
> > > Nah, thanks again. I was not aware of that. Will keep it in mind.
> > >
> > > Still, it doesn't make sense to me to be honest. I mean specifically
> > > with this example. The header file is also private to btrfs, no publi=
c
> > > API. Personally I wouldn't differentiate if it's a source or a header
> > > file. The code can be freely moved around. And with the prefix the
> > > code would end up more bloated and less readable, IMO. But let's not
> > > start any flamewars here.
> >
> > I'd disagree about less readability. Reading code that calls a
> > function with the btrfs prefix makes it clear it's a btrfs specific
> > function.
> > Looking at ext4 and xfs, functions declared or defined in their
> > headers have a "ext4_", "ext_" or "xfs_" prefix.
>
> To add my $.02 here, it is also a matter of namespacing. There's nothing =
more
> anoying than having two functions with the same name in different subsyst=
ems.
> IIRC we did have this with the in_range() function, that is available glo=
bally
> and there has been a btrfs specific as well.

Yeah, I've been there. Unloading debug symbols of some module(s) from
the debugger due to collisions/aliases. That indeed can be very
annoying.

> Byte,
>         Johannes

