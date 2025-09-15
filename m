Return-Path: <linux-btrfs+bounces-16843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339FB5881B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 01:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051E51B22CB9
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 23:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C235966;
	Mon, 15 Sep 2025 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="KhHK25KM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWBCyRfl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7C2566
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757978229; cv=none; b=PnQ2s5Lkk9Ez7av7A7OH6W/t48hlfQG6HVBna6vIh83eJ9eMjnOK5VOW0a0+0ch6htFnGinuDyQUBRyDT8eUOD4SW4mgTsGfX6UYViENj0UhfjMp/rA+zYmk6GiN0keujVZNMFWUr9XgdPy/wJ+tTsBtl0YvnM9QbThak+3870I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757978229; c=relaxed/simple;
	bh=dCU4rzP2zqtkQ8egRE84PeDOOOcWn2/GIU5IknPLCls=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c0k+ECCEn0EORh4M6pVaJO6tMId04YlZHKI6CChlXeEJ7cELixoiMDXriAF8q+qqEJgR268qbiZ0smMSbK26PIrqzKxN5hhSt01I01pllpCoDEHISTyLotRgo89fDVZsjFrsasbTxOxdyvY/zjEp3aCjf7nb+ELnSurSsh9LbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=KhHK25KM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWBCyRfl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 15A507A01AD
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 19:17:06 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 19:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1757978225; x=1758064625; bh=Ljqjd2zeh06BYhTFjG7PH
	vunarTENaa3ywaTj+oQQaI=; b=KhHK25KMESTnHsLmVK0BHJMpoOjida92uykdP
	gdH89a/pC+vUSmLWSBoi/EAdQiByYp+xE1EPj+WRMiy97/PPzOQ2h9ZZjJJNc0bO
	o7yojFrWr1r+l7/Sq8xxZg1A/DShuQyeTK5iOPpSRatreVx/k7AiMJHp16JWB3te
	mNvAv2Koxp4cPiDk02s30oSHtcQbDsABk8/xn8ZUbfyf6bFiejBRBELNxDYjR5M5
	+t1F63nkTSr0FDXCqAx0Wvd37Z0zaaxtbRYmt/fxASEfNZbxbTEGrjcS5z0Z7W7h
	DSr/BLcZJCqB1JnD1C4Tv7SPtQ6Q5YtVmRZ/AkJZC+Tf+Vw3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757978225; x=1758064625; bh=L
	jqjd2zeh06BYhTFjG7PHvunarTENaa3ywaTj+oQQaI=; b=nWBCyRfl4YgtOfRo4
	8B1cnyrVDz795XBW0ll3rkzHkWizceO2nLRIcxx1zstjHqRT1k4/j6Ya6smYvVBB
	fI80JkHAdB1SA8PRoFWa8fOHKRcxJU9KoFhQV+kgp8WAWM8QZcW+7MA9UrFrFY8i
	C4eP/PAcHzpdn3/A00yIyvFQFBxzM73mGKwPPL10FgU1kGw2z2Q9Mj8i3ne+ezHL
	ltmwgw0bnfLGzrs1/5BNpj2b9fzkiFSTpn5TJBOkrq0ATLqv3Xi9qEFM01zWfU/r
	65rDkJBFowsuxzwsGoD/RoYxtRjIRLLvdGivRXeWwFi+pxqbwiPhGEcx7gYe7s2E
	Zu1CQ==
X-ME-Sender: <xms:cZ7IaGtVFy1jS6KrrFMDAjozbTXVOLRN2PXMMmp0puoIYVjBwQn_Jg>
    <xme:cZ7IaLecR_rDKjUY1h-kZWtMFT4BdvG8_4kauodG6L6ysUDfNNLvK_0RZV3jD1AnQ
    FOJrLymqId-LLkbikA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcu
    ofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeuvdejjeevleehjeejhfehfeetfeekffeuhfdvvdehveejveei
    ieefffffgfekteenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhr
    rhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:cZ7IaLGAnGATDydZXTvzBTw8FvymZoji36JPDAYdZwOD-EnYwvHq8w>
    <xmx:cZ7IaMnGkoCAP_X95npBvec6UasCUrC8QUebBbzNtCTbh5AFr-_3-w>
    <xmx:cZ7IaIImDu6HT_1T1gkMOZmaltTLCpBR7e8r-dgV4lU39U-Bbt1gmg>
    <xmx:cZ7IaNY6dl0C-HBkJWNTQLI4OIFa5PtaXL5_XSrLwBC2vmzcrR_mlw>
    <xmx:cZ7IaGNe5tJAw3w4YruaQx9r0n7v6XitBSY8GqzMD5_1hZyiyqDxHzd0>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9C2F718C0069; Mon, 15 Sep 2025 19:17:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYAte_pFYg7k
Date: Mon, 15 Sep 2025 19:16:43 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <dcb5d446-adaa-4a6c-b212-619d286d01ad@app.fastmail.com>
In-Reply-To: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The storage stack may be relevant: USB flash drive -> dm-crypt -> Btrfs

Darrick Wong notes that in https://elixir.bootlin.com/linux/v6.15/source/fs/btrfs/ioctl.c#L3159 

btrfs_ioctl_scrub calls mnt_want_write_file for the duration of the scrub, and mnt_want_write_file takes SB_FREEZE_WRITE and holds that all the way to the end,  which means you can't fsfreeze the filesystem

So how did this ever work? Folks do use btrfsmaintenance with scrub and trim timers, and a laptop can sleep at any time. We can't inhibit this indefinitely.

Perhaps scrub and balance can be paused if pm suspend/hibernate is requested? Just make it a non-factor.

Chris Murphy

