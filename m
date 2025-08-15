Return-Path: <linux-btrfs+bounces-16087-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E634B28759
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 22:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9781CC6A1D
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB891E2602;
	Fri, 15 Aug 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kXORqzzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kb/DtXhU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76D23A9B3
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290860; cv=none; b=opf+v9VPTVg9PPKdbXMk5XQR230rU+rIsrrVdf5nrSj6E2q19KaBvlpFCgvWlnHUaDGbf2tkex2oQSbfqDITVBm8hDXF9vBB/fmus37TwMhAhEQRUItU/zrwDLeX5b0SzyZ/8iFT78+L07nt8nvE69c05UJR7m7fCgWXUjo90AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290860; c=relaxed/simple;
	bh=YyX3hS0XG7wsouTAfKPPnRlpKI0xt84ZHLNnXbXhrlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQjfiWozP1WFwTgwN4ikZduo9kx3ae25PZo9HPlP5Z0YyWJ2x+8PITLst1qYfLip5lnrCJf3sRtGT038+4OOHqq2AFwJoMUBt9qXuFymQPZUBaUwNDYLLIZcDFbWRNYONcyqypMcIu1kTE8C8/M+8NE3pyyw6SuQG7F9VUaa3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kXORqzzb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kb/DtXhU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 884C41400057;
	Fri, 15 Aug 2025 16:47:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 15 Aug 2025 16:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755290856; x=1755377256; bh=8EfICUgfBZ
	vgUj13ss3KXpRQYdjXyAvS+r+Ak+Z96NY=; b=kXORqzzbw/SKKtfmb34RM8thO0
	1no5YZFu+btBnRtymTMeJ/RdbHQ+1uSH16hxvLvxhlpbEASi1FleDwWMVLIh1TH6
	kXFvdKzRSsotYr0adM8pKOgAXx1yUFz4OXEECYOKz7eJNQn/2LzNnKZtpi/UUJU0
	ocFK3ceDwRvoktH/wKZpJfbNN959aCG6Lg4SaP8bzbZVUevekaw+ObOAbvQguu/4
	EvJCMzzyaHL5cq+iu/yhGNEw4A/oT7Mljpzgk0sTZQoxu/HPSsd5jmzs6STxjEka
	H4b7SKtl2Y1lo2cYfEe4l8+xM1cv+SfRutdo4yMClXAOlFjNpfqNU6OCwfAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755290856; x=1755377256; bh=8EfICUgfBZvgUj13ss3KXpRQYdjXyAvS+r+
	Ak+Z96NY=; b=kb/DtXhU65kKqhy0++rkA0F7oH0vPOsuEP1WVjTvlgrmNlKKd31
	Tko2GXDgpnc84LWK/+838A2vcCroJUv7iFUubDeTx0gB0cq/IYwLKg2iAuXO1VsL
	R99gpWx91YxOiYutFxthbiqZT3jdh78cKi7gTERg2idPvbBUcwnHhvNcTvwg92d/
	LHXg6SZbNlVrksRwEP126S3wIWzgrA8dj+pHLiOiNACfc+1GO1CWWCQvdJMicisi
	Sk1pXD6pOVGD2rA2qlKB0TKkKgKr1ZvHqFBXm27qijBV25AJSkIwYu3I0ahViJiJ
	exSAbn74avQYrxidsHp5rLT9vExl177vQIw==
X-ME-Sender: <xms:6JyfaKizHKltgb6hfyVSxZvYVsv4UfFP-gN6otS6ZdeVDeYh-6qUeg>
    <xme:6JyfaLNkyk3UHl3IDxhENytDujiG6AvmTMewE63pFO413tDZXxmiWAZQ1yWlkncel
    7ZcsBk0vtkasy__efA>
X-ME-Received: <xmr:6JyfaD77gyxht-cA4bJtCJph3_HgJkVL7DZYphfkOXhYD_oTD7C3f0gu8uxm2drOsJdOi4ZhENkpENaO2bdRj6NULno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6JyfaB0r2tKE-4myx1oQHi74KdDSziedouyHzAXxq_myOtrdNfCu9g>
    <xmx:6JyfaMZU9EtPzMz02YHumAiCb_SbHaBkc46rEkQrAKbo93qjXbdVFg>
    <xmx:6JyfaBCvTpEt37Hq4fup5YN0z1QTn9LG2xDh8jAygL_WogURNgYPAQ>
    <xmx:6JyfaG_hWoQCDh10yHuv42L4z3bjguqjbjc_dTMKtf9xu8Lh1C7Z2w>
    <xmx:6JyfaET3jfMox565LOpYMImVo_WZ1cjBW0e2no_CaCDeRTgYDuBgreUY>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 16:47:35 -0400 (EDT)
Date: Fri, 15 Aug 2025 13:48:17 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: convert several int parameters to bool
Message-ID: <20250815204817.GB2973697@zen.localdomain>
References: <20250813104111.1371278-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104111.1371278-1-dsterba@suse.com>

On Wed, Aug 13, 2025 at 12:41:11PM +0200, David Sterba wrote:
> We're almost done cleaning misused int/bool parameters. Convert a bunch
> of them, found by manual grepping.  Note that btrfs_sync_fs() needs an
> int as it's mandated by the struct super_operations prototype.
> 

I noticed a few related return values that could be bool-ified but I
assume that is a separate effort from the parameters done here?

Either way, this patch LGTM.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/block-group.c    |  2 +-
>  fs/btrfs/btrfs_inode.h    |  2 +-
>  fs/btrfs/ctree.c          | 16 ++++++++--------
>  fs/btrfs/disk-io.c        |  4 ++--
>  fs/btrfs/disk-io.h        |  3 +--
>  fs/btrfs/extent-io-tree.c |  2 +-
>  fs/btrfs/extent-io-tree.h |  2 +-
>  fs/btrfs/extent-tree.c    | 16 ++++++++--------
>  fs/btrfs/extent-tree.h    |  7 +++----
>  fs/btrfs/extent_io.c      |  2 +-
>  fs/btrfs/extent_map.c     | 20 ++++++++++----------
>  fs/btrfs/inode.c          |  2 +-
>  fs/btrfs/ioctl.c          | 10 +++++-----
>  fs/btrfs/qgroup.c         |  2 +-
>  fs/btrfs/reflink.c        |  4 ++--
>  fs/btrfs/relocation.c     |  4 ++--
>  fs/btrfs/scrub.c          |  6 +++---
>  fs/btrfs/scrub.h          |  2 +-
>  fs/btrfs/send.c           | 28 +++++++++++++---------------
>  fs/btrfs/transaction.c    |  6 +++---
>  fs/btrfs/tree-log.c       |  6 +++---
>  fs/btrfs/volumes.c        |  2 +-
>  22 files changed, 72 insertions(+), 76 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9bf282d2453c02..27b8b9de130c11 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1358,7 +1358,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>   * data in this block group. That check should be done by relocation routine,
>   * not this function.
>   */
> -static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
> +static int inc_block_group_ro(struct btrfs_block_group *cache, bool force)
>  {
>  	struct btrfs_space_info *sinfo = cache->space_info;
>  	u64 num_bytes;
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index b99fb027329290..06907ca149f25b 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -558,7 +558,7 @@ int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
>  		       const struct fscrypt_str *name);
>  int btrfs_add_link(struct btrfs_trans_handle *trans,
>  		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
> -		   const struct fscrypt_str *name, int add_backref, u64 index);
> +		   const struct fscrypt_str *name, bool add_backref, u64 index);
>  int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry);
>  int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 end);
>  
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 74e6d7f3d2660e..6f9465d4ce54ce 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -30,10 +30,10 @@ static int split_node(struct btrfs_trans_handle *trans, struct btrfs_root
>  		      *root, struct btrfs_path *path, int level);
>  static int split_leaf(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  		      const struct btrfs_key *ins_key, struct btrfs_path *path,
> -		      int data_size, int extend);
> +		      int data_size, bool extend);
>  static int push_node_left(struct btrfs_trans_handle *trans,
>  			  struct extent_buffer *dst,
> -			  struct extent_buffer *src, int empty);
> +			  struct extent_buffer *src, bool empty);
>  static int balance_node_right(struct btrfs_trans_handle *trans,
>  			      struct extent_buffer *dst_buf,
>  			      struct extent_buffer *src_buf);
> @@ -1484,7 +1484,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
>  			reada_for_search(fs_info, p, parent_level, slot, key->objectid);
>  
>  		/* first we do an atomic uptodate check */
> -		if (btrfs_buffer_uptodate(tmp, check.transid, 1) > 0) {
> +		if (btrfs_buffer_uptodate(tmp, check.transid, true) > 0) {
>  			/*
>  			 * Do extra check for first_key, eb can be stale due to
>  			 * being cached, read from scrub, or have multiple
> @@ -2686,7 +2686,7 @@ static bool check_sibling_keys(const struct extent_buffer *left,
>   */
>  static int push_node_left(struct btrfs_trans_handle *trans,
>  			  struct extent_buffer *dst,
> -			  struct extent_buffer *src, int empty)
> +			  struct extent_buffer *src, bool empty)
>  {
>  	struct btrfs_fs_info *fs_info = trans->fs_info;
>  	int push_items = 0;
> @@ -3102,7 +3102,7 @@ int btrfs_leaf_free_space(const struct extent_buffer *leaf)
>   */
>  static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
>  				      struct btrfs_path *path,
> -				      int data_size, int empty,
> +				      int data_size, bool empty,
>  				      struct extent_buffer *right,
>  				      int free_space, u32 left_nritems,
>  				      u32 min_slot)
> @@ -3239,7 +3239,7 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
>  static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
>  			   *root, struct btrfs_path *path,
>  			   int min_data_size, int data_size,
> -			   int empty, u32 min_slot)
> +			   bool empty, u32 min_slot)
>  {
>  	struct extent_buffer *left = path->nodes[0];
>  	struct extent_buffer *right;
> @@ -3316,7 +3316,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
>   */
>  static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
>  				     struct btrfs_path *path, int data_size,
> -				     int empty, struct extent_buffer *left,
> +				     bool empty, struct extent_buffer *left,
>  				     int free_space, u32 right_nritems,
>  				     u32 max_slot)
>  {
> @@ -3642,7 +3642,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
>  			       struct btrfs_root *root,
>  			       const struct btrfs_key *ins_key,
>  			       struct btrfs_path *path, int data_size,
> -			       int extend)
> +			       bool extend)
>  {
>  	struct btrfs_disk_key disk_key;
>  	struct extent_buffer *l;
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9cc14ab3529741..23d997f2481bbf 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -116,7 +116,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
>   * detect blocks that either didn't get written at all or got written
>   * in the wrong place.
>   */
> -int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid, int atomic)
> +int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid, bool atomic)
>  {
>  	if (!extent_buffer_uptodate(eb))
>  		return 0;
> @@ -1047,7 +1047,7 @@ static struct btrfs_root *read_tree_root_path(struct btrfs_root *tree_root,
>  		root->node = NULL;
>  		goto fail;
>  	}
> -	if (!btrfs_buffer_uptodate(root->node, generation, 0)) {
> +	if (!btrfs_buffer_uptodate(root->node, generation, false)) {
>  		ret = -EIO;
>  		goto fail;
>  	}
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index 864a55a96226e7..57920f2c6fe4ef 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -106,8 +106,7 @@ static inline struct btrfs_root *btrfs_grab_root(struct btrfs_root *root)
>  void btrfs_put_root(struct btrfs_root *root);
>  void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
>  			     struct extent_buffer *buf);
> -int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
> -			  int atomic);
> +int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid, bool atomic);
>  int btrfs_read_extent_buffer(struct extent_buffer *buf,
>  			     const struct btrfs_tree_parent_check *check);
>  
> diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> index 66361325f6dcea..0c58342c6125e1 100644
> --- a/fs/btrfs/extent-io-tree.c
> +++ b/fs/btrfs/extent-io-tree.c
> @@ -1664,7 +1664,7 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
>   */
>  u64 btrfs_count_range_bits(struct extent_io_tree *tree,
>  			   u64 *start, u64 search_end, u64 max_bytes,
> -			   u32 bits, int contig,
> +			   u32 bits, bool contig,
>  			   struct extent_state **cached_state)
>  {
>  	struct extent_state *state = NULL;
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index 36facca379738b..6f07b965e8da52 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -163,7 +163,7 @@ void __cold btrfs_extent_state_free_cachep(void);
>  
>  u64 btrfs_count_range_bits(struct extent_io_tree *tree,
>  			   u64 *start, u64 search_end,
> -			   u64 max_bytes, u32 bits, int contig,
> +			   u64 max_bytes, u32 bits, bool contig,
>  			   struct extent_state **cached_state);
>  
>  void btrfs_free_extent_state(struct extent_state *state);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 682d21a73a67a4..e117b5cbefae73 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2457,7 +2457,7 @@ int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset,
>  static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
>  			   struct btrfs_root *root,
>  			   struct extent_buffer *buf,
> -			   int full_backref, int inc)
> +			   bool full_backref, bool inc)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	u64 parent;
> @@ -2543,15 +2543,15 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
>  }
>  
>  int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> -		  struct extent_buffer *buf, int full_backref)
> +		  struct extent_buffer *buf, bool full_backref)
>  {
> -	return __btrfs_mod_ref(trans, root, buf, full_backref, 1);
> +	return __btrfs_mod_ref(trans, root, buf, full_backref, true);
>  }
>  
>  int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> -		  struct extent_buffer *buf, int full_backref)
> +		  struct extent_buffer *buf, bool full_backref)
>  {
> -	return __btrfs_mod_ref(trans, root, buf, full_backref, 0);
> +	return __btrfs_mod_ref(trans, root, buf, full_backref, false);
>  }
>  
>  static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
> @@ -5584,7 +5584,7 @@ static int check_next_block_uptodate(struct btrfs_trans_handle *trans,
>  
>  	generation = btrfs_node_ptr_generation(path->nodes[level], path->slots[level]);
>  
> -	if (btrfs_buffer_uptodate(next, generation, 0))
> +	if (btrfs_buffer_uptodate(next, generation, false))
>  		return 0;
>  
>  	check.level = level - 1;
> @@ -6051,9 +6051,9 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
>   * also make sure backrefs for the shared block and all lower level
>   * blocks are properly updated.
>   *
> - * If called with for_reloc == 0, may exit early with -EAGAIN
> + * If called with for_reloc set, may exit early with -EAGAIN
>   */
> -int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
> +int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc)
>  {
>  	const bool is_reloc_root = (btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index 82d3a82dc712a4..e970ac42a871ad 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -140,9 +140,9 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes, u64 num_bytes,
>  			 u64 min_alloc_size, u64 empty_size, u64 hint_byte,
>  			 struct btrfs_key *ins, int is_data, int delalloc);
>  int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> -		  struct extent_buffer *buf, int full_backref);
> +		  struct extent_buffer *buf, bool full_backref);
>  int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> -		  struct extent_buffer *buf, int full_backref);
> +		  struct extent_buffer *buf, bool full_backref);
>  int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
>  				struct extent_buffer *eb, u64 flags);
>  int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
> @@ -155,8 +155,7 @@ int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans,
>  			      const struct extent_buffer *eb);
>  int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
>  int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrfs_ref *generic_ref);
> -int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
> -				     int for_reloc);
> +int btrfs_drop_snapshot(struct btrfs_root *root, bool update_ref, bool for_reloc);
>  int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>  			struct btrfs_root *root,
>  			struct extent_buffer *node,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6a55099aec4e5c..52589d6b9150b6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4509,7 +4509,7 @@ void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
>  	if (IS_ERR(eb))
>  		return;
>  
> -	if (btrfs_buffer_uptodate(eb, gen, 1)) {
> +	if (btrfs_buffer_uptodate(eb, gen, true)) {
>  		free_extent_buffer(eb);
>  		return;
>  	}
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 57f52585a6dde9..ac28eee7ae32c5 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -460,7 +460,7 @@ void btrfs_clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
>  
>  static inline void setup_extent_mapping(struct btrfs_inode *inode,
>  					struct extent_map *em,
> -					int modified)
> +					bool modified)
>  {
>  	refcount_inc(&em->refs);
>  
> @@ -486,7 +486,7 @@ static inline void setup_extent_mapping(struct btrfs_inode *inode,
>   * taken, or a reference dropped if the merge attempt was successful.
>   */
>  static int add_extent_mapping(struct btrfs_inode *inode,
> -			      struct extent_map *em, int modified)
> +			      struct extent_map *em, bool modified)
>  {
>  	struct extent_map_tree *tree = &inode->extent_tree;
>  	struct btrfs_root *root = inode->root;
> @@ -509,7 +509,7 @@ static int add_extent_mapping(struct btrfs_inode *inode,
>  }
>  
>  static struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
> -						u64 start, u64 len, int strict)
> +						u64 start, u64 len, bool strict)
>  {
>  	struct extent_map *em;
>  	struct rb_node *rb_node;
> @@ -548,7 +548,7 @@ static struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
>  struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
>  					       u64 start, u64 len)
>  {
> -	return lookup_extent_mapping(tree, start, len, 1);
> +	return lookup_extent_mapping(tree, start, len, true);
>  }
>  
>  /*
> @@ -566,7 +566,7 @@ struct extent_map *btrfs_lookup_extent_mapping(struct extent_map_tree *tree,
>  struct extent_map *btrfs_search_extent_mapping(struct extent_map_tree *tree,
>  					       u64 start, u64 len)
>  {
> -	return lookup_extent_mapping(tree, start, len, 0);
> +	return lookup_extent_mapping(tree, start, len, false);
>  }
>  
>  /*
> @@ -594,7 +594,7 @@ void btrfs_remove_extent_mapping(struct btrfs_inode *inode, struct extent_map *e
>  static void replace_extent_mapping(struct btrfs_inode *inode,
>  				   struct extent_map *cur,
>  				   struct extent_map *new,
> -				   int modified)
> +				   bool modified)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	struct extent_map_tree *tree = &inode->extent_tree;
> @@ -670,7 +670,7 @@ static noinline int merge_extent_mapping(struct btrfs_inode *inode,
>  	em->len = end - start;
>  	if (em->disk_bytenr < EXTENT_MAP_LAST_BYTE)
>  		em->offset += start_diff;
> -	return add_extent_mapping(inode, em, 0);
> +	return add_extent_mapping(inode, em, false);
>  }
>  
>  /*
> @@ -707,7 +707,7 @@ int btrfs_add_extent_mapping(struct btrfs_inode *inode,
>  	if (em->disk_bytenr == EXTENT_MAP_INLINE)
>  		ASSERT(em->start == 0);
>  
> -	ret = add_extent_mapping(inode, em, 0);
> +	ret = add_extent_mapping(inode, em, false);
>  	/* it is possible that someone inserted the extent into the tree
>  	 * while we had the lock dropped.  It is also possible that
>  	 * an overlapping map exists in the tree
> @@ -1082,7 +1082,7 @@ int btrfs_split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pr
>  	split_pre->flags = flags;
>  	split_pre->generation = em->generation;
>  
> -	replace_extent_mapping(inode, em, split_pre, 1);
> +	replace_extent_mapping(inode, em, split_pre, true);
>  
>  	/*
>  	 * Now we only have an extent_map at:
> @@ -1098,7 +1098,7 @@ int btrfs_split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pr
>  	split_mid->ram_bytes = split_mid->len;
>  	split_mid->flags = flags;
>  	split_mid->generation = em->generation;
> -	add_extent_mapping(inode, split_mid, 1);
> +	add_extent_mapping(inode, split_mid, true);
>  
>  	/* Once for us */
>  	btrfs_free_extent_map(em);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fcbe3e7910261b..980e279f835609 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6645,7 +6645,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
>   */
>  int btrfs_add_link(struct btrfs_trans_handle *trans,
>  		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
> -		   const struct fscrypt_str *name, int add_backref, u64 index)
> +		   const struct fscrypt_str *name, bool add_backref, u64 index)
>  {
>  	int ret = 0;
>  	struct btrfs_key key;
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index bf561be1888566..43c63c18e0a876 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1251,7 +1251,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
>  }
>  
>  static noinline int btrfs_ioctl_snap_create(struct file *file,
> -					    void __user *arg, int subvol)
> +					    void __user *arg, bool subvol)
>  {
>  	struct btrfs_ioctl_vol_args *vol_args;
>  	int ret;
> @@ -5207,13 +5207,13 @@ long btrfs_ioctl(struct file *file, unsigned int
>  	case FITRIM:
>  		return btrfs_ioctl_fitrim(fs_info, argp);
>  	case BTRFS_IOC_SNAP_CREATE:
> -		return btrfs_ioctl_snap_create(file, argp, 0);
> +		return btrfs_ioctl_snap_create(file, argp, false);
>  	case BTRFS_IOC_SNAP_CREATE_V2:
> -		return btrfs_ioctl_snap_create_v2(file, argp, 0);
> +		return btrfs_ioctl_snap_create_v2(file, argp, false);
>  	case BTRFS_IOC_SUBVOL_CREATE:
> -		return btrfs_ioctl_snap_create(file, argp, 1);
> +		return btrfs_ioctl_snap_create(file, argp, true);
>  	case BTRFS_IOC_SUBVOL_CREATE_V2:
> -		return btrfs_ioctl_snap_create_v2(file, argp, 1);
> +		return btrfs_ioctl_snap_create_v2(file, argp, true);
>  	case BTRFS_IOC_SNAP_DESTROY:
>  		return btrfs_ioctl_snap_destroy(file, argp, false);
>  	case BTRFS_IOC_SNAP_DESTROY_V2:
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index ccaa9a3cf1ce37..6352cd29ff893e 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -2727,7 +2727,7 @@ static void qgroup_iterator_nested_clean(struct list_head *head)
>   */
>  static void qgroup_update_refcnt(struct btrfs_fs_info *fs_info,
>  				 struct ulist *roots, struct list_head *qgroups,
> -				 u64 seq, int update_old)
> +				 u64 seq, bool update_old)
>  {
>  	struct ulist_node *unode;
>  	struct ulist_iterator uiter;
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index ce25ab7f0e9965..0a85e1da97777a 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -23,7 +23,7 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
>  				     u64 endoff,
>  				     const u64 destoff,
>  				     const u64 olen,
> -				     int no_time_update)
> +				     bool no_time_update)
>  {
>  	int ret;
>  
> @@ -337,7 +337,7 @@ static int clone_copy_inline_extent(struct btrfs_inode *inode,
>   */
>  static int btrfs_clone(struct inode *src, struct inode *inode,
>  		       const u64 off, const u64 olen, const u64 olen_aligned,
> -		       const u64 destoff, int no_time_update)
> +		       const u64 destoff, bool no_time_update)
>  {
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>  	struct btrfs_path *path = NULL;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index ad9b056c4a1845..ab868304556150 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1490,7 +1490,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
>  				 * ->reloc_root.  If it fails however we must
>  				 * drop the ref ourselves.
>  				 */
> -				ret2 = btrfs_drop_snapshot(reloc_root, 0, 1);
> +				ret2 = btrfs_drop_snapshot(reloc_root, false, true);
>  				if (ret2 < 0) {
>  					btrfs_put_root(reloc_root);
>  					if (!ret)
> @@ -1500,7 +1500,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
>  			btrfs_put_root(root);
>  		} else {
>  			/* Orphan reloc tree, just clean it up */
> -			ret2 = btrfs_drop_snapshot(root, 0, 1);
> +			ret2 = btrfs_drop_snapshot(root, false, true);
>  			if (ret2 < 0) {
>  				btrfs_put_root(root);
>  				if (!ret)
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 6776e6ab8d1080..ce5f6732bfb585 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -206,7 +206,7 @@ struct scrub_ctx {
>  	ktime_t			throttle_deadline;
>  	u64			throttle_sent;
>  
> -	int			is_dev_replace;
> +	bool			is_dev_replace;
>  	u64			write_pointer;
>  
>  	struct mutex            wr_lock;
> @@ -446,7 +446,7 @@ static void scrub_put_ctx(struct scrub_ctx *sctx)
>  }
>  
>  static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
> -		struct btrfs_fs_info *fs_info, int is_dev_replace)
> +		struct btrfs_fs_info *fs_info, bool is_dev_replace)
>  {
>  	struct scrub_ctx *sctx;
>  	int		i;
> @@ -3013,7 +3013,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
>  
>  int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>  		    u64 end, struct btrfs_scrub_progress *progress,
> -		    int readonly, int is_dev_replace)
> +		    bool readonly, bool is_dev_replace)
>  {
>  	struct btrfs_dev_lookup_args args = { .devid = devid };
>  	struct scrub_ctx *sctx;
> diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
> index f0df597b75c7c7..aa68b6ebaf555c 100644
> --- a/fs/btrfs/scrub.h
> +++ b/fs/btrfs/scrub.h
> @@ -11,7 +11,7 @@ struct btrfs_scrub_progress;
>  
>  int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
>  		    u64 end, struct btrfs_scrub_progress *progress,
> -		    int readonly, int is_dev_replace);
> +		    bool readonly, bool is_dev_replace);
>  void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
>  void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
>  int btrfs_scrub_cancel(struct btrfs_fs_info *info);
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7664025a5af431..faa3710fa074fe 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -973,7 +973,7 @@ typedef int (*iterate_inode_ref_t)(u64 dir, struct fs_path *p, void *ctx);
>   * path must point to the INODE_REF or INODE_EXTREF when called.
>   */
>  static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
> -			     struct btrfs_key *found_key, int resolve,
> +			     struct btrfs_key *found_key, bool resolve,
>  			     iterate_inode_ref_t iterate, void *ctx)
>  {
>  	struct extent_buffer *eb = path->nodes[0];
> @@ -1251,8 +1251,7 @@ static int get_inode_path(struct btrfs_root *root,
>  		goto out;
>  	}
>  
> -	ret = iterate_inode_ref(root, p, &found_key, 1,
> -				__copy_first_ref, path);
> +	ret = iterate_inode_ref(root, p, &found_key, true, __copy_first_ref, path);
>  	if (ret < 0)
>  		goto out;
>  	ret = 0;
> @@ -4756,8 +4755,8 @@ static int record_new_ref(struct send_ctx *sctx)
>  {
>  	int ret;
>  
> -	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
> -				sctx->cmp_key, 0, record_new_ref_if_needed, sctx);
> +	ret = iterate_inode_ref(sctx->send_root, sctx->left_path, sctx->cmp_key,
> +				false, record_new_ref_if_needed, sctx);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -4768,9 +4767,8 @@ static int record_deleted_ref(struct send_ctx *sctx)
>  {
>  	int ret;
>  
> -	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
> -				sctx->cmp_key, 0, record_deleted_ref_if_needed,
> -				sctx);
> +	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path, sctx->cmp_key,
> +				false, record_deleted_ref_if_needed, sctx);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -4781,12 +4779,12 @@ static int record_changed_ref(struct send_ctx *sctx)
>  {
>  	int ret;
>  
> -	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
> -			sctx->cmp_key, 0, record_new_ref_if_needed, sctx);
> +	ret = iterate_inode_ref(sctx->send_root, sctx->left_path, sctx->cmp_key,
> +				false, record_new_ref_if_needed, sctx);
>  	if (ret < 0)
>  		return ret;
> -	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
> -			sctx->cmp_key, 0, record_deleted_ref_if_needed, sctx);
> +	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path, sctx->cmp_key,
> +				false, record_deleted_ref_if_needed, sctx);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -4835,7 +4833,7 @@ static int process_all_refs(struct send_ctx *sctx,
>  		     found_key.type != BTRFS_INODE_EXTREF_KEY))
>  			break;
>  
> -		ret = iterate_inode_ref(root, path, &found_key, 0, cb, sctx);
> +		ret = iterate_inode_ref(root, path, &found_key, false, cb, sctx);
>  		if (ret < 0)
>  			goto out;
>  	}
> @@ -6578,7 +6576,7 @@ static int process_all_extents(struct send_ctx *sctx)
>  	return ret;
>  }
>  
> -static int process_recorded_refs_if_needed(struct send_ctx *sctx, int at_end,
> +static int process_recorded_refs_if_needed(struct send_ctx *sctx, bool at_end,
>  					   int *pending_move,
>  					   int *refs_processed)
>  {
> @@ -6601,7 +6599,7 @@ static int process_recorded_refs_if_needed(struct send_ctx *sctx, int at_end,
>  	return ret;
>  }
>  
> -static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
> +static int finish_inode_if_needed(struct send_ctx *sctx, bool at_end)
>  {
>  	int ret = 0;
>  	struct btrfs_inode_info info;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index c5c0d9cf1a8088..25ee0183e17812 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -404,7 +404,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
>   */
>  static int record_root_in_trans(struct btrfs_trans_handle *trans,
>  			       struct btrfs_root *root,
> -			       int force)
> +			       bool force)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	int ret = 0;
> @@ -2657,9 +2657,9 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
>  
>  	if (btrfs_header_backref_rev(root->node) <
>  			BTRFS_MIXED_BACKREF_REV)
> -		ret = btrfs_drop_snapshot(root, 0, 0);
> +		ret = btrfs_drop_snapshot(root, false, false);
>  	else
> -		ret = btrfs_drop_snapshot(root, 1, 0);
> +		ret = btrfs_drop_snapshot(root, true, false);
>  
>  	btrfs_put_root(root);
>  	return (ret < 0) ? 0 : 1;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index d732b5eff24d80..c08cb91a9390d5 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -381,7 +381,7 @@ static int process_one_buffer(struct btrfs_root *log,
>  			return ret;
>  		}
>  
> -		if (btrfs_buffer_uptodate(eb, gen, 0) &&
> +		if (btrfs_buffer_uptodate(eb, gen, false) &&
>  		    btrfs_header_level(eb) == 0) {
>  			ret = btrfs_exclude_logged_extents(eb);
>  			if (ret) {
> @@ -4402,7 +4402,7 @@ static int truncate_inode_items(struct btrfs_trans_handle *trans,
>  static void fill_inode_item(struct btrfs_trans_handle *trans,
>  			    struct extent_buffer *leaf,
>  			    struct btrfs_inode_item *item,
> -			    struct inode *inode, int log_inode_only,
> +			    struct inode *inode, bool log_inode_only,
>  			    u64 logged_isize)
>  {
>  	u64 flags;
> @@ -4498,7 +4498,7 @@ static int log_inode_item(struct btrfs_trans_handle *trans,
>  	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
>  				    struct btrfs_inode_item);
>  	fill_inode_item(trans, path->nodes[0], inode_item, &inode->vfs_inode,
> -			0, 0);
> +			false, 0);
>  	btrfs_release_path(path);
>  	return 0;
>  }
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7a929a046190..db26934da9f6e3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -4264,7 +4264,7 @@ static int __btrfs_balance(struct btrfs_fs_info *fs_info)
>   * @flags:     profile to validate
>   * @extended:  if true @flags is treated as an extended profile
>   */
> -static int alloc_profile_is_valid(u64 flags, int extended)
> +static int alloc_profile_is_valid(u64 flags, bool extended)
>  {
>  	u64 mask = (extended ? BTRFS_EXTENDED_PROFILE_MASK :
>  			       BTRFS_BLOCK_GROUP_PROFILE_MASK);
> -- 
> 2.50.1
> 

