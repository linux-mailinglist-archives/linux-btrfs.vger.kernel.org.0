Return-Path: <linux-btrfs+bounces-16199-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E360AB30135
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5C21CC4B24
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EEB338F44;
	Thu, 21 Aug 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GkDK9z8p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KPZT3m+q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765B2E1F17
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755797847; cv=none; b=hbDo57ZB+lT8mX5HXo9zJOzZv/O6+jt+GLEG7rxodbpgcVmO4m/SP0OzzN+zrwJWjLvn2G3Ucj0e+skPm8CQcMxDGFLzzdGxSAy/3kWz/jocOiDfhYtiYKW0aiuAF52wgPjSo6UMEvuvdtFOmT2vIBwTmKKihNVd3HR5RcOsRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755797847; c=relaxed/simple;
	bh=5NWJq9JVnSUX7CWldqXOloMAvGfO2JUuKPgSg8QxCmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhWwtceClLjs/MZKvDQz1baEAgoESAhvjxoq7h2CA9ictyC0qkkKY/hVX7UbFi1Dkg3LmfL+Etb88aGbkaEyDk/6JBJErhU3F7ynQA6/g6T4fwDgkx0Ngd8AsYQL+/gvu6TrsudgsR+qZNS0+ATc/ykH+AapT7RPJUJz9mw6afo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GkDK9z8p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KPZT3m+q; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D96E1D00022;
	Thu, 21 Aug 2025 13:37:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 13:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1755797844; x=1755884244; bh=OHzdSxo+oI
	Fq7WCJZ8ZDlE1f2O9S770ZN5si4mi888k=; b=GkDK9z8pI/laG3CD5+W4Qs+hp2
	N8An+7eoDkMSunFYmhGa4QgtorpY5NwO0fjjZIQsZceM8XNyWXiX3NSNxnZ7rTBx
	fQ5HhFuUSCFr8ucILb3mfsQrBudb3AQXRER2bYRrVFZqHDouO02Cdl+XQm8tVvKw
	3cOcXPOqYbEWNiEWTmO0fHeYW+ktebnf0LirARy/4kjDT3J/dArWBiu7rTXooe2w
	X3KfgR76OQLfZTPCvbUi9tj0DcB3QVMc92cDTpYUppciIaExJIPo64iC6hj54/sI
	RiUX3evFHJrqs9wnpAi5mU0UVWO9/CKJ84L0WV2cTSjVPyz2C77Dd1daGeDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755797844; x=1755884244; bh=OHzdSxo+oIFq7WCJZ8ZDlE1f2O9S770ZN5s
	i4mi888k=; b=KPZT3m+qeLW90ZAHr932BToB/+z5BtrQbBPEmHIjGxqyJn6zCrS
	I9SD8STX2jhPeflWb9eFSbu77ff84wcLcOnNyDY/G/31E4iQsqe174FafpejNrqe
	Q+zvasc1Hei8fKYI5EQa8XCA4Aj7hFdjcGVWjW48Wb8jH1lHE+eXOx4PqWcCSW7I
	+BGrCjJWxfaEy9VSxFA1pe0HWlqPEMatwcnBgw0abL9PvrsYdEwfrNufHWg/E0SY
	u1S9+vEhPX4MJaXmMVfjlfJGILDOe61E60U+GgNHYFny2/Szj7p3W6ELuQ8aOuhk
	kFVCyNYmevirIF+/HLsgpmcVGoUjM5slrkA==
X-ME-Sender: <xms:U1mnaMxIVQnwIJhE8XpQZNQDQPGK0_53L1oj4GRgURNl93sKsLafsQ>
    <xme:U1mnaAc9ENExiwNOdoxq20q1qCJPNBVNJZbUh0-8_kci0lHlYh8RoRntmjkcRDbYL
    P6UQmOchRQ9LRZfckg>
X-ME-Received: <xmr:U1mnaAKPDBc9Jt1OifWuDx7-0xcyUobGRVhSwdnNbk3l07f0QRNBwv95cBkzc6cVq24x7gxFQa_2oB__kb35Qg7jUXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedukeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U1mnaJEtc5TJqq3jRMuAgpV1pYmX2p8pmdYW6vtE2iazQrcgKztdcA>
    <xmx:U1mnaCqYPg1ZhVD4iZQZnk1EWBhUr-ZVGlhuauPdWVbTkxcLNYnGow>
    <xmx:U1mnaKQ4qW6emMlkbwqkegDvi04glmxSKknd-n8m1Yd5wQv71rbKGw>
    <xmx:U1mnaHNt8kfu965tDRA5g_mWZJtig2wcOSPxRazsOurScwSOVZzOZg>
    <xmx:VFmnaIhYFnK1rOBAslyaFFy1z89EOgJDNuaA6beLA7WRHgOdklmliGtD>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 13:37:23 -0400 (EDT)
Date: Thu, 21 Aug 2025 10:37:54 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v3] btrfs: extract the compressed folio padding into
 a helper
Message-ID: <20250821173754.GB84947@zen.localdomain>
References: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>

On Thu, Aug 21, 2025 at 03:00:54PM +0930, Qu Wenruo wrote:
> Currently after btrfs_compress_folios(), we zero the tail folio at
> compress_file_range() after the btrfs_compress_folios() call.
> 
> However there are several problems with the incoming block size > page
> size support:
> 
> - We may need extra padding folios for the compressed data
>   Or we will submit a write smaller than the block size.
> 
> - The current folio tail zeroing is not covering extra padding folios
> 
> Solve this problem by introducing a dedicated helper,
> pad_compressed_folios(), which will:
> 
> - Do extra basic sanity checks
>   Focusing on the @out_folios and @total_out values.
> 
> - Zero the tailing folio
>   Now we don't need to tail zeroing inside compress_file_range()
>   anymore.
> 
> - Add extra padding zero folios
>   So that for bs > ps cases, the compressed data will always be bs
>   aligned.
> 
>   This also implies we won't allocate dedicated large folios for
>   compressed data.
> 
> Finally since we're here, update the stale comments about
> btrfs_compress_folios().
> 

Padding code looks good to me. Discussed the design questions a bit
inline.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> RFC v2->RFC v3:
> - Fix a failure related to inline compressed data (btrfs/246 failure)
>   The check on whether the resulted compressed data should not happen
>   until we're sure no inlined extent is going to be created.
> 
> RFC v1->RFC v2:
> - Fix a check causes more strict condition for subpage cases
>   Instead comparing the resulted compressed folios number, compare the
>   resulted blocks number instead.
>   For 64K page sized system with 4K block size, it will result any
>   compressed data larger than 64K to be rejected.
>   Even if the compression caused a pretty good result, e.g. 128K ->68K.
> 
> - Remove an unused local variable
> 
> Reason for RFC:
> 
> Although this seems to be a preparation patch for bs > ps support, this
> one will determine the path we go for compressed folios.
> 
> There are 2 methods I can come up with:
> 
> - Allocate dedicated large folios following min_order for compressed
>   folios
>   This is the more common method, used by filemap and will be the method
>   for page cache.

What is the fallback if the min_order allocation fails? Just fail, since
that's what "min" means?

> 
>   The problem is, we will no longer share the compr_pool across all
>   btrfs filesystems, and the dedicated per-fs pool will have a much
>   harder time to fill its pool when memory is fragmented or
>   under-pressure.

I'm curious if you have any data or workloads showing this, or if it is
just a reasonable logical speculation.

> 
>   The benefit is obvious, we will have the insurance that every folio
>   will contain at least one block for bs > ps cases.
> 
> - Allocate page sized folios but add extra padding folios for compressed
>   folios
>   The method I take in this patchset.

Assuming we don't want to straight up fail if we aren't able to allocate
a 128k contiguous folio, we will need this fallback anyway, so I think I
support this approach that you have already taken.

> 
>   The benefit is we can still use the shared compr folios pool, meaning
>   a better latency filling the pool.
> 
>   The problem is we must manually pad the compressed folios.
>   Thankfully the compressed folios are not filemap ones, we don't need
>   to bother about the folio flags at all.
> 
>   Another problem is, we will have different handling for filemap and
>   compressed folios.
>   Filemap folios will have the min_order insurance, but not for
>   compressed folios.
>   I believe the inconsistency is still manageable, at least for now.
> 
> Thus I leave this one as RFC, any feedback will be appreciated.
> ---
>  fs/btrfs/compression.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/inode.c       |  9 ---------
>  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 3291d1ff2722..9cd9182684f3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1024,6 +1024,43 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>  	return 0;
>  }
>  
> +/*
> + * Fill the range between (total_out, round_up(total_out, blocksize)) with zero.
> + *
> + * If bs > ps, also allocate extra folios to ensure the compressed folios are aligned
> + * to block size.
> + */
> +static int pad_compressed_folios(struct btrfs_fs_info *fs_info, struct folio **folios,
> +				 unsigned long orig_len,  unsigned long *out_folios,
> +				 unsigned long *total_out)
> +{
> +	const unsigned long aligned_len = round_up(*total_out, fs_info->sectorsize);
> +	const unsigned long aligned_nr_folios = aligned_len >> PAGE_SHIFT;
> +
> +	ASSERT(aligned_nr_folios <= BTRFS_MAX_COMPRESSED_PAGES);
> +	ASSERT(*out_folios == DIV_ROUND_UP_POW2(*total_out, PAGE_SIZE),
> +	       "out_folios=%lu total_out=%lu", *out_folios, *total_out);

I guess you could avoid the division if you make a different condition
for aligned vs unaligned (and thus use bit shift). I think it's fine,
though, just mentioning.

> +
> +	/* Zero the tailing part of the compressed folio. */
> +	if (!IS_ALIGNED(*total_out, PAGE_SIZE))
> +		folio_zero_range(folios[*total_out >> PAGE_SHIFT], offset_in_page(*total_out),
> +				PAGE_SIZE - offset_in_page(*total_out));
> +
> +	/* Padding the compressed folios to blocksize. */
> +	for (unsigned long cur = *out_folios; cur < aligned_nr_folios; cur++) {
> +		struct folio *folio;
> +
> +		ASSERT(folios[cur] == NULL);
> +		folio = btrfs_alloc_compr_folio();
> +		if (!folio)
> +			return -ENOMEM;
> +		folios[cur] = folio;
> +		folio_zero_range(folio, 0, PAGE_SIZE);
> +		(*out_folios)++;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Given an address space and start and length, compress the bytes into @pages
>   * that are allocated on demand.
> @@ -1033,7 +1070,7 @@ int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>   * - compression algo are 0-3
>   * - the level are bits 4-7
>   *
> - * @out_pages is an in/out parameter, holds maximum number of pages to allocate
> + * @out_folios is an in/out parameter, holds maximum number of pages to allocate
>   * and returns number of actually allocated pages
>   *
>   * @total_in is used to return the number of bytes actually read.  It
> @@ -1060,6 +1097,9 @@ int btrfs_compress_folios(unsigned int type, int level, struct btrfs_inode *inod
>  	/* The total read-in bytes should be no larger than the input. */
>  	ASSERT(*total_in <= orig_len);
>  	put_workspace(fs_info, type, workspace);
> +	if (ret < 0)
> +		return ret;
> +	ret = pad_compressed_folios(fs_info, folios, orig_len, out_folios, total_out);
>  	return ret;
>  }
>  
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0161e1aee96f..b04f48af721a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -864,7 +864,6 @@ static void compress_file_range(struct btrfs_work *work)
>  	unsigned long nr_folios;
>  	unsigned long total_compressed = 0;
>  	unsigned long total_in = 0;
> -	unsigned int poff;
>  	int i;
>  	int compress_type = fs_info->compress_type;
>  	int compress_level = fs_info->compress_level;
> @@ -964,14 +963,6 @@ static void compress_file_range(struct btrfs_work *work)
>  	if (ret)
>  		goto mark_incompressible;
>  
> -	/*
> -	 * Zero the tail end of the last page, as we might be sending it down
> -	 * to disk.
> -	 */
> -	poff = offset_in_page(total_compressed);
> -	if (poff)
> -		folio_zero_range(folios[nr_folios - 1], poff, PAGE_SIZE - poff);
> -
>  	/*
>  	 * Try to create an inline extent.
>  	 *
> -- 
> 2.50.1
> 

