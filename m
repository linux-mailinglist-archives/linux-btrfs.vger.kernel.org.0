Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B141CC090
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 May 2020 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgEIKxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 May 2020 06:53:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:52262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgEIKxH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 9 May 2020 06:53:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 045BEAEBB;
        Sat,  9 May 2020 10:53:05 +0000 (UTC)
Subject: Re: [PATCH 1/4] fs: btrfs: fix a data race in
 btrfs_block_group_done()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200509052001.2298-1-baijiaju1990@gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <21982360-ee20-edfd-bee9-cbea04b3893f@suse.com>
Date:   Sat, 9 May 2020 13:53:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509052001.2298-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 9.05.20 г. 8:20 ч., Jia-Ju Bai wrote:
> The functions btrfs_block_group_done() and caching_thread() are 
> concurrently executed at runtime in the following call contexts:
> 
> Thread 1:
>   btrfs_sync_file()
>     start_ordered_ops()
>       btrfs_fdatawrite_range()
>         btrfs_writepages() [via function pointer]
>           extent_writepages()
>             extent_write_cache_pages()
>               __extent_writepage()
>                 writepage_delalloc()
>                   btrfs_run_delalloc_range()
>                     cow_file_range()
>                       btrfs_reserve_extent()
>                         find_free_extent()
>                           btrfs_block_group_done()
> 
> Thread 2:
>   caching_thread()
> 
> In btrfs_block_group_done():
>   smp_mb();
>   return cache->cached == BTRFS_CACHE_FINISHED ||
>       cache->cached == BTRFS_CACHE_ERROR;
> 
> In caching_thread():
>   spin_lock(&block_group->lock);
>   block_group->caching_ctl = NULL;
>   block_group->cached = ret ? BTRFS_CACHE_ERROR : BTRFS_CACHE_FINISHED;
>   spin_unlock(&block_group->lock);
> 
> The values cache->cached and block_group->cached access the same memory, 
> and thus a data race can occur.
> This data race was found and actually reproduced by our concurrency 
> fuzzer.
> 
> To fix this race, the spinlock cache->lock is used to protect the 
> access to cache->cached in btrfs_block_group_done().
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/block-group.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 107bb557ca8d..fb5f12acea40 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -278,9 +278,13 @@ static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
>  
>  static inline int btrfs_block_group_done(struct btrfs_block_group *cache)
>  {
> +	int flag;
>  	smp_mb();
> -	return cache->cached == BTRFS_CACHE_FINISHED ||
> -		cache->cached == BTRFS_CACHE_ERROR;
> +	spin_lock(&cache->lock);
> +	flag = (cache->cached == BTRFS_CACHE_FINISHED ||
> +		cache->cached == BTRFS_CACHE_ERROR);
> +	spin_unlock(&cache->lock);
> +	return flag;

Using the lock also obviates the need for the memory barrier.
Furthermore this race is benign because even if it occurs and we call
into btrfs_cache_block_group we do check cache->cached under
btrfs_block_group::lock and do the right thing, though we would have
done a bit more unnecessary wor if that's the case. So have you actually
measured the effect of adding the the spinlock? This is likely done so
as to make the fastpath lock-free. Perhaps a better approach would be to
annotate the access of cached with READ/WRITE once so that it's fetched
from memory and not optimized out by the compiler and leave the more
heavy work in the unlikely path.

Please exercise some critical thinking when looking into such issues as
there might be a good reason why something has been coded in a
particular way and it might look wrong on a first look but in fact is not.

>  }
>  
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> 
