Return-Path: <linux-btrfs+bounces-1629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8A8377D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 00:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF3B2B24A4D
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BD14E1D7;
	Mon, 22 Jan 2024 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="blxxj6lo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hbbLarQM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819038DCC;
	Mon, 22 Jan 2024 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967428; cv=none; b=R1z3pK821A0B0iQrOiQQ6F3fIn/X5lS3OWWzfojyAo3j0RojXrc5tuJsYIU0cIu/fCCT2DXGZRfR52pj1h3HzSlxeSxyANB/maPkcKVidmuFqFVI6z0KY8v0nK1GA7O27lxfeBlzyD6eYIdMAuHo/BnmjbmPspSUKNBa7WTitzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967428; c=relaxed/simple;
	bh=d6cfvBQNKPaaqqNpkhTE+uXaksS5FghTgNe444hBHgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihRoRAXxsXrajzxMrdbb+3fkv8Wou1sWws3OlJvqWkP4zua7YMOKEjF/MTzBFo2/KMz+MIj3VPP2JrfftMm7LExdX1AXYuaw8Af7HMNBBj+aIy9/6FLI4fc6yGRP35nQu9etgbuUf2lKUJ4MqpAkgBthMNQGCa9p04+v2U3ectc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=blxxj6lo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hbbLarQM; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 439093200AF9;
	Mon, 22 Jan 2024 18:50:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Jan 2024 18:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705967424; x=1706053824; bh=JqOxVHoWuC
	6xC7ubsPPJY1ZmJL8w2E22Q/gtqtE3ZxE=; b=blxxj6loUh7cotlSC+whGFFZZr
	ndTTrke/x8GTb2jVGso6DujyjzU07Ct49J+KQ3gKwMrW2OD3wU2jcoG1y8SL8kQ/
	4hIaPR8nkWVhGF8cl8t+hCEfNP5HJS2qE3c1qac3k8O2yqIzAYb+lmgfFb4YHcir
	RfWNxZMN+YZ7RGwPxI7+dV0XUsNqS2wIwkGToe9WlxlCtDLsnx5M/PjQ1y0utqtz
	M75yGchZi23FZ0Qx6nkBMlB1V3QI68takNQhq/BUs+GVWOEc5VMD6aaK09BMls6f
	I7n4niIlVl1D8zcXtYOcybJRbuv1TeAxVErZs6imSBzau62vHMB0v2B/e9mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705967424; x=1706053824; bh=JqOxVHoWuC6xC7ubsPPJY1ZmJL8w
	2E22Q/gtqtE3ZxE=; b=hbbLarQMxaab5qu7O8qlYn1GfNnG7NUkIjNwnd5SeDlh
	V/UxR+UQ+zLvzV80HRobjRtW7dmaJ8XnTQfaNFOSMwqX9f1IfX74uDgAypd1S6sm
	M3JfJAbxOXG52L5UjK34kihRHuXkxcSV4PQgxE/OjqZ09VQ7HBc7MbKxA+mPaoJK
	AxtkTyC88PHTU6DktFUh4rtFWxQ8oFry8FQX2aW5uboD/CwkIbw5EYb2+3qBb+o6
	g+wuYwRANkHpFWB2wqeKVbS6UJqf8O/bDcKhtdqn5YtMjbxnQ0IjzCxKtcPFcVS6
	nL7db91veOEgiXU7smSBw1B7TKFgj4uZg3mc623mvA==
X-ME-Sender: <xms:QP-uZTXq5MZNojYbmb_tCglAAQWk0J_Glu5OAWL1viZfE8GRS__qhw>
    <xme:QP-uZblytYA9RxVBJMGvSnj76kTzs6nrBEJ9uDAeFnyK2a-pFWCi2X6ugxHiv9R_1
    zSqbBVN0sfJw0PSMjw>
X-ME-Received: <xmr:QP-uZfZmQPrpwKcYpzUWE--tFfx9cBHKMGffHmeboAo983s3nCIzDStUFg71YUMOFv-WH5rRjhxHrmbWYBJPJrVgeBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:QP-uZeVGmO1eiTDnUococIvX606sPpSCSUXC6UDXGTb9Mvs6r9NXgw>
    <xmx:QP-uZdmx5yZpZCoKO43sOGvAI0RVItrTz2DWYPTSepl3a-jh9X5mIw>
    <xmx:QP-uZbdLYl18RgJM8tGbQ3okS0nPKczjn9287O6RPpzL_2dLPWbkYw>
    <xmx:QP-uZQsTb8ec4f3MIUYPOTxR7ZTxytc7y1IUOeRNRQi99GYvvPIJIw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 18:50:23 -0500 (EST)
Date: Mon, 22 Jan 2024 15:51:27 -0800
From: Boris Burkov <boris@bur.io>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: wake up cleaner sooner if needed
Message-ID: <20240122235127.GA1695621@zen.localdomain>
References: <20240122-reclaim-fix-v1-0-761234a6d005@wdc.com>
 <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-reclaim-fix-v1-2-761234a6d005@wdc.com>

On Mon, Jan 22, 2024 at 02:51:04AM -0800, Johannes Thumshirn wrote:
> On very fast but small devices, waiting for a transaction commit can be
> too long of a wait in order to wake up the cleaner kthread to remove unused
> and reclaimable block-groups.
> 
> Check every time we're adding back free space to a block group, if we need
> to activate the cleaner kthread.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/free-space-cache.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index d372c7ce0e6b..2d98b9ca0e83 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -30,6 +30,7 @@
>  #include "file-item.h"
>  #include "file.h"
>  #include "super.h"
> +#include "zoned.h"
>  
>  #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>  #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> @@ -2694,6 +2695,7 @@ int __btrfs_add_free_space(struct btrfs_block_group *block_group,
>  static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  					u64 bytenr, u64 size, bool used)
>  {

I thought add_free_space are only called from various error/backout
conditions and then for real from unpin_extent_range, which is also in
the transaction commit.

The normal reclaim/unused decision is made in btrfs_update_block_group
for that reason.

OTOH, I assume you had some repro that was performing poorly and this
patch fixed it so, I am very likely missing something.

Thanks,
Boris

> +	struct btrfs_fs_info *fs_info = block_group->fs_info;
>  	struct btrfs_space_info *sinfo = block_group->space_info;
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	u64 offset = bytenr - block_group->start;
> @@ -2745,6 +2747,10 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  		btrfs_mark_bg_to_reclaim(block_group);
>  	}
>  
> +	if (btrfs_zoned_should_reclaim(fs_info) &&
> +	    !test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
> +		wake_up_process(fs_info->cleaner_kthread);
> +
>  	return 0;
>  }
>  
> 
> -- 
> 2.43.0
> 

