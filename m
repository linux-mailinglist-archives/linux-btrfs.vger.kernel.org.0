Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55573A828E
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 16:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhFOOVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 10:21:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33418 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbhFOOTP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 10:19:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B68AA1FD49;
        Tue, 15 Jun 2021 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623766629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JVyQwYz2svcAr/ZY06AiYicx+BXp0Hz+pc8SSM2ddQ=;
        b=cehEPJqWIj53UCg2xIO665clT2r1D+hccSc25YHGHA3fHtlFeY5PsJBk2ZWtzyJg/hHekw
        FZT0UTqZLJ1QOAj/VY5vbzH5P4kwTXZeb/7CfR7EpNp1RefZ2VmlKluuPOqwg1GO+40+Ef
        U4nPhIgxAVVGJWyi64qLmiXcMD9BMkg=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8880C118DD;
        Tue, 15 Jun 2021 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623766629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0JVyQwYz2svcAr/ZY06AiYicx+BXp0Hz+pc8SSM2ddQ=;
        b=cehEPJqWIj53UCg2xIO665clT2r1D+hccSc25YHGHA3fHtlFeY5PsJBk2ZWtzyJg/hHekw
        FZT0UTqZLJ1QOAj/VY5vbzH5P4kwTXZeb/7CfR7EpNp1RefZ2VmlKluuPOqwg1GO+40+Ef
        U4nPhIgxAVVGJWyi64qLmiXcMD9BMkg=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id UmEMH2W2yGC8MQAALh3uQQ
        (envelope-from <nborisov@suse.com>); Tue, 15 Jun 2021 14:17:09 +0000
Subject: Re: [RFC PATCH 01/31] iomap: Check if blocksize == PAGE_SIZE in
 to_iomap_page()
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <79781ca99470475ff33382e67571eeb914edac63.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9ba35f37-8876-c635-5d46-dd8682833f20@suse.com>
Date:   Tue, 15 Jun 2021 17:17:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <79781ca99470475ff33382e67571eeb914edac63.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs requires page->private set to get a callback to releasepage(). 

nit: This is somewhat terse of an explanation and someone not familiar
with btrfs might wonder what's going on. In fact, btrfs uses the
PagePrivate flag to indicate that the page has undergone CoW and has
ordered extents created. And this is in fact problematic because iomap
assume page_private is not in use by the underlying fs.

So,
> for normal circumstances of blocksize==PAGE_SIZE, btrfs will have
> page->private set to 1. In order to avoid a crash, check for the
> blocksize==PAGE_SIZE in to_iomap_page().
> ---
>  fs/iomap/buffered-io.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9023717c5188..d30683734d01 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -41,9 +41,11 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
>  	 */
>  	VM_BUG_ON_PGFLAGS(PageTail(page), page);
>  
> -	if (page_has_private(page))
> -		return (struct iomap_page *)page_private(page);
> -	return NULL;
> +	if (i_blocksize(page->mapping->host) == PAGE_SIZE)
> +		return NULL;
> +	if (!page_has_private(page))
> +		return NULL;
> +	return (struct iomap_page *)page_private(page);
>  }
>  
>  static struct bio_set iomap_ioend_bioset;
> @@ -163,7 +165,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  	if (PageError(page))
>  		return;
>  
> -	if (page_has_private(page))
> +	if (i_blocksize(page->mapping->host) != PAGE_SIZE)
>  		iomap_iop_set_range_uptodate(page, off, len);
>  	else
>  		SetPageUptodate(page);
> 
