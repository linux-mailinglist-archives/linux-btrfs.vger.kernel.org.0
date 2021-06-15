Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74C33A8276
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 16:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhFOOTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 10:19:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36468 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhFOORj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 10:17:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7278F21968;
        Tue, 15 Jun 2021 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623766533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rn8VePqjYcL61I8nC04cm0Z7AdeNZeXw57w5RSSk4Zw=;
        b=RImwQamw29beivLqL1mAuAIUWrJpVO/3oePmcYfEtOZYuHU0s94bXlvz/Cx5/wXAGqD+xD
        fInKYdAbLOHJDM9zZ1wtZogGAu1020qECBcEYQnA+jKfPNWHFWrAuH4eN0rB1vrnIm+N/O
        3he98AE3x6qN6cmKXEenld0sptuXl8g=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3985C118DD;
        Tue, 15 Jun 2021 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623766533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rn8VePqjYcL61I8nC04cm0Z7AdeNZeXw57w5RSSk4Zw=;
        b=RImwQamw29beivLqL1mAuAIUWrJpVO/3oePmcYfEtOZYuHU0s94bXlvz/Cx5/wXAGqD+xD
        fInKYdAbLOHJDM9zZ1wtZogGAu1020qECBcEYQnA+jKfPNWHFWrAuH4eN0rB1vrnIm+N/O
        3he98AE3x6qN6cmKXEenld0sptuXl8g=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 8siRCwW2yGDFMAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Tue, 15 Jun 2021 14:15:33 +0000
Subject: Re: [RFC PATCH 02/31] iomap: Add submit_io to writepage_ops
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <999c273a4d4fd73ecd9fe80a20e7008eb1124b35.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <927b3563-848a-c193-2bd1-4edbf68f1f91@suse.com>
Date:   Tue, 15 Jun 2021 17:15:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <999c273a4d4fd73ecd9fe80a20e7008eb1124b35.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Filesystems such as btrfs need to perform pre and post bio operations
> such as csum calculations, device mapping etc.
> 
> Add a submit_io() function to writepage_ops so filesystems can control
> how the bio is submitted.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/iomap/buffered-io.c | 11 ++++++++++-
>  include/linux/iomap.h  |  6 ++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d30683734d01..b6fd6d6118a6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1209,7 +1209,11 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
>  		return error;
>  	}
>  
> -	submit_bio(ioend->io_bio);
> +	if (wpc->ops->submit_io)
> +		wpc->ops->submit_io(ioend->io_inode, ioend->io_bio);
> +	else
> +		submit_bio(ioend->io_bio);
> +
>  	return 0;
>  }
>  
> @@ -1305,8 +1309,13 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
>  
>  	if (!merged) {
>  		if (bio_full(wpc->ioend->io_bio, len)) {
> +			struct bio *bio = wpc->ioend->io_bio;
>  			wpc->ioend->io_bio =
>  				iomap_chain_bio(wpc->ioend->io_bio);
> +			if (wpc->ops->submit_io)
> +				wpc->ops->submit_io(inode, bio);
> +			else
> +				submit_bio(bio);

Why do you submit the bio here? It seems iomap_add_to_ioend is used to
build a chain of ioend/bio structures which are then submitted by the
loop in iomap_writepage_map. At the very least this change should go
into a separate patch whose commit message should explain why do you
introduce this new submission point.


>  		}
>  		bio_add_page(wpc->ioend->io_bio, page, len, poff);
>  	}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index c87d0cb0de6d..689d799b1915 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -223,6 +223,12 @@ struct iomap_writeback_ops {
>  	 * we failed to submit any I/O.
>  	 */
>  	void (*discard_page)(struct page *page, loff_t fileoff);
> +
> +	/*
> +	 * Optional, allows the filesystem to perform a custom submission of
> +	 * bio, such as csum calculations or multi-device bio split
> +	 */
> +	void (*submit_io)(struct inode *inode, struct bio *bio);

nit: I'm wondering if we have the ->submit_bio callback doesn't it
really subsume prepare_ioend.

>  };
>  
>  struct iomap_writepage_ctx {
> 
