Return-Path: <linux-btrfs+bounces-6435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31A930134
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 22:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226711F222CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D840F3C488;
	Fri, 12 Jul 2024 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MFJCdQzg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcPUg8Ta"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766CBE46
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jul 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720815148; cv=none; b=OqRzOtctDyOSh9tKhKmxbO9U099wFilOhnlLzi1zobidJHJ7zqAEc+40WQ/fjm/yR5Y/QF0oL8dZ/kod6a80j55Nz+jUl4BQ/vVJcnuuyryLQBfXbeyynluxdXND0oX3uv+vL3H0yYOdp81j5QrkM9MgKGM77kiIcl41kZV2D1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720815148; c=relaxed/simple;
	bh=HZQFA8J1PorgoZjkiS6M63H333syDx7IaUDSHZQa43k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iug1dcOY9KSkFLWpidxb8slEuSuIjdVt1gbXvbsMGPXcweA2kxn5813s7tbNXwzVsIwituN5Xh0CGW/LuqC1pdqnY976SWMLdBaGb9Jv4J89du4YESgAOjtODwGVnYAHC0iq8/P5olTAakcHNC9srs8EHgbFkpbTdjaz5/Ji0qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MFJCdQzg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcPUg8Ta; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 72BA91140161;
	Fri, 12 Jul 2024 16:12:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 12 Jul 2024 16:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1720815145; x=1720901545; bh=Y3YlymAiDA
	wfElzLX1YLhFEIOIsBxY/LUh5niB7T/00=; b=MFJCdQzgZghQCPuj8Wh6anNgE7
	8inZFAIy7uchg9LzG0TJKhmGqYrjNerOe/K0W0CFAm+XJ3VUecymvYVCZd8VVTUa
	56O6VWx2FuuboI0gWmGs0Lv/MpGWuns3BUaTV7F8G7fw1jiNOCfRExu3OKQTqbH4
	j7QOcAC+n4slMYuxm+pRy8T8rfiMXZxgsK3BhX6EFFClurVCKPKsGptWJSwh23xa
	FVKpSXjzgf3hx59r/y4w/KPEUwOx3A1GM4JHy/VN8UHIF9zqnKiH6P1n2HJHX/X6
	EVBYoi8xU+52NfcqdGPr+Jp8Drvpas77RGQqVSfpSFT/wy6C8rdBhk8fB7qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720815145; x=1720901545; bh=Y3YlymAiDAwfElzLX1YLhFEIOIsB
	xY/LUh5niB7T/00=; b=PcPUg8TaKf7VNsx8npyB6lN6tVIBr06IuvPpsfS9XUgV
	NV49nU8YHMe12VHtOUzlxXicaFRdlFMoKQlrWtybFzPicmM3aNU8swtFcmARjWl7
	GzYujmfCnKr8B1G9bBuxhu6avJnLgERHddQUZxXt2NUar/C8BFc83AIhRCf/wGMW
	BUxt07RmK9dUnAu8cTuOjJ3rqSlug34poimv9D1pBD2XwFA3xgddJ22F445rTuUz
	UxrxgabDZIQh/MupA+3cf47/UJ5r6meINNiwcYVGz8DrFRuATaUEma61/3fklWsy
	tOOapbZdhTvFN4xaKiFvp+AWXiOjtUa2SVBFvg4/ng==
X-ME-Sender: <xms:KI6RZsNIDcyCxqTz3S-H4rg90mZhxa3esAnTUBz3zfC0PrWFQtadZQ>
    <xme:KI6RZi9JwUas1SfGQAPHBda92MxdXWXS3bykVKZG5V0ACsD_nDe7R52nf50d_cZ-x
    -wXEvui3C1trY89ssk>
X-ME-Received: <xmr:KI6RZjS7wPiarOIXFGMHfmW-3pftr75Z_3XvV0c84bXwUK9Stm_38ks9BdVJPYjsMuUcODKKC1_S8lilJ76YNciBxsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeeigddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:KI6RZkvZEwM68rY4QaZUT0EevHc4LavR8ZEYwqS5E3yCpIb1GmdFCg>
    <xmx:KI6RZkerFLyKunn0WVyLFyxr7mNQIO4gihXyV01WdTwooOWFhjkVuA>
    <xmx:KI6RZo1TCZ8zGsXVHdKJP5O6rCEG9IWPdo0PGb_t0uVnMhhisvCSOA>
    <xmx:KI6RZo_SotaCqxSCzY_3ifqEIu5dt6gAWTJ59WT3cJLjXGomEBuuWg>
    <xmx:KY6RZlo6GaxSHIy6euYbZq7TmJSMjmXm_w3fI9Ro06x1F-j1dbpKRtWT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 16:12:23 -0400 (EDT)
Date: Fri, 12 Jul 2024 13:11:26 -0700
From: Boris Burkov <boris@bur.io>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not subtract delalloc from avail bytes
Message-ID: <20240712201126.GA3474272@zen.localdomain>
References: <5075b1ac071c767c182ddc87b228df6147ef7bc4.1720710227.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5075b1ac071c767c182ddc87b228df6147ef7bc4.1720710227.git.naohiro.aota@wdc.com>

On Fri, Jul 12, 2024 at 12:05:32AM +0900, Naohiro Aota wrote:
> The block group's avail bytes printed when dumping a space info subtract
> the delalloc_bytes. However, as shown in btrfs_add_reserved_bytes() and
> btrfs_free_reserved_bytes(), it is added or subtracted along with
> "reserved" for the delalloc case, which means the "delalloc_bytes" is a
> part of the "reserved" bytes. So, excluding it to calculate the avail space
> counts delalloc_bytes twice, which can lead to an invalid result.
> 
> Fixes: e50b122b832b ("btrfs: print available space for a block group when dumping a space info")
> CC: stable@vger.kernel.org # 6.6+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Nice catch.
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/space-info.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 9ac94d3119e8..c1d9d3664400 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -583,8 +583,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>  
>  		spin_lock(&cache->lock);
>  		avail = cache->length - cache->used - cache->pinned -
> -			cache->reserved - cache->delalloc_bytes -
> -			cache->bytes_super - cache->zone_unusable;
> +			cache->reserved - cache->bytes_super - cache->zone_unusable;
>  		btrfs_info(fs_info,
>  "block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %llu delalloc %llu super %llu zone_unusable (%llu bytes available) %s",
>  			   cache->start, cache->length, cache->used, cache->pinned,
> -- 
> 2.45.2
> 

