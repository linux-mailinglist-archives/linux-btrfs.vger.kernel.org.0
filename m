Return-Path: <linux-btrfs+bounces-22018-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDVIDaKUoGmvkwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22018-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 19:44:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73B1ADEB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 19:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F069830F99EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 18:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2C238A724;
	Thu, 26 Feb 2026 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dfyck2IS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPwMzDwK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE623876BA
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 18:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772130534; cv=none; b=U7Qy3FhcWv6+ucvgLdhg1ctNxmArstWA2ZWgJgs1ka3/e0053joZAs9I3HmfmiQc3ddYFTr0gAQpLJO+CUv9dh+B7MZths4l4bc7Nq7mkx9jDLlwuKiv+XoBi3Dzi2dslMgHaU9sCZtejgtR4tF7pSbrDHe72ETeGfXAQnUr1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772130534; c=relaxed/simple;
	bh=zR4hJfYhcbBylLrIGmV9Rpbu9x9ZL3e8+ArQXf2tzMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnPH8UeV6wZAtHX+pnfOT7mZZTTlb8uMJKYLUZ3eFZUbavb7iDd0+3g2kpy1TlZDL6p0BOGadT8BYRbLR+dR2jczsjTLim2KkT54e/D+D75qaUQs0Ei9DkAEIl32jl5f3zNDHdb/PvPKyfUfZPLw8ff/tRpYY01UrCPO3xs+4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dfyck2IS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPwMzDwK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E83FB14001AF;
	Thu, 26 Feb 2026 13:28:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 26 Feb 2026 13:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772130531; x=1772216931; bh=KpRTOb0s8c
	WavzVcWkKaZQwn2f36eCC59a4bnfdBTS0=; b=dfyck2ISYzMowJxfFzNz41YMyd
	I/gAUTV685CaMooKBXsmwJIaFvWj6wCeTGo/LEulUMB9B56FKoux8wcpNX+eXEHj
	cPKXDl+8x+f+Zvp85CChn6qg4lo2rxUw5NSoOd43Evx5GX3CInvMvX4JDqgOod//
	TWrPTYLzzNTIdAh5I4doTSoxNCHfk4ez8PF3zzjb+vSqM0EWMVOqrhvGt8mJIwuz
	31+EufslW+q9l94P+DAz82HuzwD00mizydXHIOXQvSRM1G2ATM+BDkz92UKP9M3F
	w+pKtWKOdLn43AapTyRiJUNk1PnVE620CbYdEIlXEspT0fGxhB2xvumOE7nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772130531; x=1772216931; bh=KpRTOb0s8cWavzVcWkKaZQwn2f36eCC59a4
	bnfdBTS0=; b=cPwMzDwKfBBrScCODCGQeyUqlMc0GzMsUdu6ZU/msiSkQa5lEfI
	voOFDUA1cBZ3YbM7+Uwx7wDLTtcYyGjHfjUsvBO7S9tA8KXM2ZmwCd3OnBn7JJLN
	oyfCKXt/lJ1YsZhDeIAOtFD12fXWpfhVlv6S5Jr0DivGEM3azUWBpt0Zz/xwljQ0
	3XzSn2i7Bh47jvO7VgQMoZopnAI7xQ5rfdlLs+hNUCeSN5bQYJlDie7dCJaNia3C
	pnOPVX0IyustdGGfeWhkDs3J2Wd9NubSyipSI0Nh7oC++uE1m5NQwZJTP/oVagkK
	3inBJNofeCosfg7w86mAeBaRlOqicxoaAqw==
X-ME-Sender: <xms:45CgaTlo0on2Jih0QqRGd_Et11zn-v-Q14ywPEd6tw0ekSrliTWrZA>
    <xme:45Cgac01WRM2bIVF44u5Lu8ZPkSWJaqe-uRLZIhorOUV64ODYIEeV1JQQ_b_ooT6w
    Wjh0nBmk9QSqq9JBzLDgyS7MthYiDig8mxmcSCO-WfLr7t7-0nliw>
X-ME-Received: <xmr:45CgaXQMl_YGAYUGhxzlsxNd1AY9SuP-eq1P2rnBpR8rl0LfoOW-OBzf9xw6WOY8OCVqkg5Ii7Q4XDnOukkmLOpGDJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeijeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghlvgigrdhlhigrkhgrshesiigruggrrhgrrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:45CgaWvOSu5806xzkWtG3LRtKOamengzMaF7ntU_8Lf2IgZcrB8O5Q>
    <xmx:45CgaUaDuKma10BCxABtOwIQnM7ezPVUTBuucOCM0JIRu_PvCEFaVg>
    <xmx:45CgaTu0oF-5WB5MlhEN2ydYKA2gwNKtrvaUZ_Chx5UqPoGyb5w2uA>
    <xmx:45CgaeFxUkV0tOhi2RGWpUiJwcB8EmgBu1bvzHasJAaop0AWDHIKkQ>
    <xmx:45CgaduOSj3UzgDOmMxFrklHlnIjfcWgGMElphZioEsUPgOguh77y6BD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 13:28:51 -0500 (EST)
Date: Thu, 26 Feb 2026 10:29:44 -0800
From: Boris Burkov <boris@bur.io>
To: Alex Lyakas <alex.lyakas@zadara.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH-RFC] btrfs: for unclustered allocation don't consider
 ffe_ctl->empty_cluster
Message-ID: <20260226182915.GA2992537@zen.localdomain>
References: <20260226113419.28687-1-alex.lyakas@zadara.com>
 <20260226173746.GA2968189@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226173746.GA2968189@zen.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22018-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[bur.io];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zadara.com:email,zen.localdomain:mid,bur.io:dkim]
X-Rspamd-Queue-Id: CF73B1ADEB1
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 09:37:46AM -0800, Boris Burkov wrote:
> On Thu, Feb 26, 2026 at 01:34:19PM +0200, Alex Lyakas wrote:
> > I encountered an issue when performing unclustered allocation for metadata:
> > 
> > free_space_ctl->free_space = 2MB
> > ffe_ctl->num_bytes = 4096
> > ffe_ctl->empty_cluster = 2MB
> > ffe_ctl->empty_size = 0
> > 
> > So early check for free_space_ctl->free_space skips the block group, even though
> > it has enough space to do the allocation.
> > I think when doing unclustered allocation we should not look at ffe_ctl->empty_cluster.
> 
> I see what you are saying, and a the level of this situation and this
> line of code, I think you are right.
> 
> But as-is, this change does not contain enough reasoning about the
> semantics of the allocation algorithm to realistically be anything
> but exchanging one bug for two new ones.
> 
> What is empty_cluster modelling? Why is it included in this calculation?
> Why should it not be included? Where else is empty_cluster used and
> should it change under this new interpretation? Does any of this change
> if there is actually a cluster active for clustered allocations?
> 
> etc. etc.
> 
> Thanks,
> Boris
> 

I missed the RFC tag in the patch, so I would like to apologize for my
negativity. In my experience with other bugs, the interplay between the
clustered algorithm and the unclustered algorithm is under-specified so
I think it is likely you have indeed found a bug. 

If you want to fix it, I would proceed along the lines I complained
about in my first response and try to define the relationships between
the variables in a consistent way that explains why we shouldn't count
that variable here.

If you do go through with sharpening the definition of empty_cluster,
I would be happy to review that work and help get it in.

Thanks,
Boris

> > 
> > I tested this on stable kernel 6.6.
> > 
> > Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
> > ---
> >  fs/btrfs/extent-tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 03cf9f242c70..84b340a67882 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3885,7 +3885,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
> >  		free_space_ctl = bg->free_space_ctl;
> >  		spin_lock(&free_space_ctl->tree_lock);
> >  		if (free_space_ctl->free_space <
> > -		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
> > +		    ffe_ctl->num_bytes +
> >  		    ffe_ctl->empty_size) {
> >  			ffe_ctl->total_free_space = max_t(u64,
> >  					ffe_ctl->total_free_space,
> > -- 
> > 2.43.0
> > 

