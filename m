Return-Path: <linux-btrfs+bounces-8330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C45F98AB9F
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 20:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA08B25123
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F589198E92;
	Mon, 30 Sep 2024 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PyUX5sq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4A2AE97
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719499; cv=none; b=kiU8fTBNA56XXz5Xe+rnUzErtOuqit9YBoODg3OppQTuS7QjWPAZR65iF8ER0/vnpo7N3m1uX1clsXHEoFPusFYlXv9mxFOfluRkNk2h9mu/fDnknCCYkSwYjBmP01bQJtnDQZaVUuQ/2fcd8u0/4jq6ZFAC3liggkMvEBiW3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719499; c=relaxed/simple;
	bh=HYS93n9bhJXOMtnhBEhcxZpY3Ru7blKbrfMLxaUkC1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFuOJtxCyOHVM7QQkjuxqHZNXq83T+nlHy9MGq30B4GRNfWJ2b2yQOQPzYAq+Rt6yazMZqU8sn+C36Kphm0G+T4Ej07YtCGAWK871pCGZ3ALfPQG4iHloj46NxqQ5njAn/s21torPQegPuuybd0lEzEnBHGrxgjCdJdNXU46FRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PyUX5sq6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99fd4ea26so406261185a.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727719497; x=1728324297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4sWTI/2xn2gD8NS++R/7FZGnsdnMR56IyiF1GZ4l4Nw=;
        b=PyUX5sq6P0egnWaWvN3dJa4jVkDsmXsoz9RKjl3Fcb+FHveG2sFe5+5YhUx4K16lo3
         XLPfevVxOo4K5fAkBemPJGqj8oVB/YGcWTLLi5KNg0CDMUMJVDnEzDo/4JtLQUio0TvG
         /X/1dMynaH/w/QIea6ONvJeT/dHGZhNeHMpcnz2Mqid6pTiNf5mcBgU64gnx5Oq1hJd7
         GGZc3V1EJNqwb8L1kLnyRD6MFUIyGQWgmT2kCbOLIaoM7i5EV3NhlFAWhgZSs6PNRDzC
         jYC3hrCZMx+dUpOij3yX3BjYKbED59E/Llw5jlk7h0JlDr/lQJByVyjFynhUwrjhq52D
         tA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719497; x=1728324297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sWTI/2xn2gD8NS++R/7FZGnsdnMR56IyiF1GZ4l4Nw=;
        b=QkqGRV7G7hnBBpNwIbILulptspccPBLMkVa4Y8aNSaAuqk4c+TWIPyJ818nDHBc3Qf
         cM5TZYppnjSCX+rzM/oQcXNoa4o0MFAUr353aGnh6Xt5pgkvk+xF2AYJhhe3oDKfCNTv
         z/DugiYymWdzie35cMPLMpGGQsLDO8shgCCfy6GKYFwqv9a4ZrCnWOFLhKOacly148PO
         OVjQvoVQK5qhLQn34yKSehRFd0ycRf56ieyPBdT+HHgEsbui6f0r5d9DR2tezygKVxZd
         3jPjE4z6HO6ppFaln8cO7yzRmk+6hvCffG73rRX2ch3uiXVM1K/0PJ20eZu1MYNA5HCf
         IG+g==
X-Gm-Message-State: AOJu0YxkXfUrzVaWdJ2HCz9VCWCQVOQJefBW1Clkpp2TvSzGj4FJEH90
	gJkdO0g7l5ZskqCK8a6yQ7Z0hoNh0yqPtwboRD/cXx0sw5KO+aE5WMR6zk8kwRBfkePyvQTrXI9
	d
X-Google-Smtp-Source: AGHT+IE7bv22/+YFc7Idb9pk8W39+1bbquK7t54OgOi3/Ty69EGCcwtzv9HVfKVJgqiEpKDImZuEuw==
X-Received: by 2002:a05:620a:1793:b0:7ac:a077:6bce with SMTP id af79cd13be357-7ae37855a25mr2152238185a.34.1727719496647;
        Mon, 30 Sep 2024 11:04:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae3783d613sm434145085a.121.2024.09.30.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:04:55 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:04:54 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: simplify the page uptodate preparation for
 prepare_pages()
Message-ID: <20240930180454.GB667556@perftesting>
References: <cover.1727660754.git.wqu@suse.com>
 <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7504d38c6e6938e4d50e7cee5108a7010e9e8d8.1727660754.git.wqu@suse.com>

On Mon, Sep 30, 2024 at 11:20:30AM +0930, Qu Wenruo wrote:
> Currently inside prepare_pages(), we handle the leading and tailing page
> differently, and skip the middle pages (if any).
> 
> This is to avoid reading pages which is fully covered by the dirty
> range.
> 
> Refactor the code by moving all checks (alignment check, range check,
> force read check) into prepare_uptodate_page().
> 
> So that prepare_pages() only need to iterate all the pages
> unconditionally.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/file.c | 68 +++++++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9555a3485670..cc8edf8da79d 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -858,36 +858,46 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
>   */
>  static int prepare_uptodate_page(struct inode *inode,
>  				 struct page *page, u64 pos,
> -				 bool force_uptodate)
> +				 u64 len, bool force_uptodate)
>  {
>  	struct folio *folio = page_folio(page);
> +	u64 clamp_start = max_t(u64, pos, folio_pos(folio));
> +	u64 clamp_end = min_t(u64, pos + len, folio_pos(folio) + folio_size(folio));
>  	int ret = 0;
>  
> -	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
> -	    !PageUptodate(page)) {
> -		ret = btrfs_read_folio(NULL, folio);
> -		if (ret)
> -			return ret;
> -		lock_page(page);
> -		if (!PageUptodate(page)) {
> -			unlock_page(page);
> -			return -EIO;
> -		}
> +	if (PageUptodate(page))
> +		return 0;
>  
> -		/*
> -		 * Since btrfs_read_folio() will unlock the folio before it
> -		 * returns, there is a window where btrfs_release_folio() can be
> -		 * called to release the page.  Here we check both inode
> -		 * mapping and PagePrivate() to make sure the page was not
> -		 * released.
> -		 *
> -		 * The private flag check is essential for subpage as we need
> -		 * to store extra bitmap using folio private.
> -		 */
> -		if (page->mapping != inode->i_mapping || !folio_test_private(folio)) {
> -			unlock_page(page);
> -			return -EAGAIN;
> -		}
> +	if (force_uptodate)
> +		goto read;
> +
> +	/* The dirty range fully cover the page, no need to read it out. */
> +	if (IS_ALIGNED(clamp_start, PAGE_SIZE) &&
> +	    IS_ALIGNED(clamp_end, PAGE_SIZE))
> +		return 0;
> +read:
> +	ret = btrfs_read_folio(NULL, folio);
> +	if (ret)
> +		return ret;
> +	lock_page(page);
> +	if (!PageUptodate(page)) {
> +		unlock_page(page);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Since btrfs_read_folio() will unlock the folio before it
> +	 * returns, there is a window where btrfs_release_folio() can be
> +	 * called to release the page.  Here we check both inode
> +	 * mapping and PagePrivate() to make sure the page was not
> +	 * released.
> +	 *
> +	 * The private flag check is essential for subpage as we need
> +	 * to store extra bitmap using folio private.
> +	 */
> +	if (page->mapping != inode->i_mapping || !folio_test_private(folio)) {
> +		unlock_page(page);
> +		return -EAGAIN;

Since you're reworking it anyway can you go ahead and convert this to only use
the folio?  Thanks, 

Josef

