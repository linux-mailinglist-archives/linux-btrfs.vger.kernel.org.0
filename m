Return-Path: <linux-btrfs+bounces-15908-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD611B1DCC7
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 19:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361D0725E91
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD943AA1;
	Thu,  7 Aug 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8UbS3fO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Emt7xCFY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8UbS3fO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Emt7xCFY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B94202F8E
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589484; cv=none; b=u73ayoElKllaconDOSLjZAdSb9viENC7UcKDblZBDFA6TmYDkRJytRqU1FQ8WDAzgWhqFeOdsb2XdDgTFa82ii3/gEvyZ6BNfHwFHJwawrRjANXyJSpdO5vfQbMCH3NZmgASJ2Zq9Btoy+7t8CB3Zys5YFwrUMllYQ+r48BRP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589484; c=relaxed/simple;
	bh=UxGaGUFZUrAbJEalpafLqM+nTsw6tr9Aji+47pjg1qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoaO1HkThqrAsiQ5qV5RNw6BR7Ep8EDM2uJ0sL8wzCp9ItGvnQldOONLhhITxM9m/uTn9dcMY9omnNbu3SkIGm7u+HJvKtT7afk7xAb9b7VdE32uqZy2EAeVkWEO62Mfog7djyxnrZBG7G2EvNUxrAJrabkK/zPSqquvPkYI52U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8UbS3fO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Emt7xCFY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8UbS3fO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Emt7xCFY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AC871F397;
	Thu,  7 Aug 2025 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754589480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFFwDrO5vroaii3stIAiriMSkKUrXCOZuXJ/XvTDu04=;
	b=c8UbS3fOSXkdBiePn/kiCra/8A403mo5ZLXkwmFwU8gOUQ1x7bFumRHsPU4qSoqBAIGQLQ
	uvwDiWZErJzHXkL2tofVGHabH4qmyZujYxenhEkZhXljq2gJ995Ky5YcD846DpYtCoukFu
	vd6S6uYd9yHfahVqPt2w263Vm+DPFqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754589480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFFwDrO5vroaii3stIAiriMSkKUrXCOZuXJ/XvTDu04=;
	b=Emt7xCFYeDPp6m7fM6TSAqRh58Y//KBzg9RHU7Rw40gda0XaAdeNnD/hlykJ0RT+SSDP4S
	FNYdUOPVi81d00Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c8UbS3fO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Emt7xCFY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754589480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFFwDrO5vroaii3stIAiriMSkKUrXCOZuXJ/XvTDu04=;
	b=c8UbS3fOSXkdBiePn/kiCra/8A403mo5ZLXkwmFwU8gOUQ1x7bFumRHsPU4qSoqBAIGQLQ
	uvwDiWZErJzHXkL2tofVGHabH4qmyZujYxenhEkZhXljq2gJ995Ky5YcD846DpYtCoukFu
	vd6S6uYd9yHfahVqPt2w263Vm+DPFqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754589480;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DFFwDrO5vroaii3stIAiriMSkKUrXCOZuXJ/XvTDu04=;
	b=Emt7xCFYeDPp6m7fM6TSAqRh58Y//KBzg9RHU7Rw40gda0XaAdeNnD/hlykJ0RT+SSDP4S
	FNYdUOPVi81d00Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D8E13969;
	Thu,  7 Aug 2025 17:58:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4yO+ASjplGhkWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 07 Aug 2025 17:58:00 +0000
Date: Thu, 7 Aug 2025 19:57:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: simplify support block size check
Message-ID: <20250807175757.GN6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2AC871F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Thu, Aug 07, 2025 at 04:31:30PM +0930, Qu Wenruo wrote:
> Currently we manually check the block size against 3 different values:
> - 4K
> - PAGE_SIZE
> - MIN_BLOCKSIZE
> 
> Those 3 values can match or differ from each other.
> 
> This makes it pretty complex to output the supported block sizes.
> 
> Considering we're going to add block size > page size support soon, this
> can make the support block size sysfs attribute much harder to
> implement.
> 
> To make it easier, extract a helper, btrfs_blocksize_support() to do a
> simple check for the block size.
> 
> Then utilize it in the two locations:
> 
> - btrfs_validate_super()
>   This is very straightforward
> 
> - supported_sectorsizes_show()
>   Iterate through all valid block sizes, and only output supported ones.
> 
>   This is to make future full range block sizes support much easier.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 17 +----------------
>  fs/btrfs/fs.h      | 29 +++++++++++++++++++++++++++++
>  fs/btrfs/sysfs.c   | 18 ++++++++++++------
>  3 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9cc14ab35297..427480a8bcf8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2442,27 +2442,12 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>  		ret = -EINVAL;
>  	}
>  
> -	/*
> -	 * We only support at most 3 sectorsizes: 4K, PAGE_SIZE, MIN_BLOCKSIZE.
> -	 *
> -	 * For 4K page sized systems with non-debug builds, all 3 matches (4K).
> -	 * For 4K page sized systems with debug builds, there are two block sizes
> -	 * supported. (4K and 2K)
> -	 *
> -	 * We can support 16K sectorsize with 64K page size without problem,
> -	 * but such sectorsize/pagesize combination doesn't make much sense.
> -	 * 4K will be our future standard, PAGE_SIZE is supported from the very
> -	 * beginning.
> -	 */
> -	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K &&
> -				       sectorsize != PAGE_SIZE &&
> -				       sectorsize != BTRFS_MIN_BLOCKSIZE)) {
> +	if (!btrfs_blocksize_supported(sectorsize)) {
>  		btrfs_err(fs_info,
>  			"sectorsize %llu not yet supported for page size %lu",
>  			sectorsize, PAGE_SIZE);
>  		ret = -EINVAL;
>  	}
> -
>  	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
>  	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
>  		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 8cc07cc70b12..4548371ca10c 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -29,6 +29,7 @@
>  #include "extent-io-tree.h"
>  #include "async-thread.h"
>  #include "block-rsv.h"
> +#include "messages.h"
>  
>  struct inode;
>  struct super_block;
> @@ -59,6 +60,8 @@ struct btrfs_space_info;
>  #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
>  #endif
>  
> +#define BTRFS_MAX_BLOCKSIZE	(SZ_64K)
> +
>  #define BTRFS_MAX_EXTENT_SIZE SZ_128M
>  
>  #define BTRFS_OLDEST_GENERATION	0ULL
> @@ -900,6 +903,32 @@ struct btrfs_fs_info {
>  #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
>  					   struct inode *: (_inode)))->root->fs_info)
>  
> +/*
> + * We support the following block size for all systems:
> + * - 4K
> + *   This is the most common block size. For PAGE SIZE > 4K cases, btrfs
> + *   goes subpage routine to support it.
> + *
> + * - PAGE_SIZE
> + *   The easily block size to support.
> + *
> + * And extra support for the following block sizes based on the kernel config:
> + *
> + * - MIN_BLOCKSIZE
> + *   This is either 4K (regular builds) or 2K (debug builds)
> + *   This allows testing subpage routines on x86_64.
> + */
> +static inline bool btrfs_blocksize_supported(u32 blocksize)

This does not need to be inline, it's used once in sysfs handler. Also
I'd suggest to rename it to btrfs_supported_blocksize() as we already
have btrfs_supported_ elsewhere.

> +{
> +	/* @blocksize should be validated first. */
> +	ASSERT(is_power_of_2(blocksize) && blocksize >= BTRFS_MIN_BLOCKSIZE &&
> +	       blocksize <= BTRFS_MAX_BLOCKSIZE);
> +
> +	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
> +		return true;
> +	return false;
> +}
> +
>  static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
>  {
>  	return mapping_gfp_constraint(mapping, ~__GFP_FS);
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 9d398f7a36ad..a3c3281a4949 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -409,13 +409,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
>  					  char *buf)
>  {
>  	ssize_t ret = 0;
> +	bool has_output = false;
>  
> -	if (BTRFS_MIN_BLOCKSIZE != SZ_4K && BTRFS_MIN_BLOCKSIZE != PAGE_SIZE)
> -		ret += sysfs_emit_at(buf, ret, "%u ", BTRFS_MIN_BLOCKSIZE);
> -	if (PAGE_SIZE > SZ_4K)
> -		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
> -	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
> -
> +	for (u32 cur = BTRFS_MIN_BLOCKSIZE; cur <= BTRFS_MAX_BLOCKSIZE;
> +	     cur <<= 1) {

"cur *= 2" reads a bit better and compiler will turn it to the shift.

> +		if (!btrfs_blocksize_supported(cur))
> +			continue;
> +		if (has_output)
> +			ret += sysfs_emit_at(buf, ret, " %u", cur);
> +		else
> +			ret += sysfs_emit_at(buf, ret, "%u", cur);
> +		has_output = true;
> +	}
> +	ret += sysfs_emit_at(buf, ret, "\n");
>  	return ret;
>  }
>  BTRFS_ATTR(static_feature, supported_sectorsizes,
> -- 
> 2.50.1
> 

