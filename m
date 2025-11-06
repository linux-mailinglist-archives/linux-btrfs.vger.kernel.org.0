Return-Path: <linux-btrfs+bounces-18759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD72EC39732
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26F274EC251
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0662C11CD;
	Thu,  6 Nov 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/hfJ4qj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ac3qd9H7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f/hfJ4qj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ac3qd9H7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70E14F70
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762415399; cv=none; b=k4xlr67n6MUMgLrkw93Fco5NROQOhREB6PWKGpqjjPBNQbdji0sLsNnO4+JwN3VJPHm40PvAetHp4GKumirzE69C2TOQAjo0w0K/aMbrDniyMlV6gPmK/tXsAB5mrj9LuAQWOfoPil23dFVrHemO6LrbG0W4zFVlex1kYNEyGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762415399; c=relaxed/simple;
	bh=HQGAzzNT4PaZ8XWCmd6n1c8Fn6rXJBG8rTFU/u2tmqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krcucY99n5+5rvCXCmBPCeTKbmRpatgg7tpq0Rsz2FYWNaTIrgGbIsYRP/ur3zDbHnM4j0qDEmjcIW5LIIeDp8/nNjew9I/7dKpC5GAV0QI2t6WkW8EMG8SUeNAZM3f6e/pvIYzt//Br3gZWd06PWjA5S7JvSd1XSRU8rJNzz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/hfJ4qj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ac3qd9H7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f/hfJ4qj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ac3qd9H7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 498901F393;
	Thu,  6 Nov 2025 07:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762415395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcyDckSOrTcJhNabj2L7iJ0d4UztOhxiRaZsZMlfbsE=;
	b=f/hfJ4qj5i+cg4nUG6CmUsGgjnBmu6LpB3aGyDcdirLavHdU4rPXpRQH8eYOlkzGFvNrye
	hIxVC7A+IiwTzYEuOHSIOVu43jL7uEa5fBM3BGZuGDpdF5TQatpDLsFaK/kuIcNsvZ2BjJ
	Zz6lcbQolJfx2Xk4Yy4W/GfNFl/lfkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762415395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcyDckSOrTcJhNabj2L7iJ0d4UztOhxiRaZsZMlfbsE=;
	b=Ac3qd9H7ljBoS5OVx1U3SFukY5EJL4rK6nbwCFpgyJmhiQPk6S0PboEHTiq8WwYRkSiy6c
	NLQX0U0R9jybSDBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="f/hfJ4qj";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ac3qd9H7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762415395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcyDckSOrTcJhNabj2L7iJ0d4UztOhxiRaZsZMlfbsE=;
	b=f/hfJ4qj5i+cg4nUG6CmUsGgjnBmu6LpB3aGyDcdirLavHdU4rPXpRQH8eYOlkzGFvNrye
	hIxVC7A+IiwTzYEuOHSIOVu43jL7uEa5fBM3BGZuGDpdF5TQatpDLsFaK/kuIcNsvZ2BjJ
	Zz6lcbQolJfx2Xk4Yy4W/GfNFl/lfkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762415395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IcyDckSOrTcJhNabj2L7iJ0d4UztOhxiRaZsZMlfbsE=;
	b=Ac3qd9H7ljBoS5OVx1U3SFukY5EJL4rK6nbwCFpgyJmhiQPk6S0PboEHTiq8WwYRkSiy6c
	NLQX0U0R9jybSDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 222D6139A9;
	Thu,  6 Nov 2025 07:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ALOByNTDGmbMQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Nov 2025 07:49:55 +0000
Date: Thu, 6 Nov 2025 08:49:53 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Calvin Owens <calvin@wbinvd.org>
Subject: Re: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
Message-ID: <20251106074953.GT13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 498901F393
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Nov 06, 2025 at 08:15:03AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a report that memory allocation failed for btrfs_bio::csum
> during a large read:
> 
>  b2sum: page allocation failure: order:4, mode:0x40c40(GFP_NOFS|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
>  CPU: 0 UID: 0 PID: 416120 Comm: b2sum Tainted: G        W           6.17.0 #1 NONE
>  Tainted: [W]=WARN
>  Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
>  Call trace:
>   show_stack+0x18/0x30 (C)
>   dump_stack_lvl+0x5c/0x7c
>   dump_stack+0x18/0x24
>   warn_alloc+0xec/0x184
>   __alloc_pages_slowpath.constprop.0+0x21c/0x730
>   __alloc_frozen_pages_noprof+0x230/0x260
>   ___kmalloc_large_node+0xd4/0xf0
>   __kmalloc_noprof+0x1c8/0x260
>   btrfs_lookup_bio_sums+0x214/0x278
>   btrfs_submit_chunk+0xf0/0x3c0
>   btrfs_submit_bbio+0x2c/0x4c
>   submit_one_bio+0x50/0xac
>   submit_extent_folio+0x13c/0x340
>   btrfs_do_readpage+0x4b0/0x7a0
>   btrfs_readahead+0x184/0x254
>   read_pages+0x58/0x260
>   page_cache_ra_unbounded+0x170/0x24c
>   page_cache_ra_order+0x360/0x3bc
>   page_cache_async_ra+0x1a4/0x1d4
>   filemap_readahead.isra.0+0x44/0x74
>   filemap_get_pages+0x2b4/0x3b4
>   filemap_read+0xc4/0x3bc
>   btrfs_file_read_iter+0x70/0x7c
>   vfs_read+0x1ec/0x2c0
>   ksys_read+0x4c/0xe0
>   __arm64_sys_read+0x18/0x24
>   el0_svc_common.constprop.0+0x5c/0x130
>   do_el0_svc+0x1c/0x30
>   el0_svc+0x30/0xa0
>   el0t_64_sync_handler+0xa0/0xe4
>   el0t_64_sync+0x198/0x19c
> 
> [CAUSE]
> Btrfs needs to allocate memory for btrfs_bio::csum for large reads, so
> that we can later verify the contents of the read.
> 
> However nowadays a read bio can easily go beyond BIO_MAX_VECS *
> PAGE_SIZE (which is 1M for 4K page sizes), due to the multi-page bvec
> that one bvec can have more than one pages, as long as the pages are
> physically adjacent.
> 
> This will become more common when the large folio support is moved out
> of experimental features.
> 
> In the above case, a read larger than 4MiB with SHA256 checksum (32
> bytes for each 4K block) will be able to trigger a order 4 allocation.

Can we possibly avoid allocating order 4 and keep it only up to the
costly order 3? btrfs_submit_chunk() already splits the bio and is the
only caller of btrfs_lookup_bio_sums(). The calculation could take into
account csum size and page size so it's not splitting unnecessarily.

> 
> The order 4 is larger than PAGE_ALLOC_COSTLY_ORDER (3), thus without
> extra flags such allocation will not retry.
> 
> And if the system has very small amount of memory (e.g. RPI4 with low
> memory spec) or VMs with small vRAM, or the memory is heavily
> fragmented, such allocation will fail and cause the above warning.
> 
> [FIX]
> Although btrfs is handling the memory allocation failure correctly, we
> do not really need those physically contiguous memory just to restore
> our checksum.
> 
> In fact btrfs_csum_one_bio() is already using kvzallocated memory to
> reduce the memory pressure.

Reading the commit a3d46aea46f99d134b4e07, kvzalloc was also a
workaround and it kept the code simple but relying on the virtual page
mappings. I'd consider the bio paths critical enough so there are
fallbacks that work with heavily fragmented memory where we can't get a
contiguous memory or the mappings.

> So follow the step to use kvmalloc() for btrfs_bio::csum.

This is ok for now and that it worked for btrfs_csum_one_bio() so far
sounds promising.

Reviewed-by: David Sterba <dsterba@suse.com>

> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Link: https://lore.kernel.org/linux-btrfs/20251105180054.511528-1-calvin@wbinvd.org/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c       | 2 +-
>  fs/btrfs/file-item.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8af2b68c2d53..bb7ef4c67911 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -293,7 +293,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
>  		offset += sectorsize;
>  	}
>  	if (bbio->csum != bbio->csum_inline)
> -		kfree(bbio->csum);
> +		kvfree(bbio->csum);
>  
>  	if (fbio)
>  		btrfs_repair_done(fbio);
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 4b7c40f05e8f..bb8eb43334f6 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -373,7 +373,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>  		return -ENOMEM;
>  
>  	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
> -		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
> +		bbio->csum = kvmalloc(nblocks * csum_size, GFP_NOFS);
>  		if (!bbio->csum)
>  			return -ENOMEM;
>  	} else {
> @@ -439,7 +439,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>  		if (count < 0) {
>  			ret = count;
>  			if (bbio->csum != bbio->csum_inline)
> -				kfree(bbio->csum);
> +				kvfree(bbio->csum);
>  			bbio->csum = NULL;
>  			break;
>  		}
> -- 
> 2.51.2
> 

