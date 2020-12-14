Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32422D9840
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 13:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439432AbgLNMrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 07:47:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439416AbgLNMrC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 07:47:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607949976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=+yyU/g9Wjzocu5iv8QqEh8wrLCF68Jrw/Ug5BylQDoU=;
        b=rQs9relMMba1S3SDKP0uOxQrt2Q+mthTBsFogKUaDPHE/8brjUDc5ZnFLZG3xQtZaliU6g
        /U0eUZBwGbbyhRWpLXvVqwSFMOoajDtxbkbw6Wd/xC/h8u/j/64nBKSgihT0KFpHMKfySr
        XnB2N022yQs6I/uAH5brtcm7C6mHMUE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 215BEAC90;
        Mon, 14 Dec 2020 12:46:16 +0000 (UTC)
Subject: Re: [PATCH v2 16/18] btrfs: introduce btrfs_subpage for data inodes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-17-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d46012a6-00b8-ebbd-10aa-56773c7e0bbf@suse.com>
Date:   Mon, 14 Dec 2020 14:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-17-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.20 г. 8:39 ч., Qu Wenruo wrote:
> To support subpage sector size, data also need extra info to make sure
> which sectors in a page are uptodate/dirty/...
> 
> This patch will make pages for data inodes to get btrfs_subpage
> structure attached, and detached when the page is freed.
> 
> This patch also slightly changes the timing when
> set_page_extent_mapped() to make sure:
> - We have page->mapping set
>   page->mapping->host is used to grab btrfs_fs_info, thus we can only
>   call this function after page is mapped to an inode.
> 
>   One call site attaches pages to inode manually, thus we have to modify
>   the timing of set_page_extent_mapped() a little.
> 
> - As soon as possible, before other operations
>   Since memory allocation can fail, we have to do extra error handling.
>   Calling set_page_extent_mapped() as soon as possible can simply the
>   error handling for several call sites.
> 
> The idea is pretty much the same as iomap_page, but with more bitmaps
> for btrfs specific cases.
> 
> Currently the plan is to switch iomap if iomap can provide sector
> aligned write back (only write back dirty sectors, but not the full
> page, data balance require this feature).
> 
> So we will stick to btrfs specific bitmap for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/compression.c      | 10 ++++++--
>  fs/btrfs/extent_io.c        | 47 +++++++++++++++++++++++++++++++++----
>  fs/btrfs/extent_io.h        |  3 ++-
>  fs/btrfs/file.c             | 10 +++++---
>  fs/btrfs/free-space-cache.c | 15 +++++++++---
>  fs/btrfs/inode.c            | 12 ++++++----
>  fs/btrfs/ioctl.c            |  5 +++-
>  fs/btrfs/reflink.c          |  5 +++-
>  fs/btrfs/relocation.c       | 12 ++++++++--
>  9 files changed, 98 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 5ae3fa0386b7..6d203acfdeb3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -542,13 +542,19 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>  			goto next;
>  		}
>  
> -		end = last_offset + PAGE_SIZE - 1;
>  		/*
>  		 * at this point, we have a locked page in the page cache
>  		 * for these bytes in the file.  But, we have to make
>  		 * sure they map to this compressed extent on disk.
>  		 */
> -		set_page_extent_mapped(page);
> +		ret = set_page_extent_mapped(page);
> +		if (ret < 0) {
> +			unlock_page(page);
> +			put_page(page);
> +			break;
> +		}
> +
> +		end = last_offset + PAGE_SIZE - 1;
>  		lock_extent(tree, last_offset, end);
>  		read_lock(&em_tree->lock);
>  		em = lookup_extent_mapping(em_tree, last_offset,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 64a19c1884fc..4e4ed9c453ae 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3191,10 +3191,40 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
>  	return 0;
>  }
>  
> -void set_page_extent_mapped(struct page *page)
> +int __must_check set_page_extent_mapped(struct page *page)
>  {
> -	if (!PagePrivate(page))
> +	struct btrfs_fs_info *fs_info;
> +
> +	ASSERT(page->mapping);
> +
> +	if (PagePrivate(page))
> +		return 0;
> +
> +	fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	if (fs_info->sectorsize == PAGE_SIZE) {
>  		attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> +		return 0;
> +	}
> +
> +	return btrfs_attach_subpage(fs_info, page);

In all previous patches < PAGE_SIZE is the special case, in this
function it's reversed. For the sake of consistency change that so
btrfs_attch_subpage is executed inside the conditional.

> +}
> +
> +void clear_page_extent_mapped(struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info;
> +
> +	ASSERT(page->mapping);
> +
> +	if (!PagePrivate(page))
> +		return;
> +
> +	fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	if (fs_info->sectorsize == PAGE_SIZE) {
> +		detach_page_private(page);
> +		return;
> +	}
> +
> +	btrfs_detach_subpage(fs_info, page);

DITTO

>  }
>  
>  static struct extent_map *

<snip>

> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index a29b50208eee..9b878616b489 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1373,6 +1373,12 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
>  			goto fail;
>  		}
>  
> +		err = set_page_extent_mapped(pages[i]);
> +		if (err < 0) {
> +			faili = i;
> +			goto fail;
> +		}
> +
>  		if (i == 0)
>  			err = prepare_uptodate_page(inode, pages[i], pos,
>  						    force_uptodate);
> @@ -1470,10 +1476,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
>  	 * We'll call btrfs_dirty_pages() later on, and that will flip around
>  	 * delalloc bits and dirty the pages as required.
>  	 */
> -	for (i = 0; i < num_pages; i++) {
> -		set_page_extent_mapped(pages[i]);
> +	for (i = 0; i < num_pages; i++)
>  		WARN_ON(!PageLocked(pages[i]));
> -	}
The comment above this needs to be removed/rewritten I guess?
Essentially that set_page_extent_mapped is moved to prepare_pages.

>  
>  	return ret;
>  }

<snip>

> @@ -8355,7 +8357,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>  	wait_on_page_writeback(page);
>  
>  	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> -	set_page_extent_mapped(page);
> +	ret = set_page_extent_mapped(page);
> +	if (ret < 0)
> +		goto out_unlock;

You should use ret2, ret in this function is used for the retval of
vmf_error().

>  
>  	/*
>  	 * we can't set the delalloc bits if there are pending ordered

<snip>

