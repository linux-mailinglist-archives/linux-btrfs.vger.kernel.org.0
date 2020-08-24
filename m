Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4325043A
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHXQ73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Aug 2020 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgHXQ7U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Aug 2020 12:59:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD75C061573
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 09:59:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e5so6672274qth.5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 09:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oV/VSYZqqIumRH5P+eqTsnDgmKBm+ARcUHmfbDUpqys=;
        b=rqsdQH6ZBov+W6pWeEDyGZOwMYxLmZ/0tLItv7Us+oQ1819i+TxeURbgZ40ykfeRQj
         PDDh75U+1QWtkE68Z4GHBgOkpQ93mVsosqIVdRnLgGpOto6p7j+aiHUlB14Di/9q1K8p
         bEImsItUfiIDtU9b+bDG8wnj8b5IW5xkxDXdvVy5OBlbufte/IE2Kc/CkVMFuqQMhBTb
         Dc2NP0IRtjnL0W3hfx6Uv/Oxa2wEbb5uwwOGcoRJq4AsdiSNiUtU6xZsDrrk6KimC7FV
         sYLJwPGIxTNa+CsiCF0fQXLcbtzP8+JcFlUO0be8jzdUGmQyL8QDNh4FGjVhTQn1KrSQ
         Yqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oV/VSYZqqIumRH5P+eqTsnDgmKBm+ARcUHmfbDUpqys=;
        b=K24v2xe4QfGtbPIjE8IyGfe9uC7dzBaJ52+y3L0VY4exuUz0KSejVWsI4QcnEuwSKI
         x4o4mTBgWZDy4PsFLsUDtzxc/YnPhuD7hV6+qDd8cOrlg7UEHs3gF+fk03Rbk2k2QoTH
         +fE4TLIpAb1NJRP9427/u1gVGz2piTzhRIOC4bTDLVXp/lXsCrvI9Ua+ZWwuJWwUc2kj
         X4LyYHM/MfelCOglBm5bmkPMw6TfHVfrkfjtxmPnTslcCRfj/WkrKahrWyJ0S2fgEmcS
         cmHWpiwWHO9R5DZ/W6RD6AopUoXdRC3QG118XYfDHdMM/z2FCtMCJkad1T20e06e48Fm
         yo3A==
X-Gm-Message-State: AOAM532azvFZwGExWiry0P4gLILi/SHF6UamPGE98ZRrlgnDxvUS5GoM
        iCFPvdfSj34s2q1mJd19mST4+AbsKE5KXpXg
X-Google-Smtp-Source: ABdhPJzQgIvCCd3aS/wDjOB3hqsDGMIkaTamhjm/7QAJ8PAEZchNBQtLlCCnJVNMiatziHKOpP9QNw==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr5399159qtr.211.1598288354422;
        Mon, 24 Aug 2020 09:59:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o13sm10173667qko.48.2020.08.24.09.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 09:59:13 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] btrfs: change how we calculate the nrptrs for
 btrfs_buffered_write()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200824075959.85212-1-wqu@suse.com>
 <20200824075959.85212-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <df915d84-1296-2c04-8f63-eab1cb98316d@toxicpanda.com>
Date:   Mon, 24 Aug 2020 12:59:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824075959.85212-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/24/20 3:59 AM, Qu Wenruo wrote:
> @nrptrs of btrfs_bufferd_write() determines the up limit of pages we can
> process in one batch.
> 
> Normally we want it to be as large as possible as btrfs metadata/data
> reserve and release can cost quite a lot of time.
> 
> Commit 142349f541d0 ("btrfs: lower the dirty balance poll interval")
> introduced two extra limitations which are suspicious now:
> - limit the page number to nr_dirtied_pause - nr_dirtied
>    However I can't find any mainline fs nor iomap utilize these two
>    members.
>    Although page write back still uses those two members, as no other fs
>    utilizeing them at all, I doubt about the usefulness.
> 
> - ensure we always have 8 pages allocates
>    The 8 lower limit looks pretty strange, this means even we're just
>    writing 4K, we will allocate page* for 8 pages no matter what.
>    To me, this 8 pages look more like a upper limit.
> 
> This patch will change it by:
> - Extract the calculation into another function
>    This allows us to add more comment explaining every calculation.
> 
> - Do proper page alignment calculation
>    The old calculation, DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE)
>    doesn't take @pos into consideration.
>    In fact we can easily have iov_iter_count(i) == 2, but still cross two
>    pages. (pos == page_offset() + PAGE_SIZE - 1).
> 
> - Remove the useless max(8)
> 
> - Use PAGE_SIZE independent up limit
>    Now we use 64K as nr_pages limit, so we should get similar performance
>    between different arches.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/file.c | 28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 5a818ebcb01f..c592350a5a82 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1620,6 +1620,29 @@ void btrfs_check_nocow_unlock(struct btrfs_inode *inode)
>   	btrfs_drew_write_unlock(&inode->root->snapshot_lock);
>   }
>   
> +/* Helper to get how many pages we should alloc for the batch */
> +static int get_nr_pages(struct btrfs_fs_info *fs_info, loff_t pos,
> +			struct iov_iter *iov)
> +{
> +	int nr_pages;
> +
> +	/*
> +	 * Try to cover the full iov range, as btrfs metadata/data reserve
> +	 * and release can be pretty slow, thus the more pages we process in
> +	 * one batch the better.
> +	 */
> +	nr_pages = (round_up(pos + iov_iter_count(iov), PAGE_SIZE) -
> +		    round_down(pos, PAGE_SIZE)) / PAGE_SIZE;
> +
> +	/*
> +	 * But still limit it to 64KiB, so we can still get a similar
> +	 * buffered write performance between different page sizes
> +	 */
> +	nr_pages = min_t(int, nr_pages, SZ_64K / PAGE_SIZE);
> +
> +	return nr_pages;
> +}
> +
>   static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>   					       struct iov_iter *i)
>   {
> @@ -1638,10 +1661,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>   	bool only_release_metadata = false;
>   	bool force_page_uptodate = false;
>   
> -	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
> -			PAGE_SIZE / (sizeof(struct page *)));
> -	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
> -	nrptrs = max(nrptrs, 8);
> +	nrptrs = get_nr_pages(fs_info, pos, i);
>   	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);

These cleanups are valuable, I don't want to change this behavior in a cleanup. 
Rework the code first, then make the changes you want to make, that way when we 
go back and blame we have a reason why the behavior was changed, and we don't 
end up in a refactoring patch that also happened to change the behavior.  Thanks,

Josef
