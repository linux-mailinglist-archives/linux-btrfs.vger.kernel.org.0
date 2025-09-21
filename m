Return-Path: <linux-btrfs+bounces-17012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED7FB8E315
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 20:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF52B3BBE9B
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711D254B19;
	Sun, 21 Sep 2025 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="UlhjmFlv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aspLz1bd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC9124729C
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479158; cv=none; b=K2HUGvq5x7ToiG7BasOAUjPwgZ7CifR7tCFGJErKhK7dCPV35aZve1CYZPZ1/wlbylg2f5J4kg1Z1bNxXUDVrGscQBGPAnoUnkDoYD1d12z0WKBNsOnegCLXeYaC5WVEvr2fA3dJ29SfTYwN5svhamOIltjXcIyE34mfTE1XRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479158; c=relaxed/simple;
	bh=SC7Tv9z1EYzOJdRLhRb1092MC5ZNma1VIl6soztBpEQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=acjRrnYD+BSZJU75SsE2gdThseEHEX+coxXfmaaPzVKbRwwdhFBmhYqG3FGQskOPEdx2DXF20iSpUvseS9htVbe/y2Plp2xhGyE2gSFLeURi5GtcyQmMjQT6SyO/Fc8mkzI3mHyfM00a2Due2BtagSfwg5GGSeu5j5joq8+x72c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=UlhjmFlv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aspLz1bd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A803E14000D2;
	Sun, 21 Sep 2025 14:25:55 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 21 Sep 2025 14:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758479155; x=1758565555; bh=Kflys6N5wV
	T7aTb+z9X1FOd3MRX1+8Cdvf3EnX7Pbco=; b=UlhjmFlvuvSWCRMEshKt820d5Y
	0POVdYiW6RMB87JOWknANjGv0E1CYvwXzBig1S525PAxryWWKmAtylWGEP3WarbW
	csYWQxbnwL/lSh1ClnX/KjFu/qwNJ7XloykYk1VdVvYRWudJZkafY2PXgMwPhhyu
	C30F597yv3Xoe/3RjEr4lkeJ9dblGtVHBjVFwujVLW9arYY0t5a26xYQNuK5jEye
	uiH920AFAf8usrOxKQiorXtWSluOivd8U4yaD0iEO8tRiIh6GUZcOVnk5Lk4677m
	7CTx39Uvz5adYT3Dntz0hA9XtllQO9NVMcnwwC5FOkaI/3Cvp7NtqHuU9J/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758479155; x=
	1758565555; bh=Kflys6N5wVT7aTb+z9X1FOd3MRX1+8Cdvf3EnX7Pbco=; b=a
	spLz1bdPWRRa/6UTdQXV9UDSe71Fn49y8/BC/mzrsjzE0f6C2UgaKYW7lk2DYTiR
	3kL7VYIrVEK4ney8yAA4umMm+NgSVXpqfAAZ30FC6zZwLgCKg4ir/4sNQfy8HRMd
	WL7xWziZeggLPr4leImn/67yvyWowW66dGhdnRtWoCTQoXlVjpRiN+W9LC/h2EK+
	ikrD03OSlrAzGJyFG3mbnmNdSoBNtia1Jm5pUTrT2CAXArsze6Y44Pek2BV52LeR
	lQhhHCxocys9Jf7x/vB0sNmRTrlEwLSzObaiwWToQRSlaXX941xbX/ootajk8QZl
	AabV+TmxM1Gfl3ULcnamA==
X-ME-Sender: <xms:MkPQaFqLZtZiXv29YGztc8zGuaufZzX0Zsxxc4PYXHS6k1xEgR0I5g>
    <xme:MkPQaHpNyjWNFyexvpRFhLD4mptZfBUhTlvwxQlXoLu7NaTdWfTj9b84yhbF6-qh5
    nwKj2eFPOOxbDRgpSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhephfeuvdekteduhefgtefhvedtfeeigfffheevhfevuefffedv
    tdegiefflefflefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhksehhrghrmh
    hsthhonhgvrdgtohhmpdhrtghpthhtohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtghomhdprhgtphhtthhopegush
    htvghrsggrsehsuhhsvgdrtgiipdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MkPQaMogNBJL3VM_LBjlYckgTiw2vbDEGPaACGoKSUzS4s5rBxsyXQ>
    <xmx:M0PQaPwu9TC3xi1YCLETqs9e-sV7mZJ1PC4_G7OayypH2wozHLDTrw>
    <xmx:M0PQaAPD5_yzy-m0EKlEXGAeDKXLHvDfTtfFh6qjLwSC9i_mZydBKg>
    <xmx:M0PQaE4C4J5ECJW-PNyKegOFD3ulvMCC-w-pUH1_0QWMAjV-ZZHKAg>
    <xmx:M0PQaOajMWAR6uVPDGu0pHY8E66X6Xd_aMWMKIxkwyWH8S9IbUMgXq1B>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE91718C0067; Sun, 21 Sep 2025 14:25:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaEh5dAqTB3N
Date: Sun, 21 Sep 2025 14:25:34 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Mark Harmstone" <mark@harmstone.com>,
 "Filipe Manana" <fdmanana@kernel.org>
Cc: "David Sterba" <dsterba@suse.cz>, "David Sterba" <dsterba@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <a529e1bd-49c2-4463-90fe-847dd2c128f7@app.fastmail.com>
In-Reply-To: <eaf33285-5d77-4b7e-851a-61e40e61d3ae@harmstone.com>
References: <20250910175007.23176-1-dsterba@suse.com>
 <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
 <20250918003344.GH5333@suse.cz>
 <26c2e470-6277-4957-8b8b-b12a2e567daa@harmstone.com>
 <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
 <eaf33285-5d77-4b7e-851a-61e40e61d3ae@harmstone.com>
Subject: Re: Btrfs progs release 6.16.1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I resolved it with a single command: 
mount -o clear_cache,space-cache=v2 /dev/dm-1 /mnt

clear_cache alone doesn't resolve it because a subsequent mount creates a v1 cache by default (kernel 6.17.0-0.rc6.49.fc43.x86_64)

My question is if it makes sense for the kernel to be capable of, by default, fixing problems like this? Future feature?

For now though, the `btrfs check` message lacks an indication of the (un)seriousness of the problem, or what the user should do about it. Maybe this message could be prefaced with INFO: ? to suggest it's just an informational level concern? 

The problem with the message and documentation is users are being advised to ask a btrfs developer or expert what to do about this message. So I kinda expect there will be messages on this list from users asking about it.

---
Chris Murphy

