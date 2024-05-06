Return-Path: <linux-btrfs+bounces-4768-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBDB8BC9D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 10:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68FB2827D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17511422A2;
	Mon,  6 May 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b="vBFLldP4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from moint.1and1.com (moint.1and1.com [212.227.15.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6796CDAC
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985037; cv=none; b=Tbk+FQ7V3IgaRtoD01WSl30PE9s+ARF1QnwZ452cJ6KE1eUyv3qKelbP6zytom3A2p7QPxWJIS0ozDp44wmcJ0Ye3kkDkHwIRg8PRjLtbd/H/HADE3eDyRSXRJoeABGZznEgBn9vZlQwmaKFj+eGVXBYiXPpdGQUaKAYHrCUNmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985037; c=relaxed/simple;
	bh=3UgryAVMlVuSdwD/OOf/25G4mrwkXdn7wK0e5Me0RrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UIyvmzHCKkLU1ckESZmnMu1/O/Ci4/p+ffi64W7PgKgnCuA5WOMJVn0wCdyGh7LyUY1t9CSVT1BAshVend+EJi3AJBNMoLWN0WfLiKeTfO8l4NIax6yYYSFWX+oR+HPbHT4/1jOlFzYXh82Z4FoPFTzmgnkLwQgyFCo8fBnlxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de; spf=pass smtp.mailfrom=1und1.de; dkim=pass (2048-bit key) header.d=1und1.de header.i=@1und1.de header.b=vBFLldP4; arc=none smtp.client-ip=212.227.15.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1und1.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1und1.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=1und1.de;
	s=corp1; h=From:CC:To:Subject:MIME-Version:Date:Message-ID:sender:reply-to;
	bh=amoQOERo8lKrNeUC1EoBwdWmaCUeh2VoIDY32Z9IRt8=; b=vBFLldP49wnlKA9334jpHxoqKm
	KxFmk2SRq5NASk9yOjmJPvdzx3E3K8SKOFsYpkAT59qA9LZIJ2nRt5Aq7AdIDW89NU+zHwXRVe4tD
	YD+GN8WTM8ncBSjkBoQ4GJwlt7p55F9vPlezUY9wl0zJ/1aTD6th6C0U3rFioVvMHgJv8hmjb1ecH
	pLEeRSB11g4seTSymOwlgw0JKftuf/3aVS+4JqLRwaioTx99nvUZcOrDYY7UlaNXC2UsebzQK7qU9
	D4forkG5TzPmP4UCDvVtu5zZd0LclWaw4BCeL4Q0f5/B82sCeTdXvXH3taSNRzmFdkpRuANp26fwV
	qpy9DKyQ==;
Received: from [10.98.28.7] (helo=KAPPEX022.united.domain)
	by mrint.1and1.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <julian.taylor@1und1.de>)
	id 1s3tuN-006v5z-1R;
	Mon, 06 May 2024 10:41:15 +0200
Message-ID: <bdeef163-e099-4b70-953e-248bf44ee37f@1und1.de>
Date: Mon, 6 May 2024 10:41:14 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] btrfs: do not wait for short bulk
 allocation" failed to apply to 6.6-stable tree
To: <wqu@suse.com>
CC: <linux-btrfs@vger.kernel.org>
References: <2024041951-sports-hula-f2a5@gregkh>
Content-Language: en-US
From: Julian Taylor <julian.taylor@1und1.de>
Autocrypt: addr=julian.taylor@1und1.de; keydata=
 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
 7oKCuVqh8kE3PYxoRHbuOnFcKDL7dV8w3Mak
In-Reply-To: <2024041951-sports-hula-f2a5@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KAPPEX025.united.domain (10.98.28.10) To
 KAPPEX022.united.domain (10.98.28.7)
X-Virus-Scanned: ClamAV@mvs-ha-bs

Hello,

thank you for swiftly fixing the issue.

As the problem affects the stable releases 6.1 and 6.6 would it be 
possible to backport the fix to these versions so it can make its way 
into distributions?

It is a reasonably simple backport though 6.1 has some differences in 
the ENOMEM situation.

This should apply to 6.6:


--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -686,24 +686,14 @@ int btrfs_alloc_page_array(unsigned int nr_pages, 
struct page **page_array)
          unsigned int last = allocated;

          allocated = alloc_pages_bulk_array(GFP_NOFS, nr_pages, 
page_array);
-
-        if (allocated == nr_pages)
-            return 0;
-
-        /*
-         * During this iteration, no page could be allocated, even
-         * though alloc_pages_bulk_array() falls back to alloc_page()
-         * if  it could not bulk-allocate. So we must be out of memory.
-         */
-        if (allocated == last) {
+        if (unlikely(allocated == last)) {
+            /* No progress, fail and do cleanup. */
              for (int i = 0; i < allocated; i++) {
                  __free_page(page_array[i]);
                  page_array[i] = NULL;
              }
              return -ENOMEM;
          }
-
-        memalloc_retry_wait(GFP_NOFS);
      }
      return 0;
  }


On 19.04.24 12:39, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 1db7959aacd905e6487d0478ac01d89f86eb1e51
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041951-sports-hula-f2a5@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
> 1db7959aacd9 ("btrfs: do not wait for short bulk allocation")
> 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
> 397239ed6a6c ("btrfs: allow extent buffer helpers to skip cross-page handling")
> 94dbf7c0871f ("btrfs: free the allocated memory if btrfs_alloc_page_array() fails")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
>  From 1db7959aacd905e6487d0478ac01d89f86eb1e51 Mon Sep 17 00:00:00 2001
> From: Qu Wenruo <wqu@suse.com>
> Date: Tue, 26 Mar 2024 09:16:46 +1030
> Subject: [PATCH] btrfs: do not wait for short bulk allocation
>
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
> Call memalloc_retry_wait() if it fails to allocate any page for tree
> block allocation (which goes with __GFP_NOFAIL and may not need the
> special handling anyway), and reduce the latency for
> btrfs_alloc_page_array().
>
> Reported-by: Julian Taylor <julian.taylor@1und1.de>
> Tested-by: Julian Taylor <julian.taylor@1und1.de>
> Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
> Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
> CC: stable@vger.kernel.org # 6.1+
> Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index b18034f2ab80..2776112dbdf8 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -681,31 +681,21 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
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
> +			/* No progress, fail and do cleanup. */
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
>

