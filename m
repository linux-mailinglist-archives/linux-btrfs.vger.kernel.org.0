Return-Path: <linux-btrfs+bounces-22254-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMLkF46+qWnNDQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22254-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:34:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF292164D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 18:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE0683136436
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D763E3DBD;
	Thu,  5 Mar 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MYMO28t3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1g92lc5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7793E3DAD
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731754; cv=none; b=LWEYkHZWMwdkO5ndrP7zLw+K7/wN7gmDCV5ply5KEx5wm3IoYkZ0j/MaPVfRYQbNbQ0Xah8B71871DGXpoBnuvxvsqsblCqxF19uFSk7gQxXd329tKGM1qneGmdu90m62Y0hJxg+VSKYzAu9AnIOdOskw0SSzcdMk9ylhr7IN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731754; c=relaxed/simple;
	bh=lnmKYcHv2ntwR2jYCAtjUge1DfcsAB5aAlDY1uboSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TYTKbD7syMf/rfcoGhJC8AGMzRyswAPpHPupaHGGi44EsvtEauak19HBKk8RxdiE48j5Kt6TMFL4hnPKU8V8KRZTcBuXrTGVzjnwzbLVFCgomXsgddutCVGz6WmUlj3nkNEQZPdWghGOPGftWQDd0e5jWakpsHgVPOcAbNWq39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MYMO28t3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1g92lc5P; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 318ABEC0603;
	Thu,  5 Mar 2026 12:29:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 05 Mar 2026 12:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772731752; x=1772818152; bh=cjk73i2rOu
	Y9hb6+u9faw91Ipgd/JV+kAQhWaf/nZIk=; b=MYMO28t3YZvTiTNlIaDZiV60Y1
	dINYNci9dj1o3K8Esm8k0MBG7BcJpUXZTZmuLUu2sYCbBOp9jF1d8BAon5B7ohYu
	EzaE0lJQDhLKix/ioP34cmttEltqqdNgd4RroJySP+XPnEzEVsFrPMM9JKCvokZD
	8V2EOjhrNNlnjq/rQVqVzMoFX0ogTjpcS+xh7v6aIm0j13ZI1gqUbbZjy6gmjekF
	Y2EDGH9baPeFXhbmoMYZPSsVRNICcvuXaF1EkZEYzZwVeTFzd5xvmNSkDhUxO0q7
	5i3KKoOh3mRV8VegO13FbCm4/o00i+wmnKydS9nUjnvjR7mQ89yOlELaG07w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772731752; x=1772818152; bh=cjk73i2rOuY9hb6+u9faw91Ipgd/JV+kAQh
	Waf/nZIk=; b=1g92lc5PJ2PsUYMdA3401EetVfQM9Bh94H63lJMGOl+U9lkur2F
	wVJwsbHSEtQFI7yhTX/jVIkkwV60e+kXg6BhqaJicA74i+jkajf5+385KLj79FL2
	XIRWIAESfCFpmvq3QjNo+8NlHuFOM1rYFE5VxRcCC3jiXWo8GE+KMuhfFaXDa5Hm
	RyNY30ud2941WfCVJ4bgROywkZHKNupgys09tqumBPKCcVSyc8q8oEWRM+psrKVr
	4QK42qrHd1J1BWQAki/K6x51cHzjkTOwdmg8LGF1lxb62oUXfs3o1Oanb25t47Sx
	QmjsqexV4e7tfyQ4Q6DW5dDpu6QSXcG7Udg==
X-ME-Sender: <xms:aL2paVpaWSdRITIgFBR-tkfEKz2UxLkgHAgTvNQ_Ftsohfa8f5cn0Q>
    <xme:aL2paeg6XXqXpKYt8asTZoZVjDrc31E1EgHlpHuoliMJjkfb94Z-cJvCHlOmdFhzo
    8GYz6J22_FGU95iPOqBTcpNkKHvyh-5n86IRkz8awuHI7Ldx63D7zw>
X-ME-Received: <xmr:aL2paagXkf1AkbkTlXyN5-QyV4S7KtI6E-TnzUc1Z2YsBxxQivjozGSUQcuFHffTrHKCpWtcUqLvK9-HSTXhw6dF5aM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehtd
    fhvefghfdtvefghfelhffgueeugedtveduieehieehteelgeehvdefgeefgeenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrthhhuhhmsh
    hhihhrnhesfigutgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhihhnihgthhhirhhordhkrgifrg
    hsrghkihesfigutgdrtghomhdprhgtphhtthhopehnrghohhhirhhordgrohhtrgesfigu
    tgdrtghomhdprhgtphhtthhopegulhgvmhhorghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aL2pacgsiVZvaQ2MAqRHvls8Yi71IGVCHNht3jPmCCdh36U7sbpj7g>
    <xmx:aL2paSJ-GQQs3d8XLQ82PO1r9ynIiyTUDJWbFcje8OxhJqICBscbQw>
    <xmx:aL2paTGagW2PbU-L8cYLhT3fFWGGX2Nmv7lJW2ipfMXffTiOR0YiXg>
    <xmx:aL2paeT0Gwp6cQSrBkilDVOVEnh7JrE62FSxU4Ex833tLHMkurP_Fg>
    <xmx:aL2pabFWTu-nLi6pa7V9wDGie45jHQWsj87bFBsdAdGlhvyXJ5tlK9BH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 12:29:11 -0500 (EST)
Date: Thu, 5 Mar 2026 09:29:52 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2 0/3] btrfs: zoned: fix hang with generic/551
Message-ID: <20260305172952.GB926642@zen.localdomain>
References: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305100644.356177-1-johannes.thumshirn@wdc.com>
X-Rspamd-Queue-Id: BEF292164D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22254-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,bur.io:dkim,bur.io:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 11:06:41AM +0100, Johannes Thumshirn wrote:
> Running fstests generic/551 multiple times in a row reproduces a hang with
> zoned btrfs.
> 
> This hang can be caused by long reclaim sweeps und system preassure and
> then flushing the block-group reclaim work. Mitigate this issue in two
> steps:
> 
> * First create a syncronously executable version of
>   btrfs_reclaim_bgs_work() in patch 2/3
> 
> * Change this synchronous version to accept a limit parameter, so we don't
>   run it off for too long and then call btrfs_reclaim_block_groups() with
>   a limit of 5 block-groups (this limit was arbitrarily chosen), this is
>   done in patch 3/3.
> 
> * Patch 1/3 is a small refactor of btrfs_reclaim_bgs_work() extracting the
>   reclaim of a single block-group into its own function, to make it a bit
>   more readable.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Changes to v1:
> - Fix spelling error in 3/3
> - Only increase recalaim counter if reclaim succeeded
> - Applied Damien's R-b
> Link to v1:
> https://lore.kernel.org/linux-btrfs/20260302143942.115619-1-johannes.thumshirn@wdc.com/
> 
> Johannes Thumshirn (3):
>   btrfs: move reclaiming of a single block group into its own function
>   btrfs: create btrfs_reclaim_block_groups()
>   btrfs: zoned: limit number of zones reclaimed in flush_space
> 
>  fs/btrfs/block-group.c | 273 ++++++++++++++++++++++-------------------
>  fs/btrfs/block-group.h |   1 +
>  fs/btrfs/space-info.c  |   3 +-
>  3 files changed, 149 insertions(+), 128 deletions(-)
> 
> -- 
> 2.53.0
> 

