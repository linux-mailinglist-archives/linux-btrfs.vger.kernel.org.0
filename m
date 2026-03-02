Return-Path: <linux-btrfs+bounces-22155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKwSD2HopWlLHwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22155-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 20:43:29 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 907D11DEEA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B85443033207
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0BE47DD5E;
	Mon,  2 Mar 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lorCphJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zcu8in6P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1147DD49
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480599; cv=none; b=DADORumppeKa1O815LxyBx49f4Edzl/smVATjA4L6LcAtNDzw6siiCUcWfbb6NwSA36lQ9qR4ZB9P/W2jqjcBX2dj0fxGRBnlycBhzDyNOkydRbczBMBoMR1EmltgfP4Vs/3273Mbh3Y2A1DqgVmf8Ijv/RfFxBSgOpbR9H/oCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480599; c=relaxed/simple;
	bh=Bg45ZHscA/lmojNktzCgiMEZ8JM0bjR3IOlq50idl/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAtLQ0Qb4DDEo+4etAi8LclV3Ic24mZu5TPIxuXcsx1wKibHjtqjzljb7Y59QxsFQ0SPoPpiOZEkTiQj7LvPoaLPlNBs3FAe4rkMisegsSM9hkxrJEtYYWifAKcsATf7avyoiRO9IfhZzsre7ccas8aQHkTF+UyN/y7StLa6aYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lorCphJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zcu8in6P; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DBB8F7A0068;
	Mon,  2 Mar 2026 14:43:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Mar 2026 14:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772480594;
	 x=1772566994; bh=xt22U4CVExrOCrqaenKk6yR+KigYVT/WNjg1I9nACsE=; b=
	lorCphJxbB+hBAh9WBWUP/lVpYtK3uWLepLlxSPiRTijSmC6JcHRHemIhz7zR5Gh
	ImAplXR7gKz5DKCv776q9ahK9f25wSvg2yDPqpRDjePLucMEnfOK2yHwEiGrd4KA
	oQ5H5DISKxemxT0U7gppD3w1aP9+EXnOE3fMrYwd0z8oTlmTIyBoRYMMHj563iyQ
	ixDySL97xa+rDk2oyzFDE0XiK/DKZwuSwEllIOUGbr3HCBKJUxdbT4w+urX+LvNS
	Kxumb/HN5jJsQAPk4tJ4goRDwfqohia0KgQ1RbIXrcqc9ShMk9D1729wyktUaJYy
	Px2P7m8rItzkp7jb5HdFCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772480594; x=
	1772566994; bh=xt22U4CVExrOCrqaenKk6yR+KigYVT/WNjg1I9nACsE=; b=Z
	cu8in6PSOUSlNkmSbRqZpGYDoch/Ytcy+OdHMwXGiOqc7CXrW2GUsp0eFVcxEAKF
	DXrBmwr2l0RBobka3/OX0y8bYD/EhuI4Q4I5+Zcr2Bke673XXqhAbih4QW8FxLF1
	W90O/zo1DuOLo1Kx1MoMcAPsxeQZ8Bt3u7u4Si2Gg6n0OraTrVFXdLBZOS2UNyB5
	6bnxLzyoz9QONbVRqkl0pxGYtaxN/KEDLu2OCg9B99gZ0chH6ZUP1ryXLTZdg9nF
	Sv6sWH+q0deRWiK3/YNsUPyHN0pVz+9zmugva/KoQB0gWaWx9WIRwOltISdizZgt
	64XfvdsV3YMGquyJCCyjg==
X-ME-Sender: <xms:UuilaUqMALsabL-TldIEXP0mfkvmtwJr8zXZ5OlE20Pkqq2PHHo3vA>
    <xme:UuilaQrXEXZCFddM7pBQBspRVCHVssdslDFK7Z32fU7Hv3V38XoIBuDijLbChh22T
    eKSMl2d_eSUayI_1h1f64b1PCXE1L6hFVcMnUPfqsk_cBX2sdYn1VS8>
X-ME-Received: <xmr:UuilaW2BTGrLVRSgCRbmDawR2n6W3ITC1BQW7sgRLKTeNPRzQaIHvdjththwIQprUHxLJxGxLwNRtfW5JtWeMmc_diM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrlhgvgidrlhihrghkrghsseiirggurghrrgdrtghomhdprhgtphhtthhopehlih
    hnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UuilaXBSMf1enQHDzcIUyw2uObbACTNbnvZ8mZM64KMSa921qDpi8g>
    <xmx:UuilaWc3FyfvHfndiT3f7v1O4eX5ooI4OVVBnvsEwhjS0BIcbWmfOQ>
    <xmx:UuilaUgMNYMb334LIcZo1z5oQ78srK0XuAIS7lHVCGNwC3ClD83XdA>
    <xmx:UuilaWqdkyRx89dRyXaaaz5AYGPRN2dsN8jTu-d9XU7Xo8gG_EjI_Q>
    <xmx:UuiladxsZb65NwMxDjuqvhSiy7s25YaknvA1IvmLB6KjW-l2r2ZZHEpR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 14:43:14 -0500 (EST)
Date: Mon, 2 Mar 2026 11:43:59 -0800
From: Boris Burkov <boris@bur.io>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH-RFC] btrfs: for unclustered allocation don't consider
 ffe_ctl->empty_cluster
Message-ID: <20260302194359.GA1173790@zen.localdomain>
References: <20260226113419.28687-1-alex.lyakas@zadara.com>
 <20260226173746.GA2968189@zen.localdomain>
 <20260226182915.GA2992537@zen.localdomain>
 <CAOcd+r31fvMHskN93LNjbXrhpL0hF1kZd6rkVuhcEAgXHtcW-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOcd+r31fvMHskN93LNjbXrhpL0hF1kZd6rkVuhcEAgXHtcW-A@mail.gmail.com>
X-Rspamd-Queue-Id: 907D11DEEA1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22155-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,zen.localdomain:mid]
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 12:14:09PM +0200, Alex Lyakas wrote:
> Hi Boris,
> 
> On Thu, Feb 26, 2026 at 8:28 PM Boris Burkov <boris@bur.io> wrote:
> >
> > On Thu, Feb 26, 2026 at 09:37:46AM -0800, Boris Burkov wrote:
> > > On Thu, Feb 26, 2026 at 01:34:19PM +0200, Alex Lyakas wrote:
> > > > I encountered an issue when performing unclustered allocation for metadata:
> > > >
> > > > free_space_ctl->free_space = 2MB
> > > > ffe_ctl->num_bytes = 4096
> > > > ffe_ctl->empty_cluster = 2MB
> > > > ffe_ctl->empty_size = 0
> > > >
> > > > So early check for free_space_ctl->free_space skips the block group, even though
> > > > it has enough space to do the allocation.
> > > > I think when doing unclustered allocation we should not look at ffe_ctl->empty_cluster.
> > >
> > > I see what you are saying, and a the level of this situation and this
> > > line of code, I think you are right.
> > >
> > > But as-is, this change does not contain enough reasoning about the
> > > semantics of the allocation algorithm to realistically be anything
> > > but exchanging one bug for two new ones.
> > >
> 
> Thank you for your review and your comments below.
> 
> However, I am not sure what is it that you are actually requesting.
> Do you expect me to describe the whole mechanics of find_free_extent()
> and how its state is tracked through ffe_ctl?

To be confident that this change does not introduce a different,
potentially more serious, bug, it is important to demonstrate why this
transformation is reasonable, safe, and fits the existing model. That
implies some level of explanation of the mechanisms of the existing
model.

> 
> > > What is empty_cluster modelling? Why is it included in this calculation?
> > > Why should it not be included? Where else is empty_cluster used and
> > > should it change under this new interpretation? Does any of this change
> > > if there is actually a cluster active for clustered allocations?
> I am not changing the meaning of any field of ffe_ctl, which tracks
> the state of every call to find_free_extent().
> 
> I found an issue where "empty_cluster" is used erroneously in my opinion.
> 

At this point, in my opinion, you have a useful insight and a good lead
for a fix, but have not done enough work to justify the change you want
to make.

> According to the code, "empty_cluster" describes the minimal amount of
> free space in the block group, which we are considering to allocate a
> cluster from. I am not changing the meaning of it.
> 
> My fix is suggesting that "empty_cluster" should not be used when
> looking at free space in a block group during unclustered allocation.
> Nothing else is changed. In the issue that I saw, this bug prevented
> us from allocating a metadata block from a block group, when the block
> group still had enough space to make a 4Kb allocation.

At a minimum level, I would like to see an analysis of why the
empty_cluster may have been included in the calculation and some
reasoning about why excluding it ought to be safe and not cause issues
in other situations. Aside from improving the behavior in the conditions
you observed.

i.e., a general demonstration of an understanding of how the change fits
into the code at a wider level than just changing the one thing you care
about right now.

> 
> I tagged the patch as RFC, because I am unable to test it on the
> latest mainline kernel, and I tested it on a stable LTS kernel 6.6.

Why are you unable to test it on the latest mainline kernel? I can run
it through fstests for you, if that would be helpful.

> 
> Thanks,
> Alex.

Thanks,
Boris

> 
> 
> 
> 
> 
> > >
> > > etc. etc.
> > >
> > > Thanks,
> > > Boris
> > >
> >
> > I missed the RFC tag in the patch, so I would like to apologize for my
> > negativity. In my experience with other bugs, the interplay between the
> > clustered algorithm and the unclustered algorithm is under-specified so
> > I think it is likely you have indeed found a bug.
> >
> > If you want to fix it, I would proceed along the lines I complained
> > about in my first response and try to define the relationships between
> > the variables in a consistent way that explains why we shouldn't count
> > that variable here.
> >
> > If you do go through with sharpening the definition of empty_cluster,
> > I would be happy to review that work and help get it in.
> >
> 
> 
> 
> > Thanks,
> > Boris
> >
> > > >
> > > > I tested this on stable kernel 6.6.
> > > >
> > > > Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
> > > > ---
> > > >  fs/btrfs/extent-tree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > > > index 03cf9f242c70..84b340a67882 100644
> > > > --- a/fs/btrfs/extent-tree.c
> > > > +++ b/fs/btrfs/extent-tree.c
> > > > @@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
> > > >             free_space_ctl = bg->free_space_ctl;
> > > >             spin_lock(&free_space_ctl->tree_lock);
> > > >             if (free_space_ctl->free_space <
> > > > -               ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> > > > +               ffe_ctl->num_bytes +
> > > >                 ffe_ctl->empty_size) {
> > > >                     ffe_ctl->total_free_space = max_t(u64,
> > > >                                     ffe_ctl->total_free_space,
> > > > --
> > > > 2.43.0
> > > >

