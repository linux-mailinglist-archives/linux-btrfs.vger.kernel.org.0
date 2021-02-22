Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065623211AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBVH66 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 02:58:58 -0500
Received: from eu-shark1.inbox.eu ([195.216.236.81]:47164 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhBVH65 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 02:58:57 -0500
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id F09056C00745;
        Mon, 22 Feb 2021 09:58:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1613980688; bh=bbQ62V4GthswWegrgcoqUrD5BftmNKmNud6bUQAcOyM=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=C4aBDRRoIhv2H/+Rzf5Q+fT07fAK/6ZX8ob0ufBki4KKofEOZiQWtPCaq3dNvrz16
         VW52uo5TKYQXdU9iwncM9SytpOHSUYugTS0xJvmLpYVWt4TNLOPHAFNYw4rkaTlQku
         Z2yN67sbDWzRDGcnHXmPSwXXspcRMxLpYW0TF6CU=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id E7E9D6C00754;
        Mon, 22 Feb 2021 09:58:07 +0200 (EET)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id i5aLIWdz25LU; Mon, 22 Feb 2021 09:58:07 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id 68D976C0074F;
        Mon, 22 Feb 2021 09:58:07 +0200 (EET)
Received: from nas (unknown [45.87.95.231])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id CF8D01BE00B1;
        Mon, 22 Feb 2021 09:58:05 +0200 (EET)
References: <20210222063357.92930-1-wqu@suse.com>
 <20210222063357.92930-4-wqu@suse.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/12] btrfs: disk-io: allow btree_set_page_dirty() to
 do more sanity check on subpage metadata
In-reply-to: <20210222063357.92930-4-wqu@suse.com>
Message-ID: <im6kr0tz.fsf@damenly.su>
Date:   Mon, 22 Feb 2021 15:58:00 +0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgs1s1k3Ua26u/vDsBBdmWXyNjCNe1YPUxGr7h97Nxyk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 22 Feb 2021 at 14:33, Qu Wenruo <wqu@suse.com> wrote:

> For btree_set_page_dirty(), we should also check the extent 
> buffer
> sanity for subpage support.
>
> Unlike the regular sector size case, since one page can contain 
> multiple
> extent buffers, we need to make sure there is at least one dirty 
> extent
> buffer in the page.
>
> So this patch will iterate through the 
> btrfs_subpage::dirty_bitmap
> to get the extent buffers, and check if any dirty extent buffer 
> in the page
> range has EXTENT_BUFFER_DIRTY and proper refs.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 47 
>  ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c2576c5fe62e..437e6b2163c7 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -42,6 +42,7 @@
>  #include "discard.h"
>  #include "space-info.h"
>  #include "zoned.h"
> +#include "subpage.h"
>
>  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>  				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -992,14 +993,48 @@ static void btree_invalidatepage(struct 
> page *page, unsigned int offset,
>  static int btree_set_page_dirty(struct page *page)
>  {
>  #ifdef DEBUG
> +	struct btrfs_fs_info *fs_info = 
> btrfs_sb(page->mapping->host->i_sb);
> +	struct btrfs_subpage *subpage;
>  	struct extent_buffer *eb;
> +	int cur_bit;
>
cur_bit is not initialized.

> +	u64 page_start = page_offset(page);
> +
> +	if (fs_info->sectorsize == PAGE_SIZE) {
> +		BUG_ON(!PagePrivate(page));
> +		eb = (struct extent_buffer *)page->private;
> +		BUG_ON(!eb);
> +		BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> +		BUG_ON(!atomic_read(&eb->refs));
> +		btrfs_assert_tree_locked(eb);
> +		return __set_page_dirty_nobuffers(page);
> +	}
> +	ASSERT(PagePrivate(page) && page->private);
> +	subpage = (struct btrfs_subpage *)page->private;
> +
> +	ASSERT(subpage->dirty_bitmap);
> +	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
> +		unsigned long flags;
> +		u64 cur;
> +		u16 tmp = (1 << cur_bit);
> +
> +		spin_lock_irqsave(&subpage->lock, flags);
> +		if (!(tmp & subpage->dirty_bitmap)) {
> +			spin_unlock_irqrestore(&subpage->lock, flags);
> +			cur_bit++;
> +			continue;
> +		}
> +		spin_unlock_irqrestore(&subpage->lock, flags);
> +		cur = page_start + cur_bit * fs_info->sectorsize;
>
> -	BUG_ON(!PagePrivate(page));
> -	eb = (struct extent_buffer *)page->private;
> -	BUG_ON(!eb);
> -	BUG_ON(!test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> -	BUG_ON(!atomic_read(&eb->refs));
> -	btrfs_assert_tree_locked(eb);
> +		eb = find_extent_buffer(fs_info, cur);
> +		ASSERT(eb);
> +		ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> +		ASSERT(atomic_read(&eb->refs));
> +		btrfs_assert_tree_locked(eb);
> +		free_extent_buffer(eb);
> +
> +		cur_bit += (fs_info->nodesize >> 
> fs_info->sectorsize_bits);
> +	}
>  #endif
>  	return __set_page_dirty_nobuffers(page);
>  }

