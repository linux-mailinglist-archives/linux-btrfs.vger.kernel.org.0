Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3B3B699A
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jun 2021 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhF1UZN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Jun 2021 16:25:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhF1UZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Jun 2021 16:25:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8316A2227D;
        Mon, 28 Jun 2021 20:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624911764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziqLhgKqppZ3oSyfE6MHId6omm8RWiOpNVwiWwFFqHk=;
        b=tWw0HMZsObagU7Sw29Rw+IJmGPZtO/3qe+qs6mD7kcSihUPG/w6nQ1+C2rYTMmf6LoOdJ3
        P6EXjC/bmGPZRfaF3LR33KQQm2BKW7f4t3DjHAFAXZNRfTGaFcdvaEpeuv0BpeJLCnZ/Tw
        kWBTW5vWQ4w7rlG4eWURAAyat/7Go/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624911764;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ziqLhgKqppZ3oSyfE6MHId6omm8RWiOpNVwiWwFFqHk=;
        b=gsClOjHjamaj5dSp2X9j41G5O0hv1KKwPPhQlAeNMPoEpoWgvsKnmBq6losR27ZS7ZrQBW
        mBzweV/CXeNeqXAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 85E25A3B8C;
        Mon, 28 Jun 2021 20:22:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D813DA7F7; Mon, 28 Jun 2021 22:20:14 +0200 (CEST)
Date:   Mon, 28 Jun 2021 22:20:14 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] btrfs: zoned: remove fs_info->max_zone_append_size
Message-ID: <20210628202013.GG2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>
References: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7f717432896b5f12847435727838b32bd6e2b35.1624905177.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 29, 2021 at 03:36:45AM +0900, Johannes Thumshirn wrote:
> Remove fs_info->max_zone_append_size, it doesn't serve any purpose.

Why was it added then? Commit 862931c76327 ("btrfs: introduce
max_zone_append_size") states some reasons so you should explain why
it's not needed now. It's a partial revert of the commit.

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v1:
> - also remove the local max_zone_append_size variable in
>   btrfs_check_zoned_mode() (Anand)
> ---
>  fs/btrfs/ctree.h     |  2 --
>  fs/btrfs/extent_io.c |  1 -
>  fs/btrfs/zoned.c     | 10 ----------
>  3 files changed, 13 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d7ef4d7d2c1a..7a9cf4d12157 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1014,8 +1014,6 @@ struct btrfs_fs_info {
>  		u64 zoned;
>  	};
>  
> -	/* Max size to emit ZONE_APPEND write command */
> -	u64 max_zone_append_size;
>  	struct mutex zoned_meta_io_lock;
>  	spinlock_t treelog_bg_lock;
>  	u64 treelog_bg;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 9e81d25dea70..1f947e24091a 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3266,7 +3266,6 @@ static int calc_bio_boundaries(struct btrfs_bio_ctrl *bio_ctrl,
>  		return 0;
>  	}
>  
> -	ASSERT(fs_info->max_zone_append_size > 0);
>  	/* Ordered extent not yet created, so we're good */
>  	ordered = btrfs_lookup_ordered_extent(inode, logical);
>  	if (!ordered) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 297c0b1c0634..76754e441e20 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -529,7 +529,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  	u64 zoned_devices = 0;
>  	u64 nr_devices = 0;
>  	u64 zone_size = 0;
> -	u64 max_zone_append_size = 0;
>  	const bool incompat_zoned = btrfs_fs_incompat(fs_info, ZONED);
>  	int ret = 0;
>  
> @@ -565,11 +564,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  				ret = -EINVAL;
>  				goto out;
>  			}
> -			if (!max_zone_append_size ||
> -			    (zone_info->max_zone_append_size &&
> -			     zone_info->max_zone_append_size < max_zone_append_size))
> -				max_zone_append_size =
> -					zone_info->max_zone_append_size;
>  		}
>  		nr_devices++;
>  	}
> @@ -619,7 +613,6 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>  	}
>  
>  	fs_info->zone_size = zone_size;
> -	fs_info->max_zone_append_size = max_zone_append_size;
>  	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
>  
>  	/*
> @@ -1318,9 +1311,6 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
>  	if (!btrfs_is_zoned(fs_info))
>  		return false;
>  
> -	if (!fs_info->max_zone_append_size)
> -		return false;
> -
>  	if (!is_data_inode(&inode->vfs_inode))
>  		return false;
>  
> -- 
> 2.31.1
