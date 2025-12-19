Return-Path: <linux-btrfs+bounces-19877-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9566CCCE237
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 02:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2D0B301515F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954022D7A9;
	Fri, 19 Dec 2025 01:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4357tle";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d/XsuaLq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T/IdCYTj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="//0yl/wt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02C419AD5C
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766107648; cv=none; b=qwR88PCMDqT33z8up5+R0XDuSGE2J5RXrHiq6D6DRtgQ6SN8opVmhc2UfvJY6h7o6GyCvkCEeCjqHQvQfzjHHQ3aLGldr6QLprdtT0bZAzW+jaLba9k3ICPEo9u3ctYyizYqQ7Y9iyW2ryKj9fr7nsKPvdbXjlnTgJwR34+ByqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766107648; c=relaxed/simple;
	bh=n4tyWtudaMrO2z2In0DEtYDsTBSE6zhYRVvqOmttkc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LezDNjWnhLMc1EFSzqS6u779lxxD/RVi6blfxNh2VziAA9ADw0KC+SNjqVrPlEWxxrkPMPf6RTfzjyEvx/Y09uG2cQYNpHY+5bNsV7c9y3+6lqkS2uNoXVdEjO6iBNVUXF7WWBFQ/08WX3+I3T4cYwYPRKmMpBONW9gyrDBPFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4357tle; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d/XsuaLq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T/IdCYTj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=//0yl/wt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5E7033809;
	Fri, 19 Dec 2025 01:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766107643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYge3nEPPan3RTUBPeFXHqdRGoJ6itYWHl05eyUXcgY=;
	b=c4357tlekIv1cJXt4CTJYlX8WD8P+ARY8G1IAvEnsv4ywPbx+HRrQnG+4iGl/iFVNGYZ5G
	Kz4v8IibRGRLt3eRHgr7buEIh6UGxlKxfvQX4gzLQZQV0Z/y+yq4uLDo2ULsyWgrEwB5Z7
	l4jtqQZTK2dG4cm7pozkKRY+MUqP0gI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766107643;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYge3nEPPan3RTUBPeFXHqdRGoJ6itYWHl05eyUXcgY=;
	b=d/XsuaLq9UrDHFq5PPVtbtBzK9g7MRJf5HBeLsJErXIgYdUiVh9y1II6++5oFiHFgrCF5p
	KTqqT5MgyhRp4+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766107641;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYge3nEPPan3RTUBPeFXHqdRGoJ6itYWHl05eyUXcgY=;
	b=T/IdCYTjMVpr7mrKq0wdK5m27WlDZTGxa/H30c75sNF+oAnrWFkASVb8GMTLYIzV+PcxqD
	tTQ73UkHmtZ9x0lwbu+WrHeifdZ7yUBgOWK4+//t8SL2vvpQy3R7U8QiK1LjXKhPIvj10D
	S7q940G2e1aRWw+x5IgjMb14LhLFlCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766107641;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SYge3nEPPan3RTUBPeFXHqdRGoJ6itYWHl05eyUXcgY=;
	b=//0yl/wtew/5w1f9BBOunoZXWRP+4HLli0A+5PRe813sYCDjUiqxoeA0PH66dsViLE7zZP
	BwTf0575hxCGD4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B12B93EA63;
	Fri, 19 Dec 2025 01:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V2+oKvmpRGlZMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 19 Dec 2025 01:27:21 +0000
Date: Fri, 19 Dec 2025 02:27:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v7 02/16] btrfs: add REMAP chunk type
Message-ID: <20251219012712.GW3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251124185335.16556-1-mark@harmstone.com>
 <20251124185335.16556-3-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124185335.16556-3-mark@harmstone.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.94
X-Spam-Level: 
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.14)[-0.686];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,harmstone.com:email,bur.io:email,suse.cz:replyto];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,harmstone.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Mon, Nov 24, 2025 at 06:52:54PM +0000, Mark Harmstone wrote:
> Add a new REMAP chunk type, which is a metadata chunk that holds the
> remap tree.
> 
> This is needed for bootstrapping purposes: the remap tree can't itself
> be remapped, and must be relocated the existing way, by COWing every
> leaf. The remap tree can't go in the SYSTEM chunk as space there is
> limited, because a copy of the chunk item gets placed in the superblock.
> 
> The changes in fs/btrfs/volumes.h are because we're adding a new block
> group type bit after the profile bits, and so can no longer rely on the
> const_ilog2 trick.
> 
> The sizing to 32MB per chunk, matching the SYSTEM chunk, is an estimate
> here, we can adjust it later if it proves to be too big or too small.
> This works out to be ~500,000 remap items, which for a 4KB block size
> covers ~2GB of remapped data in the worst case and ~500TB in the best case.
> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-rsv.c            |  8 ++++++++
>  fs/btrfs/block-rsv.h            |  1 +
>  fs/btrfs/disk-io.c              |  1 +
>  fs/btrfs/fs.h                   |  2 ++
>  fs/btrfs/space-info.c           | 13 ++++++++++++-
>  fs/btrfs/sysfs.c                |  2 ++
>  fs/btrfs/tree-checker.c         | 13 +++++++++++--
>  fs/btrfs/volumes.c              |  3 +++
>  fs/btrfs/volumes.h              | 10 +++++++++-
>  include/uapi/linux/btrfs_tree.h |  4 +++-
>  10 files changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 96cf7a162987..71bcaa6fa7ee 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -419,6 +419,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
>  	case BTRFS_TREE_LOG_OBJECTID:
>  		root->block_rsv = &fs_info->treelog_rsv;
>  		break;
> +	case BTRFS_REMAP_TREE_OBJECTID:
> +		root->block_rsv = &fs_info->remap_block_rsv;
> +		break;
>  	default:
>  		root->block_rsv = NULL;
>  		break;
> @@ -432,6 +435,9 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
>  	fs_info->chunk_block_rsv.space_info = space_info;
>  
> +	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_REMAP);
> +	fs_info->remap_block_rsv.space_info = space_info;
> +
>  	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
>  	fs_info->global_block_rsv.space_info = space_info;
>  	fs_info->trans_block_rsv.space_info = space_info;
> @@ -458,6 +464,8 @@ void btrfs_release_global_block_rsv(struct btrfs_fs_info *fs_info)
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
>  	BTRFS_BLOCK_RSV_DELOPS,
>  	BTRFS_BLOCK_RSV_DELREFS,
>  	BTRFS_BLOCK_RSV_TREELOG,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 89149fac804c..6f27bbf8f887 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2806,6 +2806,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  			     BTRFS_BLOCK_RSV_GLOBAL);
>  	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
>  	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
> +	btrfs_init_block_rsv(&fs_info->remap_block_rsv, BTRFS_BLOCK_RSV_REMAP);
>  	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
>  	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
>  	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 3c7eeaefa7d5..2d9dc32c7af9 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -499,6 +499,8 @@ struct btrfs_fs_info {
>  	struct btrfs_block_rsv trans_block_rsv;
>  	/* Block reservation for chunk tree */
>  	struct btrfs_block_rsv chunk_block_rsv;
> +	/* Block reservation for remap tree */

In new code please follow the comment style which should be a full
sentece with "." at the end. This is in many other places, please try to
fix them all.

> +	struct btrfs_block_rsv remap_block_rsv;
>  	/* Block reservation for delayed operations */
>  	struct btrfs_block_rsv delayed_block_rsv;
>  	/* Block reservation for delayed refs */
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 6babbe333741..8e040dcea64a 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -215,7 +215,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
>  
>  	if (flags & BTRFS_BLOCK_GROUP_DATA)
>  		return BTRFS_MAX_DATA_CHUNK_SIZE;
> -	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
> +	else if (flags & (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_REMAP))
>  		return SZ_32M;
>  
>  	/* Handle BTRFS_BLOCK_GROUP_METADATA */
> @@ -344,6 +344,8 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
>  	if (mixed) {
>  		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
>  		ret = create_space_info(fs_info, flags);
> +		if (ret)
> +			goto out;
>  	} else {
>  		flags = BTRFS_BLOCK_GROUP_METADATA;
>  		ret = create_space_info(fs_info, flags);
> @@ -352,7 +354,15 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
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
> @@ -623,6 +633,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
>  	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, chunk_block_rsv);
> +	DUMP_BLOCK_RSV(fs_info, remap_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
>  }
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index e095936c2389..ff7f79a3c3e7 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -2026,6 +2026,8 @@ static const char *alloc_name(struct btrfs_space_info *space_info)
>  	case BTRFS_BLOCK_GROUP_SYSTEM:
>  		ASSERT(space_info->subgroup_id == BTRFS_SUB_GROUP_PRIMARY);
>  		return "system";
> +	case BTRFS_BLOCK_GROUP_REMAP:
> +		return "remap";
>  	default:
>  		WARN_ON(1);
>  		return "invalid-combination";
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index aedc208a95b8..21bf57e81e1a 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -748,17 +748,26 @@ static int check_block_group_item(struct extent_buffer *leaf,
>  		return -EUCLEAN;
>  	}
>  
> +	if (flags & BTRFS_BLOCK_GROUP_REMAP &&
> +		!btrfs_fs_incompat(fs_info, REMAP_TREE)) {
> +		block_group_err(leaf, slot,
> +"invalid flags, have 0x%llx (REMAP flag set) but no remap-tree incompat flag",
> +				flags);
> +		return -EUCLEAN;

Statement blocks that lead to EUCLEAN or EIO should have unlikely() in
the condition.

> +	}
> +
>  	type = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
>  	if (unlikely(type != BTRFS_BLOCK_GROUP_DATA &&
>  		     type != BTRFS_BLOCK_GROUP_METADATA &&
>  		     type != BTRFS_BLOCK_GROUP_SYSTEM &&
> +		     type != BTRFS_BLOCK_GROUP_REMAP &&
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
> index 193cbb634ba3..c036d341f5c2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -231,6 +231,9 @@ void btrfs_describe_block_groups(u64 bg_flags, char *buf, u32 size_buf)
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_DATA, "data");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_SYSTEM, "system");
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_METADATA, "metadata");
> +	/* block groups containing the remap tree */

	/* Block groups containing the remap tree. */
etc

> +	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAP, "remap");
> +	/* block group that has been remapped */
>  	DESCRIBE_FLAG(BTRFS_BLOCK_GROUP_REMAPPED, "remapped");
>  
>  	DESCRIBE_FLAG(BTRFS_AVAIL_ALLOC_BIT_SINGLE, "single");
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 34b854c1a303..4117fabb248b 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -58,7 +58,6 @@ static_assert(ilog2(BTRFS_STRIPE_LEN) == BTRFS_STRIPE_LEN_SHIFT);
>   */
>  static_assert(const_ffs(BTRFS_BLOCK_GROUP_RAID0) <
>  	      const_ffs(BTRFS_BLOCK_GROUP_PROFILE_MASK & ~BTRFS_BLOCK_GROUP_RAID0));
> -static_assert(ilog2(BTRFS_BLOCK_GROUP_RAID0) > ilog2(BTRFS_BLOCK_GROUP_TYPE_MASK));
>  
>  /* ilog2() can handle both constants and variables */
>  #define BTRFS_BG_FLAG_TO_INDEX(profile)					\
> @@ -80,6 +79,15 @@ enum btrfs_raid_types {
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

Ok so I must have missed something about the block groups as there are
'remap' and 'remapped' this is going to be confusing. Is it possible to
pick better names?

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
> 2.51.0
> 

