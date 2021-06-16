Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10A3A9D4B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 16:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhFPORb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 10:17:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbhFPORa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:17:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD8C51FD47;
        Wed, 16 Jun 2021 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623852923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+o0BN/rvAF61FJ7cUN87pPxN1gBSytbMeb9706tnLk=;
        b=civN6El0jAYw9yZkyN+FGIyp/I1uBbNqe/GwAQUPfoQsc0svZH/Zhip4gYdNNz7bHUVIlh
        2OlYxtnaJDs6ibASknIDleXz50NB8/gR67XSmU7R75bb3pqZj3OtjwcxD08w1G7Kvdc1AG
        x+MiQINGgBaW9ETPvZLHJCiJ2gSvmhQ=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 84261118DD;
        Wed, 16 Jun 2021 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623852923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n+o0BN/rvAF61FJ7cUN87pPxN1gBSytbMeb9706tnLk=;
        b=civN6El0jAYw9yZkyN+FGIyp/I1uBbNqe/GwAQUPfoQsc0svZH/Zhip4gYdNNz7bHUVIlh
        2OlYxtnaJDs6ibASknIDleXz50NB8/gR67XSmU7R75bb3pqZj3OtjwcxD08w1G7Kvdc1AG
        x+MiQINGgBaW9ETPvZLHJCiJ2gSvmhQ=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id xpzUHXsHymCPVAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 16 Jun 2021 14:15:23 +0000
Subject: Re: [RFC PATCH 10/31] btrfs: Add btrfs_map_blocks to for
 iomap_writeback_ops
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <5a0fbde3961d867e810a22d240882a91f4f81bba.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3580aadb-2b28-fb51-5f1b-08053536a777@suse.com>
Date:   Wed, 16 Jun 2021 17:15:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5a0fbde3961d867e810a22d240882a91f4f81bba.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_map_blocks() runs delayed allocation range to allcate new CoW
> space if required and returns the io_map associated with the
> location to write.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5491d0e5600f..eff4ec44fecd 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -8283,6 +8283,77 @@ int btrfs_readpage(struct file *file, struct page *page)
>  	return ret;
>  }
>  

<snip>

> +static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
> +		struct inode *inode, loff_t offset)
> +{
> +	int ret;
> +	unsigned long nr_written; /* unused */
> +	int page_started; /* unused */
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	u64 start = round_down(offset, fs_info->sectorsize);
> +	u64 end = 0;
> +
> +	/* Check if iomap is valid */
> +	if (offset >= wpc->iomap.offset &&
> +			offset < wpc->iomap.offset + wpc->iomap.length)

use in_range macro from btrfs/misc.h :

if (in_range(offset, wpc->iomap.offset, wpc->iomap.length))

<snip>
