Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7228943232D
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Oct 2021 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhJRPol (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 11:44:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhJRPol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 11:44:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6904521961;
        Mon, 18 Oct 2021 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634571749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzuJlaPUS4s2lX1GmY3fQCafA4wSmo1rBXDXaHB8RfE=;
        b=CCdtITAA8WjcunXG2P6v89bMsIO2FwmAiR3AqmSGo5S/8ds68bytoNJRTi6dpe4nehq1Xp
        2sQF+s7twDQxNr70QgOi/vEbsxqXN+eY9+PnPW8AVm2zOGu1sAHGmjqcV46IPfpPlBwrRQ
        oPPW03zuuHBbxZmaOi+KbfQdZN35D4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634571749;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzuJlaPUS4s2lX1GmY3fQCafA4wSmo1rBXDXaHB8RfE=;
        b=MDT09aJ74WHqoQKjR2btIVyk1o75FAU8OjQf2R2BnrYHSzLF4cPd7NTBzl376wD+K+0ChL
        hbOOBDDVKdZ3AoDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 61493A3B81;
        Mon, 18 Oct 2021 15:42:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EC60DA7A3; Mon, 18 Oct 2021 17:42:02 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:42:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3] btrfs: zoned: btrfs: zoned: use greedy gc for auto
 reclaim
Message-ID: <20211018154202.GM30611@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
References: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667291b2902cad926bbff8d5e9124166796cba32.1634204285.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 14, 2021 at 06:39:02PM +0900, Johannes Thumshirn wrote:
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

So you also reverted to v1 the compare condition, this should be < so
it's the valid stable sort condition.
