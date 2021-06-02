Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE4B3991DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBRqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Jun 2021 13:46:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFBRqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Jun 2021 13:46:08 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CFF821957;
        Wed,  2 Jun 2021 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622655864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/n9OER48RI9YR9HlRjV1SeBrQ5LmQ5RKcAZjMG+PhTc=;
        b=AC/4U7hPBvg1WCbPddZ3sDVPlMRC31tVmD7OY27B4/KLW4nfY8MDdJdbfNHpdDylw7Q+lc
        4W6VhnsWCu9JHSwvUGAS+0zx5f3A9NaaOwcc4qoz5xTM3SVPsrwRN6eI/3kaJQTFLn6Hv2
        bM+DO96aZ4ZdnE1o3vxm/NKeqsXFs2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622655864;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/n9OER48RI9YR9HlRjV1SeBrQ5LmQ5RKcAZjMG+PhTc=;
        b=6BHJ/9/Cwv+nC6TgVT7RKLv1+xzceK/VlemFW0K0ukAu/lS8Pd375lqbSv1P8SyDBPaXGS
        hFvvsTCnX2M27MDg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 15BA7A3B81;
        Wed,  2 Jun 2021 17:44:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 46EB2DA734; Wed,  2 Jun 2021 18:25:55 +0200 (CEST)
Date:   Wed, 2 Jun 2021 18:25:55 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 22/30] btrfs: fix wild subpage writeback which does
 not have ordered extent.
Message-ID: <20210602162555.GO31483@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-23-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531085106.259490-23-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 31, 2021 at 04:50:58PM +0800, Qu Wenruo wrote:
> [BUG]
> When running fsstress with subpage RW support, there are random
> BUG_ON()s triggered with the following trace:
> 
>  kernel BUG at fs/btrfs/file-item.c:667!
>  Internal error: Oops - BUG: 0 [#1] SMP
>  CPU: 1 PID: 3486 Comm: kworker/u13:2 Tainted: G        WC O      5.11.0-rc4-custom+ #43
>  Hardware name: Radxa ROCK Pi 4B (DT)
>  Workqueue: btrfs-worker-high btrfs_work_helper [btrfs]
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>  pc : btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
>  lr : btrfs_csum_one_bio+0x400/0x4e0 [btrfs]
>  Call trace:
>   btrfs_csum_one_bio+0x420/0x4e0 [btrfs]
>   btrfs_submit_bio_start+0x20/0x30 [btrfs]
>   run_one_async_start+0x28/0x44 [btrfs]
>   btrfs_work_helper+0x128/0x1b4 [btrfs]
>   process_one_work+0x22c/0x430
>   worker_thread+0x70/0x3a0
>   kthread+0x13c/0x140
>   ret_from_fork+0x10/0x30
> 
> [CAUSE]
> Above BUG_ON() means there are some bio range which doesn't have ordered
> extent, which indeed is worthy a BUG_ON().
> 
> Unlike regular sectorsize == PAGE_SIZE case, in subpage we have extra
> subpage dirty bitmap to record which range is dirty and should be
> written back.
> 
> This means, if we submit bio for a subpage range, we do not only need to
> clear page dirty, but also need to clear subpage dirty bits.
> 
> In __extent_writepage_io(), we will call btrfs_page_clear_dirty() for
> any range we submit a bio.
> 
> But there is loophole, if we hit a range which is beyond isize, we just
> call btrfs_writepage_endio_finish_ordered() to finish the ordered io,
> then break out, without clearing the subpage dirty.
> 
> This means, if we hit above branch, the subpage dirty bits are still
> there, if other range of the page get dirtied and we need to writeback
> that page again, we will submit bio for the old range, leaving a wild
> bio range which doesn't have ordered extent.
> 
> [FIX]
> Fix it by always calling btrfs_page_clear_dirty() in
> __extent_writepage_io().
> 
> Also to avoid such problem from happening again, add a new assert,
> btrfs_page_assert_not_dirty(), to make sure both page dirty and subpage
> dirty bits are cleared before exiting __extent_writepage_io().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/extent_io.c | 17 +++++++++++++++++
>  fs/btrfs/subpage.c   | 16 ++++++++++++++++
>  fs/btrfs/subpage.h   |  7 +++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 1909979d41de..631c4f3e9cea 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3905,6 +3905,16 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		if (cur >= i_size) {
>  			btrfs_writepage_endio_finish_ordered(inode, page, cur,
>  							     end, 1);
> +			/*
> +			 * This range is beyond isize, thus we don't need to
> +			 * bother writing back.
> +			 * But we still need to clear the dirty subpage bit, or
> +			 * the next time the page get dirtied, we will try to
> +			 * writeback the sectors with subpage diryt bits,
> +			 * causing writeback without ordered extent.
> +			 */
> +			btrfs_page_clear_dirty(fs_info, page, cur,
> +					       end + 1 - cur);
>  			break;
>  		}
>  
> @@ -3955,6 +3965,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  			else
>  				btrfs_writepage_endio_finish_ordered(inode,
>  						page, cur, cur + iosize - 1, 1);
> +			btrfs_page_clear_dirty(fs_info, page, cur, iosize);
>  			cur += iosize;
>  			continue;
>  		}
> @@ -3990,6 +4001,12 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
>  		cur += iosize;
>  		nr++;
>  	}
> +	/*
> +	 * If we finishes without problem, we should not only clear page dirty,
> +	 * but also emptied subpage dirty bits
> +	 */
> +	if (!ret)
> +		btrfs_page_assert_not_dirty(fs_info, page);
>  	*nr_ret = nr;
>  	return ret;
>  }
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 516e0b3f2ed9..696485ab68a2 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -548,3 +548,19 @@ IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writeback, end_page_writeback,
>  			 PageWriteback);
>  IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
>  			 PageOrdered);
> +
> +void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
> +				 struct page *page)
> +{
> +	struct btrfs_subpage *subpage = (struct btrfs_subpage *)page->private;
> +
> +	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
> +		return;
> +
> +	ASSERT(!PageDirty(page));
> +	if (fs_info->sectorsize == PAGE_SIZE)
> +		return;
> +
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(subpage->dirty_bitmap == 0);
> +}
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 3419b152c00f..7188e9d2fbea 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -119,4 +119,11 @@ DECLARE_BTRFS_SUBPAGE_OPS(ordered);
>  bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
>  		struct page *page, u64 start, u32 len);
>  
> +/*
> + * Extra assert to make sure not only the page dirty bit is cleared, but also
> + * subpage dirty bit is cleared.
> + */

I've moved the comment to the function definition, as it's next to the
code.

> +void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
> +				 struct page *page);
> +
>  #endif
> -- 
> 2.31.1
