Return-Path: <linux-btrfs+bounces-12705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95408A77335
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 06:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5763A188FB1F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89E61C8603;
	Tue,  1 Apr 2025 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="oP1pjSzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AXx5duxg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3368E86349
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 04:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743480285; cv=none; b=egApkN2oMedaTI5w9vInU/s4MaSMsYjkaBQOfHK4HCpbBUgqmuhxD4FBNZnYq08I3SrX2BFELcZ5hCyJztJQ1W4xPfoVoE6Ph2fZIApgspbCsyfcuh/sk06dGygQVufj0xnCXXVPvqkMYFO0GABfm0Y3jn2yFERqU4LlyzazHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743480285; c=relaxed/simple;
	bh=5YmN88sxm8QoMeQ+rAEEcaMS2MhSobnMREGAobswRBc=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IiwvHsMcDWj6hzr0Tt7Xu799pZn4m3/xDuwSob5MmUvITNANXK5xFJfQ6sqc4jQN38Kvf9/k5bjUQmri7srm4yKN4qX5WJAxU098ZXWIRfjYWv7qLZajmGZ143MnRl/Sv11sdd+mVF0Ts3LgYN1WzhuN0twxgwA/HfIVgSfMPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=oP1pjSzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AXx5duxg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 196F513845B1;
	Tue,  1 Apr 2025 00:04:42 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-11.internal (MEProxy); Tue, 01 Apr 2025 00:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1743480282; x=1743566682; bh=ZlRIyCz8RBld0iDXR7hxG
	T0Me9yFcH6SOr2CLTYyAVA=; b=oP1pjSzEvaEjiztlK5Zyfu2OlFB3lmVhwGYAs
	n0TTo6ydXOlFK5VPUctKCH8nONvSTSMZ5Dax7nj4Law4Sod2brrsHm9MA3i9uNWn
	Gxqs4Ao5ie7DZ3sVxB0uBS2qlprKmyAE+vS7gODhTQw6ON/zmmBeDKQkZ/sOsPuU
	D8WJbbLc/le9XKJHzzEpMlRPiFXS5MHPC/ajnVc69D+0U2vLHZbphP8m1y4dStdz
	v3zV61F0ZGoQ3Iekw3UOp+SuwvM0aSHD90RrLlBYkt0iMVXvqihr/yzKVf9u5gfm
	W9B2Lp4W/ZOnM6zKhqhgvXYn0IIe7HxRe6QHIHBShCVXbUovQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1743480282; x=1743566682; bh=Z
	lRIyCz8RBld0iDXR7hxGT0Me9yFcH6SOr2CLTYyAVA=; b=AXx5duxgq/2pWdYcW
	12UUsXSofPsAFfP6NFOZvZGjwchaHmK2Yt0fiY9Jcb7RT3hmEq4xzWKRsHv+ujdR
	KWYUctKagtOBW5Mf9jQxh0S7DDG3pQTVjnMT5Y96Vh+GIPBINuE0tJPw9uIf1nrY
	5QC61GGiUa4ZlN6T4xKHYiTIjmWO7/yIWtNL/lGfp7WrdMvxM0whHfXM1voOHg1X
	Dc2cV5KHmOEDbBliEYDTszXG2mmWoPpCe7qh6lX1OlZiY8/rg2edGQZSzn/9Y71x
	dKP2md5G0lfRAYLor6A39On4USsXYARPoZo7Cq6rZmb1AODqaXhsg/KBlEbLlUGi
	4StuA==
X-ME-Sender: <xms:2WXrZ7BDrl6MVs-Kwwl-RASzRzQVZxdotTpCh-yJvgwlY229p7v2ag>
    <xme:2WXrZxgOOS_njadz7iVlFTTgr0ILDVLJ6-TpfHTyevSIFiHrSysUq9Tv8PWPuKPCU
    WvMxqnYTL10jCJL56g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedujeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2WXrZ2nodCOdkH1iVpFGsPqM7yJsu5sVol9DF7B9YTrVZMwZxaMxSg>
    <xmx:2WXrZ9y2RLUQVSRIVpYd8Zw-Wvc53eiHlIel6Fbo5d4EcEUGqNAGqA>
    <xmx:2WXrZwRIn4FBFI8OOu3e9oeGcoPxEqeVuk4TjntUp09bxgRryCXJgw>
    <xmx:2WXrZwbeG6hO01s_aXgTnKT_esdZU04c_kE__zQsjRFLS_cctISfaQ>
    <xmx:2mXrZ7JBkTg6O2cB4AeDdDLRa7QvkuuGUA4lRtJxhfcVcXalOz6temF7>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D4421C20066; Tue,  1 Apr 2025 00:04:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T94110d4a53b0169f
Date: Tue, 01 Apr 2025 00:04:20 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Russell Coker" <russell@coker.com.au>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <834224db-bd52-41ee-bce4-599cf12183c2@app.fastmail.com>
In-Reply-To: <3349404.aeNJFYEL58@xev>
References: <3349404.aeNJFYEL58@xev>
Subject: Re: BTRFS error count 754 after reboot on Debian kernel 6.12.17
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Mar 22, 2025, at 9:44 AM, Russell Coker wrote:
> [/dev/sdd1].write_io_errs    753
> [/dev/sdd1].read_io_errs     1
>
> I have a test system which has a strange problem where the BTRFS error count 
> on one device (out of four) goes to 754 after a reboot.
>
> There are no BTRFS errors in the kernel message log after booting up.  There 
> are no log entries in /var/log/kern.log about BTRFS issues.  When I look at 
> the console as it's shutting down I don't see any errors being logged, so 
> either there are no errors logged or there are 753 errors logged in the final 
> split second before power off or reboot so that I don't even see them.
>
> This is repeatable and it's 754 every time.
>
> After I get the error I remove the device from the array and add it again.  I 
> can run it for days without problem with data being written to that device and 
> read from it without error.
>
> But when I reboot it says 754 errors.  When I swapped that device with another 
> one in a different drive bay the same device has errors and the other device 
> doesn't.  So it's not related to the drive bay it's related to the SSD.
>
> The system is a Dell PowerEdge T630.
>
> The SSD could have a fault, but if so why does it only show up on reboot and 
> why 754 errors every time?


These are likely old errors. You'd need to check old logs to see when the write errors occurred. These statistics are just a counter. You can reset them with `btrfs dev stats -z` and they'll go back to zero.

It's simple counter. It could be 754 errors seen one time. Or it could be `1 error seen 754 times. Or any combination of multiple errors multiple times adding up to 754 errors.

-- 
Chris Murphy

