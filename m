Return-Path: <linux-btrfs+bounces-12730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683A8A77FC0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59870163B36
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB26F20469A;
	Tue,  1 Apr 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="SGaxMz/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nnGjhsgd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA321CAA62
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743523258; cv=none; b=XEmdw6OsMrVIIM4mVXHNmQVQmT3bYouQ5bFoOOvh2NuuLxsUPO4ldY+lp/wml1amo29vElsF2aBSMW95vlbtxGi/BhVfNNE4/tTPxsvSLjpXb5l7YLhU6GJfgk2NBfOb4hdYT4I9/DqT10UScL/TuJWY8sGgYD7BGJxYTm0n6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743523258; c=relaxed/simple;
	bh=WwvhzloBISebKvFdt1A0uHt9B+0wWmIefUp8wVuvyeg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YWW8zl4jOF2cqOiSTmU4QmZZscv8YwioZ75ogzdhA31iiTAxfzWOM9CWALzGrKSJS/TNS3ta0tgJYEtatx6wmZtCi6sgWSOJZ5jxMFQYM9+l5RHpczfJL08CIz452hnhfY3o3lb2mQ/Qty6jzRMRt8BB+DouKLqmlReFvXAYlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=SGaxMz/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nnGjhsgd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B7D2A1140267;
	Tue,  1 Apr 2025 12:00:54 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 12:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1743523254; x=1743609654; bh=3xeRDnNLFhZGZoNhmSzBr
	ZD57i++sCFGzTNsA7Hxz8w=; b=SGaxMz/yaRHlo6kcXW+cFCkic7s8A2qw9vMah
	5liZjiNTDZv18mYqORKd23QwYZAGf33OnaAb5XCYW2z9xUwgwfY2qBcRccGpyewh
	5VKvHbd2/mJjkJk+4xctBm2rzqvQ4/YbO/ElCBauloTMI/Hfibc5tRojveK3Jg08
	3ROjqoweZpN5o1I1sYWCvOSFVicnnuSxoftkhw2jjbcFdgPB0lL9052DYfRb8skU
	70WyWCuLd5Yu0n2OTO9IrKEQnqD8LCfTZrLM0Lpf3oxhEpgujw5b0ewrR0U1GKtf
	pwJkoOFEZwOO4ZlCaAa7DR7XxMa2iH6xsWtcJDGUFOw+fhYWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743523254; x=1743609654; bh=3
	xeRDnNLFhZGZoNhmSzBrZD57i++sCFGzTNsA7Hxz8w=; b=nnGjhsgdNxjsJ/sZj
	D3KIQ9nqj0MwMjph7Voy5oGK27DAHbufUN7G5qAtaoI1BINtg4QW41ioJymzlIiq
	0SFX+gyNZSzTkE6vVZTBLG7tje4gtzxj64kiwuN32s1+iAphBkp5jkLdJTgeDrci
	LGq/qI0EI3Ym4jInPU1TNY9uCr2gVqJK8bfaoGyKKbVOi3jnfimL/4h159fBUvcL
	iVWNWuGEagNHTe1CVKhewPs6e86rKXAiro8ce8TWQn8G/lm/KJ4bzqwwym0j9QCR
	GoAe/Q30qe+3mpFAA6h5W5gMoIiu7OAGvHlxLiTuLFPHM3kk0kgNtTD70AY9gD0N
	r0hPw==
X-ME-Sender: <xms:tQ3sZ2G_KKon9XzvhVzG5ot2M-B6zyliP_la8cyOg1v36XJ4pc2HXw>
    <xme:tQ3sZ3W-rOIej3UfcsKPCJnQj7mLu1m3LvssaARR7TncqsCyeoQXPe0tstk9Zcgbh
    qbhoeNQPudXD8nJCaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorh
    hrvghmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepteefudehkeehgeekhfdv
    gefhjedvveeuhfdtgfejgfevieeviedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghmvggu
    ihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprhhushhsvghllhestghokhgvrhdrtghomhdrrghupdhrtghpthhtoheplhhi
    nhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tQ3sZwKO5rdKWKRB3SqWR7Ot1dOROuvsmeW35nYrtcGGqFeYxRm2Xw>
    <xmx:tQ3sZwGve1uarintC0qYIh3BywkZZK0GOUZWm90SW5uYvmv_JFgEfA>
    <xmx:tQ3sZ8UtFIKruOifsq50q2tMLNWnLZ7FHgvKCiSPGPBomeX6mYFFQw>
    <xmx:tQ3sZzMXOQxg35Z3K6BjFSj7hUpYTTIzX08OgZEgJvftqm6nJxuPog>
    <xmx:tg3sZ3c5H6IQwrFpdEN2So0fdnW2-BKzraBD-sWlxWxgkXvRprQ9yhtK>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92DFC1C20066; Tue,  1 Apr 2025 12:00:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T94110d4a53b0169f
Date: Tue, 01 Apr 2025 12:00:33 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Russell Coker" <russell@coker.com.au>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <7b155ed6-da59-4560-9e2f-1ffa0143d84b@app.fastmail.com>
In-Reply-To: <3682098.taCxCBeP46@cupcakke>
References: <3349404.aeNJFYEL58@xev>
 <834224db-bd52-41ee-bce4-599cf12183c2@app.fastmail.com>
 <3682098.taCxCBeP46@cupcakke>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Apr 1, 2025, at 1:18 AM, Russell Coker wrote:
> On Tuesday, 1 April 2025 15:04:20 AEDT Chris Murphy wrote:
>> These are likely old errors. You'd need to check old logs to see when the
>> write errors occurred. These statistics are just a counter. You can reset
>> them with `btrfs dev stats -z` and they'll go back to zero.
>> 
>> It's simple counter. It could be 754 errors seen one time. Or it could be `1
>> error seen 754 times. Or any combination of multiple errors multiple times
>> adding up to 754 errors.
>
> Is "btrfs dev stats -z" covered by removing the device from the set and adding 
> it again?  If so I did that but it kept recurring.  The fact that the error 
> count was there in the first place wasn't the unexpected thing, it was the 
> fact that it kept coming back and had no log entries about it.

Removing it with a `btrfs` command? Or physically disconnecting and reconnecting?

The statistics are per device, persistently stored in the device b-tree which is metadata block group. So this metadata could be on any device in a multiple device Btrfs, not necessarily on the device that produced the errors.

I'd like to think upon `btrfs device remove` or `btrfs replace` the device's stats are also removed from dev tree. But I haven' tested it, and I'm not sure what the code says should happen.


-- 
Chris Murphy

