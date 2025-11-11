Return-Path: <linux-btrfs+bounces-18869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9525C4F285
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D793A3BBD
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1AF377E85;
	Tue, 11 Nov 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="PSV8Ibxx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jU5SqWKg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1754A2550D4;
	Tue, 11 Nov 2025 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880221; cv=none; b=tjMPSb8pH2uN6OXf91CNPEAOPaDslsscgZRHty1TGJ/+C0vy5kQz095Lr5bLnVbL2wuEBTrtrM9sXlwpkYFAH+DAHthxrDe9wm+QGMLM0FQUEzD8bsHHtvbIfeZ2hGd7e/xf4mVcC6cppZqhUfBv7OWN0PYjMdRbdN9tr9FJlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880221; c=relaxed/simple;
	bh=DqXcOTREauByWgEhGQHq/TSUiYK6pnMAOexgqUPfrS8=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gA0+DXNBXA0XAvmxmfkuyHVJdP9fGqQtrMhAkC+/vQRS+FlSgoMAprDiBLcwgz+7o+Kr7rLGZ2OVbvCqHFFzwyS4BAQvlO7vk3fmLFmbafireA/k/LVrzWTMbSSqn/g6eJksZXvJDwUMdJSxl6F/kPQvLcbjjEIySgMdwUC4+ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=PSV8Ibxx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jU5SqWKg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 29E8A1400275;
	Tue, 11 Nov 2025 11:56:58 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 11:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1762880218; x=1762966618; bh=jQ1ckFQTuSMN6aUp1G48v
	fcpdeK6dBa2SZ0GHuhXz0w=; b=PSV8IbxxaHg/tLIy5K492WGwsS4UfG+yUU9SZ
	aAkrDoClNnaIHJqlnKLW4IUWL5rQWamSqIgPxvttCW06/ACBArGNlDwA7IdpCuIR
	O691TUf3n4IeUYow4w+KK51eMoSKtIMax1030Jt2tv32uTfhEqfhYQL04ThI3o6s
	2OXgtUiw8sR0xx2r5mbqF9IKIuUDYrI6OM0ZMX0fQZYBaJXYIIXNWHpq9SdZFfIm
	JIgTpG7YrATph80kbOHcQfxbttwFt8qn5aVHuY3xnMJB6YxUWu4K4//zkeE2S4zA
	FbSx8NRMqx19lY38Mv9f5MWMeE5h8e4/eq2xHG3bpLCTgfOnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762880218; x=1762966618; bh=j
	Q1ckFQTuSMN6aUp1G48vfcpdeK6dBa2SZ0GHuhXz0w=; b=jU5SqWKgCPLSAPLyU
	Ar9xe7qhCSDxKxR4ncXweWInU+IM3dP5K7QKl/5rJHYZDFcunBpVWcnTuqBSSAxl
	76VQSkzNkxnIkE6kYF0reXL+bW6ij5yXs2ou29GFLjT5NF0YpCtN71Sna2oMZlm6
	OinulrY/8hrFY9WNcSwU0beyizTSAOHtLlNCCMStXymrBzc/zkodZpp4JJHViry9
	D8S0P9r6P9RI1jy0hioUCv4rWozIuCOfnNRPuqvW4ZClmrJKiVPgg8gBMLrqL3eE
	iOGYcubPyfstgCxL2ULNW4I8DZ1iDWnX7kFOfWwQn0I/v87ohUHHnERgBVKn+l12
	9ChpA==
X-ME-Sender: <xms:2WoTafVAKmzyYLX4_VFT_WU6AzKtuqc0pfDya012V2dcoSYOicQPUg>
    <xme:2WoTaSaaxDeDAiqX-bRpeF53QmZbatbCsolKPY8ZPZyrxsGg2vTlBg20N0D5GDp2e
    gyOdrgdANAzp_4jPKqqtqPMF1Hbo2WExfItFBOHPdOrhlJPYcWtb_5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepteefudehkeehgeekhfdvgefhjedvveeuhfdtgfejgfevieev
    iedvfedvhfevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqnhhvmh
    gvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepjhhpihhsiigt
    iieslhhutghiughpihigvghlshdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2WoTaRD6dkKSgOlwwkrZm7kTbaEX9r6_E3OZTz3vvX5NwipX_5pK9A>
    <xmx:2WoTaWa_P7OKgEzH_uzzdysmclkLFG1_oN83sR5WnvOGQ5lMTzdS1w>
    <xmx:2WoTaU61NCF3s_llmjzPtR3CetBNFMYdIX7yUanvPke8WcyJ3JbEyQ>
    <xmx:2WoTaXZw3stzBqHV186x9ShRgjUOvKQMtR8GgHFVyDyRICByLhWOqA>
    <xmx:2moTacpLo1jFIrmWbXFvD_-WOOTBnlrxMuZV4vLual0t0lDdhobl8H_M>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C071618C004E; Tue, 11 Nov 2025 11:56:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABlTi-3C1DAF
Date: Tue, 11 Nov 2025 11:56:37 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <e5a2b8b2-d4e5-42ce-9324-5748c5e078d4@app.fastmail.com>
In-Reply-To: 
 <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
References: 
 <CAO9zADwMjaMp=TmgkBDHVFxdj5FVHtjTn_6qvFaTcAjpbaDSWg@mail.gmail.com>
Subject: Re: BTRFS error (device nvme1n1p2): bdev /dev/nvme0n1p2 errs: wr 37868055...
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Mon, Nov 10, 2025, at 10:05 AM, Justin Piszcz wrote:
> Hello,
>
> I am using an ASUS Pro WS W680-ACE motherboard with 2 x Samsung SSD
> 990 PRO with Heatsink 4TB NVME SSDs with BTRFS R1.  When a BTRFS scrub
> was kicked off this morning, suddenly BTRFS was noting errors for one
> of the drives.  The system became unusable and I had to power cycle
> and re-run the scrub and everything is now OK.  My question is what
> would cause this?

We'd have to see a complete dmesg at the time the problem occurred. If the same device holds system log files, seems like a pretty good chance none of it made it to persistent storage.

All we know is btrfs sees a bunch of dropped reads, writes, and flush requests. So it's not a btrfs error per se, though it affects btrfs. The issue is with the NVMe drive, its firmware, or a kernel nvme driver bug, or some combination of those.

--
Chris Murphy

