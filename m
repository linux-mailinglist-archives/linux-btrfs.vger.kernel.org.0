Return-Path: <linux-btrfs+bounces-14658-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C2AD98A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Jun 2025 01:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B4E3BE6E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D5D28EA76;
	Fri, 13 Jun 2025 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ffLGQgJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMQJATIe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD248F6C
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749857139; cv=none; b=L3PSAGn9cAvgBHpA1YqPGzhiRnJIsLqw6av2R28gmBEJz8ln8vMbKbIUGpqfymveQCAH75pWxsmOOT3aprPMlOCRUoN3Dz5ptj0N/oDqShjRS7EEl1D/Rf7b/XPZfKyPei6b9YC0Og9nh9asjsyDwIaflMleP2NwkKaG6d6sp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749857139; c=relaxed/simple;
	bh=DfS0DFK6R8ETU3Kkt3GOuK5AWh5NNj4zQjeTQLPbwQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSu3qwc7uSR0DdkQsz31efxfFNc+36YPaD9U7+cYOqV/R1CQiUs6LC5I06z+GHsSnQxDbThPAnwU3d09zf0Mn1XveKXNITmJeFZK9KrwIIkJsHyyGEYRhSfoKDFzB2WKJ9UO/Uu+YQIhlDwFP70IjwGVwS6YAHjWnAuQ+e5oSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ffLGQgJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMQJATIe; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6639A138036F;
	Fri, 13 Jun 2025 19:25:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Jun 2025 19:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749857135; x=1749943535; bh=l1XvJh15ou
	XPmdxgH3rsvRbbD2P5lQK/sN77MyDli7A=; b=ffLGQgJxC6Rk3cui5OCA2BCroJ
	tod28U2XzQpzD9luSHtlBH2zL1LqAZWXNJQqDdP823nLM3M6CswZh2D3nC9jUO98
	2VVltMeC70Sd6f9FjkqZR8zX1X82MwW8da39satmGc0hZt3u/vzYhvYfPmPJNuSZ
	AYfX18PogeD9R/C8GRWDj4TFfqJj4TbdTCXgPrreXZiWdIhFKKLLcmwE87z0lxwF
	Uf9ve/YUks3h13UdOmNzpxgtF+kIpx6DMHDiNjvHIfU5A2w600exBCrOiCAo3jRO
	FZMhRZIvFYsbchHkolkHfqZ4d3uW29+N1xPA8ok9JD400+9XayUV9H+KGWgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749857135; x=1749943535; bh=l1XvJh15ouXPmdxgH3rsvRbbD2P5lQK/sN7
	7MyDli7A=; b=WMQJATIe0EJ87Jd/+4ceEJYjG0NPu33Jb2i19lhJxnIzKGv/8Q3
	DYN9Y/UQH0yFEelIYEKBkE/iLckO8aT3lA3+HoYnJjZZeSSj/CP3e6Ft9UWjz3Wy
	WBIqB0cEbp9y4L//sjGxyCcaNPIf2ErjCL/QoxB6IGVicub2fyWkfbhKggGCg7fb
	9XV/fTa9cNoa1cICJlLafninsMrDoyqRS8YtXL1orBIyKdnabpPLK86k4pxS3DLB
	8pqGq+5qh4lv9o9Mi6sL0vlnEs23rKBFOU8PRfgDEBt7jT9Y/lB0yXH9DteWDIed
	15oggvtrAD+R7cV9KVZ+RFEBUD8uX4VwVKA==
X-ME-Sender: <xms:b7NMaEqFOWUPsY7V31DCylSCHAjJlJ9wcRC0Fm21Yx8rSR9gJM2zvA>
    <xme:b7NMaKpYbBvb8nKYjK14SX7Oce1eEUramVrucK7cH8Iu_aQ76ZzSctMUrW93j-HaQ
    CjxVmyHMKhuhBUvbiA>
X-ME-Received: <xmr:b7NMaJPU4iRl62GXpLmDMTqE4fUWVon-KVFWe-yrLU2-uGh8R1JTeanDF0BHaz4AZOKb_eoWqB4-2lpqHSBbWtyqQIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduledviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b7NMaL4A-DVLuwyxtvrMlRnLhiwvYih04PCRDyA6GMJ4uEDlCyrn7g>
    <xmx:b7NMaD7JrnpUUJQJwwRs1wClW3dfoJbh_zQ_QUZK0-52n-ytEhMJ0A>
    <xmx:b7NMaLj_Rw-jgP6PGD0GzYmtK2_NR4QW7nH4Tuh8opfcYX3EOeM20Q>
    <xmx:b7NMaN7CpPFzgB3Zdkk1FrkfrEejLFtWEHynO170-w64ryUpMScuHQ>
    <xmx:b7NMaPOjoUWcGdoB1pguqzURNh9Ad0pWRfs2p6ftr2zplAl4RSEmXQVU>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 19:25:34 -0400 (EDT)
Date: Fri, 13 Jun 2025 16:25:15 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 10/12] btrfs: handle setting up relocation of block group
 with remap-tree
Message-ID: <20250613232515.GF3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-11-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-11-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:40PM +0100, Mark Harmstone wrote:
> Handle the preliminary work for relocating a block group in a filesystem
> with the remap-tree flag set.
> 
> If the block group is SYSTEM or REMAP btrfs_relocate_block_group()
> proceeds as it does already, as bootstrapping issues mean that these
> block groups have to be processed the existing way.
> 
> Otherwise we walk the free-space tree for the block group in question,
> recording any holes. These get converted into identity remaps and placed
> in the remap tree, and the block group's REMAPPED flag is set. From now
> on no new allocations are possible within this block group, and any I/O
> to it will be funnelled through btrfs_translate_remap(). We store the
> number of identity remaps in `identity_remap_count`, so that we know
> when we've removed the last one and the block group is fully remapped.
> 
> The change in btrfs_read_roots() is because data relocations no longer
> rely on the data reloc tree as a hidden subvolume in which to do
> snapshots.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/disk-io.c         |  30 +--
>  fs/btrfs/free-space-tree.c |   4 +-
>  fs/btrfs/free-space-tree.h |   5 +-
>  fs/btrfs/relocation.c      | 452 ++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/relocation.h      |   3 +-
>  fs/btrfs/space-info.c      |   9 +-
>  fs/btrfs/volumes.c         |  15 +-
>  7 files changed, 483 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index dac22efd2332..f2a9192293b1 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2268,22 +2268,22 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>  		root->root_key.objectid = BTRFS_REMAP_TREE_OBJECTID;
>  		root->root_key.type = BTRFS_ROOT_ITEM_KEY;
>  		root->root_key.offset = 0;
> -	}
> -
> -	/*
> -	 * This tree can share blocks with some other fs tree during relocation
> -	 * and we need a proper setup by btrfs_get_fs_root
> -	 */
> -	root = btrfs_get_fs_root(tree_root->fs_info,
> -				 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> -	if (IS_ERR(root)) {
> -		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> -			ret = PTR_ERR(root);
> -			goto out;
> -		}
>  	} else {
> -		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> -		fs_info->data_reloc_root = root;
> +		/*
> +		 * This tree can share blocks with some other fs tree during
> +		 * relocation and we need a proper setup by btrfs_get_fs_root
> +		 */
> +		root = btrfs_get_fs_root(tree_root->fs_info,
> +					 BTRFS_DATA_RELOC_TREE_OBJECTID, true);
> +		if (IS_ERR(root)) {
> +			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS)) {
> +				ret = PTR_ERR(root);
> +				goto out;
> +			}
> +		} else {
> +			set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
> +			fs_info->data_reloc_root = root;
> +		}

Why not do this change to the else case for remap tree along with the if
case in the earlier patch (allow mounting filesystems with remap-tree
incompat flag)?

>  	}
>  
>  	location.objectid = BTRFS_QUOTA_TREE_OBJECTID;
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index af51cf784a5b..eb579c17a79f 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -21,8 +21,7 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
>  					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path);
>  
> -static struct btrfs_root *btrfs_free_space_root(
> -				struct btrfs_block_group *block_group)
> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_key key = {
>  		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
> @@ -96,7 +95,6 @@ static int add_new_free_space_info(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> -EXPORT_FOR_TESTS
>  struct btrfs_free_space_info *search_free_space_info(
>  		struct btrfs_trans_handle *trans,
>  		struct btrfs_block_group *block_group,
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index e6c6d6f4f221..1b804544730a 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,12 +35,13 @@ int add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  			   u64 start, u64 size);
>  int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  				u64 start, u64 size);
> -
> -#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
>  search_free_space_info(struct btrfs_trans_handle *trans,
>  		       struct btrfs_block_group *block_group,
>  		       struct btrfs_path *path, int cow);
> +struct btrfs_root *btrfs_free_space_root(struct btrfs_block_group *block_group);
> +
> +#ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  			     struct btrfs_block_group *block_group,
>  			     struct btrfs_path *path, u64 start, u64 size);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 54c3e99c7dab..acf2fefedc96 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3659,7 +3659,7 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
>  		btrfs_btree_balance_dirty(fs_info);
>  	}
>  
> -	if (!err) {
> +	if (!err && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>  		ret = relocate_file_extent_cluster(rc);
>  		if (ret < 0)
>  			err = ret;
> @@ -3906,6 +3906,90 @@ static const char *stage_to_string(enum reloc_stage stage)
>  	return "unknown";
>  }
>  
> +static int add_remap_tree_entries(struct btrfs_trans_handle *trans,
> +				  struct btrfs_path *path,
> +				  struct btrfs_key *entries,
> +				  unsigned int num_entries)
> +{
> +	int ret;
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_item_batch batch;
> +	u32 *data_sizes;
> +	u32 max_items;
> +
> +	max_items = BTRFS_LEAF_DATA_SIZE(trans->fs_info) / sizeof(struct btrfs_item);
> +
> +	data_sizes = kzalloc(sizeof(u32) * min_t(u32, num_entries, max_items),
> +			     GFP_NOFS);
> +	if (!data_sizes)
> +		return -ENOMEM;
> +
> +	while (true) {
> +		batch.keys = entries;
> +		batch.data_sizes = data_sizes;
> +		batch.total_data_size = 0;
> +		batch.nr = min_t(u32, num_entries, max_items);
> +
> +		ret = btrfs_insert_empty_items(trans, fs_info->remap_root, path,
> +					       &batch);
> +		btrfs_release_path(path);
> +
> +		if (num_entries <= max_items)
> +			break;
> +
> +		num_entries -= max_items;
> +		entries += max_items;
> +	}
> +
> +	kfree(data_sizes);
> +
> +	return ret;
> +}
> +
> +struct space_run {
> +	u64 start;
> +	u64 end;
> +};
> +
> +static void parse_bitmap(u64 block_size, const unsigned long *bitmap,
> +			 unsigned long size, u64 address,
> +			 struct space_run *space_runs,
> +			 unsigned int *num_space_runs)
> +{
> +	unsigned long pos, end;
> +	u64 run_start, run_length;
> +
> +	pos = find_first_bit(bitmap, size);
> +
> +	if (pos == size)
> +		return;
> +
> +	while (true) {
> +		end = find_next_zero_bit(bitmap, size, pos);
> +
> +		run_start = address + (pos * block_size);
> +		run_length = (end - pos) * block_size;
> +
> +		if (*num_space_runs != 0 &&
> +		    space_runs[*num_space_runs - 1].end == run_start) {
> +			space_runs[*num_space_runs - 1].end += run_length;
> +		} else {
> +			space_runs[*num_space_runs].start = run_start;
> +			space_runs[*num_space_runs].end = run_start + run_length;
> +
> +			(*num_space_runs)++;
> +		}
> +
> +		if (end == size)
> +			break;
> +
> +		pos = find_next_bit(bitmap, size, end + 1);
> +
> +		if (pos == size)
> +			break;
> +	}
> +}
> +
>  static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  					   struct btrfs_block_group *bg,
>  					   s64 diff)
> @@ -3931,6 +4015,227 @@ static void adjust_block_group_remap_bytes(struct btrfs_trans_handle *trans,
>  		btrfs_inc_delayed_refs_rsv_bg_updates(fs_info);
>  }
>  
> +static int create_remap_tree_entries(struct btrfs_trans_handle *trans,
> +				     struct btrfs_path *path,
> +				     struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_free_space_info *fsi;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_root *space_root;
> +	u32 extent_count;
> +	struct space_run *space_runs = NULL;
> +	unsigned int num_space_runs = 0;
> +	struct btrfs_key *entries = NULL;
> +	unsigned int max_entries, num_entries;
> +	int ret;
> +
> +	mutex_lock(&bg->free_space_lock);
> +
> +	if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &bg->runtime_flags)) {
> +		mutex_unlock(&bg->free_space_lock);
> +
> +		ret = add_block_group_free_space(trans, bg);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&bg->free_space_lock);
> +	}
> +
> +	fsi = search_free_space_info(trans, bg, path, 0);
> +	if (IS_ERR(fsi)) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return PTR_ERR(fsi);
> +	}
> +
> +	extent_count = btrfs_free_space_extent_count(path->nodes[0], fsi);
> +
> +	btrfs_release_path(path);
> +
> +	space_runs = kmalloc(sizeof(*space_runs) * extent_count, GFP_NOFS);
> +	if (!space_runs) {
> +		mutex_unlock(&bg->free_space_lock);
> +		return -ENOMEM;
> +	}
> +
> +	key.objectid = bg->start;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	space_root = btrfs_free_space_root(bg);
> +
> +	ret = btrfs_search_slot(trans, space_root, &key, path, 0, 0);
> +	if (ret < 0) {
> +		mutex_unlock(&bg->free_space_lock);
> +		goto out;
> +	}
> +
> +	ret = 0;
> +
> +	while (true) {
> +		leaf = path->nodes[0];
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +		if (found_key.objectid >= bg->start + bg->length)
> +			break;
> +
> +		if (found_key.type == BTRFS_FREE_SPACE_EXTENT_KEY) {
> +			if (num_space_runs != 0 &&
> +			    space_runs[num_space_runs - 1].end == found_key.objectid) {
> +				space_runs[num_space_runs - 1].end =
> +					found_key.objectid + found_key.offset;
> +			} else {
> +				space_runs[num_space_runs].start = found_key.objectid;
> +				space_runs[num_space_runs].end =
> +					found_key.objectid + found_key.offset;
> +
> +				num_space_runs++;
> +
> +				BUG_ON(num_space_runs > extent_count);
> +			}
> +		} else if (found_key.type == BTRFS_FREE_SPACE_BITMAP_KEY) {
> +			void *bitmap;
> +			unsigned long offset;
> +			u32 data_size;
> +
> +			offset = btrfs_item_ptr_offset(leaf, path->slots[0]);
> +			data_size = btrfs_item_size(leaf, path->slots[0]);
> +
> +			if (data_size != 0) {
> +				bitmap = kmalloc(data_size, GFP_NOFS);

free space tree does this with alloc_bitmap, as far as I can tell.

> +				if (!bitmap) {
> +					mutex_unlock(&bg->free_space_lock);
> +					ret = -ENOMEM;
> +					goto out;
> +				}
> +
> +				read_extent_buffer(leaf, bitmap, offset,
> +						   data_size);
> +
> +				parse_bitmap(fs_info->sectorsize, bitmap,
> +					     data_size * BITS_PER_BYTE,
> +					     found_key.objectid, space_runs,
> +					     &num_space_runs);
> +
> +				BUG_ON(num_space_runs > extent_count);
> +
> +				kfree(bitmap);
> +			}
> +		}
> +
> +		path->slots[0]++;
> +
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(space_root, path);
> +			if (ret != 0) {
> +				if (ret == 1)
> +					ret = 0;
> +				break;
> +			}
> +			leaf = path->nodes[0];
> +		}
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	mutex_unlock(&bg->free_space_lock);
> +
> +	max_entries = extent_count + 2;
> +	entries = kmalloc(sizeof(*entries) * max_entries, GFP_NOFS);
> +	if (!entries) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	num_entries = 0;
> +
> +	if (num_space_runs > 0 && space_runs[0].start > bg->start) {
> +		entries[num_entries].objectid = bg->start;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset = space_runs[0].start - bg->start;
> +		num_entries++;
> +	}
> +
> +	for (unsigned int i = 1; i < num_space_runs; i++) {
> +		entries[num_entries].objectid = space_runs[i - 1].end;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset =
> +			space_runs[i].start - space_runs[i - 1].end;
> +		num_entries++;
> +	}
> +
> +	if (num_space_runs == 0) {
> +		entries[num_entries].objectid = bg->start;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset = bg->length;
> +		num_entries++;
> +	} else if (space_runs[num_space_runs - 1].end < bg->start + bg->length) {
> +		entries[num_entries].objectid = space_runs[num_space_runs - 1].end;
> +		entries[num_entries].type = BTRFS_IDENTITY_REMAP_KEY;
> +		entries[num_entries].offset =
> +			bg->start + bg->length - space_runs[num_space_runs - 1].end;
> +		num_entries++;
> +	}
> +
> +	if (num_entries == 0)
> +		goto out;
> +
> +	bg->identity_remap_count = num_entries;
> +
> +	ret = add_remap_tree_entries(trans, path, entries, num_entries);
> +
> +out:
> +	kfree(entries);
> +	kfree(space_runs);
> +
> +	return ret;
> +}
> +
> +static int mark_bg_remapped(struct btrfs_trans_handle *trans,
> +			    struct btrfs_path *path,
> +			    struct btrfs_block_group *bg)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	unsigned long bi;
> +	struct extent_buffer *leaf;
> +	struct btrfs_block_group_item_v2 bgi;
> +	struct btrfs_key key;
> +	int ret;
> +

Do the changes to the in memory bg flags / commit_identity_remap_count
need any locking? What happens if we see the flag set but don't yet see
the identity remap count set from some other context?

> +	bg->flags |= BTRFS_BLOCK_GROUP_REMAPPED;
> +
> +	key.objectid = bg->start;
> +	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
> +	key.offset = bg->length;
> +
> +	ret = btrfs_search_slot(trans, fs_info->block_group_root, &key,
> +				path, 0, 1);
> +	if (ret) {
> +		if (ret > 0)
> +			ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	leaf = path->nodes[0];
> +	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
> +	read_extent_buffer(leaf, &bgi, bi, sizeof(bgi));

ASSERT the incompat flag?

> +	btrfs_set_stack_block_group_v2_flags(&bgi, bg->flags);
> +	btrfs_set_stack_block_group_v2_identity_remap_count(&bgi,
> +						bg->identity_remap_count);
> +	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
> +
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	bg->commit_identity_remap_count = bg->identity_remap_count;
> +
> +	ret = 0;
> +out:
> +	btrfs_release_path(path);
> +	return ret;
> +}
> +
>  static int remove_chunk_stripes(struct btrfs_trans_handle *trans,
>  				struct btrfs_chunk_map *chunk,
>  				struct btrfs_path *path)
> @@ -4050,6 +4355,55 @@ static int adjust_identity_remap_count(struct btrfs_trans_handle *trans,
>  	return ret;
>  }
>  
> +static int mark_chunk_remapped(struct btrfs_trans_handle *trans,
> +			       struct btrfs_path *path, uint64_t start)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_chunk_map *chunk;
> +	struct btrfs_key key;
> +	u64 type;
> +	int ret;
> +	struct extent_buffer *leaf;
> +	struct btrfs_chunk *c;
> +
> +	read_lock(&fs_info->mapping_tree_lock);
> +
> +	chunk = btrfs_find_chunk_map_nolock(fs_info, start, 1);
> +	if (!chunk) {
> +		read_unlock(&fs_info->mapping_tree_lock);
> +		return -ENOENT;
> +	}
> +
> +	chunk->type |= BTRFS_BLOCK_GROUP_REMAPPED;
> +	type = chunk->type;
> +
> +	read_unlock(&fs_info->mapping_tree_lock);
> +
> +	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
> +	key.type = BTRFS_CHUNK_ITEM_KEY;
> +	key.offset = start;
> +
> +	ret = btrfs_search_slot(trans, fs_info->chunk_root, &key, path,
> +				0, 1);
> +	if (ret == 1) {
> +		ret = -ENOENT;
> +		goto end;
> +	} else if (ret < 0)
> +		goto end;
> +
> +	leaf = path->nodes[0];
> +
> +	c = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_chunk);
> +	btrfs_set_chunk_type(leaf, c, type);
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +
> +	ret = 0;
> +end:
> +	btrfs_free_chunk_map(chunk);
> +	btrfs_release_path(path);
> +	return ret;
> +}
> +
>  int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  			  u64 *length, bool nolock)
>  {
> @@ -4109,16 +4463,78 @@ int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
>  	return 0;
>  }
>  
> +static int start_block_group_remapping(struct btrfs_fs_info *fs_info,
> +				       struct btrfs_path *path,
> +				       struct btrfs_block_group *bg)
> +{
> +	struct btrfs_trans_handle *trans;
> +	int ret, ret2;
> +
> +	ret = btrfs_cache_block_group(bg, true);
> +	if (ret)
> +		return ret;
> +
> +	trans = btrfs_start_transaction(fs_info->remap_root, 0);
> +	if (IS_ERR(trans))
> +		return PTR_ERR(trans);
> +
> +	/* We need to run delayed refs, to make sure FST is up to date. */
> +	ret = btrfs_run_delayed_refs(trans, U64_MAX);
> +	if (ret) {
> +		btrfs_end_transaction(trans);
> +		return ret;
> +	}
> +
> +	mutex_lock(&fs_info->remap_mutex);
> +
> +	if (bg->flags & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		ret = 0;
> +		goto end;
> +	}
> +
> +	ret = create_remap_tree_entries(trans, path, bg);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto end;
> +	}
> +
> +	ret = mark_bg_remapped(trans, path, bg);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto end;
> +	}
> +
> +	ret = mark_chunk_remapped(trans, path, bg->start);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		goto end;
> +	}
> +
> +	ret = remove_block_group_free_space(trans, bg);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
> +
> +end:
> +	mutex_unlock(&fs_info->remap_mutex);
> +
> +	ret2 = btrfs_end_transaction(trans);
> +	if (!ret)
> +		ret = ret2;
> +
> +	return ret;
> +}
> +
>  /*
>   * function to relocate all extents in a block group.
>   */
> -int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
> +int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
> +			       bool *using_remap_tree)
>  {
>  	struct btrfs_block_group *bg;
>  	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, group_start);
>  	struct reloc_control *rc;
>  	struct inode *inode;
> -	struct btrfs_path *path;
> +	struct btrfs_path *path = NULL;
>  	int ret;
>  	int rw = 0;
>  	int err = 0;
> @@ -4185,7 +4601,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	}
>  
>  	inode = lookup_free_space_inode(rc->block_group, path);
> -	btrfs_free_path(path);
> +	btrfs_release_path(path);
>  
>  	if (!IS_ERR(inode))
>  		ret = delete_block_group_cache(rc->block_group, inode, 0);
> @@ -4197,11 +4613,17 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  		goto out;
>  	}
>  
> -	rc->data_inode = create_reloc_inode(rc->block_group);
> -	if (IS_ERR(rc->data_inode)) {
> -		err = PTR_ERR(rc->data_inode);
> -		rc->data_inode = NULL;
> -		goto out;
> +	*using_remap_tree = btrfs_fs_incompat(fs_info, REMAP_TREE) &&
> +		!(bg->flags & BTRFS_BLOCK_GROUP_SYSTEM) &&
> +		!(bg->flags & BTRFS_BLOCK_GROUP_REMAP);
> +
> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		rc->data_inode = create_reloc_inode(rc->block_group);
> +		if (IS_ERR(rc->data_inode)) {
> +			err = PTR_ERR(rc->data_inode);
> +			rc->data_inode = NULL;
> +			goto out;
> +		}
>  	}
>  
>  	describe_relocation(rc->block_group);
> @@ -4213,6 +4635,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  	ret = btrfs_zone_finish(rc->block_group);
>  	WARN_ON(ret && ret != -EAGAIN);
>  
> +	if (*using_remap_tree) {
> +		err = start_block_group_remapping(fs_info, path, bg);
> +
> +		goto out;
> +	}
> +
>  	while (1) {
>  		enum reloc_stage finishes_stage;
>  
> @@ -4258,7 +4686,9 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>  out:
>  	if (err && rw)
>  		btrfs_dec_block_group_ro(rc->block_group);
> -	iput(rc->data_inode);
> +	if (!btrfs_fs_incompat(fs_info, REMAP_TREE))
> +		iput(rc->data_inode);
> +	btrfs_free_path(path);
>  out_put_bg:
>  	btrfs_put_block_group(bg);
>  	reloc_chunk_end(fs_info);
> @@ -4452,7 +4882,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  
>  	btrfs_free_path(path);
>  
> -	if (ret == 0) {
> +	if (ret == 0 && !btrfs_fs_incompat(fs_info, REMAP_TREE)) {
>  		/* cleanup orphan inode in data relocation tree */
>  		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
>  		ASSERT(fs_root);
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index 0021f812b12c..49bd48296ddb 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -12,7 +12,8 @@ struct btrfs_trans_handle;
>  struct btrfs_ordered_extent;
>  struct btrfs_pending_snapshot;
>  
> -int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start);
> +int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
> +			       bool *using_remap_tree);
>  int btrfs_init_reloc_root(struct btrfs_trans_handle *trans, struct btrfs_root *root);
>  int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
>  			    struct btrfs_root *root);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6471861c4b25..ab4a70c420de 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -375,8 +375,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>  	factor = btrfs_bg_type_to_factor(block_group->flags);
>  
>  	spin_lock(&space_info->lock);
> -	space_info->total_bytes += block_group->length;
> -	space_info->disk_total += block_group->length * factor;
> +
> +	if (!(block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED) ||
> +	    block_group->identity_remap_count != 0) {
> +		space_info->total_bytes += block_group->length;
> +		space_info->disk_total += block_group->length * factor;
> +	}
> +
>  	space_info->bytes_used += block_group->used;
>  	space_info->disk_used += block_group->used * factor;
>  	space_info->bytes_readonly += block_group->bytes_super;
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6c0a67da92f1..771415139dc0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3425,6 +3425,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	struct btrfs_block_group *block_group;
>  	u64 length;
>  	int ret;
> +	bool using_remap_tree;
>  
>  	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>  		btrfs_err(fs_info,
> @@ -3448,7 +3449,8 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  
>  	/* step one, relocate all the extents inside this chunk */
>  	btrfs_scrub_pause(fs_info);
> -	ret = btrfs_relocate_block_group(fs_info, chunk_offset);
> +	ret = btrfs_relocate_block_group(fs_info, chunk_offset,
> +					 &using_remap_tree);
>  	btrfs_scrub_continue(fs_info);
>  	if (ret) {
>  		/*
> @@ -3467,6 +3469,9 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset)
>  	length = block_group->length;
>  	btrfs_put_block_group(block_group);
>  
> +	if (using_remap_tree)
> +		return 0;
> +
>  	/*
>  	 * On a zoned file system, discard the whole block group, this will
>  	 * trigger a REQ_OP_ZONE_RESET operation on the device zone. If
> @@ -4165,6 +4170,14 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>  		chunk = btrfs_item_ptr(leaf, slot, struct btrfs_chunk);
>  		chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> +		/* Check if chunk has already been fully relocated. */
> +		if (chunk_type & BTRFS_BLOCK_GROUP_REMAPPED &&
> +		    btrfs_chunk_num_stripes(leaf, chunk) == 0) {
> +			btrfs_release_path(path);
> +			mutex_unlock(&fs_info->reclaim_bgs_lock);
> +			goto loop;
> +		}
> +
>  		if (!counting) {
>  			spin_lock(&fs_info->balance_lock);
>  			bctl->stat.considered++;
> -- 
> 2.49.0
> 

