Return-Path: <linux-btrfs+bounces-11940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47652A49C23
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94CC57A42EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C126FDB3;
	Fri, 28 Feb 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yse72wvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6dIxHi7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yse72wvw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G6dIxHi7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF526FD9C
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753431; cv=none; b=bwP/qjoNuhGLcskPClzCZ2veLkSbr5nOxoe4xdCFrCrFGPMABlHO52oyu7fcYDZCtIDp/tJZkGdayHFBWmNT+N4OFp4HFKuYeSkB4PofB5D8qN2h+UJPlKEpzMWzjFfoA4cp3m07stwblpTnHjNCBtFBKcpz8FxAnY9wS+8ioUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753431; c=relaxed/simple;
	bh=1aBP9K7l6QGkES0Z/E1APd+6JF6ML9hxGfniCgK16Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K907PauH2lvbkqKLdMoIs4RIvbaqajcBX0iSXRlwAI8kNDBmZu7xeHrGCBNw8/5up2Emyrmf/O+XK4I26Zmc/76NZYmXGU8VQGScIDneuGiSvU9ATr3jr1FpSdaUff94Nwouxihry+mJUzpVA+Y0J5DpHT/rn0kKC1UBX/OsLrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yse72wvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6dIxHi7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yse72wvw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G6dIxHi7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A3D821184;
	Fri, 28 Feb 2025 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740753427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRsDPNjbs4lASqTZP0a9+AoO1cmrvCJTlngj6NM5/5U=;
	b=Yse72wvwYfvbUB8i+6Ccl9rfhSi3wC6BcXhGxtv2en5E2oeNz8zEz9ZjBQVCvPwSbvgC0A
	K0mtczk8fqcfQAYhfVOGDtzqSIfsvC2Rgi314GpLwE3UL4muO7XreiKSe2sEXJ77ZlEWlW
	Z0TlGw9PP6Cr2WjHbtfJYLuFwcqFC8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740753427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRsDPNjbs4lASqTZP0a9+AoO1cmrvCJTlngj6NM5/5U=;
	b=G6dIxHi7FKQA2qW2sNu8+buEEvyKlFIfqVAUbd20JoXZ+L9Mn69vxpv309SlicXd25XSUm
	mHYfdDWcxqjBKHAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yse72wvw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G6dIxHi7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740753427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRsDPNjbs4lASqTZP0a9+AoO1cmrvCJTlngj6NM5/5U=;
	b=Yse72wvwYfvbUB8i+6Ccl9rfhSi3wC6BcXhGxtv2en5E2oeNz8zEz9ZjBQVCvPwSbvgC0A
	K0mtczk8fqcfQAYhfVOGDtzqSIfsvC2Rgi314GpLwE3UL4muO7XreiKSe2sEXJ77ZlEWlW
	Z0TlGw9PP6Cr2WjHbtfJYLuFwcqFC8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740753427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRsDPNjbs4lASqTZP0a9+AoO1cmrvCJTlngj6NM5/5U=;
	b=G6dIxHi7FKQA2qW2sNu8+buEEvyKlFIfqVAUbd20JoXZ+L9Mn69vxpv309SlicXd25XSUm
	mHYfdDWcxqjBKHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F4226137AC;
	Fri, 28 Feb 2025 14:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id up1tOxLKwWc1OQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 28 Feb 2025 14:37:06 +0000
Date: Fri, 28 Feb 2025 15:37:05 +0100
From: David Sterba <dsterba@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/2] btrfs: kill EXTENT_FOLIO_PRIVATE
Message-ID: <20250228143705.GL5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740168635.git.rgoldwyn@suse.com>
 <f20af3e9a924af09da20a49f348b9b1f49057ccc.1740168635.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20af3e9a924af09da20a49f348b9b1f49057ccc.1740168635.git.rgoldwyn@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3A3D821184
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 21, 2025 at 03:20:53PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Since mapping_set_release_always() will provide a callback for release
> folio, remove EXTENT_FOLIO_PRIVATE and all it's helper functions.
> 
> This affects how we handle subpage, so convert the function name of
> set_folio_extent_mapped() to btrfs_set_folio_subpage() and
> clear_folio_extent_mapped() to btrfs_clear_folio_subpage().
> 
> free_space_cache_inode does not use subpage, so just skip calling
> btrfs_set_folio_subpage().
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/compression.c      |  2 +-
>  fs/btrfs/defrag.c           |  2 +-
>  fs/btrfs/extent_io.c        | 28 +++++++++++++---------------
>  fs/btrfs/extent_io.h        | 10 ++--------
>  fs/btrfs/file.c             |  4 ++--
>  fs/btrfs/free-space-cache.c |  9 ---------
>  fs/btrfs/inode.c            |  6 +++---
>  fs/btrfs/reflink.c          |  2 +-
>  fs/btrfs/relocation.c       |  2 +-
>  9 files changed, 24 insertions(+), 41 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 1fe154e7cc02..8f0cc726ba20 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -491,7 +491,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			*memstall = 1;
>  		}
>  
> -		ret = set_folio_extent_mapped(folio);
> +		ret = btrfs_set_folio_subpage(folio);
>  		if (ret < 0) {
>  			folio_unlock(folio);
>  			folio_put(folio);
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 968dae953948..46df90f9e790 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -883,7 +883,7 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
>  		return ERR_PTR(-ETXTBSY);
>  	}
>  
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d1f9fad18f25..ca29a1111de6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -865,25 +865,22 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
>  	return ret;
>  }
>  
> -int set_folio_extent_mapped(struct folio *folio)
> +int btrfs_set_folio_subpage(struct folio *folio)
>  {
> -	struct btrfs_fs_info *fs_info;
> +	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
>  
>  	ASSERT(folio->mapping);
>  
> -	if (folio_test_private(folio))
> +	if (!btrfs_is_subpage(fs_info, folio->mapping))
>  		return 0;
>  
> -	fs_info = folio_to_fs_info(folio);
> -
> -	if (btrfs_is_subpage(fs_info, folio->mapping))
> -		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
> +	if (folio_test_private(folio))
> +		return 0;

Is this necessary to check the private bit here? It is maybe a shortcut
because btrfs_attach_subpage will test the private bit as well but I
don't think this is a hot path where we'd need to optimize it.

>  
> -	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
> -	return 0;
> +	return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
>  }
>  
> -void clear_folio_extent_mapped(struct folio *folio)
> +void btrfs_clear_folio_subpage(struct folio *folio)
>  {
>  	struct btrfs_fs_info *fs_info;
>  
> @@ -893,10 +890,11 @@ void clear_folio_extent_mapped(struct folio *folio)
>  		return;
>  
>  	fs_info = folio_to_fs_info(folio);
> -	if (btrfs_is_subpage(fs_info, folio->mapping))
> -		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
>  
> -	folio_detach_private(folio);
> +	if (!btrfs_is_subpage(fs_info, folio->mapping))
> +		return;
> +
> +	btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
>  }
>  
>  static struct extent_map *get_extent_map(struct btrfs_inode *inode,
> @@ -951,7 +949,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
>  	size_t iosize;
>  	size_t blocksize = fs_info->sectorsize;
>  
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0) {
>  		folio_unlock(folio);
>  		return ret;
> @@ -1562,7 +1560,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
>  	 * The proper bitmap can only be initialized until writepage_delalloc().
>  	 */
>  	bio_ctrl->submit_bitmap = (unsigned long)-1;
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0)
>  		goto done;
>  
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 6c5328bfabc2..303c92272a46 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -65,12 +65,6 @@ enum {
>  	ENUM_BIT(PAGE_SET_ORDERED),
>  };
>  
> -/*
> - * Folio private values.  Every page that is controlled by the extent map has
> - * folio private set to this value.
> - */
> -#define EXTENT_FOLIO_PRIVATE			1

The whole naming and extent mapping is from the old times where the
relation between page and extent depended on the private bit but it
probably got changed during the folio conversion so we don't really need
it anymore.

It still looks strange to see btrfs_set_folio_subpage() at random place
that do not seem to be related to subpage, so the "mapped" semantics
fits better but as said it's probably not correct anymore.

> -
>  /*
>   * The extent buffer bitmap operations are done with byte granularity instead of
>   * word granularity for two reasons:
> @@ -247,8 +241,8 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
>  int btree_write_cache_pages(struct address_space *mapping,
>  			    struct writeback_control *wbc);
>  void btrfs_readahead(struct readahead_control *rac);
> -int set_folio_extent_mapped(struct folio *folio);
> -void clear_folio_extent_mapped(struct folio *folio);
> +int btrfs_set_folio_subpage(struct folio *folio);
> +void btrfs_clear_folio_subpage(struct folio *folio);
>  
>  struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  					  u64 start, u64 owner_root, int level);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5808eb5bcd42..820feaf26583 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -875,7 +875,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>  	}
>  	/* Only support page sized folio yet. */
>  	ASSERT(folio_order(folio) == 0);
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0) {
>  		folio_unlock(folio);
>  		folio_put(folio);
> @@ -1840,7 +1840,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  	folio_wait_writeback(folio);
>  
>  	lock_extent(io_tree, page_start, page_end, &cached_state);
> -	ret2 = set_folio_extent_mapped(folio);
> +	ret2 = btrfs_set_folio_subpage(folio);
>  	if (ret2 < 0) {
>  		ret = vmf_error(ret2);
>  		unlock_extent(io_tree, page_start, page_end, &cached_state);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 056546bf9abd..7a85b243f18e 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -453,7 +453,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>  	int i;
>  
>  	for (i = 0; i < io_ctl->num_pages; i++) {
> -		int ret;
>  
>  		folio = __filemap_get_folio(inode->i_mapping, i,
>  					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
> @@ -463,14 +462,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>  			return -ENOMEM;
>  		}
>  
> -		ret = set_folio_extent_mapped(folio);
> -		if (ret < 0) {
> -			folio_unlock(folio);
> -			folio_put(folio);
> -			io_ctl_drop_pages(io_ctl);
> -			return ret;
> -		}
> -
>  		io_ctl->pages[i] = &folio->page;
>  		if (uptodate && !folio_test_uptodate(folio)) {
>  			btrfs_read_folio(NULL, folio);
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 6424d45c6baa..896c9454dc96 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4863,7 +4863,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  	 * folio private, but left the page in the mapping.  Set the page mapped
>  	 * here to make sure it's properly set for the subpage stuff.
>  	 */
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> @@ -7290,7 +7290,7 @@ static bool __btrfs_release_folio(struct folio *folio, gfp_t gfp_flags)
>  {
>  	if (try_release_extent_mapping(folio, gfp_flags)) {
>  		wait_subpage_spinlock(folio);
> -		clear_folio_extent_mapped(folio);
> +		btrfs_clear_folio_subpage(folio);
>  		return true;
>  	}
>  	return false;
> @@ -7488,7 +7488,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
>  	btrfs_folio_clear_checked(fs_info, folio, folio_pos(folio), folio_size(folio));
>  	if (!inode_evicting)
>  		__btrfs_release_folio(folio, GFP_NOFS);
> -	clear_folio_extent_mapped(folio);
> +	btrfs_clear_folio_subpage(folio);
>  }
>  
>  static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index f0824c948cb7..f1060cab079f 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -91,7 +91,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
>  		goto out_unlock;
>  	}
>  
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index af0969b70b53..285b0e5a9ab9 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2873,7 +2873,7 @@ static int relocate_one_folio(struct reloc_control *rc,
>  	 * folio above, make sure we set_folio_extent_mapped() here so we have any

Leftover set_folio_extent_mapped() in the comment.

>  	 * of the subpage blocksize stuff we need in place.
>  	 */
> -	ret = set_folio_extent_mapped(folio);
> +	ret = btrfs_set_folio_subpage(folio);
>  	if (ret < 0)
>  		goto release_folio;
>  
> -- 
> 2.48.1
> 

