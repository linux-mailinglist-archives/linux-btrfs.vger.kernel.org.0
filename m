Return-Path: <linux-btrfs+bounces-12164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC74A5AD1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AECA1740A7
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2797B22170F;
	Mon, 10 Mar 2025 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="UpbmLR84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UnFpuDey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1B022154E
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649227; cv=none; b=VeiXEaQCIUyvKwHCeMNBIU+R0GqPeY/Lm9KGnmsREcO/0bBCM98lE+jhT2Dos08kTzA+fl3fknYXcJNAZwu+KpBGzdwmK5tbcWqZbobMEJ4cZwguzwwx1rzR+oDBGTB0FG2/SHa6cK1SnspwbuHGEBPicWcYlX0QrLEsrfHN6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649227; c=relaxed/simple;
	bh=lLCHCamBtVNXptoFeKUmVi7Elzu065xUY1TPzVIdn58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prd++7zjxARTVrTyg7sjH/xdQlwl7CQRvnRFM1jhKuWBP/PHd+9HfLQp0heJ/JXzsC1Cp7l5VW3s0i503EWuzy4a++hK6kpgXfgzR78+sJ2YhPDM3+M+VskTdCYMjPElx+c2im9nop4YvrRO3kDhinnI7wtBrldHPYW3jBJDZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=UpbmLR84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UnFpuDey; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FEDD254022D;
	Mon, 10 Mar 2025 19:27:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 19:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1741649223; x=1741735623; bh=mDE7xI6V2F
	Nw5Y6b/fKTdCVlh23B60DTNVJoAGjzaGc=; b=UpbmLR843JQUL0h1BYTblQIbyO
	s7oi6u/y33lc3WT98VZVJD5snDDquZhqh7ReZpMsy6nUD/JaxXc5TjPlfBpX0G7l
	PShSWg9hRxRwfdeUAsXqUdkx/gOsrHxQs1mxcPSKHSM/hXNVnW3qkre89vJ5Sn6k
	gX4iqxaX3EJ9qx12BW6NBGnoeorgEKcwcRBEgFsfany7+NnnKSs5P52/RblQ7X8t
	nm85d/DqivWL6hVK2e1507iGavgDY5rFURLEypuP2IYv9oSwjl7dex97Wzmd1LJM
	OPE9RQmt7G+A7TVMlD7Yrj0EBZQo6+26AM15u++TY9+bt9QY66kDT7iRyU3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741649223; x=1741735623; bh=mDE7xI6V2FNw5Y6b/fKTdCVlh23B60DTNVJ
	oAGjzaGc=; b=UnFpuDeyO9VBRkF66IVfENqJvvUJE+hmPWQYTPSBx3hhr8Ao05F
	YL7fLh7Y0HgQ/pInSnuzYxxuV+2DaY1gKTotDEdUoLOs6tdCqCAIKbUbuOSQw0p9
	gVBoXNY2NlIaV4aDwyAt0V2eU5HwfeU7dN43dbzwhoNwO8oG/YvoWR5hR0eLvNeI
	KOokfm+d1aRfrP+rdKqpphuUJWgzlUR01rReB/FuY4cdkN8zDf2ODBkz71Mf+u2s
	2XhVhHsCPnVINLCyaa3NHU+VpCq1Ug8Vm74bo7luNRUvuJth+UZAX1Mc5a5c2KVe
	X+98WY2O1hFDrXCbBudrNAIdSPfGTdMoM4g==
X-ME-Sender: <xms:RnXPZ9XTQHGmbZ41xQ9De26xrU2_mvFTqpUPVUfxg_dkGj3PamPdHg>
    <xme:RnXPZ9mrPb2NUiESKEnE6qsIgf2v73ixn5Tn2fWnMwZhd6rFbitf7zuLc0_yufjGY
    Bnldwkh1l10gBHg9c0>
X-ME-Received: <xmr:RnXPZ5Z5E40mLPAQXOGjfoQcjYZU94BVC7pfmAufGrWK91KntNNGT7XHu9TY9rKHW17LJKnYP1m-GWt-NeQucYN5w4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RnXPZwX1sv_v4hxBWkVuvvd_0x5Hnr5GZZyvY7_KviSbXfDDUwvRdg>
    <xmx:RnXPZ3mVNBq8mc63e9zjvmsErX6j1lNWNNId5dgOXa4pFtq2vqqlBA>
    <xmx:RnXPZ9f2IKG7xsiU34RBCqmhdTSy7Ia2EdIF812Wi_8oINHflhp6mQ>
    <xmx:RnXPZxHVn6vifz2xSsYyS_uFa901JLETBESnvTXK_90q1r6rQmbtXg>
    <xmx:R3XPZ8x45YcjLhYqhmJe0w5lzCHqm_cI9pyCmKfPvQKoTfgtoZWJrVyo>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:27:02 -0400 (EDT)
Date: Mon, 10 Mar 2025 16:27:50 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs: prepare extent_io.c for future larger folio
 support
Message-ID: <20250310232750.GA967114@zen.localdomain>
References: <cover.1741591823.git.wqu@suse.com>
 <657d28be4aebee9d3b40e7e34b0c1b75fbbf5da6.1741591823.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657d28be4aebee9d3b40e7e34b0c1b75fbbf5da6.1741591823.git.wqu@suse.com>

On Mon, Mar 10, 2025 at 06:06:01PM +1030, Qu Wenruo wrote:
> When we're handling folios from filemap, we can no longer assume all
> folios are page sized.
> 
> Thus for call sites assuming the folio is page sized, change the
> PAGE_SIZE usage to folio_size() instead.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 337d2bed98d9..337908f09b88 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -425,7 +425,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
>  	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
>  
>  	ASSERT(folio_pos(folio) <= start &&
> -	       start + len <= folio_pos(folio) + PAGE_SIZE);
> +	       start + len <= folio_pos(folio) + folio_size(folio));
>  
>  	if (uptodate && btrfs_verify_folio(folio, start, len))
>  		btrfs_folio_set_uptodate(fs_info, folio, start, len);
> @@ -492,7 +492,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
>  		return;
>  
>  	ASSERT(folio_test_private(folio));
> -	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
> +	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), folio_size(folio));
>  }
>  
>  /*
> @@ -753,7 +753,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
>  {
>  	struct btrfs_inode *inode = folio_to_inode(folio);
>  
> -	ASSERT(pg_offset + size <= PAGE_SIZE);
> +	ASSERT(pg_offset + size <= folio_size(folio));
>  	ASSERT(bio_ctrl->end_io_func);
>  
>  	if (bio_ctrl->bbio &&
> @@ -935,7 +935,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  	struct inode *inode = folio->mapping->host;
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>  	u64 start = folio_pos(folio);
> -	const u64 end = start + PAGE_SIZE - 1;
> +	const u64 end = start + folio_size(folio) - 1;
>  	u64 extent_offset;
>  	u64 last_byte = i_size_read(inode);
>  	struct extent_map *em;
> @@ -1279,7 +1279,7 @@ static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bit
>  	unsigned int start_bit;
>  	unsigned int nbits;
>  
> -	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
> +	ASSERT(start >= folio_start && start + len <= folio_start + folio_size(folio));
>  	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
>  	nbits = len >> fs_info->sectorsize_bits;
>  	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
> @@ -1297,7 +1297,7 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
>  	unsigned int first_zero;
>  	unsigned int first_set;
>  
> -	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
> +	ASSERT(start >= folio_start && start < folio_start + folio_size(folio));
>  
>  	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
>  	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
> @@ -1499,10 +1499,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
>  		delalloc_end = page_end;
>  	/*
>  	 * delalloc_end is already one less than the total length, so
> -	 * we don't subtract one from PAGE_SIZE
> +	 * we don't subtract one from folio_size().
>  	 */
>  	delalloc_to_write +=
> -		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
> +		DIV_ROUND_UP(delalloc_end + 1 - page_start, folio_size(folio));
>  
>  	/*
>  	 * If all ranges are submitted asynchronously, we just need to account
> @@ -1765,7 +1765,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  		goto done;
>  
>  	ret = extent_writepage_io(inode, folio, folio_pos(folio),
> -				  PAGE_SIZE, bio_ctrl, i_size);
> +				  folio_size(folio), bio_ctrl, i_size);
>  	if (ret == 1)
>  		return 0;
>  	if (ret < 0)
> @@ -2492,8 +2492,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
>  
>  	while (cur <= end) {
> -		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> -		u32 cur_len = cur_end + 1 - cur;
> +		u64 cur_end;
> +		u32 cur_len;
>  		struct folio *folio;
>  
>  		folio = filemap_get_folio(mapping, cur >> PAGE_SHIFT);
> @@ -2503,13 +2503,18 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
>  		 * code is just in case, but shouldn't actually be run.
>  		 */
>  		if (IS_ERR(folio)) {
> +			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
> +			cur_len = cur_end + 1 - cur;

Curious: is this guess based on PAGE_SIZE more correct than using 1 as
num_bytes? How much more correct? :)

Probably better question: what is the behavior for the range
[PAGE_SIZE, folio_size(folio)] should that filemap_get_folio have
returned properly? If it truly can never happen AND we can't handle
it correctly, is handling it "sort of correctly" a good idea?

>  			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
>  						       cur, cur_len, false);
>  			mapping_set_error(mapping, PTR_ERR(folio));
> -			cur = cur_end + 1;
> +			cur = cur_end;
>  			continue;
>  		}
>  
> +		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
> +		cur_len = cur_end + 1 - cur;
> +
>  		ASSERT(folio_test_locked(folio));
>  		if (pages_dirty && folio != locked_folio)
>  			ASSERT(folio_test_dirty(folio));
> @@ -2621,7 +2626,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>  				     struct folio *folio)
>  {
>  	u64 start = folio_pos(folio);
> -	u64 end = start + PAGE_SIZE - 1;
> +	u64 end = start + folio_size(folio) - 1;
>  	bool ret;
>  
>  	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
> @@ -2659,7 +2664,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
>  bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
>  {
>  	u64 start = folio_pos(folio);
> -	u64 end = start + PAGE_SIZE - 1;
> +	u64 end = start + folio_size(folio) - 1;
>  	struct btrfs_inode *inode = folio_to_inode(folio);
>  	struct extent_io_tree *io_tree = &inode->io_tree;
>  
> -- 
> 2.48.1
> 

