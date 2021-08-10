Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98C3E5C1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Aug 2021 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbhHJNrn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Aug 2021 09:47:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56180 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhHJNrn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Aug 2021 09:47:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5B03C2205C;
        Tue, 10 Aug 2021 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628603240;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wisKuHMKthXHwTAKjGYbdUT2dvPuvGd1dQhnNyKw8Zg=;
        b=U6gCo2CB75zrx9vHmdsEkJFbaqbit4ENYQ8Z18i39ik5CNC3HIKy7sdRNkJETxR8SagcIN
        3VsKn/u60W2nw0gN/zAT6idb004UdO/PetIPUhvz1jW3mzNi7IbB85m87hNud5hovg81+T
        Nqeq975ex1a6ZnDb8VXIjVNVHtosTQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628603240;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wisKuHMKthXHwTAKjGYbdUT2dvPuvGd1dQhnNyKw8Zg=;
        b=fGft7jkd7oLX+xl0xtSVIJZIapLpxWvX5qri3S3aM1JLM7LoJpQEUVko3pUyAQ+Thl/jmS
        oKAtqA6sfL8ptkBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0137BA3B8F;
        Tue, 10 Aug 2021 13:47:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 41170DA880; Tue, 10 Aug 2021 15:44:27 +0200 (CEST)
Date:   Tue, 10 Aug 2021 15:44:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: allow disabling of zone auto relcaim
Message-ID: <20210810134425.GR5047@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
References: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56979ba90a8e850da85d2a246d6c10d8c45e8fa5.1628509211.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 09, 2021 at 08:41:17PM +0900, Johannes Thumshirn wrote:
> Automatically reclaiming dirty zones might not always be desired for all
> workloads, especially as there are currently still some rough edges with
> the relocation code on zoned filesystems.
> 
> Allow disabling zone auto reclaim on a per filesystem basis.
> 
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
>  - Use READ_ONCE/WRITE_ONCE
> ---
>  fs/btrfs/free-space-cache.c |  7 ++++---
>  fs/btrfs/sysfs.c            | 10 +++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8eeb65278ac0..05336630cb9f 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -2538,6 +2538,7 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
>  	u64 offset = bytenr - block_group->start;
>  	u64 to_free, to_unusable;
> +	int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
>  
>  	spin_lock(&ctl->tree_lock);
>  	if (!used)
> @@ -2567,9 +2568,9 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
>  	/* All the region is now unusable. Mark it as unused and reclaim */
>  	if (block_group->zone_unusable == block_group->length) {
>  		btrfs_mark_bg_unused(block_group);
> -	} else if (block_group->zone_unusable >=
> -		   div_factor_fine(block_group->length,
> -				   fs_info->bg_reclaim_threshold)) {
> +	} else if (bg_reclaim_threshold &&
> +		   block_group->zone_unusable >=
> +		   div_factor_fine(block_group->length, bg_reclaim_threshold)) {
>  		btrfs_mark_bg_to_reclaim(block_group);
>  	}
>  
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index bfe5e27617b0..7ba09991aa23 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -984,7 +984,8 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
>  	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
>  	ssize_t ret;
>  
> -	ret = scnprintf(buf, PAGE_SIZE, "%d\n", fs_info->bg_reclaim_threshold);
> +	ret = scnprintf(buf, PAGE_SIZE, "%d\n",
> +			READ_ONCE(fs_info->bg_reclaim_threshold));
>  
>  	return ret;
>  }
> @@ -1001,10 +1002,13 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
>  	if (ret)
>  		return ret;
>  
> -	if (thresh <= 50 || thresh > 100)
> +	if (thresh != 0 && (thresh <= 50 || thresh > 100))
>  		return -EINVAL;
>  
> -	fs_info->bg_reclaim_threshold = thresh;
> +	WRITE_ONCE(fs_info->bg_reclaim_threshold, thresh);
> +
> +	if (thresh == 0)
> +		btrfs_info(fs_info, "disabling auto reclaim");

There's no message for adjusting/enabling the reclaim, so either there
should be both or none. I'm not sure we need the messages though, for
sysfs files in general.
