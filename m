Return-Path: <linux-btrfs+bounces-15760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6CB1668E
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 20:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F343BD691
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FBD2E11DD;
	Wed, 30 Jul 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nO09tzBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GhtJ0KNw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DB2E0B79
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Jul 2025 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901486; cv=none; b=MfzjYpRasCOM4jhFFKwh0pHdQ5laOgJKNOrUp+pgoccAKXf6DSclgPwWV14ESDOvDU6eJIK5OPCQz/kdh8gQPg288jKm9ExArsh5kU0X8eS616ZQ4xySKyzc8rf36XU4g45L2hIfrCA2SHVRSgGRFJqVPG3NNKJGwuJFCjvgGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901486; c=relaxed/simple;
	bh=9aHHvZ0hWRMETGH9ZhbpNB3j4qlY/5au0AIO+iX8JJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlqvkB+Kd1/Hiy3pRZcuns//aYC6Yv2EOE9WfOdRe3cnaTOAzxgSYfkmcCe3aJ6tWB2pf2MUgOQoLorUxjOz3d2gj3c6y3WHD0jRgKz4USLKo94dkEOyhALn7TcrSnQLsnBZZ56VzrARUqMixysKqT7wXdpprH1e+AXFL+amCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nO09tzBa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GhtJ0KNw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 08450EC1275;
	Wed, 30 Jul 2025 14:51:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 30 Jul 2025 14:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753901484;
	 x=1753987884; bh=1hQa6xK+fWUak/iakF4UtIbvCzELJJOl0C4qiDY3FCc=; b=
	nO09tzBa9D0qEdP8PQf+XI6pDVuFmLlH5ZBgAIY2qJuwbBpGCc/VQ+4RIsaWoz3N
	lCK/0PEea5Fy3zjMnXGcoOIuGogc72y2/0YpqLxkmMDyOiar9pxOvHM4tUCOuh0U
	qI/yRcm7/XrS6r5gT2Ro66YQqPV2YgWH9TPbRz2GIANVdvSJAOC6/AnJaopRkBpO
	Dy/4DfkzTqSP2JWlF5rn5m4MM/uXnjxPo1FIP2rHUcINy3KOrhAZqMxZ40RnbpS3
	QWdx3izf04gd9iABCcDvutoUzMCYDxkz415la5OQI9dsi73ejXFD6eHLHux7+60O
	kMxURZf2gT0x11v0rQlLvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753901484; x=
	1753987884; bh=1hQa6xK+fWUak/iakF4UtIbvCzELJJOl0C4qiDY3FCc=; b=G
	htJ0KNwnNQebG/S06d9enHji09i/5cBTLfZrIDNwJrBqRd4BG7QZBIPi7aQFt7Hr
	0wGVU3WdRIAjiXW2RQTpfVsufvbfSyj77yg772XEyTe7iwaWYWtM/Xh34Kkh5soL
	wxSW3j2t15KWOmMecjydd2bO6kUtFP2b6phIutZlUSAjULyGYif/1AEqeCGcRIiv
	WyjRlvC3OJGtH1deRWu4sf7Wa3ZF/Iz10iS90PzJ3Pt0BFSv5XOGvO6GH/MZVM/V
	5N6FourIcNi1gAMHPOFo4cQ2MGQA3bNF86lhS3mGRv9EElK450dK7XXrlDHYVX+v
	oK53bBNxfK9pnwgHG8maw==
X-ME-Sender: <xms:q2mKaPCOnBkUetxOY-82zG_rYsOQbqdHOl5E12jT-9lyWTD7pF3GpQ>
    <xme:q2mKaIyE0qnN-OAHIFE-hEeAPBP7aIhjioQVjGqgoSgSw2oCPwacZonpzEW4N8gte
    KvgXUPIXDnE2rAQUJc>
X-ME-Received: <xmr:q2mKaEC7kvMX7G9C6VJfdnGd2acP3lsDDi5rOIqeo68VmWh5Z5Fb71bABuXbyt7nyz_2UOY1wqXyyizxzJiG-ig2nj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeehhf
    duhefgkeehudefvdetgfetleeuiefgfefhfeegjeekfeehhffgkeejhfdvheenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghohhhirhhordgrohhtrgesfi
    gutgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfihquhesshhushgvrdgtohhm
X-ME-Proxy: <xmx:q2mKaNa1FhM_R7Y06mPpAOXQt8zQB-Hpju1QTbCS5I6vd4upatGwZw>
    <xmx:q2mKaEgx48e4ghFeWgFNh2Td3LZVoDyJroKa3i1rb4RDly-43n1FyA>
    <xmx:q2mKaH61NYby80l4698XRnIgWfIULRY1RyN-_mKOZMSP_BBP1itlew>
    <xmx:q2mKaD47RF0eE8jFOeRSyhDjLxm6LrQsiJc0QFw1V5PP5QG069BYsQ>
    <xmx:q2mKaJXnFYdcTkcYytjcjcN5NGQrViyuqCwai-i_koX_9oNpyaPZJobd>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 14:51:23 -0400 (EDT)
Date: Wed, 30 Jul 2025 11:52:32 -0700
From: Boris Burkov <boris@bur.io>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] btrfs: subpage: keep TOWRITE tag until folio is cleaned
Message-ID: <20250730185232.GB874072@zen.localdomain>
References: <20250730103534.259857-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730103534.259857-1-naohiro.aota@wdc.com>

On Wed, Jul 30, 2025 at 07:35:34PM +0900, Naohiro Aota wrote:
> btrfs_subpage_set_writeback() calls folio_start_writeback() the first time
> a folio is written back, and it also clears the PAGECACHE_TAG_TOWRITE tag
> even if there are still dirty pages in the folio. This can break ordering
> guarantees, such as those required by btrfs_wait_ordered_extents().
> 
> Consider process A calling writepages() with WB_SYNC_NONE. In zoned mode or
> for compressed writes, it locks several folios for delalloc and starts
> writing them out. Let's call the last locked folio folio X. Suppose the
> write range only partially covers folio X, leaving some pages dirty.
> Process A calls btrfs_subpage_set_writeback() when building a bio. This
> function call clears the TOWRITE tag of folio X.
> 
> Now suppose process B concurrently calls writepages() with WB_SYNC_ALL. It
> calls tag_pages_for_writeback() to tag dirty folios with
> PAGECACHE_TAG_TOWRITE. Since folio X is still dirty, it gets tagged. Then,
> B collects tagged folios using filemap_get_folios_tag() and must wait for
> folio X to be written before returning from writepages().
> 
> However, between tagging and collecting, process A may call
> btrfs_subpage_set_writeback() and clear folio X’s TOWRITE tag. As a result,
> process B won’t see folio X in its batch, and returns without waiting for
> it. This breaks the WB_SYNC_ALL ordering requirement.
> 
> Fix this by using btrfs_subpage_set_writeback_keepwrite(), which retains
> the TOWRITE tag. We now manually clear the tag only after the folio becomes
> clean, via the xas operation.

I'm a little bit nervous about this for two reasons:

1. we previously tried something very similar for extent_buffer
   writeback and did not land it after all:
   https://lore.kernel.org/linux-btrfs/ff2b56ecb70e4db53de11a019530c768a24f48f1.1744659146.git.josef@toxicpanda.com/
   That patch was very intentional about clearing it later than at the
   moment of set_writeback, so I want to be sure we aren't missing
   something along those lines. I'm trying to think of some way this
   logic might fail to ever clear TO_WRITE, for example.
2. Similarly, how will this interact with the extent_buffer case? That
   uses the eb radix now so I guess it's separate? But it is still
   touching the folio writeback bits at write_one_eb.

Sorry for the hassle, but just want to be extra careful, as this was
already a big pile of bugs for us quite recently.

Thanks for the fix, of course,
Boris

> 
> Fixes: 55151ea9ec1b ("btrfs: migrate subpage code to folio interfaces")
> CC: stable@vger.kernel.org # 6.12+
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/subpage.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index c9b3821957f7..67cbf0b15b4a 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -448,8 +448,25 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>  
>  	spin_lock_irqsave(&bfs->lock, flags);
>  	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> +
> +	/*
> +	 * Don't clear the TOWRITE tag when starting writeback on a still-dirty
> +	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
> +	 * assume writeback is complete, and exit too early — violating sync
> +	 * ordering guarantees.
> +	 */
>  	if (!folio_test_writeback(folio))
> -		folio_start_writeback(folio);
> +		folio_start_writeback_keepwrite(folio);
> +	if (!folio_test_dirty(folio)) {
> +		struct address_space *mapping = folio_mapping(folio);
> +		XA_STATE(xas, &mapping->i_pages, folio->index);
> +		unsigned long flags;
> +
> +		xas_lock_irqsave(&xas, flags);
> +		xas_load(&xas);
> +		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> +		xas_unlock_irqrestore(&xas, flags);
> +	}
>  	spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>  
> -- 
> 2.50.1
> 

