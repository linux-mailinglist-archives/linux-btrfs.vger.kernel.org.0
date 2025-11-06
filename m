Return-Path: <linux-btrfs+bounces-18753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13417C39178
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 05:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D68F3B9AE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 04:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049922C17A8;
	Thu,  6 Nov 2025 04:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="P7AwrkJ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ysl+b9rh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265718DF9D
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762403195; cv=none; b=meaNpoY54w89WaL8173Z6rTlQwiUAm7Q4Ebvce3aoSTfpESZ2f0BGbi06VZKu/QWhE3I2Q/A4/hfi4qBsyyvZDAMwc91YrvPtv1uZMy9fZ4WIo2cqbRHX4P8s4HnyAfHdcg+mC+ffUVyG6UXsONiCSV/NIhbXDSShezxCygZdAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762403195; c=relaxed/simple;
	bh=H+UT7Y1uEkM1FCyptUDOCLDOOg9mrl4/WQ81jxAD/5E=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RtZ5n9bej/KmWSKtxcE4EwNtxIH1g5ExDgtE4oc81vV3IgKsLhB60fpmDb1fByxbs2uOkwvBbZ9RXHaYNMpeA3eX9H+SLFhdaixaqkxXXV483l9yRpP7XaiXOUNNnp3qJngR2Pd4WEypsRwOEGftckWa7eCKgDFLBnvrvfmkyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=P7AwrkJ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ysl+b9rh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 666221400025;
	Wed,  5 Nov 2025 23:26:32 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 23:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1762403192; x=1762489592; bh=Laq5hBgVbEoXQ7n72lPML
	cMbFFbT1huESPeSbA3FvZ8=; b=P7AwrkJ2LJZkCeXKMw03fV0nGz2Dod6sLj3ny
	LBpNt6Dt8CbYZbdJn4e/3r02EjX0ri3qEr2jbYEEsxpIYJissYoxW/OrDu9+OXKs
	CEA0/t1Sjj+Z63/9uS9Ym2WdyD8a9vYEWcRI0w9VnV11zV43C3fVTMRI+jdBOcVn
	5l9W129eDAEAgcLEoFXr9IwzkeNrDmeI7LRCljxcKknn9IUoDBrk8Pvp28k3DAmh
	Xx8SZhIo4tMu5yP8eEaAZgksxd5Novimo2yZM5MZdWAsBadXmTqnQcfJK4u7NLjI
	HwaSusLE7J6/10Ou5wdlo6H21+3kYUaUyFp5kvxbpE3VroFEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762403192; x=1762489592; bh=L
	aq5hBgVbEoXQ7n72lPMLcMbFFbT1huESPeSbA3FvZ8=; b=Ysl+b9rhR3pU3iHJr
	FpZB1I9Wm1WWFh7YL3/BJwb3dXdY4Zn5zHREJw5nxj6d3wgZD8vBbjk2eaL7i4vP
	/23Wqj3ycierZUN6WpqhGVhFVpOAXQiz5PMnF4dmV8ACfbrgl1zCRwJOYV+6yNwR
	NBEMNs4kld4EBsZEYN5qeT1Su9r75+ugEkKeTjdlqELvSuatANGwweoTGS2JJ2Yj
	KvE1+AAn+pVofmHW773KmPt8sjslnPV74kKvx5E9Drhlolu76vcwhbocmvODeFRr
	jko19Q7bbyZgjCmGELZF9IrBBD/A9V/Vtsd4t4Fi/1k27LK6T8qBrY1s1H7SeG4R
	NEADw==
X-ME-Sender: <xms:eCMMaZ1w5B5poPNuGcm6Vm1OmC3my_uOW441dxQ-47aUlnpcziFmpA>
    <xme:eCMMaa7UuzYbHJy9_4SW_U-8LmeFY4sxtJXQk3x1EsyBD1mocqXasqBu2Lb8m1xMy
    UlPSGtdktxL4CBdlAWyFpdplMMV4prcT-bU41OGARyEIlBAdfz7xzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefhjedvveeuhfdtgfejgfevieev
    iedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgvnhgurhhikhesfh
    hrihgvuggvlhhsrdhnrghmvgdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eCMMaQg5UIPySvCUmhF-DR-uWX6Hl6QKzJrgrYIEOrg_3ZRbek978Q>
    <xmx:eCMMaW_Bn6fmrRaIVA7Z0Mc443a3-oljtTAy21D1UYPK8YceiaPq0g>
    <xmx:eCMMafqT6WTvqELrEVvv-3UVy1OP1Li0st3PV8YwpYYTk1vzmhOYUQ>
    <xmx:eCMMad-IdqbIqaHrrF3ipgYsWr3JxFQYimis0PL71TrlNjsrtOvWmw>
    <xmx:eCMMaU3Zo5s05Q9WC-JcVcDB4EseNKqGO4qoG038uAK_0LmQi1fdv1aL>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1459918C004E; Wed,  5 Nov 2025 23:26:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AVMxPOgRNBic
Date: Wed, 05 Nov 2025 23:26:11 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Hendrik Friedel" <hendrik@friedels.name>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <9efd0399-62c3-4800-81c2-761c53592540@app.fastmail.com>
In-Reply-To: <27964904-b200-46d1-87c6-0dc5d8174036@app.fastmail.com>
References: <cfc7539c-a0c5-45d2-a781-89c2e0cb2c62@friedels.name>
 <12716866-2ffe-4cbb-8e2f-8b2e4abd0237@app.fastmail.com>
 <a37cea05-f77f-41f1-8763-a28311b72790@friedels.name>
 <f6858f97-1fe2-49d7-b1ad-dc688142fdcb@app.fastmail.com>
 <eddf3273-d7f9-4bef-865d-dfec1d7ffb66@friedels.name>
 <27964904-b200-46d1-87c6-0dc5d8174036@app.fastmail.com>
Subject: Re: Corrupt Filesystem (Mirror) despite previously successful scrub
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


>> - what could have caused it / what can I do better in future

A bit more on this, in addition to using more recent kernel and btrfs-progs, and finding problems sooner with monitoring.

When providing logs, most people on this list prefer raw, unfiltered, uncurrated logs. Seems like providing a lot of junk, but the thing is, problems with file systems tend to involve other areas of the kernel or storage stack. With snippets of logs, it's impossible to get a complete picture of what's going on. There are always questions. With complete logs, there's far less questions.

Speaking for myself, I will want to see kernel messages starting at the last clean mount with no errors which represents a state in which scrub was clean, and btrfs check was clean - and then leading up to the problem so we can see whether the kernel is in some kind of distress or there are block layer errors happening. By the time you see problems reported, it's likely the actual instigator problem happened before that.

It's kinda tedious but that's sysadmin stuff.

-- 
Chris Murphy

