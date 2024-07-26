Return-Path: <linux-btrfs+bounces-6720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154593D577
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 16:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56445B2301B
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1D178CC8;
	Fri, 26 Jul 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uN59rw2E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC91CD06
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005878; cv=none; b=u5zD1QytdWOK5/1MSld4HmObcZf9r5rgJR+w2ZuaUbzEpvpo/DbByV29BTsiR9t3CGgBwxZQdJoUpg10mIO6mpNrSB8TylvuNo6khz6eayeUC4puB7Ag/2gnUhufGAzDjA/jxqHbz2BT8lZDbFAKjHxE/lKEzMq4bV8CcT/yfz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005878; c=relaxed/simple;
	bh=zEnxPDmXVxIIG1EivEJSdfNCOZ32fb6cx8PqYHnOYsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKqlnRcpj2nl14c/r2uH6h7bHeHI27zTMh/BzhDXuI/YUi2kcR+5MT7J7/ksovsRVfyAi6z3bWzqAzhf9bFm3uigcJh6Kfy7UVo6ec0Zham7tJMjAM0yWRYJz6QI5BmWU8j/pMUPZ/5ACn8EpYvJ0VjDAXZ8itvjGrhPsSodBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uN59rw2E; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-823423e3accso218540241.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722005875; x=1722610675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2rw8AI45SDuYUg4So1l/h1eBBZK/Q6ylvNqZKlerrsc=;
        b=uN59rw2E956IGQPNF5lWUpwvhEBEzs4wrTx/86qZfO0IcAszQzjY9TLIGVNgLBNAWL
         /S1QawH9jryravIpZdN2WS4BKayTyV8nXY+aOlmIRWwtuNQ2pTLe4eDC5IxrV3Pl2my4
         SvEatCO/pZUsZNPNjQ04vVcCZ1zQJzzUCUcvznACEn7L18tCniHcN1Bf8GSeDrBGF1VJ
         t6YtZLOaq0861XcqH73CeZqkThNXFU14zk+9MXvlprvksA0pPTbydCn+1xWKGbJ+Bd9m
         a1k4/GwYxNoQc/auq+SOnGS+D4shAIaEaBFmNcIcr6BJd5VtP63VE4wEBLOgkIkWQtWS
         pW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005875; x=1722610675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rw8AI45SDuYUg4So1l/h1eBBZK/Q6ylvNqZKlerrsc=;
        b=Mxi76Jwl2pDOlpJmUJaYo1PeeItlzoDrbEd/YdyT5Hb02g9sV17QhtTJTGJL6J2G4w
         9kwqCY5Tu5XYfRfFLWZD8mIL7k+NXlfxbw5nuy3OtvmMiYaulAyZ2mOjoScy22BbvqIc
         s1gZ/LO1VYKlIHLTTt60dX5KiMqKq5gDXbPnc8oq1GqF9TyYdRT+/LwIpVtH1NKmS6Oa
         /GU8/5QLLJ0I7I+dUok5X0jhRTuw07N+net7mei9bpySD2k9jvAhasBA7COk+f0FpA39
         /NglT1H1W9Bg7pVhXCDbmbLdovJ35sxZIu9JzTc3TfqOoeLhdA39Fwjy+wuEqleyw8XC
         cOlA==
X-Gm-Message-State: AOJu0YwpKDZepJmV34uTosNCvdKedYbOAU7Lk/DYCoVud4/7YcaevBL8
	v8apf7TcJKvy0IKQ7FxaMJx3tzjNQ5AAu3cjYOn8S7aLAEfyUpLMa4i9scpB8dE=
X-Google-Smtp-Source: AGHT+IEwVT9DaF4j6hmAOhS0Aa6Tw4e1C+v27uhkQ94dsMPTlxNUQ/x57GxOGPn+vwCFcyGRpti1Hg==
X-Received: by 2002:a05:6102:1626:b0:493:daea:615d with SMTP id ada2fe7eead31-493daea737emr7034312137.0.1722005875036;
        Fri, 26 Jul 2024 07:57:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73b46b4sm181434785a.53.2024.07.26.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 07:57:54 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:57:53 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240726145753.GC3432726@perftesting>
References: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>

On Thu, Jul 25, 2024 at 07:41:16PM +0930, Qu Wenruo wrote:
> Since btrfs metadata is always in fixed size (nodesize, determined at
> mkfs time, default to 16K), and btrfs has the full control of the folios
> (read is triggered internally, no read/readahead call backs), it's the
> best location to experimental larger folios inside btrfs.
> 
> To enable larger folios, the btrfs has to meet the following conditions:
> 
> - The extent buffer start is aligned to nodesize
>   This should be the common case for any btrfs in the last 5 years.
> 
> - The nodesize is larger than page size
> 
> - MM layer can fulfill our larger folio allocation
>   The larger folio will cover exactly the metadata size (nodesize).
> 
> If any of the condition is not met, we just fall back to page sized
> folio and go as usual.
> This means, we can have mixed orders for btrfs metadata.
> 
> Thus there are several new corner cases with the mixed orders:
> 
> 1) New filemap_add_folio() -EEXIST failure cases
>    For mixed order cases, filemap_add_folio() can return -EEXIST
>    meanwhile filemap_lock_folio() returns -ENOENT.
>    We can only retry several times, before falling back to 0 order
>    folios.
> 
> 2) Existing folio size may be different than the one we allocated
>    This is after the existing eb checks.
> 
> 2.1) The existing folio is larger than the allocated one
>      Need to free all allocated folios, and use the existing larger
>      folio instead.
> 
> 2.2) The existing folio has the same size
>      Free the allocated one and reuse the page cache.
>      This is the existing path.
> 
> 2.3) The existing folio is smaller than the allocated one
>      Fall back to re-allocate order 0 folios instead.
> 
> Otherwise all the needed infrastructure is already here, we only need to
> try allocate larger folio as our first try in alloc_eb_folio_array().
> 
> For now, the higher order allocation is only a preferable attempt for
> debug build, before we had enough test coverage and push it to end
> users.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> [CHANGELOG]
> v8:
> - Drop the memcgroup optimization as dependency
>   Opting out memcgroup will be pushed as an independent patchset
>   instead. It's not related to the soft lockup.
> 
> - Fix a soft lockup caused by mixed folio orders
> 	 |<- folio ->|
> 	 |  |  |//|//|   |//| is the existing page cache
>   In above case, the filemap_add_folio() will always return -EEXIST
>   but filemap_lock_folio() also returns -ENOENT.
>   Which can lead to a dead loop.
>   Fix it by only retrying 5 times for larger folios, then fall back
>   to 0 order folios.
> 
> - Slightly rewording the commit messages
>   Make it shorter and better organized.
> 
> v7:
> - Fix an accidentally removed line caused by previous modification
>   attempt
>   Previously I was moving that line to the common branch to
>   unconditionally define root_mem_cgroup pointer.
>   But that's later discarded and changed to use macro definition, but
>   forgot to add back the original line.
> 
> v6:
> - Add a new root_mem_cgroup definition for CONFIG_MEMCG=n cases
>   So that users of root_mem_cgroup no longer needs to check
>   CONFIG_MEMCG.
>   This is to fix the compile error for CONFIG_MEMCG=n cases.
> 
> - Slight rewording of the 2nd patch
> 
> v5:
> - Use root memcgroup to attach folios to btree inode filemap
> - Only try higher order folio once without NOFAIL nor extra retry
> 
> v4:
> - Hide the feature behind CONFIG_BTRFS_DEBUG
>   So that end users won't be affected (aka, still per-page based
>   allocation) meanwhile we can do more testing on this new behavior.
> 
> v3:
> - Rebased to the latest for-next branch
> - Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
> - Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
>   and high order allocation"
>   This allows us to use NOFAIL up to 32K nodesize, and makes sure for
>   default 16K nodesize, all metadata would go 16K folios
> 
> v2:
> - Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"
> ---
>  fs/btrfs/extent_io.c | 122 ++++++++++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index aa7f8148cd0d..0beebcb9be77 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -719,12 +719,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>   *
>   * For now, the folios populated are always in order 0 (aka, single page).
>   */
> -static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
> +static int alloc_eb_folio_array(struct extent_buffer *eb, int order,
> +				bool nofail)
>  {
>  	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
>  	int num_pages = num_extent_pages(eb);
>  	int ret;
>  
> +	if (order) {
> +		gfp_t gfp;
> +
> +		if (order > 0)
> +			gfp = GFP_NOFS | __GFP_NORETRY | __GFP_NOWARN;
> +		else
> +			gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;

This check is useless, we're already checking if (order) above.

> +		eb->folios[0] = folio_alloc(gfp, order);
> +		if (likely(eb->folios[0])) {
> +			eb->folio_size = folio_size(eb->folios[0]);
> +			eb->folio_shift = folio_shift(eb->folios[0]);
> +			return 0;
> +		}
> +		/* Fallback to 0 order (single page) allocation. */
> +	}
>  	ret = btrfs_alloc_page_array(num_pages, page_array, nofail);
>  	if (ret < 0)
>  		return ret;
> @@ -2707,7 +2723,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
>  	 */
>  	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>  
> -	ret = alloc_eb_folio_array(new, false);
> +	ret = alloc_eb_folio_array(new, 0, false);
>  	if (ret) {
>  		btrfs_release_extent_buffer(new);
>  		return NULL;
> @@ -2740,7 +2756,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
>  	if (!eb)
>  		return NULL;
>  
> -	ret = alloc_eb_folio_array(eb, false);
> +	ret = alloc_eb_folio_array(eb, 0, false);
>  	if (ret)
>  		goto err;
>  
> @@ -2955,7 +2971,16 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
>  	return 0;
>  }
>  
> +static void free_all_eb_folios(struct extent_buffer *eb)
> +{
> +	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
> +		if (eb->folios[i])
> +			folio_put(eb->folios[i]);
> +		eb->folios[i] = NULL;
> +	}
> +}
>  
> +#define BTRFS_ADD_FOLIO_RETRY_LIMIT	(5)
>  /*
>   * Return 0 if eb->folios[i] is attached to btree inode successfully.
>   * Return >0 if there is already another extent buffer for the range,
> @@ -2973,6 +2998,8 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
>  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
>  	const unsigned long index = eb->start >> PAGE_SHIFT;
>  	struct folio *existing_folio = NULL;
> +	const int eb_order = folio_order(eb->folios[0]);
> +	int retried = 0;
>  	int ret;
>  
>  	ASSERT(found_eb_ret);
> @@ -2990,18 +3017,25 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
>  	/* The page cache only exists for a very short time, just retry. */
>  	if (IS_ERR(existing_folio)) {
>  		existing_folio = NULL;
> +		retried++;
> +		/*
> +		 * We can have the following case:
> +		 *	|<- folio ->|
> +		 *	|  |  |//|//|
> +		 * Where |//| is the slot that we have a page cache.
> +		 *
> +		 * In above case, filemap_add_folio() will return -EEXIST,
> +		 * but filemap_lock_folio() will return -ENOENT.
> +		 * After several retries, we know it's the above case,
> +		 * and just fallback to order 0 folios instead.
> +		 */
> +		if (eb_order > 0 && retried > BTRFS_ADD_FOLIO_RETRY_LIMIT) {
> +			ASSERT(i == 0);
> +			return -EAGAIN;
> +		}

Ok hold on, I'm just now looking at this code, and am completely confused.

filemap_add_folio inserts our new folio into the mapping and returns with it
locked.  Under what circumstances do we end up with filemap_lock_folio()
returning ENOENT?

I understand in this larger folio case where this could happen, but this code
exists today where we're only allocating 0 order folios.  So does this actually
happen today, or were you future proofing it?

Also it seems like a super bad, no good thing that we can end up being allowed
to insert a folio that overlaps other folios already in the mapping.  So if that
can happen, that seems like the thing that needs to be addressed generically.

This sets off huge alarm bells for me, I'm going to need a more thorough
explanation of how this happens and why it's ok in the normal case.  Thanks,

Josef

