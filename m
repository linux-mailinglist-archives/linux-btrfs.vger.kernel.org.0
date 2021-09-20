Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D8D4118A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbhITPvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 11:51:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48802 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242124AbhITPvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 11:51:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B69121D39;
        Mon, 20 Sep 2021 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632153020;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXn6jfn6i66m9jiQTVj3hCXJShFE8xgI2m5jz2dkSXE=;
        b=RHMuk7uKEhxjUBcPyyM9qYX9SIo8mhZEaw5s5hCRcs09fWBPQ6gjhlCSMJs9buvG3WFEDv
        cUp/HJBQ764oZAiHm33FaT0zQvSG+NTXrGF5PyyKqh/eh5PXBSV1EpRiVczrF0utAqnwc6
        kM31SX/3+gU4o2AQS9Iyi8sveTncGEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632153020;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DXn6jfn6i66m9jiQTVj3hCXJShFE8xgI2m5jz2dkSXE=;
        b=J0kRMUzzoXg919ADvZ8U63Zuz8g9L8GHbBFWLWv+LwswZWOavb2A3JWNecNiF+EfZFqwLR
        TjEYTniDLgcKKWDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DFF1DA3BA2;
        Mon, 20 Sep 2021 15:50:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 706E9DA7FB; Mon, 20 Sep 2021 17:50:08 +0200 (CEST)
Date:   Mon, 20 Sep 2021 17:50:07 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] btrfs: zoned: auto reclaim low mostly full
 block-groups first
Message-ID: <20210920155006.GN9286@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
References: <a5b7e730eeeeebd701d807f7aa950dc1f52caade.1632150570.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b7e730eeeeebd701d807f7aa950dc1f52caade.1632150570.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 21, 2021 at 12:11:01AM +0900, Johannes Thumshirn wrote:
> Currently auto reclaim of unusable zones reclaims the block-groups in the
> order they have been added to the reclaim list.
> 
> Sort the list so  we have the block-groups with the least amount of bytes
> to preserve at the beginning before starting the garbage collection loop.

Makes sense as an optimization.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 46fdef7bbe20..d90297fb99e1 100644
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

The sort is under a spinlock, though it's probably not a highly
contended lock, I think we should try to move it outside. Something like

  lock()
  list_splice_init(&splice, &reclaim_bgs)
  unlock()

  list_sort(&splice);

  while (!list_empty(splice)) {
  }

We already use splice in the again_list so it could build on top of it.

OTOH, it may not be absolutelly necessary to do the sort outside of the
lock but rather because as a matter of good programming hygiene to not
introduce unnecessary delays due to contended lock here and there that
could potentially cascade further.
