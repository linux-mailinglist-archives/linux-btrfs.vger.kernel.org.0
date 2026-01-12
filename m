Return-Path: <linux-btrfs+bounces-20421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C0ED14D33
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 19:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 994573021796
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 18:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C13876D3;
	Mon, 12 Jan 2026 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TOydS3jU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yOF7qrcy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127193803F3;
	Mon, 12 Jan 2026 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244197; cv=none; b=EQD7Ym54Rg2cdLELNFcsQUD5SliIjAOUPLABHOo+XJRwDexqAgQpbR0jOtrsJjoum8+SA8coFMKOzdSxHa2WEhsm3y+LO6VnbaDqxTTfu1cE5QaX+6XZqN5wZJ68gUrIiaYy44VdPKqDVRAPJU9FASxUemnnJTbZXJDNHhN2Ods=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244197; c=relaxed/simple;
	bh=tlO3JcWYt12kNV3WNdGU5u9bALxYIJsV0PZhnr4xJkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uikbFV1DxcYNrw+w4wIKy96g9/vzgoZo5UnOJifitCiJRjWVEiR5SveMAwLlYtR6m91Ehba3XK6/7Fb5/CG8tjnUqPm7qXcBHrBfE1QLi/09amcTTJW5JlBT9vy9YqKPMzJZVu2ngF63ilZs9jeTL88yW6/hkrU1iuLRmKG5ync=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TOydS3jU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yOF7qrcy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BB777A011E;
	Mon, 12 Jan 2026 13:56:35 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 Jan 2026 13:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768244195; x=1768330595; bh=9y+C5fa4M6
	BCY2cru/Ze2ooN8bgCUW3IuwemNOOZrLk=; b=TOydS3jU4JSEqNqjN+vrAYeAvH
	7qdkLFGxOuv8pgu6TTqcf46Lmodv91u//lABtdJYAsBjFT4GpObf+wCPnWlu6j6o
	m9a1ZpTrOoLFji3TFCbWvtZv6Nv0SBm8sMMtmgfqYvbAaYiZnC62JPx3HBaGFm4W
	dQo3FfNuVVtgQS9RBt6PvDIiGkM0mRpm+5T9mHaVWRCxxGCLaqPcLAvFEj3VswHT
	OGuqInZcMCeSuwmyzB66vDuz4PJSzHaGu6Grw67+YRsHBu4JZuqeriUb08Kfs2BE
	0TbZl6s+iB77ez1sGr7GxAqIcqUqpZt2aqMwBuXNOZLl3H2QVJGagUbbNmJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768244195; x=1768330595; bh=9y+C5fa4M6BCY2cru/Ze2ooN8bgCUW3Iuwe
	mNOOZrLk=; b=yOF7qrcy4D5KyNw3M4VawUynjcTmI/QQwxP0QoBbDo39twfNMPk
	K9gY5PeTZgw59RFqZZB9aRaEZ8HjWb+qgtrUygWdOavaas662TOI0fEjiVsRZi0w
	PA5rAPDDpCVjSIjZAG62y11YpzU9qMJd0eA8aBevQMox//nkQd5cjpM6kuNsNd80
	JxJrOVC5OB+lf4HW744t5Mt0nM1Gx42WYRdlV+PAc9GYlUCjIcjSSCeRf1+0LMgM
	xx9QHPrFWtCFbRk7CyHlYxevpg7vur0B1BdHr+IsC9sVciMSB0P9XNYcNk6Pgsh7
	OkBSk+aABQM6chKqvDZZoUzMrS3sAcVk4Yg==
X-ME-Sender: <xms:40Nlady7UJt__VZll-ZZ46J9UgIjj2G_J3dN0vwORWrzkcSrZIpPSg>
    <xme:40NlaezOmCb0hPQz7D33uuRieu12QkAl0pocDyl5N9Vo5g6L9BB6GwQPTZpa5IIQF
    WrRxHS6HNYF3SzzbvhVDniUxJyJkN3vkCecXEWJ5r0bkrGZgcgoUEA>
X-ME-Received: <xmr:40NlaXbfnVdcR8pCOidBW7R9Sgx9B8F69zn3Ba8uqoArEHFv0sMhXq7IG1c7jFkDpAdpO0GNzxjR3nMWHI60NWukbD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudekvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhirghshhgvnhhgjhhirghnghgtohholhesghhmrghilhdrtghomhdprhgtphhtth
    hopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:40NlafWCwH1Vjn6-K3VQtFqoCah7FlRcoHIr6fAaxXh_EJxv3bcu6Q>
    <xmx:40NlaVgotQZJTioXftqtqzMzyQiLvSVHRWGBXtZtij2OgxkjCw3H1A>
    <xmx:40Nladt-8hXqAVCJ5x0t82YmcD_tUH1CYYgpYqWed3KT3M9X3F4N0g>
    <xmx:40Nlae4f4FrT-RgHMBOkISl1KRQ2cGEGEoMRwGt4p46xF3VINUMmGw>
    <xmx:40NlaWs35-XFmbDUqQVXlvwHj_KQ061Z72VQq7EoAZubDKm5-rkHGs7N>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 13:56:34 -0500 (EST)
Date: Mon, 12 Jan 2026 10:56:37 -0800
From: Boris Burkov <boris@bur.io>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: remove redundant space_info lock and
 variable in do_allocation_zoned
Message-ID: <20260112185637.GB450687@zen.localdomain>
References: <20260112154040.35746-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112154040.35746-1-jiashengjiangcool@gmail.com>

On Mon, Jan 12, 2026 at 03:40:40PM +0000, Jiasheng Jiang wrote:
> In do_allocation_zoned, the code acquires space_info->lock followed by
> block_group->lock. However, the critical section does not access or
> modify any members of the space_info structure, making the lock
> acquisition and the space_info local variable redundant.
> 
> This unnecessary locking also creates a potential circular wait deadlock
> (AB-BA) risk. Other paths, such as background reclaim or space reporting,
> could acquire block_group->lock and subsequently attempt to acquire
> space_info->lock to update global counters.

This is not a valid point. The lock order between space_info->lock and
block_group->lock is already strongly established and is the same as
here: space_info, then block_group. Any call site that did the opposite
would already be a deadlock risk.

With that said, this patch does look OK in the sense that it doesn't
appear that we need to synchronize with anything blocking on the
space_info->lock here.

Please update the commit message to not include anything about avoiding
possible deadlocks.

> 
> This behavior diverges from other Zoned-specific paths like
> __btrfs_add_free_space_zoned which only rely on block_group->lock.
> Removing the acquisition of space_info->lock and its corresponding
> definition in do_allocation_zoned eliminates the deadlock risk and
> improves concurrency by reducing contention on the global space_info lock.
> 
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  fs/btrfs/extent-tree.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index e4cae34620d1..43d78056c274 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3839,7 +3839,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  			       struct btrfs_block_group **bg_ret)
>  {
>  	struct btrfs_fs_info *fs_info = block_group->fs_info;
> -	struct btrfs_space_info *space_info = block_group->space_info;
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	u64 start = block_group->start;
>  	u64 num_bytes = ffe_ctl->num_bytes;
> @@ -3900,7 +3899,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  		 */
>  	}
>  
> -	spin_lock(&space_info->lock);
>  	spin_lock(&block_group->lock);
>  	spin_lock(&fs_info->treelog_bg_lock);
>  	spin_lock(&fs_info->relocation_bg_lock);
> @@ -4002,7 +4000,6 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
>  	spin_unlock(&fs_info->relocation_bg_lock);
>  	spin_unlock(&fs_info->treelog_bg_lock);
>  	spin_unlock(&block_group->lock);
> -	spin_unlock(&space_info->lock);
>  	return ret;
>  }
>  
> -- 
> 2.25.1
> 

