Return-Path: <linux-btrfs+bounces-18134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F0ABF97C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 02:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FCD3AB25B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 00:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016913A86C;
	Wed, 22 Oct 2025 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="o4Ia1niH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sL9+GlUM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16AE1A267
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093463; cv=none; b=GPv/IfCA87kmTnCPJt5sZGsiJWAm+JENyAyycd5p5a++tAXbJVXxjqdQItH0T/0SdOQpa/UkC+6TFJSBnV6gvMub1QJDnh+oawbgSzDZ7yhMguCt5mYAbfE3YtFkwIF9zlwv7OIVbiNSKGLe9EoJ5c6n9NQz/KlZO+H0TAULxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093463; c=relaxed/simple;
	bh=HErJTa9daZ4+GnRYWYR3n2I1zCBFMFjjnTMEUYKytMM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JmVbdyF52txc2LvzuUHqJ2t0BJiDHWm+yfWAXe7dcVv4PUUite/emEQb6IOgiqb/lfjGZ/Se6LQnXkp/qYblR3BMnQVQfCa3Ye7Vtw0kpygyUgjUfc1+EDBpRgEwM8Qvr7bZeMGy1IIwryNZNC8bQcZrgiD0nwhadVArTqzQHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=o4Ia1niH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sL9+GlUM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AAA87A00A7;
	Tue, 21 Oct 2025 20:37:39 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 20:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761093459; x=1761179859; bh=rMgYuAJrdL
	ELXjD2xYC9/bgkuavJUClt+Vun4WnJads=; b=o4Ia1niHkHoDMWc4Q4fLcI2LJW
	nEoCwkZwsKt8SwAEILAucmqA2mhFnXVD2m/XYYs9zZVhljRy/cVcyzpwWwvasQVF
	K59E0+gsfk6AOUUwB8fHCSrXgXjU84XCETYGXfrDvWpNl0t/EihCk8BCywS+g3VY
	xkkhCZ/i2rCeQAPuJm2WoYyUxxwiULqvyjM9L1ImVXl864358JzMs9ggrGMdNaYY
	D91cICXe4dvV+8u6RdLbCehMxExj70izvvkRLnTKL1iADPy/k231oGpsnvkLDOeE
	y3yERgmF4emC7peqt3ulGNVMJedqHuu5x0ykAKtDEODyHBwJglf4iJSF/BIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761093459; x=
	1761179859; bh=rMgYuAJrdLELXjD2xYC9/bgkuavJUClt+Vun4WnJads=; b=s
	L9+GlUMGljXr48uYBzVVSh3i4hxK+Cf7xsWVI76+x/6aXri1alC8bhMCv2icz3OX
	5wLEdZ42QmYJbQ1+GkSvzCNcRmJFLwTabIZ/U4JwRDQuGFqthNBCTdblcwKrOhas
	BH3kTGnvEVi6YJpyDNpM9WCec5RMQyiP1aa9XF5lL05N7bS4lOqauCVBfPN6ZvBV
	aXPmSsSVuauIEfjHwVFIE+wNbsRsEf8QT0RBKDYEJwdqe8hIW2bFVENNhn/YIbx4
	D/V8ulxCihsk6LESUauEHMbUZUIkac1FrlSl7aZW/UNQPzyF8AuaEBA+yYCimNSQ
	x9SuZwfaKVNjHMqZLkV7Q==
X-ME-Sender: <xms:Uyf4aJVXf8mWYgMqMht0z63WqZSskWGvm4Y3QdBG6jEW78k0l4bASA>
    <xme:Uyf4aEb80gJfyAOY72hF49bIkTLQLT7hBmhjDc8V2oizl9ElqeAY7P0M91yJp4y0e
    mUmvqSJbkmAY2OEqg6ilrsd3SB_CyL8FR967ORZKp08Z0mAIjEdutk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhuedvkeetudehgfethfevtdefiefgffehvefhveeuffef
    vddtgeeiffelffelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsohhrihhssegsuh
    hrrdhiohdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomhdprhgtphht
    thhopehlohgvmhhrrgdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuh
    igqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Uyf4aG-URABKYUKkgcSIYEbW0olA41UHqhEh8jVxLrCAkWm0c2fMIQ>
    <xmx:Uyf4aEj7Aqzdip8IxHFzDAKtnx8eUQ7iS0PKjQA3_hE6oPp7sWZm6g>
    <xmx:Uyf4aGfjqK4kHDmIDfkBrtucKWFTALLwENk6-gZc1AP6q95gOYXHKA>
    <xmx:Uyf4aLqqwV2ctF1L627Fm-3rcDcSI8nvSOoZ-amJKGV3aDjEpLTyQw>
    <xmx:Uyf4aN7dJDvCzg3IZmDxoqsf8hjtKtYlClRgwf_0FFnXlWyjsF84MHmP>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EFA5918C0069; Tue, 21 Oct 2025 20:37:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsRwXutkemSN
Date: Tue, 21 Oct 2025 20:37:18 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Leo Martins" <loemra.dev@gmail.com>
Cc: "Boris Burkov" <boris@bur.io>, kernel-team@fb.com,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <a254c33c-2a05-4e75-9c3b-12f823ebc8a7@app.fastmail.com>
In-Reply-To: <20251021224005.1087028-1-loemra.dev@gmail.com>
References: <20251021224005.1087028-1-loemra.dev@gmail.com>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks for the response.

On Tue, Oct 21, 2025, at 6:39 PM, Leo Martins wrote:

>
> Wanted to provide some data from the Meta rollout to give more context on the
> decision to enable dynamic+periodic reclaim by default for data. All the before
> numbers are with bg_reclaim_threshold set to 30.
>
> Enabling dynamic+periodic reclaim for data block groups dramatically decreases
> number of reclaims per host, going from 150/day to just 5/day (p99), and from
> 6/day to 0/day (p50). The trade-offs are increases in fragmentation, and a
> slight uptick in enospcs.
>
> I currently don't have direct fragmentation metrics, though that is a
> work in progress, but I'm tracking FP as a proxy for fragmentation.
>
> FP = (allocated - used) / allocated
> So if there are 100G allocated for data and 80G are used, FP = (100 - 
> 80) / 100 = 20%.
>
> FP has increased from 30% to 45% (p99), and from 5% to 7% (p50).
> Enospc rates have gone from around 0.5/day to 1/day per 100k hosts.
> This is a doubling in rate, but still a very small absolute number
> of enospcs. The unallocated space on disk decreases by ~15G (p99)
> and ~5G (p50) after rollout.

I'm curious how it compares with default btrfsmaintenance btrfs-balance.timer/service  - I'm guessing this is a bit harder to test at Meta in production due to the strictly time based trigger. And customization ends up being a choice between even higher reclaim or higher enospc.

> That being said I don't think bg_reclaim_threshold is enabled by default,
> and I am comfortable saying dynamic+periodic reclaim is better than no
> automatic reclaim!

So there are still corner cases occurring even with dynamic periodic reclaim. What do those look like? Is the file system unable to write metadata for arbitrary deletes to back the file system out? Or is it stuck in some cases?

ext4 users are used to 5% of space being held in reserve for root user processes. I'm not sure if xfs has such a concept. Btrfs global reserve is different in that even root can't use it, it's really reserved for the kernel. But sometimes it's still possible to exhaust this metadata space, and be unable to delete files or balance even 1 data bg to back the file system out of the situation. The wedged in file system that keeps going read-only and appears stuck is a big concern since users have no idea what to do. And internet searches tend to produce results that are less help than no help.

-- 
Chris Murphy

