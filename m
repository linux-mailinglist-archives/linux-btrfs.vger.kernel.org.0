Return-Path: <linux-btrfs+bounces-14426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F3ACCE18
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76D257A1D3E
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C208200B99;
	Tue,  3 Jun 2025 20:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="L9ShJxa1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZLse0EEi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DED7C2E0
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982096; cv=none; b=GVzrFDIuxHNSLUCrvFDJzmnpIyE5y79jo7SFjRdL1ZdzTRaBObBXaFowwZgVqQA2mjGvFMEFyG4OD27HleFwjviIXWtv5dJePmb/fdrFQYFfnwd2Ox48/Tc5us1SP1G0GQm/3/X+wWfGt0WbAHwJDMzO7WBoOTkCFUuwn8R4/Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982096; c=relaxed/simple;
	bh=ctj2kVb26SZOGCt70AaIB12YcikGmEESjXgOpjckRec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZovJwVNryoM77s1Awtd1SRgiQweCdUbZ3HaQpZk5ziL05klWgIUV1bBxafZYqZUC+1uJXttMjaLeRutWbzpJENLGiEnthXPtsHTNzHC/sMTIbY3ib98v3vVdANEmbtC72uRQWYN9RjiP1LisKc6KKR85Q7JXT9vvMnOAbVMW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=L9ShJxa1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZLse0EEi; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 78D9E11400DD;
	Tue,  3 Jun 2025 16:21:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 03 Jun 2025 16:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1748982092; x=1749068492; bh=C06nSlTWk0
	//XeKaWEhLKBcZzfCWFYUfzDQpbb7XYxY=; b=L9ShJxa1p4QRoq/GIPQ6KFoequ
	KkahbDOddqGhPBpZQYx591JnvkHVLtisDqu74v3OMYXJU+iuU76OJCjXOgvR1zKy
	V5wjOKg1EZPj0w7ntp5r4EF95PSvoDpi814554LoRFLOf0+guexTcHqql4Tpj7w2
	ayigHoLJS7EgFhcN+OfsrvsLtc5gqwJhz6VxLJKp+bRZHvFAyiy7horJ3uP+68gk
	AMHgukwnIR/y+NFu32IcSqfnS9G+/BgIBeTdVfZO9YOswhUooWuSnfpaS5HOOZ3q
	GXGxbtLuCmEAOwJ57wzijE5LnfOHthujlZ+E5SsQ5KWfkAJgykOBgUlxPNpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748982092; x=1749068492; bh=C06nSlTWk0//XeKaWEhLKBcZzfCWFYUfzDQ
	pbb7XYxY=; b=ZLse0EEiCClnTj2CMA0BUit6qhWlW44OMEcuwKY1KZ8tPvyXKQB
	jih4Q7iR2ky+bZub57/Ki96LO1NJ0W8zhFb8OhLNkNmgKq7XisFKmj0Tvq2UftZr
	aCi4t7iqfa0LOxnSIIWXcFHdaeuXf0wQk5X/LXiPXhDodKqYLcFRM7v/MgAlwzK1
	kh311GqrgDX4cCMd2tcgxVc2sOt3JxtYx98Sm1iYRNK5JPJKu/L7ZnEL5JdZyh6g
	Zn/SdV5HVhkt8XNiNZLvkKmNeG6SZHYcw8NMdzcw0VgxndTLYFtTRFbrcEhPxqlb
	X9hTjhwAidat/7tUEkRUhN6t75vmnXkJzaw==
X-ME-Sender: <xms:TFk_aBie63zQAS-D6vy0f42FhW3j5wCeA0_taht_SlGt_0ngNB1Gpg>
    <xme:TFk_aGD8cbbyL2kkDN8oiG83__tjI_lV743HSKvNup99rfVH7ZuRmgpS7DXK5vr06
    VEVl6nmm2c0sth_vzU>
X-ME-Received: <xmr:TFk_aBENJ_dSpU2VhHetir_-d2G84EAZ9CWoQSppmOfilwkztffEb0nOSwQOfxN9pt6NiF81YJDFXw4CkYRiUV7mjMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtth
    hopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhr
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TFk_aGRC7V905_T1AZVNJXXUM0ds7M8naoGNdhCj4K1C1ni4F7STRQ>
    <xmx:TFk_aOzgHioJLJc8TackTGAOhic6iYIuGhq4s4Il3Rm-LLXaoQI1RQ>
    <xmx:TFk_aM5osC8WbLdYk_EPWyoXum6yKB5JXZVSD4qszGYsfgowh2CGEA>
    <xmx:TFk_aDxFy4AUmF2kaYkMOLQE2VNq3_x1xAbr-rEuUkGOAurmumOY_g>
    <xmx:TFk_aIpcKschLfPirDOOELRjqtqJ4ZAjTwCp0u8hV_oF_cvKDpCgQ3PS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 16:21:31 -0400 (EDT)
Date: Tue, 3 Jun 2025 13:21:28 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: add helper folio_end()
Message-ID: <20250603202128.GA1771652@zen.localdomain>
References: <cover.1748938504.git.dsterba@suse.com>
 <bb27f76180bb5bc365b4917310c7bc283ba91c6b.1748938504.git.dsterba@suse.com>
 <20250603185442.GA2633115@zen.localdomain>
 <20250603193659.GK4037@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603193659.GK4037@suse.cz>

On Tue, Jun 03, 2025 at 09:36:59PM +0200, David Sterba wrote:
> On Tue, Jun 03, 2025 at 11:54:42AM -0700, Boris Burkov wrote:
> > On Tue, Jun 03, 2025 at 10:16:17AM +0200, David Sterba wrote:
> > > There are several cases of folio_pos + folio_size, add a convenience
> > > helper for that. Rename local variable in defrag_prepare_one_folio() to
> > > avoid name clash.
> > > 
> > > Signed-off-by: David Sterba <dsterba@suse.com>
> > > ---
> > >  fs/btrfs/defrag.c | 8 ++++----
> > >  fs/btrfs/misc.h   | 7 +++++++
> > >  2 files changed, 11 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > > index 6dca263b224e87..e5739835ad02f0 100644
> > > --- a/fs/btrfs/defrag.c
> > > +++ b/fs/btrfs/defrag.c
> > > @@ -849,7 +849,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
> > >  	struct address_space *mapping = inode->vfs_inode.i_mapping;
> > >  	gfp_t mask = btrfs_alloc_write_mask(mapping);
> > >  	u64 folio_start;
> > > -	u64 folio_end;
> > > +	u64 folio_last;
> > 
> > This is nitpicky, but I think introducing the new word "last" in in an
> > inconsistent fashion is a mistake.
> > 
> > In patch 2 at truncate_block_zero_beyond_eof() and
> > btrfs_writepage_fixup_worker, you have variables called "X_end" that get
> > assigned to folio_end() - 1. Either those should also get called
> > "X_last" or this one should have "end" in its name.
> 
> Ok, then the "-1" should be renamed to _last, so it's "last byte of the
> range", but unfortunatelly the "_end" suffix could mean the same.
> 

Agreed that it's still not supremely clear. Whatever you decide you
can add

Reviewed-by: Boris Burkov <boris@bur.io>

to both patches.

> > >  	struct extent_state *cached_state = NULL;
> > >  	struct folio *folio;
> > >  	int ret;
> > > diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> > > index 9cc292402696cc..ff5eac84d819d8 100644
> > > --- a/fs/btrfs/misc.h
> > > +++ b/fs/btrfs/misc.h
> > > @@ -158,4 +160,9 @@ static inline bool bitmap_test_range_all_zero(const unsigned long *addr,
> > >  	return (found_set == start + nbits);
> > >  }
> > >  
> > > +static inline u64 folio_end(struct folio *folio)
> > > +{
> > > +	return folio_pos(folio) + folio_size(folio);
> > > +}
> > 
> > Is there a reason we can't propose this is a generic folio helper
> > function alongside folio_pos() and folio_size()?
> 
> We can eventually. The difference is that now it's a local convenience
> helper while in MM it would be part of the API and I haven't done the
> extensive research of it's use.
> 
> A quick grep (folio_size + folio_end) in fs/ shows
> 
>      24 btrfs
>       4 iomap
>       4 ext4
>       2 xfs
>       2 netfs
>       1 gfs2
>       1 f2fs
>       1 buffer.c
>       1 bcachefs
> 
> where bcachefs has its own helper folio_end_pos() with 19 uses. In mm/
> there are 2.
> 

OK, thanks for looking into it. It seems like it's not a crazy change
either way, without too many relevant users.

> > Too many variables out
> > there called folio_end from places that would include it?
> 
> I found only a handful of cases, so should be doable.

