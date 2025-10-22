Return-Path: <linux-btrfs+bounces-18135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2546BF98E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 03:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D18DF4EB7F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 01:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE618405C;
	Wed, 22 Oct 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WJjCdYhe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EOJUrP5f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F363EA8D
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094935; cv=none; b=N3HCllSlzUzvtWIg39b9S1Z3jYHs+KfCyOtJyKnZVZcDjsFwQgRCY6FkFar1nm5plDXJNbcm09Pk8+3yluPfTTsvzNvSRpMd/WIZKzVuXF0v29B6He7E7Zs30xWorXqz+la47JGmjXS0hMUBsQmpBOaEksS7QKaGevLTPeaiG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094935; c=relaxed/simple;
	bh=fY1SrBcOp0lNFO9LiiaOT8P8XRdtwyAgSrSe4xAOmng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv+/+qrn7r8VW9+FwFWXNtILoYCMRzFFs5xbdK5f/9QV+1jszMgd8TcrmAkTh4h2FxAdu0UiKYW5jdB7Fyle3ofzjleIySttxrJ6YJJahGjKlF3SAmAZPKkxVtD2ZdZ7gz9HXsNFLsnOh31eXr3mrNre/bjcgpJkN4Lf4a5u6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WJjCdYhe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EOJUrP5f; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 72BE31D0014B;
	Tue, 21 Oct 2025 21:02:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 21:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761094931; x=1761181331; bh=z815DUGtfl
	Z/EiCWRl400DXiYKLruhjo/jDz1uX8Wkk=; b=WJjCdYherFbNal3VG4Nv/pKe4s
	bHJohgLWLMy1myNfiptkqjBqaDvRXxiaNL2Zji62ulDzD5pUYG8dQLVYBXJFinXw
	gAurMJF8zPjI+91PP7UY7L/USwvSfmTiGRE16qWAgKaowMQsqUfcwN3wKu227R5j
	+Sse6U1FtwtFCvlN7WrQhz+bKa5/Vh3qZz4f3cmi4s+qjZ0RlUX3Lv1671dof8a4
	RTkCe2OBYJsTHzEVYPTiXKxqjVHSYH3CsITIYUyflelxepCPqHEr4RYQ3tVU5au8
	MD2Ya3EcWTc9aYVHP3K5zArQkH8O0NDRmaRoFxZhthCUKhGG4Wt50XzNK8tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761094931; x=1761181331; bh=z815DUGtflZ/EiCWRl400DXiYKLruhjo/jD
	z1uX8Wkk=; b=EOJUrP5fMGbgsGctTn8q2hFz4nUpcWsm3yr9s4sRtoXvCcI6RYd
	occBzlL/Hk41rHQj3CW/P9bEWnykrSpC5xCYaQClSpkEONvp5YoWXSo7mMOxJ3R7
	W03M1NZgXJfEjPkCWYAqcMbmpA7lvxo+AXeaC1muXrKN0oyto9LE6n5WRsvp/JG9
	XopbdGFKlxzPN+h02kmpweR7mgPj3lWKc+HW9dmCNwgczYdXr6nDp1avnM2hpd52
	+x9sCQEOTVzAnbicrwX1aDQr80KRiwo2uSo1soD8xgC699sxq0Jya57YZn+BE/pK
	1xiQ3exolRSTpvR40z6tszbahI2xkGnfCaw==
X-ME-Sender: <xms:Ei34aA53VIutCHrKp1ZBzBRPpsiP-uUFlzh-veuduUYuQXH3ywTzIQ>
    <xme:Ei34aI4FBH6_IlTdAgQq1l91ESzqJvHEMQ1wgvSciLXUc_TXdCYS_zWbHnMaImUb2
    cCP0Rc4hyHXdy23dXqxH0gHenTQNPa1vvraJV_WRX0moWxHsdVZIY_z>
X-ME-Received: <xmr:Ei34aEf_hfUo8yn1w9puaLSmUD6HI6U4mvICTv0RHuMiqZknLfnE36raZtvhlxcC4iJMf2dXxK1U3IiHo2wv-cV1SdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhsthhssegtohhlohhrrhgvmh
    gvughivghsrdgtohhmpdhrtghpthhtoheplhhovghmrhgrrdguvghvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ei34aECJ-629vWCRqGB1vs97at0kPMXnoyVtfsTwn7wErYbucjwh_g>
    <xmx:Ei34aP8lqsWj5krBJd7LFAh6BDLWbAl8UjrRGq9Q0uuqVCOnLkIe0Q>
    <xmx:Ei34aHKVP3_uaVUzEZMJ5mLsyZJO7rPg6aAMsmki8YT0Ix_FwPi2BQ>
    <xmx:Ei34aAghWnceYG0wxrBjHPveSeeIPH2k9K2cWaLqq3sFUSX1eMfgdw>
    <xmx:Ey34aJ2MNaFnYNXVRQCdYIjSKU5YSMyXIyEyNi_lfHq-n3aabMwqVoMK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 21:02:10 -0400 (EDT)
Date: Tue, 21 Oct 2025 18:02:15 -0700
From: Boris Burkov <boris@bur.io>
To: Chris Murphy <lists@colorremedies.com>
Cc: Leo Martins <loemra.dev@gmail.com>, kernel-team@fb.com,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Message-ID: <20251022010215.GA167205@zen.localdomain>
References: <20251021224005.1087028-1-loemra.dev@gmail.com>
 <a254c33c-2a05-4e75-9c3b-12f823ebc8a7@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a254c33c-2a05-4e75-9c3b-12f823ebc8a7@app.fastmail.com>

On Tue, Oct 21, 2025 at 08:37:18PM -0400, Chris Murphy wrote:
> Thanks for the response.
> 
> On Tue, Oct 21, 2025, at 6:39 PM, Leo Martins wrote:
> 
> >
> > Wanted to provide some data from the Meta rollout to give more context on the
> > decision to enable dynamic+periodic reclaim by default for data. All the before
> > numbers are with bg_reclaim_threshold set to 30.
> >
> > Enabling dynamic+periodic reclaim for data block groups dramatically decreases
> > number of reclaims per host, going from 150/day to just 5/day (p99), and from
> > 6/day to 0/day (p50). The trade-offs are increases in fragmentation, and a
> > slight uptick in enospcs.
> >
> > I currently don't have direct fragmentation metrics, though that is a
> > work in progress, but I'm tracking FP as a proxy for fragmentation.
> >
> > FP = (allocated - used) / allocated
> > So if there are 100G allocated for data and 80G are used, FP = (100 - 
> > 80) / 100 = 20%.
> >
> > FP has increased from 30% to 45% (p99), and from 5% to 7% (p50).
> > Enospc rates have gone from around 0.5/day to 1/day per 100k hosts.

Leo, correct me if I'm wrong, but we have yet to investigate a system
where unallocated steadily marched down to 0 since the introduction of
dynamic reclaim and then it ENOSPC'd, right? If there is a strong,
undeniable increase in ENOSPCs we should absolutely look for such
systems in those regions to motivate further improvements with
full/filling filesystems.

There is also the confounding variable of the bug fixed here:
https://lore.kernel.org/linux-btrfs/22e8b64df3d4984000713433a89cfc14309b75fc.1759430967.git.boris@bur.io/
that has been plaguing our fleet causing ENOSPC issues.

> > This is a doubling in rate, but still a very small absolute number
> > of enospcs. The unallocated space on disk decreases by ~15G (p99)
> > and ~5G (p50) after rollout.
> 
> I'm curious how it compares with default btrfsmaintenance btrfs-balance.timer/service  - I'm guessing this is a bit harder to test at Meta in production due to the strictly time based trigger. And customization ends up being a choice between even higher reclaim or higher enospc.
> 

Yeah, we don't have that data unfortunately.

> > That being said I don't think bg_reclaim_threshold is enabled by default,
> > and I am comfortable saying dynamic+periodic reclaim is better than no
> > automatic reclaim!
> 
> So there are still corner cases occurring even with dynamic periodic reclaim. What do those look like? Is the file system unable to write metadata for arbitrary deletes to back the file system out? Or is it stuck in some cases?
> 

I would imagine the cases that are tough for dynamic reclaim are:
1. genuinely quite full fs
2. rapidly needs a big hunk of metadata between entering the dynamic
   reclaim zone but before the cleaner thread / reclaim worker can run.

> ext4 users are used to 5% of space being held in reserve for root user processes. I'm not sure if xfs has such a concept. Btrfs global reserve is different in that even root can't use it, it's really reserved for the kernel. But sometimes it's still possible to exhaust this metadata space, and be unable to delete files or balance even 1 data bg to back the file system out of the situation. The wedged in file system that keeps going read-only and appears stuck is a big concern since users have no idea what to do. And internet searches tend to produce results that are less help than no help.
> 
> -- 
> Chris Murphy

Anyway, I think Leo's forthcoming detailed per-BG fragmentation data
should be the most telling. System level fragmentation percentage
isn't the most useful IMO.

Thanks,
Boris

