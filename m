Return-Path: <linux-btrfs+bounces-16101-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0BBB28911
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 02:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B13A9A43
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 Aug 2025 00:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736224A02;
	Sat, 16 Aug 2025 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="JDXEUT8A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PP2U+bN7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E9189
	for <linux-btrfs@vger.kernel.org>; Sat, 16 Aug 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755302782; cv=none; b=DONJoLikPq+jzCkoWRQnYJEm00B5T5/1lZ/vhs+1KjFiilWM5u86C6FzHZjPRM5XpMwS7zQ9CCscSnq6Gv2cL0GAZYqCogTr+KgL+pL01BH1/0gc0Vm0UogqgY0iiNdu54iOatTGJI532I9LBQFMsImMrwrvHLrlKrqHcnpMSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755302782; c=relaxed/simple;
	bh=+kZYBllYRGS5YBsjegPluxuVh6tIpdwGOCbsMZWr0vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwtLvUu1yXCQ2pgWB8PJ+k3lc0u1HaM9VYbcfBDGBzI+okYVYQAf4qwsNL46c9/6sitbyrQHKRB5P9zAh3xQSPlUEqxc/kIhb9hQUMaEH5lRWoeZaL4RWpUkBZYc0EHhvt8JiVQIVzKLTn1QCkzU+icqbGHbQhN1MKRJx/V1evw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=JDXEUT8A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PP2U+bN7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E3A71D001BA;
	Fri, 15 Aug 2025 20:06:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 15 Aug 2025 20:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755302779; x=1755389179; bh=0HcCewYwhU
	ya4jHR1Fyxr0ymsqNqK8mVAQYba8VrgSY=; b=JDXEUT8AvNdhmSczi8MYvM6AuR
	5UFHy7u7TA7cBxHwKE+veiI3PCQOsgeu9KNWxU5TfUx57QUWwdSTW9yxWMOYGyUd
	K4aP3/ugLRaIx3MNiX/GLmTJnqcmE3HZErJXIirzHzPG7rCY5aKdruxFujeAe/gu
	Wz1XUXPps2jxhXuKG2Jd1kBMpKgzZS6GKZnI61hojndZc02pt4GqrwV5fz7q1R6V
	1lncQDAR7jzsMPPqCSPuFZuBWf/9BoOA/5oibF9bj9McX5tH4yJZFX1gYAa+yiDd
	O4AW+MZMYkQqv3/8kXRNNaSr30fMJbYvK1BzlJV2e//+RyrkW+KBSil7C3EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755302779; x=1755389179; bh=0HcCewYwhUya4jHR1Fyxr0ymsqNqK8mVAQY
	ba8VrgSY=; b=PP2U+bN7t54R2nUWJMWeYkQkLf34bKc8BwTB7863J7s3Pmg6zXV
	d3rFPhpjgkU7T4Nhu9nqvP09RoH9fY6jtEV+xiiEzi1L0fHc1L7vCFza65KDlETj
	8mzlSDjseQqryw9mnIdguOkWDifyyN+E9IdJSeg9qKuEyhXPR+O3Dv3VdmX75tny
	p4WFueWraZ+IkI3FKQl+tmJVrNxQo1PhbAz4+p5uQZrDNYYKtfzQbG1UNcAHNE8w
	fyNBoBUhHgSNMBPGkAhOWI8cqHHZlerAC82GWU3rYY45vkkdo4KFEy54KpDEKZk2
	xb65LyA8XXlNfS6q2Cq+RJzBr6m0hHHHAaA==
X-ME-Sender: <xms:esufaOSj9W6DXlXuopQhwaPTnVrWIwBbzTn-iRnJvJd-UcdXhukyjQ>
    <xme:esufaD-WTvKcFFTMH_bNWjkCopCmIfBYIUUmCln28ULvK_M05l6t1sp7YubGGPaCj
    lmUzrjK-ZeixC52VL8>
X-ME-Received: <xmr:esufaNrbYBJuiWClM3iQzRwVbwQpfX35Tbnwx0yUJVdhaGnEqW0R7usyvG0f3ULxMIKmeUUaB8VeT6xvABV2J2E7jbs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:esufaIn1gXt7fW6L8CfZmWljYGIC5DlD6S7ZD-WM-lgO584dIfLfvg>
    <xmx:esufaMKM0h40S-heicLecVlhAfIYEJKBPNNQ8HM3T_XhgYU5gfZN0Q>
    <xmx:esufaFztiCS319xziseLrpgw6MAhi5Ysw41mD-QE29KR7acuGNAy7A>
    <xmx:esufaMuvL96RnisRvcTO3SCpeI3OcwJNkAW0GWtj1DoxBo_WDtW2vw>
    <xmx:e8ufaE3f7UCdZU925GyKW9L2PKGvSgsZ00658H_RgiF2q_8zATUqVlHy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Aug 2025 20:06:18 -0400 (EDT)
Date: Fri, 15 Aug 2025 17:06:59 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 05/16] btrfs: don't add metadata items for the remap
 tree to the extent tree
Message-ID: <20250816000659.GC3042054@zen.localdomain>
References: <20250813143509.31073-1-mark@harmstone.com>
 <20250813143509.31073-6-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813143509.31073-6-mark@harmstone.com>

On Wed, Aug 13, 2025 at 03:34:47PM +0100, Mark Harmstone wrote:
> There is the following potential problem with the remap tree and delayed refs:
> 
> * Remapped extent freed in a delayed ref, which removes an entry from the
>   remap tree
> * Remap tree now small enough to fit in a single leaf
> * Corruption as we now have a level-0 block with a level-1 metadata item
>   in the extent tree
> 
> One solution to this would be to rework the remap tree code so that it operates
> via delayed refs. But as we're hoping to remove cow-only metadata items in the
> future anyway, change things so that the remap tree doesn't have any entries in
> the extent tree. This also has the benefit of reducing write amplification.
> 
> We also make it so that the clear_cache mount option is a no-op, as with the
> extent tree v2, as the free-space tree can no longer be recreated from the
> extent tree.
> 
> Finally disable relocating the remap tree itself, which is added back in
> a later patch. As it is we would get corruption as the traditional
> relocation method walks the extent tree, and we're removing its metadata
> items.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>  fs/btrfs/disk-io.c     |  3 +++
>  fs/btrfs/extent-tree.c | 31 ++++++++++++++++++++++++++++++-
>  fs/btrfs/volumes.c     |  3 +++
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7e60097b2a96..8e9520119d4f 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3049,6 +3049,9 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>  		if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
>  			btrfs_warn(fs_info,
>  				   "'clear_cache' option is ignored with extent tree v2");
> +		else if (btrfs_fs_incompat(fs_info, REMAP_TREE))
> +			btrfs_warn(fs_info,
> +				   "'clear_cache' option is ignored with remap tree");
>  		else
>  			rebuild_free_space_tree = true;
>  	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 682d21a73a67..5e038ae1a93f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1552,6 +1552,28 @@ static void free_head_ref_squota_rsv(struct btrfs_fs_info *fs_info,
>  				  BTRFS_QGROUP_RSV_DATA);
>  }
>  
> +static int drop_remap_tree_ref(struct btrfs_trans_handle *trans,
> +			       const struct btrfs_delayed_ref_node *node)
> +{
> +	u64 bytenr = node->bytenr;
> +	u64 num_bytes = node->num_bytes;
> +	int ret;
> +
> +	ret = btrfs_add_to_free_space_tree(trans, bytenr, num_bytes);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
> +	ret = btrfs_update_block_group(trans, bytenr, num_bytes, false);
> +	if (ret) {
> +		btrfs_abort_transaction(trans, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>  				struct btrfs_delayed_ref_head *href,
>  				const struct btrfs_delayed_ref_node *node,
> @@ -1746,7 +1768,10 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
>  		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
>  	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
> -		ret = __btrfs_free_extent(trans, href, node, extent_op);
> +		if (node->ref_root == BTRFS_REMAP_TREE_OBJECTID)
> +			ret = drop_remap_tree_ref(trans, node);
> +		else
> +			ret = __btrfs_free_extent(trans, href, node, extent_op);
>  	} else {
>  		BUG();
>  	}
> @@ -4896,6 +4921,9 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  	int level = btrfs_delayed_ref_owner(node);
>  	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
>  
> +	if (unlikely(node->ref_root == BTRFS_REMAP_TREE_OBJECTID))
> +		goto skip;
> +
>  	extent_key.objectid = node->bytenr;
>  	if (skinny_metadata) {
>  		/* The owner of a tree block is the level. */
> @@ -4948,6 +4976,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  
>  	btrfs_free_path(path);
>  
> +skip:
>  	return alloc_reserved_extent(trans, node->bytenr, fs_info->nodesize);
>  }
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c95f83305c82..678e5d4cd780 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3993,6 +3993,9 @@ static bool should_balance_chunk(struct extent_buffer *leaf, struct btrfs_chunk
>  	struct btrfs_balance_args *bargs = NULL;
>  	u64 chunk_type = btrfs_chunk_type(leaf, chunk);
>  
> +	if (chunk_type & BTRFS_BLOCK_GROUP_REMAP)
> +		return false;
> +
>  	/* type filter */
>  	if (!((chunk_type & BTRFS_BLOCK_GROUP_TYPE_MASK) &
>  	      (bctl->flags & BTRFS_BALANCE_TYPE_MASK))) {
> -- 
> 2.49.1
> 

