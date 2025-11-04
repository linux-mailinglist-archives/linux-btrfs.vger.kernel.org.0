Return-Path: <linux-btrfs+bounces-18688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD5C3300F
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4158434B317
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153982EB5CD;
	Tue,  4 Nov 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="w7/ksUyu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cymz34Cf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FAD27E
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 21:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290566; cv=none; b=DUKfQEISrwpTC2nMDXbFKPq7scCNN9twj0ihi4jPOQqRPOBiuViq7SFRIzR8iwhbAGoy8ERA4XpOJ7E30zirLPikHaCI5cPqjES04KMOt6/F+h4rBLNDn3x2Qtn1XAJjRi7CsniSzAvgvGSmEGxoaLjK04Wcz4I8GO5vCrRdOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290566; c=relaxed/simple;
	bh=0ybOxKIqtLT1IZWv+8aCH/MFdm9cVasQLZhcDTLZdK0=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tWLoQy4NLCGtAY52fnluaCTMlrWIBv12gAgnjpRvJZWMTtdxieCxEthLzlOoCpXIYOeul/rIzDF4niYYE6RvNXAE330JS043TarngVt/LxyOczk0+rA+LjVzUAaKysYxMAFDd1qhgtWBGNrhtR3W5oiuPNI4NowjcCXNbv6c/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=w7/ksUyu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cymz34Cf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 694B1EC053F;
	Tue,  4 Nov 2025 16:09:22 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Tue, 04 Nov 2025 16:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1762290562; x=1762376962; bh=olmhSQmSXuOG04XybcRaJ
	xNvNegKi3b+6TLg94vQ5Zw=; b=w7/ksUyufiXJ5i8YGnTcpKgISHT7bKsG+65GR
	A/fVHE5nqAHXpAkxVazaL30xTIBYIxwVhOkkt68bSq6qYEudv/JYDaQBPJQdlDmH
	rzigCxPyVyjspu/uPMq/8Qyzl/EF6Y9ewOjTR4/0halE0xOzBW+32V8Iwoh8piF4
	LFnNzm+TTIIYn1AQPCpXLoZymg8BbYhcihmRDjlgksFu+frnFCWXAQ9Ae38i2PBU
	u39JE/Ez0my7evADhJ2SG6zal70d3XUnZVTG0OTzPgp7wSOXgfqRFD76UXNqtWdF
	sen07N7iwu0aSf5QXbwdldV7cc7J4xVDr0um4qoBJebLUNDEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762290562; x=1762376962; bh=o
	lmhSQmSXuOG04XybcRaJxNvNegKi3b+6TLg94vQ5Zw=; b=cymz34CfvlO0v61ee
	bQjmxM6LJssJfzF48drflkouTwYyYoJA8DuwWHytdZv0Qzod+qlcwoUD/xQUWqmX
	5eBfvRpP6G1CVBmaChGzuQTRAD/IIImGlyiuIO/BKo/cCNbn/DCdYRgCYVCgcyWz
	pqcGkvHR4sNUf3Af+Yeqy4WdqV06ofHkS5fbHpxtYhfW6cECNWRa+BfNsITt/roF
	43SqBPTMoIzKYwURY3TMJqoWJLXdz9u4BmVzpWYaQHECWGhzG1Ep+dKv3NbGq+8R
	u+p6bwF2gTbRpBrssMRwcbt+WbuvFmDBAT+kEFtINApmK0OE/q5NGtuO5eCo220a
	1jBGw==
X-ME-Sender: <xms:gmsKafDOJL8dTxr8Y7ItzTHSo2fdhIWaX24v7uW-SbbLOse_qu4zcQ>
    <xme:gmsKaQWQZjVCywdwUgQH6k9UKJsrMxsgGI3EaeoB_ItIWMXzhx2r-zLetV37D8kZt
    yHfN_f7SGnuEKGl1wxkx9ptkrQGBUtoJjxG_h6fySSV0cnqbWNMUTQx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepveekteevieffleeiudektdeigfegheejhedugeeigeffjeev
    kedttdfgleehvefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhr
    rhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehhvghnughrihhksehfrhhivgguvghlshdrnhgrmhgvpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gmsKaRvSAJLBKGNHIPj-QzbGrp-LML-PelXGOPga-nPZZht-St6LMA>
    <xmx:gmsKaYYA3Cm0yKxh13Cyeot9Xh2a9YothyY3BwwZ1tV1W03_wmT_ww>
    <xmx:gmsKacUacxTpSsNhYxsM3pbU9xQ3ubVvEfB-_6EsbmdpdSG_2eNHTw>
    <xmx:gmsKaU5PQ0D9eQcOBz9zqZ_5cSZKb1QY37LzbJlqoR4sboAtjNLU8g>
    <xmx:gmsKaWyN1JsotRiQF0LkNUboljRfFxB8Ct1ibEB1r9bWTP1B6WajtGCh>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F272818C004E; Tue,  4 Nov 2025 16:09:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVMxPOgRNBic
Date: Tue, 04 Nov 2025 16:09:01 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <0e8eb618-ffa6-4474-a890-c34119082451@app.fastmail.com>
In-Reply-To: <9b9fffc2-7a95-492b-8ef0-39195b1cdb61@friedels.name>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <9b9fffc2-7a95-492b-8ef0-39195b1cdb61@friedels.name>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Nov 4, 2025, at 12:26 PM, Hendrik Friedel wrote:
> Hello,
>
> any further suggestions on this one?

Maybe you missed this.

https://lore.kernel.org/linux-btrfs/9b9fffc2-7a95-492b-8ef0-39195b1cdb61@friedels.name/T/#m45945767cc18e4fc3add1a0b2b1f8cbec18178fc



-- 
Chris Murphy

