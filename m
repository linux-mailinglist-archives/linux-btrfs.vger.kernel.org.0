Return-Path: <linux-btrfs+bounces-18127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006E1BF826A
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DBC18C1E5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1F034E747;
	Tue, 21 Oct 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="ShnJvo2C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7eT4IeL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D86234C81F
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072773; cv=none; b=HPzfaotd9IHpyd0oefdRPyZDS6gkmZtiNgP0Q9m/23y1u/vCNB06LPRDnWyrBDcBTnr315zu7dTi8RRfosZkbCPE504hXQsb0eH9olCxsbrDH1CatHYTCsUqfqDbuMG0zLQvk9nQm9a2PShw7ZcS3Ihd5HgKkkGQ/GSKw/CTZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072773; c=relaxed/simple;
	bh=dU0p8FmAoMG3nTlhtp6o0EkJMiPuFuqbl3xwg0DlJ3M=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:Subject:
	 Content-Type; b=UiChH9R7MDNIMYcKi4IQxWPNqhmvBO2yQgdzewhVhP1Ji64sXvqslVEWVDsZPRYCGDwcCb3KnnuDyNvZu0le1hur9N4nUYLcTiWitSb/4+swwTQZn32/VX9RWx3kKpu00C7edzWAWwU+QZi11Zihf2SCNZWBZHBirZvkXi5GR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=ShnJvo2C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7eT4IeL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2BB2614000D7;
	Tue, 21 Oct 2025 14:52:50 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 14:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1761072770; x=1761159170; bh=dU0p8FmAoMG3nTlhtp6o0
	EkJMiPuFuqbl3xwg0DlJ3M=; b=ShnJvo2CFBFTFcCMtxV7g9SdgVnvkn9CISXel
	5l13XfpO5FVdGMSRWq544F9+BtZ7yGW6alt+qGZ8R48c00Nx+tS6bpBOWsZggnSG
	gAY56hDhE6IEVLmxIA/2C9LCss2VPNz71QsFaTD0wJZSPN3uV4NU07J/Z5l5ambi
	dP0st9CJhumFz81f7TukTEiFVDPZSSDe7XOyRLa6915T6URNJSF37bQfpZNbuyxY
	5Vk9b59c3/BpVmrjVJFuxlELwozoj7wiyKacLBu/OFcFDJEK47vW59YA6QYSsbW2
	X8ojDeFkuNreKgophmoZSEhxa13kinh6iWrapj5hsx6kLrZzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1761072770; x=1761159170; bh=d
	U0p8FmAoMG3nTlhtp6o0EkJMiPuFuqbl3xwg0DlJ3M=; b=b7eT4IeLk/ETgFi7X
	FJ9A3eJmyF+r3PZN9rB1P5t0DYFRNe1Ktn8LfNoJXaDFVMgvbewBIkArqib2Iue6
	keGv4eOc693GrTfYlfs93YS9DWLIKxrCQ9iczE7Pta47Fp29wUEzbphQNx/cYt5T
	q6R/MVWDYtVHarzlqhsrk+TkedFPEH+eAf/KWp58iOIlP7263QpyzTMcse+T1GbD
	iPdrjfNTV78OD5WMB39/9t0Fj7wKg06mgygtK9G0gyeqHeezFuu82MzR/thBdcHz
	h4w+vFy77E5QYgba76u3HVZ7pHjqQCH3/VdENgarMBfo6+R/DF1PO0ZqQ68W5Goa
	NaDaA==
X-ME-Sender: <xms:gdb3aKzQUyUyLRsexQBEKXgIhhbNZtrO-Cs9Spd88JKK41A8Aj4ItA>
    <xme:gdb3aBE1SZRge_3Y0CaRBHkoazbIHiKb3XlH9tzxIhwno3HA2TUPmtN4l76_RhDns
    FrpbGsf2gc0fq8kob9U71Z3yDs-rgc0Vj7TIx-Pi39WnW7wnEx15YM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedugeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhs
    ucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqne
    cuggftrfgrthhtvghrnhepveeluefhieevjeekleeikefggfeuhfegudeuteevudeikefg
    gfduledvvdeffeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehlihhsthhssegtohhlohhr
    rhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegsohhrihhssegsuhhrrdhiohdprhgtphhtthhopehkvghrnhgv
    lhdqthgvrghmsehfsgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gdb3aKMDaCmYlzFhyYqrmxKGFcZ-W9fVz2vrBLIFWPACe_Al5oNoGQ>
    <xmx:gdb3aAuCnLGs1CMm8-o-92tQEHEBCdqWqqgFDydDZ86cdTx6CPE5FQ>
    <xmx:gdb3aEW8_hKtbYcYRrxyvYT1Ay-_p3LMWcGmbXIEVuw1rK7Prh3ehA>
    <xmx:gdb3aIuoyWMN7E9PEV7lFVoB4XgYbEL-GtZk6JuhMaEj1QJKgmSJQw>
    <xmx:gtb3aKW7EKvP8KIwlrcBA-k0ZIeSoKhzId20UEWAEYOZ8Ur35MJWCiQ2>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 991DD18C004E; Tue, 21 Oct 2025 14:52:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Oct 2025 14:52:31 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Boris Burkov" <boris@bur.io>
Cc: kernel-team@fb.com, "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <4c595af2-f06e-4957-9f08-67a78609901c@app.fastmail.com>
In-Reply-To: 
 <52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io>
Subject: Re: [PATCH] btrfs: make periodic dynamic reclaim the default for data
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>Tue, 15 Jul 2025 11:58:24 -0700
https://lore.kernel.org/linux-btrfs/52b863849f0dd63b3d25a29c8a830a09c748d86b.1752605888.git.boris@bur.io/

Fedora is interested in this enhancement. Any idea when it could be merged or if there are any outstanding concerns?

In particular, I like the lack of knobs. It's either on or off. And it has no effect until unallocated space drops below 10G means it's super lightweight, affecting only users likely to end up in related corner cases.

Fedora isn't installing btrfsmaintenance by default. We do see infrequent cases of premature or misallocation out of space. It would be nice to have this "it does nothing until" type solution enabled by default, if it's ready.

Thanks,

--
Chris Murphy

