Return-Path: <linux-btrfs+bounces-17641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE0BD0CF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 00:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CFE3B123E
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Oct 2025 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF8A242D6C;
	Sun, 12 Oct 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="WUjEh6yr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MainVFg9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D7215789
	for <linux-btrfs@vger.kernel.org>; Sun, 12 Oct 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760307031; cv=none; b=e0aXmRbiuNdYtXDtAoqAqoR4sb9UzFQkEC3Ekzx/yrYIbn3SMbSiS/Bz8BcTyG2BDrFNnv/Uqs0RPFxgFg017+HzyO0VKFBfa39Mf2gbsPhKY47jMk5F0nFoA/KePY8xQTVB8NaillUvLufFXBC3w6oLS0ic5zuxTtTqb9c+0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760307031; c=relaxed/simple;
	bh=QhRdnxCMZkxCe+iU4EscVuaBWxkQi7wdO1PnE12ja50=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D8/cCu2QrLH+Gd0iJBlBpMAOdbiq69MaV53Nr8YdCW77BjwEwlT7yF/6F+1b06y+3RvdOluIXlOP6snjj/6H9K2j9jmZZPwU77mYhotCXANeG2CMWld8GrB2OPfUdPMfCZdf2IJldtGOaTCJOVa14EX6U+WhDvdhB+c4KUUGB4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=WUjEh6yr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MainVFg9; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DE9CB1D0006F;
	Sun, 12 Oct 2025 18:10:27 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 12 Oct 2025 18:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760307027; x=1760393427; bh=I0L83vHSM3
	VxthBoZmT5cjXgjBD1R2mwCzdvQafQcys=; b=WUjEh6yrpkEaJLbr+VQPqoBohg
	a70GLQO7DHwWmD5CbWCmiH7d7mPhCpPkuNTxA2PX+8Yb9JHrfh/Bvw0JO7FPMfqf
	giEormCbgQYgURCrZMXK1aitUYqCieP99Ohw6+RIISyVZ+1Cld3LT2p1TmcXVuf3
	HTeAWfFiNNtgbe4azamu+j2/PBQ923VF2r1NbXHGlTNoForbokU4vNuW4xoSGmq6
	e6LsYQJIf+Jyd74pl69XFS1L5DpvH1gIizieJjB+hYcdHg5fLayjFp/vfQIaJeRr
	R3IQqwDaVG0ZUI6EldMFzpZmlkA3OXWYlRZAWjNbq32NBNsOZNFn1lByW8Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760307027; x=
	1760393427; bh=I0L83vHSM3VxthBoZmT5cjXgjBD1R2mwCzdvQafQcys=; b=M
	ainVFg9Z51MHZcUBm8SOH7Z7Qgrnmrr8EcBZ1EPxMocYATPEgCflMiRdMl5MumPS
	UGHIPUxMucVjszGji76TCDem5fOIpNBY9lonSeVRt4Q6au1yvQKoLvfZ7fQk3YLF
	ZJyzMawWtWOHuTog8DRuPifBGa6DTmyULlf3IVvdttE7m83mtrojWV/+98MGkRn0
	q+I+OYTDfKncqBKHv/H+B2sp/GJSZVXbUZRy53SMduJKVIAMNBM0H7/jVt6A88t8
	MAMDJGbPFsIwmLrUI8VeDhoFYK9JRy/YA9qifbtOL1W8eQxtF8lf5zsUnCFP/LYO
	frFKhqvAjKuzNVlIOOu4g==
X-ME-Sender: <xms:UyfsaKz5XDFa0TSJXYHE71AvYMlQBei54hyXsDnH5hnsc3w968KQbg>
    <xme:UyfsaBGqBbvSKwXDaWV1OholLIM_wn_B9aoqF7M4A-VGs0WLrKqPDuvijBSK_KkBD
    u4QJD6wE0xep9UCj2yTbmllfzc2W1WQeC1AUXbMcUgDkxjV10q3N_M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudehleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhi
    shcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqe
    enucggtffrrghtthgvrhhnpedugedvfffgfefhueetiedvkeetjeehieekieeljefhfefh
    feelffekleeutefgteenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhho
    rhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshgrfhhinhgrshhkrghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UyfsaNcjyd-VQQqXdpycmGl8R6ucNRf-WRXMjgPiYNzHhQLG0UPS6g>
    <xmx:UyfsaJK15aJp5D8WupT3OlAd0bEQSIRWcUQwGGNlaIoIHhZJs2MgDA>
    <xmx:UyfsaOH4TaWganR3HEuDX7fnspv6t0MenoyyejWEQ7uL7FptWmWMSA>
    <xmx:UyfsaDoJ0Zol7CI06FZj2AHgXP-cxhZA7QsDZAriLpc2D39hrMgJHw>
    <xmx:UyfsaJ1JHTMw_X2Hh78lnR-uCZBbxuJ-psCfubVVjzTWoDOSgbijayQe>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6EACE18C004E; Sun, 12 Oct 2025 18:10:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYAte_pFYg7k
Date: Sun, 12 Oct 2025 18:10:01 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Askar Safin" <safinaskar@gmail.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <19dd908b-12df-45ad-bde4-ab7281557608@app.fastmail.com>
In-Reply-To: <20251012085256.8628-1-safinaskar@gmail.com>
References: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
 <20251012085256.8628-1-safinaskar@gmail.com>
Subject: Re: 6.17rc5: btrfs scrub, Freezing user space processes failed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Oct 12, 2025, at 4:52 AM, Askar Safin wrote:
> "Chris Murphy" <lists@colorremedies.com>:
>> Scrub initiated, walked away,  and when I come back it appears hung with a black screen unresponsive
>
> I suspect here is interplay between two issues.
> First is btrfs kernel bug Qu Wenruo is talking about.
> Second is systemd issue, which amplifies this kernel bug.
>
> Systemd bug turns simple "suspend doesn't work, but system continues to
> operate normally" to "reboot is needed".
>
> I wrote about this here: https://github.com/systemd/systemd/issues/38337 .
>
> The bug is fixed in mainline and stable versions of systemd.

Thanks for the response.

 I've since moved to Fedora 43 (pre-release) which has systemd-258-1.fc43.x86_64.

Fedora 42 still has systemd-257.9-2.fc42 which is what I was running at the time of the problem.


-- 
Chris Murphy

