Return-Path: <linux-btrfs+bounces-20604-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C3D2941F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 00:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10108302AF9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D29330B34;
	Thu, 15 Jan 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="rO+mgCHu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hL7CuUmx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9611248F66
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768519814; cv=none; b=NVgwgqNr/+orPAVkj+OIt98/bV/QsjG9vQvlTL6byRoTzBdCpG3BAcVXYxdqemr2QZrjEI7Nz9FaVuiXnLXRwo8BhdJMHeg/D7tm/bUa4379puhjRUdSbpxuRWKM6Oal9toBtDut/FR3Mf1Z+8R8RYFMQptSzg6TJiklcXIN110=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768519814; c=relaxed/simple;
	bh=BBlvTJM1dMfM4cVSy3k56IePBkejwNovHmqiMQZTz24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn4nTMG6tvQUXP7Jbk26zP1gUlHQueRuAUhb6bJ/B1MdLY16uZht77thUJccU1p+9dfvnxugfsZM7sQCZvXDK8092IxIWrYjeIqyVES7aPVx3IA3C7zc8CPF4Iy86PUaoL7VXG6hkgMQdW/w/dFdOJzEwCiQQ5hs6BqkHZnspFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=rO+mgCHu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hL7CuUmx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id DB1D91D00124;
	Thu, 15 Jan 2026 18:30:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 18:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1768519811; x=1768606211; bh=+akwpDgBOz
	RYzTXlt4hidCaRczqe5PG2XqWmk1ZzBhI=; b=rO+mgCHuI+8JVfrwQBOrBP1S08
	hE410/rnwnfW+FOfYoLLfvqHi6LY5Ozl2yQVCNcnzz3wazixoUEUaxXU00kTj9cQ
	lPwjlRjy3IrGvYzGiBw7ltv/fMGJ77hgPtnWsen4vI0424T+B5UkWdNpzCRSYR99
	shrrRs7JNAqYdN2qpV8JulQxp7ltao2NXktyDPmPDBTWX2iSh/lpIFZfEDxem8tS
	cUAgldoabdwV0fQKcUaLISh1pW0MjiN47N2cZkseUJa9051UZy0lGOHLdwQ3cm9P
	/qaWMaQPvMJPI3z1CUM8Q846qobp7LEoVTPzWkuKnt7cK1SNAARUh0g3jwsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768519811; x=1768606211; bh=+akwpDgBOzRYzTXlt4hidCaRczqe5PG2XqW
	mk1ZzBhI=; b=hL7CuUmxWayw98eUP9uw4WIt9VW+jTvodY9EQJP9+N8mje2xifT
	/W9/mG2nkAc2hn9QF0kyCxnEP561E9AE6Wpv116mZAGjrcsw+b94anvQnC3/5Tr5
	ZW7/u4IO1K8EZzwEScB4CnAeS/DVUWF6Z+REJr7BumcBoGXPd9SkNYRhKwpYIrcu
	yGBq6SzKEvBbpyOQmAlUKXOdnLy3G+HJAsoFfiQxLE/KbnSnKPY0GeGds/UY0xrC
	I4VHEdptQT61zOS200MU8KVz3g065fHdlzWkENmlSz5lDFNyYy46FQKCEkcmu0LH
	IePJ3EJ03bC5eBqPPxwoMULrQu4tN9Mrp6w==
X-ME-Sender: <xms:g3hpacMgwcdEueqqep9eNQAuMHIpDq5E3tci0-eR6-11rJLdbskNmA>
    <xme:g3hpaaYcQJBFEHbxBufsPpHuqM87XVu7_3MMtL_1b4Xgb3DfdWCl4JwvnReaOS3Mo
    efcvnBs7VuV55apa82ZPORGzZYhURAYici63TlJ8dy_T6tgrTHDOr4>
X-ME-Received: <xmr:g3hpaQpfj5Y3V6up6Ji3xGN0YY3xSQbsZEAX5Z46TujWhNNh-95QNAL2dlvLswFhi4Sa2nYc-D3RdR5xu0_5AB2rkhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdejfeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtii
X-ME-Proxy: <xmx:g3hpaeb2cBylxFA6KmY-ZgzDuZTC2ERwbFU9kc4bMCbS4EErXKWRcg>
    <xmx:g3hpaYQ_VRTkxFQ3pjIcdboWnShr8d9tjwFP-KAgG5OJvxkOr-we5w>
    <xmx:g3hpaV4knk-tPRUigfOfatfePPxs4brg_agfB_zCu4-YLH0eIQz3Yw>
    <xmx:g3hpadz5fHNO9z3enPd7VekJos-O1HNzWPpxz4ed_o7N2ya1v8i9xA>
    <xmx:g3hpaTFqffY5YfSvWhxOdezJKoK4q9NwZSi43Hg1dZ1ajQ2Fhf0xabFL>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 18:30:10 -0500 (EST)
Date: Thu, 15 Jan 2026 15:30:07 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] btrfs: do not strictly require dirty metadata threshold
 for metadata writepages
Message-ID: <20260115233007.GC2118372@zen.localdomain>
References: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccfd051d2ae173d95f3f6e75b7466efbf4596620.1768452808.git.wqu@suse.com>

On Thu, Jan 15, 2026 at 03:23:44PM +1030, Qu Wenruo wrote:
> [BUG]
> There is an internal report that btrfs hits a hang at
> balance_dirty_pages() for btree inode.
> 
> [CAUSE]
> balance_dirty_pages() can be triggered by both internal calls like
> btrfs_btree_balance_dirty() and external callers like mm or cgroup.
> 
> For internal calls, btrfs_btree_balance_dirty() calls
> __btrfs_btree_balance_dirty() which will check if the current dirty
> metadata reaches a certain threshold (32M), and if not we just skip the
> workload.
> 
> For external calls they can directly call btree_writepages(), which

grammar nit: you don't need the "can".
"External callers directly call btree_writepages()" or something is
clearer.

> is doing a similar check against the threshold, and skip the writeback
> again if it's not reaching the same 32M threshold.
> 
> But the threshold is only internal to btrfs, if cgroup or mm chose to
> balance dirty pages for the metadata inode at a much lower threshold, in
> this case the dirty pages count is around 28M, lower than btrfs'
> internal threshold.

I think this is a good argument. Layering multiple different mechanisms
for metering writeback doesn't make a ton of sense to me. With that
said, it's not great for the write performance of the btrees if we
writeback already cow-ed nodes, so allowing more frequent writeback
might be harmful in practice.

I still think it's worth it to simplify things and "find out",
especially if this existing behavior is buggy...

> 
> This causes all writeback request to be ignored, and no dirty pages for
> btrfs btree inode can be balanced, resulting hang for all
> balance_dirty_pages() callers.

Does this happen determinstically if balance_dirty_pages() is called on
the btrfs sb with <32M dirty eb pages? Or does it depend on the state of
the dirty file pages too, like if those inodes get back some memory,
it's OK? Just curious to understand better.

> 
> Thanks Jan Kara a lot for the analyze on the root cause.
> 
> [FIX]
> For internal callers using btrfs_btree_balance_dirty() since that
> function is already doing internal threshold check, we don't need to
> bother it.
> 
> But for external callers of btree_writepages(), then respect their
> request and just writeback whatever they want, ignoring the internal
> btrfs threshold to avoid such deadlock on btree inode dirty page
> balancing.

Is it a deadlock or a livelock? Can you explain the hang a bit more? Is
it something bad about returning 0 or does the balance_dirty_pages()
loop forever trying to balance and failing to make progress? Is it a
hard requirement that if balance_dirty_pages() selects some inode it
must make progress on writeback in one call to writepages or else it's a
bug? That would be a bit surprising to me as well, but I am not a memory
expert obviously.

Sorry for being a bit pedantic, but I have coincidentally been thinking
about this a lot lately.

Thanks for hunting it down, by the way.

Boris

> 
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5e4b7933ab20..9add1f287635 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -485,28 +485,6 @@ static int btree_migrate_folio(struct address_space *mapping,
>  #define btree_migrate_folio NULL
>  #endif
>  
> -static int btree_writepages(struct address_space *mapping,
> -			    struct writeback_control *wbc)
> -{
> -	int ret;
> -
> -	if (wbc->sync_mode == WB_SYNC_NONE) {
> -		struct btrfs_fs_info *fs_info;
> -
> -		if (wbc->for_kupdate)
> -			return 0;
> -
> -		fs_info = inode_to_fs_info(mapping->host);
> -		/* this is a bit racy, but that's ok */
> -		ret = __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
> -					     BTRFS_DIRTY_METADATA_THRESH,
> -					     fs_info->dirty_metadata_batch);
> -		if (ret < 0)
> -			return 0;
> -	}
> -	return btree_write_cache_pages(mapping, wbc);
> -}
> -
>  static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
>  {
>  	if (folio_test_writeback(folio) || folio_test_dirty(folio))
> @@ -584,7 +562,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
>  #endif
>  
>  static const struct address_space_operations btree_aops = {
> -	.writepages	= btree_writepages,
> +	.writepages	= btree_write_cache_pages,
>  	.release_folio	= btree_release_folio,
>  	.invalidate_folio = btree_invalidate_folio,
>  	.migrate_folio	= btree_migrate_folio,
> -- 
> 2.52.0
> 

