Return-Path: <linux-btrfs+bounces-22263-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEFCEqcHqmlwJwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22263-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 23:45:59 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10C2190BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 23:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81D5B303205A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 22:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873903644D5;
	Thu,  5 Mar 2026 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="EgvSVOOn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Btw5cDYn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3435F166
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772750721; cv=none; b=N5ObZ79RCT1IzG8K9qXIdIepgLGkXe2IPaWTLg4fin2N02fQB3pC1Shne7HZ25KH3xC44Qmg0+MvwlLQnOfALPMVLEerhxvw2HOYe/z+4a+Z0jfLkqrqnMOGMEQT02Xol1Y3kFKZI+QcQOaOvxCRrlyUMiJL6cxVydOUqe2Jk70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772750721; c=relaxed/simple;
	bh=eOnqKVQvOW9/WQ0L18NvJIN3dIUQDNmoTteUsqdMUBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYEh9wPneyCKPSEDiJUAU7XanV7ynyE+bNnQzFz7MtSQhQygrZwJ9VVJQnVSPgA6mqPZ6y7HbfOLVS8uNsGU03o+UvQtV3qEJEvbY4pse90e7LiBsAPmJGNqSBWf3dPxCHe/dVX0Ey2gO0SpurWqoaIdiOehM9bNZyoWHV1Cqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=EgvSVOOn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Btw5cDYn; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 6ED0DEC022F;
	Thu,  5 Mar 2026 17:45:19 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 05 Mar 2026 17:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772750719;
	 x=1772837119; bh=Q5fpQF0WKsKxy3HOhYQ1rSBFkdMtOke4x4LF5xrTLZg=; b=
	EgvSVOOnq6Ho2zxt2kXYB/g44Hz72cNDxQdTfWoLKQjjnY9Z9r+BhXZR4S1sFN8S
	mkw9heuLAZcpTCxNaOclQcRhwrz/JwZWlNElir+VbBE9bI81HVsoAxcf4gTRrj76
	sYlIDxbpFrqluUyUQrC0q5Cw+meSMsIGJUtefm/5QsrMPUdxWNU9s3D/WDcBpQL4
	S/NdPWeysmx63OJnaofxWFuEGgbMmp4f6snMnL/H0ZZGAKzSzsh8jtW/q/nLjbhw
	w8boiTycUPtjsb0tWREDHHZSVeZsJgULzamVakAe5gP1rX1ZhpGv+XhA/n3SiA30
	sOz2CkxLlSzZJNnNm3wcfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772750719; x=
	1772837119; bh=Q5fpQF0WKsKxy3HOhYQ1rSBFkdMtOke4x4LF5xrTLZg=; b=B
	tw5cDYnc8SDUGELHLKYc6BGllrZ8OVmnjQT/GjiCWOITvLoUJPXgaPQ41ObcZpO2
	5VuInNdqyTR8nG7VFI3MNHLMlOrvTg1JZbcDJQt1pa6bdkVf83QIPecXMVai2/12
	ZOt2J+O/StREuLGjGaZvcYa/tIlw2PvJta/4fW3AjMWh9ECbOQDdImt+vYGUMR2C
	QSWKf5QI/nllUuGmamRxynlGCG1few2zYOY+BAle7+aXksw3OiUypW2fJG997dZc
	WWwCP+r2kaEtTcjt4kSooah83600aqhxK4NhrMPd/7TYYpSeAZA4T9NE62u1PPee
	bAdkLoM5qDGgMcVCASITg==
X-ME-Sender: <xms:fweqaW1MYhSm4MuFT6f7ULyUloL-FIs0EnXTJ6p41fI-6W_Lj-Mmnw>
    <xme:fweqaQE5L1z4IFYwuOynbyNcLN8CV1xsgWwBCzDmwX3oUZEOab4Hf3NnC-vDmAmKC
    SP3G9boL_E-KX-e-34r8PSaS8PRj75OD2owxbQAlgdmnJizmf6iRgLU>
X-ME-Received: <xmr:fweqaT45KIaStGXrGvpL87wxJFMe_VAp8VDHdrNMUkiZyep3jBs5aPU2JBPKBj-1irZNEw5XWIcp1DZXoy2lwpSoaEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieejieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopegush
    htvghrsggrsehsuhhsvgdrtgiipdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fweqaWsh1qQ_bvXR2cLw19ABm9ukuCITBZiNUfLXkIJAKFgzvZV8eQ>
    <xmx:fweqaU6SF9egqwZBUr926Q2NixfVUbpjLRHHP_30Ni6IYJnUZ3LMkg>
    <xmx:fweqaRWt-ZQUEpngB28Sw_R45YI71lmvzmkZrI0GAf6tVFiFLfFNKw>
    <xmx:fweqaW-jFg19dp3WHRtMwFARcJ-dLylnhB_D3HDeuPbBs94m36-Kig>
    <xmx:fweqaZICDL25yHX07IavfOLh41tX03jhYsTh4slRReI-CvLzZsTXJeRv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 17:45:18 -0500 (EST)
Date: Thu, 5 Mar 2026 14:45:58 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
Message-ID: <20260305224558.GA1293763@zen.localdomain>
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
 <20260305025611.GC5735@twin.jikos.cz>
 <20260305174609.GC926642@zen.localdomain>
 <63e3b64e-e344-4d90-bcfa-ecc686b85c5f@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63e3b64e-e344-4d90-bcfa-ecc686b85c5f@gmx.com>
X-Rspamd-Queue-Id: 6B10C2190BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22263-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,bur.io:dkim,zen.localdomain:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:13:23AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2026/3/6 04:16, Boris Burkov 写道:
> [...]
> > > So I stand by the reason of the pool but with the evolution of folios
> > > and bs < ps the cost could be too high. I can still see the pool for a
> > > subset of the combinations for some common scenario like 4K block size
> > > on 64K page host (e.g. ARM).
> > > 
> > 
> > FWIW, we do already see issues with allocation in compressed IO in
> > production, so I am hesitant to support this change.
> 
> May I ask how frequent the problem is, and what's the CPU arch?
> Finally is it only happening after commit 6f706f34fc4c ("btrfs: switch to
> btrfs_compress_bio() interface for compressed writes"), aka v7.0 kernel.
> 
> I tried my best locally to introduce extra ASSERT()s to make sure every
> folio inside a compressed bio has a ref of 1, but it hasn't yet triggered
> inside zlib_compress_bio().
> 
> Thanks,
> Qu
> 

I'm sorry, I didn't mean to give you the wrong impression.

I have not seen the bug you and Dave have been hunting.

I meant generic allocation issues in more complex paths involving
writeback/reclaim/page faults, etc that Dave was warning about with
removing the compr pool.

Thanks,
Boris

> > 
> > On the one hand, we have the issues so the pool is not completely saving
> > us anyway. On the other hand, removing it seems likely to make this worse
> > in the way that you predict, Dave.
> > 
> > If we do move forward with this, I will try to watch such errors closely
> > on the first release of a kernel without the pool.
> > 
> > Thanks,
> > Boris
> > 
> > > > And hopefully this will address David's recent crash (as usual I'm not
> > > > able to reproduce locally).
> > > 
> > > I'll run the test with this patch.
> > 
> 

