Return-Path: <linux-btrfs+bounces-16114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C323BB295BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Aug 2025 01:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 355457B152C
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Aug 2025 23:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6D206F23;
	Sun, 17 Aug 2025 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="gYYkD8Bm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UD3uc5m8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAE926AE4
	for <linux-btrfs@vger.kernel.org>; Sun, 17 Aug 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755474429; cv=none; b=h8kXsTAnpKll7vQrUaFxBkX11SvmjCkTc9rAUn4HHeIKHMXkOrpeWxV78oDuyPPQN6sBLXqmFD+b+Zcp/cbp6x+ravdeHsdz8PQkBzj8JF+/JBWJlsWfVOMdwh924+ddJ/DueMAWQVzqVscb8HxdBq/HaVsazgzYATHck2ENvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755474429; c=relaxed/simple;
	bh=/uXhEvt6/YBB+m4ODxLbUQ6wOi3FFVpEZi3atq/eb+0=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=Pd1xBKA0hXg1qYCChk4867f1Ek5gzZfWoOxXH2zykUnnDVYnIkBSJGtiC5Z6ie6vBlqRnOY3jBc5GgtaI2aAdZOHdGtzq6aDsAjOHeb4B8pZJYE6+5RMVFL6ZKOgvsoB9R05uuYTda1ExgaLHIoMYN8YQydaLtAbf7ynPo+oUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=gYYkD8Bm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UD3uc5m8; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF6437A013F
	for <linux-btrfs@vger.kernel.org>; Sun, 17 Aug 2025 19:47:05 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 17 Aug 2025 19:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1755474425; x=1755560825; bh=/uXhEvt6/YBB+m4ODxLbUQ6wOi3FFVpEZi3
	atq/eb+0=; b=gYYkD8BmX7g+Qk1N/Yd9Ju6yep45/I5Ft7/EZJMrelB9LnurJnn
	uguRA1O5lDui7DwhvMwtRynafpYKVf9Xvn98SL9Ud03XKIXsjMPzT37HDoboBu7/
	kMqiLXh2gkAjB9UsE5GbWa68v1bLAZo6nQgvNhbML/BPVXL+NKaRUiLKFB2MctCu
	YdKsoYy2KzuKLeqKhjfoOHgCruxfeci5vUwQ2RADI2V/nMvxbRsKc8Vfy2yTjO5z
	/n6qy7vx/1zaXFb5qh7NesmvkEsC5JAcvtrCECmOw+trif1Xvoz4OlVu6xy87R55
	cxND3NqF/IUTi4QsiRjUUjxN1/Qut1DZ32g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755474425; x=1755560825; bh=/uXhEvt6/YBB+m4ODxLbUQ6wOi3FFVpEZi3
	atq/eb+0=; b=UD3uc5m89EcknCJkM6ufCUPh75UwSYb5fKQU3fjH2nLhOpSgoWs
	/LFd4lk7HWWeoHcSjh6bwOvPLT5RcJPBkNFAgmaS6mPHZ7bkIHFh6pWCIgGmDME/
	b7PPq5aUzYMMz6VVZvvTCLHddENlCUfRG/bu1tSRDHRZ1AnJhFxq7jY242VbX/71
	c6hD11JnJbYBwmsFyunflfb9mhLYTwzdLNiyHAtOa5+l04a/z1zIGo2xVGYM3AK1
	Vx2W0qh+C/vm9PE3N2VCvrnYNxcztJ6QatDfk/WIAfum3vDV/D2DIlKs+I2o2uqs
	na/EEMbZBjF5BOIOLldfGdSIWILyX5iDApw==
X-ME-Sender: <xms:-WmiaGiSJeitX3CMULENSikFOvBntg92ekNjoQJ5dJfxl2DNUuSzQQ>
    <xme:-WmiaHDiXglA6fsU8zFbrdClku701eJH2UKcCEanS6fZaZkc_Z9XOxLrLSDpNNPCa
    -9QXebdjSA0Emp2W5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedutdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhsucfo
    uhhrphhhhidfuceotghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomheqnecugg
    ftrfgrthhtvghrnhepjeetjeelhfeltdfgtdegjedtfeelueegudfhudejgeeiteeguddt
    jeekffetleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheptghhrhhishestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-WmiaBZ6ALUelYddpHVF3KD45rLYwNRDs_tAzEmkQwxBq2Q6YnYe8g>
    <xmx:-WmiaMq0UMAwaDbnuzvFNk2WG1gG_Yc54oyh6OpPEoJSlSLkWoOcLQ>
    <xmx:-WmiaO9irfyPLqAAFP6iYrBJFKgn3zKpC2ye_S0Hph-DL52n7Kdb8Q>
    <xmx:-WmiaD_jCOKLyu7rMpa648IuK5GyJnIJJpX3KdsbwxrC4ZoNSjaIsw>
    <xmx:-WmiaAh7_-nA38puZpoqYGh3T8eQ_J-2OhgX5yqyzBBhhBa-21HVKLR9>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65A1F18C0066; Sun, 17 Aug 2025 19:47:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 17 Aug 2025 19:46:45 -0400
From: "Chris Murphy" <chris@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <89953b90-476d-4949-ab90-865cd535ca94@app.fastmail.com>
Subject: degraded raid1 allocates new single bg's, degraded raid56 does not
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

This is not new but I'm still seeing it with 6.16 series kernels. If a device fails during runtime, newly allocated bg's inherit the existing profile.

However, when mounting a file system with raid1 data, using degraded mount option, new data bg's have single profile. I forget why this happens, if there's a good reason for it? It seems users are decently likely to not notice this reduction in redundancy.

When I mount a data raid5 array degraded, and continue writes, new bg's are raid5. There's no reduction in redundancy (other than the missing device of course). So only raid1 reduces to single? (I haven't tested raid10 or raid1c34).

--
Chris Murphy

