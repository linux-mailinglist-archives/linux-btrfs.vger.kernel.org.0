Return-Path: <linux-btrfs+bounces-18074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AFDBF2BAE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C5A4F3CC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFE3321A1;
	Mon, 20 Oct 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="ZES42ia3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qyg/CIna"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836311A76DE
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981761; cv=none; b=Gj8c03b5s+TSyrEVhBlssuRgFj1PYA1AJ+CeGKvclEilxxGNIE5PMCtj6Jheih099/4277z6YuDEAlXbvQAYQc2OZYHmWpv6XO4JH6iieQltVOM8bJTaOueFDQNU+C+xCnAqdo/jP0KqiHsH+tc/8IMs1A4FfSZDlT8DrIMma/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981761; c=relaxed/simple;
	bh=55G2l+tW1aCjOm2TyKvqlLxS8o1fbv6MYx934j9+fmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KndJujcUuYmj/CvXkxmPtvOZRKonodLkSUbXGlqOLv+MZbazqPXikEAvaY5wFpQq2JTurNcRHlaW6mD9mCUM6ZQ2HBgLJw493Yv4ZuWv6hr/iuKJyrmhvzuu+kr1n8bRLCYtM2ljSJdl6pB8squNJPoskFSKsu91arZi7zvRnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=ZES42ia3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qyg/CIna; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E4E9E7A0177;
	Mon, 20 Oct 2025 13:35:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Oct 2025 13:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1760981755; x=1761068155; bh=5Yw0WIzWqg
	imiIvBjsku5PI2hmLS9r/9CuNdtNZPOOg=; b=ZES42ia35t4WPjYLmx/r1wY8AR
	BK0hMei5Oq/tT/DgjiCi2hrQlMx/iwggwTvPfb1NgkQGmc3NiLbGZHCfomY8wiJK
	bqglCIyFOvJMpilqlMN7Sv+5odNO9f41qubeueBc90/GPCnahuhiiVOmwn6V4pfW
	WJX3GihvzPi9Gxkm0FiM8YWwQK+o9pZwEVKSPZPoQ3GcmowNqajz7q/QlBY+6RPi
	yumK6Tnnb44IDHKLCI/ZLACj8riE1EamJHAKyjqK5q4mSwJkkqeRArG9gLbmBUAz
	iU2hQFcIoCwRIMhX9a+AUnr4jXqqmhalB0hwzZFnekeEsfOnZzLnhWPaIPhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760981755; x=1761068155; bh=5Yw0WIzWqgimiIvBjsku5PI2hmLS9r/9CuN
	dtNZPOOg=; b=qyg/CIna2OEIUPxzC9BNrNZA+zbfCK/TFzVIQrOwRlqn45qpA6k
	ljEZrikIBrIjJEBP5z7SwUR4c8uWHqfrxoOw2nV3hlTcXrJBDCtvp6+GLI2BzQMG
	gfypC3x0ngtwnRQPapqBk9UmSZYp6UgArRLJashBOkMvDwPYu0hChqo8vQe3BJip
	3ImqfHBxuHaqusDWzyxVDpsteHxM4UDClqRuTKvAUkeq2j/5Wf2BePAeOlEFMXnX
	yRXw9m1GbwkMiy4XhE3b6sOZpG6T3i+Tr55xsAJNsfzp7Ba2UTIXYVA73ccF8KW/
	jYf0vWAvrNC12hOvquCo7M5nX/iW27/8dFg==
X-ME-Sender: <xms:-3L2aIEpsLzF7HRdpH70Ep2It2_66Pj3QWSdXY4WSslAtvKPG0Mcrw>
    <xme:-3L2aHUxy5UgSEW9KQpLlZpaSo___qvBFsCUSfiTdzq_DRqdUsXJ7OKiUpDyzyHGn
    y6L8zzwgKmBy7CQG5injD35zUYxrogcyvRyKfgwTuoVQx8ZpOFUBw>
X-ME-Received: <xmr:-3L2aPwiGJjvwKQFdBJfqgQAW1yHHEf_3L7E5ngwkuCUsvYOCY7VEiVyqJqB-YEG7pcGlGhFLX5uOLWRjbVE_M69Ruw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgrrhhksehhrghrmhhsthhonhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsg
    htrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-3L2aFOW32GfImwbc21jjPu0XrxaZWwAS7HHakL-0J3DCUafe96IfA>
    <xmx:-3L2aA4RjAWFjr_zmQWyXLM8UU_UocQV2Nm82szDPVvHubiF8rwkZw>
    <xmx:-3L2aGPCda5Wy8s7ETNTtyvo8C4aSPkbV5HfN4rmoWjS4jXwhom-eg>
    <xmx:-3L2aOloof0tJqyEdpUfF65-HckamvULvrOHqqP_bVsT1Qvk087s-Q>
    <xmx:-3L2aNZgBQE3oMbiLnuwaK22ebgYfcbn59xmCe5MZN0ObYWtrSFcFJMp>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Oct 2025 13:35:54 -0400 (EDT)
Date: Mon, 20 Oct 2025 10:35:24 -0700
From: Boris Burkov <boris@bur.io>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 02/17] btrfs: add REMAP chunk type
Message-ID: <20251020173524.GA696792@zen.localdomain>
References: <20251009112814.13942-1-mark@harmstone.com>
 <20251009112814.13942-3-mark@harmstone.com>
 <20251015033707.GD1702774@zen.localdomain>
 <7a6877f7-371b-4421-a1c7-91bf3a46e91d@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a6877f7-371b-4421-a1c7-91bf3a46e91d@harmstone.com>

On Mon, Oct 20, 2025 at 10:58:55AM +0100, Mark Harmstone wrote:
> Thanks Boris. Have a look at the third paragraph of the commit message, I
> explain the volumes.h changes there.
> 

Well, great job reading by me. *facepalm*
Sorry about that..

> On 15/10/2025 4.37 am, Boris Burkov wrote:
> > On Thu, Oct 09, 2025 at 12:27:57PM +0100, Mark Harmstone wrote:
> > > Add a new REMAP chunk type, which is a metadata chunk that holds the
> > > remap tree.
> > > 
> > > This is needed for bootstrapping purposes: the remap tree can't itself
> > > be remapped, and must be relocated the existing way, by COWing every
> > > leaf. The remap tree can't go in the SYSTEM chunk as space there is
> > > limited, because a copy of the chunk item gets placed in the superblock.
> > > 
> > > The changes in fs/btrfs/volumes.h are because we're adding a new block
> > > group type bit after the profile bits, and so can no longer rely on the
> > > const_ilog2 trick.
> > > 
> > > The sizing to 32MB per chunk, matching the SYSTEM chunk, is an estimate
> > > here, we can adjust it later if it proves to be too big or too small.
> > > This works out to be ~500,000 remap items, which for a 4KB block size
> > > covers ~2GB of remapped data in the worst case and ~500TB in the best case.
> > > 
> > 
> > Asked a relatively inconsequential question about static asserts in
> > volumes.h. Otherwise,
> > 
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > 
> > > Signed-off-by: Mark Harmstone <mark@harmstone.com>
> > > ---
> > >   fs/btrfs/block-rsv.c            |  8 ++++++++
> > >   fs/btrfs/block-rsv.h            |  1 +
> > >   fs/btrfs/disk-io.c              |  1 +
> > >   fs/btrfs/fs.h                   |  2 ++
> > >   fs/btrfs/space-info.c           | 13 ++++++++++++-
> > >   fs/btrfs/sysfs.c                |  2 ++
> > >   fs/btrfs/tree-checker.c         | 13 +++++++++++--
> > >   fs/btrfs/volumes.c              |  3 +++
> > >   fs/btrfs/volumes.h              | 11 +++++++++--
> > >   include/uapi/linux/btrfs_tree.h |  4 +++-
> > >   10 files changed, 52 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> > > index 5ad6de738aee..2678cd3bed29 100644
> > > --- a/fs/btrfs/block-rsv.c
> > > +++ b/fs/btrfs/block-rsv.c
> > > @@ -421,6 +421,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
> > >   	case BTRFS_TREE_LOG_OBJECTID:
> > >   		root->block_rsv = &fs_info->treelog_rsv;
> > >   		break;
> > > +	case BTRFS_REMAP_TREE_OBJECTID:
> > > +		root->block_rsv = &fs_info->remap_block_rsv;
> > > +		break;
> > >   	default:
> > >   		root->block_rsv = NULL;
> > >   		break;
> > > @@ -434,6 +437,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
> > >   	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
> > >   	fs_info->chunk_block_rsv.space_info = space_info;
> > > +	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
> > > +	fs_info->remap_block_rsv.space_info = space_info;
> > > +
> > >   	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
> > >   	fs_info->global_block_rsv.space_info = space_info;
> > >   	fs_info->trans_block_rsv.space_info = space_info;
> > > @@ -460,6 +466,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
> > >   	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
> > >   	WARN_ON(fs_info->chunk_block_rsv.size > 0);
> > >   	WARN_ON(fs_info->chunk_block_rsv.reserved > 0);
> > > +	WARN_ON(fs_info->remap_block_rsv.size > 0);
> > > +	WARN_ON(fs_info->remap_block_rsv.reserved > 0);
> > >   	WARN_ON(fs_info->delayed_block_rsv.size > 0);
> > >   	WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
> > >   	WARN_ON(fs_info->delayed_refs_rsv.reserved > 0);
> > > diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
> > > index 79ae9d05cd91..8359fb96bc3c 100644
> > > --- a/fs/btrfs/block-rsv.h
> > > +++ b/fs/btrfs/block-rsv.h
> > > @@ -22,6 +22,7 @@ enum btrfs_rsv_type {
> > >   	BTRFS_BLOCK_RSV_DELALLOC,
> > >   	BTRFS_BLOCK_RSV_TRANS,
> > >   	BTRFS_BLOCK_RSV_CHUNK,
> > > +	BTRFS_BLOCK_RSV_REMAP,
> > >   	BTRFS_BLOCK_RSV_DELOPS,
> > >   	BTRFS_BLOCK_RSV_DELREFS,
> > >   	BTRFS_BLOCK_RSV_TREELOG,
> > > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > > index f475fb2272ac..102e5e0ad10c 100644
> > > --- a/fs/btrfs/disk-io.c
> > > +++ b/fs/btrfs/disk-io.c
> > > @@ -2815,6 +2815,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
> > >   			     BTRFS_BLOCK_RSV_GLOBAL);
> > >   	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
> > >   	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
> > > +	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
> > >   	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
> > >   	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
> > >   	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
> > > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > > index 814bbc9417d2..c4dba7e7ce5a 100644
> > > --- a/fs/btrfs/fs.h
> > > +++ b/fs/btrfs/fs.h
> > > @@ -485,6 +485,8 @@ struct btrfs_fs_info {
> > >   	struct btrfs_block_rsv trans_block_rsv;
> > >   	/* Block reservation for chunk tree */
> > >   	struct btrfs_block_rsv chunk_block_rsv;
> > > +	/* Block reservation for remap tree */
> > > +	struct btrfs_block_rsv remap_block_rsv;
> > >   	/* Block reservation for delayed operations */
> > >   	struct btrfs_block_rsv delayed_block_rsv;
> > >   	/* Block reservation for delayed refs */
> > > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > > index 04a07d6f8537..22bc95f33a6f 100644
> > > --- a/fs/btrfs/space-info.c
> > > +++ b/fs/btrfs/space-info.c
> > > @@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
> > >   	if (flags & BTRFS_BLOCK_GROUP_DATA)
> > >   		return BTRFS_MAX_DATA_CHUNK_SIZE;
> > > -	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> > > +	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
> > >   		return SZ_32M;
> > >   	/* Handle BTRFS_BLOCK_GROUP_METADATA */
> > > @@ -343,6 +343,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
> > >   	if (mixed) {
> > >   		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
> > >   		ret = create_space_info(fs_info, flags);
> > > +		if (ret)
> > > +			goto out;
> > >   	} else {
> > >   		flags = BTRFS_BLOCK_GROUP_METADATA;
> > >   		ret = create_space_info(fs_info, flags);
> > > @@ -351,7 +353,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
> > >   		flags = BTRFS_BLOCK_GROUP_DATA;
> > >   		ret = create_space_info(fs_info, flags);
> > > +		if (ret)
> > > +			goto out;
> > > +	}
> > > +
> > > +	if (features & BTRFS_FEATURE_INCOMPAT_REMAP_TREE) {
> > > +		flags = BTRFS_BLOCK_GROUP_REMAP;
> > > +		ret = create_space_info(fs_info, flags);
> > >   	}
> > > +
> > >   out:
> > >   	return ret;
> > >   }
> > > @@ -590,6 +600,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
> > >   	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
> > >   	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
> > >   	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
> > > +	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
> > >   	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
> > >   	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
> > >   }
> > > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > > index 857d2772db1c..f942fde1d936 100644
> > > --- a/fs/btrfs/sysfs.c
> > > +++ b/fs/btrfs/sysfs.c
> > > @@ -1973,6 +1973,8 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
> > >   	case BTRFS_BLOCK_GROUP_SYSTEM:
> > >   		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
> > >   		return "system";
> > > +	case BTRFS_BLOCK_GROUP_REMAP:
> > > +		return "remap";
> > >   	default:
> > >   		WARN_ON(1);
> > >   		return "invalid-combination";
> > > diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> > > index 9c03aeb6f2c7..62f35338a555 100644
> > > --- a/fs/btrfs/tree-checker.c
> > > +++ b/fs/btrfs/tree-checker.c
> > > @@ -748,17 +748,26 @@ static int check_block_group_item(struct extent_buffer *leaf,
> > >   		return -EUCLEAN;
> > >   	}
> > > +	if (flags & BTRFS_BLOCK_GROUP_REMAP &&
> > > +		!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> > > +		block_group_err(leaf, slot,
> > > +"invalid flags, have 0x%llx (REMAP flag set) but no remap-tree incompat flag",
> > > +				flags);
> > > +		return -EUCLEAN;
> > > +	}
> > > +
> > >   	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
> > >   	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
> > >   		     type != BTRFS_BLOCK_GROUP_METADATA &&
> > >   		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
> > > +		     type != BTRFS_BLOCK_GROUP_REMAP &&
> > >   		     type != (BTRFS_BLOCK_GROUP_METADATA |
> > >   			      BTRFS_BLOCK_GROUP_DATA))) {
> > >   		block_group_err(leaf, slot,
> > > -"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx or 0x%llx",
> > > +"invalid type, have 0x%llx (%lu bits set) expect either 0x%llx, 0x%llx, 0x%llx, 0x%llx or 0x%llx",
> > >   			type, hweight64(type),
> > >   			BTRFS_BLOCK_GROUP_DATA, BTRFS_BLOCK_GROUP_METADATA,
> > > -			BTRFS_BLOCK_GROUP_SYSTEM,
> > > +			BTRFS_BLOCK_GROUP_SYSTEM, BTRFS_BLOCK_GROUP_REMAP,
> > >   			BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA);
> > >   		return -EUCLEAN;
> > >   	}
> > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > index 2e144ebd56ac..e14b86e2996b 100644
> > > --- a/fs/btrfs/volumes.c
> > > +++ b/fs/btrfs/volumes.c
> > > @@ -231,6 +231,9 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> > > +	/* block groups containing the remap tree */
> > > +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
> > > +	/* block group that has been remapped */
> > >   	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
> > >   	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
> > > diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> > > index 2cbf8080eade..b0fa8eb38060 100644
> > > --- a/fs/btrfs/volumes.h
> > > +++ b/fs/btrfs/volumes.h
> > > @@ -58,8 +58,6 @@ static_assert(const_ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
> > >    */
> > >   static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
> > >   	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
> > > -static_assert(const_ilog2(BTRFS_BLOCK_GROUP_RAID0) >
> > > -	      ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
> > >   /* ilog2() can handle both constants and variables */
> > >   #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
> > > @@ -81,6 +79,15 @@ enum btrfs_raid_types {
> > >   	BTRFS_NR_RAID_TYPES
> > >   };
> > > +static_assert(BTRFS_RAID_RAID0 == 1);
> > > +static_assert(BTRFS_RAID_RAID1 == 2);
> > > +static_assert(BTRFS_RAID_DUP == 3);
> > > +static_assert(BTRFS_RAID_RAID10 == 4);
> > > +static_assert(BTRFS_RAID_RAID5 == 5);
> > > +static_assert(BTRFS_RAID_RAID6 == 6);
> > > +static_assert(BTRFS_RAID_RAID1C3 == 7);
> > > +static_assert(BTRFS_RAID_RAID1C4 == 8);
> > > +
> > 
> > What is the significance of these static_assert changes?
> > 
> > >   /*
> > >    * Use sequence counter to get consistent device stat data on
> > >    * 32-bit processors.
> > > diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> > > index 4439d77a7252..9a36f0206d90 100644
> > > --- a/include/uapi/linux/btrfs_tree.h
> > > +++ b/include/uapi/linux/btrfs_tree.h
> > > @@ -1169,12 +1169,14 @@ struct btrfs_dev_replace_item {
> > >   #define BTRFS_BLOCK_GROUP_RAID1C3       (1ULL << 9)
> > >   #define BTRFS_BLOCK_GROUP_RAID1C4       (1ULL << 10)
> > >   #define BTRFS_BLOCK_GROUP_REMAPPED      (1ULL << 11)
> > > +#define BTRFS_BLOCK_GROUP_REMAP         (1ULL << 12)
> > >   #define BTRFS_BLOCK_GROUP_RESERVED	(BTRFS_AVAIL_ALLOC_BIT_SINGLE | \
> > >   					 BTRFS_SPACE_INFO_GLOBAL_RSV)
> > >   #define BTRFS_BLOCK_GROUP_TYPE_MASK	(BTRFS_BLOCK_GROUP_DATA |    \
> > >   					 BTRFS_BLOCK_GROUP_SYSTEM |  \
> > > -					 BTRFS_BLOCK_GROUP_METADATA)
> > > +					 BTRFS_BLOCK_GROUP_METADATA | \
> > > +					 BTRFS_BLOCK_GROUP_REMAP)
> > >   #define BTRFS_BLOCK_GROUP_PROFILE_MASK	(BTRFS_BLOCK_GROUP_RAID0 |   \
> > >   					 BTRFS_BLOCK_GROUP_RAID1 |   \
> > > -- 
> > > 2.49.1
> > > 
> 

