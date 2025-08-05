Return-Path: <linux-btrfs+bounces-15871-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB3B1BD1F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 01:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F018A8159
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6652BE054;
	Tue,  5 Aug 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hxzFYBZd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WaM1At4H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044FC29C347
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436362; cv=none; b=jv5soDlD0XFEyBpyKt/tE48cxBfVVSn0QW6ZHYTsaAWfYitBjIzhTmT7r5utvhwFtTHRB3otMaM/iOER2sidkksf3/A/Dh7JWFEguBH+5OMh2xEFe36PjK4CcJHxMypdlGV68RzgVFDF404/W746l9UuOQJ3xeED8cb4EaTr7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436362; c=relaxed/simple;
	bh=nOxg2V+b5yFc6FNnjOx5J6jytyVKIRrVvnJ8Uj6iTXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esRmbX295XiUL0mKm36R9uanrBW2JaeRKrIW27+QHmZUed3EHd69kSmcRLm60gDC405Dwgn6QRI3EjOEc5gYdyHw0uu4MxzIExJQO9apCf4z0ccD/09ayH4cKO850w2ErQ5iyRe0ztgmsuUFJsX1DYtMhJJyeAhCUo6VHKTY6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hxzFYBZd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WaM1At4H; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D87561400162;
	Tue,  5 Aug 2025 19:25:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 05 Aug 2025 19:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754436358;
	 x=1754522758; bh=fJDaAn8wKKf8hVBfN3tcAYUDE0Q99EQgM1pvegv1mbk=; b=
	hxzFYBZdH/Av0YOxCqsd0s+BHtNnfM7EaDOmy/F/X5K06eHdjFl3pqs55PBTHnrx
	PHrsyV2Mtv+XRvwLHbQM+k1JnkGWiangwVvt8+zyFSd0RHs0aqs3cvXv+e/liKDB
	FWcQj2aog1YkvSQWKa2Oi694l/JktPpdYmiqbvLuHe1Hgi8sfRa1VpO1uWbsxIWI
	R/RyxyjZuy4mxq7ZfOFrE/rHzmEkF8FJfvTI0WmBNFXoojoINxduzN5ofxTv/4wJ
	xmbB6Hw7yjhsxGVSEpn2BiYP93pMA88lMEGTwu5rLhnxuXJPfRKk5WdQ5ChYcFvp
	HyuE4kObwYMYZhNVz4MOFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754436358; x=
	1754522758; bh=fJDaAn8wKKf8hVBfN3tcAYUDE0Q99EQgM1pvegv1mbk=; b=W
	aM1At4HQNJNoG++aLCJ7nVQEDGk5k78Dc9naYm82TMly3eSzqvX3jTJ243EdRk2C
	xzbciUCdIK9aGuWNErgrpUnH8tW3Aw17EyzISpov9mPSrj5d9wfLV1Cv5xV8EcHD
	qnUAK0bCQ0lVQOHferLyhu+Au3x+aHbL2wWYv8dIfMKsaJvvzmgbMShsgmcnoqnm
	mcgqYAZpFV6h7e7dVPSEQONKFNK2oxhiqAuRY5obc4332jKsP4mDNuAdjHqQ9/4/
	3oFqtKdcUDYbo+MucVhQqzldT9ZQGJ7/MRHDu4arfVi6W1OKW6XMgmaLQ9kO/48E
	2L+vxKW3pm5Mru58EYVgA==
X-ME-Sender: <xms:BpOSaHBoN2x5auEiHKhNS7hoB2rrZr3zSL1tzc1zyvqeZgi_3O68gg>
    <xme:BpOSaAwgKnfTE47izrA6h_SMIN8s00GGgdSPOUqGSqVi9OUhR4EmuSrzQnCMyx3U_
    7aboHwZ5VMOgDSb30A>
X-ME-Received: <xmr:BpOSaMDwlHFgMvr0Cof3eLL17p0Y1Uml7hWZTpDAvoeyKCnYJMq1vLF9vBbKGvvzO0LKHGWgpCWahearutSTaqiOr7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehquhifvghnrhhuohdrsghtrhhfshesghhmgidrtghomhdprhgtphhtthhopeifqh
    husehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BpOSaFZ9GAjrnnMHVgcO1TlSFfpVFRQFBuhBflqlgwGzq-0S_0su5w>
    <xmx:BpOSaMgi4pwWl70bh-uUqKEC6WY9Ip5u49xnF-39tde6GpeCSkWeuQ>
    <xmx:BpOSaP6Iu-Uh4TrjmgyYTva5Hw6jHi6O1fCKt5tqh4dlVYjz48DHxA>
    <xmx:BpOSaL5IRD81lZ4EulNz1RxMVBLuWq8981Ycf44tTXulFSvz_nMEhQ>
    <xmx:BpOSaKHWO6Q0y1dMMkSj0-2Sf_qVTkGXAnzlXUUAuNF47eM2TJQDJvFI>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 19:25:58 -0400 (EDT)
Date: Tue, 5 Aug 2025 16:26:56 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: check for device item between super
Message-ID: <20250805232656.GA966775@zen.localdomain>
References: <cover.1754090561.git.wqu@suse.com>
 <20250805193458.GD4106638@zen.localdomain>
 <4656f4eb-3189-4283-97e8-5d56a0946763@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4656f4eb-3189-4283-97e8-5d56a0946763@gmx.com>

On Wed, Aug 06, 2025 at 08:23:33AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/6 05:04, Boris Burkov 写道:
> > On Sat, Aug 02, 2025 at 09:56:18AM +0930, Qu Wenruo wrote:
> > > Mark has submitted a check enhancement for progs to detect the device
> > > item mismatch between super blocks and the items inside chunk tree.
> > > 
> > > However there is a long existing problem that it will break CI.
> > > 
> > > The root cause is that the CI kernel lacks the needed backports, that on
> > > a lot cases the kernel can lead to such mismatch and being caught by the
> > > newer progs.
> > 
> > Can you explain why we are contorting around out of date "continuous"
> > integration? Shouldn't we just get the CI on a new kernel?
> 
> Because the distro used in github CI (ubuntu LTS?) doesn't have a proper way
> to install the latest upstream kernel.
> 
> Thus it means a lot of btrfs-progs self tests are out of our control.
> 
> I have a crazy idea that we include some read-write fuse implementation into
> btrfs-progs, and use that fuse implement to replace kernel btrfs, but that
> will be a super huge project.
> 
> Thus we have to workaround the problem for now, and I believe the github CI
> is still a great tool.
> 

Sounds, good, thanks for explanation.

You can add
Reviewed-by: Boris Burkov <boris@bur.io>
to the series.

> > 
> > > 
> > > So to merge this long existing fsck enhancement, this series refresh and
> > > workaround the problem by:
> > 
> > Thanks for putting in the effort to get the enhancement in, by the way!
> > 
> > > 
> > > - Only reports warnings when such mismatch is detected
> > >    Such mismatch is not a huge deal, as we always trust the device item in
> > >    chunk tree more than the super block one.
> > >    So it won't cause data loss or whatever.
> > 
> > That makes sense to me.
> > 
> > > 
> > >    So even if the CI kernel doesn't have the fix, self test cases won't
> > >    report them as a failure.
> > > 
> > > - Workaround fsck/057 to avoid failure
> > >    Test case fsck/057 is a special case, where we manually check the
> > >    output for warning messages.
> > > 
> > >    This is originally to detect problems related seed device, but now it
> > >    will also detect device item mismatch cause by the older CI kernel.
> > > 
> > >    Workaround it by making the keyword more specific to the original
> > >    problem, not just checking for warnings.
> > 
> > I'm a little skeptical about reducing even the incidental coverage of
> > the test except for a good reason.
> 
> Yep, that's the biggest problem, and I do not have any better solution.
> 
> We either:
> 
> - Find a way to use upstream kernel for github CI
>   But it will still cause check errors for newer progs on older
>   kernels.
> 
>   And I failed to find a way for that.
> 
> 
> - Further reduce the severity of the dev item mismatch
>   That's possible and workaround the fsck/057 by not outputting
>   "WARNING:" at all.
> 
>   But that also further reduce the need of dev item check in the first
>   place.
> 
> - Workaround fsck/057
>   The way I choose.
> 
> 
> - Use fuse from btrfs-progs instead of kernel
>   The ultimate but the most time consuming solution.
> 
> Thanks,
> Qu
> 
> > 
> > Thanks,
> > Boris
> > 
> > > 
> > > With those done, we can finally make CI to accept the new checks even
> > > the kernel is not uptodate.
> > > 
> > > Mark Harmstone (1):
> > >    btrfs-progs: check that device byte values in superblock match those
> > >      in chunk root
> > > 
> > > Qu Wenruo (1):
> > >    btrfs-progs: fsck-tests: make the warning check more specific for 057
> > > 
> > >   check/main.c                                  | 35 +++++++++++++++++++
> > >   .../fsck-tests/057-seed-false-alerts/test.sh  |  6 ++--
> > >   2 files changed, 38 insertions(+), 3 deletions(-)
> > > 
> > > --
> > > 2.50.1
> > > 
> > 
> 

