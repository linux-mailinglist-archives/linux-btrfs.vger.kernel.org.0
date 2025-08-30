Return-Path: <linux-btrfs+bounces-16541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE41B3CFEF
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Aug 2025 00:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80908206767
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Aug 2025 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3DB261595;
	Sat, 30 Aug 2025 22:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="KpROckMz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n/4eTGpW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47B25A355
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Aug 2025 22:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756593731; cv=none; b=cesQdJGc5ERL91LEuHN7jLG1gSXF7Unnv78Kvd0JGVivtXHJUYunB8G7ajENMz0HgZtFYxR0o1iRbAmefb93XN4/k4wWX9VElTjjEPVx/NQGI9Z+cj6rS7GB61BV/IPqCxF1P+YEapM8BnYKvnHrQ3D4ZpqF3yf8leETQxjbfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756593731; c=relaxed/simple;
	bh=sNMJbOV7L8Pw5L4dpGmYim8XElfgoITGKOYJLlpqzGE=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ONLO8PpupBqIq6t6/v6KVGLoI3wz8RvyExLLq4eIiQKBu+AYBlsgbsFb+gySlJxjC4AcagQ68rIT983I8eWTTZagYzOi4FSTcSQj0fSUbZPvZBUd5BmdVjQKoKuOA86YxZDj4lbub0ofCehgF083EQ+ieM23JBJH7+9gjZ7F9bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=KpROckMz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n/4eTGpW; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C2FEFEC01C2;
	Sat, 30 Aug 2025 18:42:07 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 30 Aug 2025 18:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1756593727; x=1756680127; bh=j5ZGPB+qEVQ4lLJwvJMKv
	ypelhVdLDngdKDPQsIKeTA=; b=KpROckMzRwomtTHXlVVEZZ+ES8XjezvWB+6GD
	GCfhOD/SfZPquWIhLlofisDnBUZRYTNEpri7+EwwHD4h507/6rJSFVMWuO7+mZOB
	0j2KaAK12PbVE2rmsLhp1RziZETnzpvEJJPgD/VogXT+gvXGqtpRi+7zx7K9Bp9K
	WF7nepYftqbK2GdPUWIUGH4D6Ix/zzFEb8bronDxwxSf6zyqX5hin5Pr99EW6ZEp
	l5mEA6PZKcjIrhpp2nCihq3oE/8LOeTWAaPwI7dya+OVuJBZ89SfiUxjf/eDK73S
	2oQQGCG2eO4QkXRnk/sAMYKtxhFntzUpXoeubrANUFh3of72A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1756593727; x=1756680127; bh=j
	5ZGPB+qEVQ4lLJwvJMKvypelhVdLDngdKDPQsIKeTA=; b=n/4eTGpWqPpnuxdxb
	8RUxgTMuHpkAzByawHTJJvvfiwHDYS+XRZqzG+bdWwo4vpgT7u15+mc91S4Z+q1T
	Zu6ebbZrZCNJc37kLP2Di5ojDc66O9BpbEYQLbVxK9Ti2HIeubAtiiykSHhiYSpK
	T2sZyvIY6+toXBhlbostxQwOUgDQ4zS6s81iYnBn642n0PkngFsjTim1aTaWN6C7
	3+QbdXyM8V3wrbV2h1n5johbEGTqm8VZOokcT49Z/tCvG0Pvoj7Vv8GS0z5qdgpT
	wu6fLEPKpm3A5yP2BJ+Jx8G4JUvMUTlRuY1U/6DU3CF7qEx2XU2qMbupkTKvZLbQ
	CHBXg==
X-ME-Sender: <xms:P36zaG8iTzeXMH53hePPTVtbUMKEdwlj2M1zeZ20r0dgCf03_nOpOg>
    <xme:P36zaGt_6-0YjudWqCIdAy_5UgqDFOYuHghs7viJS8IbocU1Y72p9_5x3SUKrOr2c
    Kuw96XK8r1Vq9wJ3JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepkeeiueejkeffhfevvdefgeefffelffelgfejieevteevleff
    ueeuvdfghfdujefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghnugihsehsthhruh
    hgghhlvghrshdrnhgvthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P36zaHABFo8eyLx2Jttc6YVhz5J3lhWwbQABGZtqKK8MeRQn3HnJJg>
    <xmx:P36zaGe6rw7G-7QfbnkZ__-UTKySm2C21n1QInY7lEEbJylp0i69Zw>
    <xmx:P36zaEjT1ugItlbF3_a8UBz2D6MwhDxyflK1kR7gQ0XaSsl073lAGw>
    <xmx:P36zaGpYPze9nRUgVwj_P2RVorVqP3bRLZzsoBpaI5jm3fVoCK3ciA>
    <xmx:P36zaJyw0XqruGypnv0VnwxAVtDHzYffUNJxKI0IeB4cd_-MzS1mNN8->
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6CE0E18C0066; Sat, 30 Aug 2025 18:42:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlSwDfZadHnw
Date: Sat, 30 Aug 2025 18:41:47 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Andy Smith" <andy@strugglers.net>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <b8ca27ee-3a4a-433d-ab25-8d9bee4bdddf@app.fastmail.com>
In-Reply-To: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
References: <aLIRfvDUohR/2mnv@mail.bitfolk.com>
Subject: Re: Mysterious disappearing corruption and how to diagnose
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Fri, Aug 29, 2025, at 4:45 PM, Andy Smith wrote:

> The shuffling of devices that I had to do can only be temporary, so I
> need to decide what I am going to do. The smaller device I had intended
> to remove (but now had to add back in for capacity reasons) is 1.7T and
> is currently /dev/sdg. I could "btrfs replace /dev/sdg /dev/sdh =E2=80=
=A6" and
> assuming no errors seen do a scrub, but if errors were seen I'd want to
> remove sdh again quickly. replace then wouldn't be an option since sdg
> is smaller than sdh. "btrfs remove sdh =E2=80=A6" takes a really long =
time.

I haven't checked in a while, but I think  `replace` does not do a file =
system resize following completion. The dev_item.total_bytes remains the=
 same, regardless of block device size. If that's still true, then don't=
 resize it following replace for the time being.

Or alternatively if it is or must be resized, you can shrink it first. N=
ow you can use `btrfs replace` instead of `btrfs device remove`. This pa=
rtial shrink is significantly less than the one implied by device remove.


--=20
Chris Murphy

