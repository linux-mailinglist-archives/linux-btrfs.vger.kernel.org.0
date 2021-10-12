Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428D342A683
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Oct 2021 15:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhJLN6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 09:58:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbhJLN6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 09:58:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 693B12218A;
        Tue, 12 Oct 2021 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634046962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byLEtF7kMITa43qTnV61Hu1g/XSZrrextIF4SX0dS8k=;
        b=RDbFZ3Vnz9d/BuJkoAcUulxj+f4YlfhNmkgFAE4ZJ4u0JE2rnyDUubyXOLXFZVO0MjyCcx
        3TyCAxte4yhd1X+GGBQceIcanMxwKNbBJGyfVzCnz+lVcx8iIjxvYfdh7e9h9wACSySDNi
        1Dphr8ZgJ0w/tTr/ST83Vf25y0xR4Ow=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1291A13BEC;
        Tue, 12 Oct 2021 13:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o7+LAPKTZWGXdgAAMHmgww
        (envelope-from <nborisov@suse.com>); Tue, 12 Oct 2021 13:56:01 +0000
Subject: Re: [PATCH v2] btrfs: zoned: use greedy gc for auto reclaim
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <3d5b7f4e-646b-8430-6970-e287ebbb7719@suse.com>
Date:   Tue, 12 Oct 2021 16:56:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <75b42490e41e7c7bf49c07c76fb93764a726c621.1634035992.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.10.21 г. 15:37, Johannes Thumshirn wrote:
> Currently auto reclaim of unusable zones reclaims the block-groups in the
> order they have been added to the reclaim list.
> 
> Change this to a greedy algorithm by sorting the list so we have the
> block-groups with the least amount of valid bytes reclaimed first.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes since v1:
> -  Changed list_sort() comparator to 'boolean' style
> 
> Changes since RFC:
> - Updated the patch description
> - Don't sort the list under the spin_lock (David)

<snip>


> @@ -1510,17 +1528,20 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	}
>  
>  	spin_lock(&fs_info->unused_bgs_lock);
> -	while (!list_empty(&fs_info->reclaim_bgs)) {
> +	list_splice_init(&fs_info->reclaim_bgs, &reclaim_list);
> +	spin_unlock(&fs_info->unused_bgs_lock);
> +
> +	list_sort(NULL, &reclaim_list, reclaim_bgs_cmp);
> +	while (!list_empty(&reclaim_list)) {

Nit: Now that you've switched to a local reclaim_list you can convert
the while to a list_for_each_entry_safe, since it's guaranteed that new
entries can't be added while you are iterating the list, which is
generally the reason why a while() is preferred to one of the iteration
helpers.

>  		u64 zone_unusable;
>  		int ret = 0;
>  
> -		bg = list_first_entry(&fs_info->reclaim_bgs,
> +		bg = list_first_entry(&reclaim_list,
>  				      struct btrfs_block_group,
>  				      bg_list);
>  		list_del_init(&bg->bg_list);
>  
>  		space_info = bg->space_info;
> -		spin_unlock(&fs_info->unused_bgs_lock);
>  
>  		/* Don't race with allocators so take the groups_sem */
>  		down_write(&space_info->groups_sem);
> @@ -1568,12 +1589,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  				  bg->start);
>  
>  next:
> -		spin_lock(&fs_info->unused_bgs_lock);
>  		if (ret == -EAGAIN && list_empty(&bg->bg_list))
>  			list_add_tail(&bg->bg_list, &again_list);
>  		else
>  			btrfs_put_block_group(bg);
>  	}
> +	spin_lock(&fs_info->unused_bgs_lock);
>  	list_splice_tail(&again_list, &fs_info->reclaim_bgs);
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  	mutex_unlock(&fs_info->reclaim_bgs_lock);
> 
