Return-Path: <linux-btrfs+bounces-13811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7FBAAEE2F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B942F176E76
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 21:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B628C2B3;
	Wed,  7 May 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Rpbzth6m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fz6yhZ3W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71524230272
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654769; cv=none; b=oypz0w51zoeZ0698Y5gqbI7HgAk9L/av+Jx1gAB073RmzR/P1xVRlPCiup0+7W8Dg+tJlfNJavW/LHJUPAg0iWt1+45rlF0nzHy4V7OrYM7DnHFUQDs4DrEFLixOpKi7Habm/jq1wkwngofiGjtFCKQb0ICtLavKCpZy+SgVFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654769; c=relaxed/simple;
	bh=OhbyAZCu7qhDmcxFGgdq27Rkv4A+rt0vOaHQ2f5KJJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh0+Dr90B8xtmizLHLrOpRyVkNpIBBcwxG0sKpq9ZlMrkA1FowLn+LfPueuoAbO4scM9TuYN6RQPzujKOeEkxYgBixr74dkt8K3Nn1c4WUqKW/8WVkRNFkm+Xb9yY5h0GtKROrB0i1+kPR6SUy+50UJTwFHeoLDLrYI5CmolgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Rpbzth6m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fz6yhZ3W; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F773138019E;
	Wed,  7 May 2025 17:52:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 07 May 2025 17:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746654765; x=1746741165; bh=OF88DyVSQn
	rtDQvMOrbixt2tsMGzRdxDTAof7/NCjd4=; b=Rpbzth6mVwKOo7zNH3JSt8qVru
	yiSPYKPjHI0aDqXsDOk412Ps2eVNNBtPUeRhgkSut5/M+6yOR3stHTKmLfk2vUmS
	RtuMe7xbc2kzF8ov8mtKFiIjgeygqq5X8ijBFzCuh+/muY4+9UTUhJKR11d+/us0
	c7YnhGc6oAlqgQSxbm2febjpssZ/oMjfQQAUER7haHJ1i9efpkOx02C/CfUkFSPw
	JXfSUeDxv0O4Oi0iqyDj3icwlVciBse8T2vFoAHXVbFviTOawJhlTZ4DeaTZXEKW
	CFVTViuuF6hAg7Q7Jz6pUvxZZYBPF9AQ7dS1Ncf865ZX1saAibVqUZdf4H3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746654765; x=1746741165; bh=OF88DyVSQnrtDQvMOrbixt2tsMGzRdxDTAo
	f7/NCjd4=; b=Fz6yhZ3WQNHEbL7R5TfTmX7NwwoaMoN3xponK4Upd0R4CdOKxvp
	sddJgHV8569eelYZ4yWL45j/ghGFdGxf0yQhmMsSARVt4PPY4EAFC6VW8rgl/u/4
	iuTQBjsseae/Ox+lekEGxDXnLtZmrnsLuuxk8Y6Zu6FrrQP5yunRQwzFWum3mCX1
	WonfyhojNuOqQAMrMgjYOUhKF7QucnHbCJfpamIhxMyWv494T82AH/OGt2e+oMOI
	HNbXHL+SCmqojWHoZC/MiWyXVAya3LZu91KU8AkPEaJg5mmZDa1zjwi727Qmn/Ub
	8PqOSeTuPCXa+OpvYrPoVtImT6hiqFz9khQ==
X-ME-Sender: <xms:LNYbaFhD-nu1KzvKidCzDeOwqhDby2Ww8t2i5sesOr4eMy6srfzrIw>
    <xme:LNYbaKDYJU9OVdlmLqBKT1XPs8o0__SC7zy1bjNw4h815NETE-yHQO112gmaXLKkN
    -evp-JOJ43jitKnUzc>
X-ME-Received: <xmr:LNYbaFFUnR4ZERjMSCe72JaOj0T152FVS26DoqkdwK_7rgK-aW5xQGBdJ6M93doH_D2hxTbfBClyQoPAHZvWIuRUp1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgtph
    htthhopehnvggvlhigsehsuhhsvgdrtghomhdprhgtphhtthhopegushhtvghrsggrsehs
    uhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:LNYbaKQYTaBBFthzCDSeOBWlCKFlgNZFbI2eyK-fy501twALWG67Nw>
    <xmx:LNYbaCyaarDn7zYTskOkl_Nohermwer2VNN8z9YfSnfOeJLmp3x9NA>
    <xmx:LNYbaA7JXa3Kx27xZGYDdoGQ89lhdZznTAQYvPbJoPL5YpO-3DQkzg>
    <xmx:LNYbaHzAFgOBFRrIWMsrUVjVJSDSc6nEgv5vSZSBmaDqdBKC7yBXZg>
    <xmx:LdYbaL9_aHd5F1P5C0GLV0hBKNcAN9_fs2i-eVJSIvVl5lYOkhRuYrrN>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 17:52:44 -0400 (EDT)
Date: Wed, 7 May 2025 14:53:27 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: use unsigned types for constants defined as bit
 shifts
Message-ID: <20250507215327.GA332956@zen.localdomain>
References: <20250422155541.296808-1-dsterba@suse.com>
 <CAPjX3FcGAUqheUg0TQHG_yvuQExjT3N3SUGRYtk1S3b3aDVZZQ@mail.gmail.com>
 <20250507174328.GK9140@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507174328.GK9140@twin.jikos.cz>

On Wed, May 07, 2025 at 07:43:28PM +0200, David Sterba wrote:
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
> 
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
> 

For what it's worth, my support for moving to unsigned types for all
shifts is based on that same investigation.

I think a sign extension on s32->u64 is way more surprising and hard to
debug than a "whoops I thought -1 was less than 1 but actually it's
bigger", which is the first thing you would think of for weird
arithmetic errors.

> > 
> > And btw, the LINK_UPPER is not used at all anywhere in the code, if I
> > see correctly.
> 
> $ git grep LINK_UPPER
> backref.c:      if (link_which & LINK_UPPER)
> backref.h:#define               LINK_UPPER      (1U << 1)
> 
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

I suppose the MOST convincing form of this patch would thoroughly audit
all the users/arithmetic involved to make sure they aren't doing
anything silly. I immediately noticed that LINK_UPPER/LINK_LOWER do get
passed as ints to btrfs_backref_link_edge() in a way that is fine to my
eye, but it wouldn't hurt to change that unsigned int too, the way you
did in a few other places?

I am still comfortable with this as-is.

