Return-Path: <linux-btrfs+bounces-2686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59173861C8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 20:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088D8B23363
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 19:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B89143C67;
	Fri, 23 Feb 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="YiL0o9c1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0y0t9U0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB45179A8
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716721; cv=none; b=Ji6CVgNGSRMEbKqyjEV7oRfHOCLADEGEr1XENrCCVsTMu+MjrfEHh3BR+sUKrngJpl50garbMf55QqdrX/4e0OMqqk7rYNhNWmckIFT76FtDHnTLwEoqScYHBeWiTaZNqEhUrhws+UwN8ZbElTebCn/KvLU50Ea9SI+P9lieYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716721; c=relaxed/simple;
	bh=6ZAGIuI6bsmRmrqQoI1PpXyC71RE+m97IyMR91frKi8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=DCuq9afbVSGygNk5m/vGTpujjXkosoX+nYgcnkBNn09tgvvWtcVVAfMVcN1VHDfY6LpJHp7P1h3lJVa8pNwOiFcLzjGJO8cqA3QOAg179WHU9S2GwS/c0Lmblg/YlNAe6IUIHtONfGw80bAAXhsI1UsuejVjYLoEHNe9kVm19qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=YiL0o9c1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0y0t9U0; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 890E35C0046;
	Fri, 23 Feb 2024 14:31:58 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Fri, 23 Feb 2024 14:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1708716718; x=
	1708803118; bh=p5PKEVg5YaBjUfu9gA2Wyjx/Lq0xmBaKjav8AFJrWyA=; b=Y
	iL0o9c1f8tmcNUv1OVurmkiBgi+fvRcOr+Q5+hdmMEd6xPRenqqZLzF0pjEWsJn4
	SIKSeZ2/bHcUO2hL5ygE5XTdb+eDp4D5kJV2tyNfg0PnViKkE2SsaQE/0nARrc2/
	uasUI593Kjxf6pYZXgaXPbyO9wjG4WWH73F4mWlkqWuPGTsRx3AV6wp8E2vJEzyi
	l2pIJ1H0TltQIo7ZgdApB2ZgH8kYxNlWUMZ8fkksc+mK1zLWQMboyJQl5Q7I0VOL
	lnM3ZRL70X6zZlWLZgh3sfyKUlEHz+AqrdzLCTfPeIEmhtNN7NlYzLm23DgDmfyk
	EIsEYiJk7x0iMviR4R00g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708716718; x=1708803118; bh=p5PKEVg5YaBjUfu9gA2Wyjx/Lq0x
	mBaKjav8AFJrWyA=; b=T0y0t9U0zOeQLyy8Jv32tPFbYFeWBa0sErADbctUg0lI
	3of52FNu9MMNdoWg17LSWs7zSyE3/ZOzWhb0GYBvA4+jbtrUpUtxHlponv4465M1
	DfWKAQPJ8vjLuXRFxeeepJK6sZCQZ7WNgBNOpUL5tpQwvCOQQ8iN8fVn8Vo9aYUH
	6lxOhzolim7CQsSmdKNALcE7DDD/jKhDVEpDgtD0XcSbzdk4cmGUXywSJd5jeGzX
	fS+TcD6WaxlBA8S0xIxRzYz17wH/mtHH0mT+IosZ/YQ14Sr48Jc1TEUUq67bEqmq
	cCYsvsQk2Qh6EnQo3P3vsKe/PC3ddxW4dCPuA0Mleg==
X-ME-Sender: <xms:rvLYZZgUKRiyWCHbZYNXMb0C8i4ebGB-MAkex57Cq0W9qhe2lASrxw>
    <xme:rvLYZeBwFEbH4Rna0t3fYjazUkCf8_Dm0wRkb_Kp1tcqD2ndkwcTiHZBIDdTApY_U
    cf-oRUSs4zb3MIHsew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:rvLYZZGn_XlpwKwrikJOjfuF-9XAiQ3k6MpCSYUvVmerrKA3LQQkpg>
    <xmx:rvLYZeQKHFKEOQMH8v1-JQFGO7tXCfHamIErI8K3qhNf47us8jBOLw>
    <xmx:rvLYZWw_LSbITrP0DAkGpQ38LeoKOR748nFkHNGOmW2UBZWRaJQ7VA>
    <xmx:rvLYZbvf4ZqJ2YX1qm2OWF9paghkBUgQ8zSWMvIIkJagVLxGDEsxcw>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 484D51700093; Fri, 23 Feb 2024 14:31:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e6dad062-0462-4b56-95ca-f5399aa5f565@app.fastmail.com>
In-Reply-To: <811716d2-fb98-4cf7-beab-c1960ee8c8e8@app.fastmail.com>
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <811716d2-fb98-4cf7-beab-c1960ee8c8e8@app.fastmail.com>
Date: Fri, 23 Feb 2024 12:31:38 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Matthew Jurgens" <default@edcint.co.nz>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: How to repair BTRFS
Content-Type: text/plain



On Fri, Feb 23, 2024, at 12:28 PM, Chris Murphy wrote:

> After removing the space caches, you should explicitly mount one time 
> with space_cachev2 


space_cache=v2

Trust but verify :D
Feel free to wait on the repair for a 2nd opinion on the repair. It doesn't sound like this is an urgent matter to repair.


-- 
Chris Murphy

