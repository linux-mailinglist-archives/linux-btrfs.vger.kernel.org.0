Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4105521FB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jun 2022 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiFTQMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Jun 2022 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbiFTQMp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Jun 2022 12:12:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769DD20BCE
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Jun 2022 09:12:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3771F21A09;
        Mon, 20 Jun 2022 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9k3m8xcI+bTt+VkSM6Fdh+aOugZq2l6Ya2IWOMTFiN0=;
        b=SfrwvMg+6NikWLDzGP7IcXO6ZmLOISu1wb+P1LEM+XCBb9ZTG3I5BGdIZVxG+j8cxmNkG9
        7YOr4Y8g4mGrIUU9I6d/IvQRHz4oGd10B8Elzx7s1ZTfoxNKZEbAO9r5OKYGRC5An3nXdR
        Xyt04uIr2P02BSKhWe+sAWY1cZEmEmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741563;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9k3m8xcI+bTt+VkSM6Fdh+aOugZq2l6Ya2IWOMTFiN0=;
        b=rKqTdfQgNtX9oe8hWNEl/xoQiW5EaPH0RMMPvM2EQJRPBzQ60oKJPOKuMpQTQSmPGoM/M/
        cKfYCnbrnOR4vDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12997134CA;
        Mon, 20 Jun 2022 16:12:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bQOAA3ucsGLwEQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 20 Jun 2022 16:12:43 +0000
Date:   Mon, 20 Jun 2022 18:08:06 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: Re: [PATCH] btrfs: zlib: refactor how we prepare the input buffer
Message-ID: <20220620160806.GS20633@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0bfc791b5509df7b9ad44e41ada197d1b3149b3.1655519730.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jun 18, 2022 at 10:39:28AM +0800, Qu Wenruo wrote:
> Inspired by recent kmap() change from Fabio M. De Francesco.
> 
> There are some weird behavior in zlib_compress_pages(), mostly around how
> we prepare the input buffer.
> 
> [BEFORE]
> - We hold a page mapped for a long time
>   This is making it much harder to convert kmap() to kmap_local_page(),
>   as such long mapped page can lead to nested mapped page.
> 
> - Different paths in the name of "optimization"
>   When we ran out of input buffer, we will grab the new input with two
>   different paths:
> 
>   * If there are more than one pages left, we copy the content into the
>     input buffer.
>     This behavior is introduced mostly for S390, as that arch needs
>     multiple pages as input buffer for hardware decompression.
> 
>   * If there is only one page left, we use that page from page cache
>     directly without copying the content.
> 
>   This is making page map/unmap much harder, especially due the latter
>   case.
> 
> [AFTER]
> This patch will change the behavior by introducing a new helper, to
> fulfill the input buffer:
> 
> - Only map one page when we do the content copy
> 
> - Unified path, by always copying the page content into workspace
>   input buffer
>   Yes, we're doing extra page copying. But the original optimization
>   only work for the last page of the input range.
> 
>   Thus I'd say the sacrifice is already not that big.

I don't like that the performance may drop and that there's extra memory
copyiing when not absolutely needed, OTOH it's in zlib code and I think
though it's in use today, the zstd is a sufficient replacement so the
perf drop should have low impact.

> - Use kmap_local_page() and kunmap_local() instead
>   Now the lifespan for the mapped page is only during memcpy() call,
>   we're definitely fine to use kmap_local_page()/kunmap_local().
> 
> Cc: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Only tested on x86_64 for the correctness of the new helper.
> 
> But considering how small the window we need the page to be mapped, I
> think it should also work for x86 without any problem.
> ---
>  fs/btrfs/zlib.c | 85 ++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 767a0c6c9694..2cd4f6fb1537 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -91,20 +91,54 @@ struct list_head *zlib_alloc_workspace(unsigned int level)
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> +/*
> + * Copy the content from page cache into @workspace->buf.
> + *
> + * @total_in:		The original total input length.
> + * @fileoff_ret:	The file offset.
> + *			Will be increased by the number of bytes we read.
> + */
> +static void fill_input_buffer(struct workspace *workspace,
> +			      struct address_space *mapping,
> +			      unsigned long total_in, u64 *fileoff_ret)
> +{
> +	unsigned long bytes_left = total_in - workspace->strm.total_in;
> +	const int input_pages = min(DIV_ROUND_UP(bytes_left, PAGE_SIZE),
> +				    workspace->buf_size / PAGE_SIZE);
> +	u64 file_offset = *fileoff_ret;
> +	int i;
> +
> +	/* Copy the content of each page into the input buffer. */
> +	for (i = 0; i < input_pages; i++) {
> +		struct page *in_page;
> +		void *addr;
> +
> +		in_page = find_get_page(mapping, file_offset >> PAGE_SHIFT);
> +
> +		addr = kmap_local_page(in_page);
> +		memcpy(workspace->buf + i * PAGE_SIZE, addr, PAGE_SIZE);

The workspace->buf is 1 page or 4 pages for x390, so here it looks
confusing that it could overflow and no bounds are explicitly checked
wherether the i * PAGE_SIZE offset is still OK. This would at least
deserve a comment and some runtime checks.
