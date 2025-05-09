Return-Path: <linux-btrfs+bounces-13847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9BAB0B1C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F889874D7
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50D26FA4E;
	Fri,  9 May 2025 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bQQFuAGe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DD51C2324
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774191; cv=none; b=uMxCU4YYyYmhgSccI9FG3ZoX3sygEnaJ0rEgRXkLEvVYDmCGPMXkL//rRjqJjaRTPZNhHaKA2EG9hhAKFQYC82rtR9vfRyudltRdYAKeziaQJRkXXSU7D2hyRHl3hUqC5khDFNPRmtqlRwDpCS3E+tcPBOuyh0uS/SaTS1yURbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774191; c=relaxed/simple;
	bh=CvONQ7eEzu3ayZggNQu/kFRSKacxZAOPmHYbBaIFMmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc2NbgjmO+KfcLCMY/E40zI6KFaYtg2YUkxLQtiVIIDw4id/7al2ChxmI2DUbAOMiXj34qQNLhqZYoqxOj9OB8e6a25MMpcKPlNT1JUGDh2NXiVt0Y/6pocKle+Tsywangj/ixHKCgWH8/dMuZubQ7Rm1U9EBfKC4MQIKqJ6LDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bQQFuAGe; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so286595266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746774187; x=1747378987; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kWR4S8gCHgh90zVtA+3pYG6Dq2UYmqa68QtELpfJSqY=;
        b=bQQFuAGe+BOZqwauweXIJHY1aCl8UUdcsXUfERTJkQGmEF+7UUTck+yvoHua5kkV8W
         zH5DONhxbgYV4w065RydaX54TqE4g4IUDFsRY/eMDtHRyLIQ/LJTzAd41Wkzt1A+Nt5z
         lYocRCNhinkw2G6VZq1Qk9fwRN5Im8BNMBWoPtpfsHkuiQJvLNOayiu6twTBMHsln0Bm
         CBRyMiTdKGeWteGdOdsAV5dhAISZ1g70Insuajww5pFzDhvrPqdPczB+D9TsV90DSvev
         QE5r8Qkd7p9ZoBmd0TCyU7NqAhCiCkVytdmH09F8xp6JRWvsWfMF7NE8WX+hX2/4ezRC
         bkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774187; x=1747378987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWR4S8gCHgh90zVtA+3pYG6Dq2UYmqa68QtELpfJSqY=;
        b=ez7wqqD1l0LgtSEVVYXxQMIhavshNr10GMpcwh3RWGuTX28sYFbAK27gpXnz8B2xla
         mVfdWaS/qNcjV5bU2ui0ta29BiqkibTF0YZDJmf9LjeNtiWCGCv2/l4CWgKjCTtHfMP6
         JrdpH+YHkeKW1TSrnjdy3MnMN3lzWRWpLn6GBVKYDTnbMRphGrZJjaMqEUUsspQTqb/l
         EC3cQfJXg3cm2z+QpAH/TPhTQXd1lMoxBkuz0Bplwo/1vE70OcfCUdWNLYqBWjK4VisT
         NKkKud36Bq5oqS6odlO5dSB7oJr4SWyMorbhWt9+AXJYBKb4qB9Krwmv/RhTswbJTCar
         YewQ==
X-Forwarded-Encrypted: i=1; AJvYcCXouajbIxDFtjNJVgB6yjBH3L5DX+K2Qr5KZgmxBTJB010/M4wGs04BvCuMKWc3Z1znQXhW7R2QCljxtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQ6kADBAb7lov4pkIJdAVrxfpSDYuklRt9LEEz0o3hA6gsZkF
	VnfwlAmvKyRzVvhYUjSO6ib3D9efdnkLaLwKYKpSm3Myrvq0yFydojCaKNbI3qATMgk4Nbdd8Y/
	trbob+geJgR0FZ6u3QRrkqVgRuC2m6xSI+nRY5A==
X-Gm-Gg: ASbGnct4zFhfwucKIj7wXI/xHDNaJPCz5xEnDS4otQ7s+eAldEMvanQc8HuOUM/ahw1
	81ro6pE8CGWnQk9Wmve5ypLcqB/k6RUlhdtfQPx1oJqgXryHl8m8gnq2vpyhDJGr3xQ/kVJ2MDI
	jl/wdJ9ZQzNKhBsFCaJX8n78kXV623AeBHdbUteGj6RG6mrGehPSnyhbGKfnkAYXz3MVs=
X-Google-Smtp-Source: AGHT+IGxo4nq7hfXX71i571Gr5GnYywHl1wOMZjqK/5yAU/Y2BTpIqf3WCKR6HUF/rhSGCgBiDEdQkDF07/Lda3cmDY=
X-Received: by 2002:a17:907:7a8b:b0:ace:3a35:43f2 with SMTP id
 a640c23a62f3a-ad218e70678mr219019966b.6.1746774187325; Fri, 09 May 2025
 00:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422155541.296808-1-dsterba@suse.com> <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
 <20250507174328.GK9140@twin.jikos.cz>
In-Reply-To: <20250507174328.GK9140@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 9 May 2025 09:02:56 +0200
X-Gm-Features: AX0GCFvwnUi3Ec3rfcio7HTymqWMnnmkfbHtOSe-VZyYhB2UkATbpEcLYX6vwKQ
Message-ID: <CAPjX3FdoqC6VJ2F1ia3vxYKVhnv=oT2GCkY668Z7ugSagTmPdg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use unsigned types for constants defined as bit shifts
To: dsterba@suse.cz
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 May 2025 at 19:43, David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, May 07, 2025 at 03:50:51PM +0200, Daniel Vacek wrote:
> > > --- a/fs/btrfs/raid56.c
> > > +++ b/fs/btrfs/raid56.c
> > > @@ -203,8 +203,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
> > >         struct btrfs_stripe_hash_table *x;
> > >         struct btrfs_stripe_hash *cur;
> > >         struct btrfs_stripe_hash *h;
> > > -       int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
> > > -       int i;
> > > +       unsigned int num_entries = 1U << BTRFS_STRIPE_HASH_TABLE_BITS;
> >
> > This one does not really make much sense. It is an isolated local thing.
> >
> > >         if (info->stripe_hash_table)
> > >                 return 0;
> > > @@ -225,7 +224,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
> > >
> > >         h = table->table;
> > >
> > > -       for (i = 0; i < num_entries; i++) {
> > > +       for (unsigned int i = 0; i < num_entries; i++) {
> >
> > I'd just do:
> >
> > for (int i = 0; i < 1 << BTRFS_STRIPE_HASH_TABLE_BITS; i++) {
> >
> > The compiler will resolve the shift and the loop will compare to the
> > immediate constant value.
>
> Yes, it's a compile time constant. It's in num_entries because it's used
> twice in the function, for that we usually have a local variable so we
> don't have to open code the value everywhere.

Right. I'm just blind, sorry. Could be const unsigned int.

I have noticed before, using `const` is also not consistent within btrfs
code. But that's OT here.

> > ---
> >
> > Quite honestly the whole patch is questionable. The recommendations
> > are about right shifts. Left shifts are not prone to any sinedness
> > issues.
> >
> > What is more important is where the constants are being used. They
> > should honor the type they are compared with or assigned to. Like for
> > example 0x80ULL for flags as these are usually declared unsigned long
> > long, and so on...
>
> Agreed, flags and masks should be unsigned.
>
> > For example the LINK_LOWER is converted to int when used as
> > btrfs_backref_link_edge(..., LINK_LOWER) parameter and then another
> > LINK_LOWER is and-ed to that int argument. I know, the logical
> > operations are not really influenced by the signedness, but still.
>
> Well, it's more a matter of consistency and coding style. We did have a
> real bug with signed bit defined on 32bit int that got promoted to u64
> not as a single bit but 0xffffffff80000000 and this even got propagated
> to on-disk data. We were lucky it never had any real impact but since
> then I'm on the side of making bit shifts unconditionally on unsigned
> types. 77eea05e7851d910b7992c8c237a6b5d462050da

Yeah, that's nasty. That's precisely what I meant when saying that
more important is the types actually do match. The implicit promotions
are the source of hidden bugs.

I'll check all the changes once again, to be sure.

> >
> > And btw, the LINK_UPPER is not used at all anywhere in the code, if I
> > see correctly.
>
> $ git grep LINK_UPPER
> backref.c:      if (link_which & LINK_UPPER)
> backref.h:#define               LINK_UPPER      (1U << 1)

This is what I was referring to. The flag is never used. The whole
`if` can be removed as it'll always be false.

$ g g btrfs_backref_link_edge
fs/btrfs/backref.c:void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
fs/btrfs/backref.c:    btrfs_backref_link_edge(edge, cur, upper, LINK_LOWER);
fs/btrfs/backref.c:        btrfs_backref_link_edge(edge, lower, upper,
LINK_LOWER);
fs/btrfs/backref.h:void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,




> > ---
> >
> > In theory the situation could be even worse at some places as
> > incorrectly using an unsigned constant may force a signed variable to
> > get promoted to unsigned one to match. This may result in an int
> > variable with the value of -1 ending up as UINT_MAX instead. And now
> > imagine if(i < (1U << 4)) where int i = -1;
> >
> > I did not check all the places where the constants you are changing
> > are being used, but it looks scary.
>
> This is touching the core problem, mixing the signed and unsigned types
> in the wrong and very unobvious way. But we maybe disagree that it
> should be int, while I'd rather unify that to unsigned.
>
> If you find a scary and potentially wrong use please send a RFC patch so
> we can see how much we can avoid that by changing that to a safer
> pattern.

