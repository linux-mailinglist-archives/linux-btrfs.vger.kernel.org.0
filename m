Return-Path: <linux-btrfs+bounces-20218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A476CFFC3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 07 Jan 2026 20:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D933930039E2
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jan 2026 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7934028F;
	Wed,  7 Jan 2026 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Jy4Vgo5c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rzaPlJF+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B6C33EB17
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Jan 2026 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814471; cv=none; b=Kn38MEN0YuABrSBOWyzMZeVlnosPglz0O8rvoon5rUyyADiglS2FWfQrtAW1cNMWLC0hdIreC3KzjvXh8VnSckkJA7X7g6UX/V/GGzS6fFE9nRReaUI6x4h8QAxV4fYzrlpBztYMMpk9g+Wm++hrTvV0maaKyvkZN7FzJCgCvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814471; c=relaxed/simple;
	bh=FxO2NmgGL/35xoocjh3LIWaBeshnzIp+x+hXeaZ6+lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sjr9Tyzptmzd8RhbW8MOMDz4oe7t3Fct2gHqHLAfTLFqLdRm6hBoaDLgEi5J2zJ/hCuzQSaxvY5LI603uGSOh+pEBMlg/zZ/kQ3+7175EPmOoAElJtHaAHW2rG1P6RAicwzrxPRzlpyz2jkcLcjXlcvg7FZRuZstUdEdjftgbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Jy4Vgo5c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rzaPlJF+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 89FE81400055;
	Wed,  7 Jan 2026 14:34:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 07 Jan 2026 14:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767814468; x=1767900868; bh=fRwoYVXf68
	n8+ApmU5naQYw7mTdnSiGrERduDseTy3w=; b=Jy4Vgo5cnFtqT+XutiMVBpvHI4
	N+WvpaC5+F7zer/9KuwjxSa3T+kawXLjavRRYHULTmsY/61wVgc3ASe/Q7b3A882
	jm3VfOznlvXRpdDUlokPRSM6HiDzdVyAOhfMWqs1z9+yjGYlBwYJbT83pFKqa4rB
	AE69NEn1lXLUIlKIiVjUeoCqZLY/DiOKOZO1aWhEeRAZ6MHuyR5oJMjHkIW/4Gyj
	EUoO2a+mX0yXHr2k1DdU4qhjNKL39HQNDmEcqrvEwhoZ1dMt+FXxXWembrl75gQg
	pOAa3GmH6SO08cwuQqB36S36OHpYOl4jeL2SsrLAEqwlO7oKgPCmmNR0p9Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767814468; x=1767900868; bh=fRwoYVXf68n8+ApmU5naQYw7mTdnSiGrERd
	uDseTy3w=; b=rzaPlJF+Pd7J75lBmMO4MkHGM3ooRy27KWMvrVSsmOo+9s61msN
	Yc7S8jphbQzlbFxWemIJLEvUZU+CTtnXgDQT7mno9hXdVclwKBH+1fprvrV0Q/Fi
	uwz6JR3/tAWf1RUEAfZXzjuCyRTvWZCtNOgmmhbH531h/GALatV6x6Wm3FpnGUZt
	ee8xtYNJgHyY3LilJYx0AMli8oYECz2jLaHvF4XeAylLl1Api25vZ7h+nLHtEQ7j
	NCqW/D5xjeyIOXEtqZfoaXcLvAmPh+Q/WUTv+rOQ4cWXjGdA94uYtKXK0Xj1jD9h
	2boSnujaLJEXKb8P8/exqL0PcopuFsTqqvQ==
X-ME-Sender: <xms:RLVeaaWw3Tcypa3X39jUBCAX_nMqZreop4u9wFfP7a1tS4mT8WdYEQ>
    <xme:RLVeackTyLziGEptLbM9j_sM7cMm1CS5Nepj5J9PHa6EkNEPL6zoPpvDpmATsBbTV
    0ziE7IpDGz_VCBNVjl9E_1kkm5DcQk4_wDohvRidi1sRqZmdZQqU9E>
X-ME-Received: <xmr:RLVeacD4i-IzbLM4LzzWaAZeGOqJuulKovh1Qv6489FN9C3P0LcarbrPmO5uZIrNEu7oYrTsFteGklLSEc1FEJSZKe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RLVeacey7y_qIr1HHvkgRSDLk_xK-HUPSJFPJy8sgQ_I7eFa0AdTnw>
    <xmx:RLVeaXJm6A7FeUjDd3WwhNRjnZKhrrOOzoPYvXj5s5wwXxvrutMHpw>
    <xmx:RLVeaff1rQ8k_ijE_VPwr9OQ1BUivFqsmmbjAWWFsdTLCcnwnb-cYQ>
    <xmx:RLVeae1WVsVTjVbGReUJZmKGbeZZ9Mw7-7evGnynVR2Ad_ymCRVxFw>
    <xmx:RLVeaTArOn0qiozveUU4p3Ckm4F-J147PkHXsJH1zDy_cgGZ_-7zmh1r>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 14:34:28 -0500 (EST)
Date: Wed, 7 Jan 2026 11:34:39 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/12] btrfs: rename local variable for offset in folio
Message-ID: <20260107193439.GE2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <2b6c0f20ed5022d29336268dce8f951dd78500e2.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b6c0f20ed5022d29336268dce8f951dd78500e2.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:26PM +0100, David Sterba wrote:
> Use proper abbreviation of the 'offset in folio' in the variable name,
> same as we have in accessors.c.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/ctree.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 0a7ee47aa8aaab..b959d62f015ef5 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -762,7 +762,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
>  
>  	while (low < high) {
>  		const int unit_size = eb->folio_size;
> -		unsigned long oil;
> +		unsigned long oif;
>  		unsigned long offset;
>  		struct btrfs_disk_key *tmp;
>  		struct btrfs_disk_key unaligned;
> @@ -770,13 +770,13 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
>  
>  		mid = (low + high) / 2;
>  		offset = p + mid * item_size;
> -		oil = get_eb_offset_in_folio(eb, offset);
> +		oif = get_eb_offset_in_folio(eb, offset);
>  
> -		if (oil + key_size <= unit_size) {
> +		if (oif + key_size <= unit_size) {
>  			const unsigned long idx = get_eb_folio_index(eb, offset);
>  			char *kaddr = folio_address(eb->folios[idx]);
>  
> -			tmp = (struct btrfs_disk_key *)(kaddr + oil);
> +			tmp = (struct btrfs_disk_key *)(kaddr + oif);
>  		} else {
>  			read_extent_buffer(eb, &unaligned, offset, key_size);
>  			tmp = &unaligned;
> -- 
> 2.51.1
> 

