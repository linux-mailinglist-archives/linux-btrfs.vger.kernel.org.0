Return-Path: <linux-btrfs+bounces-18502-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE6C273DD
	for <lists+linux-btrfs@lfdr.de>; Sat, 01 Nov 2025 01:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B71894E6D4B
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Nov 2025 00:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EB335948;
	Sat,  1 Nov 2025 00:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LOUrNiED";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="deXup/+n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994B2F56
	for <linux-btrfs@vger.kernel.org>; Sat,  1 Nov 2025 00:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955352; cv=none; b=VWs7zIoeOawLNowf1DmnYl4TG4ITXt4Q3vetrnBPwiytcbKfJFPqco566+USPv8881wseXEgSGrxzgY3K6psrwHq0ymLQwUdR/Y8oaV6sz54vKj6cfirtAnyPM1ZhpDgQqXvEhBNj+QI3zHh15b/fygNo3szBv5DuZY1A6xPZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955352; c=relaxed/simple;
	bh=IsTcrqZuy6PMzDsHNqOB408UMBb/H8bFcONDPdnJd/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AS2q/Ezt5tY7wdZmBWy1A/yocCn6zgsKuQbGVXSXn2uxqgMjxgyit//eL6wo0LTky5Zg4b9maiJXyZL0Soob/BwUHXyRcNxKtK1H5+wkdRDEm4UoPRAMBGWITYKwPQjmo08kybNgWtMlCLzEr8RKFjSlxeaz7dVb/PWWLBvcDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LOUrNiED; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=deXup/+n; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E994140018E;
	Fri, 31 Oct 2025 20:02:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 31 Oct 2025 20:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761955347; x=1762041747; bh=rDenqtS1pN
	NjyQizunHi2rMdF2I29Bg60PXy+RwTXWM=; b=LOUrNiEDNWqHWiIGYu2SGPe7D9
	x3KHwpVS7u6cMNuM1woPcoseVdnjGiDqlbQc5jf5/MpfOz+rWZD1D0iFMttaLetG
	N6DSut8Gv6ARyznlywakMvkdEF3tSn+QzUcMciTXTfl8hzI6RcL52QOTCXLbuxvx
	pQCRbvAALS+Mo/w5ll89Siq1MjdAicV5xA4hiw+LYRthcfja6MLcmsguZ+OFK7ci
	/RIA1okBiEr7KpkPm3iYzEjhWBF1DOzxSExEprgDAR9d02VObDZGjzz1eMn7iTYf
	uq5dkN63u6KTQx9NIgXqercVZLcKL/0h3OjJ/WUIPDWp2jp0k/ynMqS85o9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761955347; x=1762041747; bh=rDenqtS1pNNjyQizunHi2rMdF2I29Bg60PX
	y+RwTXWM=; b=deXup/+noml+wy3r+BAW0pSX54YOlToeS45MgRNw2vgEnfoTztS
	OHNfAGEBG/JNbcbaLlAAAlR2d9Rahu0yrzpHzMRede6uWYAxVmcUwzZPUYjp8bqH
	XQJZzaLN2+rjvLTI09LmPX/Svm4ndAE564jYf1NN53wRfOmXIEjR597zbniuofu3
	INh+dU+ohvoJQNkG5RBDRjsV4Mu17YaqVrgBucHglYd0mCWQuCfq3lGUyltq9xMu
	E0ri9BCcYu4vWJxNJTx5vMozQfTyaYeCTnEk86rLBt6zYOkEzc5g7ZJfR70vAeMR
	c6/3mbOMh8kPPjqhvkdKg2bQ6aPocnK/08g==
X-ME-Sender: <xms:E04FaYhGB36ywd19wTwTq-V6PAwB0Y9l5IkTRWVtIP-UoyWIV5oqUA>
    <xme:E04FaXDXagCFst9g-HxABRj8L9mlKyj-D1KceXVkmA7QZZV0ulPg6TRXbqbjP8IEG
    g8g_ohpjQTh9foRYtkqloIgLCQskTpLC3sj0P5nP6vTrUtX-vFgIE00>
X-ME-Received: <xmr:E04FadtQlRqklUaPpUsuwSnHO0xzwpc-51RmcC3zJwAQp8jb7iqbHDN4RxL5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeeite
    ffhedtieetfeeffeelhedtheevheeviefftdethffggfeikeeuiefggedvjeenucffohhm
    rghinhepsghipghithgvrhdrsghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrghrkheshhgrrhhmshhtohhnvg
    drtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:E04FaUZ49hNDpPGjv5sKKvYT9tdXt9lzJv_96_NlaWLXnZjx8TCKig>
    <xmx:E04FaYWXTm6dJUk8XPgvM3ESHVMuhkxyMw_yWY-BoJYAx85rHyZ7iQ>
    <xmx:E04FaQ7tyzXNbFySoDZrThGyPBCPR1G8TeHPKvDwEIjB5am5rk5dUw>
    <xmx:E04Fabg1S6d1wfeyo-VaRkBoVEb9Iy0GrbHfa1teQ6pzj2_PrDbJhA>
    <xmx:E04FadXebTrWyTFq7-zdRrJBrIqIc_pzWNInPDv7NzNam5c07JQ3Mn4e>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 20:02:26 -0400 (EDT)
Date: Fri, 31 Oct 2025 17:02:24 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 11/16] btrfs: move existing remaps before relocating
 block group
Message-ID: <aQVOEFx9CvJQH7Bq@devvm12410.ftw0.facebook.com>
References: <20251024181227.32228-1-mark@harmstone.com>
 <20251024181227.32228-12-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024181227.32228-12-mark@harmstone.com>

On Fri, Oct 24, 2025 at 07:12:12PM +0100, Mark Harmstone wrote:
> If when relocating a block group we find that `remap_bytes` > 0 in its
> block group item, that means that it has been the destination block
> group for another that has been remapped.
> 
> We need to seach the remap tree for any remap backrefs within this
> range, and move the data to a third block group. This is because
> otherwise btrfs_translate_remap() could end up following an unbounded
> chain of remaps, which would only get worse over time.
> 
> We only relocate one block group at a time, so `remap_bytes` will only
> ever go down while we are doing this. Once we're finished we set the
> REMAPPED flag on the block group, which will permanently prevent any
> other data from being moved to within it.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/extent-tree.c |   6 +-
>  fs/btrfs/relocation.c  | 481 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 485 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1c14e0c82c03..10dc6f8d2f71 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -4545,7 +4545,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		    block_group->cached != BTRFS_CACHE_NO) {
>  			down_read(&space_info->groups_sem);
>  			if (list_empty(&block_group->list) ||
> -			    block_group->ro) {
> +			    block_group->ro ||
> +			    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
>  				/*
>  				 * someone is removing this block group,
>  				 * we can't jump into the have_block_group
> @@ -4579,7 +4580,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  
>  		ffe_ctl->hinted = false;
>  		/* If the block group is read-only, we can skip it entirely. */
> -		if (unlikely(block_group->ro)) {
> +		if (unlikely(block_group->ro) ||
> +		    block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
>  			if (ffe_ctl->for_treelog)
>  				btrfs_clear_treelog_bg(block_group);
>  			if (ffe_ctl->for_data_reloc)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index cd53509c2fda..d31817379078 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3987,6 +3987,481 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>  }
>  
> +struct reloc_io_private {
> +	struct completion done;
> +	refcount_t pending_refs;
> +	blk_status_t status;
> +};
> +
> +static void reloc_endio(struct btrfs_bio *bbio)
> +{
> +	struct reloc_io_private *priv = bbio->private;
> +
> +	if (bbio->bio.bi_status)
> +		WRITE_ONCE(priv->status, bbio->bio.bi_status);
> +
> +	if (refcount_dec_and_test(&priv->pending_refs))
> +		complete(&priv->done);
> +
> +	bio_put(&bbio->bio);
> +}
> +
> +static int copy_remapped_data_io(struct btrfs_fs_info *fs_info,
> +				 struct reloc_io_private *priv,
> +				 struct page **pages, u64 addr, u64 length,
> +				 bool do_write)
> +{
> +	struct btrfs_bio *bbio;
> +	unsigned long i = 0;
> +	blk_opf_t op = do_write ? REQ_OP_WRITE : REQ_OP_READ;
> +
> +	init_completion(&priv->done);
> +	refcount_set(&priv->pending_refs, 1);
> +	priv->status = 0;
> +
> +	bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info, reloc_endio,
> +			       priv);
> +	bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
> +
> +	do {
> +		size_t bytes = min_t(u64, length, PAGE_SIZE);
> +
> +		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
> +			refcount_inc(&priv->pending_refs);
> +			btrfs_submit_bbio(bbio, 0);
> +
> +			bbio = btrfs_bio_alloc(BIO_MAX_VECS, op, fs_info,
> +					       reloc_endio, priv);
> +			bbio->bio.bi_iter.bi_sector = addr >> SECTOR_SHIFT;
> +			continue;
> +		}
> +
> +		i++;
> +		addr += bytes;
> +		length -= bytes;
> +	} while (length);
> +
> +	refcount_inc(&priv->pending_refs);
> +	btrfs_submit_bbio(bbio, 0);
> +
> +	if (!refcount_dec_and_test(&priv->pending_refs))
> +		wait_for_completion_io(&priv->done);
> +
> +	return blk_status_to_errno(READ_ONCE(priv->status));
> +}
> +
> +static int copy_remapped_data(struct btrfs_fs_info *fs_info, u64 old_addr,
> +			      u64 new_addr, u64 length)
> +{
> +	int ret;
> +	struct page **pages;
> +	unsigned int nr_pages;
> +	struct reloc_io_private priv;
> +
> +	nr_pages = DIV_ROUND_UP(length, PAGE_SIZE);

length + (PAGE_SIZE - 1) >> PAGE_SHIFT avoids the division

You may also want to bail out if you detect the bs > ps case Qu is
working on, as I believe that will require using large folios here.

> +	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> +	ret = btrfs_alloc_page_array(nr_pages, pages, 0);
> +	if (ret) {
> +		ret = -ENOMEM;
> +		goto end;
> +	}
> +
> +	ret = copy_remapped_data_io(fs_info, &priv, pages, old_addr, length,
> +				    false);
> +	if (ret)
> +		goto end;
> +
> +	ret = copy_remapped_data_io(fs_info, &priv, pages, new_addr, length,
> +				    true);
> +
> +end:
> +	for (unsigned int i = 0; i < nr_pages; i++) {
> +		if (pages[i])
> +			__free_page(pages[i]);
> +	}
> +	kfree(pages);
> +
> +	return ret;
> +}
> +
> +static int do_copy(struct btrfs_fs_info *fs_info, u64 old_addr, u64 new_addr,
> +		   u64 length)
> +{
> +	int ret;
> +
> +	/* Copy 1MB at a time, to avoid using too much memory. */

Seems sort of arbitrary.
How does this relate to the max via BIO_MAX_VECS?

> +
> +	do {
> +		u64 to_copy = min_t(u64, length, SZ_1M);
> +
> +		ret = copy_remapped_data(fs_info, old_addr, new_addr,
> +					 to_copy);
> +		if (ret)
> +			return ret;
> +
> +		if (to_copy == length)
> +			break;
> +
> +		old_addr += to_copy;
> +		new_addr += to_copy;
> +		length -= to_copy;
> +	} while (true);
> +
> +	return 0;
> +}
> +
> +static int add_remap_item(struct btrfs_trans_handle *trans,
> +			  struct btrfs_path *path, u64 new_addr, u64 length,
> +			  u64 old_addr)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_remap remap;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret;
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_REMAP_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root, path,
> +				      &key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	btrfs_set_stack_remap_address(&remap, new_addr);
> +
> +	write_extent_buffer(leaf, &remap,
> +			    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +			    sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
> +
> +	return 0;
> +}
> +
> +static int add_remap_backref_item(struct btrfs_trans_handle *trans,
> +				  struct btrfs_path *path, u64 new_addr,
> +				  u64 length, u64 old_addr)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_remap remap;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	int ret;
> +
> +	key.objectid = new_addr;
> +	key.type = BTRFS_REMAP_BACKREF_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +				      path, &key, sizeof(struct btrfs_remap));
> +	if (ret)
> +		return ret;
> +
> +	leaf = path->nodes[0];
> +
> +	btrfs_set_stack_remap_address(&remap, old_addr);
> +
> +	write_extent_buffer(leaf, &remap,
> +			    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +			    sizeof(struct btrfs_remap));
> +
> +	btrfs_release_path(path);
> +
> +	return 0;
> +}
> +
> +static int move_existing_remap(struct btrfs_fs_info *fs_info,
> +			       struct btrfs_path *path,
> +			       struct btrfs_block_group *bg, u64 new_addr,
> +			       u64 length, u64 old_addr)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap_ptr, remap;
> +	struct btrfs_key key, ins;
> +	u64 dest_addr, dest_length, min_size;
> +	struct btrfs_block_group *dest_bg;
> +	int ret;
> +	bool is_data = bg->flags & BTRFS_BLOCK_GROUP_DATA;
> +	struct btrfs_space_info *sinfo = bg->space_info;
> +	bool mutex_taken = false, bg_needs_free_space;
> +
> +	spin_lock(&sinfo->lock);
> +	btrfs_space_info_update_bytes_may_use(sinfo, length);
> +	spin_unlock(&sinfo->lock);
> +
> +	if (is_data)
> +		min_size = fs_info->sectorsize;
> +	else
> +		min_size = fs_info->nodesize;
> +
> +	ret = btrfs_reserve_extent(fs_info->fs_root, length, length, min_size,
> +				   0, 0, &ins, is_data, false);
> +	if (ret) {
> +		spin_lock(&sinfo->lock);
> +		btrfs_space_info_update_bytes_may_use(sinfo, -length);
> +		spin_unlock(&sinfo->lock);
> +		return ret;
> +	}
> +
> +	dest_addr = ins.objectid;
> +	dest_length = ins.offset;
> +
> +	if (!is_data && !IS_ALIGNED(dest_length, fs_info->nodesize)) {
> +		u64 new_length = ALIGN_DOWN(dest_length, fs_info->nodesize);
> +
> +		btrfs_free_reserved_extent(fs_info, dest_addr + new_length,
> +					   dest_length - new_length, 0);
> +
> +		dest_length = new_length;
> +	}
> +
> +	trans = btrfs_join_transaction(fs_info->remap_root);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		trans = NULL;
> +		goto end;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +	mutex_taken = true;
> +
> +	/* Find old remap entry. */
> +
> +	key.objectid = old_addr;
> +	key.type = BTRFS_REMAP_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
> +				path, 0, 1);
> +	if (ret == 1) {
> +		/*
> +		 * Not a problem if the remap entry wasn't found: that means
> +		 * that another transaction has deallocated the data.
> +		 * move_existing_remaps() loops until the BG contains no
> +		 * remaps, so we can just return 0 in this case.
> +		 */

I agree with this reasoning. However, what prevents someone from
deallocating this data after we have found the entry? Is there some
higher locking that protects us? As far as I can tell if the last extent
goes away we could delete the remap entry while simultaneously moving
it here?

> +		btrfs_release_path(path);
> +		ret = 0;
> +		goto end;
> +	} else if (ret) {
> +		goto end;
> +	}
> +
> +	ret = do_copy(fs_info, new_addr, dest_addr, dest_length);
> +	if (ret)
> +		goto end;
> +
> +	/* Change data of old remap entry. */
> +
> +	leaf = path->nodes[0];
> +
> +	remap_ptr = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> +	btrfs_set_remap_address(leaf, remap_ptr, dest_addr);
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	if (dest_length != length) {
> +		key.offset = dest_length;
> +		btrfs_set_item_key_safe(trans, path, &key);
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	if (dest_length != length) {
> +		/* Add remap item for remainder. */
> +
> +		ret = add_remap_item(trans, path, new_addr + dest_length,
> +				     length - dest_length,
> +				     old_addr + dest_length);
> +		if (ret)
> +			goto end;
> +	}
> +
> +	/* Change or remove old backref. */
> +
> +	key.objectid = new_addr;
> +	key.type = BTRFS_REMAP_BACKREF_KEY;
> +	key.offset = length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key,
> +				path, -1, 1);
> +	if (ret) {
> +		if (ret == 1) {
> +			btrfs_release_path(path);
> +			ret = -ENOENT;
> +		}
> +		goto end;
> +	}
> +
> +	leaf = path->nodes[0];
> +
> +	if (dest_length == length) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret) {
> +			btrfs_release_path(path);
> +			goto end;
> +		}
> +	} else {
> +		key.objectid += dest_length;
> +		key.offset -= dest_length;
> +		btrfs_set_item_key_safe(trans, path, &key);
> +
> +		btrfs_set_stack_remap_address(&remap, old_addr + dest_length);
> +
> +		write_extent_buffer(leaf, &remap,
> +				    btrfs_item_ptr_offset(leaf, path->slots[0]),
> +				    sizeof(struct btrfs_remap));
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	/* Add new backref. */
> +
> +	ret = add_remap_backref_item(trans, path, dest_addr, dest_length,
> +				     old_addr);
> +	if (ret)
> +		goto end;
> +
> +	adjust_block_group_remap_bytes(trans, bg, -dest_length);
> +
> +	ret = btrfs_add_to_free_space_tree(trans, new_addr, dest_length);
> +	if (ret)
> +		goto end;
> +
> +	dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
> +
> +	adjust_block_group_remap_bytes(trans, dest_bg, dest_length);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +	btrfs_put_block_group(dest_bg);
> +
> +	if (bg_needs_free_space) {
> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
> +		if (ret)
> +			goto end;
> +	}
> +
> +	ret = btrfs_remove_from_free_space_tree(trans, dest_addr, dest_length);
> +	if (ret) {
> +		btrfs_remove_from_free_space_tree(trans, new_addr,
> +						  dest_length);
> +		goto end;
> +	}
> +
> +	ret = 0;
> +
> +end:
> +	if (mutex_taken)
> +		mutex_unlock(&fs_info->remap_mutex);
> +
> +	btrfs_dec_block_group_reservations(fs_info, dest_addr);
> +
> +	if (ret) {
> +		btrfs_free_reserved_extent(fs_info, dest_addr, dest_length, 0);
> +
> +		if (trans) {
> +			btrfs_abort_transaction(trans, ret);
> +			btrfs_end_transaction(trans);
> +		}
> +	} else {
> +		dest_bg = btrfs_lookup_block_group(fs_info, dest_addr);
> +		btrfs_free_reserved_bytes(dest_bg, dest_length, 0);
> +		btrfs_put_block_group(dest_bg);
> +
> +		ret = btrfs_commit_transaction(trans);
> +	}
> +
> +	return ret;
> +}
> +
> +static int move_existing_remaps(struct btrfs_fs_info *fs_info,
> +				struct btrfs_block_group *bg,
> +				struct btrfs_path *path)
> +{
> +	int ret;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap;
> +	u64 old_addr;
> +
> +	/* Look for backrefs in remap tree. */
> +
> +	while (bg->remap_bytes > 0) {
> +		key.objectid = bg->start;
> +		key.type = BTRFS_REMAP_BACKREF_KEY;
> +		key.offset = 0;
> +
> +		ret = btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> +					0, 0);
> +		if (ret < 0)
> +			return ret;
> +
> +		leaf = path->nodes[0];
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(fs_info->remap_root, path);
> +			if (ret < 0) {
> +				btrfs_release_path(path);
> +				return ret;
> +			}
> +
> +			if (ret) {
> +				btrfs_release_path(path);
> +				break;
> +			}
> +
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +		if (key.type != BTRFS_REMAP_BACKREF_KEY) {
> +			path->slots[0]++;
> +
> +			if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +				ret = btrfs_next_leaf(fs_info->remap_root, path);
> +				if (ret < 0) {
> +					btrfs_release_path(path);
> +					return ret;
> +				}
> +
> +				if (ret) {
> +					btrfs_release_path(path);
> +					break;
> +				}
> +
> +				leaf = path->nodes[0];
> +			}
> +		}
> +
> +		remap = btrfs_item_ptr(leaf, path->slots[0],
> +				       struct btrfs_remap);
> +
> +		old_addr = btrfs_remap_address(leaf, remap);
> +
> +		btrfs_release_path(path);
> +
> +		ret = move_existing_remap(fs_info, path, bg, key.objectid,
> +					  key.offset, old_addr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	BUG_ON(bg->remap_bytes > 0);
> +
> +	return 0;
> +}
> +
>  static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>  				     struct btrfs_path *path,
>  				     struct btrfs_block_group *bg)
> @@ -4564,6 +5039,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	WARN_ON(ret && ret != -EAGAIN);
>  
>  	if (*using_remap_tree) {
> +		if (bg->remap_bytes != 0) {
> +			ret = move_existing_remaps(fs_info, bg, path);
> +			if (ret)
> +				goto out;
> +		}
> +
>  		ret = start_block_group_remapping(fs_info, path, bg);
>  		goto out;
>  	}
> -- 
> 2.49.1
> 

