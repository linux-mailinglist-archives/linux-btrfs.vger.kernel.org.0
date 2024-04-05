Return-Path: <linux-btrfs+bounces-3942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDC8992BA
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 03:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785CA1C222E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 01:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23E79C4;
	Fri,  5 Apr 2024 01:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="PorH92pA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0568256D
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712279412; cv=none; b=Wd8vAhxb90WqnNF+EOj7KT5E7gDt+5YNFrZB4Ec3FGJrf9l9eHpTqO5m9RvFjxZjBGm98y0s+CTzGFNoPmvrYtSxEOowXTxhG7mjoakAG1FbTcY0cFsqruK5Hf74fnSl7sYLkjzqTymzSWqwyv04oC+Xw+ReF6mmmaz7pTrOTLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712279412; c=relaxed/simple;
	bh=zcvIX2J3M3r8Up6b3vk/SKQqgcuxjJDX21AXWZ6v8Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIB9xoED5CUf4DTcG/QRKiFYaeG6WcHT2Rs/JZ7b+pdlK+GX9Rm200K6FhXvnajxrlPpjpnuaX/4eM0jQqFZkBb8CzjIheIlCVpqK/HVuTMdXyYlcezCL0ai3PbBkik6L+mIsqtL4l7LFHQQ2pBaJvqpAlGlsyVHgy7NO5FUjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=PorH92pA; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id 994B9804E7;
	Thu,  4 Apr 2024 21:10:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1712279409; bh=zcvIX2J3M3r8Up6b3vk/SKQqgcuxjJDX21AXWZ6v8Ac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PorH92pAvfe5NA8JJhQqejmT5GIbNt5HPPrmpMBP/UeqzNTOVIigk5po43cuW39UD
	 W4NEGiNHHoTFf7K2DJSbmAhQQfJbUcY6N4UMwKMkwqbfGDC59k+4O5fQQqjptcdHCq
	 Xx6YCXroCnWSfhqYNjYUfKB79Q6GzizhZke4oR0wcEorR4rv/zpPzLyFxjk3paDngY
	 guIB/Xq6uDa+g6yxY/q0hWEjWE3MX0NH2aamfC/ldT8j2A//MgB2zm1PktzFb87ham
	 YenhOfe48QfqOMrME/hQrd1NhsloYv+tdH8QRTIatUVyu73JLlJm62ilqRt940lkIP
	 b6ZTI4Fqz3jjw==
Message-ID: <f80bf0eb-a775-48a7-b221-0dcee03126cf@dorminy.me>
Date: Thu, 4 Apr 2024 21:10:06 -0400
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btrfs: do not wait for short bulk allocation
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>, Filipe Manana <fdmanana@suse.com>
References: <78e109cdbec7b11b1832822143d483509abb059e.1712266967.git.wqu@suse.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <78e109cdbec7b11b1832822143d483509abb059e.1712266967.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/4/24 17:43, Qu Wenruo wrote:
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
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v3:
> - Remove wait part completely
>    For NOFAIL metadata allocation, the allocation itself should not fail.
>    For regular allocation, we can afford the failure anyway.
> 
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
>   fs/btrfs/extent_io.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bbdcb7475cea..48476f8fcf79 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -712,31 +712,21 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
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
> -
> -		if (allocated == nr_pages)
> -			return 0;
> -
> -		/*
> -		 * During this iteration, no page could be allocated, even
> -		 * though alloc_pages_bulk_array() falls back to alloc_page()
> -		 * if  it could not bulk-allocate. So we must be out of memory.
> -		 */
> -		if (allocated == last) {
> +		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
> +		if (unlikely(allocated == last)) {
> +			/* Fail and do cleanup. */
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

