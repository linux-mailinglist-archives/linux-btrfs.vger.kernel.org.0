Return-Path: <linux-btrfs+bounces-18884-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F6CC50A79
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 06:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F31E3AF4EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307512D97A9;
	Wed, 12 Nov 2025 05:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="kZdnouiv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mvdtMZkf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E135CBDC
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762927050; cv=none; b=jlbU6hCUaodRgo5mWSvsTlXlBAlb4jPgXTguOeXVpO2liLCkWNGyj4VIA/XzsR5wZmTJtes03bDQfxhOoL13wXOCOPwU5L+vO7GpzYB0Z7dY0gzlfsQRTiX9n/rP4Ofliqh/fT0xdemc53s+XHlzhMO1ioNRxz4rGR/ddpaQDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762927050; c=relaxed/simple;
	bh=ofSB1cJpFzBdNaE0aPLod53XO+rgN1mDS9Oft/fS2f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8WvtmfBIiexcN2LBFrc8zsr3TZcEzg1PhedudXRF4Dr5ty82PyQsBQ7Wqi2j4uDGnAztLew8Mwe1LVddBOCWdcNAobv5MpCZAqAHK7ZwaoKlFoudBTbBV+GDIKYqLsoJGhditopMCx0FkbDve5fN9j712gBvU4TSYNrtW1L/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=kZdnouiv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mvdtMZkf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 724A51400282;
	Wed, 12 Nov 2025 00:57:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 12 Nov 2025 00:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1762927047; x=1763013447; bh=v0C2XPz3az
	1dQTMqLMycMW6oe2HKqNM4VO+zUfmGqN0=; b=kZdnouivcOwtUU4QhOhrysU9cH
	AcBYU7Um66VAM+Id37/urzJBdeNlR15zlFhHJVttYcqXXkfr5CD9UJNgzkBF5HFa
	qD+aKQucO37RzFehSKmNWYjjFhtHtrheYoZxWD+oRIHUBurEJT7nG6cKmZwtYXz9
	qSkcjZam/eT37uRiPXlKFClHTRzsA0rxNubqsQsmM4a5ogV0vJB2dLpP/riMTSV0
	OzgxeMsg2C+U5CSPcVYU7jOl151PxXy7qthas5k6lcXMO6H8343sfEHYZIni/LR3
	ZdyT8WSNycYhHsVQRHNL7/DzwUFYiqa1gAduVRcJRk4jwMOXFeDaRCoeOfpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762927047; x=1763013447; bh=v0C2XPz3az1dQTMqLMycMW6oe2HKqNM4VO+
	zUfmGqN0=; b=mvdtMZkfCvELe6hu5cJJQE2VLDNv3SLwB2YoD+/ObpXHBoC8YJj
	3Q7Hx/QNCbUzTCCiBz8pEgRcpyng381FVNw28DIGq0jfWrFU9JcI4L4aoSesY/vP
	az5gXzzt1pOw5E2n7gT7KbPpyLr8iZr1/RJjMgXSa6sHQOVbIZS6LFt+PPnUnKGb
	j7P+T+M17wQBYbGPPIqYssoflemSqUp0d6zD2RR8PfJx5/GzqQLYhFgbJxyjKoxQ
	EaO4vIwk70SxdmZwPkYpVJjq4mVGAgdLFGnj9sHl65Bjn06plGsTLdyArA5NAUa7
	5mC/p+JLdHF/EC3plLgwJUoz3ogy3ppYj3w==
X-ME-Sender: <xms:xyEUae4RQUUmmMSiRCx0r6sqbIshNJW3rUXbA_6_oqAyfqIwQ9WkNA>
    <xme:xyEUad4VzLbheehKjKgz0VNk_Oh5m_O-LKBxi7vdsEgShbf0R2pDnYoOwcAYgDlct
    iNCost_VxEft4OWbyHhpjUs4SvXsDGPDMxMO2UBLJ726nzG0FY7rg>
X-ME-Received: <xmr:xyEUabG5exHE6UYc0N_r717TLU9JXdqfCSTzk30_ikudkI58a9NfeB_Oa8vI-D5uIBWR-jvb93Ne8mMEVfTEQOe1PFSKL70U0Mw6G9A02Vqc8uUTLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xyEUaWRfiW9oRHx5sbP0ljnsxwrMsT_qq0kGwkDMjNgpJRCh94_LLg>
    <xmx:xyEUaUvzJ3t2JDUYmSSoCAua0MDtMewifp3VLIqBkfZj2i2BSMPQvg>
    <xmx:xyEUaVzkU0WW2Fw2hhrM4NT1BfVoIryUsiLNuciCp9N_i6HpELELNg>
    <xmx:xyEUae6VRwxJM09qCb-aN0gtsS1QaVMNbDZJMBZGd-hmOuaNuTROWg>
    <xmx:xyEUaQuSHINhU_VV--gJSMs-iQInGXyo0VhkYPqgba7KBAwVdvV3eV3d>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 00:57:26 -0500 (EST)
Date: Tue, 11 Nov 2025 21:57:24 -0800
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 16/16] btrfs: populate fully_remapped_bgs_list on mount
Message-ID: <aRQhxKxa6gqnx5NX@devvm12410.ftw0.facebook.com>
References: <20251110171511.20900-1-mark@harmstone.com>
 <20251110171511.20900-17-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110171511.20900-17-mark@harmstone.com>

On Mon, Nov 10, 2025 at 05:14:40PM +0000, Mark Harmstone wrote:
> Add a function btrfs_populate_fully_remapped_bgs_list() which gets
> called on mount, which looks for fully remapped block groups
> (i.e. identity_remap_count == 0) which haven't yet had their chunk
> stripes and device extents removed.
> 
> This happens when a filesystem is unmounted while async discard has not
> yet finished, as otherwise the data range occupied by the chunk stripes
> would be permanently unusable.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Thanks for rewriting this one.
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/block-group.c      | 82 ++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/block-group.h      |  2 +
>  fs/btrfs/disk-io.c          |  9 ++++
>  fs/btrfs/free-space-cache.c |  7 ++++
>  fs/btrfs/relocation.c       |  4 ++
>  5 files changed, 103 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index b8ace5118d79..18a6b0984ce9 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4851,6 +4851,86 @@ void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  
> -	if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
> +	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +		spin_lock(&bg->lock);
> +		set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
> +			&bg->runtime_flags);
> +		spin_unlock(&bg->lock);
> +
>  		btrfs_discard_queue_work(&fs_info->discard_ctl, bg);
> +	}
> +}
> +
> +/*
> + * Compare the block group and chunk trees, and find any fully-remapped block
> + * groups which haven't yet had their chunk stripes and device extents removed,
> + * and put them on the fully_remapped_bgs list so this gets done.
> + *
> + * This happens when a block group becomes fully remapped, i.e. its last
> + * identity mapping is removed, and the volume is unmounted before async
> + * discard has finished. It's important this gets done as until it is the
> + * chunk's stripes are dead space.
> + */
> +int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info)
> +{
> +	struct rb_node *node_bg, *node_chunk;
> +
> +	node_bg = rb_first_cached(&fs_info->block_group_cache_tree);
> +	node_chunk = rb_first_cached(&fs_info->mapping_tree);
> +
> +	while (node_bg && node_chunk) {
> +		struct btrfs_block_group *bg;
> +		struct btrfs_chunk_map *map;
> +
> +		bg = rb_entry(node_bg, struct btrfs_block_group, cache_node);
> +		map = rb_entry(node_chunk, struct btrfs_chunk_map, rb_node);
> +
> +		ASSERT(bg->start == map->start);
> +
> +		if (!(bg->flags & BTRFS_BLOCK_GROUP_REMAPPED))
> +			goto next;
> +
> +		if (bg->identity_remap_count != 0)
> +			goto next;
> +
> +		if (map->num_stripes == 0)
> +			goto next;
> +
> +		spin_lock(&fs_info->unused_bgs_lock);
> +
> +		if (list_empty(&bg->bg_list)) {
> +			btrfs_get_block_group(bg);
> +			list_add_tail(&bg->bg_list,
> +				      &fs_info->fully_remapped_bgs);
> +		} else {
> +			list_move_tail(&bg->bg_list,
> +				       &fs_info->fully_remapped_bgs);
> +		}
> +
> +		spin_unlock(&fs_info->unused_bgs_lock);
> +
> +		/*
> +		 * Ideally we'd want to call btrfs_discard_queue_work() here,
> +		 * but it'd do nothing as the discard worker hasn't been
> +		 * started yet.
> +		 *
> +		 * The block group will get added to the discard list when
> +		 * btrfs_handle_fully_remapped_bgs() gets called, when we
> +		 * commit the first transaction.
> +		 */
> +		if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
> +			spin_lock(&bg->lock);
> +			set_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
> +				&bg->runtime_flags);
> +			spin_unlock(&bg->lock);
> +		}
> +
> +next:
> +		node_bg = rb_next(node_bg);
> +		node_chunk = rb_next(node_chunk);
> +	}
> +
> +	ASSERT(!node_bg && !node_chunk);
> +
> +	return 0;
>  }
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index b0b16efea19a..03e8ad8a2ec7 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -93,6 +93,7 @@ enum btrfs_block_group_flags {
>  	 * transaction.
>  	 */
>  	BLOCK_GROUP_FLAG_NEW,
> +	BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING,
>  };
>  
>  enum btrfs_caching_type {
> @@ -416,5 +417,6 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
>  bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
>  void btrfs_mark_bg_fully_remapped(struct btrfs_block_group *bg,
>  				  struct btrfs_trans_handle *trans);
> +int btrfs_populate_fully_remapped_bgs_list(struct btrfs_fs_info *fs_info);
>  
>  #endif /* BTRFS_BLOCK_GROUP_H */
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 908f706cf409..27f3cfc0145d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3645,6 +3645,15 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  		goto fail_sysfs;
>  	}
>  
> +	if (btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		ret = btrfs_populate_fully_remapped_bgs_list(fs_info);
> +		if (ret) {
> +			btrfs_err(fs_info,
> +			"failed to populate fully_remapped_bgs list: %d", ret);
> +			goto fail_sysfs;
> +		}
> +	}
> +
>  	btrfs_zoned_reserve_data_reloc_bg(fs_info);
>  	btrfs_free_zone_cache(fs_info);
>  
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 60101cb93e3d..0987e3750301 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3068,6 +3068,7 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
>  	bool ret = true;
>  
>  	if (block_group->flags & BTRFS_BLOCK_GROUP_REMAPPED &&
> +	    !test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &block_group->runtime_flags) &&
>  	    block_group->identity_remap_count == 0) {
>  		return true;
>  	}
> @@ -3851,6 +3852,11 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_chunk_map *map;
>  
> +	if (!test_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags)) {
> +		bg->discard_cursor = end;
> +		goto skip_discard;
> +	}
> +
>  	bytes = end - bg->discard_cursor;
>  
>  	if (max_discard_size &&
> @@ -3897,6 +3903,7 @@ void btrfs_trim_fully_remapped_block_group(struct btrfs_block_group *bg)
>  
>  	btrfs_free_chunk_map(map);
>  
> +skip_discard:
>  	if (bg->used == 0) {
>  		spin_lock(&fs_info->unused_bgs_lock);
>  		if (list_empty(&bg->bg_list)) {
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 840336965f32..3de0434413bf 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4760,6 +4760,10 @@ int btrfs_last_identity_remap_gone(struct btrfs_trans_handle *trans,
>  
>  	btrfs_remove_bg_from_sinfo(bg);
>  
> +	spin_lock(&bg->lock);
> +	clear_bit(BLOCK_GROUP_FLAG_STRIPE_REMOVAL_PENDING, &bg->runtime_flags);
> +	spin_unlock(&bg->lock);
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> -- 
> 2.51.0
> 

