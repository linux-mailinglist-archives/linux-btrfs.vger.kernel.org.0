Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04F5D1568
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbfJIRUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 13:20:30 -0400
Received: from mail.itouring.de ([188.40.134.68]:47412 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbfJIRUa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 13:20:30 -0400
Received: from tux.wizards.de (pD9EBF359.dip0.t-ipconnect.de [217.235.243.89])
        by mail.itouring.de (Postfix) with ESMTPSA id 62BCD4169EE1;
        Wed,  9 Oct 2019 19:20:28 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id 17305F01600;
        Wed,  9 Oct 2019 19:20:28 +0200 (CEST)
Subject: Re: [PATCH 2/2] Btrfs: keep pages dirty when using
 btrfs_writepage_fixup_worker
To:     Chris Mason <clm@fb.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20180620145612.1644763-1-clm@fb.com>
 <20180620145612.1644763-3-clm@fb.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2b2ce8e7-ffdc-4e1f-67c6-138ccc02c016@applied-asynchrony.com>
Date:   Wed, 9 Oct 2019 19:20:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20180620145612.1644763-3-clm@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/20/18 4:56 PM, Chris Mason wrote:
> For COW, btrfs expects pages dirty pages to have been through a few setup
> steps.  This includes reserving space for the new block allocations and marking
> the range in the state tree for delayed allocation.
> 
> A few places outside btrfs will dirty pages directly, especially when unmapping
> mmap'd pages.  In order for these to properly go through COW, we run them
> through a fixup worker to wait for stable pages, and do the delalloc prep.
> 
> 87826df0ec36 added a window where the dirty pages were cleaned, but pending
> more action from the fixup worker.  During this window, page migration can jump
> in and relocate the page.  Once our fixup work actually starts, it finds
> page->mapping is NULL and we end up freeing the page without ever writing it.
> 
> This leads to crc errors and other exciting problems, since it screws up the
> whole statemachine for waiting for ordered extents.  The fix here is to keep
> the page dirty while we're waiting for the fixup worker to get to work.  This
> also makes sure the error handling in btrfs_writepage_fixup_worker does the
> right thing with dirty bits when we run out of space.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Chris, is this still relevant? It's not in mainline and seems to work since it
didn't seem to have eaten data in my tree since last year, but then again I just
have regular and fairly pedestrian use cases. Dave asked for a clarification [1]
but nothing ever happened.

It sounds important enough to clarify once and for all, especially in light of
other recent dirty page handling fixes which may or may not interact with this.

thanks!
Holger

[1] https://patchwork.kernel.org/patch/10477683/#22699195

> ---
>   fs/btrfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++++---------------
>   1 file changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0b86cf1..5538900 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2100,11 +2100,21 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
>   	page = fixup->page;
>   again:
>   	lock_page(page);
> -	if (!page->mapping || !PageDirty(page) || !PageChecked(page)) {
> -		ClearPageChecked(page);
> +
> +	/*
> +	 * before we queued this fixup, we took a reference on the page.
> +	 * page->mapping may go NULL, but it shouldn't be moved to a
> +	 * different address space.
> +	 */
> +	if (!page->mapping || !PageDirty(page) || !PageChecked(page))
>   		goto out_page;
> -	}
>   
> +	/*
> +	 * we keep the PageChecked() bit set until we're done with the
> +	 * btrfs_start_ordered_extent() dance that we do below.  That
> +	 * drops and retakes the page lock, so we don't want new
> +	 * fixup workers queued for this page during the churn.
> +	 */
>   	inode = page->mapping->host;
>   	page_start = page_offset(page);
>   	page_end = page_offset(page) + PAGE_SIZE - 1;
> @@ -2129,33 +2139,46 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
>   
>   	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
>   					   PAGE_SIZE);
> -	if (ret) {
> -		mapping_set_error(page->mapping, ret);
> -		end_extent_writepage(page, ret, page_start, page_end);
> -		ClearPageChecked(page);
> -		goto out;
> -	 }
> +	if (ret)
> +		goto out_error;
>   
>   	ret = btrfs_set_extent_delalloc(inode, page_start, page_end, 0,
>   					&cached_state, 0);
> -	if (ret) {
> -		mapping_set_error(page->mapping, ret);
> -		end_extent_writepage(page, ret, page_start, page_end);
> -		ClearPageChecked(page);
> -		goto out;
> -	}
> +	if (ret)
> +		goto out_error;
>   
> -	ClearPageChecked(page);
> -	set_page_dirty(page);
>   	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE, false);
> +
> +	/*
> +	 * everything went as planned, we're now the proud owners of a
> +	 * Dirty page with delayed allocation bits set and space reserved
> +	 * for our COW destination.
> +	 *
> +	 * The page was dirty when we started, nothing should have cleaned it.
> +	 */
> +	BUG_ON(!PageDirty(page));
> +
>   out:
>   	unlock_extent_cached(&BTRFS_I(inode)->io_tree, page_start, page_end,
>   			     &cached_state);
>   out_page:
> +	ClearPageChecked(page);
>   	unlock_page(page);
>   	put_page(page);
>   	kfree(fixup);
>   	extent_changeset_free(data_reserved);
> +	return;
> +
> +out_error:
> +	/*
> +	 * We hit ENOSPC or other errors.  Update the mapping and page to
> +	 * reflect the errors and clean the page.
> +	 */
> +	mapping_set_error(page->mapping, ret);
> +	end_extent_writepage(page, ret, page_start, page_end);
> +	clear_page_dirty_for_io(page);
> +	SetPageError(page);
> +	goto out;
>   }
>   
>   /*
> @@ -2179,6 +2202,13 @@ static int btrfs_writepage_start_hook(struct page *page, u64 start, u64 end)
>   	if (TestClearPagePrivate2(page))
>   		return 0;
>   
> +	/*
> +	 * PageChecked is set below when we create a fixup worker for this page,
> +	 * don't try to create another one if we're already PageChecked()
> +	 *
> +	 * The extent_io writepage code will redirty the page if we send
> +	 * back EAGAIN.
> +	 */
>   	if (PageChecked(page))
>   		return -EAGAIN;
>   
> @@ -2192,7 +2222,8 @@ static int btrfs_writepage_start_hook(struct page *page, u64 start, u64 end)
>   			btrfs_writepage_fixup_worker, NULL, NULL);
>   	fixup->page = page;
>   	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
> -	return -EBUSY;
> +
> +	return -EAGAIN;
>   }
>   
>   static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
> 

