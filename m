Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1F21D0158
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbgELV5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 17:57:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731171AbgELV5T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 17:57:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C5347AC85;
        Tue, 12 May 2020 21:57:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE603DA70B; Tue, 12 May 2020 23:56:25 +0200 (CEST)
Date:   Tue, 12 May 2020 23:56:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: btrfs: fix data races in
 extent_write_cache_pages()
Message-ID: <20200512215625.GE18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200509052701.3156-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509052701.3156-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 09, 2020 at 01:27:01PM +0800, Jia-Ju Bai wrote:
> The function extent_write_cache_pages is concurrently executed with
> itself at runtime in the following call contexts:
> 
> Thread 1:
>   btrfs_sync_file()
>     start_ordered_ops()
>       btrfs_fdatawrite_range()
>         btrfs_writepages() [via function pointer]
>           extent_writepages()
>             extent_write_cache_pages()
> 
> Thread 2:
>   btrfs_writepages() 
>     extent_writepages()
>       extent_write_cache_pages()
> 
> In extent_write_cache_pages():
>   index = mapping->writeback_index;
>   ...
>   mapping->writeback_index = done_index;
> 
> The accesses to mapping->writeback_index are not synchronized, and thus
> data races for this value can occur.
> These data races were found and actually reproduced by our concurrency 
> fuzzer.
> 
> To fix these races, the spinlock mapping->private_lock is used to
> protect the accesses to mapping->writeback_index.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/extent_io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 39e45b8a5031..8c33a60bde1d 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4160,7 +4160,9 @@ static int extent_write_cache_pages(struct address_space *mapping,
>  
>  	pagevec_init(&pvec);
>  	if (wbc->range_cyclic) {
> +		spin_lock(&mapping->private_lock);
>  		index = mapping->writeback_index; /* Start from prev offset */
> +		spin_unlock(&mapping->private_lock);
>  		end = -1;
>  		/*
>  		 * Start from the beginning does not need to cycle over the
> @@ -4271,8 +4273,11 @@ static int extent_write_cache_pages(struct address_space *mapping,
>  			goto retry;
>  	}
>  
> -	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
> +	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole)) {
> +		spin_lock(&mapping->private_lock);
>  		mapping->writeback_index = done_index;
> +		spin_unlock(&mapping->private_lock);

I'm more and more curious what exactly is your fuzzer tool actualy
reporting. Because adding the locks around the writeback index does not
make any sense.

The variable is of type unsigned long, this is written atomically so the
only theoretical problem is on an achritecture that is not capable of
storing that in one go, which means a lot more problems eg. because
pointers are assumed to be the same width as unsigned long.

So torn write is not possible and the lock leads to the same result as
if it wasn't there and the read and write would happen not serialized by
the spinlock but somewhere on the way from CPU caches to memory.

CPU1                                   CPU2

lock
index = mapping->writeback_index
unlock
                                       lock
				       m->writeback_index = index;
				       unlock

Is the same as

CPU1                                   CPU2


index = mapping->writeback_index
				       m->writeback_index = index;

So maybe this makes your tool happy but there's no change from the
correctness point of view, only added overhead from the lock/unlock
calls.

Lockless synchronization is a thing, using memory barriers etc., this
was the case of some other patch, I think your tool needs to take that
into account to give sensible results.
