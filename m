Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8582845CA04
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbhKXQb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 11:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbhKXQb5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 11:31:57 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9EFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 08:28:47 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a24so2162155qvb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Nov 2021 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzhrOLMY6+iLwUWu646F0CiGieMqj2hWMcTJg4sYgKc=;
        b=CkGm+EcmNEt3arxzLDNhXNJWVC6Xs/dLDctZIDx8OUVqecLV9xzqnxtv2CzUvVL5Pg
         nt6cv71XhSRz1jv6XXovHJ9DU5qPd8ibvnrie2fxXpW6d5BN8y1NHaHW6+V1qAdyH8yt
         cnGmlt/3it2oWu4DGPwlBaDbW8yc9vFr8PikXypHJE3XOHGwMKG19Bg+cLquTa/Kug8e
         fKX0HQPa+ZYFr1yvVNJTX2ZHez0iVIlub7QpE/x07frj6C6hxiHmy308/56og/6SfwVB
         rh5VqfE3QiAA6tXAK7AW4RbAw9XVs+klBDQ/C115ZrzsANik5STLVh39MJIMLV+ja1De
         iDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzhrOLMY6+iLwUWu646F0CiGieMqj2hWMcTJg4sYgKc=;
        b=VJU8C8icAOYm7Dwzrgo2i4FgApNKXPTQamVBChvh3z0bTowhnzBlSWwmsTjV8ceaTf
         G6adrxdB16+0Gh0cFmYLxV+XvuNVErC70LWbQWN9R5XLjhsfkQ7AfqCkBA/WbXGEgQQz
         1Oz5dlC/ZOflMFC+tCaJqohTCyuNSykjPOH7r+Y506sBTwhal4zpUCV94Y4mnIo9h1xx
         rNI81Qn/sNSYqm67881lJFFXhuL/nBRlWV4gUu+ICsvCWGou6Uz1QpaNsvjc97/1gAQY
         m4JeQ4Ws+IYjT6Vu54pu19iCuI1M7DZ/Qb8pn6fe97bU937gwb5ddfDnbHLP19tC/yRg
         yK7Q==
X-Gm-Message-State: AOAM530wVdUZEh58GuvJgD17II03pMk3YMoz3aCy88njHKXVatvqxlaE
        43hgvcFshxZzE7gL1wA4ZPTv2w03Dg70+A==
X-Google-Smtp-Source: ABdhPJzb3C/FhcS7wKVGKGoaejqA2UU4qFyidbrMU7YrZnc0V2SKHKRgzx3lbhWMhh8l9sG5AaYUfw==
X-Received: by 2002:a0c:f8cc:: with SMTP id h12mr8873462qvo.6.1637771326178;
        Wed, 24 Nov 2021 08:28:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c24sm108182qkp.43.2021.11.24.08.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 08:28:45 -0800 (PST)
Date:   Wed, 24 Nov 2021 11:28:44 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 03/21] btrfs: zoned: sink zone check into
 btrfs_repair_one_zone
Message-ID: <YZ5oPOZGFTR3s2Ov@localhost.localdomain>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
 <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c38c2f9d1bee46ded4ec491e16398f2f5764200.1637745470.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 01:30:29AM -0800, Johannes Thumshirn wrote:
> Sink zone check into btrfs_repair_one_zone() so we don't need to do it in
> all callers.
> 
> Also as btrfs_repair_one_zone() doesn't return a sensible error, just
> make it a void function.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/extent_io.c |  3 +--
>  fs/btrfs/scrub.c     |  4 ++--
>  fs/btrfs/volumes.c   | 13 ++++++++-----
>  fs/btrfs/volumes.h   |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1654c611d2002..96c2e40887772 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2314,8 +2314,7 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>  	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
>  	BUG_ON(!mirror_num);
>  
> -	if (btrfs_is_zoned(fs_info))
> -		return btrfs_repair_one_zone(fs_info, logical);
> +	btrfs_repair_one_zone(fs_info, logical);
>  
>  	bio = btrfs_bio_alloc(1);
>  	bio->bi_iter.bi_size = 0;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index d175c5ab11349..30bb304bb5e9a 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -852,8 +852,8 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
>  	have_csum = sblock_to_check->pagev[0]->have_csum;
>  	dev = sblock_to_check->pagev[0]->dev;
>  
> -	if (btrfs_is_zoned(fs_info) && !sctx->is_dev_replace)
> -		return btrfs_repair_one_zone(fs_info, logical);
> +	if (!sctx->is_dev_replace)
> +		btrfs_repair_one_zone(fs_info, logical);
>  
>  	/*
>  	 * We must use GFP_NOFS because the scrub task might be waiting for a
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index ae1a4f2a8af64..d0615256dacc3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -8329,23 +8329,26 @@ static int relocating_repair_kthread(void *data)
>  	return ret;
>  }
>  
> -int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
> +void btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
>  {
>  	struct btrfs_block_group *cache;
>  
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +
>  	/* Do not attempt to repair in degraded state */
>  	if (btrfs_test_opt(fs_info, DEGRADED))
> -		return 0;
> +		return;
>  
>  	cache = btrfs_lookup_block_group(fs_info, logical);
>  	if (!cache)
> -		return 0;
> +		return;
>  
>  	spin_lock(&cache->lock);
>  	if (cache->relocating_repair) {
>  		spin_unlock(&cache->lock);
>  		btrfs_put_block_group(cache);
> -		return 0;
> +		return;
>  	}
>  	cache->relocating_repair = 1;
>  	spin_unlock(&cache->lock);
> @@ -8353,5 +8356,5 @@ int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
>  	kthread_run(relocating_repair_kthread, cache,
>  		    "btrfs-relocating-repair");
>  
> -	return 0;
> +	return;

This is extraneous.  Thanks,

Josef
