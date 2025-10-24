Return-Path: <linux-btrfs+bounces-18243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3C4C04A84
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 09:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2F14E359F01
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4A2C0293;
	Fri, 24 Oct 2025 07:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="w3KmWE5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RG+K7C/M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C42C08C8
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290054; cv=none; b=XcRr+pD16bpfh6CDkHp4Gy93JA0k79Vw9RHo4pxgBbTOpvGou2ZYLZAxPBfyw51h9MzTdaM0YL/BRHBIKocXuAUpfDThNEG1WvYOEyxrLR64WmQ1N79Ck5/DmtHH264jZHpnxJERKAVPe1xO85Rw1FBhsZ65q0m/aeE6F5NDH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290054; c=relaxed/simple;
	bh=Wc0honp8q9j6qcoFgYoq1Vk56bBNE/1iAs+IFEno0TA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Q20LL+/lC4IIJEoR13skkOMCjmNYtkqNjUBvT2nbc6A0ka2Hk+BuF5PGHOkUgAQa1zDue7ulH+Ocwllt7dKkGSbCVc4kKed70XhpJdp8gvfairxJNp67I3U48C95LpyQ5YYTwPo6uoQSXUJ/VtKWXs694+cZudU8j8bhjpnkDcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=w3KmWE5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RG+K7C/M; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BB46BEC02C6;
	Fri, 24 Oct 2025 03:14:09 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 03:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761290049; x=1761376449; bh=gmBQnTNB/7
	E+Ja6ZitmZfEL3ufIzM7PsgLvzTCtRV0w=; b=w3KmWE5CJlwTcOYTvsEZHNEQsZ
	8g1xJZWKvDu6HcRuEA8yjsMV2ptOzWGvFwOcY8Bw88Tdx6ocB4SI0EAN4G2LRMkT
	3sP8vIvR3fCmEjD5INcANuYT8nLWBZlUBkpwPp0L8tvBwkMDJlqmlvhRSCLtcYof
	PsV6kQDwPKkUezt7v/XJiM0DmXE19uEQIbpIfT0EDEIoYo2PSxxT0oQASNTMEN0E
	fShNgeYbRYvFJXUvAacXCi/pjPhWgiXihq+CDYjQmPX2hLh16ZFfq5eVbrgpBBDg
	+3zqbkSrwMzhLjneobPbTq5/6HTToxo2LvjynGi2I5Bm+b3MgoVosWF33YZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761290049; x=
	1761376449; bh=gmBQnTNB/7E+Ja6ZitmZfEL3ufIzM7PsgLvzTCtRV0w=; b=R
	G+K7C/MIHVtJD2g20HOFnA93Aw7Z9VljZe7N/cS47aK+2TqajZc475jVVTQj1mop
	5w3t1d949w8Fc7QEVADC4cVw4dx+QDwE730SB2exfpx+BZoncZYvNoQ4MrNgqeIw
	OPcXuMcx7CAJRoMxtr2kUbbEgTPcFhQjLRA5kdCBU24lWQuKw/UlUir3JU/p/7f0
	AItiNSBwaOQbSNXPhojjEodDGL/JtzhvqRawdLOj7qWUCoWcAXBM/171fxpZL6ie
	/QnDtY4zMuI4nZh5MBMe9IgsDE82cTUupG9qM9+tlH2isKnBn1yjUikLMwhRR1Dp
	Uw2JmtHOVDQTDgXwDFEAA==
X-ME-Sender: <xms:QSf7aCj8sSf9uIGoO-c3R5j9SJW4hJtCmlfUcb9sapc2mB2AXRONHw>
    <xme:QSf7aN0gw8-zaZXXDWjXIx6Uqdi_G6zfeukTh6C38GLitV57qyq_wSzxmIXpzW1AC
    TWiD5G5oAwZL6pTkwS_FPdcF1VJOWf-jvVH9-ruzq-KNODT8lMQSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhuedvkeetudehgfethfevtdefiefgffehvefhveeuffef
    vddtgeeiffelffelgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehurdhklhgvihhnvg
    dqkhhovghnihhgsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopeduudduiedtieej
    segsuhhgshdruggvsghirghnrdhorhhgpdhrtghpthhtoheptggrrhhnihhlseguvggsih
    grnhdrohhrghdprhgtphhtthhopehprhhonhhoihgrtgesghhmrghilhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QSf7aBtsVVwHiYzGOJDM6Ny4wBKiVIjumHCXa8IIQ4925iDWczNUnA>
    <xmx:QSf7aDajXyawt72Xgv3ihmn70Fjha1XryRzWHK916hHmWRpttMUB4g>
    <xmx:QSf7aAVKXON9Y--G1ry5x4618afot9mJpsN30jcR99M-JFC26UTpbA>
    <xmx:QSf7aIRD2ULlqEm3WHvrcSmmpGQ0_Untw8XO9OeCu_HaxqRZ2-oaDg>
    <xmx:QSf7aFQpTg2LmCIS-BSPMsDfLaSEY9lBJJBXElkAqla3IC36LqflxEv->
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0E78418C0066; Fri, 24 Oct 2025 03:14:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6pIN6RInZo
Date: Fri, 24 Oct 2025 03:13:48 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "james young" <pronoiac@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: 1116067@bugs.debian.org, "Salvatore Bonaccorso" <carnil@debian.org>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <4c5faf27-31a2-4a26-9479-27a6e321fed1@app.fastmail.com>
In-Reply-To: <5FFC8167-3F74-401B-906E-0DA5CE4FCDC2@gmail.com>
References: <gcwabziwxb2u57m7tbku3wnqgsocdi3euyv7cx2yip5t7nyp2y@ncw4nxihp2zx>
 <5FFC8167-3F74-401B-906E-0DA5CE4FCDC2@gmail.com>
Subject: Re: Bug#1116067: linux-image-6.1.0-32-amd64: btrfs compression quietly stopped
 around 60TB in
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



It seems difficult to try to reproduce, as described. If a simpler reproducer could be found with the current mainline kernel? 6.18-rc2 is current. The vast majority of development happens there, and only once a bug is still present there does a fix get developed and then backported to something like a longterm series like 6.1 which is now at 6.1.157 - but this series was released in 2022. It's a long time in btrfs terms.


-- 
Chris Murphy

