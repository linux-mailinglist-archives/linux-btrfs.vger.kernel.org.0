Return-Path: <linux-btrfs+bounces-17031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85246B8E9FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 02:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8786B189B59A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A43596D;
	Mon, 22 Sep 2025 00:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="rPmxcFTs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cvK3UD/E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983728F4
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501085; cv=none; b=n8S5J74gRx/IoPf8J//y9SPyqwcQYNAGq1S+KcfPZq6WwAdZq5fdlhilKlckCTABdlxkP/ejNbWJkmSX23HG0WdKVOJ1aMVN3AbPYIcet7vMCd5nezlLxqrSIm+ng3J/XmLFvURfzAbsPU8A8bOePqk8THhJpEGvJ6kKHHAkUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501085; c=relaxed/simple;
	bh=tfYFDCmD9bD7w4twhorKj5sgZAGbM2/lTqjYVghtJ3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E+iP8lQlVOF7OblmmnWDNss1W9H943vc1U0ci8YPdt1PfYwbcymw2KyUUpYKQhU4q9VNGmo9iaMHC91E1q3iC1tUWAj/F7KKE6r1ba98JhFK2zeV4zqsU2feKqzh3l/uXqM3HYsaU65FDyWUzvfhH8kbcv0IqgafBZbrDwDa2EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=rPmxcFTs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cvK3UD/E; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 10A69EC0073;
	Sun, 21 Sep 2025 20:31:22 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 21 Sep 2025 20:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758501082; x=1758587482; bh=tfYFDCmD9b
	D7w4twhorKj5sgZAGbM2/lTqjYVghtJ3g=; b=rPmxcFTsZcqWOETejnorXmF5aM
	uKVI6Hy2fo966C+NCK4pH5mLPnsl7hm/I6w0RcJpX1Wfs6CagvD1DvWNFVJIFSM5
	jSZFnjGceUnTsAafUtbnl1HnPpIjP3i1dOVz6A5TmlPrLdo+uGGPgE9VK3xajCIE
	bx6eJ3ZpjmbZK2tIRbbj4if+vyccmc26Fs0vBd3rfoNYZQ67ZZ1ouAJWqL2U6ht4
	IdKOFjwxSDOsqDy/8RZ3elAON65ibEYvrIedctpLyImHJPijbHvRP2AqIUr18HOg
	LvM9Kq7CGhBPVvORFXQY0xntikVqeAk84ENe3HvYNV5/i0H2UUke9OHirtbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758501082; x=
	1758587482; bh=tfYFDCmD9bD7w4twhorKj5sgZAGbM2/lTqjYVghtJ3g=; b=c
	vK3UD/Ed9MyETmHmCk9DyN+wjjYbGbHXObqM2RZtGmYRkozt/vNYbQCg6ogxmfkL
	w/yYOLDna5GZp0kJKRxbog2tYUGyf3NW2uCMSIAwZzmkj67lD1xgj1XCVwa0alFj
	sr0eJgDlO+Y1VDMw1Qq3LlCQ6MTSgF2NwUzh/PKorxOrwkF4WrTzExC2kPGg2ldI
	lKFKQm1Bc38NJlNll711YL3YGZcIomhyL7GkgkDJ7y296dFgKPmM2KeRLf1JhmLV
	gXXC4w/XoxWT7eiX2aFKOvmwcJA1pANTlHTth6cdp+CK+QJWYc0Tp0iRlyOzUAtR
	u7OXe7GO/2+pCCxp1CesQ==
X-ME-Sender: <xms:2ZjQaH6xkwlB9svWQewoH9EKMXcAr6qDaW3AKPG2HXskPMJBQh-9dQ>
    <xme:2ZjQaM7id_EvMUNTS99Cxwotly7Ff4diLyAhgEQo2ph6FU44jPN6oksa672KOcsMT
    TgPO1Kf6eQ9g3Wty0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhephfeuvdekteduhefgtefhvedtfeeigfffheevhfevuefffedv
    tdegiefflefflefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhushhtihhnrdgsrh
    hofihnsehfrghnughinhhgohdrohhrghdprhgtphhtthhopehquhifvghnrhhuohdrsght
    rhhfshesghhmgidrtghomhdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtph
    htthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:2ZjQaACJLmZ83dSMAdeHcrOHsNalqPpPb-4he30k2usaZb6YxqGwfw>
    <xmx:2ZjQaL-KJ0pRT8ezYK-bvrne7WajZQKH8R-Lf5WJqcXe65xXmrH4Eg>
    <xmx:2ZjQaDL7J_IVQLqS5_xoNMIXxL_Gb2kO0yFvZ79zDWiCxWtKv-ZnAA>
    <xmx:2ZjQaMjzt3xlgWcqTBy0KUlpnzZ4sqmvspnccHI01Lm-qBC_baz3cg>
    <xmx:2pjQaEL_vUElCNG2yf-6VbJ0uwf2Ls9u0XVXBl9eZIOAkffm7O-1LDXh>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C147218C0069; Sun, 21 Sep 2025 20:31:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ac8M0w2PifQg
Date: Sun, 21 Sep 2025 20:31:01 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Justin Brown" <Justin.Brown@fandingo.org>, "Qu WenRuo" <wqu@suse.com>
Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <293aab80-89e4-44fe-b588-977ab24dbf51@app.fastmail.com>
In-Reply-To: <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
References: 
 <CAKZK7uzqNj1336MijN2De-R9+rdjw_Zm6=b-Q1jCCDQb5+fmXw@mail.gmail.com>
 <27b4ca8f-de3a-4b9f-b90d-c6260ba81f9c@suse.com>
 <CAKZK7uxiRmDxk-1goC4yj7QZPSmL-=GAoAuF=OdekbSNVrG8fg@mail.gmail.com>
 <23d859bc-19f9-4cf5-9405-03792dbf2e7a@gmx.com>
Subject: Re: [Support] failed to read chunk root / open_ctree failed: -5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

It might be worth looking at all supers and backup roots.

btrfs insp dump-s -fa /dev/sdXY

The supers should be all the same on HDD. The backup roots might be more reliable for attempting repair compared to SSD where I've seen recent (but zero ref) trees already overwritten by btrfs. That doesn't appear to be the case here, seems like newer trees weren't yet committed to stable media which is ... not good.

---
Chris Murphy

