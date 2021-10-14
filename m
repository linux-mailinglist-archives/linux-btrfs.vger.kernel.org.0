Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785B942D64E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 11:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJNJo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 05:44:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46462 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJNJo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 05:44:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7D8EB1FD29;
        Thu, 14 Oct 2021 09:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634204542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmEyHKUzCRy9AV28QuEc7joZi6slE8NnI/H0+/4eqgw=;
        b=Vr5i0L4EygEZNXmwEsSg6BHCZZE1hgwdg1PlTKneW54G6i8y3dGLvB1AjXYJ3WaDh0iAq+
        dF9g7NMUl8YzQsToMZhW/NhyFhCw9I+F26CNCqqG1AqqV74cP3O1orgy021UeHtgzzoXM/
        DhboTeXxv0ma0GqELOrmtYtN750ybxE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E8513D7F;
        Thu, 14 Oct 2021 09:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m/zLDX77Z2HTYwAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 14 Oct 2021 09:42:22 +0000
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9e808e25-ed2b-d114-dd50-97f3b7c295fe@suse.com>
Date:   Thu, 14 Oct 2021 12:42:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14.10.21 г. 12:39, Johannes Thumshirn wrote:
> Currently auto reclaim of unusable zones reclaims the block-groups in the
> order they have been added to the reclaim list.
> 
> Change this to a greedy algorithm by sorting the list so we have the
> block-groups with the least amount of valid bytes reclaimed first.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes since v2:
> - Go back to the RFC state, as we must not access ->bg_list
>   without taking the lock. (Nikolay)

So following my feedback on his v2 Johannes added an assert for the
emptylessn of the list which triggered. Turns out that's due to the fact
unpin_extent_range calls __btrfs_add_free_space_zoned which adds a bg
via its ->bg_list to the reclaim list. Actually accessing any of the
blockgroups on reclaim_bgs list without holding unused_bg_lock is wrong,
because even if reclaimi_bgs is spliced to a local list, each individual
block group can still be accessed by other parts of the code and its
->bg_list used to link it to some list, all of this happens under
unused_bgs_lock. So that's the reason why we need to keep the code as is.


> 
> Changes since v1:
> -  Changed list_sort() comparator to 'boolean' style
> 
> Changes since RFC:
> - Updated the patch description
> - Don't sort the list under the spin_lock (David)
> ---
>  fs/btrfs/block-group.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 7dba9028c80c..77e6224866c1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> +#include <linux/list_sort.h>
> +
>  #include "misc.h"
>  #include "ctree.h"
>  #include "block-group.h"
> @@ -1486,6 +1488,21 @@ void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  }
>  
> +/*
> + * We want block groups with a low number of used bytes to be in the beginning
> + * of the list, so they will get reclaimed first.
> + */
> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
> +			   const struct list_head *b)
> +{
> +	const struct btrfs_block_group *bg1, *bg2;
> +
> +	bg1 = list_entry(a, struct btrfs_block_group, bg_list);
> +	bg2 = list_entry(b, struct btrfs_block_group, bg_list);
> +
> +	return bg1->used - bg2->used;
> +}
> +
>  void btrfs_reclaim_bgs_work(struct work_struct *work)
>  {
>  	struct btrfs_fs_info *fs_info =
> @@ -1510,6 +1527,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>  	}
>  
>  	spin_lock(&fs_info->unused_bgs_lock);
> +	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);
>  	while (!list_empty(&fs_info->reclaim_bgs)) {
>  		u64 zone_unusable;
>  		int ret = 0;
> 
