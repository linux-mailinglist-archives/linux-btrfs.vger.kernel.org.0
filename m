Return-Path: <linux-btrfs+bounces-14652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB392AD974B
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 23:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5253BAA49
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3966D28D849;
	Fri, 13 Jun 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Sub26kWB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nxfwnd65"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDFC2E11C1
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 21:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749849783; cv=none; b=FLhq333c4TQNGwMieCllh1YSXzidPi85o+aOA1w5uZWzsSBHZP330NW42BR8Q2TKR8Pbu5ugkRoRzUPjZiFKCiQFJUBaxwCnrcZ2hzNt/2SOB53IEluLFCrPE9X3ifVrKVRjX4RX++YIjCKnXwuqBb/DDR3slYuGzWjSSeFBAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749849783; c=relaxed/simple;
	bh=Mt9sDPgCFPC+Xp95tP8EmaRxxMF5befnMAM3NFWcWbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7ZesCASyZYIa4Wu8oc15pdOwZOxXXAmy0OcoNr9vQ8/hqpABk8qxDCfCXx0zzDbcOiZy5Dylv9ws+QapbAF88T1WV9fBCawDXYWTzUn7cf+9jWCg0gYLJmtiqv0fpj4FskVgRNVRKcOodHeG+PCs9ORSEe6N6UbGXY60F0tYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Sub26kWB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nxfwnd65; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 825091380381;
	Fri, 13 Jun 2025 17:22:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 13 Jun 2025 17:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1749849779; x=1749936179; bh=/dUvm+QPBi
	rONqJFnacqQUBmn4D84x3op95OUDuB/zo=; b=Sub26kWBv/VLu+uvK6TKXfsHXf
	NgXxX3/vq8v2dbgpq5eHbTBgp3NqEsHqkrLs07KM8Os7o5jvSiBkFBH5TwVG8JsE
	RXBfrZXvdyIox5MxFzCIEMghDAEHK27yjZ45ZnO3v09xrTDDGciYRG3X6VgWMZ4h
	MPm96Jo54QTapX0Z9FgnjdtspPcBCBNu06gLm8ToN5sn1Qg/VRfQuWH+Bq3W96/9
	TKbmh/KhTj50GHtEC4w/PhFQfE2OIIXosbZteUCFCqwqB2l5d7B2DQTM27V9CpAa
	gXaLKWw1waBk6WSdjD49KnBPWkOOkm9AjflHm7NM3/7mEWPolVRhTAGmVbNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749849779; x=1749936179; bh=/dUvm+QPBirONqJFnacqQUBmn4D84x3op95
	OUDuB/zo=; b=nxfwnd65VJubLlHa4k9VfJYgRm0LkKv26vlDgMggyD3w70bc3QR
	08ow0G6Gi/NhjP7TBCCTuQ9Q+enGqDA/LXzJJsV82SDVh9L4xC4U8K8vAApoWnma
	JgxrBNF9nh97ePn8abseDLnJkGyZ0HXu+VO3BJYlRon+zKGF4paTAKD3K/Jfbxq5
	xotqabKf4bpQkNRxqn0aLBUaAGF7sjVVvT6x5SEztLJvMGLlC3J3t/Q35iQdXryF
	CQFXWqUAMq6hLE3JXBRim7lFKvIalJlPqberYqux+LZ9BcwvQLtldAcglEyTJaaB
	8TH709h8DBASKqfNMPvMSqZEwULKR9KqG5g==
X-ME-Sender: <xms:s5ZMaNKPlWQfDUJalWaWFwJZyeuUsqIvZ4hIXeOPjtuOeeN4rqqEOA>
    <xme:s5ZMaJIEcyyY9lTc9FNg27X9bLje2_U42FXq3fC61_gFXU3KTYfP62d2tiYamCQVT
    q9uAZFP5CPcYEzYB-k>
X-ME-Received: <xmr:s5ZMaFt2DA36DDfzjLJwDI6a8nh1yR9B4w4_ZzVAWITBESVaYLu32ACyGZ_fjn6FvQGEAoKFRF6CQQ3axfiHrVTIkgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduledtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfg
    uefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmrghhrghrmhhsthhonhgvsehfsgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:s5ZMaOaSawvpPhyR-UnqwpyiGnVkWzoRzvkxmYy6ubaIfppRkPCZGg>
    <xmx:s5ZMaEb0E5_glGpjQ87G_bxZPg1THcuiLM3xfhbd5RzMUmL0JuoKCA>
    <xmx:s5ZMaCCCZA4LapFIO3kleinw0lB20NHfU3CwlJsu1uvfZ8WGvqi8gA>
    <xmx:s5ZMaCa50ZVVJfw-952PW8NmJ-v8o47Mc8zdfSw4bamUKzf7A4cJmQ>
    <xmx:s5ZMaPvyYKqQ5Aw_iz_az1pp7duzaQx2huJQc9Xa7MpgSZ_erOlgwv29>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 17:22:58 -0400 (EDT)
Date: Fri, 13 Jun 2025 14:22:39 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/12] btrfs: add REMAP chunk type
Message-ID: <20250613212239.GB3621880@zen.localdomain>
References: <20250605162345.2561026-1-maharmstone@fb.com>
 <20250605162345.2561026-3-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605162345.2561026-3-maharmstone@fb.com>

On Thu, Jun 05, 2025 at 05:23:32PM +0100, Mark Harmstone wrote:
> Add a new REMAP chunk type, which is a metadata chunk that holds the
> remap tree.
> 
> This is needed for bootstrapping purposes: the remap tree can't itself

I think it's pretty clear why, *now*, while we're thinking about it.
However, I think a longer, more detailed explanation of bootstrapping
and the constraints on the remap tree would be quite helpful.

i.e.,
Why can't it be remapped? (where do you look up the remappings for its
own blocks?!)

What if you put it in metadata BGs and made those un-relocatable (that
would contaminate too many of them?)

Why can't you make it generic metadata, then while relocating check what
tree a block is from? If remap tree, then cow it, else do the normal
remap thing. (complexity? performance?)

Since this seems to be one of the more contentious parts of the
proposal, fleshing out ALL the reasoning is helpful, IMO.

Along those lines and moving away from the exact self relocating and
bootstrapping problem details:

What are the drawbacks to a new space info? How serious are they given
that we don't expect the remap tree to be very large (probably include
your reasoned bounding estimates too...).

Are there any other space infos we have or would consider? What happens
if we move forward on plans to parallelize the system further, would
we add multiple data space infos? That might be a useful argument that
while this is the weird "4th" space info, there could also be a 5th and
6th and 7th etc.. and it's OK. I'd also be curious to get Josef's thoughts
on this, for example.

> be remapped, and must be relocated the existing way, by COWing every
> leaf. The remap tree can't go in the SYSTEM chunk as space there is
> limited, because a copy of the chunk item gets placed in the superblock.
> 
> The changes in fs/btrfs/volumes.h are because we're adding a new block
> group type bit after the profile bits, and so can no longer rely on the
> const_ilog2 trick.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/block-rsv.c            |  8 ++++++++
>  fs/btrfs/block-rsv.h            |  1 +
>  fs/btrfs/disk-io.c              |  1 +
>  fs/btrfs/fs.h                   |  2 ++
>  fs/btrfs/space-info.c           | 13 ++++++++++++-
>  fs/btrfs/sysfs.c                |  2 ++
>  fs/btrfs/tree-checker.c         |  5 +++--
>  fs/btrfs/volumes.c              |  1 +
>  fs/btrfs/volumes.h              | 11 +++++++++--
>  include/uapi/linux/btrfs_tree.h |  4 +++-
>  10 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 5ad6de738aee..2678cd3bed29 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -421,6 +421,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
>  	case BTRFS_TREE_LOG_OBJECTID:
>  		root->block_rsv = &fs_info->treelog_rsv;
>  		break;
> +	case BTRFS_REMAP_TREE_OBJECTID:
> +		root->block_rsv = &fs_info->remap_block_rsv;
> +		break;
>  	default:
>  		root->block_rsv = NULL;
>  		break;
> @@ -434,6 +437,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
>  	fs_info->chunk_block_rsv.space_info = space_info;
>  
> +	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
> +	fs_info->remap_block_rsv.space_info = space_info;
> +
>  	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>  	fs_info->global_block_rsv.space_info = space_info;
>  	fs_info->trans_block_rsv.space_info = space_info;
> @@ -460,6 +466,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
>  	WARN_ON(fs_info->chunk_block_rsv.size > 0);
>  	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
> +	WARN_ON(fs_info->remap_block_rsv.size > 0);
> +	WARN_ON(fs_info->remap_block_rsv.reserved > 0);
>  	WARN_ON(fs_info->delayed_block_rsv.size > 0);
>  	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
>  	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
> diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
> index 79ae9d05cd91..8359fb96bc3c 100644
> --- a/fs/btrfs/block-rsv.h
> +++ b/fs/btrfs/block-rsv.h
> @@ -22,6 +22,7 @@ enum btrfs_rsv_type {
>  	BTRFS_BLOCK_RSV_DELALLOC,
>  	BTRFS_BLOCK_RSV_TRANS,
>  	BTRFS_BLOCK_RSV_CHUNK,
> +	BTRFS_BLOCK_RSV_REMAP,

Why do we need a new block_rsv_type? Please include that justification
in your commit as well.

>  	BTRFS_BLOCK_RSV_DELOPS,
>  	BTRFS_BLOCK_RSV_DELREFS,
>  	BTRFS_BLOCK_RSV_TREELOG,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5a565bf96bf8..60cce96a9ec4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2830,6 +2830,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  			     BTRFS_BLOCK_RSV_GLOBAL);
>  	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
>  	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
> +	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
>  	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
>  	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
>  	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 5e48ed252fd0..07ac1a96477a 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -476,6 +476,8 @@ struct btrfs_fs_info {
>  	struct btrfs_block_rsv trans_block_rsv;
>  	/* Block reservation for chunk tree */
>  	struct btrfs_block_rsv chunk_block_rsv;
> +	/* Block reservation for remap tree */
> +	struct btrfs_block_rsv remap_block_rsv;
>  	/* Block reservation for delayed operations */
>  	struct btrfs_block_rsv delayed_block_rsv;
>  	/* Block reservation for delayed refs */
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 517916004f21..6471861c4b25 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
>  
>  	if (flags & BTRFS_BLOCK_GROUP_DATA)
>  		return BTRFS_MAX_DATA_CHUNK_SIZE;
> -	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))

What is the rationale for this sizing? Experimentation? Estimate?

>  		return SZ_32M;
>  
>  	/* Handle BTRFS_BLOCK_GROUP_METADATA */
> @@ -343,6 +343,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>  	if (mixed) {
>  		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
>  		ret = create_space_info(fs_info, flags);
> +		if (ret)
> +			goto out;
>  	} else {
>  		flags = BTRFS_BLOCK_GROUP_METADATA;
>  		ret = create_space_info(fs_info, flags);
> @@ -351,7 +353,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>  
>  		flags = BTRFS_BLOCK_GROUP_DATA;
>  		ret = create_space_info(fs_info, flags);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
> +		flags = BTRFS_BLOCK_GROUP_REMAP;
> +		ret = create_space_info(fs_info, flags);
>  	}
> +
>  out:
>  	return ret;
>  }
> @@ -590,6 +600,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
> +	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
>  }
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 831c25c2fb25..aa98d99833fd 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1985,6 +1985,8 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
>  	case BTRFS_BLOCK_GROUP_SYSTEM:
>  		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
>  		return "system";
> +	case BTRFS_BLOCK_GROUP_REMAP:
> +		return "remap";
>  	default:
>  		WARN_ON(1);
>  		return "invalid-combination";
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index a83fb828723a..0505f8d76581 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -751,13 +751,14 @@ static int check_block_group_item(struct extent_buffer *leaf,
>  	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
>  		     type != BTRFS_BLOCK_GROUP_METADATA &&
>  		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
> +		     type != BTRFS_BLOCK_GROUP_REMAP &&

We should fail if the type is REMAP and we don't have the flag.

>  		     type != (BTRFS_BLOCK_GROUP_METADATA |
>  			      BTRFS_BLOCK_GROUP_DATA))) {
>  		block_group_err(leaf, slot,
> -"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
> +"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx, 0x%llx or 0x%llx",
>  			type, hweight64(type),
>  			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
> -			BTRFS_BLOCK_GROUP_SYSTEM,
> +			BTRFS_BLOCK_GROUP_SYSTEM, BTRFS_BLOCK_GROUP_REMAP,
>  			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
>  		return -EUCLEAN;
>  	}
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3e53bde0e605..e7c467b6af46 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -234,6 +234,7 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");

This is a little confusing on the surface. I think a comment for each
like the following are merited:

/* block groups containing the remap tree */
and
/* block group that has been remapped */

>  
>  	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6d8b1f38e3ee..9fb8fe4312a5 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -59,8 +59,6 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
>   */
>  static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
>  	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
> -static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
> -	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
>  
>  /* ilog2() can handle both constants and variables */
>  #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
> @@ -82,6 +80,15 @@ enum btrfs_raid_types {
>  	BTRFS_NR_RAID_TYPES
>  };
>  
> +static_assert(BTRFS_RAID_RAID0 == 1);
> +static_assert(BTRFS_RAID_RAID1 == 2);
> +static_assert(BTRFS_RAID_DUP == 3);
> +static_assert(BTRFS_RAID_RAID10 == 4);
> +static_assert(BTRFS_RAID_RAID5 == 5);
> +static_assert(BTRFS_RAID_RAID6 == 6);
> +static_assert(BTRFS_RAID_RAID1C3 == 7);
> +static_assert(BTRFS_RAID_RAID1C4 == 8);
> +
>  /*
>   * Use sequence counter to get consistent device stat data on
>   * 32-bit processors.
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 4439d77a7252..9a36f0206d90 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -1169,12 +1169,14 @@ struct btrfs_dev_replace_item {
>  #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
>  #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
>  #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
> +#define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
>  #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
>  					 BTRFS_SPACE_INFO_GLOBAL_RSV)
>  
>  #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
>  					 BTRFS_BLOCK_GROUP_SYSTEM |  \
> -					 BTRFS_BLOCK_GROUP_METADATA)
> +					 BTRFS_BLOCK_GROUP_METADATA | \
> +					 BTRFS_BLOCK_GROUP_REMAP)
>  
>  #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
>  					 BTRFS_BLOCK_GROUP_RAID1 |   \
> -- 
> 2.49.0
> 

