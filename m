Return-Path: <linux-btrfs+bounces-22013-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HWzN7tqoGk3jgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22013-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:46:03 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D9D1A90BC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30F053072BE8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7B641322A;
	Thu, 26 Feb 2026 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="BFOz5yqx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fc2ByHch"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7B3F23D7;
	Thu, 26 Feb 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120637; cv=none; b=exhMYR5bVN8UZgvJSA5f+PegLIJHmhGAHGggwdTb+8sgyz9kx3Q8c5PWsnl9mDux5wRAuWqLm0YD1PtKj8AjpcSDLDlarY9rR556lgkxJ+KvLeKh9OJ84p5OpgmA/V+4ldXaNoae24g5nP/sf2a5ZycqZplnJH+DATwvgiQmuJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120637; c=relaxed/simple;
	bh=zaIt+6c5Z6aF5nOzcYBB7QJkaXuFxNxAQjsZxA8CeFs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g+6q2aNlB2JwDgGhAh/NfCTcvMCUSyFcfJn+E2sTopOVyXh/fRZ7nKXEqeCZKtcHAkSFXogZKe1+BxlTVCPlAUFzsGt/6Z1yuuTWQCn11Bm9t6wUdokmgaI99e0UGasH//0Msd/TyR2Y3EcaqDi1fo+ujYsDSHznm2QzYeSBfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=BFOz5yqx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fc2ByHch; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 702FC1380BA9;
	Thu, 26 Feb 2026 10:43:55 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 26 Feb 2026 10:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772120635;
	 x=1772127835; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=
	BFOz5yqxSmg9S50IsSdLRGyQHw6zGY1eOdKa+Po1ZziBbN2GJ+4j9GfSK2vBzpb8
	jke/0DjjeJ1N27rCrrDV17hYarBNm1Yv5Ef3DpswEsW5lXmy5P2MpCy6/j4n03oF
	6AXtPA/NP2OgKRV62bfh5y074ZgZyuVK80kBotJiI5viaax3nK4TDXtsz7/fmWKi
	Idb44puvspjnRxIVW8rRiXroKSe3UOJgw6SBDrDW/b4nrdVt9gRrGH0VYyTCCFI+
	MaLql0ByGC1lAPGvtsNQy7knHDrJrYmiw6Z0TH7LP/fMQ/mbjchvlBUub+fpzM0z
	AwgDVPMDWtHsSHNybdc70Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1772120635; x=
	1772127835; bh=5NKb8s5uQsJxGoQ2AVBEtObpQ/CvaKcz4OqTIpIkbmc=; b=F
	c2ByHch3ij59MUwgdS2tUPIb02ImNYf+PdWdDaqtx5ATw62eUpliVMY8iV5D7hR3
	wYi0CHEzfkgh/mmBuCbJYAChbEOC/Yi8PJeN5l62Iy2psmFsZrqPUq0n/+vZEsQO
	qYjytQD72iqh1ghXwEeBJ+WUnvc4Fp1Jeo/4mgECJRniva5kBNFlm6iANF8sqab6
	oNPUlMV1dQUyv+GQi7/PfCZFIvgRRn3B9r6NcepO1/wYvQBeHCR1LEsGxh1+Og4p
	FYPE0U4hjheq9evedYJAexwrwIPKQjOD7fllTYCzxyIBPwHANOFBQd6w9WsyZAmJ
	opoR4yIXQlrQwxqExmjlA==
X-ME-Sender: <xms:N2qgaaQjbD4lDTTpYYJW04n5-N_REynhDJNOjDcAsLpq8XoFDTIP1Q>
    <xme:N2qgaalYz6oAwIkXti0ilmTZ4SAWzxEhI78J-NBiOcz8jBnpIMTvnyc8aM72hc_ES
    ARSAHBEQvzfvqva9WEslWopqCs96M2xP3m79vrzlriTC5w2htjwEyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeeigeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegtrghtrghlih
    hnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhhtohhnrdhivhgrnhhovhestggrmh
    gsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghpthhtohepphgrlhhmvghrsegurggssggv
    lhhtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohep
    mhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtoheptghlmhesfhgsrdgtoh
    hm
X-ME-Proxy: <xmx:N2qgaUJWUEXUlLEjkxtJWtWBvZvargLkJYDYLT1WCObuQQIhrpl4jg>
    <xmx:N2qgabuNvv7e3NmdoP0u_IPqZN1TMDnyqD0tO35lBUa_NaOCzbSmCg>
    <xmx:N2qgaRqz5OOPUoSW-rsw8dZEHVicCLZG3p0s42DHReFDaNuct761aw>
    <xmx:N2qgafV0jsQUaX0mdJgZVSo50cBCHJXR9outsNs-5KBrOO1PzPsRXw>
    <xmx:O2qgafUJmIOfDaRuA5FfQ3utukV1YK4slK3UAvn21GEOucPhAX52tGfc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A0F9D700065; Thu, 26 Feb 2026 10:43:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AQu7KcbS869J
Date: Thu, 26 Feb 2026 16:40:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christoph Hellwig" <hch@lst.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Magnus Lindholm" <linmag7@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Song Liu" <song@kernel.org>,
 "Yu Kuai" <yukuai@fnnas.com>, "Li Nan" <linan122@huawei.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-btrfs@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-raid@vger.kernel.org
Message-Id: <29afa24a-f659-481b-b5a8-7b8b9e009755@app.fastmail.com>
In-Reply-To: <20260226151106.144735-10-hch@lst.de>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-10-hch@lst.de>
Subject: Re: [PATCH 09/25] xor: move generic implementations out of asm-generic/xor.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,armlinux.org.uk,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,ghiti.fr,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-22013-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,lst.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7D9D1A90BC
X-Rspamd-Action: no action

On Thu, Feb 26, 2026, at 16:10, Christoph Hellwig wrote:
> Move the generic implementations from asm-generic/xor.h to
> per-implementaion .c files in lib/raid.
>
> Note that this would cause the second xor_block_8regs instance created by
> arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
> code, so add a NO_TEMPLATE symbol to disable it for this case.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> 
> -#pragma GCC diagnostic ignored "-Wunused-variable"
> -#include <asm-generic/xor.h>
> +#define NO_TEMPLATE
> +#include "../../../lib/raid/xor/xor-8regs.c"

The #include is slightly ugly, but I see it gets better in a later patch,
and is clearly worth it either way.

The rest of the series looks good to me as well. I had a brief
look at each patch, but nothing to complain about.

     Arnd

