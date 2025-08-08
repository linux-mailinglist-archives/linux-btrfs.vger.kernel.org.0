Return-Path: <linux-btrfs+bounces-15939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCF5B1ED03
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E805D18C80B5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17550287278;
	Fri,  8 Aug 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="pQYB8GlA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rk7+6wev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366B7404E
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754670486; cv=none; b=H1lnRD+Mhst0Pzwk68CZrr7P8Aa9H/sRATUPsl8sbMz+1GKy8nDQ7V4yG+2SCiCXqRBzywbYL5NHPN2YE1azIZUjrRyJWiqf1qP9MT2E+okebr+S4GPfE6KtvLuN5Czs2NjLFyszqEWjXczlmpA9BKx655ioelLo3VImrhgujjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754670486; c=relaxed/simple;
	bh=BcymXVGhX1vG1CjrPlCeq6lerwYhsSrOJ3ekcR0c3FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRzMOtYcmfCmy//HLrYbHOZIzEeto1Vuxhkdq2Xro3MeRSByvvzgWSShKc9+5E8V+ty8AEZaNYINu8WQgFx4K5HljWWoovlwAuKqqCeRekLLVVXlN4n3jdx+ZMO5ydnk7jWPRfn5R/ySPNArhBi+2rnOhSqe8R8lxJ3Mzg7/DmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=pQYB8GlA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rk7+6wev; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D60B1400088;
	Fri,  8 Aug 2025 12:28:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 08 Aug 2025 12:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1754670483;
	 x=1754756883; bh=AKbb3PKHvw2aHIvcUFjPJ/pUV1tc01A/0FgGxxM8+cI=; b=
	pQYB8GlARRXpPzGrPilI4gXmrPQ79a2CafmZN8URLRum08dKaqJeMuyNICOtR4Y+
	uz3/8kBngaY2DbHMw86+7aM791k5sGja8JL4E18VRR+YZjOuV7Jl7hFQTmbBaYZr
	n/gw4/C/Qwgyxh0eU9SntMyUhZ/EhGDfruXVhI5//P0wN/vgiUv0mZEI/9NW8yTJ
	2KcZThGoSLsnBAmrKapcYRBC0fNGQTn3ly9PP6+nPlIarUYLnG93FlnGV6BZ0maM
	3rwUwcePYHQAIUSDL00dFMGhuPSD6NBRsZHYKzlVmbMTx0ho+xw+QVYq2x8Yzrhg
	I6bjNrRAZtdF03vNJ1hZBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754670483; x=
	1754756883; bh=AKbb3PKHvw2aHIvcUFjPJ/pUV1tc01A/0FgGxxM8+cI=; b=R
	k7+6wevSr7VVmWaxReIvhIgGBZ0dcO9T+yb+q1U8rj/pu4M9SmU+lMhAzk4butIH
	k1JHpNl/dOu0j23gIqAtUiQBtakKF0RmarrLP/xx1XNI7FWzpybwrcE2bgd12mQk
	ox4s1hSG5qpzd1xjb3TDBsA17yW9ICC3S+TsIFjHPq7jBUcb+kxnGFAQeMdvKGsy
	R919IN4U4kDeY+2PXVvLCDKKFWETL+AY9pqObXvEPGCUgwBAGc72xyQup+X3DOme
	K9od4vvmv5AN3Xo4yBWpkJySCbw1uvg56Ktn7N+ERCpgNWsHP/RRQ1TRyH7R9VwV
	fUDCA+CwmIzPA3ZlBhByQ==
X-ME-Sender: <xms:kiWWaE2n4HRmAvH8suXOQ-zhKih75WsHRx0A5oGER2PiHDoRgTgk_A>
    <xme:kiWWaCVycM-ej5kpYW1V7UNLTUi3DvtDtqidL9QWd3IRTynCpJ-1jjOmDiFutAkqc
    AYQhOFWNhwdQP3L5Do>
X-ME-Received: <xmr:kiWWaGVbVJJzeqcyi1TGYH4Izw4xJ9kWSdgfQLKiLHgZ1CHX5i8yhPQWHA23_6LtATTz2Pq359dC-aGELe6xpHazowE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopegrnhgrnhgurdhjrghinhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kiWWaJcjhVlJ5o6IL1GWv-DAJRyI-yWkXcbpt4ylYg4gVmJm-JWD8A>
    <xmx:kiWWaHVSb4ectikGGMswn8p2jG-3PM49R5sErtJswZuS6qgycZZFxg>
    <xmx:kiWWaKdDKpZprVjBq0M8ru_2Ef8lJUp3qT0EVYVOgiHQruw89pbEYw>
    <xmx:kiWWaLOY6XtaBSoOBRTsO0N00iwqJTxuRLS4pYJGGimsX4-CB2ifkQ>
    <xmx:kyWWaPbwEhIXBEo8i72SAGfZneuf_cERI15Ul4VGtNFMpCj6huXPQv0X>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Aug 2025 12:28:02 -0400 (EDT)
Date: Fri, 8 Aug 2025 09:28:55 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 5/6] btrfs-progs: add error handling for
 device_get_partition_size()
Message-ID: <20250808162855.GA2410255@zen.localdomain>
References: <cover.1754455239.git.wqu@suse.com>
 <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
 <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
 <531a7c76-0b6e-454a-bb7a-3fc3ee0d95ee@oracle.com>
 <c709e1b3-f57a-4c34-bf28-d00694c01cc8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c709e1b3-f57a-4c34-bf28-d00694c01cc8@suse.com>

On Fri, Aug 08, 2025 at 07:01:47PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/8/8 18:56, Anand Jain 写道:
> > On 8/8/25 15:23, Anand Jain wrote:
> > > On 6/8/25 12:48, Qu Wenruo wrote:
> > > > The function device_get_partition_size() has all kinds of error paths,
> > > > but it has no way to return error other than returning 0.
> > > > 
> > > > This is not helpful for end users to know what's going wrong.
> > > > 
> > > 
> > > 
> > > > Change that function to return s64, as even the kernel won't return a
> > > > block size larger than LLONG_MAX.
> > > > Thus we're safe to use the minus range of s64 to indicate an error.
> > > 
> > 
> > > Returning s64 is almost unused in btrfs-progs; Either PTR_ERR() or
> > > int return + arg parameter * u64; Rest looks good.
> > 
> > correction: almost unused -> mostly avoided
> 
> @Boris, mind me to revert back to the old int + u64 *ret solution?
> 

Yes, that's fine, sorry to send you on a yak shaving quest.

> Despite the fact that s64 is seldomly used in progs, I also feel a little
> uneasy with the s64->u64 (all the extra ASSERT() I added) or the s64->int
> error code conversion.
> 
> Thanks,
> Qu

