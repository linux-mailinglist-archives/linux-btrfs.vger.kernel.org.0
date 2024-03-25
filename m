Return-Path: <linux-btrfs+bounces-3573-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814588B497
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A5F1F3E2B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCD82D6C;
	Mon, 25 Mar 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="gf8QaoDX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD6823DB
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711407471; cv=none; b=Aa9AHw+Aen9Qow4lSWTTM6do4TJBQcj0CWzHMICe9e0j0Y0ld8fNA569KQMYnWanIK7xoS1Uxb4vNFKzIeXrsLbaysoCPVBZjbeaG4rwzzE0j2fre38CkIEeeSHi6/gZhudm8ld3qm4QxI7ZX5SHgXXlCx6sJ0NYJ9G1NT/L3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711407471; c=relaxed/simple;
	bh=8yHuW646JTUOXNDxx4etIyTFAlf7TWe7t3eS400nNxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/BrvA3nTy4JeU09UiDc+llzZuhz3Rgb5meuRRf+ypC3IFbaqG0jOKhC7Tfd2Z+GeBVhFaIQtSaOUg2BNWWTjtVnvZlDhV4ylbrYESlnOQtfDYTbd6RzSHvR186Kv810YQwGDJQjz9KayXUEjc5gQ3BvwFhXmegY8DjM1DQi4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=gf8QaoDX; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id CEFE18282E;
	Mon, 25 Mar 2024 18:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1711407469; bh=8yHuW646JTUOXNDxx4etIyTFAlf7TWe7t3eS400nNxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gf8QaoDX5hBu7ulHVZwxHHVE2BcsQ7t4LJfZ5JV2g8ksWjilQOCjX0VojK7Yi/3uh
	 G2kFE3oc7jK4gx4JQq5ma0fJc/kz9OuYayUgoFmJX7BfWnPpSF8A7iwglHH/L/Q/QD
	 jHA6t7k2fRDJUkdcEEeqeZ5kjULiciPKPPvTfHAFhYDhDKNAYmFK4t9iLlWMvn1xhJ
	 dR7FaL18FpScFFf+b/RCDoMDff2sc3tMuH/CJ1GiOBnkk2InpiLbNi6gewZOyyYp0s
	 XJR+I6rX8B3rFybp0DQWy7A0qMsnx+4Y0xsdSNv8xPno+AUrm2mdlB1yd1ctOHotIc
	 s5qobwT0u2hGA==
Message-ID: <6502f543-1fb6-4aaf-bbba-effd69c1cc7f@dorminy.me>
Date: Mon, 25 Mar 2024 18:57:37 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] btrfs: do not wait for short bulk allocation
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>, Filipe Manana <fdmanana@suse.com>
References: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks!!

On 3/25/24 18:46, Qu Wenruo wrote:
> [BUG]
> There is a recent report that when memory pressure is high (including
> cached pages), btrfs can spend most of its time on memory allocation in
> btrfs_alloc_page_array() for compressed read/write.
> 
> [CAUSE]
> For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
> even if the bulk allocation failed (fell back to single page
> allocation) we still retry but with extra memalloc_retry_wait().
> 
> If the bulk alloc only returned one page a time, we would spend a lot of
> time on the retry wait.
> 
> The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
> incomplete batch memory allocations").
> 
> [FIX]
> Although the commit mentioned that other filesystems do the wait, it's
> not the case at least nowadays.
> 
> All the mainlined filesystems only call memalloc_retry_wait() if they
> failed to allocate any page (not only for bulk allocation).
> If there is any progress, they won't call memalloc_retry_wait() at all.
> 
> For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
> if there is no allocation progress at all, and the call is not for
> metadata readahead.
> 
> So I don't believe we should call memalloc_retry_wait() unconditionally
> for short allocation.
> 
> This patch would only call memalloc_retry_wait() if failed to allocate
> any page for tree block allocation (which goes with __GFP_NOFAIL and may
> not need the special handling anyway), and reduce the latency for
> btrfs_alloc_page_array().
> 
> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> Tested-by: Julian Taylor <julian.taylor@1und1.de>
> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

> ---
> Changelog:
> v2:
> - Still use bulk allocation function
>    Since alloc_pages_bulk_array() would fall back to single page
>    allocation by itself, there is no need to go alloc_page() manually.
> 
> - Update the commit message to indicate other fses do not call
>    memalloc_retry_wait() unconditionally
>    In fact, they only call it when they need to retry hard and can not
>    really fail.
> ---
>   fs/btrfs/extent_io.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 7441245b1ceb..c96089b6f388 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
>   int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>   			   gfp_t extra_gfp)
>   {
> +	const gfp_t gfp = GFP_NOFS | extra_gfp;
>   	unsigned int allocated;
>   
>   	for (allocated = 0; allocated < nr_pages;) {
>   		unsigned int last = allocated;
>   
> -		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
> -						   nr_pages, page_array);
> +		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
> +		if (unlikely(allocated == last)) {
> +			/* Can not fail, wait and retry. */
> +			if (extra_gfp & __GFP_NOFAIL) {
> +				memalloc_retry_wait(GFP_NOFS);
> +				continue;
> +			}
>   
> -		if (allocated == nr_pages)
> -			return 0;
> -
> -		/*
> -		 * During this iteration, no page could be allocated, even
> -		 * though alloc_pages_bulk_array() falls back to alloc_page()
> -		 * if  it could not bulk-allocate. So we must be out of memory.
> -		 */
> -		if (allocated == last) {
> +			/* Allowed to fail, error out. */
>   			for (int i = 0; i < allocated; i++) {
>   				__free_page(page_array[i]);
>   				page_array[i] = NULL;
>   			}
>   			return -ENOMEM;
>   		}
> -
> -		memalloc_retry_wait(GFP_NOFS);
>   	}
>   	return 0;
>   }

