Return-Path: <linux-btrfs+bounces-13636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1720AA78B0
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 19:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D3E17AA57
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 May 2025 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057225D1E2;
	Fri,  2 May 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JbgGQqfr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWYhpKlb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3DD1A3174;
	Fri,  2 May 2025 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207273; cv=none; b=bPs9WE6TIema3j2QI5DT9WWoQ2Ke553aidn0f8W2kw9sGRdC29nLtR8sAKqK+i31KA5AX041c6lvqVAwEzybY1+x+CmsyMhDwMljKV3b54sB8W8xZsi2E0nd5621NULm0Kn71qSGus661eGv4LkmM90yZX42Lxb/daFDBLpMYNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207273; c=relaxed/simple;
	bh=wJ9RbnjiIA196BC3HKC4jldgn4wsqyNiBCQg2V5f2jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+h8f94f9WAZo46ACytJnK1xJrI7PCZPoUN2Q33Pjq829sKEerQczui+caC73tux1ndxxh8O/t4au4ICsV72kD2bYGLP4puSldjW7j4Ggq0+8bgWmP5yqn3R6EVlmJKnyzSXM1pEF1z+oJoAKtBjpGsN6p9hZbnRcu4cGQf3aSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JbgGQqfr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mWYhpKlb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A8C2114008D;
	Fri,  2 May 2025 13:34:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 May 2025 13:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1746207269; x=1746293669; bh=yJTZtoqWwY
	L1+GcCvwFIOKRquekdsM13WaxtnSKlQC4=; b=JbgGQqfrhZdkWwK8v72Wx51jE/
	oQEY2RBX/7Y0tnL2JAuZMAZvJ7/eiLC0JKp66H75gpC6rnk48oZuKr+U5CkR4heA
	F9SNqbHVggmm8fmFuuSazkexVKja4bI6wvurPtVPuAENQ1eBdJrQsmnRTUbANlQE
	uhSORe3HQvsQEKkX0pTjjq28Rmyoyqto2uB4PcTo5X5KejZpgibKAKOx2LCPjD38
	OdzXsG2SCoX7Dt2ai82fprjzR8pJbPDNi3dyu432KO1fNww5LK1DLsEpHv89trKN
	Q5b/jyMUWdxnUiPFVKhUrSS+7cZ5hXegBNV6vCsMEgYirNUaPWfgD57KGl5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746207269; x=1746293669; bh=yJTZtoqWwYL1+GcCvwFIOKRquekdsM13Wax
	tnSKlQC4=; b=mWYhpKlbT9d3hjXhnytrp8/eBbOU+HNMSo8X9CEVdjiHIvFDVPv
	mZe5IS9wn/IJgttH6R/a9cd1sybb2Hp9XHo3sLKNZrKCbGkKlGdyHIpo4zXhbGFb
	3sA/L5Syj2mtv0rMLEphboTFbP3oIwGjsYpIXhupIUGM137+/cafDLFwRsxW76+C
	YrVfzfGfFlzTdUgQK9pZ71IS2IP4RGEfRtmqI0rVIqlnDJfXwIs5ugmOAVOzP5B3
	PKgQFdks5N6AAVhEkHcet0lcoFC9UJxFkKdsqSfXxcEiKLhKrwsUJnAaZhg4TgfL
	rIMd12Nijt91FqhoMExIKkwWwVPFiiD1KSg==
X-ME-Sender: <xms:JQIVaEHBMr9Vr9nz7WOgk5MQ4Bq0Vvu-Vxf55A3Xt4GfS9s1V8IGPQ>
    <xme:JQIVaNXKHtBy2oJH3rqoqIhj3aq7l_XkEx8Nj57w1N6XK74YC63ZP3Cr8ytSrneWD
    vks_nuTv1ea1jKSE2s>
X-ME-Received: <xmr:JQIVaOISFPEK1QKBa4mzrAMgzsYYi3Efd-dZ1_v-wuDp93bCGLNpBxeVBT9saK-CY6c3rzImq2Y-oGPevQGyJ0u94sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeeiteffhedtieetfeeffeelhedtheevheeviefftdethffg
    gfeikeeuiefggedvjeenucffohhmrghinhepsghipghithgvrhdrsghinecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdr
    ihhopdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hnvggvlhigsehsuhhsvgdrtghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdr
    tghomhdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopehjohhsvghfse
    htohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:JQIVaGGCvlcA4_YyyGWxC6cfLoRLFzsAuIDMlSsUjiJhOzJ5H_U9ug>
    <xmx:JQIVaKVt8BDhYKGve9iS9nsEm-09TjSaZ407QXwmv6mOkYw0x6NjIA>
    <xmx:JQIVaJOJ4-PDd2fvcEAkfTD5eHoOCGYuYMd3R0C0KMgucuY-fRCA3g>
    <xmx:JQIVaB03nTVMF_0AK-ncaZQjKXUhCKN7ijawj7msvhejpRPnbpPbVg>
    <xmx:JQIVaEvnECSgpcNZIAqzevBxrWHKyJfKsOG9v589gBPBdFJ0ZYKmHx0b>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 13:34:28 -0400 (EDT)
Date: Fri, 2 May 2025 10:35:20 -0700
From: Boris Burkov <boris@bur.io>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: remove extent buffer's redundant `len`
 member field
Message-ID: <20250502173520.GB1179844@zen.localdomain>
References: <20250429151800.649010-1-neelx@suse.com>
 <20250502133725.1210587-1-neelx@suse.com>
 <20250502133725.1210587-2-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502133725.1210587-2-neelx@suse.com>

On Fri, May 02, 2025 at 03:37:22PM +0200, Daniel Vacek wrote:
> Even super block nowadays uses nodesize for eb->len. This is since commits
> 
> 551561c34663 ("btrfs: don't pass nodesize to __alloc_extent_buffer()")
> da17066c4047 ("btrfs: pull node/sector/stripe sizes out of root and into fs_info")
> ce3e69847e3e ("btrfs: sink parameter len to alloc_extent_buffer")
> a83fffb75d09 ("btrfs: sink blocksize parameter to btrfs_find_create_tree_block")
> 
> With these the eb->len is not really useful anymore. Let's use the nodesize
> directly where applicable.

Transformations look good to me. I think it might be a little neater to
add a static inline helper that does eb->fs_info->nodesize to make that
a bit easier to type (kinda like btrfs_root_id()) but I'm happy with
this too.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> 
> v2 changes:
>  - rebased to this week's for-next
>  - use plain eb->fs_info->nodesize instead of a helper function as suggested
>    by Filipe and Wenruo
>  - constify local nodesize variables as suggested by Wenruo
> 
> ---
>  fs/btrfs/accessors.c             |  4 +--
>  fs/btrfs/disk-io.c               | 11 +++---
>  fs/btrfs/extent-tree.c           | 28 ++++++++-------
>  fs/btrfs/extent_io.c             | 59 ++++++++++++++------------------
>  fs/btrfs/extent_io.h             |  6 ++--
>  fs/btrfs/ioctl.c                 |  2 +-
>  fs/btrfs/relocation.c            |  2 +-
>  fs/btrfs/subpage.c               | 12 ++++---
>  fs/btrfs/tests/extent-io-tests.c | 12 +++----
>  fs/btrfs/zoned.c                 |  2 +-
>  10 files changed, 69 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
> index e3716516ca387..6839251b09a18 100644
> --- a/fs/btrfs/accessors.c
> +++ b/fs/btrfs/accessors.c
> @@ -14,10 +14,10 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
>  {
>  	const unsigned long member_offset = (unsigned long)ptr + off;
>  
> -	if (unlikely(member_offset + size > eb->len)) {
> +	if (unlikely(member_offset + size > eb->fs_info->nodesize)) {
>  		btrfs_warn(eb->fs_info,
>  		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
> -			(member_offset > eb->len ? "start" : "end"),
> +			(member_offset > eb->fs_info->nodesize ? "start" : "end"),
>  			(unsigned long)ptr, eb->start, member_offset, size);
>  		return false;
>  	}
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 308e8f384ecbb..2bf4df92474cb 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -190,7 +190,7 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
>  	for (int i = 0; i < num_extent_folios(eb); i++) {
>  		struct folio *folio = eb->folios[i];
>  		u64 start = max_t(u64, eb->start, folio_pos(folio));
> -		u64 end = min_t(u64, eb->start + eb->len,
> +		u64 end = min_t(u64, eb->start + fs_info->nodesize,
>  				folio_pos(folio) + eb->folio_size);
>  		u32 len = end - start;
>  		phys_addr_t paddr = PFN_PHYS(folio_pfn(folio)) +
> @@ -230,7 +230,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb,
>  			break;
>  
>  		num_copies = btrfs_num_copies(fs_info,
> -					      eb->start, eb->len);
> +					      eb->start, fs_info->nodesize);
>  		if (num_copies == 1)
>  			break;
>  
> @@ -260,6 +260,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
>  {
>  	struct extent_buffer *eb = bbio->private;
>  	struct btrfs_fs_info *fs_info = eb->fs_info;
> +	const u32 nodesize = fs_info->nodesize;
>  	u64 found_start = btrfs_header_bytenr(eb);
>  	u64 last_trans;
>  	u8 result[BTRFS_CSUM_SIZE];
> @@ -268,7 +269,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
>  	/* Btree blocks are always contiguous on disk. */
>  	if (WARN_ON_ONCE(bbio->file_offset != eb->start))
>  		return -EIO;
> -	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != eb->len))
> +	if (WARN_ON_ONCE(bbio->bio.bi_iter.bi_size != fs_info->nodesize))

You could also use the nodesize local variable here.

>  		return -EIO;
>  
>  	/*
> @@ -277,7 +278,7 @@ int btree_csum_one_bio(struct btrfs_bio *bbio)
>  	 * ordering of I/O without unnecessarily writing out data.
>  	 */
>  	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
> -		memzero_extent_buffer(eb, 0, eb->len);
> +		memzero_extent_buffer(eb, 0, nodesize);
>  		return 0;
>  	}
>  
> @@ -881,7 +882,7 @@ struct btrfs_root *btrfs_create_tree(struct btrfs_trans_handle *trans,
>  	btrfs_set_root_generation(&root->root_item, trans->transid);
>  	btrfs_set_root_level(&root->root_item, 0);
>  	btrfs_set_root_refs(&root->root_item, 1);
> -	btrfs_set_root_used(&root->root_item, leaf->len);
> +	btrfs_set_root_used(&root->root_item, fs_info->nodesize);
>  	btrfs_set_root_last_snapshot(&root->root_item, 0);
>  	btrfs_set_root_dirid(&root->root_item, 0);
>  	if (is_fstree(objectid))
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 527bffab75e5c..7b90ed007ef2e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2186,7 +2186,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
>  	extent_op->update_flags = true;
>  	extent_op->update_key = false;
>  
> -	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len,
> +	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->fs_info->nodesize,
>  					  btrfs_header_level(eb), extent_op);
>  	if (ret)
>  		btrfs_free_delayed_extent_op(extent_op);
> @@ -2635,10 +2635,10 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>  	if (ret)
>  		goto out;
>  
> -	pin_down_extent(trans, cache, eb->start, eb->len, 0);
> +	pin_down_extent(trans, cache, eb->start, eb->fs_info->nodesize, 0);
>  
>  	/* remove us from the free space cache (if we're there at all) */
> -	ret = btrfs_remove_free_space(cache, eb->start, eb->len);
> +	ret = btrfs_remove_free_space(cache, eb->start, eb->fs_info->nodesize);
>  out:
>  	btrfs_put_block_group(cache);
>  	return ret;
> @@ -3434,13 +3434,14 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	struct btrfs_block_group *bg;
> +	const u32 nodesize = fs_info->nodesize;
>  	int ret;
>  
>  	if (root_id != BTRFS_TREE_LOG_OBJECTID) {
>  		struct btrfs_ref generic_ref = {
>  			.action = BTRFS_DROP_DELAYED_REF,
>  			.bytenr = buf->start,
> -			.num_bytes = buf->len,
> +			.num_bytes = nodesize,
>  			.parent = parent,
>  			.owning_root = btrfs_header_owner(buf),
>  			.ref_root = root_id,
> @@ -3476,7 +3477,7 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  	bg = btrfs_lookup_block_group(fs_info, buf->start);
>  
>  	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> -		pin_down_extent(trans, bg, buf->start, buf->len, 1);
> +		pin_down_extent(trans, bg, buf->start, nodesize, 1);
>  		btrfs_put_block_group(bg);
>  		goto out;
>  	}
> @@ -3500,17 +3501,17 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
>  
>  	if (test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags)
>  		     || btrfs_is_zoned(fs_info)) {
> -		pin_down_extent(trans, bg, buf->start, buf->len, 1);
> +		pin_down_extent(trans, bg, buf->start, nodesize, 1);
>  		btrfs_put_block_group(bg);
>  		goto out;
>  	}
>  
>  	WARN_ON(test_bit(EXTENT_BUFFER_DIRTY, &buf->bflags));
>  
> -	btrfs_add_free_space(bg, buf->start, buf->len);
> -	btrfs_free_reserved_bytes(bg, buf->len, 0);
> +	btrfs_add_free_space(bg, buf->start, nodesize);
> +	btrfs_free_reserved_bytes(bg, nodesize, 0);
>  	btrfs_put_block_group(bg);
> -	trace_btrfs_reserved_extent_free(fs_info, buf->start, buf->len);
> +	trace_btrfs_reserved_extent_free(fs_info, buf->start, nodesize);
>  
>  out:
>  	return 0;
> @@ -4752,7 +4753,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
>  		return -ENOSPC;
>  	}
>  
> -	ret = pin_down_extent(trans, cache, eb->start, eb->len, 1);
> +	ret = pin_down_extent(trans, cache, eb->start, eb->fs_info->nodesize, 1);
>  	btrfs_put_block_group(cache);
>  	return ret;
>  }
> @@ -5034,6 +5035,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	struct extent_buffer *buf;
>  	u64 lockdep_owner = owner;
> +	const u32 nodesize = fs_info->nodesize;
>  
>  	buf = btrfs_find_create_tree_block(fs_info, bytenr, owner, level);
>  	if (IS_ERR(buf))
> @@ -5091,16 +5093,16 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  		 */
>  		if (buf->log_index == 0)
>  			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
> -					     buf->start + buf->len - 1,
> +					     buf->start + nodesize - 1,
>  					     EXTENT_DIRTY, NULL);
>  		else
>  			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
> -					     buf->start + buf->len - 1,
> +					     buf->start + nodesize - 1,
>  					     EXTENT_NEW, NULL);
>  	} else {
>  		buf->log_index = -1;
>  		btrfs_set_extent_bit(&trans->transaction->dirty_pages, buf->start,
> -				     buf->start + buf->len - 1, EXTENT_DIRTY, NULL);
> +				     buf->start + nodesize - 1, EXTENT_DIRTY, NULL);
>  	}
>  	/* this returns a buffer locked for blocking */
>  	return buf;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d889d8fcf1d27..a34644bb4b146 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -76,8 +76,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
>  		eb = list_first_entry(&fs_info->allocated_ebs,
>  				      struct extent_buffer, leak_list);
>  		pr_err(
> -	"BTRFS: buffer leak start %llu len %u refs %d bflags %lu owner %llu\n",
> -		       eb->start, eb->len, atomic_read(&eb->refs), eb->bflags,
> +	"BTRFS: buffer leak start %llu refs %d bflags %lu owner %llu\n",
> +		       eb->start, atomic_read(&eb->refs), eb->bflags,
>  		       btrfs_header_owner(eb));
>  		list_del(&eb->leak_list);
>  		WARN_ON_ONCE(1);
> @@ -1788,8 +1788,8 @@ static noinline_for_stack bool lock_extent_buffer_for_io(struct extent_buffer *e
>  
>  		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN);
>  		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> -					 -eb->len,
> -					 fs_info->dirty_metadata_batch);
> +					 -fs_info->nodesize,
> +					  fs_info->dirty_metadata_batch);
>  		ret = true;
>  	} else {
>  		spin_unlock(&eb->refs_lock);
> @@ -1986,7 +1986,7 @@ static unsigned int buffer_tree_get_ebs_tag(struct btrfs_fs_info *fs_info,
>  	rcu_read_lock();
>  	while ((eb = find_get_eb(&xas, end, tag)) != NULL) {
>  		if (!eb_batch_add(batch, eb)) {
> -			*start = (eb->start + eb->len) >> fs_info->sectorsize_bits;
> +			*start = (eb->start + fs_info->nodesize) >> fs_info->sectorsize_bits;
>  			goto out;
>  		}
>  	}
> @@ -2050,7 +2050,7 @@ static void prepare_eb_write(struct extent_buffer *eb)
>  	nritems = btrfs_header_nritems(eb);
>  	if (btrfs_header_level(eb) > 0) {
>  		end = btrfs_node_key_ptr_offset(eb, nritems);
> -		memzero_extent_buffer(eb, end, eb->len - end);
> +		memzero_extent_buffer(eb, end, eb->fs_info->nodesize - end);
>  	} else {
>  		/*
>  		 * Leaf:
> @@ -2086,7 +2086,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
>  		struct folio *folio = eb->folios[i];
>  		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
>  		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
> -				      eb->start + eb->len) - range_start;
> +				      eb->start + fs_info->nodesize) - range_start;
>  
>  		folio_lock(folio);
>  		btrfs_meta_folio_clear_dirty(folio, eb);
> @@ -2200,7 +2200,7 @@ int btree_write_cache_pages(struct address_space *mapping,
>  			if (ctx.zoned_bg) {
>  				/* Mark the last eb in the block group. */
>  				btrfs_schedule_zone_finish_bg(ctx.zoned_bg, eb);
> -				ctx.zoned_bg->meta_write_pointer += eb->len;
> +				ctx.zoned_bg->meta_write_pointer += fs_info->nodesize;
>  			}
>  			write_one_eb(eb, wbc);
>  		}
> @@ -2836,7 +2836,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>  
>  	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
>  	eb->start = start;
> -	eb->len = fs_info->nodesize;
>  	eb->fs_info = fs_info;
>  	init_rwsem(&eb->lock);
>  
> @@ -2845,8 +2844,6 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
>  	spin_lock_init(&eb->refs_lock);
>  	atomic_set(&eb->refs, 1);
>  
> -	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
> -
>  	return eb;
>  }
>  
> @@ -3558,7 +3555,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
>  		return;
>  
>  	buffer_tree_clear_mark(eb, PAGECACHE_TAG_DIRTY);
> -	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
> +	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -fs_info->nodesize,
>  				 fs_info->dirty_metadata_batch);
>  
>  	for (int i = 0; i < num_extent_folios(eb); i++) {
> @@ -3589,7 +3586,8 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
>  	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
>  
>  	if (!was_dirty) {
> -		bool subpage = btrfs_meta_is_subpage(eb->fs_info);
> +		struct btrfs_fs_info *fs_info = eb->fs_info;
> +		bool subpage = btrfs_meta_is_subpage(fs_info);
>  
>  		/*
>  		 * For subpage case, we can have other extent buffers in the
> @@ -3609,9 +3607,9 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
>  		buffer_tree_set_mark(eb, PAGECACHE_TAG_DIRTY);
>  		if (subpage)
>  			folio_unlock(eb->folios[0]);
> -		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
> -					 eb->len,
> -					 eb->fs_info->dirty_metadata_batch);
> +		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
> +					  fs_info->nodesize,
> +					  fs_info->dirty_metadata_batch);
>  	}
>  #ifdef CONFIG_BTRFS_DEBUG
>  	for (int i = 0; i < num_extent_folios(eb); i++)
> @@ -3723,7 +3721,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
>  		struct folio *folio = eb->folios[i];
>  		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
>  		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
> -				      eb->start + eb->len) - range_start;
> +				      eb->start + eb->fs_info->nodesize) - range_start;
>  
>  		bio_add_folio_nofail(&bbio->bio, folio, range_len,
>  				     offset_in_folio(folio, range_start));
> @@ -3751,8 +3749,8 @@ static bool report_eb_range(const struct extent_buffer *eb, unsigned long start,
>  			    unsigned long len)
>  {
>  	btrfs_warn(eb->fs_info,
> -		"access to eb bytenr %llu len %u out of range start %lu len %lu",
> -		eb->start, eb->len, start, len);
> +		"access to eb bytenr %llu out of range start %lu len %lu",
> +		eb->start, start, len);

I think including the nodesize (or eb end..) would sill be useful.

>  	DEBUG_WARN();
>  
>  	return true;
> @@ -3770,8 +3768,8 @@ static inline int check_eb_range(const struct extent_buffer *eb,
>  {
>  	unsigned long offset;
>  
> -	/* start, start + len should not go beyond eb->len nor overflow */
> -	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->len))
> +	/* start, start + len should not go beyond nodesize nor overflow */
> +	if (unlikely(check_add_overflow(start, len, &offset) || offset > eb->fs_info->nodesize))
>  		return report_eb_range(eb, start, len);
>  
>  	return false;
> @@ -3827,8 +3825,8 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
>  	unsigned long i = get_eb_folio_index(eb, start);
>  	int ret = 0;
>  
> -	WARN_ON(start > eb->len);
> -	WARN_ON(start + len > eb->start + eb->len);
> +	WARN_ON(start > eb->fs_info->nodesize);
> +	WARN_ON(start + len > eb->start + eb->fs_info->nodesize);
>  
>  	if (eb->addr) {
>  		if (copy_to_user_nofault(dstv, eb->addr + start, len))
> @@ -3919,8 +3917,8 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
>  		folio = eb->folios[0];
>  		ASSERT(i == 0);
>  		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
> -							 eb->start, eb->len)))
> -			btrfs_subpage_dump_bitmap(fs_info, folio, eb->start, eb->len);
> +							 eb->start, fs_info->nodesize)))
> +			btrfs_subpage_dump_bitmap(fs_info, folio, eb->start, fs_info->nodesize);
>  	} else {
>  		WARN_ON(!folio_test_uptodate(folio));
>  	}
> @@ -4013,12 +4011,10 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
>  	const int unit_size = src->folio_size;
>  	unsigned long cur = 0;
>  
> -	ASSERT(dst->len == src->len);
> -
> -	while (cur < src->len) {
> +	while (cur < src->fs_info->nodesize) {
>  		unsigned long index = get_eb_folio_index(src, cur);
>  		unsigned long offset = get_eb_offset_in_folio(src, cur);
> -		unsigned long cur_len = min(src->len, unit_size - offset);
> +		unsigned long cur_len = min(src->fs_info->nodesize, unit_size - offset);
>  		void *addr = folio_address(src->folios[index]) + offset;
>  
>  		write_extent_buffer(dst, addr, cur, cur_len);
> @@ -4033,7 +4029,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
>  			unsigned long len)
>  {
>  	const int unit_size = dst->folio_size;
> -	u64 dst_len = dst->len;
>  	size_t cur;
>  	size_t offset;
>  	char *kaddr;
> @@ -4043,8 +4038,6 @@ void copy_extent_buffer(const struct extent_buffer *dst,
>  	    check_eb_range(src, src_offset, len))
>  		return;
>  
> -	WARN_ON(src->len != dst_len);
> -
>  	offset = get_eb_offset_in_folio(dst, dst_offset);
>  
>  	while (len > 0) {
> @@ -4315,7 +4308,7 @@ static int try_release_subpage_extent_buffer(struct folio *folio)
>  			xa_unlock_irq(&fs_info->buffer_tree);
>  			break;
>  		}
> -		cur = eb->start + eb->len;
> +		cur = eb->start + fs_info->nodesize;
>  
>  		/*
>  		 * The same as try_release_extent_buffer(), to ensure the eb
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index e36e8d6a00bc5..7a8451c11630a 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -16,6 +16,7 @@
>  #include "messages.h"
>  #include "ulist.h"
>  #include "misc.h"
> +#include "fs.h"
>  
>  struct page;
>  struct file;
> @@ -86,7 +87,6 @@ void __cold extent_buffer_free_cachep(void);
>  #define INLINE_EXTENT_BUFFER_PAGES     (BTRFS_MAX_METADATA_BLOCKSIZE / PAGE_SIZE)
>  struct extent_buffer {
>  	u64 start;
> -	u32 len;
>  	u32 folio_size;
>  	unsigned long bflags;
>  	struct btrfs_fs_info *fs_info;
> @@ -274,12 +274,12 @@ static inline int __pure num_extent_pages(const struct extent_buffer *eb)
>  {
>  	/*
>  	 * For sectorsize == PAGE_SIZE case, since nodesize is always aligned to
> -	 * sectorsize, it's just eb->len >> PAGE_SHIFT.
> +	 * sectorsize, it's just nodesize >> PAGE_SHIFT.
>  	 *
>  	 * For sectorsize < PAGE_SIZE case, we could have nodesize < PAGE_SIZE,
>  	 * thus have to ensure we get at least one page.
>  	 */
> -	return (eb->len >> PAGE_SHIFT) ?: 1;
> +	return (eb->fs_info->nodesize >> PAGE_SHIFT) ?: 1;
>  }
>  
>  /*
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index a498fe524c907..d06008ff63de9 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -598,7 +598,7 @@ static noinline int create_subvol(struct mnt_idmap *idmap,
>  	btrfs_set_root_generation(root_item, trans->transid);
>  	btrfs_set_root_level(root_item, 0);
>  	btrfs_set_root_refs(root_item, 1);
> -	btrfs_set_root_used(root_item, leaf->len);
> +	btrfs_set_root_used(root_item, fs_info->nodesize);
>  	btrfs_set_root_last_snapshot(root_item, 0);
>  
>  	btrfs_set_root_generation_v2(root_item,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 0a6325ebf266f..59cdc6e1ec0e8 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4353,7 +4353,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
>  			mark_block_processed(rc, node);
>  
>  		if (first_cow && level > 0)
> -			rc->nodes_relocated += buf->len;
> +			rc->nodes_relocated += fs_info->nodesize;
>  	}
>  
>  	if (level == 0 && first_cow && rc->stage == UPDATE_DATA_PTRS)
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index d4f0192334936..64c212f76ff12 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -631,7 +631,8 @@ void btrfs_meta_folio_set_##name(struct folio *folio, const struct extent_buffer
>  		folio_set_func(folio);					\
>  		return;							\
>  	}								\
> -	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb->len); \
> +	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start,		\
> +				 eb->fs_info->nodesize);		\
>  }									\
>  void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buffer *eb) \
>  {									\
> @@ -639,13 +640,15 @@ void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buff
>  		folio_clear_func(folio);				\
>  		return;							\
>  	}								\
> -	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb->len); \
> +	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start,	\
> +				   eb->fs_info->nodesize);		\
>  }									\
>  bool btrfs_meta_folio_test_##name(struct folio *folio, const struct extent_buffer *eb) \
>  {									\
>  	if (!btrfs_meta_is_subpage(eb->fs_info))			\
>  		return folio_test_func(folio);				\
> -	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, eb->len); \
> +	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start,	\
> +					 eb->fs_info->nodesize);	\
>  }
>  IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
>  			 folio_test_uptodate);
> @@ -765,7 +768,8 @@ bool btrfs_meta_folio_clear_and_test_dirty(struct folio *folio, const struct ext
>  		return true;
>  	}
>  
> -	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start, eb->len);
> +	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start,
> +						  eb->fs_info->nodesize);
>  	if (last) {
>  		folio_clear_dirty_for_io(folio);
>  		return true;
> diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
> index 00da54f0164c9..697d558808103 100644
> --- a/fs/btrfs/tests/extent-io-tests.c
> +++ b/fs/btrfs/tests/extent-io-tests.c
> @@ -342,7 +342,7 @@ static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
>  {
>  	unsigned long i;
>  
> -	for (i = 0; i < eb->len * BITS_PER_BYTE; i++) {
> +	for (i = 0; i < eb->fs_info->nodesize * BITS_PER_BYTE; i++) {
>  		int bit, bit1;
>  
>  		bit = !!test_bit(i, bitmap);
> @@ -411,7 +411,7 @@ static int test_bitmap_clear(const char *name, unsigned long *bitmap,
>  static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
>  {
>  	unsigned long i, j;
> -	unsigned long byte_len = eb->len;
> +	unsigned long byte_len = eb->fs_info->nodesize;
>  	u32 x;
>  	int ret;
>  
> @@ -670,7 +670,7 @@ static int test_find_first_clear_extent_bit(void)
>  static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
>  					const char *test_name)
>  {
> -	for (int i = 0; i < eb->len; i++) {
> +	for (int i = 0; i < eb->fs_info->nodesize; i++) {
>  		struct page *page = folio_page(eb->folios[i >> PAGE_SHIFT], 0);
>  		void *addr = page_address(page) + offset_in_page(i);
>  
> @@ -686,7 +686,7 @@ static void dump_eb_and_memory_contents(struct extent_buffer *eb, void *memory,
>  static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
>  				const char *test_name)
>  {
> -	for (int i = 0; i < (eb->len >> PAGE_SHIFT); i++) {
> +	for (int i = 0; i < (eb->fs_info->nodesize >> PAGE_SHIFT); i++) {
>  		void *eb_addr = folio_address(eb->folios[i]);
>  
>  		if (memcmp(memory + (i << PAGE_SHIFT), eb_addr, PAGE_SIZE) != 0) {
> @@ -703,8 +703,8 @@ static int verify_eb_and_memory(struct extent_buffer *eb, void *memory,
>   */
>  static void init_eb_and_memory(struct extent_buffer *eb, void *memory)
>  {
> -	get_random_bytes(memory, eb->len);
> -	write_extent_buffer(eb, memory, 0, eb->len);
> +	get_random_bytes(memory, eb->fs_info->nodesize);
> +	write_extent_buffer(eb, memory, 0, eb->fs_info->nodesize);
>  }
>  
>  static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 271c958909cd8..0b87f2e2ee75e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2416,7 +2416,7 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
>  				   struct extent_buffer *eb)
>  {
>  	if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flags) ||
> -	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
> +	    eb->start + eb->fs_info->nodesize * 2 <= bg->start + bg->zone_capacity)
>  		return;
>  
>  	if (WARN_ON(bg->zone_finish_work.func == btrfs_zone_finish_endio_workfn)) {
> -- 
> 2.47.2
> 

