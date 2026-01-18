Return-Path: <linux-btrfs+bounces-20654-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC29D39200
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 01:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEA2130042AC
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E761A23B1;
	Sun, 18 Jan 2026 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="pqYSN9Ms";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMH2KqCT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429778F2F
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768697703; cv=none; b=DJoXVP0LOZY0yHsCMDWwIsI7exuRiqFx1Q/Rwc/Gs+bIVfLg/69Z/pTHDSM/15UQwbwA0jsIt3Fuu0Nvo1FSfahreaEjfuyjt82gbqfpE7WjneeNp+O3fR41dmd9pYoEHGotpqj2NEtYoRDgUUK0bfTbF6hbSqqdIUZVKecx2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768697703; c=relaxed/simple;
	bh=kNF+LKparxEiH1B985AvgQjas4OLblZ6JMh9zYjsh3I=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lvJyDr5l2uZvqIH6uT0OqmTB7YZySGLS5IgumrM6dK6FEGeLRX1kt/GbaYSBVlJWay00/HZQbRlfXgeFX+JNQYerrnbF5yB5TCWQkfQ+G2Br2P/n3PZaN9YyUv0p3vVmqu+S9rQg8lZSR66CFHpm1azU3eqire4W0+eq6KOEpjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=pqYSN9Ms; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nMH2KqCT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1D4D27A03DD;
	Sat, 17 Jan 2026 19:55:01 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 19:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1768697700; x=1768784100; bh=6xHldqt+6hY1mfkgvDh0q
	U7EpyO9iyf+4BRWL9frWOc=; b=pqYSN9Ms+o5eMMqjD6vXfQeX49CEOD2qbqvp7
	6Nr4B7dGEsCqzm9v6zb4lxfxFhJHvmNeiy5+aYxIhRDulcs09bvh7ojDsLgUK1ge
	sk2Ese8qeZBaPzXik9SjnvBDnj/yrWthUaGcIixLmttSsGDmSv2mH/aqLfvtED0E
	W180YTf0g6OaEC00SKTcOhnAhVgO/z2BimG3Azb608EpXPEiSB2wIep2L4Khttor
	7HedXn4AvDyBRdl0wo5M+dnwFqGRUNp11MmKNus//etWdgWmtP+agfaOo2Rvt62d
	Yu3UqXlSlbnVEz1zZfIr/Bap3mLfLx3ZXGRP9tt7LX9zQQauw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1768697700; x=1768784100; bh=6
	xHldqt+6hY1mfkgvDh0qU7EpyO9iyf+4BRWL9frWOc=; b=nMH2KqCTIB5g+YOca
	b5uDVXZtCZ0UZ/lEnsAuvj3PH/tJWHhv4Jk+FcJQoY3fAMqIkEIMuKHzBqBVXtNq
	zq5KC7cC3FUMjR5pbsaTF6L++O4+U0fBYLbzad80RIGNCJGLj53iFdfVFIWDBUvY
	tyktmMu2PEuXE1Vb7286dhBHCx+wIzV8AXhgWgvpj3+YRmqhLr7HgsiFZN/AWtu0
	bFXUcKULgRf1DC2PkSr6UL1TUGhd2JmOve6KS8wnEIMkdiZkEuSqrCBIE4mtehGg
	MIC9xtSceXE16lWBcr/2dfpPJxk0tDjFIJqVEjtG8AwMIcOotUdkxSrwznPo3Aup
	48TUA==
X-ME-Sender: <xms:ZC9saSwaFIfONVNVZAcmoOOTtasQAprVwkWeSn6gMAHInRpiY7m6WQ>
    <xme:ZC9saZGAMbfpGdo_ELFmw1iRrpxLyMtnMrcEtQgIb9LKMrwDZsD5vo85o5sgQvsT4
    9G_c3BcC0R35lFj7nizfCmfU7BVJGvqfjrBKFGx0Q8iXIXPUEWKTNM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeffedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepkeeiueejkeffhfevvdefgeefffelffelgfejieevteevleff
    ueeuvdfghfdujefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepqhhufigvnhhruhhord
    gsthhrfhhssehgmhigrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZC9saVdkicse6L-imNj3PLhiJ2fCSwAEZjgZCqJbHO5GnU-XJobn-g>
    <xmx:ZC9saRIstDOtt6XBdljx98o0sZGsTDdmw6mvpDfFdcOpZSsz9rc11A>
    <xmx:ZC9saWFtrQlYsvAQd2MhQnst_8kr-jL5RPYdO9OUpbdTxTmxtr6U8A>
    <xmx:ZC9sabqjIIAo12tTVUBJIGLcd6fgHL485ZLj31JcH6_sSbRStAnmSg>
    <xmx:ZC9saZ1i97WKGgO90Uk930jr9Fa6BgXr0c2jw2YROgSpYXUyydh0eeaV>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C4D5718C0067; Sat, 17 Jan 2026 19:55:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACwNenEtR58g
Date: Sat, 17 Jan 2026 17:54:40 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <09eeaa03-80f0-48f5-bd25-14f885f86023@app.fastmail.com>
In-Reply-To: <e32a5190-3959-4983-8cd7-3eac9c37f20d@gmx.com>
References: <2cd6db87-bf12-4888-ade1-2fdea527a08c@app.fastmail.com>
 <e32a5190-3959-4983-8cd7-3eac9c37f20d@gmx.com>
Subject: Re: btrfs check, file item bytenr 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Sat, Jan 17, 2026, at 5:29 PM, Qu Wenruo wrote:
> =E5=9C=A8 2026/1/18 10:45, Chris Murphy =E5=86=99=E9=81=93:
>> On a healthy file system, do all file items have a non-zero bytenr? S=
eems like that would be true, and I'm wondering what, other than metadat=
a cow failure, results in file item bytenr being zero?
>>=20
>> More info:
>>=20
>> User reports a file system about 1 year old, running kernel 6.18.5 at=
 the time of the problem, with no dmesg saved other than this excerpt.
>>=20
>> [   27.927279] BTRFS: error (device nvme0n1p3 state A) in btrfs_creat=
e_new_inode:6670: errno=3D-17 Object already exists
>> [   27.927283] BTRFS info (device nvme0n1p3 state EA): forced readonly
>>=20
>> Subsequently `btrfs check --repair` is run,
>
> That just destroys the original fs, please provide a full 'btrfs check=20
> --readonly' output.

I posted that already. It's the only btrfs check I have, which is after =
--repair was attempted. I don't have a btrfs check prior to --repair att=
empt. The user didn't retain it.

> And for who ever reported the problem, let him/her run a full memtest =
first.

They did  a short one and it came up OK. I'll suggest a longer one.



--=20
Chris Murphy

