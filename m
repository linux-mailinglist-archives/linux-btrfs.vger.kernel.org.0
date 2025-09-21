Return-Path: <linux-btrfs+bounces-17013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D7B8E343
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6127AFDF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Sep 2025 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F81A2392;
	Sun, 21 Sep 2025 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="ENn+4F1/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ujf2BbIH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5893EF9E8
	for <linux-btrfs@vger.kernel.org>; Sun, 21 Sep 2025 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479593; cv=none; b=IkkHcIl0nxW5Oi7HnFglpFCD4RugBeevklru00AXkRsIq6ilR4fCcYCUtaX4XKBNcuJN6GwCzfdhg6xoVw2oyu40OWgtIEQX+PU2CQCMZPOv9+RpRxFAyz6GnYOYjzCm+jag3AYufuEGqyH48wT4qcGPvgJQdMdD455HlCn35Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479593; c=relaxed/simple;
	bh=t4Ih5huGAWycLYumidSbKapX9vhfSubt+yQvWlul2QE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ef6AoRxNsxWC2Fk5yX17tgLmuS9v7gAil5xekLYqAgSolvfbp+4WJ01JMVqNO/qpb+xHoKJ55XChUx1kqAFgJIOR2RnMPi5cRmG2RpZ4lx5yK22TalnDRwvro7fAGqJQ5OitlcNiy7wsUFwFiX3vuAf2kFyL56SrQRVYng7KgEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=ENn+4F1/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ujf2BbIH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5D53314000AD;
	Sun, 21 Sep 2025 14:33:10 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sun, 21 Sep 2025 14:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1758479590; x=1758565990; bh=HBT9Oh4aIu
	33BAhXGHm0omsXk+RlP7wBQh5dVfU54ns=; b=ENn+4F1/Xvq20cwFMzGbVriJrD
	0nLl/4atrzOa8TlzJ3KhttvwOw6RxMJHzmVD0t7AIudKBt2N2CskWmlphsnnsOmh
	tzyMyYKX1vxJlooBzf9/p1QJawL4BmA8nxmiu5hNSKwJRYIIht5yEG2lSGbmJ4E2
	4mZJZk1JeXL+Xzcv9bbtN3A/85SsRlKkwJhtjbThLQooTBskf14xLN3jAQIdbGtR
	CEnXYTAO35G9oIX25CEH7dXekl+Zh/FBcjenUYnogauavqXTn9Nu0TRvzByMNX2w
	c3gSQeEc4vO+r68FSa7/AdRWBqrjUIfruuTvDMj9xtXroGizGYGMBKoNZqVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758479590; x=
	1758565990; bh=HBT9Oh4aIu33BAhXGHm0omsXk+RlP7wBQh5dVfU54ns=; b=U
	jf2BbIHqB9n0U0IyrpQ5TzyqCIenhUQrwKyhh2oEDdYbzJUA1AmiDyZegnSPjIwl
	xS+HYWztiCADhnzn7OybrOSCcMUYqmcokNT4VcF0RwamZBnq1xb6PimqtmBE5IVb
	6pj7hwTquLnVmkb/WKqgY7fKwlLE0TizjJ6CBR6Lr0/daAajTMhcu/UOIQzHSOqy
	8FHBsYJMNA7S6PGbwhkI0Aq2bhaKrPIZw/rakPl9vDcDi2Mo7ofd6RihwtkM+fFO
	X9G4Dy1w8VBGP5A0hwN34MXSQtFLXzVDlM3Tc2Gjcio4fThG+uP16rtEGGPRuQrW
	AixptsVFRYCfelX2+Eutw==
X-ME-Sender: <xms:5kTQaMsq-_BftR-68LgLs5EzvxonrppFVEUDyJyiEPlF3TYYmYPF3A>
    <xme:5kTQaJe2fQjLCK2Wy--I-jf5X9SCyld8ygEwa0UWgCoyqPfJ9E2rFAklg-LmLBg5p
    RFYmM-gQOSjakCTs0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehheejtdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:5kTQaKOQQzndRT42xF23tyimUiSCOm9M6_P3VMT2FydohY75cbIU2g>
    <xmx:5kTQaGHEEPsFFGU3qWMhJRL0tkZzLMRzd-l1JgkrSoGKN2YJB9rOBQ>
    <xmx:5kTQaAQd-yFPYQ23LQwBVAKcPdP2sbYs0frU_CwyOIxrTAnIurhUMg>
    <xmx:5kTQaLs65qF455MM4wqnRCmCDQeNoEkreY0LpsBasUowJwSB5UCGFQ>
    <xmx:5kTQaAdmaKlq1NFFJSB4r8LyeM7tcZNAWe4Mi2pCdppVkhK_sBEZYzRi>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EE22418C0067; Sun, 21 Sep 2025 14:33:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaEh5dAqTB3N
Date: Sun, 21 Sep 2025 14:32:49 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Mark Harmstone" <mark@harmstone.com>,
 "Filipe Manana" <fdmanana@kernel.org>
Cc: "David Sterba" <dsterba@suse.cz>, "David Sterba" <dsterba@suse.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <270fb896-5128-478d-a338-8ac4741abf02@app.fastmail.com>
In-Reply-To: <a529e1bd-49c2-4463-90fe-847dd2c128f7@app.fastmail.com>
References: <20250910175007.23176-1-dsterba@suse.com>
 <CAL3q7H4vXmz4pGXayq98XZqPbFh6H6Z4=eaM-gFX7fsRLnFfEQ@mail.gmail.com>
 <20250918003344.GH5333@suse.cz>
 <26c2e470-6277-4957-8b8b-b12a2e567daa@harmstone.com>
 <CAL3q7H4WX5XddPyQ2+0a8yQaCW757+V8VVVO6byscY9ch+LzQw@mail.gmail.com>
 <eaf33285-5d77-4b7e-851a-61e40e61d3ae@harmstone.com>
 <a529e1bd-49c2-4463-90fe-847dd2c128f7@app.fastmail.com>
Subject: Re: Btrfs progs release 6.16.1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sun, Sep 21, 2025, at 2:25 PM, Chris Murphy wrote:

> clear_cache alone doesn't resolve it because a subsequent mount creates 
> a v1 cache by default (kernel 6.17.0-0.rc6.49.fc43.x86_64)

OK that is wrong. 

clear_cache clears the tree and recreates it. A v1 cache is not created.

If `btrfs rescue` is used to clear v1 and v2 caches, a mount without options does create a v1 cache.


-- 
Chris Murphy

