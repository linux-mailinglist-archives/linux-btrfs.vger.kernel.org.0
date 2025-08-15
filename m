Return-Path: <linux-btrfs+bounces-16098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6647B288EF
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 01:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5990B66DF3
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Aug 2025 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F1EEAB;
	Fri, 15 Aug 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZoIcKioP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVE7QosZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C727F18F
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Aug 2025 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755301830; cv=none; b=jE63r7WFB8yjygoGepnJeDW64EV9/IFsDcA9920UO5OKyphS3EAr5yOCzxpRmpqIBGVIl+yTI1GTP9qiv31/ngrrr+85KeYxLOlT4Net1pGA+RiLm57utN8c4HPbCaETr65V4FbL4Iyvh+Cy0Qf/6YgQ5UhhtCKqBUyos3Stq0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755301830; c=relaxed/simple;
	bh=QMAag5jnVXOvBfdUhRjPFcUdNcqQHHnX/SbpJDlGq20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eheiZq42L/20q2K5VWPLreVeRNCxTlMOHZoGRtbckhEWU/PJml/0an4Ft+NfhsSpVRED18QDA26bQo2o7lyhiI57i8308GA427Vso7pTEhUWi7boxHmb5NEjys3aVV0Jh9uaKX5/1tVu/E7AtloSlvWswZ+2e4GudbLVYzvfh+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZoIcKioP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DVE7QosZ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E2F05140007C;
	Fri, 15 Aug 2025 19:50:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Aug 2025 19:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755301826; x=1755388226; bh=X05Bd3UGH+
	6qjAoCXoVdBm5SjCnPlDdMhAYIxXztauI=; b=ZoIcKioPMFRbwXdxDVhp6R1f2H
	I3dT4UJ3+HlxX1sVT3ZsZILRyijm+d1CUKU/Mjv9eb3LQxGwUI6TfXmRnd7h1AkN
	UCYMAkW2MKCGmowB1/Ya9UaGjnNitNs+wu34UcTrM5897U1uH4ZlCBlD+/PqXj5M
	sbJ9aQGwU2d2gviKXFw6HY27bYT6EjKQr/d6H2i242z7FL9oyouA5U3EVmDagMjj
	0duyNC9M1SBiw0ikNHrGoEA4XsWUem2o7FgXZSs/LNvIntZYj0KYshqZdcbxi+Wi
	v6m6/z3KCRqNeZCHWptGYJ1dCFRbvM5ETcEOEin18aEUFiv+LsRsVSoT2VUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755301826; x=1755388226; bh=X05Bd3UGH+6qjAoCXoVdBm5SjCnPlDdMhAY
	IxXztauI=; b=DVE7QosZjWzdzCMsM+Mp9uLtqrkv6GA/L1jzs+OsPBXHyQQGM6I
	b01FGKRYL5C4tcmv+PUfTHCpqW56Y+cM5gU2T+URtAiy6VZhLzHmUYYp6cJEKiw+
	h4GiNYjf6LM6DdnTMkAvEpLUftQxy1BgfZuOVPRAh9HLxnvktznxQBsJxT2w1ter
	NQc1nNnTCN3ht7gGaOlRQ5nsjT0BBpWkUML7jFjuqU9NjGoDnhRVVevNXW9eihk6
	Mcr6l7URZjX3Hs5GP6OWx6kLwb5UnTRcfbUoBcpOxF7qaOrZdpHIfZ0l9PQDYIeF
	Aob7I7SZ+PSRicISglUgUUKSSelhIigj5Mg==
X-ME-Sender: <xms:wsefaMmPMeE0jWz-x3Vmlc0NU0tvo1MH3cW26oweknokE3pLe0wdGQ>
    <xme:wsefaMDE3Xggh8hHTVNRVTxLHay1TSqfFIm7i6xAEIT82HIV34-o9QBalSGZRvhKW
    AgA3xs0Zj_H6n7rSto>
X-ME-Received: <xmr:wsefaMeOC77p2qqR4GPK-mt-dIdkrwvzi47fXbSCYVAtB_4wAdImMkxcDS3Wfc-PNVRWdLStJOyYDLQk79DDiKTjHXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wsefaHISbWjroOspZqsa4JP69cX_RR5uKTFiB3b0HqGll7Casn27cw>
    <xmx:wsefaPcxs-8zjsM68G65j27SSiqgghWHFtQQ3j7GYGE0JeJarakkNA>
    <xmx:wsefaO3ieCv484biqhEi2AVVCO9DdHuKiyDOtcN6vnt0UAQVQQuKZg>
    <xmx:wsefaIiEp4idjk4sJurxlucCWDn51FbqlC-XfUlHccs82FYpv_9aUg>
    <xmx:wsefaIrW55iRbGDEs12tuLaOlX5C0ny4SXAhvM5znD7cRVnvp2GnF5lM>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 19:50:26 -0400 (EDT)
Date: Fri, 15 Aug 2025 16:51:07 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 01/16] btrfs: add definitions and constants for
 remap-tree
Message-ID: <20250815235107.GA3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-2-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-2-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:43PM +0100, Mark Harmstone wrote:
> Add an incompat flag for the new remap-tree feature, and the constants
> and definitions needed to support it.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>

Some formatting nits, but you can add

Reviewed-by: Boris Burkov <boris@bur.io>

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
> index 99b3ced12805..95a1ca8c099b 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -1009,6 +1009,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
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
> index a3e6d9616e60..26f810258486 100644
> --- a/fs/btrfs/locking.c
> +++ b/fs/btrfs/locking.c
> @@ -73,6 +73,7 @@ static struct btrfs_lockdep_keyset {
>  	{ .id = BTRFS_FREE_SPACE_TREE_OBJECTID,	DEFINE_NAME("free-space") },
>  	{ .id = BTRFS_BLOCK_GROUP_TREE_OBJECTID, DEFINE_NAME("block-group") },
>  	{ .id = BTRFS_RAID_STRIPE_TREE_OBJECTID, DEFINE_NAME("raid-stripe") },
> +	{ .id = BTRFS_REMAP_TREE_OBJECTID,      DEFINE_NAME("remap-tree") },
>  	{ .id = 0,				DEFINE_NAME("tree")	},
>  };
>  
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 81f52c1f55ce..857d2772db1c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>  BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
> +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
> @@ -325,6 +326,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
>  	BTRFS_FEAT_ATTR_PTR(block_group_tree),
>  	BTRFS_FEAT_ATTR_PTR(simple_quota),
> +	BTRFS_FEAT_ATTR_PTR(remap_tree),
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 0f556f4de3f9..76ec3698f197 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -912,12 +912,10 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
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

I think the two next lines should be lined up after the '('

See the masks in include/uapi/linux/btrfs_tree.h

>  /*
>   * Exported simply for btrfs-progs which wants to have the
>   * btrfs_tree_block_status return codes.
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index fa7a929a0461..e067e9cd68a5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -231,6 +231,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>  
>  	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>  	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 8e710bbb688e..fba303ed49e6 100644
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

more funny indenting

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
> +} __attribute__ ((__packed__));
> +
>  #endif /* _BTRFS_CTREE_H_ */
> -- 
> 2.49.1
> 

