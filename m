Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6011A4292A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 16:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbhJKOyp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Oct 2021 10:54:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37984 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbhJKOyj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Oct 2021 10:54:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9DBD71FEBE;
        Mon, 11 Oct 2021 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633963958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6GwyHkMZv0f6Fcg4ceBe127RmQTNWZ+wAG6FtQ4wA4=;
        b=prs8kgOFllabN+hjSBCEeUs73JcbsgnJ2AgRA0maFKuf/Lr28yw+fsuoaHugBzBtVJ1lHQ
        dHVyEHJQgcS8F/++r5bB7h2tf3a5UqKTj0KgRZzAOGuhyhvml2qbUSUiGlQ5+tVFdzh5zp
        7c6y23qiMMsfM1QfYMjBQjJrdy/PQF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633963958;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t6GwyHkMZv0f6Fcg4ceBe127RmQTNWZ+wAG6FtQ4wA4=;
        b=RoMjx2As0cGWaIo8x0aoul7sFEtMiaWu3mZbi0IVsXBWrteSNoFsqMtsEIg47z8aRuaW5+
        EBrBnbbyj43hzvCg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6C05FA3B90;
        Mon, 11 Oct 2021 14:52:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46FFDDA781; Mon, 11 Oct 2021 16:52:15 +0200 (CEST)
Date:   Mon, 11 Oct 2021 16:52:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: use greedy gc for auto reclaim
Message-ID: <20211011145215.GN9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <d09710513b6f8ad50973d894129b1dd441f2ab83.1633950641.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09710513b6f8ad50973d894129b1dd441f2ab83.1633950641.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 11, 2021 at 08:11:32PM +0900, Johannes Thumshirn wrote:
> Currently auto reclaim of unusable zones reclaims the block-groups in the
> order they have been added to the reclaim list.
> 
> Change this to a greedy algorithm by sorting the list so we have the
> block-groups with the least amount of valid bytes reclaimed first.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes since RFC:
> - Updated the patch description
> - Don't sort the list under the spin_lock (David)
> ---
>  fs/btrfs/block-group.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 46fdef7bbe20..930c07cdad81 100644
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

It returns int but compares two u64, this should be either a if chaing
comparing all the possibilities or properly cast to s64.
