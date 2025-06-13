Return-Path: <linux-btrfs+bounces-14651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35886AD96D6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 23:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64674A1403
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 21:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2D322E3E8;
	Fri, 13 Jun 2025 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bIFSsMWN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oo4XzJrY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE1C263F5F
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848603; cv=none; b=kxYiPBujHIwZ9xTl/Dtade51ypCv3yFFgDhs4REFkIjQousLC4YKAy2XBGFhr/7kvi6rZBl4p5ml3MS93wPNAaQTUVz+vsThFKQJYckP8n7j79DDAbmjJmqzCyKJWiR6U+LZAiyhaQpTpIBwYFwJD41SguPjuis0se1LTZ8qSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848603; c=relaxed/simple;
	bh=19YiKOHm5ZleVOHGpUSPpQSYK3UtOBVoVFMV7c6Jp78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aH4r2yV2cAP4ttrDvSaUPcL99U9NRkLdJ5TUkrVbt+ayEOmExWDph+tIjGOSuYA+YBILvzXeIequ9kpK2vqVW7E5i8jRp5snBKFELaMHvVr+NgoB74C214eN0plG7yLnfkIYsG6oPHTwi5wn1I3xupj1FtKRbuYt+3c/SZYiRW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bIFSsMWN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oo4XzJrY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7B11811400E0;
	Fri, 13 Jun 2025 17:03:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 13 Jun 2025 17:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749848598; x=1749934998; bh=wIX2QDM6dS
	XQBc++0z4+ek7Gf3mBlsKyzL7/lad6R0Y=; b=bIFSsMWN2w1EyDc10AcN/KlCwy
	u4X7vOwzix3lsnsRK1U/S4/PChEMhYxKtSelHg44AD3KSo9+jlgsv0rF2tl+U2cL
	WavSTLhfEt4N9mIOUXA9YRBc91iyjFfu+djKCTXOkvix1zaxGxT9S9WHxvCcyoJI
	WqBHQg9NSCX3l84IwE7az4RCC4DKVZ2ze+v5A+9IU02onwNh0EzSrSrPvGoaTMPs
	djwj+d7S0bQ7MeYxxsYgA8oqFUdwEI2WAc8/+iFeZQYFuA6GJOsW+8o2tEABUDVd
	lcA52OcaXVAu6g5FHgmqVzWa8WOEO9sCWSfeg1o1JhsX0FdRIEqMTvICPr5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749848598; x=1749934998; bh=wIX2QDM6dSXQBc++0z4+ek7Gf3mBlsKyzL7
	/lad6R0Y=; b=oo4XzJrYJDUS0pGhs32dhCfUYa/g9Y2DvyM4OAqCBZowgrVTwy5
	wZtmplg+9UaVus4Jpac7zDp/IPI0pd2V/6aCA37sSHJkeW8tM8T6/M4fn9rDRAcv
	dw4lD59rNoJrTWdXMg4ac0gwcWQCs0Z/uvuv8/qiVRKJvJ939NfOmDHDPFlNdymk
	/iOQzXPec2Fnm5RezzE1Q+tEw6o4cN5AwMMlkrT1mo+kh5sLvtSMXuLjlrDhgX9D
	XBsVyUEazr/wJ5bxt1Wtvq8IdYYV6W+MKX0POqcsLVgL9xFNXzrHjVa+l/B2qgu8
	B54mYYcNAbx5xHsmRI+pTIKFXEl0a7Rajdw==
X-ME-Sender: <xms:FpJMaCCmkZTiyrYJRPb0Tpyf9ZRTuGc6pgsexM5KipEDT2ka5sW6iw>
    <xme:FpJMaMiXukpHAS8kad-ppYW2VT4IbaQLZOt4BZj7ruA8hZBHEhYQIgVKScH_ilQ_N
    IJaARJIul4oDy5KiHI>
X-ME-Received: <xmr:FpJMaFmokMk8IFCXfCgt_Fu9bpQ4U4mVNqw2kYAIu6YS5EU3m-wQtRgvjmTKQoxjJs5BuxX7JHBpUqVl0VXp7g58m1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FpJMaAwQx27THfl7AP-nKA9XLJjFxPkjy4IscmGSipeN6Cse0QL6sg>
    <xmx:FpJMaHRhgHI0wukoSVUFRKU5mTQj3Nw5ThwFi7CxLK-vShU0IL6h-g>
    <xmx:FpJMaLZSDghiwKXDxxDsBhU-P6I-RJaml8wy2ErZph1pGF_VNCMoNA>
    <xmx:FpJMaARNztL1r2Ou-hz5IW3hhnKGffvhyyK7VbzbIGQJMyksY3oTMQ>
    <xmx:FpJMaCmPIQykjDz9uKEacLSDgdC2uD1DTDNqZBYClTD22mrLbuHWwgUv>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 17:03:17 -0400 (EDT)
Date: Fri, 13 Jun 2025 14:02:58 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/12] btrfs: add definitions and constants for remap-tree
Message-ID: <20250613210258.GA3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-2-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-2-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:31PM +0100, Mark Harmstone wrote:
> Add an incompat flag for the new remap-tree feature, and the constants
> and definitions needed to support it.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/accessors.h            |  3 +++
>  fs/btrfs/sysfs.c                |  2 ++
>  fs/btrfs/tree-checker.c         |  6 ++++--
>  fs/btrfs/volumes.c              |  1 +
>  include/uapi/linux/btrfs.h      |  1 +
>  include/uapi/linux/btrfs_tree.h | 12 ++++++++++++
>  6 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
> index 15ea6348800b..5f5eda8d6f9e 100644
> --- a/fs/btrfs/accessors.h
> +++ b/fs/btrfs/accessors.h
> @@ -1046,6 +1046,9 @@ BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_encryption,
>  BTRFS_SETGET_STACK_FUNCS(stack_verity_descriptor_size,
>  			 struct btrfs_verity_descriptor_item, size, 64);
>  
> +BTRFS_SETGET_FUNCS(remap_address, struct btrfs_remap, address, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_remap_address, struct btrfs_remap, address, 64);
> +
>  /* Cast into the data area of the leaf. */
>  #define btrfs_item_ptr(leaf, slot, type)				\
>  	((type *)(btrfs_item_nr_offset(leaf, 0) + btrfs_item_offset(leaf, slot)))
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index f186c8082eff..831c25c2fb25 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -292,6 +292,7 @@ BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
>  BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
>  BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
>  BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
> +BTRFS_FEAT_ATTR_INCOMPAT(remap_tree, REMAP_TREE);
>  #ifdef CONFIG_BLK_DEV_ZONED
>  BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
>  #endif
> @@ -326,6 +327,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
>  	BTRFS_FEAT_ATTR_PTR(raid1c34),
>  	BTRFS_FEAT_ATTR_PTR(block_group_tree),
>  	BTRFS_FEAT_ATTR_PTR(simple_quota),
> +	BTRFS_FEAT_ATTR_PTR(remap_tree),
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	BTRFS_FEAT_ATTR_PTR(zoned),
>  #endif
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 8f4703b488b7..a83fb828723a 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -913,11 +913,13 @@ int btrfs_check_chunk_valid(const struct btrfs_fs_info *fs_info,
>  		return -EUCLEAN;
>  	}
>  	if (unlikely(type & ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> -			      BTRFS_BLOCK_GROUP_PROFILE_MASK))) {
> +			      BTRFS_BLOCK_GROUP_PROFILE_MASK |
> +			      BTRFS_BLOCK_GROUP_REMAPPED))) {

I'm not sure when we start a mask variable for these, but probably at
least at 3 of them. Wouldn't hate one here with the second, either.

>  		chunk_err(fs_info, leaf, chunk, logical,
>  			  "unrecognized chunk type: 0x%llx",
>  			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
> -			    BTRFS_BLOCK_GROUP_PROFILE_MASK) & type);
> +			    BTRFS_BLOCK_GROUP_PROFILE_MASK |
> +			    BTRFS_BLOCK_GROUP_REMAPPED) & type);
>  		return -EUCLEAN;
>  	}
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1535a425e8f9..3e53bde0e605 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -234,6 +234,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>  
>  	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
>  	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index dd02160015b2..d857cdc7694a 100644
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

Have we ever discussed any possible future extensions or more exotic
remappings? Would any metadata about the tree or type of remapping help
with the trickier relocation issues?

> +} __attribute__ ((__packed__));
> +
>  #endif /* _BTRFS_CTREE_H_ */
> -- 
> 2.49.0
> 

