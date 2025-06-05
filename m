Return-Path: <linux-btrfs+bounces-14476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0000ACEB99
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 10:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1B9189BCD3
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E1204C36;
	Thu,  5 Jun 2025 08:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="YXN3e8wz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SwI2vGeQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C41DF982
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111445; cv=none; b=NnUnHyonccja1FdL64P7/Gpn0s2+gA93i+V0r6knPPzlLapk2ly/+fGJfB9FferK1lnI7VZbgD1nNf+2ngBtMlNV5Yy0+ZE+V0ok0CAIVtE16mBE4EgaaXB4HTVodgSNYGqemKPIXeZUpzTfNEenXsF1ywgsZ+rWB9KhMV8jl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111445; c=relaxed/simple;
	bh=TlqYTQ1auteg2QMdAr+nAx6MTHPejAeGe1KAShHFk8I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=eCNSm1bFF7TzjJUXaex4+fo1yTQDy84gyX02j+hcSUCHmcmGPOQpX/+tenRWq0Tf9aK/ECI2kixFLl23MnvdSQRs3RPTlTAh0SrdojwNafPNu97kHnYMqPv3WQVbpEQJDKhtdorVmWjQeAOzToEs/3/4qu6+t7qE8NFjKdh2+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=YXN3e8wz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SwI2vGeQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 785E213803C1;
	Thu,  5 Jun 2025 04:17:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 04:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749111441;
	 x=1749197841; bh=TlqYTQ1auteg2QMdAr+nAx6MTHPejAeGe1KAShHFk8I=; b=
	YXN3e8wzyyE2H30yoTHEjYfDKXVMBfstD41OC63yfyZcn3kyF9MsfTE6OEDxEeet
	ok/8lNAEZnhtt5hKp8Try5XHW+JRSU53VuZAM2B7S+tJ8RKnlZ+v8gp/OBzmQBpB
	xK6svC1unvOdYq7VTBRJsSyOQZMtfZS4KlCYcJz+/CuA6KgMm6G2BjI41/cxYrwe
	IWcfa076Bh7KDTtmlBoXkS7nGdPWPFqrOtuxsT7GP4qIHnW/XXfVr8an64Bj9QQQ
	diDUUSY0x6pfZg/LJnMou+Y0T71eIGByeCjk8E2lGVaLOp1V6IMAFMS74YwfCpYg
	9Gs5ChcoY1cV3uufGP/ktA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1749111441; x=1749197841; bh=T
	lqYTQ1auteg2QMdAr+nAx6MTHPejAeGe1KAShHFk8I=; b=SwI2vGeQAqAxmejlJ
	wyOgSPttu9k4qEGyLM04tjLrA6wVMfGyei3rp/uK5F4+LzpkkB0qDJSz1oAuHhIs
	WtdwOFukeD6QSqrAHrI5UqpfWqvR7ZydbpORinuzSV+gVLk0FP0N7dHdMgQSWpdS
	NwccpTHxj19na2QjSDONnsdpgCC2Khm3fEUwcyVt/7kld+KNlC1HJYrA5u3WwVda
	thHdixkjPrPO6ajOL0EPDz7z8jK0NfQojpE+/BukgGJ3R9kkk5Wj5zyZk5WnsRm6
	m1u1AFX2tWD1wlX3q0qWNpNwAt6MzJ/rywDpMkRdtkzQNAVIlFl5r2wN3tHArAhe
	4e91w==
X-ME-Sender: <xms:kVJBaJGYTieNShZM1u87EKdrOsZRP4duzQqRp9P7IynIO6271cV89Q>
    <xme:kVJBaOVXKwWowR1gVVb82y9QhmopPoTwTLtRv_ZYoSn_DN8Ib6gBiXCFrOeJ8ulPp
    AvRGwYJNuOjxWwTzEQ>
X-ME-Received: <xmr:kVJBaLKC6LimbsAvMP3C8zQsTZ7ZWbZRvx1kKidcNxVvv45f7LsGPXTP1979nYfVIw8DbgTWKEd-OriQXgH17XAMemxEKewpZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeffeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeen
    ucfhrhhomhepfdevhhhrihhsthhophhhvghrucfunhhofihhihhllhdfuceotghhrhhish
    eskhhouggvheegrdhnvghtqeenucggtffrrghtthgvrhhnpedvffehieeutdduudfhkeek
    jeeufffgtdejvdfhjeejheffvddvteevfeefffduheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhrihhssehkohguvgehgedrnhgvthdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhgvlh
    hotghifhihvghrsehvvghlohgtihhfhigvrhdrtghomhdprhgtphhtthhopehfnhhtohht
    hhesghhmrghilhdrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kVJBaPH9Zr2qg4sCThSsAxR57P1g-N1Z8EXPTQxXitmux1fTMn85GA>
    <xmx:kVJBaPVpcIHF8-HQmOw4OiI0QaApZ5aTwgEfh0tHlUfiiIVb63kcsg>
    <xmx:kVJBaKPX0cBUJgZYcEkgLjq1bhBNOO50vKCY1wT4eEd8KCgCsuyT5g>
    <xmx:kVJBaO3T9jcpWKRNo56BS1aJ_3pH143r4hgJLA-xZsEvPLv-69pG1A>
    <xmx:kVJBaILtBTAVqfacIUfWMPgq5ONHr6Unp3u8wKrPpS7I7SkKL8CZMz-d>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 04:17:20 -0400 (EDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Jun 2025 01:17:19 -0700
Message-Id: <DAEG9AKPBKFN.2ZRRNL0ROETEL@kode54.net>
Subject: Re: Why does defragmenting break reflinks?
From: "Christopher Snowhill" <chris@kode54.net>
To: =?utf-8?q?=F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=9D=95=A0=F0=9D=95=94?=
 =?utf-8?q?=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=95=A3?=
 <velocifyer@velocifyer.com>, "Ferry Toth" <fntoth@gmail.com>, "Qu Wenruo"
 <wqu@suse.com>, <linux-btrfs@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <9d74d71f-b65d-4f06-adb3-18f7698edb8a@velocifyer.com>
 <b407459f-5c9b-49e8-ab77-07768cb30783@suse.com>
 <3fea5116-8532-4076-a824-620dc4c5a627@gmail.com>
 <1d6ac208-a08a-47e4-8c9f-9f99bd244146@velocifyer.com>
In-Reply-To: <1d6ac208-a08a-47e4-8c9f-9f99bd244146@velocifyer.com>

On Wed Jun 4, 2025 at 2:54 PM PDT, =F0=9D=95=8D=F0=9D=95=96=F0=9D=95=9D=F0=
=9D=95=A0=F0=9D=95=94=F0=9D=95=9A=F0=9D=95=97=F0=9D=95=AA=F0=9D=95=96=F0=9D=
=95=A3 wrote:
> On 6/4/25 17:36, Ferry Toth wrote:
>> Actually this makes defrag a very dangerous operation on disks with=20
>> many snapshots (> 20). When you would defrag each snapshot suddenly=20
>> your 5% full disk would be 100%.
>
> This actualy happend to me once because i forgot i had snapshots.

Greater than 20 is a lot of snapshots? I guess I should stop using
things like Snapper on my systems, then. It *defaults* to hourly
snapshots of every subvolume you activate it on, pruned to the last 24
hours, so that's 24 alone. Then it keeps midnight for every day going
back several weeks.

