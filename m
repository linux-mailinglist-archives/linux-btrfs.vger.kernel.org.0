Return-Path: <linux-btrfs+bounces-20652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBDD391D5
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 01:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BB83017EC4
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jan 2026 00:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E173156CA;
	Sun, 18 Jan 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="QinkF1/Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieX3LJV2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A39650094E
	for <linux-btrfs@vger.kernel.org>; Sun, 18 Jan 2026 00:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768695346; cv=none; b=QTDmTM9vioL0xfXBXRzueqFkicz37KcpPoZAjmFxeE4hwMr/de8xeyI8ZNrHnmShTkFeR98maW30IL2jHLQmwZCxRWF9b621g2TWilktSqJ0XhvmJCJj27cCVsXDgMtkmVy1+gECq97AFw5Xk2FfIqC5SQlDTn0he+eOgz3tyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768695346; c=relaxed/simple;
	bh=fG45MK5SYH8b3rMUTT5CzU4g/xnz8Z+bjfWzn+bpL1U=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=kh3YVBWYRuPYo0cPHIVnMjkBgAiTvC90VaDWWa6R3CtLW3NNHEwmCEheLX5+DJzXKtKAQGD59jkEPIF6Opl4zjmN5i8alMIEtAaOsW5eoVJUSDwKNAXAL1FBlG0EwW7M20hfJRo8uMF+vutGEjnRYwztWbJva1MLCVA2GeEZ6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=QinkF1/Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieX3LJV2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7CFEE7A030B
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Jan 2026 19:15:43 -0500 (EST)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-01.internal (MEProxy); Sat, 17 Jan 2026 19:15:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1768695343; x=1768781743; bh=Knw9hxGN48/pMhAl7pkIT79eR10tgnaz+/q
	t42yvD0w=; b=QinkF1/QW5F7ewD8t7eok/ovBf+PCPy7Hj7OLlx4HO7MMcyrPyP
	tc/megeE07e9MyqgHAV5/bhkPSGntCtx8n7RPbrrro6COaEv3BFSM+uvu/yKySex
	U7Yo6RBo4LbmWrmCK7qkuo9J69j1tyIEVKDYyA3JrYYsLWp33QlWABWfJBDUptad
	XdE6gJ98s6L0dBp6aqTarfoDAlUB15uJaHxYBQ+h+73+sFmifH47hoAnLbfM502+
	UzggWrLYOA336j+9XeCSX/TD2qhoTF+I+0Bn93c2zLD8CT3HnlFVQdWi5h2YMi+M
	xs5YopWLHwn8xZEth/TWYfO/dfG2AdvJBMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768695343; x=1768781743; bh=Knw9hxGN48/pMhAl7pkIT79eR10tgnaz+/q
	t42yvD0w=; b=ieX3LJV2io/U3f1goKJYRyBRuKWd7purwJptAqsLs+Pi5HcijBk
	P11Ddmdp2E4nv1/AmKDc33c+erBBntQEPQk0cwOoHp6ktHCztoTT5SuxSrPDe9fg
	pjP4T+rXydV9ptt3igDDUn6dFIx5Eqw6114n+82v9fxnEdPJv9dJHc4bJ+sLVhLE
	pCrRTxznZAt2mHAk/LKrStGQb/RjhMC7zHQgFgbOR3NOcolKP2klB7qKyFkCfEr4
	ZnNsDLLVgKKHa43na5XlEkB4Ti2Spp/isgDwh2uI1dPEEijX+qPGTUDLUlq+kUjq
	FEInTNQOQxZtFU8Ny3DfGbbWYcSpJmZ3c7A==
X-ME-Sender: <xms:LyZsaQb5qvmdKY-bLoGQsIKXe7UK7gFajZ_hdKf-i_6bh3DnEu1IjQ>
    <xme:LyZsaWM_norATPGekKATdwLPwD9BVIJYdrRI4JgfsWkG9ZjlRFLe5OkH4TnGKaKbY
    nHQ1bUAUmdOqudxRUYnKXyRImtCNi3hpIb7Dn888L7mW3LF9RVOPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeefvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkufgtgfesthhqredtredtjeenucfhrhhomhepfdevhhhrihhsucfo
    uhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecugg
    ftrfgrthhtvghrnhepteetiedthffhffdufeejgeeifedvheehhfdvkeeiudejffeivdfh
    ueduvedugedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LyZsaQq5hJGtQlF2smOKZuEoiruJzDggGqI3Or9UVm4AGzzAfL5q5Q>
    <xmx:LyZsaWlGb93CS50dDuZ8eihSXEscwKJHbudbStU-BOFdUJZn8lE_Cw>
    <xmx:LyZsaSFGlNl_ljPpOObrCucDCaBRNFZXDdg57limemXLrxtJKdJK6w>
    <xmx:LyZsafpuOuGR-hHm5MyPA9PgQG-n10HKkhfILq0NDB31PdhRzMY92Q>
    <xmx:LyZsaa-ROpNCg0kKKCWIYcQU_t8-9IR4HfjK499mYHcC49aS-UKEjzqc>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2579B18C0067; Sat, 17 Jan 2026 19:15:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Jan 2026 17:15:21 -0700
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <2cd6db87-bf12-4888-ade1-2fdea527a08c@app.fastmail.com>
Subject: btrfs check, file item bytenr 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On a healthy file system, do all file items have a non-zero bytenr? Seem=
s like that would be true, and I'm wondering what, other than metadata c=
ow failure, results in file item bytenr being zero?

More info:

User reports a file system about 1 year old, running kernel 6.18.5 at th=
e time of the problem, with no dmesg saved other than this excerpt.

[   27.927279] BTRFS: error (device nvme0n1p3 state A) in btrfs_create_n=
ew_inode:6670: errno=3D-17 Object already exists
[   27.927283] BTRFS info (device nvme0n1p3 state EA): forced readonly

Subsequently `btrfs check --repair` is run, but the output is also not s=
aved by the user. We don't have check --readonly output before repair, a=
nd we don't have check output for --repair. All I have is the btrfs chec=
k after repair. And therefore I don't know if the errors are the result =
of --repair, or the original problem. I'll guess the original problem is=
 fatal and not fixable therefore repair had no effect, but I don't know =
this.

$ sudo btrfs check /dev/nvme0n1p3
Opening filesystem to check=E2=80=A6
Checking filesystem on /dev/nvme0n1p3
UUID: 5a79da3a-afb6-4b7a-846f-e5be70def2b0
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
ref mismatch on [108706131968 4096] extent item 14, found 12
data extent[108706131968, 4096] bytenr mimsmatch, extent item bytenr 108=
706131968 file item bytenr 0
data extent[108706131968, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[108706131968, 4096] bytenr mimsmatch, extent item bytenr 108=
706131968 file item bytenr 0
data extent[108706131968, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [108706131968 4096]
ref mismatch on [108709425152 4096] extent item 11, found 9
data extent[108709425152, 4096] bytenr mimsmatch, extent item bytenr 108=
709425152 file item bytenr 0
data extent[108709425152, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[108709425152, 4096] bytenr mimsmatch, extent item bytenr 108=
709425152 file item bytenr 0
data extent[108709425152, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [108709425152 4096]
ref mismatch on [108777738240 4096] extent item 14, found 12
data extent[108777738240, 4096] bytenr mimsmatch, extent item bytenr 108=
777738240 file item bytenr 0
data extent[108777738240, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[108777738240, 4096] bytenr mimsmatch, extent item bytenr 108=
777738240 file item bytenr 0
data extent[108777738240, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [108777738240 4096]
ref mismatch on [108886646784 4096] extent item 14, found 12
data extent[108886646784, 4096] bytenr mimsmatch, extent item bytenr 108=
886646784 file item bytenr 0
data extent[108886646784, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[108886646784, 4096] bytenr mimsmatch, extent item bytenr 108=
886646784 file item bytenr 0
data extent[108886646784, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [108886646784 4096]
ref mismatch on [109075341312 4096] extent item 14, found 12
data extent[109075341312, 4096] bytenr mimsmatch, extent item bytenr 109=
075341312 file item bytenr 0
data extent[109075341312, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[109075341312, 4096] bytenr mimsmatch, extent item bytenr 109=
075341312 file item bytenr 0
data extent[109075341312, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [109075341312 4096]
ref mismatch on [109164244992 4096] extent item 14, found 12
data extent[109164244992, 4096] bytenr mimsmatch, extent item bytenr 109=
164244992 file item bytenr 0
data extent[109164244992, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[109164244992, 4096] bytenr mimsmatch, extent item bytenr 109=
164244992 file item bytenr 0
data extent[109164244992, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [109164244992 4096]
ref mismatch on [109401321472 4096] extent item 14, found 12
data extent[109401321472, 4096] bytenr mimsmatch, extent item bytenr 109=
401321472 file item bytenr 0
data extent[109401321472, 4096] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[109401321472, 4096] bytenr mimsmatch, extent item bytenr 109=
401321472 file item bytenr 0
data extent[109401321472, 4096] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [109401321472 4096]
ref mismatch on [134378655744 8192] extent item 14, found 12
data extent[134378655744, 8192] bytenr mimsmatch, extent item bytenr 134=
378655744 file item bytenr 0
data extent[134378655744, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134378655744, 8192] bytenr mimsmatch, extent item bytenr 134=
378655744 file item bytenr 0
data extent[134378655744, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134378655744 8192]
ref mismatch on [134389161984 8192] extent item 14, found 12
data extent[134389161984, 8192] bytenr mimsmatch, extent item bytenr 134=
389161984 file item bytenr 0
data extent[134389161984, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134389161984, 8192] bytenr mimsmatch, extent item bytenr 134=
389161984 file item bytenr 0
data extent[134389161984, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134389161984 8192]
ref mismatch on [134390292480 8192] extent item 14, found 12
data extent[134390292480, 8192] bytenr mimsmatch, extent item bytenr 134=
390292480 file item bytenr 0
data extent[134390292480, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134390292480, 8192] bytenr mimsmatch, extent item bytenr 134=
390292480 file item bytenr 0
data extent[134390292480, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134390292480 8192]
ref mismatch on [134391074816 8192] extent item 14, found 12
data extent[134391074816, 8192] bytenr mimsmatch, extent item bytenr 134=
391074816 file item bytenr 0
data extent[134391074816, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134391074816, 8192] bytenr mimsmatch, extent item bytenr 134=
391074816 file item bytenr 0
data extent[134391074816, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134391074816 8192]
ref mismatch on [134397329408 8192] extent item 14, found 12
data extent[134397329408, 8192] bytenr mimsmatch, extent item bytenr 134=
397329408 file item bytenr 0
data extent[134397329408, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134397329408, 8192] bytenr mimsmatch, extent item bytenr 134=
397329408 file item bytenr 0
data extent[134397329408, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134397329408 8192]
ref mismatch on [134404030464 8192] extent item 14, found 12
data extent[134404030464, 8192] bytenr mimsmatch, extent item bytenr 134=
404030464 file item bytenr 0
data extent[134404030464, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134404030464, 8192] bytenr mimsmatch, extent item bytenr 134=
404030464 file item bytenr 0
data extent[134404030464, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134404030464 8192]
ref mismatch on [134516363264 12288] extent item 14, found 12
data extent[134516363264, 12288] bytenr mimsmatch, extent item bytenr 13=
4516363264 file item bytenr 0
data extent[134516363264, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[134516363264, 12288] bytenr mimsmatch, extent item bytenr 13=
4516363264 file item bytenr 0
data extent[134516363264, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [134516363264 12288]
ref mismatch on [134960566272 8192] extent item 14, found 12
data extent[134960566272, 8192] bytenr mimsmatch, extent item bytenr 134=
960566272 file item bytenr 0
data extent[134960566272, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134960566272, 8192] bytenr mimsmatch, extent item bytenr 134=
960566272 file item bytenr 0
data extent[134960566272, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134960566272 8192]
ref mismatch on [134962233344 8192] extent item 14, found 12
data extent[134962233344, 8192] bytenr mimsmatch, extent item bytenr 134=
962233344 file item bytenr 0
data extent[134962233344, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134962233344, 8192] bytenr mimsmatch, extent item bytenr 134=
962233344 file item bytenr 0
data extent[134962233344, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134962233344 8192]
ref mismatch on [134962601984 8192] extent item 14, found 12
data extent[134962601984, 8192] bytenr mimsmatch, extent item bytenr 134=
962601984 file item bytenr 0
data extent[134962601984, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[134962601984, 8192] bytenr mimsmatch, extent item bytenr 134=
962601984 file item bytenr 0
data extent[134962601984, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [134962601984 8192]
ref mismatch on [135127560192 8192] extent item 14, found 12
data extent[135127560192, 8192] bytenr mimsmatch, extent item bytenr 135=
127560192 file item bytenr 0
data extent[135127560192, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[135127560192, 8192] bytenr mimsmatch, extent item bytenr 135=
127560192 file item bytenr 0
data extent[135127560192, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [135127560192 8192]
ref mismatch on [135146340352 8192] extent item 14, found 12
data extent[135146340352, 8192] bytenr mimsmatch, extent item bytenr 135=
146340352 file item bytenr 0
data extent[135146340352, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[135146340352, 8192] bytenr mimsmatch, extent item bytenr 135=
146340352 file item bytenr 0
data extent[135146340352, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [135146340352 8192]
ref mismatch on [135196753920 8192] extent item 14, found 12
data extent[135196753920, 8192] bytenr mimsmatch, extent item bytenr 135=
196753920 file item bytenr 0
data extent[135196753920, 8192] referencer count mismatch (parent 219602=
649088) wanted 1 have 0
data extent[135196753920, 8192] bytenr mimsmatch, extent item bytenr 135=
196753920 file item bytenr 0
data extent[135196753920, 8192] referencer count mismatch (parent 172671=
614976) wanted 1 have 0
backpointer mismatch on [135196753920 8192]
ref mismatch on [135997460480 12288] extent item 14, found 12
data extent[135997460480, 12288] bytenr mimsmatch, extent item bytenr 13=
5997460480 file item bytenr 0
data extent[135997460480, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[135997460480, 12288] bytenr mimsmatch, extent item bytenr 13=
5997460480 file item bytenr 0
data extent[135997460480, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [135997460480 12288]
ref mismatch on [135998251008 12288] extent item 14, found 12
data extent[135998251008, 12288] bytenr mimsmatch, extent item bytenr 13=
5998251008 file item bytenr 0
data extent[135998251008, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[135998251008, 12288] bytenr mimsmatch, extent item bytenr 13=
5998251008 file item bytenr 0
data extent[135998251008, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [135998251008 12288]
ref mismatch on [135998578688 12288] extent item 14, found 12
data extent[135998578688, 12288] bytenr mimsmatch, extent item bytenr 13=
5998578688 file item bytenr 0
data extent[135998578688, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[135998578688, 12288] bytenr mimsmatch, extent item bytenr 13=
5998578688 file item bytenr 0
data extent[135998578688, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [135998578688 12288]
ref mismatch on [136127258624 12288] extent item 14, found 12
data extent[136127258624, 12288] bytenr mimsmatch, extent item bytenr 13=
6127258624 file item bytenr 0
data extent[136127258624, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136127258624, 12288] bytenr mimsmatch, extent item bytenr 13=
6127258624 file item bytenr 0
data extent[136127258624, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136127258624 12288]
ref mismatch on [136129404928 16384] extent item 14, found 12
data extent[136129404928, 16384] bytenr mimsmatch, extent item bytenr 13=
6129404928 file item bytenr 0
data extent[136129404928, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136129404928, 16384] bytenr mimsmatch, extent item bytenr 13=
6129404928 file item bytenr 0
data extent[136129404928, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136129404928 16384]
ref mismatch on [136129548288 20480] extent item 11, found 9
data extent[136129548288, 20480] bytenr mimsmatch, extent item bytenr 13=
6129548288 file item bytenr 0
data extent[136129548288, 20480] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
data extent[136129548288, 20480] bytenr mimsmatch, extent item bytenr 13=
6129548288 file item bytenr 0
data extent[136129548288, 20480] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
backpointer mismatch on [136129548288 20480]
ref mismatch on [136130199552 16384] extent item 14, found 12
data extent[136130199552, 16384] bytenr mimsmatch, extent item bytenr 13=
6130199552 file item bytenr 0
data extent[136130199552, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136130199552, 16384] bytenr mimsmatch, extent item bytenr 13=
6130199552 file item bytenr 0
data extent[136130199552, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136130199552 16384]
ref mismatch on [136145211392 16384] extent item 14, found 12
data extent[136145211392, 16384] bytenr mimsmatch, extent item bytenr 13=
6145211392 file item bytenr 0
data extent[136145211392, 16384] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136145211392, 16384] bytenr mimsmatch, extent item bytenr 13=
6145211392 file item bytenr 0
data extent[136145211392, 16384] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136145211392 16384]
ref mismatch on [136155037696 20480] extent item 14, found 12
data extent[136155037696, 20480] bytenr mimsmatch, extent item bytenr 13=
6155037696 file item bytenr 0
data extent[136155037696, 20480] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136155037696, 20480] bytenr mimsmatch, extent item bytenr 13=
6155037696 file item bytenr 0
data extent[136155037696, 20480] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136155037696 20480]
ref mismatch on [136281296896 12288] extent item 11, found 9
data extent[136281296896, 12288] bytenr mimsmatch, extent item bytenr 13=
6281296896 file item bytenr 0
data extent[136281296896, 12288] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[136281296896, 12288] bytenr mimsmatch, extent item bytenr 13=
6281296896 file item bytenr 0
data extent[136281296896, 12288] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [136281296896 12288]
ref mismatch on [145211674624 24576] extent item 14, found 12
data extent[145211674624, 24576] bytenr mimsmatch, extent item bytenr 14=
5211674624 file item bytenr 0
data extent[145211674624, 24576] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[145211674624, 24576] bytenr mimsmatch, extent item bytenr 14=
5211674624 file item bytenr 0
data extent[145211674624, 24576] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [145211674624 24576]
ref mismatch on [149326233600 53248] extent item 14, found 12
data extent[149326233600, 53248] bytenr mimsmatch, extent item bytenr 14=
9326233600 file item bytenr 0
data extent[149326233600, 53248] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[149326233600, 53248] bytenr mimsmatch, extent item bytenr 14=
9326233600 file item bytenr 0
data extent[149326233600, 53248] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [149326233600 53248]
ref mismatch on [149571932160 49152] extent item 14, found 12
data extent[149571932160, 49152] bytenr mimsmatch, extent item bytenr 14=
9571932160 file item bytenr 0
data extent[149571932160, 49152] referencer count mismatch (parent 21960=
2649088) wanted 1 have 0
data extent[149571932160, 49152] bytenr mimsmatch, extent item bytenr 14=
9571932160 file item bytenr 0
data extent[149571932160, 49152] referencer count mismatch (parent 17267=
1614976) wanted 1 have 0
backpointer mismatch on [149571932160 49152]
ERROR: errors found in extent allocation tree or chunk allocation
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 326294581248 bytes used, error(s) found
total csum bytes: 294034880
total tree bytes: 8848949248
total fs tree bytes: 8187265024
total extent tree bytes: 327122944
btree space waste bytes: 1882580070
file data blocks allocated: 2168958410752
referenced 1094921699328


So roughly 33 instances of different data extents, all pointing to a com=
mon parent, with some sort of corruption. All of the errors have in comm=
on. Scrub shows no errors.

parent 219602649088
parent 172671614976

I'm guessing the same extent item repeated twice, with two different par=
ents are due to DUP metadata? But I still don't know what the error mean=
s other than the extent tree is damage.

Is it worth trying rebuilding the extent tree?

Thanks,


--
Chris Murphy

