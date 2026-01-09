Return-Path: <linux-btrfs+bounces-20348-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D16D0BCB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 19:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D19093025305
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 18:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B437366DA3;
	Fri,  9 Jan 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GRcQ0t0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wm5+EDjK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3335335B139
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981979; cv=none; b=h71+RUWfJRMU+sFiNmDSWqBFrLEBVfM1Lahwi1jXvALyK5SKg987zS6S+VLHhTLjzJm7a4Y8xJdHKsP21Hg8OCSAurHv2XFYmB7QI1O568hvHRsQTK4oGPmwH8ub9myNV1AxNBXb+g6GeCZhWUctWl1D+fQ7RdQAWUsUYHQmQlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981979; c=relaxed/simple;
	bh=me34ENG9VyuEp9SgLk9dt5nZpTWh07adrsNvd/pp1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtnzfFm+jqnUl1FmHeg0KvAv5uR+OXTUl8kzbtJO1TbpQHJIVAvZfR6cFOJtLuw724tAZbOGX37ZWfHZofG4nRB4ezNWy0ArDAAluIpKACLxOZDI0WCqP9DlpC+Byo8AUW63RSB2Xq24pgBVCnzDr7WjTzsz5jL0Q8ll8UJ0hRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GRcQ0t0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wm5+EDjK; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 59B9114000C0;
	Fri,  9 Jan 2026 13:06:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 09 Jan 2026 13:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767981976; x=1768068376; bh=iy3ZEzZkIe
	z/sa1h24xPVU3fsTbYW3wKgLzwG0FuBGc=; b=GRcQ0t0vx3AdaH1Zs6mvSR3qZS
	eom0zPgJUND6/GmfYNPPvXpQeAOn9QS9qzNaLmbhCahpGMw/NLHZmqxzYfXgoX/w
	PBj/9c7J2PjXQUb1mEXPjZJVTqCe/4cq5fmTt8VuVKs6YxJKxbGrO7qIxRRMWkjr
	HpWnIrADBSkqULQn39BQE5OgvV5nl3CG73R3nYO7+K81esvqVueRybQgBswE99BD
	eiC8w6cXR3hgeKb+Uygq78a/WGSsbjWpElgJJBkjr9/5pboRrPfXElxt29LD+Ksa
	hMGDcVGY3KG6LgHuSKnl5+uhHFc9ExcDOf7+qYhYJFspsyr2qSl6B5ZVXU2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767981976; x=1768068376; bh=iy3ZEzZkIez/sa1h24xPVU3fsTbYW3wKgLz
	wG0FuBGc=; b=wm5+EDjK//0eDDm5urdTRl+3/aRP8a1xXauwtuhpCPl/4PtrsST
	sga2v+L2oW8s0MF2Fp7JsY36ajtdXR8gPpm7lCOQ9Dc6nXhXbEo98vNI8yNe5v3I
	pBi3gLyIGHZ3BiCTl1T5Rd3oDwWo9jyUOfbxvm3Nm4shxnm9DTuEnGzyjf/Xv6qE
	0aqQlAK16OJwkZ+/0tVF3/2vALth8x7Gbo4BhVI0gQX49gf5G8LZE/rQkhssL000
	xZJ5TXmmnbu3QTj2uQHbmtNaK8CKeZNfjAQbjuAtWid/45+I5wrNT3/9umKfjiMm
	QcB3tbbt6UtbOlcfY8/WixNbD1tcp9fQbzQ==
X-ME-Sender: <xms:mENhafuBZSCSLMWmTr0OsTvuA1uYn_RH-pNVJNqHIJxohvCyEbL4vA>
    <xme:mENhaWd591NajQU8WhNkbHe3waVRrED611Qm-cBxo6vtoUXCm-NQTli84_4KgkFcj
    LlgV1UH9xqiDzyui_LUjh7tqxcYtvkFjV0lmmduDE7G_gIKm7mwfuU>
X-ME-Received: <xmr:mENhaQYxrog-A9F862mmj6Otlr3C385irb1YhVHpADbhd-XBp0nbFKD27BU25xZ5ZT_jL3MQYaxWUulKoZ05yYPh2EY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelgeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehjihhmihhssehgmhigrdhnvghtpdhrtghp
    thhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mENhaZWMmD_PnIWQYK8M1ujbft9CRalsdGJ40zbc05nVj-s3j4l1Ow>
    <xmx:mENhaSg3ZNsQwTpI8kTuN0F9OlwzuzFwz6Q8iwhhgkzvQqqNLwsnQw>
    <xmx:mENhaXVXsZm-wtCdhpibFtwcy6RcacF5LIwbG4Ki8xrKWR9gS_39pg>
    <xmx:mENhaZMNhrZIxfrsPVHG7NZkJwezYpnGxxd6i0p6rIWobZoGuqO6Dw>
    <xmx:mENhaXQz7SIE5JtXLUzKVncDKxN5agYr6vUYyTNecKPvyArlFVH-CSMD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 13:06:15 -0500 (EST)
Date: Fri, 9 Jan 2026 10:06:23 -0800
From: Boris Burkov <boris@bur.io>
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: error in btrfs_create_pending_block_groups:2788: errno=-17
 Object already exists
Message-ID: <20260109180623.GA3035730@zen.localdomain>
References: <q7760374-q1p4-029o-5149-26p28421s468@tzk.arg>
 <20260108225254.GA2633085@zen.localdomain>
 <s7rn1057-p146-7p9n-17s2-oq0r2n642756@tzk.arg>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s7rn1057-p146-7p9n-17s2-oq0r2n642756@tzk.arg>

On Fri, Jan 09, 2026 at 12:18:43PM +0100, Dimitrios Apostolou wrote:
> On Thursday 2026-01-08 23:52, Boris Burkov wrote:
> 
> > Are you able to reproduce it or did it happen just once?
> 
> It only happened once. I didn't try to recover the fs, was worried about
> future data integrity.

No problem, I'll just work on reproducing it.

> 
> So I decided to follow a different strategy, copying the block device
> containing the btrfs instead of cp'ing the contents to a new btrfs.
> 
> If I see it again, are there any debug operations to get more info?
> 

No, I was more hoping to instrument a reproducer. I have plenty of
examples to dig into.

Thanks,
Boris

> 
> Dimitris
> 

