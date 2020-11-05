Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6557D2A874B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgKETed (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 14:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETed (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 14:34:33 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FDAC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 11:34:33 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so2307664qki.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 11:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hk3RmtGhjOh+j0Wok6Amuv9aBYx4sqQZnq0m/Zgaw1M=;
        b=inhHxuKQs0mI/DeJOAqvuBFgy4qDkrHfGb/686te2B4p2LhY6pQFo6rD3+i4adByhA
         eiASYgB9v8mBqfmiV7OpBuLszlDvEsUnqTXC5HVtwOs5gYAgSSnHBKEqndBYF884yTtX
         SGsQS70QIoBWEL67x/zroQrX+1yXPSVw7H49bmAhU1/D71DDRJvPqh0wBT5AqfsoXI/R
         YI3JbvJ8Yjdcvn1dRTsahh2vRXtG+3nxxt5xJ34yZV4cvdaTz7z9ttQU8bYqu1l6ZOC7
         5TcILO8sfZ28xepaC4weML5vx570W8h/j1PmYm3cS905NXtO9iBXtLn6fGuhAXdgr5yp
         Hqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hk3RmtGhjOh+j0Wok6Amuv9aBYx4sqQZnq0m/Zgaw1M=;
        b=oJ3qlrfD8nbrkO4anTBKUyIc2bcR+9wgFX451vFh3dIOle95/lrSU3VeGsUDoPttAO
         KV2TobIBUOCMMa6JivhMRSjTACFQKjkiDCM2FLlm8Vjkoyz+nixVntduqClnEya4KfV6
         c5BaecL2d2upxzhh6gZJvH5Ws29a8rxtg1RkzDmgpkrMQ9u4w82V0kXjLul1eBjEyS8c
         oj5efx2GpXk6/8LcmgMVKUpU7xO5wf46+fFUAMux5p05IOn0FKOPB5RNltrrsuTgynIb
         16DWMcIalNk4k3E1dCb4eqWOhAB4EXmTKDCePolQ0g5VCpTe6vjjgqsKV8vqvwMhxn4c
         oiAQ==
X-Gm-Message-State: AOAM531fJmsZI06G6paoh0lL7D4vDaIW/kzRBEdFUwxBo6+FDZ3bxjjO
        Fq5KbJydzGsk4pWvFEtAn8YeuQ==
X-Google-Smtp-Source: ABdhPJyI8z9jKnZTnFsSXj5ykjnbTONCmzyHQhVDlhmsQ99fuf4Zkme0D68O0EWbXU9VHGwZUmRcpQ==
X-Received: by 2002:ae9:e709:: with SMTP id m9mr3517384qka.397.1604604872531;
        Thu, 05 Nov 2020 11:34:32 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p8sm1619785qtc.37.2020.11.05.11.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 11:34:31 -0800 (PST)
Subject: Re: [PATCH 02/32] btrfs: extent_io: integrate page status update into
 endio_readpage_release_extent()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-3-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <84f5a26d-467b-f05d-decb-441a46df62d0@toxicpanda.com>
Date:   Thu, 5 Nov 2020 14:34:30 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/3/20 8:30 AM, Qu Wenruo wrote:
> In end_bio_extent_readpage(), we set page uptodate or error according to
> the bio status.  However that assumes all submitted reads are in page
> size.
> 
> To support case like subpage read, we should only set the whole page
> uptodate if all data in the page have been read from disk.
> 
> This patch will integrate the page status update into
> endio_readpage_release_extent() for end_bio_extent_readpage().
> 
> Now in endio_readpage_release_extent() we will set the page uptodate if:
> 
> - start/end range covers the full page
>    This is the existing behavior already.
> 
> - the whole page range is already uptodate
>    This adds the support for subpage read.
> 
> And for the error path, we always clear the page uptodate and set the
> page error.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/extent_io.c | 38 ++++++++++++++++++++++++++++----------
>   1 file changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 58dc55e1429d..228bf0c5f7a0 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2779,13 +2779,35 @@ static void end_bio_extent_writepage(struct bio *bio)
>   	bio_put(bio);
>   }
>   
> -static void endio_readpage_release_extent(struct extent_io_tree *tree, u64 start,
> -					  u64 end, int uptodate)
> +static void endio_readpage_release_extent(struct extent_io_tree *tree,
> +		struct page *page, u64 start, u64 end, int uptodate)
>   {
>   	struct extent_state *cached = NULL;
>   
> -	if (uptodate && tree->track_uptodate)
> -		set_extent_uptodate(tree, start, end, &cached, GFP_ATOMIC);
> +	if (uptodate) {
> +		u64 page_start = page_offset(page);
> +		u64 page_end = page_offset(page) + PAGE_SIZE - 1;
> +
> +		if (tree->track_uptodate) {
> +			/*
> +			 * The tree has EXTENT_UPTODATE bit tracking, update
> +			 * extent io tree, and use it to update the page if
> +			 * needed.
> +			 */
> +			set_extent_uptodate(tree, start, end, &cached, GFP_NOFS);

Why is the switching from GFP_ATOMIC to GFP_NOFS safe here?  If it is it should 
be in it's own patch with it's own explanation.

> +			check_page_uptodate(tree, page);
> +		} else if (start <= page_start && end >= page_end) {
> +			/* We have covered the full page, set it uptodate */
> +			SetPageUptodate(page);
> +		}
> +	} else if (!uptodate){

} else if (!uptodate) {

> +		if (tree->track_uptodate)
> +			clear_extent_uptodate(tree, start, end, &cached);
> +

And this is new.  Please keep logical changes separate.  In this patch you are

1) Changing the GFP pretty majorly.
2) Cleaning up error handling to handle ranges properly.
3) Changing the behavior of EXTENT_UPTODATE for ->track_uptodate trees.

These each require their own explanation and commit so I can understand why 
they're safe to do.  Thanks,

Josef
