Return-Path: <linux-btrfs+bounces-21630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDvQNCe+jGmisgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21630-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:36:39 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4E7126A86
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337703024973
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Feb 2026 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227034DCE0;
	Wed, 11 Feb 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="PV/EkTOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9ETsKZe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2BD3EBF2C
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Feb 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831336; cv=none; b=eVPRjebPNxaTqEtkt28LMzBaIu3md34koLmgZ4Cb0lrKus/oIXM7lvpjIupaHn73ovSkrD0SjrkAN3TBy7uI91/Xy+rpHcnL98cDPp9DEA4SdH9u/RbBipVM4AC0RqgfvsJOEBBVsUl5k6sWr4KwRzko67xHDt4lgwOe70l1/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831336; c=relaxed/simple;
	bh=6sF8RlrhPYM7Q3chGdNElh2lPkXVYMWgWC0bEZKq6kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLJ24EOSrrrMWbYIU0qO9+nhUr2CcC0tARg5b75BdWlC6BEjdIVq5HdI7RNZsDuY9/IrwC5rUlCKXIz4UiENCv7lC9UsLqevQ8DEOCugvUvFn0aPQKZ2Y6EOOnkNwcPVt12IVJhi2MyihvguiLgcarIYmZ/2esBrq7TzG0uSfec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=PV/EkTOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9ETsKZe; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 26EE57A0053;
	Wed, 11 Feb 2026 12:35:33 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 12:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1770831332; x=1770917732; bh=7KGHpdOllp
	QQ1GL8pa9dCWqh/7sS93v0Ch6wTog/5eA=; b=PV/EkTOMXcOrKNm08wPlTZntes
	tGsPyndR3GnWtT2RqtDOwGeMnW9BLhlK6ci2n1FjT5+wp1zWGhWKEu37sda6PEXo
	6ywHYZ6Ll9zpWgfqxWDJNGgUHAZDk2YJ+9VK/LdzF2YJKXq79HK522M5el4VpJ4g
	nw6e78fpfgZ+8RX/37WlCJoMzVo/3gBtZRcfMnNWV52a97LJVA9PTntwyka+NyA1
	xIVv/NVP6JWtyx8ETjCXRzHdDnysLo2ncDDcvuDYmG3P9BnPfV83SX/aWZPuWlJd
	90XCLqeVWzfQliWEm4GTn7zORoeNU6kVWlf8nTlQ0CfFZWaKJpOlYbrg8a1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770831332; x=1770917732; bh=7KGHpdOllpQQ1GL8pa9dCWqh/7sS93v0Ch6
	wTog/5eA=; b=l9ETsKZe7JmWXJggTf4yeXBfWL5M4BPppQ8ffZG0JVBey61YQLq
	tIW3ogM63NfApbNJhmCoHriKE4rg/J0Nby7CEzodz3TfoLqo0C2PZbHQsfidz8rc
	Bw45riEMu2Ptf4I8RYtQb82T9LRQpfhTn87kX5N2meA0v4IA40vYnow80gp3uTBH
	xeA/m0U/5xbx3yXiAd4XJeMbjb6ZqmgSow2+vrO67viyQX7Pt5J65ynYRiPKu4O3
	igv/3GZt86YNRcBeBudOz+86psi24y0qZMGMScjKmgB7g4EPyrrQUqBbglUN5Bl3
	drFWFJwDYdUT5qGdaHm7H4j0pQardQhFWwA==
X-ME-Sender: <xms:5L2MaT1lYWh53BM6JyXP20x_5YAgVI2ZxdJq1seneJ0mH-RW-2oMAQ>
    <xme:5L2MaSTf8WBEnM8aDyMx-KTxkRhS3yt9rVWQziIH0tMusPVXMyu3oqEXBUrM14tVx
    HuC9oV33Va804DWXWEkAO-IZUXmRS6ztlSbY82MCAA_UTh5KUQ9XJo>
X-ME-Received: <xmr:5L2MaVujgKoTMQvo791mtLTeEHjkqRyMshUzzAak0JVQjDmOTqZiwBhEr_kh4YL8XicrQCA_SbYvHEevP1aqCIiPKEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefudeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5L2MaXbNM5cENBeTbW-RDmZ7PCafjIbek4lV6bJBKKzDK3HdoFPm1Q>
    <xmx:5L2MaatqBkZJJyE236UFOAqMFwNueBR6x-es5Sl6kwnwGh2rfLpJ1A>
    <xmx:5L2MaZG_yQ-f2igG5nMfyiMWBXACRi3JkJrpr3RkjnAeADs5opjEwA>
    <xmx:5L2MaVzOgATmCiyPUpuQRSwcMSiDYqczRbNzIKdV9evLZD8sjS-8tQ>
    <xmx:5L2MaV6abpzivgzYYtpOOE0Sk-2uIz3uF-vp7H2-zZPXxlCLawrvFe45>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 12:35:32 -0500 (EST)
Date: Wed, 11 Feb 2026 09:34:42 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: check for NULL root after calls to
 btrfs_extent_root()
Message-ID: <20260211173442.GA1458991@zen.localdomain>
References: <cover.1770724034.git.fdmanana@suse.com>
 <1d92d80fd23e64c3f9e5e295cff686c126274658.1770724034.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d92d80fd23e64c3f9e5e295cff686c126274658.1770724034.git.fdmanana@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21630-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,bur.io:dkim,suse.com:email]
X-Rspamd-Queue-Id: 0C4E7126A86
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 11:57:49AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> btrfs_extent_root() can return a NULL pointer in case the root we are
> looking for is not in the rb tree that tracks roots. So add checks to
> every caller that is missing such check to log a message and return
> an error. The same applies to callers of btrfs_block_group_root(),
> since it calls btrfs_extent_root().
> 

LGTM, thanks.

Would it also make sense to add
Fixes: 29cbcf401793 ("btrfs: stop accessing ->extent_root directly")

Or was it technically possible fs_info->extent_root was NULL before?

> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@meta.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/backref.c         | 28 ++++++++++++++
>  fs/btrfs/block-group.c     | 36 ++++++++++++++++++
>  fs/btrfs/disk-io.c         | 13 ++++++-
>  fs/btrfs/extent-tree.c     | 78 ++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/free-space-tree.c |  9 ++++-
>  fs/btrfs/qgroup.c          |  8 ++++
>  fs/btrfs/relocation.c      | 22 ++++++++++-
>  fs/btrfs/zoned.c           |  7 ++++
>  8 files changed, 193 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index cf10e10a40fa..8a119c505e32 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1388,6 +1388,13 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
>  		.indirect_missing_keys = PREFTREE_INIT
>  	};
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(ctx->fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  ctx->bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	/* Roots ulist is not needed when using a sharedness check context. */
>  	if (sc)
>  		ASSERT(ctx->roots == NULL);
> @@ -2194,6 +2201,13 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
>  	struct btrfs_extent_item *ei;
>  	struct btrfs_key key;
>  
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  logical);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = logical;
>  	if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
>  		key.type = BTRFS_METADATA_ITEM_KEY;
> @@ -2841,6 +2855,13 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
>  	struct btrfs_key key;
>  	int ret;
>  
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	key.type = BTRFS_METADATA_ITEM_KEY;
>  	key.offset = (u64)-1;
> @@ -2977,6 +2998,13 @@ int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
>  
>  	/* We're at keyed items, there is no inline item, go to the next one */
>  	extent_root = btrfs_extent_root(iter->fs_info, iter->bytenr);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(iter->fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  iter->bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_next_item(extent_root, iter->path);
>  	if (ret)
>  		return ret;
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 17a18f17538d..36ff6c5a8f51 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -738,6 +738,12 @@ static int load_extent_tree_free(struct btrfs_caching_control *caching_ctl)
>  		return -ENOMEM;
>  
>  	extent_root = btrfs_extent_root(fs_info, last);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for block group at offset %llu",
> +			  block_group->start);
> +		return -EUCLEAN;
> +	}
>  
>  #ifdef CONFIG_BTRFS_DEBUG
>  	/*
> @@ -1060,6 +1066,11 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
>  	int ret;
>  
>  	root = btrfs_block_group_root(fs_info);
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = block_group->start;
>  	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
>  	key.offset = block_group->length;
> @@ -1348,6 +1359,11 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>  	struct btrfs_chunk_map *map;
>  	unsigned int num_items;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return ERR_PTR(-EUCLEAN);
> +	}
> +
>  	map = btrfs_find_chunk_map(fs_info, chunk_offset, 1);
>  	ASSERT(map != NULL);
>  	ASSERT(map->start == chunk_offset);
> @@ -2139,6 +2155,11 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
>  	int ret;
>  	struct btrfs_key found_key;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return -EUCLEAN;
> +	}
> +
>  	btrfs_for_each_slot(root, key, &found_key, path, ret) {
>  		if (found_key.objectid >= key->objectid &&
>  		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
> @@ -2713,6 +2734,11 @@ static int insert_block_group_item(struct btrfs_trans_handle *trans,
>  	size_t size;
>  	int ret;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return -EUCLEAN;
> +	}
> +
>  	spin_lock(&block_group->lock);
>  	btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
>  	btrfs_set_stack_block_group_v2_chunk_objectid(&bgi, block_group->global_root_id);
> @@ -3048,6 +3074,11 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>  	int ret;
>  	bool dirty_bg_running;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return -EUCLEAN;
> +	}
> +
>  	/*
>  	 * This can only happen when we are doing read-only scrub on read-only
>  	 * mount.
> @@ -3192,6 +3223,11 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
>  	u64 used, remap_bytes;
>  	u32 identity_remap_count;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info, "missing block group root");
> +		return -EUCLEAN;
> +	}
> +
>  	/*
>  	 * Block group items update can be triggered out of commit transaction
>  	 * critical section, thus we need a consistent view of used bytes.
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e2a4d4dbf056..4b1e67f176a3 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1590,7 +1590,7 @@ static int find_newest_super_backup(struct btrfs_fs_info *info)
>   * this will bump the backup pointer by one when it is
>   * done
>   */
> -static void backup_super_roots(struct btrfs_fs_info *info)
> +static int backup_super_roots(struct btrfs_fs_info *info)
>  {
>  	const int next_backup = info->backup_root_index;
>  	struct btrfs_root_backup *root_backup;
> @@ -1622,6 +1622,11 @@ static void backup_super_roots(struct btrfs_fs_info *info)
>  		struct btrfs_root *extent_root = btrfs_extent_root(info, 0);
>  		struct btrfs_root *csum_root = btrfs_csum_root(info, 0);
>  
> +		if (unlikely(!extent_root)) {
> +			btrfs_err(info, "missing extent root for extent at bytenr 0");
> +			return -EUCLEAN;
> +		}
> +
>  		btrfs_set_backup_extent_root(root_backup,
>  					     extent_root->node->start);
>  		btrfs_set_backup_extent_root_gen(root_backup,
> @@ -1669,6 +1674,8 @@ static void backup_super_roots(struct btrfs_fs_info *info)
>  	memcpy(&info->super_copy->super_roots,
>  	       &info->super_for_commit->super_roots,
>  	       sizeof(*root_backup) * BTRFS_NUM_BACKUP_ROOTS);
> +
> +	return 0;
>  }
>  
>  /*
> @@ -4019,7 +4026,9 @@ int write_all_supers(struct btrfs_trans_handle *trans)
>  	} else {
>  		/* We are called from transaction commit. */
>  		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
> -		backup_super_roots(fs_info);
> +		ret = backup_super_roots(fs_info);
> +		if (ret < 0)
> +			return ret;
>  	}
>  
>  	sb = fs_info->super_for_commit;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 01bbe3cae5c2..331263c206af 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -75,6 +75,12 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
>  	struct btrfs_key key;
>  	BTRFS_PATH_AUTO_FREE(path);
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu", start);
> +		return -EUCLEAN;
> +	}
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> @@ -131,6 +137,12 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
>  	key.offset = offset;
>  
>  	extent_root = btrfs_extent_root(fs_info, bytenr);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>  	if (ret < 0)
>  		return ret;
> @@ -436,6 +448,12 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>  	int recow;
>  	int ret;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	if (parent) {
>  		key.type = BTRFS_SHARED_DATA_REF_KEY;
> @@ -510,6 +528,12 @@ static noinline int insert_extent_data_ref(struct btrfs_trans_handle *trans,
>  	u32 num_refs;
>  	int ret;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	if (node->parent) {
>  		key.type = BTRFS_SHARED_DATA_REF_KEY;
> @@ -668,6 +692,12 @@ static noinline int lookup_tree_block_ref(struct btrfs_trans_handle *trans,
>  	struct btrfs_key key;
>  	int ret;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	if (parent) {
>  		key.type = BTRFS_SHARED_BLOCK_REF_KEY;
> @@ -692,6 +722,12 @@ static noinline int insert_tree_block_ref(struct btrfs_trans_handle *trans,
>  	struct btrfs_key key;
>  	int ret;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	if (node->parent) {
>  		key.type = BTRFS_SHARED_BLOCK_REF_KEY;
> @@ -782,6 +818,12 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>  	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
>  	int needed;
>  
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
>  	key.offset = num_bytes;
> @@ -1680,6 +1722,12 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
>  	}
>  
>  	root = btrfs_extent_root(fs_info, key.objectid);
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  key.objectid);
> +		return -EUCLEAN;
> +	}
>  again:
>  	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
>  	if (ret < 0) {
> @@ -2379,6 +2427,12 @@ static noinline int check_committed_ref(struct btrfs_inode *inode,
>  	int type;
>  	int ret;
>  
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
> +
>  	key.objectid = bytenr;
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
>  	key.offset = (u64)-1;
> @@ -3222,7 +3276,11 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
>  	u64 delayed_ref_root = href->owning_root;
>  
>  	extent_root = btrfs_extent_root(info, bytenr);
> -	ASSERT(extent_root);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(info,
> +			  "missing extent root for extent at bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
>  
>  	path = btrfs_alloc_path();
>  	if (!path)
> @@ -4935,11 +4993,18 @@ static int alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  		size += btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER_REF_KEY);
>  	size += btrfs_extent_inline_ref_size(type);
>  
> +	extent_root = btrfs_extent_root(fs_info, ins->objectid);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  ins->objectid);
> +		return -EUCLEAN;
> +	}
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
>  
> -	extent_root = btrfs_extent_root(fs_info, ins->objectid);
>  	ret = btrfs_insert_empty_item(trans, extent_root, path, ins, size);
>  	if (ret) {
>  		btrfs_free_path(path);
> @@ -5015,11 +5080,18 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  		size += sizeof(*block_info);
>  	}
>  
> +	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  extent_key.objectid);
> +		return -EUCLEAN;
> +	}
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
>  
> -	extent_root = btrfs_extent_root(fs_info, extent_key.objectid);
>  	ret = btrfs_insert_empty_item(trans, extent_root, path, &extent_key,
>  				      size);
>  	if (ret) {
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index ecddfca92b2b..9efd1ec90f03 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1073,6 +1073,14 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
>  	if (ret)
>  		return ret;
>  
> +	extent_root = btrfs_extent_root(trans->fs_info, block_group->start);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(trans->fs_info,
> +			  "missing extent root for block group at offset %llu",
> +			  block_group->start);
> +		return -EUCLEAN;
> +	}
> +
>  	mutex_lock(&block_group->free_space_lock);
>  
>  	/*
> @@ -1086,7 +1094,6 @@ static int populate_free_space_tree(struct btrfs_trans_handle *trans,
>  	key.type = BTRFS_EXTENT_ITEM_KEY;
>  	key.offset = 0;
>  
> -	extent_root = btrfs_extent_root(trans->fs_info, key.objectid);
>  	ret = btrfs_search_slot_for_read(extent_root, &key, path, 1, 0);
>  	if (ret < 0)
>  		goto out_locked;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 9dfd6632c8cc..aaa47b63ffb1 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3740,6 +3740,14 @@ static int qgroup_rescan_leaf(struct btrfs_trans_handle *trans,
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
>  	extent_root = btrfs_extent_root(fs_info,
>  				fs_info->qgroup_rescan_progress.objectid);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  fs_info->qgroup_rescan_progress.objectid);
> +		mutex_unlock(&fs_info->qgroup_rescan_lock);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_search_slot_for_read(extent_root,
>  					 &fs_info->qgroup_rescan_progress,
>  					 path, 1, 0);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 95f7c3a20691..3906e457d2ef 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4941,6 +4941,12 @@ static int do_remap_reloc_trans(struct btrfs_fs_info *fs_info,
>  	struct btrfs_space_info *sinfo = src_bg->space_info;
>  
>  	extent_root = btrfs_extent_root(fs_info, src_bg->start);
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for block group at offset %llu",
> +			  src_bg->start);
> +		return -EUCLEAN;
> +	}
>  
>  	trans = btrfs_start_transaction(extent_root, 0);
>  	if (IS_ERR(trans))
> @@ -5293,6 +5299,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start,
>  	int ret;
>  	bool bg_is_ro = false;
>  
> +	if (unlikely(!extent_root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for block group at offset %llu",
> +			  group_start);
> +		return -EUCLEAN;
> +	}
> +
>  	/*
>  	 * This only gets set if we had a half-deleted snapshot on mount.  We
>  	 * cannot allow relocation to start while we're still trying to clean up
> @@ -5523,12 +5536,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
>  		goto out;
>  	}
>  
> +	rc->extent_root = btrfs_extent_root(fs_info, 0);
> +	if (unlikely(!rc->extent_root)) {
> +		btrfs_err(fs_info, "missing extent root for extent at bytenr 0");
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +
>  	ret = reloc_chunk_start(fs_info);
>  	if (ret < 0)
>  		goto out_end;
>  
> -	rc->extent_root = btrfs_extent_root(fs_info, 0);
> -
>  	set_reloc_control(rc);
>  
>  	trans = btrfs_join_transaction(rc->extent_root);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ae6f61bcefca..4a1dabeea531 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1259,6 +1259,13 @@ static int calculate_alloc_pointer(struct btrfs_block_group *cache,
>  	key.offset = 0;
>  
>  	root = btrfs_extent_root(fs_info, key.objectid);
> +	if (unlikely(!root)) {
> +		btrfs_err(fs_info,
> +			  "missing extent root for extent at bytenr %llu",
> +			  key.objectid);
> +		return -EUCLEAN;
> +	}
> +
>  	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
>  	/* We should not find the exact match */
>  	if (unlikely(!ret))
> -- 
> 2.47.2
> 

