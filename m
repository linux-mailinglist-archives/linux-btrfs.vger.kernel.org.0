Return-Path: <linux-btrfs+bounces-13902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DABEAB4083
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 19:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025923AC57E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C07296D30;
	Mon, 12 May 2025 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="XVEuLeqw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W+p46fTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A7254879;
	Mon, 12 May 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072403; cv=none; b=DwYdBiKhE9jcdY57l1I2HLrs0bFLFET3uT3OhvUQ5K8AVkolEr19i69ON21wUyNP/32ZSIKkzNWQMQY8g7yKHwIJmDpil3kVNOUEy+WIfBqC1hve01ERp2Rkwbe5WK957Pwo8xDZXkWLd5hVMHCoAXZtcBpUfW9cN0vrAKd2KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072403; c=relaxed/simple;
	bh=U0aycZU3nL8B3sPAjX2RrQuFxgX3wKcotQ348hOj6NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj4rmhp83SB9x0axYPFaMn7WODk3Cbw8cRA+XX+/NBKrrn52IL1yIj8746GVSGJGly5mJ23ijObnCACthnIT9vvpu8dZzYjtAZP0gXzFJyqoD7NcN9a5qU2pwQXO5RGXnjcwjG/s5Sl6nyh6VOoYrNXTKsZWGbLUUHfOWtWkJgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=XVEuLeqw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W+p46fTM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 711001140121;
	Mon, 12 May 2025 13:53:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 12 May 2025 13:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1747072399; x=1747158799; bh=VXmW3ltCTa
	H7AoKDzv6sYaMiQCFrnONwdydPYaY9q2c=; b=XVEuLeqwAdAa9UWRVW9DN+XLz7
	OG/rntCzlyiNY7B5UkLjzuCGo5Ae6SBBZYFeZKIw4YIvueif2PUpKQiRlh4TnIoI
	s+WQelYIEwUPm/mf63Z+Iw+lT48yehwVGRSEyxrMxDPZKer/ABrT8J6+8qa67Wni
	VWqFgZhBNiufXvPdp3Zvz9qpXY09ndT0laIsI1a7apbv8rNlxejYbLOVK+UZgN/t
	KOWUJPu2BChhpFrkgBs/T6LfJPoC7clP3CEsFgBrrgw3sMhXVIHZRsabwU8tYGZK
	Yz0yzd9y8D7ImI6NSb3/tIsNaDxsMKM5eCVCMdLcZ2KjlqF93mJo8cyHBJXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747072399; x=1747158799; bh=VXmW3ltCTaH7AoKDzv6sYaMiQCFrnONwdyd
	PYaY9q2c=; b=W+p46fTM0bbbYCL6IE5tZUS4Sby2PVJ2567PP7vDr1FmzwZnLem
	ufaPhg5PGbVkgXZK5xO4a3EqDVgNfxze8pLdKl6hGzEYUDOUhB+7fcWmvAX+j5Kd
	/1IYmspSXJwWOATj+/HHAbWsTStts5BP/5V0XBMfLD+0mL0ZcDhU2YMpTgfE7xQf
	DBm66wvis6sMRB+E4w8TKV3YLE/sSJdCPl8cZIynu8pbrnbsK7Y7wTPpClYGuEzK
	ZSjcxbWldLNal/BGVWstvzk8YvztLr1xKpClmtTYPnYuMuAz1dwIlcoNg4WDiqwc
	0DrCiPVwrRtx3OM0xIFsOHX8Y1oaNfz3mSg==
X-ME-Sender: <xms:jzUiaNdqmIcrl0NgcOFobAIJYgQWSGDYm4tOfHcx64Wzsf2-egcbog>
    <xme:jzUiaLPDDOQpbZumzkQCR9zqFH2rh5HtqKt9ktPC6VIA0rwioO-ErosaAPpx4394Q
    UMipDvuHe9JKpquHxs>
X-ME-Received: <xmr:jzUiaGh9pisKB39VC99RJYkXQZChZGw0oLnO4jx_Y67_TD7tCkz7z9KnkwP-1ZkkREcQm5_1BTMhE-lM0mzB-3NW83U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvvghlgiesshhushgvrdgtohhmpdhrtghpth
    htoheptghlmhesfhgsrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghn
    uggrrdgtohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jzUiaG9BUjsl6ItdiNpcNnibXb4JKL4wpaVkqfGCQXO-_FiIb2EO9w>
    <xmx:jzUiaJtaZ_mXordzNyyCKBa-lNbjxkSNocN8pknvCO7o3HEViS4iLQ>
    <xmx:jzUiaFFyM376utRw9PVERqSb5fE3Cc_9OSHt61-ymxLkj_qeTDk69g>
    <xmx:jzUiaAME5gcrsSCw-Zm5QiR3uRWX1vUU1fuKPIo0QcU797fesxqeYg>
    <xmx:jzUiaLGP3nPZdriNVJFipOjXfzCEBUVS65UtG7yS7VTpuROFU-O_r0n8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:53:18 -0400 (EDT)
Date: Mon, 12 May 2025 10:53:53 -0700
From: Boris Burkov <boris@bur.io>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: correct the assert for subpage case
Message-ID: <20250512175353.GA3472716@zen.localdomain>
References: <20250512132850.2973032-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512132850.2973032-1-neelx@suse.com>

On Mon, May 12, 2025 at 03:28:50PM +0200, Daniel Vacek wrote:
> The assert is only true in !subpage case. We can either fix it this way
> or completely remove it.
> 
> This fixes and should be folded into:
> 	btrfs: fix broken drop_caches on extent buffer folios
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

I would lean towards removing it, personally. But LGTM, thanks.

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 80a8563a25add..3b3f73894ffe2 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3411,7 +3411,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  			continue;
>  		}
>  
> -		ASSERT(!folio_test_private(folio));
> +		ASSERT(!btrfs_meta_is_subpage(fs_info) && !folio_test_private(folio));
>  		folio_put(folio);
>  		eb->folios[i] = NULL;
>  	}
> -- 
> 2.47.2
> 

