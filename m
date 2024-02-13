Return-Path: <linux-btrfs+bounces-2364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D0853DE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 23:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3211C287CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Feb 2024 22:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86986629E8;
	Tue, 13 Feb 2024 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xNkzwul5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e/Zy3F6q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CA629E1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Feb 2024 21:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861435; cv=none; b=XMqEKQI8Pw3MJOdwGxmvOVfMvvVTi/znTARK4qeY04Dc9ufCJLGgpe6sn6HTahN4DzqZWi3LuV7UDBT6ZkSkOFDknAf7vtpPD9vWTZU+p/pHZamJGQ1xNvUplYxX50xOs844qxGNtTpPlBYBcKgWr1WYpSbI8vvXB1zz5WwKYf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861435; c=relaxed/simple;
	bh=0FQCUamBDqi7CcM6Gw5tBeVyNi8piLXmJeQ8yK8crwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+Pj2KTrSSBjLEsNogZ+0dufVDH34hqJ92QNEelSJ7UOf90yH0A5PB/xAHx63m42kzcgkbB98JVx0s2pSF9LeSlj7uQ4evPr9Om4Wd14HBp10rnuozTk61tYvtAXg05DE6p0w0FuI762eaBPncWy3KMVpsKBfoQfwUc2rdXRDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=xNkzwul5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e/Zy3F6q; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id AB5535C00DC;
	Tue, 13 Feb 2024 16:57:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Feb 2024 16:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707861431; x=1707947831; bh=QBfAFa2ZqN
	2hvQjuthE0jQDQRadHgJKOHHD7GOl/818=; b=xNkzwul54Xci0RrbpKm32o6xnW
	Fvwk3jVGajeBH76sipSQwHLE0JR+q3JbUXjA36/0QjLf7ohdcbui2VlJVeix61Qc
	JIZwMFGlkBoOfWYtuQ5gYQfTmgIbdYbYfZVJeVq6XYkxegFos88wWlL4yTOH7/LF
	YnUx7y1UbA4O5oVEm5Jb1a5cxHW1/r9tVNV8m0liloXAjLVpqGriiCiFxTaFoUD4
	2XnS7+og1W5x78jRkYk7rCLLo2nSuVNzcmMHQtbmowjIihmdm8j3cYD93EIXeOnz
	hIzThNOA+5DcWI13PXNsTZtDxcemc1oTEA8zQzWq6rtB0HG8Y7YScrwcQNMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707861431; x=1707947831; bh=QBfAFa2ZqN2hvQjuthE0jQDQRadH
	gJKOHHD7GOl/818=; b=e/Zy3F6qcL1Dzc1JIM3585V2Pd4tf7y45Sh4H+xF3r4V
	/n4ReHYxF9LMuMf2PUPTqXhbGbKOnUDf+u0X0dRjIQsAzbTQYtpX0vFw2GRIy3dU
	gtOJ716IW01uGiC6NFebD0MOcaCItxPCtPwylfG7uDrt3HRSwPS2b30c+xuwtagh
	OcyjO+e0JwO32Uc+mpyDReEqebKaz9rTkplFJZOhu517eCGmyX0kzP0tK8PzlfQK
	zlidof2+Ecfnus5apgSdl0cXGa8i4lDHt1u6gS3Bzdh+Y7D9wOJhoacelJWYLxo9
	NFGlAsCs2VlWgmnzgdY9cmHUPB3oUg2XlJiGgKSY+g==
X-ME-Sender: <xms:t-XLZQPj8W-uPO5wbB8vpCZe9wyAodhoPr6DuT_jXEvCRQMonIs47w>
    <xme:t-XLZW92rCTPXASvLVYSIiWZXbSvu4-UzHjj01gEhiw4Z-PsBCHtvZG9ofDyDmaJP
    tpp_OuAUJqSn-XN0K0>
X-ME-Received: <xmr:t-XLZXR_ive78Tqwq8qIJFq8Jsfo_zdE5-5bTjLfDpBPpFXYlzE7NHxQU0bkObHZOsmiOzSnN42S9BiplrVW2RMfHpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:t-XLZYvoTTC19h0vhtzuTAoF_ssjOHvIaR-HohpgA8L_hLVycmlBKg>
    <xmx:t-XLZYepgLZSQnRUnOyAe6SW6B82KLIBp5Wb41xz6oCNSaveHHKPyQ>
    <xmx:t-XLZc0UcijJJdAPCiNXt8-7gTffxco-CIoBYiYwwPHSuSgEvSD7fQ>
    <xmx:t-XLZX4UcwJecI1EPqbrPusBVzJvSMXFWcXJMM_A8yuDoO8E8Hs-mA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Feb 2024 16:57:10 -0500 (EST)
Date: Tue, 13 Feb 2024 13:58:48 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Naohiro Aota <naohiro.aota@wdc.com>, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't skip block group profile checks on
 conv zones
Message-ID: <20240213215848.GA306016@zen.localdomain>
References: <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cd08a6b0f5285498811504d3713ced3afe3b8d2.1707812175.git.johannes.thumshirn@wdc.com>

On Tue, Feb 13, 2024 at 12:16:15AM -0800, Johannes Thumshirn wrote:
> On a zoned filesystem with conventional zones, we're skipping the block
> group profile checks for the conventional zones.
> 
> This allows converting a zoned filesystem's data block groups to RAID when
> all of the zones backing the chunk are on conventional zones.  But this
> will lead to problems, once we're trying to allocate chunks backed by
> sequential zones.
> 
> So also check for conventional zones when loading a block group's profile
> on them.
> 
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
> ---
>  fs/btrfs/zoned.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d9716456bce0..e43c689b1253 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1637,6 +1637,15 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
>  	}
>  
>  out:
> +	/* Reject non SINGLE data profiles without RST */
> +	if ((map->type & BTRFS_BLOCK_GROUP_DATA) &&
> +	    (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) &&
> +	    !fs_info->stripe_root) {
> +		btrfs_err(fs_info, "zoned: data %s needs raid-stripe-tree",
> +			  btrfs_bg_type_to_raid_name(map->type));
> +		return -EINVAL;
> +	}
> +
>  	if (cache->alloc_offset > cache->zone_capacity) {
>  		btrfs_err(fs_info,
>  "zoned: invalid write pointer %llu (larger than zone capacity %llu) in block group %llu",
> -- 
> 2.43.0
> 

