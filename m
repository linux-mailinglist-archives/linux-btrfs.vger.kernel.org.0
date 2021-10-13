Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCE42C3EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 16:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhJMOwp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhJMOwo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:52:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3FCC061570
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 07:50:41 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id v10so1797562qvb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Oct 2021 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jEW2+/0qdqWh1Fm4BTWWReCR3DpdVUs3FrUuG7Ko+tU=;
        b=uEEncLph8qZOAr/r8lbEyG5bEcc4C02v8Nja8XyhPhguzrrN1B4bxlggMp0h29fjsr
         C+o3/jiz32Rmj1Zyyf4f3LeR5ENVN5TSUNTvqQY3upPg4SpxsmW4//WLUHJfKpXH8RQj
         bVp9MNWuugusxZ/lin4SeDDR9sujeiB6kF9lh6mmSn8YVb3kWZ6o9Q89xVyIKeU4ifU6
         zYzuPYfRUnrCtO3GNL3zJ3jvHNucHsm1Jnq73cn7AKJV80dIaa2rb3+Fh5G3qLqdPulr
         vAaIg9FSEMTet5TP9FLZEPg6/uJ+Ks/0MtA7xeB0lAq3Q6SGDa0gXr7Qjmw7Mh60Ngl5
         3xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jEW2+/0qdqWh1Fm4BTWWReCR3DpdVUs3FrUuG7Ko+tU=;
        b=QZiJ7+r0jj44n6Tr8zwC1Sm3Af0hmM+PNjE72caxiSVqKQG3VIKYMjxuyafQsFYW+J
         oXVDskKXRsww9mIqW9BnmcnCSaa31XZQUODCqwFFgWas894X6BUO4ZjR3ifnze0u6bG4
         Nj1SRGy7+69BzkEihwVEL74yplOaprJW1s7umZQODX19ZOj994b3B/U0oAPzV52U2m53
         caDaQDXfd9Wkcu4HrIPLC2ykwLlh8EH/IJoub2rTLNsKID24Rk+je6V8CZfliLcx0Nno
         /78s/2ZdXn8urOG9ljyDyvu/OBUptrXqIjLVHOEAogJ3OFxez8wZZyjEH288lLLATtox
         cRqQ==
X-Gm-Message-State: AOAM533Dhv9GP0WTwpenf5w71MjIg2wNY0L6wWctyDVdQKaEfuMCBYRz
        v9FzScRVrFIdEvzon/fucGOPE7r7MHMpMA==
X-Google-Smtp-Source: ABdhPJxxXwQNokEU9Jq+e6giTrDT7diTjJPwz9OhcVMLmi3DcfUTQCDLqOmf8PeD1ABh/yWOZzN9tw==
X-Received: by 2002:a05:6214:29c9:: with SMTP id gh9mr17734302qvb.50.1634136640511;
        Wed, 13 Oct 2021 07:50:40 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 33sm8098682qtc.18.2021.10.13.07.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:50:39 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:50:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 20/26] btrfs: make extent_write_locked_range() to be
 subpage compatible
Message-ID: <YWbyPmlCPtvOvMOZ@localhost.localdomain>
References: <20210927072208.21634-1-wqu@suse.com>
 <20210927072208.21634-21-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927072208.21634-21-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 03:22:02PM +0800, Qu Wenruo wrote:
> There are two sites are not subpage compatible yet for
> extent_write_locked_range():
> 
> - How @nr_pages are calculated
>   For subpage we can have the following range with 64K page size:
> 
>   0   32K  64K   96K 128K
>   |   |////|/////|   |
> 
>   In that case, although 96K - 32K == 64K, thus it looks like one page
>   is enough, but the range spans across two pages, not one.
> 
>   Fix it by doing proper round_up() and round_down() to calculate
>   @nr_pages.
> 
>   Also add some extra ASSERT()s to ensure the range passed in is already
>   aligned.
> 
> - How the page end is calculated
>   Currently we just use cur + PAGE_SIZE - 1 to calculate the page end.
> 
>   Which can't handle above range layout, and will trigger ASSERT() in
>   btrfs_writepage_endio_finish_ordered(), as the range is no longer
>   covered by the page range.
> 
>   Fix it by take page end into consideration.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 825917f1b623..f05d8896d1ad 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5087,15 +5087,14 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>  	struct address_space *mapping = inode->i_mapping;
>  	struct page *page;
>  	u64 cur = start;
> -	unsigned long nr_pages = (end - start + PAGE_SIZE) >>
> -		PAGE_SHIFT;
> +	unsigned long nr_pages;
> +	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
>  	struct extent_page_data epd = {
>  		.bio_ctrl = { 0 },
>  		.extent_locked = 1,
>  		.sync_io = 1,
>  	};
>  	struct writeback_control wbc_writepages = {
> -		.nr_to_write	= nr_pages * 2,
>  		.sync_mode	= WB_SYNC_ALL,
>  		.range_start	= start,
>  		.range_end	= end + 1,
> @@ -5104,14 +5103,24 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
>  		.no_cgroup_owner = 1,
>  	};
>  
> +	ASSERT(IS_ALIGNED(start, sectorsize) &&
> +	       IS_ALIGNED(end + 1, sectorsize));
> +	nr_pages = (round_up(end, PAGE_SIZE) - round_down(start, PAGE_SIZE)) >>
> +		   PAGE_SHIFT;
> +	wbc_writepages.nr_to_write = nr_pages * 2;
> +
>  	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
>  	while (cur <= end) {
> +		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1,
> +				  end);
> +
>  		page = find_get_page(mapping, cur >> PAGE_SHIFT);
>  		/*
>  		 * All pages in the range are locked since
>  		 * btrfs_run_delalloc_range(), thus there is no way to clear
>  		 * the page dirty flag.
>  		 */
> +		ASSERT(PageLocked(page));

We're tripping this ASSERT() with compression turned on, sorry I didn't notice
this but we've been panicing consistently since this was merged, so I've lost a
weeks worth of xfstests runs.  You can easily reproduce running

./check generic/029

with

MOUNT_OPTIONS="-o compress"

Thanks,

Josef
