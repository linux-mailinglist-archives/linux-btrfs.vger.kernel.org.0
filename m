Return-Path: <linux-btrfs+bounces-19175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56417C718AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E914E20BE
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BEC1C84A2;
	Thu, 20 Nov 2025 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="LEnx2+Qm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMtbHyUq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670B1A00F0
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763598112; cv=none; b=JUXFV8RMCCqYqy/OmFjmGI4CSnIxN6oc8fetiG6B34/JbbrTE/+7sEKmlM65Ye/WpAXw7YGLNXsHTlmZuJimDZiAAXEkpdFUyS1ZbMyC0FH2tUSUhfFGWa5KsmpeaslPnFua75ipJVxR6Drzbxq2VsEsTSNRvX9gxETITAXAMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763598112; c=relaxed/simple;
	bh=fQtl7sZ1qcjdWdMRU5S3VmmhtzxZaHr1+NoQJ4P4aNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5ewic6dvoaEqCu1Z5jqkxexMvWw15RDGZhNkqJx7W3qED42gMdPM1xHvFBweS2e1fhLpe4KLODuMADF9get1arno0PGq8DDb9LvkGSDQZ5HXc9BEh32CWYuXNsO0YQ507Sq1CqgxmazK0JRjlzOSkzoaAFuY99yT49t9e8fX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=LEnx2+Qm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMtbHyUq; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 48B9B1400132;
	Wed, 19 Nov 2025 19:21:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 19:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763598109; x=1763684509; bh=APSKsfbzsX
	aaiKGfB8YwvQCc6whB8CzwbAzeR2T/wRI=; b=LEnx2+Qmxe/fbaWgprCHNGTWcf
	M6Tl2caqS+0RoAhfZ1Wa1ZCbJnlVQXdESQd3o84DPoujW2sjIG2RohsLMQgiBQdO
	m/q0cEK92pWmsZsnbP4CrAZpNpC6v//0ukVd0MUeF/5VQV8m6gDgfycjLJdHPuS2
	vozUndW93Rpi1T0NNTZAG+R6xS36dfnSSavbQJhTAk0b9VIAlvHF+6Qje4rZmBZh
	xYld15HsWCV7l3XFrwCFxiTbt0pYlq6rFchFTtgbO6VC/YU1oYNgk8eALVe83zjC
	BtJQasi+qQ6Jhuex+7YFQ8sorPHX0ENhpYyaaHmYTvxxGgUXawrKijvHt3vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763598109; x=1763684509; bh=APSKsfbzsXaaiKGfB8YwvQCc6whB8CzwbAz
	eR2T/wRI=; b=TMtbHyUqm2rHhl1FZjEz0Xv79SVW3Hqo56q5WwOZnrD68PRBCpo
	dSN/OW0rk17ACLAa/n5thOZEmG1AUidNi1bXyS1Gt7ieMZvQLjtCJDPrPnohIqiQ
	L+G0abiV66fQX/GXGxh1MHELgb7OLcfTwUpXFOsO2PrItcXA/yTOFrD6HXKan57O
	tt91oDbs4wfKCLbkceUQlGupW2TUA0ivwmAgjegwZS2wQJ4BUSlLSv5iM1EgdMOk
	19GJh4RcFBvRzNn1aDx/+22Sf9oP6PJBjX6qMNJgpXykEB+/7lljQSFMIP0/1dns
	6YOZpFNnUztpFagNeEVxbGSv+3YxIgUR6CA==
X-ME-Sender: <xms:HF8eaVvRbHO12CFNIvSFLQvZdCDUZmWBZR1rHAxgU6ETF3SvxIfN3g>
    <xme:HF8eaUeF5KvZWi0EmLd9D5VvAGqTfKdwQctPRRirnOKDeqAfmUvzApSeDWuakjijJ
    mq64ON1nhBp4-YJws2PlvGL8So6BT1vPUzBxvXHFO0yinJTea84m9Y>
X-ME-Received: <xmr:HF8eaWZ_xyNVogmJ6RhVIcgYoj-rR9aeqfUWOCsmoU7JwKBMMD8c_JepuXk-K5MkjQDcpI6fxlgD834SmIopjQONZgM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HF8eaXUrSYZXPOY3fOPxAnz2S3CJk_m70uPtwbifPQPw6zgEqY4Itg>
    <xmx:HF8eaYgc1Vn72arwtGp9CfA2GEL2NEDnhvYHKEEdcFCgmui5VshVVg>
    <xmx:HF8eaVVBV5K_0fDBgCmMcue_YHJyp-6PovqFYpYzm2XAChrPrVtUfA>
    <xmx:HF8eafPhyX_6VDUCpnRzRfN_MG9FR6o4jM3mhLVz8hyzrUNLc28ibw>
    <xmx:HV8eaZBEVjgaBjLaXTaG1rw1ERtsCzN9sGu5ImSqJVvl25uRAJn4fEON>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 19:21:48 -0500 (EST)
Date: Wed, 19 Nov 2025 16:21:03 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 12/16] btrfs: replace identity remaps with actual
 remaps when doing relocations
Message-ID: <20251120002103.GC2478853@zen.localdomain>
References: <20251114184745.9304-1-mark@harmstone.com>
 <20251114184745.9304-13-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114184745.9304-13-mark@harmstone.com>

On Fri, Nov 14, 2025 at 06:47:17PM +0000, Mark Harmstone wrote:
> Add a function do_remap_tree_reloc(), which does the actual work of
> doing a relocation using the remap tree.
> 
> In a loop we call do_remap_reloc_trans(), which searches for the first
> identity remap for the block group. We call btrfs_reserve_extent() to
> find space elsewhere for it, and read the data into memory and write it
> to the new location. We then carve out the identity remap and replace it
> with an actual remap, which points to the new location in which to look.
> 
> Once the last identity remap has been removed we call
> last_identity_remap_gone(), which, as with deletions, removes the
> chunk's stripes and device extents.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/relocation.c | 336 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 336 insertions(+)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index a95899af811d..15c4a7c6b1ef 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4636,6 +4636,61 @@ static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int find_next_identity_remap(struct btrfs_trans_handle *trans,
> +				    struct btrfs_path *path, u64 bg_end,
> +				    u64 last_start, u64 *start,
> +				    u64 *length)
> +{
> +	int ret;
> +	struct btrfs_key key, found_key;
> +	struct btrfs_root *remap_root = trans->fs_info->remap_root;
> +	struct extent_buffer *leaf;
> +
> +	key.objectid = last_start;
> +	key.type = BTRFS_IDENTITY_REMAP_KEY;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, remap_root, &key, path, 0, 0);
> +	if (ret < 0)
> +		goto out;
> +
> +	leaf = path->nodes[0];
> +	while (true) {
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(remap_root, path);
> +
> +			if (ret != 0) {
> +				if (ret == 1)
> +					ret = -ENOENT;
> +				goto out;
> +			}
> +
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.objectid >= bg_end) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
> +
> +		if (found_key.type == BTRFS_IDENTITY_REMAP_KEY) {
> +			*start = found_key.objectid;
> +			*length = found_key.offset;
> +			ret = 0;
> +			goto out;
> +		}
> +
> +		path->slots[0]++;
> +	}
> +
> +out:
> +	btrfs_release_path(path);
> +
> +	return ret;
> +}
> +
>  static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>  				struct btrfs_chunk_map *chunk,
>  				struct btrfs_path *path)
> @@ -4781,6 +4836,96 @@ static void adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>  		btrfs_mark_bg_fully_remapped(bg, trans);
>  }
>  
> +static int add_remap_entry(struct btrfs_trans_handle *trans,
> +			   struct btrfs_path *path,
> +			   struct btrfs_block_group *src_bg, u64 old_addr,
> +			   u64 new_addr, u64 length)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_key key, new_key;
> +	int ret;
> +	int identity_count_delta = 0;
> +
> +	key.objectid = old_addr;
> +	key.type = (u8)-1;
> +	key.offset = (u64)-1;
> +
> +	ret = btrfs_search_slot(trans, fs_info->remap_root, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto end;
> +
> +	if (path->slots[0] == 0) {
> +		ret = -ENOENT;
> +		goto end;
> +	}
> +
> +	path->slots[0]--;
> +
> +	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +
> +	if (key.type != BTRFS_IDENTITY_REMAP_KEY ||
> +	    key.objectid > old_addr ||
> +	    key.objectid + key.offset <= old_addr) {
> +		ret = -ENOENT;
> +		goto end;
> +	}
> +
> +	/* Shorten or delete identity mapping entry. */
> +
> +	if (key.objectid == old_addr) {
> +		ret = btrfs_del_item(trans, fs_info->remap_root, path);
> +		if (ret)
> +			goto end;
> +
> +		identity_count_delta--;
> +	} else {
> +		new_key.objectid = key.objectid;
> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
> +		new_key.offset = old_addr - key.objectid;
> +
> +		btrfs_set_item_key_safe(trans, path, &new_key);
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	/* Create new remap entry. */
> +
> +	ret = add_remap_item(trans, path, new_addr, length, old_addr);
> +	if (ret)
> +		goto end;
> +
> +	/* Add entry for remainder of identity mapping, if necessary. */
> +
> +	if (key.objectid + key.offset != old_addr + length) {
> +		new_key.objectid = old_addr + length;
> +		new_key.type = BTRFS_IDENTITY_REMAP_KEY;
> +		new_key.offset = key.objectid + key.offset - old_addr - length;
> +
> +		ret = btrfs_insert_empty_item(trans, fs_info->remap_root,
> +					      path, &new_key, 0);
> +		if (ret)
> +			goto end;
> +
> +		btrfs_release_path(path);
> +
> +		identity_count_delta++;
> +	}
> +
> +	/* Add backref. */
> +
> +	ret = add_remap_backref_item(trans, path, new_addr, length, old_addr);
> +	if (ret)
> +		goto end;
> +
> +	if (identity_count_delta != 0)
> +		adjust_identity_remap_count(trans, src_bg, identity_count_delta);
> +
> +end:
> +	btrfs_release_path(path);
> +
> +	return ret;
> +}
> +
>  static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>  			       struct btrfs_path *path, uint64_t start)
>  {
> @@ -4830,6 +4975,189 @@ static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int do_remap_reloc_trans(struct btrfs_fs_info *fs_info,
> +				struct btrfs_block_group *src_bg,
> +				struct btrfs_path *path, u64 *last_start)
> +{
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_root *extent_root;
> +	struct btrfs_key ins;
> +	struct btrfs_block_group *dest_bg = NULL;
> +	u64 start, remap_length, length, new_addr, min_size;
> +	int ret;
> +	bool no_more = false;
> +	bool is_data = src_bg->flags & BTRFS_BLOCK_GROUP_DATA;
> +	bool made_reservation = false, bg_needs_free_space;
> +	struct btrfs_space_info *sinfo = src_bg->space_info;
> +
> +	extent_root = btrfs_extent_root(fs_info, src_bg->start);
> +
> +	trans = btrfs_start_transaction(extent_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	ret = find_next_identity_remap(trans, path, src_bg->start + src_bg->length,
> +				       *last_start, &start, &remap_length);
> +	if (ret == -ENOENT) {
> +		no_more = true;
> +		goto next;
> +	} else if (ret) {
> +		mutex_unlock(&fs_info->remap_mutex);
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	/* Try to reserve enough space for block. */
> +
> +	spin_lock(&sinfo->lock);
> +	btrfs_space_info_update_bytes_may_use(sinfo, remap_length);
> +	spin_unlock(&sinfo->lock);
> +
> +	if (is_data)
> +		min_size = fs_info->sectorsize;
> +	else
> +		min_size = fs_info->nodesize;
> +
> +	/*
> +	 * We're using btrfs_reserve_extent() to allocate a contiguous
> +	 * logical address range, but this will become a remap item rather than
> +	 * an extent in the extent tree.
> +	 *
> +	 * Short allocations are fine: it means that we chop off the beginning
> +	 * of the identity remap that we're processing, and will tackle the
> +	 * rest of it the next time round.
> +	 */
> +	ret = btrfs_reserve_extent(fs_info->fs_root, remap_length,
> +				   remap_length, min_size,
> +				   0, 0, &ins, is_data, false);
> +	if (ret) {
> +		spin_lock(&sinfo->lock);
> +		btrfs_space_info_update_bytes_may_use(sinfo, -remap_length);
> +		spin_unlock(&sinfo->lock);
> +
> +		mutex_unlock(&fs_info->remap_mutex);
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	made_reservation = true;
> +
> +	new_addr = ins.objectid;
> +	length = ins.offset;
> +
> +	if (!is_data && !IS_ALIGNED(length, fs_info->nodesize)) {
> +		u64 new_length = ALIGN_DOWN(length, fs_info->nodesize);
> +
> +		btrfs_free_reserved_extent(fs_info, new_addr + new_length,
> +					   length - new_length, 0);
> +
> +		length = new_length;
> +	}
> +
> +	dest_bg = btrfs_lookup_block_group(fs_info, new_addr);
> +
> +	mutex_lock(&dest_bg->free_space_lock);
> +	bg_needs_free_space = test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> +				       &dest_bg->runtime_flags);
> +	mutex_unlock(&dest_bg->free_space_lock);
> +
> +	if (bg_needs_free_space) {
> +		ret = btrfs_add_block_group_free_space(trans, dest_bg);
> +		if (ret)
> +			goto fail;
> +	}
> +
> +	ret = do_copy(fs_info, start, new_addr, length);
> +	if (ret)
> +		goto fail;
> +
> +	ret = btrfs_remove_from_free_space_tree(trans, new_addr, length);
> +	if (ret)
> +		goto fail;
> +
> +	ret = add_remap_entry(trans, path, src_bg, start, new_addr, length);
> +	if (ret) {
> +		btrfs_add_to_free_space_tree(trans, new_addr, length);
> +		goto fail;
> +	}
> +
> +	adjust_block_group_remap_bytes(trans, dest_bg, length);
> +	btrfs_free_reserved_bytes(dest_bg, length, 0);
> +
> +	spin_lock(&sinfo->lock);
> +	sinfo->bytes_readonly += length;
> +	spin_unlock(&sinfo->lock);
> +
> +next:
> +	if (dest_bg)
> +		btrfs_put_block_group(dest_bg);
> +
> +	if (made_reservation)
> +		btrfs_dec_block_group_reservations(fs_info, new_addr);
> +
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	if (src_bg->identity_remap_count == 0) {
> +		bool mark_fully_remapped = false;
> +
> +		spin_lock(&src_bg->lock);
> +
> +		if (!src_bg->fully_remapped) {
> +			mark_fully_remapped = true;
> +			src_bg->fully_remapped = true;
> +		}
> +
> +		spin_unlock(&src_bg->lock);
> +
> +		if (mark_fully_remapped)
> +			btrfs_mark_bg_fully_remapped(src_bg, trans);
> +	}
> +
> +	ret = btrfs_end_transaction(trans);
> +	if (ret)
> +		return ret;
> +
> +	if (no_more)
> +		return 1;
> +
> +	*last_start = start;
> +
> +	return 0;
> +
> +fail:
> +	if (dest_bg)
> +		btrfs_put_block_group(dest_bg);
> +
> +	btrfs_free_reserved_extent(fs_info, new_addr, length, 0);
> +
> +	mutex_unlock(&fs_info->remap_mutex);
> +	btrfs_end_transaction(trans);
> +
> +	return ret;
> +}
> +
> +static int do_remap_reloc(struct btrfs_fs_info *fs_info,
> +			  struct btrfs_path *path, struct btrfs_block_group *bg)
> +{
> +	u64 last_start;
> +	int ret;
> +
> +	last_start = bg->start;
> +
> +	while (true) {
> +		ret = do_remap_reloc_trans(fs_info, bg, path, &last_start);
> +		if (ret) {
> +			if (ret == 1)
> +				ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length)
>  {
> @@ -5123,6 +5451,14 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  		}
>  
>  		ret = start_block_group_remapping(fs_info, path, bg);
> +		if (ret)
> +			goto out;
> +
> +		ret = do_remap_reloc(fs_info, path, rc->block_group);
> +		if (ret)
> +			goto out;
> +
> +		btrfs_delete_unused_bgs(fs_info);
>  	} else {
>  		ret = do_nonremap_reloc(fs_info, verbose, rc);
>  	}
> -- 
> 2.51.0
> 

