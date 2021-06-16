Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56D3A9E00
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhFPOsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 10:48:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41486 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhFPOsP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 10:48:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9967F21A56;
        Wed, 16 Jun 2021 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623854768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82cP5QkGHFNq8yA8Oh+NXOj9J+z2MZ9bJzsnJobrd28=;
        b=Fev+gjsnfXv2n8kyi9gnqNAq4VIuolfsGIiq9Q91SMxZWW4sPU0s5SAIEIK/Z0/NpFKJPx
        8unyw7jqGElCpGpMbbf6Ho84VF3l9Q2oqEC2LSXq7wR7YY1pVcBmqmOC3gtQyKADb3bcMX
        uops6bLHOweEyEWQBMEZq8TVN3sYKRw=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6ABCD118DD;
        Wed, 16 Jun 2021 14:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623854768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82cP5QkGHFNq8yA8Oh+NXOj9J+z2MZ9bJzsnJobrd28=;
        b=Fev+gjsnfXv2n8kyi9gnqNAq4VIuolfsGIiq9Q91SMxZWW4sPU0s5SAIEIK/Z0/NpFKJPx
        8unyw7jqGElCpGpMbbf6Ho84VF3l9Q2oqEC2LSXq7wR7YY1pVcBmqmOC3gtQyKADb3bcMX
        uops6bLHOweEyEWQBMEZq8TVN3sYKRw=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4VKoF7AOymDCZgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 16 Jun 2021 14:46:08 +0000
Subject: Re: [RFC PATCH 13/31] btrfs: do not checksum for free space inode
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <acd977c106057ee19f4c965b718460605add1cc0.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <ac68a0ac-3903-1495-d8d5-0120d59dee5d@suse.com>
Date:   Wed, 16 Jun 2021 17:46:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <acd977c106057ee19f4c965b718460605add1cc0.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Free space inode writes should not be checksummed.
> 
> Q: Now sure why this is required now (as opposed to earlier), but it
> would fail on writing free_space_inode. How is this avoided in the
> existing code?
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/disk-io.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index d1d5091a8385..3af505ec22dc 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -946,9 +946,12 @@ blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
>  			goto out_w_error;
>  		ret = btrfs_map_bio(fs_info, bio, mirror_num);
>  	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
> -		ret = btree_csum_one_bio(bio);
> -		if (ret)
> -			goto out_w_error;
> +		/* Do not checksum free space inode */
> +		if (!btrfs_is_free_space_inode(BTRFS_I(inode))) {
> +			ret = btree_csum_one_bio(bio);
> +			if (ret)
> +				goto out_w_error;
> +		}

Something is broken here, the freespace inode is considered a data
inode, this means that this check should always be true i.e this patch
is a null op?  I.e the only inode you should be writing through
submit_metadata_bio is the btree_inode.

>  		ret = btrfs_map_bio(fs_info, bio, mirror_num);
>  	} else {
>  		/*
> 
