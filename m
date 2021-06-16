Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EF33A9D93
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhFPO3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 10:29:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37944 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhFPO26 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:28:58 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF60221A5A;
        Wed, 16 Jun 2021 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623853611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FS/yC5LQ1DEik07TznzSC8md1RybUQcoal+lqf0Cu0E=;
        b=oc5hmuNvwyuhVUPXTdIG07/lhOyhy7MaMDkBy0pLRr6N8n11Ug4yuqmXZbjV9aqvktsTuY
        t3/9+hU8dht1feXuojaek5KGRdwcEkgBO6/tuzdQQdznGO2UWxviDnWxQaa6I5MjAfdPGx
        hKlQXSA2r61+hXdniJ0Yi7R3n2uVug4=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7C620118DD;
        Wed, 16 Jun 2021 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623853611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FS/yC5LQ1DEik07TznzSC8md1RybUQcoal+lqf0Cu0E=;
        b=oc5hmuNvwyuhVUPXTdIG07/lhOyhy7MaMDkBy0pLRr6N8n11Ug4yuqmXZbjV9aqvktsTuY
        t3/9+hU8dht1feXuojaek5KGRdwcEkgBO6/tuzdQQdznGO2UWxviDnWxQaa6I5MjAfdPGx
        hKlQXSA2r61+hXdniJ0Yi7R3n2uVug4=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Jsp5GysKymAOWwAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 16 Jun 2021 14:26:51 +0000
Subject: Re: [RFC PATCH 11/31] btrfs: Use submit_io to submit btrfs writeback
 bios
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <b281a2a58372728b86453a0cc6506d4bf5e68fa3.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <c53e98e0-310d-793c-bfd5-b52a7199f678@suse.com>
Date:   Wed, 16 Jun 2021 17:26:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b281a2a58372728b86453a0cc6506d4bf5e68fa3.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> The submit_io sequence calls set_page_extent_mapped() for data
> inodes to make sure that page->private is set. Depending on
> the type of inode: metadata or data, the respective submit_bio
> function is called.
> 
> This will also be used for readpage() sequence.
> ---
>  fs/btrfs/inode.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index eff4ec44fecd..87d0730f59d8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8349,11 +8349,26 @@ static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
>  	return btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
>  }
>  
> +static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
> +{
> +	struct bio_vec *bvec;
> +	struct bvec_iter_all iter_all;
> +
> +	if (is_data_inode(inode))
> +		bio_for_each_segment_all(bvec, bio, iter_all)
> +			set_page_extent_mapped(bvec->bv_page);
> +
> +	if (is_data_inode(inode))
> +		btrfs_submit_data_bio(inode, bio, 0, 0);
> +	else
> +		btrfs_submit_metadata_bio(inode, bio, 0, 0);

Move the submit_data_bio into the first if() and then
submit_metadata_bio into an else clause. That way you'll have just a
single check in this function.

> +}
> +
>  static const struct iomap_writeback_ops btrfs_writeback_ops = {
>  	.map_blocks             = btrfs_map_blocks,
> +	.submit_io		= btrfs_buffered_submit_io,
>  };
>  
> -
>  static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
>  {
>  	struct inode *inode = page->mapping->host;
> 
