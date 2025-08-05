Return-Path: <linux-btrfs+bounces-15859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95AB1BA51
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C1E180EF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253FB29A9CD;
	Tue,  5 Aug 2025 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dmrJx7GR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LKR0jWkI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8019E98C
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419045; cv=none; b=KRX0xaW5nAiT4dzXTNaycSdbPOCGK50VDLZtedkk1AkMd5NZaPttNabSFBmn36mJZL4daFczsU2LjwJQGYSM7VTM6BgFQ45hbMWthJLyqD5yBTMmAtbcaAVwhBBgtbXkQF536lZYvQ9/24/Q2umXIybWunesRIJxYJpGtidfKgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419045; c=relaxed/simple;
	bh=lbh67/n1bQTYMdSHQa2cHFRDgfjOROMSmRhWX8GaQWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0G5Rgd4emX23yPf2yfhmAEgtAEhiyuyfeG1lt6L9XZDdXgNnh/8QpQJBLJ3jcrnDX4LLmzHbXhrsp9L4j65aZxBvph70PQEoaUZU24dOwF1p0DRRP2jUocKH7xpkDkvgtKpvqBf4B4SS9ANWgw4/Ijff5VJQF1nT6MtvrofQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dmrJx7GR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LKR0jWkI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4532AEC018D;
	Tue,  5 Aug 2025 14:37:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Aug 2025 14:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754419042; x=1754505442; bh=eZf8bZzmdo
	LM0yglnPKwKMTkdzS1E8+KqC3xqOUotTg=; b=dmrJx7GRvImezfHpYabSaB1ukq
	OV1mVjdb40N1DPVTGvpYf4jBvL14eKoTt0bdv3NaAiV6AIdDkBI1kTCKEyjyDTs2
	mq7GC/MuCFpdhDuDGWlDHgA9WqNAHwJvsgIPcLi1UCQJKv9KtiQY7Hm8+zhqvJCX
	pxflGmGMu2v/SHeNsnfojftq8JGKhq0RGbFPoBd6+1XjNCv38XHLwqNrq+PnJcou
	VvUBxbwu47KGNUXUF2CkZ3OAXQ5qiow1SRcpftTsClxEzkNJoXQhmonlLj1kOzz6
	9rKJQO0y7TkndKB5DGCeHzTko4l+4ZvlzEvePoHPX0WTNVPoRTRGFdJVxvAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754419042; x=1754505442; bh=eZf8bZzmdoLM0yglnPKwKMTkdzS1E8+KqC3
	xqOUotTg=; b=LKR0jWkImx7VA5BnAhiqZCdw/BlSt9mOf34Wi5HukqMv0bwOIAd
	cWrCs8FQ3ivaj7bfzHu+5R7folUDIOEZUSlCF4OvNop4ZaeZRD9T7dMme7VPGGn3
	f1KBscs7OIns83w92x+Sa7ZmUYfD7OFMzgIjV5/bJZ9iTVl7C+ujzrQOrW1YysVB
	f9cmcaW8zjSOT7D8BYMDjjNLharecne7BYkQ8kbg2M6RGtByH6e/tpVTUsYK3IVs
	Tr4OhQx9zxj/hNrNfHXFUsDo2/6IXQiTlfbkyIyaO1xJ0NmXNVXdddilLZ/aG2L0
	TGnVxiM5G3BxecsTk+aHlFO9+ikeabMf7Vg==
X-ME-Sender: <xms:YU-SaNK91IHJ9tF2DEfEHEv7AwoSZSfQxkrBSz3phdXbkOHvNaQjxg>
    <xme:YU-SaJV0ALjEUCnBRzikvA0W0Tdo5suPYzYLICW7fP2ExKf9lJeRMuTU2FPEIowzR
    kZi9rCpNMiTDGGtrUA>
X-ME-Received: <xmr:YU-SaHjKJZjPnIUbGRKOpNF4bNzEEs2iXFl3F12ThYAR5D5pwQWMsRdGpcMEUxYXLa9NPk1fv2J_uvlwOHQxYlhdm1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Yk-SaM-CZVz2tvKa1-eREvAxUsPcqlpnIFQU5x-9Lg1vQvu2CscLAg>
    <xmx:Yk-SaJCXKkFPWOirEwJ5yFRg1yAnD4WQmqPCWO6k6QVQW5zxpxX_LA>
    <xmx:Yk-SaBKboneEqNEfCVcaQb5Bkqt6vZVLiHal7d5e1mDw2NMFXPIENw>
    <xmx:Yk-SaEkq-EnAszMhkLXxI7aCZE9fZa9b-0O74MTnTz5WbaPobBWCVw>
    <xmx:Yk-SaD7G8JV1jm3MjGzHz9-Fc_DFqrL8nJNZNjyfG-Eu6G9-FTORw6IF>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:37:21 -0400 (EDT)
Date: Tue, 5 Aug 2025 11:38:20 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: updates related to seed device and
 v6.17 kernel
Message-ID: <20250805183820.GC4088788@zen.localdomain>
References: <cover.1754265134.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754265134.git.wqu@suse.com>

On Mon, Aug 04, 2025 at 09:22:35AM +0930, Qu Wenruo wrote:
> Kernel commit 40426dd147ff ("btrfs: use the super_block as holder when
> mounting file systems") changed the block device holder so that each
> device of a mounted btrfs can only belong to a single fs.
> 
> This is fine for most users, but for a corner case of seed devices, it
> can be problematic.
> 
> As previously we allow the same seed device to be mounted through both
> the seed device and the sprouted fs, as at that time all btrfs devices
> share the same holder.
> 
> But now since each block device can only belong to a single mounted fs,
> it means the seed device can only be mounted through either the seed
> device itself or a sprouted fs, not both at the same time.
> 
> This series will update the docs to be more explicit about the seed
> device mounting behavior, and updated the test case misc/046 to follow
> the new kernel behavior.
> 
> And since we're here, also update a note where newer kernel fix a bug in
> orphan roots cleanup.

Looks good to me, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> 
> Qu Wenruo (3):
>   btrfs-progs: docs/seed: update a note related to orphan roots cleanup
>   btrfs-progs: docs/seed: add extra notes for v6.17 and newer kernels
>   btrfs-progs: misc-tests: do not try to mount a block device into
>     different filesystems
> 
>  Documentation/ch-seeding-device.rst           | 14 +++++++++++++-
>  tests/misc-tests/046-seed-multi-mount/test.sh | 17 ++++++++---------
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> --
> 2.50.1
> 

