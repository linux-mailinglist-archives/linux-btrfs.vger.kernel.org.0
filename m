Return-Path: <linux-btrfs+bounces-22255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFL5GTLEqWm2EQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22255-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:58:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC52216A68
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC9F303F065
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24923EAAB;
	Thu,  5 Mar 2026 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LeMsaGg4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uiUooHH+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435422248A3
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732731; cv=none; b=VZKIdaN3gu1Pve3hAx1QtZoyVsLPyF3hHh7aoHjOE8cbfUkaoMDDBlIoRJU2hd0SahtoaMC0LlTrwXhplcS9rC8En5sw8uSiS8etaVUBoKhpx3A+QOvV89x4GZQqwmraM4r8nLRKdTHFr32Ws6bg5KdoG7dd1cwUBynJchQx6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732731; c=relaxed/simple;
	bh=pzRUyjSlX2700Hq1rMOWcOaDsOt14wSdLlNd+xT85bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+bCxPwLZdlPnIw1VfGEUNxBzIs5DBfRrebV06xj/G8vNTXPsnAoxfO1zo6wmSqoSIwZDaNorHE+EoMRu/eD+L0cDr3fJowu5Sv6Z9RUWAWcvbCiQUQWCY5A4IgXTJh7Nwi92tAflR801bY7opwKXllMf5xsLapz9T/jMxtlOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LeMsaGg4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uiUooHH+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7FFECEC0574;
	Thu,  5 Mar 2026 12:45:29 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 12:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772732729; x=1772819129; bh=hLBgVNsWIP
	OVeePzwIQYkboGhQzrYTjvXhyciHZ6hLE=; b=LeMsaGg4xCxd16Xpu/xyjywNZS
	Af75n44d2llL4gMP+W6djQ56BvgmI8Fvh1XuMHSI82h+vzqeYtxaQlA9qiI3+Y4D
	qiHcefAHh272VTxlGYcrjL8tYPwzMoLco3NCjVXGvxJ9x7ZdPRFAor9vkAABt9if
	SNQ3WZQdll0toQ0xBzOoy9e7hNFg2Sq+GNLzrnKin4crfDTQBpmROFkgoJv9RGrh
	7N9LElOA8VN6+FgQnf1SWuNR+SletTpF/bVwdU1Er/DArruBxntpb7PtRs5UlV8p
	pURw6PjcEkCyb8GYzKCO1OyCawBnX2qedDV2K4OZjH2gvdQrGfLu4JBqUJUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772732729; x=1772819129; bh=hLBgVNsWIPOVeePzwIQYkboGhQzrYTjvXhy
	ciHZ6hLE=; b=uiUooHH+4+WaK02KNotaJrAX7qdmc8ZeRB37JsPFFgCO37ouPfU
	c5qko8PpUEvKN7yRUz4eWqI3V6e45su3E7KERZlIqKpNQud5W8VNwNBEognx4MIk
	WO70rwXGD2QstF8Tym6hX1kiQIsVGnvPkW0LOhqUuf7wxBASwhBKQWqS63nYyAjx
	KZQN5WuYOTnC9GiC2vYux4GKFR2C0cHYLuo9JZGuBvOvAIyzwSSl6f44+Y2N67Po
	FfcTMxhs5ug0DQpMR+Ksk6aTuGskf0Aq7fm5u2gbwy8O5SRgaiUuMe542ENcclHa
	K7zBe7co/XgVfjB/PPAX3gfTgRfoaq9zoTA==
X-ME-Sender: <xms:OcGpadhK51u2VLMtzxRTIP3pjRkW3yLiJsd-gnu81-saghjjLfaghQ>
    <xme:OcGpaZflqu8lJ2tuP9yBRrdjVliPq-tP3fH9YXzM0imJF7jzZOkwtJAGQKESSYGU4
    jdGPxZGVfj6jZ03krj9inFJZajqTfnndxxnp4T4rwEx6ryQxwBEbRI>
X-ME-Received: <xmr:OcGpaadzu2P0em2nc2Xm6XdLhMiOWCiKydidaRQVopXcgHmaDcSwHtpE__Eg8aiWwBeqjO3fnQsL6UvUeuvKDuKg1Gk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtiidprhgtphhtthhopeifqhhusehsuhhsvgdrtg
    homhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:OcGpab_LdjkhUuhkyloQf0hH32RCRwsst9VOmDIvy6BrC0_xAnZZBw>
    <xmx:OcGpaenVFxP4e01w0jrWiipI8dwwE4DghYEx3DH-WG-C25nN_2K4qg>
    <xmx:OcGpaV_rstb8ma08DGXj7ffRZLj24w8TOoCREIkd3-gO9J4D-IizNA>
    <xmx:OcGpaUmbDPU4Zf8tncu3dyP8B5hqWJ2fYwOCP92KHexugikY7PJZkA>
    <xmx:OcGpaRr8bnF-F3yjnaRPt7aK0Wt-f0miIbMzs0E7kHesp9oz09ORZwRK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 12:45:28 -0500 (EST)
Date: Thu, 5 Mar 2026 09:46:09 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
Message-ID: <20260305174609.GC926642@zen.localdomain>
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
 <20260305025611.GC5735@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305025611.GC5735@twin.jikos.cz>
X-Rspamd-Queue-Id: DCC52216A68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22255-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 03:56:11AM +0100, David Sterba wrote:
> On Mon, Mar 02, 2026 at 06:30:30PM +1030, Qu Wenruo wrote:
> > [GLOBAL POOL]
> > Btrfs has maintained a global (per-module) pool of folios for compressed
> > read/writes.
> > 
> > That pool is maintained by a LRU list of cached folios, with a shrinker
> > to free all cached folios when needed.
> > 
> > The function btrfs_alloc_compr_folio() will try to grab any existing
> > folio from that LRU list first, and go regular folio allocation if that
> > list is empty.
> > 
> > And btrfs_free_compr_folio() will try to put the folio into the LRU list
> > if the current cache level is below the threshold (256 pages).
> > 
> > [EXISTING LIMITS]
> > Since the global pool is per-module, we have no way to support different
> > folio sizes. This limit is already affecting bs > ps support, so that bs
> > > ps cases just by-pass that global pool completely.
> > 
> > Another limit is for bs < ps cases, which is more common.
> > In that case we always allocate a full page (can be as large as 64K) for
> > the compressed bio, this can be very wasteful if the on-disk extent is
> > pretty small.
> > 
> > [POTENTIAL BUGS]
> > Recently David is reporting bugs related to compression:
> > 
> > - List corruption on that LRU list
> > 
> > - Folio ref count reaching zero at btrfs_free_compr_folio
> > 
> > Although I haven't yet found a concrete chain of how this happened, I'm
> > suspecting the usage of folio->lru is different from page->lru.
> > Under most cases a lot of folio members are 1:1 mapped to page members,
> > but I have not seen any driver/fs using folio->lru for their internal
> > usage. (There are users of page->lru though)
> 
> The pool worked well for pages and it is possible that the ->lru has
> different semantics that do not apply the same for folios. With the
> support for large folios and bs < ps the pool lost its appeal.
> 
> > [REMOVAL]
> > Personally I'm not a huge fan of maintaining a local folio list just for
> > compression.
> > 
> > I believe MM has seen much more pressure and can still properly give us
> > folios/pages.
> > I do not think we are doing it better than MM, so let's just use regular
> > folio allocation instead.
> 
> While in principle we should not try to be smarter than the allocator
> there's a still a difference when we don't have to use it at all when
> there's memory pressure that wants to write out data. The allocation is
> a place where it can stall or increase the pressure on the rest of the
> system.
> 
> When we cycle through a few pages in the pool we can write lots of data.
> Returning pages to allocator does not guarantee we'll get them back.
> Placing that just to the compression path was an exception because there
> should ideally be no allocation required on the writeout path. As
> there's no generic layer that would do that transparently it's btrfs
> being nice at a small cost of a few pages.
> 
> So I stand by the reason of the pool but with the evolution of folios
> and bs < ps the cost could be too high. I can still see the pool for a
> subset of the combinations for some common scenario like 4K block size
> on 64K page host (e.g. ARM).
> 

FWIW, we do already see issues with allocation in compressed IO in
production, so I am hesitant to support this change.

On the one hand, we have the issues so the pool is not completely saving
us anyway. On the other hand, removing it seems likely to make this worse
in the way that you predict, Dave.

If we do move forward with this, I will try to watch such errors closely
on the first release of a kernel without the pool.

Thanks,
Boris

> > And hopefully this will address David's recent crash (as usual I'm not
> > able to reproduce locally).
> 
> I'll run the test with this patch.

