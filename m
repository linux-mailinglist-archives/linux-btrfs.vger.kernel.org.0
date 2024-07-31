Return-Path: <linux-btrfs+bounces-6915-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135479432EE
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9B51281B7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9166918FDC0;
	Wed, 31 Jul 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ZLJFDKg6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332B17552
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438699; cv=none; b=BERvA5VfiQBNAYkO0xfrF5FjSIrPyUCvYaKw9YueDb5d0TB/62OUa435VO3e1tdXIJyuoR3GZafW9WDPQ8wKYvoj1XgAunXsH+FLmpcNMjdCNabXDnG4r7M6bH3qIYBAe1nscdWT95AAlZk14IfpEvB3sKbf5n63zGjzQy0BDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438699; c=relaxed/simple;
	bh=rVClSLT9f277Ybxg0Y7Evq/Ggfaax6lI0fNU995UilA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZsCwUUPTceJtZ0pUvXBUmbbgmxmtZ6/T2hCcpWRsey0ZaW5TNZwEn0qnKE+aPxgQPm0fYdmi2f+NuVj1/aztHYgxBg4POcRT6ZMSbIp6qh/S9QrTx4/rQ0YL04td6UNuC+qLwoBS8GrWoMOljr41XB7b1/RaGjSB5GjO9++6KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ZLJFDKg6; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5c8c1006eso3290186eaf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2024 08:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722438696; x=1723043496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmwefmibWUoEL6wEGhOdxrlVZv0gmH/DZ9JPwtFoHmc=;
        b=ZLJFDKg6kRpJyri+eLBomvc1agUNBSHemxcistnKLdBvrHEl5iVTE3tx2PRM4o1bgx
         690WAFzRqW5WoEPyvnjMySUVtnaA7NvNrCd8fcJuwtt0vtyYci1TBKzeY8fnkLQPGSRG
         zDz7kvicC7fUjtwuqVnYQgq1Sv8ott435kGhX9ErVxqKJFni3Tuz+xDrmF0YgcBmslQh
         cfsYpre3yxKM4J7DvLRg/1UbP++gzMVV+T2jAyBiQlSPktnE1Eq8DC7zuS4ehLoljBXU
         PEkXcNh1R7zMK+tCqQoJyOpo5zakDgxvVPHiAzULP0iU13fxI7LdAXUxjM3xU4098JQp
         U2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438696; x=1723043496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmwefmibWUoEL6wEGhOdxrlVZv0gmH/DZ9JPwtFoHmc=;
        b=rZWlKQREkbaYur3nGRdQdD7INAsMGFBe3BAzTDDMWiz7YPB9lAwLXalG7rtqTLibkV
         8S9k8ME/XNxiRa6nF+JtGpa26+g/fnXLne5cxTd7lTEewtrLF3g39NqrhXySzmGp9tMa
         gWLkMeRptQeGyJKMU40eNM5P1W/Q1NICFSrAHsZe0kSNTfpif1YUxYIKSFtIOwfDA3uP
         L1BDrCEVIc/J169W6drCQrzp2GMk8E54aGwwLXBkwgXtIcCOda+pL4YhkLKxTKgWQHDd
         +/T10/fnTwtb3JfQFZGGGEjCJW6kaoPD2YpOcA3fNhO5q5ZKGlhdRePhohWkS4azKnyd
         DAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOe2cNFIp77WGty7L7G9lCAATEhEywqivoaeu0w5fCqQdjWbzNUcLqON6cVFQ8iBejOE9NsoPFh/TXw4ungKA6KBBOxT3lUq6z36Q=
X-Gm-Message-State: AOJu0YyU5aUbWcX9dnJgjIdmMSuxOlJjruNaMVrRNtlfsPRst8aSiPMY
	FPg0fAfX6bIfBylWpwTMSy6fLL18JHZFvcUp76xH2lE8i6WKUPskH0lT+BEsUytO5uVzE1d+qJM
	U
X-Google-Smtp-Source: AGHT+IEzF6ngGsFfxbGdkBQcb8a51FJZYRr+E8q+I+53YoNvG5tO/Kn6+6cU3x21vY1Y5cnJOxusGA==
X-Received: by 2002:a05:6870:610e:b0:260:fc35:b37e with SMTP id 586e51a60fabf-267d4f3b456mr16922290fac.44.1722438696495;
        Wed, 31 Jul 2024 08:11:36 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1ea8943a4sm506723085a.121.2024.07.31.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:11:36 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:11:35 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v8] btrfs: prefer to allocate larger folio for metadata
Message-ID: <20240731151135.GC3908975@perftesting>
References: <c9bd53a8c7efb8d0e16048036d0596e17e519dd6.1721902058.git.wqu@suse.com>
 <20240726145753.GC3432726@perftesting>
 <d5473dd9-69ca-4df3-b4d0-f9d7b0a46a86@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5473dd9-69ca-4df3-b4d0-f9d7b0a46a86@gmx.com>

On Sat, Jul 27, 2024 at 08:02:26AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/27 00:27, Josef Bacik 写道:
> > On Thu, Jul 25, 2024 at 07:41:16PM +0930, Qu Wenruo wrote:
> > > Since btrfs metadata is always in fixed size (nodesize, determined at
> > > mkfs time, default to 16K), and btrfs has the full control of the folios
> > > (read is triggered internally, no read/readahead call backs), it's the
> > > best location to experimental larger folios inside btrfs.
> > > 
> > > To enable larger folios, the btrfs has to meet the following conditions:
> > > 
> > > - The extent buffer start is aligned to nodesize
> > >    This should be the common case for any btrfs in the last 5 years.
> > > 
> > > - The nodesize is larger than page size
> > > 
> > > - MM layer can fulfill our larger folio allocation
> > >    The larger folio will cover exactly the metadata size (nodesize).
> > > 
> > > If any of the condition is not met, we just fall back to page sized
> > > folio and go as usual.
> > > This means, we can have mixed orders for btrfs metadata.
> > > 
> > > Thus there are several new corner cases with the mixed orders:
> > > 
> > > 1) New filemap_add_folio() -EEXIST failure cases
> > >     For mixed order cases, filemap_add_folio() can return -EEXIST
> > >     meanwhile filemap_lock_folio() returns -ENOENT.
> > >     We can only retry several times, before falling back to 0 order
> > >     folios.
> > > 
> > > 2) Existing folio size may be different than the one we allocated
> > >     This is after the existing eb checks.
> > > 
> > > 2.1) The existing folio is larger than the allocated one
> > >       Need to free all allocated folios, and use the existing larger
> > >       folio instead.
> > > 
> > > 2.2) The existing folio has the same size
> > >       Free the allocated one and reuse the page cache.
> > >       This is the existing path.
> > > 
> > > 2.3) The existing folio is smaller than the allocated one
> > >       Fall back to re-allocate order 0 folios instead.
> > > 
> > > Otherwise all the needed infrastructure is already here, we only need to
> > > try allocate larger folio as our first try in alloc_eb_folio_array().
> > > 
> > > For now, the higher order allocation is only a preferable attempt for
> > > debug build, before we had enough test coverage and push it to end
> > > users.
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > > Changelog:
> > > [CHANGELOG]
> > > v8:
> > > - Drop the memcgroup optimization as dependency
> > >    Opting out memcgroup will be pushed as an independent patchset
> > >    instead. It's not related to the soft lockup.
> > > 
> > > - Fix a soft lockup caused by mixed folio orders
> > > 	 |<- folio ->|
> > > 	 |  |  |//|//|   |//| is the existing page cache
> > >    In above case, the filemap_add_folio() will always return -EEXIST
> > >    but filemap_lock_folio() also returns -ENOENT.
> > >    Which can lead to a dead loop.
> > >    Fix it by only retrying 5 times for larger folios, then fall back
> > >    to 0 order folios.
> > > 
> > > - Slightly rewording the commit messages
> > >    Make it shorter and better organized.
> > > 
> > > v7:
> > > - Fix an accidentally removed line caused by previous modification
> > >    attempt
> > >    Previously I was moving that line to the common branch to
> > >    unconditionally define root_mem_cgroup pointer.
> > >    But that's later discarded and changed to use macro definition, but
> > >    forgot to add back the original line.
> > > 
> > > v6:
> > > - Add a new root_mem_cgroup definition for CONFIG_MEMCG=n cases
> > >    So that users of root_mem_cgroup no longer needs to check
> > >    CONFIG_MEMCG.
> > >    This is to fix the compile error for CONFIG_MEMCG=n cases.
> > > 
> > > - Slight rewording of the 2nd patch
> > > 
> > > v5:
> > > - Use root memcgroup to attach folios to btree inode filemap
> > > - Only try higher order folio once without NOFAIL nor extra retry
> > > 
> > > v4:
> > > - Hide the feature behind CONFIG_BTRFS_DEBUG
> > >    So that end users won't be affected (aka, still per-page based
> > >    allocation) meanwhile we can do more testing on this new behavior.
> > > 
> > > v3:
> > > - Rebased to the latest for-next branch
> > > - Use PAGE_ALLOC_COSTLY_ORDER to determine whether to use __GFP_NOFAIL
> > > - Add a dependency MM patch "mm/page_alloc: unify the warning on NOFAIL
> > >    and high order allocation"
> > >    This allows us to use NOFAIL up to 32K nodesize, and makes sure for
> > >    default 16K nodesize, all metadata would go 16K folios
> > > 
> > > v2:
> > > - Rebased to handle the change in "btrfs: cache folio size and shift in extent_buffer"
> > > ---
> > >   fs/btrfs/extent_io.c | 122 ++++++++++++++++++++++++++++++-------------
> > >   1 file changed, 86 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index aa7f8148cd0d..0beebcb9be77 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -719,12 +719,28 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
> > >    *
> > >    * For now, the folios populated are always in order 0 (aka, single page).
> > >    */
> > > -static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
> > > +static int alloc_eb_folio_array(struct extent_buffer *eb, int order,
> > > +				bool nofail)
> > >   {
> > >   	struct page *page_array[INLINE_EXTENT_BUFFER_PAGES] = { 0 };
> > >   	int num_pages = num_extent_pages(eb);
> > >   	int ret;
> > > 
> > > +	if (order) {
> > > +		gfp_t gfp;
> > > +
> > > +		if (order > 0)
> > > +			gfp = GFP_NOFS | __GFP_NORETRY | __GFP_NOWARN;
> > > +		else
> > > +			gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
> > 
> > This check is useless, we're already checking if (order) above.
> > 
> > > +		eb->folios[0] = folio_alloc(gfp, order);
> > > +		if (likely(eb->folios[0])) {
> > > +			eb->folio_size = folio_size(eb->folios[0]);
> > > +			eb->folio_shift = folio_shift(eb->folios[0]);
> > > +			return 0;
> > > +		}
> > > +		/* Fallback to 0 order (single page) allocation. */
> > > +	}
> > >   	ret = btrfs_alloc_page_array(num_pages, page_array, nofail);
> > >   	if (ret < 0)
> > >   		return ret;
> > > @@ -2707,7 +2723,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> > >   	 */
> > >   	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> > > 
> > > -	ret = alloc_eb_folio_array(new, false);
> > > +	ret = alloc_eb_folio_array(new, 0, false);
> > >   	if (ret) {
> > >   		btrfs_release_extent_buffer(new);
> > >   		return NULL;
> > > @@ -2740,7 +2756,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> > >   	if (!eb)
> > >   		return NULL;
> > > 
> > > -	ret = alloc_eb_folio_array(eb, false);
> > > +	ret = alloc_eb_folio_array(eb, 0, false);
> > >   	if (ret)
> > >   		goto err;
> > > 
> > > @@ -2955,7 +2971,16 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
> > >   	return 0;
> > >   }
> > > 
> > > +static void free_all_eb_folios(struct extent_buffer *eb)
> > > +{
> > > +	for (int i = 0; i < INLINE_EXTENT_BUFFER_PAGES; i++) {
> > > +		if (eb->folios[i])
> > > +			folio_put(eb->folios[i]);
> > > +		eb->folios[i] = NULL;
> > > +	}
> > > +}
> > > 
> > > +#define BTRFS_ADD_FOLIO_RETRY_LIMIT	(5)
> > >   /*
> > >    * Return 0 if eb->folios[i] is attached to btree inode successfully.
> > >    * Return >0 if there is already another extent buffer for the range,
> > > @@ -2973,6 +2998,8 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> > >   	struct address_space *mapping = fs_info->btree_inode->i_mapping;
> > >   	const unsigned long index = eb->start >> PAGE_SHIFT;
> > >   	struct folio *existing_folio = NULL;
> > > +	const int eb_order = folio_order(eb->folios[0]);
> > > +	int retried = 0;
> > >   	int ret;
> > > 
> > >   	ASSERT(found_eb_ret);
> > > @@ -2990,18 +3017,25 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
> > >   	/* The page cache only exists for a very short time, just retry. */
> > >   	if (IS_ERR(existing_folio)) {
> > >   		existing_folio = NULL;
> > > +		retried++;
> > > +		/*
> > > +		 * We can have the following case:
> > > +		 *	|<- folio ->|
> > > +		 *	|  |  |//|//|
> > > +		 * Where |//| is the slot that we have a page cache.
> > > +		 *
> > > +		 * In above case, filemap_add_folio() will return -EEXIST,
> > > +		 * but filemap_lock_folio() will return -ENOENT.
> > > +		 * After several retries, we know it's the above case,
> > > +		 * and just fallback to order 0 folios instead.
> > > +		 */
> > > +		if (eb_order > 0 && retried > BTRFS_ADD_FOLIO_RETRY_LIMIT) {
> > > +			ASSERT(i == 0);
> > > +			return -EAGAIN;
> > > +		}
> > 
> > Ok hold on, I'm just now looking at this code, and am completely confused.
> > 
> > filemap_add_folio inserts our new folio into the mapping and returns with it
> > locked.  Under what circumstances do we end up with filemap_lock_folio()
> > returning ENOENT?
> 
> Remember we go filemap_lock_folio() only when filemap_add_folio()
> returns with -EEXIST.
> 
> There is an existing case (all order 0 folios) like this:
> 
> ------------------------------+-------------------------------------
> filemap_add_folio()           |
> Return -EEXIST                |
>                               | Some page reclaim happens
>                               | Choose the page at exactly the same
>                               | index to be reclaimed
> filemap_lock_folio            |
> return -ENOENT
> 
> Remember that between the filemap_add_folio() and filemap_lock_folio()
> there is nothing preventing page reclaim from happening.
> 
> 
> > 
> > I understand in this larger folio case where this could happen, but this code
> > exists today where we're only allocating 0 order folios.  So does this actually
> > happen today, or were you future proofing it?
> 
> It's already happening even for order 0 folios. As we do not hold any
> lock for the address space.
> 
> > 
> > Also it seems like a super bad, no good thing that we can end up being allowed
> > to insert a folio that overlaps other folios already in the mapping.  So if that
> > can happen, that seems like the thing that needs to be addressed generically.
> 
> For the generic __filemap_get_folio() with FGP_CREAT, that's exactly
> what we do, just retry with smaller folio.
> 
> And in that case, they do the retry if filemap_add_folio() hits -EEXIST
> just like us.

You're right, I misread the code and thought this was the normal path, so my
whole rambling was just wrong, sorry about that.

However if we're allocating them at the order that our extent buffer is, this
means that we previously had an extent buffer that had 0 order pages, and these
just haven't been cleaned up yet.

This is kind of an ugly scenario, because now we're widening the possibility of
racing with somebody else trying to create an extent buffer here.  I think the
only sane choice is to immediately switch to 0 order folios and carry on.
Thanks,

Josef

