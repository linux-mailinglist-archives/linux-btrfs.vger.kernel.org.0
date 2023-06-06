Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5358B723898
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjFFHOX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 03:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjFFHOB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 03:14:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F843E79;
        Tue,  6 Jun 2023 00:13:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 927F01FD6B;
        Tue,  6 Jun 2023 07:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686035604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zXSead29cb/X6WK/OYs0Rg2NSA3cgXeSg/kRze2eug=;
        b=vZPMzrCFuY4OnmVChtWdybbiDkORnG6eghm6v2X1KX/29qN1JPMouWJPHvVAj6fcLn9dGY
        vOSUfJsbwRBzccvVXI5/YlONk+U6bkP3jXLzE14fIHkHe6zTeiwLQYXldOc2WAejh25NfC
        xBWNpqn5gucE0/PvgRp1Y8E4/aegpAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686035604;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zXSead29cb/X6WK/OYs0Rg2NSA3cgXeSg/kRze2eug=;
        b=BLBwK9YsJFmV9jap45BLaAwocFUnobvByD7sG/S+o0TCEQCd6Lumw5fMvYzUnsHBm1CEJs
        od9TGUxdDaetxhAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BAD813519;
        Tue,  6 Jun 2023 07:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HAOuFZTcfmTyBQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 06 Jun 2023 07:13:24 +0000
Message-ID: <cd47d6ac-69ce-0315-dd45-2cb9dce57f36@suse.cz>
Date:   Tue, 6 Jun 2023 09:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] mm/vmalloc: do not output a spurious warning when huge
 vmalloc() fails
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux btrfs <linux-btrfs@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, a1bert@atlas.cz,
        Forza <forza@tnonline.net>
References: <20230605201107.83298-1-lstoakes@gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230605201107.83298-1-lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 6/5/23 22:11, Lorenzo Stoakes wrote:
> In __vmalloc_area_node() we always warn_alloc() when an allocation
> performed by vm_area_alloc_pages() fails unless it was due to a pending
> fatal signal.
> 
> However, huge page allocations instigated either by vmalloc_huge() or
> __vmalloc_node_range() (or a caller that invokes this like kvmalloc() or
> kvmalloc_node()) always falls back to order-0 allocations if the huge page
> allocation fails.
> 
> This renders the warning useless and noisy, especially as all callers
> appear to be aware that this may fallback. This has already resulted in at
> least one bug report from a user who was confused by this (see link).
> 
> Therefore, simply update the code to only output this warning for order-0
> pages when no fatal signal is pending.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1211410
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

I think there are more reports of same thing from the btrfs context, that
appear to be a 6.3 regression

https://bugzilla.kernel.org/show_bug.cgi?id=217466
Link: https://lore.kernel.org/all/efa04d56-cd7f-6620-bca7-1df89f49bf4b@gmail.com/

If this indeed helps, it would make sense to Cc: stable here. Although I
don't see what caused the regression, the warning itself is not new, so is
it new source of order-9 attempts in vmalloc() or new reasons why order-9
pages would not be possible to allocate?

> ---
>  mm/vmalloc.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ab606a80f475..e563f40ad379 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3149,11 +3149,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * allocation request, free them via vfree() if any.
>  	 */
>  	if (area->nr_pages != nr_small_pages) {
> -		/* vm_area_alloc_pages() can also fail due to a fatal signal */
> -		if (!fatal_signal_pending(current))
> +		/*
> +		 * vm_area_alloc_pages() can fail due to insufficient memory but
> +		 * also:-
> +		 *
> +		 * - a pending fatal signal
> +		 * - insufficient huge page-order pages
> +		 *
> +		 * Since we always retry allocations at order-0 in the huge page
> +		 * case a warning for either is spurious.
> +		 */
> +		if (!fatal_signal_pending(current) && page_order == 0)
>  			warn_alloc(gfp_mask, NULL,
> -				"vmalloc error: size %lu, page order %u, failed to allocate pages",
> -				area->nr_pages * PAGE_SIZE, page_order);
> +				"vmalloc error: size %lu, failed to allocate pages",
> +				area->nr_pages * PAGE_SIZE);
>  		goto fail;
>  	}
>  

