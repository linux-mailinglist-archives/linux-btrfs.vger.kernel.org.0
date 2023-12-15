Return-Path: <linux-btrfs+bounces-965-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C72B813FCF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 03:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B47C1F22CAC
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 02:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB56AA4;
	Fri, 15 Dec 2023 02:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="UhZtDqHH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NfZfgrl9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37963A9
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id C20243200B4B;
	Thu, 14 Dec 2023 21:33:25 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Thu, 14 Dec 2023 21:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1702607605; x=
	1702694005; bh=f+rWVYl0kAeEbABnMPo1kbQXlVKm4bTFGEP18kcsDzg=; b=U
	hZtDqHHX2ICzp90HFfv7F7tXV0UTYSdfUWEXhSFE4Kf0zzX7sgR8mzeGWIYNQSbA
	wT2ibTx6V1IwlP0W4RuLkveQq2nVn8gKfdg5vOS1f6E6/rdQCHTrpUjSU8hVD/JR
	q3yU9ug+B0vev/dMFU/FTMGNiD073qvtFouegDYNdbLsBpJLND2RhtdaEckOvie0
	jGG54nfWTn9vKFPZ5MLlKcesYsKjN79Jt4yTT7S8vlAqxI4Ypaz0VePZglhQWLPI
	PJkLqd86wHfZG3ejqNsA+hQAVkCvOZ/pnocOcuB12hut/cP5gRMSrQu93OqNlHDj
	5Wi6AwKoGFT/ePfXIjlZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702607605; x=1702694005; bh=f+rWVYl0kAeEbABnMPo1kbQXlVKm
	4bTFGEP18kcsDzg=; b=NfZfgrl926/hbl61+e1vOM9dnBQYwN0K8y+kkvWpMiLf
	N1vp8EfaqbDFh81yLEQjDd1TCmJltoB6oGXy9ZKOB3E42GJJ30RGrRX5hEXGT6ZD
	URd9EJQpbzdeAH1/TusCQlIK+ef4fIG9tNsIWEEwi4Rj/3b9PHr5suhMEBux0wER
	C9CiG7hTJSKs0XhdT/aOuKaQdc/oiFfP+Cdwjm9hOY+ZH6cJMhRE4spdtXCSuQr7
	UMwX+kAqXMedSthn4EogtWRpVqGFk0F2VPifIrNFdwWz5tMV+aMAd7FTcWqUXElj
	4lmrjuVqw4Bu8NU8wLpZ8CgJx2oEaDlCRYjNFyacwQ==
X-ME-Sender: <xms:9Lp7Zf-VuyOFF4R5So_WfEmabS4qtRsAu7fe-9CIBaFidrWaT8Ypzw>
    <xme:9Lp7ZbsTrHBtkKOHXT4vv5aEnh60v6RvgMGjgov-pah9rLMbMs1WC6kQ8AsI4Uqgw
    S38A594RF4HS2woGFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddttddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdevhhhr
    ihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
    eqnecuggftrfgrthhtvghrnhepudehieevueetgffhkeetkeelveffueeltdejvdejveev
    vdeggfefhfegvddugeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomh
X-ME-Proxy: <xmx:9bp7ZdDAwuS418eQQjnDGS3teIuPnKpp6ZH8771G7DAD-9HhFOUzvg>
    <xmx:9bp7ZbdkysRWbSN8X8-Of2yxTRWGW9ZQF6GIeUkKeMt-7AzTuhNXgg>
    <xmx:9bp7ZUMQoWfj_dy1OpZjQUN4eleZoGFN2RA1yYEjo_-ntKAbWEeVdA>
    <xmx:9bp7ZeUnOan6fPFh_aReI3n6d8irCREyt1iTPkg-FQOfzwSlCu8f1w>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CDB721700097; Thu, 14 Dec 2023 21:33:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ef38bfd3-5195-4043-8ba4-20daf9cdbeda@app.fastmail.com>
In-Reply-To: <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <253c6b4e-2b33-4892-8d6f-c0f783732cb6@gmx.com>
 <95692519c19990e9993d5a93985aab854289632a.camel@scientia.org>
 <656b69f7-d897-4e9d-babe-39727b8e3433@gmx.com>
 <cf65cb296cf4bca8abb0e1ee260436990bc9d3ca.camel@scientia.org>
 <f2dfb764-1356-4a3c-81e8-a2225f40fea5@gmx.com>
 <f1f3b0f2a48f9092ea54f05b0f6596c58370e0b2.camel@scientia.org>
 <3cfc3cdf-e6f2-400e-ac12-5ddb2840954d@gmx.com>
 <2d5838efc179a557b41c84e9ca9a608be6a159e8.camel@scientia.org>
 <9ce30564e238d1be0deafb8cab8968f800a8deaa.camel@scientia.org>
 <8a9b6743-37e6-4a71-9423-6ce5169959ac@gmx.com>
Date: Thu, 14 Dec 2023 21:33:00 -0500
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Christoph Mitterer" <calestyo@scientia.org>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Type: text/plain



On Mon, Dec 11, 2023, at 11:13 PM, Qu Wenruo wrote:

> IIRC we can set the AUTODEFRAG for an directory?

How? Would be useful to isolate autofrag for the bookends and small database (web browser) use case, but not for the large busy database use case.

-- 
Chris Murphy

