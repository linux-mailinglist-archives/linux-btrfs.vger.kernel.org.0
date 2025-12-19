Return-Path: <linux-btrfs+bounces-19876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9ECCE219
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92268301988E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7B6218ACC;
	Fri, 19 Dec 2025 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FR9mP1Ak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOhZGmII";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FR9mP1Ak";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tOhZGmII"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFD72606
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 01:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107282; cv=none; b=u8FR/Ga7GE4srf+yHGZhQ1zyrMSIp5HS7I2pAlery8Mw8GgwzbLWIn368asy5iAkIeVL8odheseNn+xkZRqq6I37CRnQDlOoBGv0WMVOiPhvk9q5jlnDg+99JjM9YmJ0oi685neNG3oQUOfYdmVsLN5zYeCsD/wQz0cDSNT+Nsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107282; c=relaxed/simple;
	bh=KYsShYlsM1TTLxosMhotRmANwLAO+2y7aNr3EG3lH1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9KbQ+Rcyg8BBrPbS+tt83dY2q9+Bhgq48oiHmqUgJGfKFwgK9Tg0uXKHsFcC6A2yXx4RH7Y7TFlDEsboC3LEIVL1ObNcHLDvVKTlH3p8hC80vcbYG8eSKGr2t2qftdzVxGqC4unufk4hx+47CMcRQo5MXLJU1GuY2Ugm5wTieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FR9mP1Ak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOhZGmII; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FR9mP1Ak; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tOhZGmII; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 950925BD14;
	Fri, 19 Dec 2025 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766107277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3VdjcH/8M5RPNkbqmBqzk3Kx4by4rpDZFadtn2Puc=;
	b=FR9mP1AkHyH3MFgu1X45VPqWi7kJ6UmN3Qbwy4wdmqBQwPN6/cCw9cNHEN1xhoMo4Z/5s1
	x8q078U0x7SDrRUjO0R5qBuTV3v/12gghLTzUiQI0Yb3QOK8QfheXEVChgWmibDmQOULMQ
	bd1Qt9cB3F6gYanNJbh0uIZFD7142EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766107277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3VdjcH/8M5RPNkbqmBqzk3Kx4by4rpDZFadtn2Puc=;
	b=tOhZGmIIKATwkW5sZnIKej2fVMcI6WUNpQvVBabugjFEOl2D1NQhzDbZUyw1c8C4W0PH9E
	axwJgkJ6+vP3eMBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766107277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3VdjcH/8M5RPNkbqmBqzk3Kx4by4rpDZFadtn2Puc=;
	b=FR9mP1AkHyH3MFgu1X45VPqWi7kJ6UmN3Qbwy4wdmqBQwPN6/cCw9cNHEN1xhoMo4Z/5s1
	x8q078U0x7SDrRUjO0R5qBuTV3v/12gghLTzUiQI0Yb3QOK8QfheXEVChgWmibDmQOULMQ
	bd1Qt9cB3F6gYanNJbh0uIZFD7142EM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766107277;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qY3VdjcH/8M5RPNkbqmBqzk3Kx4by4rpDZFadtn2Puc=;
	b=tOhZGmIIKATwkW5sZnIKej2fVMcI6WUNpQvVBabugjFEOl2D1NQhzDbZUyw1c8C4W0PH9E
	axwJgkJ6+vP3eMBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75F373EA63;
	Fri, 19 Dec 2025 01:21:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wpt+HI2oRGl5MQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 01:21:17 +0000
Date: Fri, 19 Dec 2025 02:21:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v7 01/16] btrfs: add definitions and constants for
 remap-tree
Message-ID: <20251219012108.GV3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-2-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-2-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.14)[-0.680];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.94

On Mon, Nov 24, 2025 at 06:52:53PM +0000, Mark Harmstone wrote:
> Add an incompat flag for the new remap-tree feature, and the constants
> and definitions needed to support it.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/accessors.h            |  3 +++
>  fs/btrfs/locking.c              |  1 +
>  fs/btrfs/sysfs.c                |  2 ++
>  fs/btrfs/tree-checker.c         |  6 ++----
>  fs/btrfs/tree-checker.h         |  5 +++++
>  fs/btrfs/volumes.c              |  1 +
>  include/uapi/linux/btrfs.h      |  1 +
>  include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
>  8 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 78721412951c..3eec1a1ecdf4 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -1010,6 +1010,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
>  BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
>  			 struct btrfs_verity_descriptor_item, size, 64);
>  
> +BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, address, 64);
> +
>  /* Cast into the data area of the leaf. */
>  #define btrfs_item_ptr(leaf, slot, type)				\
>  	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
> diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
> index 0035851d72b0..726e4d70f37c 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
>  	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
>  	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
>  	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
> +	{ .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },

	"remap"

the '-tree" suffix is not used in other definitions.

>  	{ .id = 0,				DEFINE_NAME("tree")	},
>  };
>  
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 1f64c132b387..e095936c2389 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -293,6 +293,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>  BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
> +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
> @@ -327,6 +328,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
>  	BTRFS_FEAT_ATTR_PTR(block_group_tree),
>  	BTRFS_FEAT_ATTR_PTR(simple_quota),
> +	BTRFS_FEAT_ATTR_PTR(remap_tree),

This needs to be a few lines below under the #ifdef EXPERIMENTAL

>  #ifdef CONFIG_BLK_DEV_ZONED
>  	BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index c21c21adf61e..aedc208a95b8 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -913,12 +913,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  			  length, btrfs_stripe_nr_to_offset(U32_MAX));
>  		return -EUCLEAN;
>  	}
> -	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> -			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
> +	if (unlikely(type & ~BTRFS_BLOCK_GROUP_VALID)) {
>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "unrecognized chunk type: 0x%llx",
> -			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> -			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
> +			  type & ~BTRFS_BLOCK_GROUP_VALID);
>  		return -EUCLEAN;
>  	}
>  
> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> index eb201f4ec3c7..833e2fd989eb 100644
> --- a/fs/btrfs/tree-checker.h
> +++ b/fs/btrfs/tree-checker.h
> @@ -57,6 +57,11 @@ enum btrfs_tree_block_status {
>  	BTRFS_TREE_BLOCK_WRITTEN_NOT_SET,
>  };
>  
> +
> +#define BTRFS_BLOCK_GROUP_VALID	(BTRFS_BLOCK_GROUP_TYPE_MASK | \
> +				 BTRFS_BLOCK_GROUP_PROFILE_MASK | \
> +				 BTRFS_BLOCK_GROUP_REMAPPED)
> +
>  /*
>   * Exported simply for btrfs-progs which wants to have the
>   * btrfs_tree_block_status return codes.
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e81c8ac0d8ae..193cbb634ba3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");

Didn't we want to call it "remap" everywhere, ie. that it's related to
the remap-tree?

>  
>  	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>  	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index f40b300bd664..0763a23aeebc 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -336,6 +336,7 @@ struct btrfs_ioctl_fs_info_args {
>  #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
>  #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
>  #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
> +#define BTRFS_FEATURE_INCOMPAT_REMAP_TREE	(1ULL << 17)
>  
>  struct btrfs_ioctl_feature_flags {
>  	__u64 compat_flags;
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index fc29d273845d..4439d77a7252 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -76,6 +76,9 @@
>  /* Tracks RAID stripes in block groups. */
>  #define BTRFS_RAID_STRIPE_TREE_OBJECTID 12ULL
>  
> +/* Holds details of remapped addresses after relocation. */
> +#define BTRFS_REMAP_TREE_OBJECTID 13ULL
> +
>  /* device stats in the device tree */
>  #define BTRFS_DEV_STATS_OBJECTID 0ULL
>  
> @@ -282,6 +285,10 @@
>  
>  #define BTRFS_RAID_STRIPE_KEY	230
>  
> +#define BTRFS_IDENTITY_REMAP_KEY 	234
> +#define BTRFS_REMAP_KEY		 	235
> +#define BTRFS_REMAP_BACKREF_KEY	 	236

I've looked again for the key number placement, this is probably a good
location. Sorting by key does not apply as the objectid is still some
random value, there's a gap left before and after the other keys, which
is raid-stripe and followed by qgroup keys that have some gaps left
should we ever need to extend them.

> +
>  /*
>   * Records the overall state of the qgroups.
>   * There's only one instance of this key present,
> @@ -1161,6 +1168,7 @@ struct btrfs_dev_replace_item {
>  #define BTRFS_BLOCK_GROUP_RAID6         (1ULL << 8)
>  #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
>  #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
> +#define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
>  #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>  					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>  
> @@ -1323,4 +1331,8 @@ struct btrfs_verity_descriptor_item {
>  	__u8 encryption;
>  } __attribute__ ((__packed__));
>  

> +struct btrfs_remap {
> +	__le64 address;

Please add description of the item and rename it to btrfs_remap_item,
ie. which address in which space is it referring to.

> +} __attribute__ ((__packed__));
> +
>  #endif /* _BTRFS_CTREE_H_ */
> -- 
> 2.51.0
> 

