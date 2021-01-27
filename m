Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8B0306174
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 18:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhA0RAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 12:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhA0Q5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 11:57:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36AC061756
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:56:42 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id o18so1862584qtp.10
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 08:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vAV9d0dep5LV/AlG/hjaifY98gLWId476OjwUPRAxks=;
        b=ZyDz6aQbGq05bY0HPmdbMEPH4949zzgvzScnc9Y07qsgnyiEA1FbXYuB3nPCvM66o2
         /MBCtInherFAAVWQ5KKS1vUIiO7VZBjRglypzbuVgbLGLR1Mt47h8qilDvRtorw5YS5U
         KgH4xMDsuyP0I3L4u3dh1KhO635H+32mPrO6ItVgKfMhy47iCX+hJGCtpK/92sU0Bl+W
         OLlbwhcy4X4HBxbsBBJQ1MKSlNaSk/L3zK4yqnQKPtkMoTCXg9chei8WcEMm+1am8n/m
         rJzFtUT5Vp/1gjVcpgGY8Vda4yetqapk3TMLYno1BuFYc5nyEfpDb72crn1Oc4kE8rb6
         N2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vAV9d0dep5LV/AlG/hjaifY98gLWId476OjwUPRAxks=;
        b=lU76ZwvrgEyw5KPiGO4kE6mfG9j6XYqcmEJ+MHM6TVlV5AAEutIHMUV93CrGeJ/Oya
         1VopFpYOBsKyt+lG8/OoesWY4EZFu60tLuqv1NwP7XSHrUuxhWVetgKrnPnboGXlhc7+
         4UWUo7DX1u3laGN6HuDf+I0mm66J9ZHC6LVek4pvF2GAYpr/BMNasHZbhuGf+U7WonZV
         D98cmDjiRzWuDkvRpxY7uod0SvqM7YnjIIoTX3JRDF/NMxHL3hjNd3sddilm265fnom/
         z18v8M20S/a/eOZuX6F01/C6c+wAGLYQnQug+36Gr1I56TctTqD5BomSrD3Y42Ue9mN8
         JFCg==
X-Gm-Message-State: AOAM5305pqGYpJLW9qtfFBe15Yggo8HGuIYqY/q9msELaJju0jU4BTnK
        UG8Cl7rusZu81TsqXjHQhoNEIA==
X-Google-Smtp-Source: ABdhPJz18tsceJLgS9uVkLwms2AgXcr96gLxKMoZyK1SJrQuAmn8bSetCE8kTbE0avmKgNd0LJw9pw==
X-Received: by 2002:ac8:5cc2:: with SMTP id s2mr10605888qta.342.1611766601333;
        Wed, 27 Jan 2021 08:56:41 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v19sm1563235qkj.48.2021.01.27.08.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 08:56:40 -0800 (PST)
Subject: Re: [PATCH v5 16/18] btrfs: introduce btrfs_subpage for data inodes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
 <20210126083402.142577-17-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <62fa0a03-e375-8528-0e75-a593745eae1d@toxicpanda.com>
Date:   Wed, 27 Jan 2021 11:56:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126083402.142577-17-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/26/21 3:34 AM, Qu Wenruo wrote:
> To support subpage sector size, data also need extra info to make sure
> which sectors in a page are uptodate/dirty/...
> 
> This patch will make pages for data inodes to get btrfs_subpage
> structure attached, and detached when the page is freed.
> 
> This patch also slightly changes the timing when
> set_page_extent_mapped() to make sure:
> 
> - We have page->mapping set
>    page->mapping->host is used to grab btrfs_fs_info, thus we can only
>    call this function after page is mapped to an inode.
> 
>    One call site attaches pages to inode manually, thus we have to modify
>    the timing of set_page_extent_mapped() a little.
> 
> - As soon as possible, before other operations
>    Since memory allocation can fail, we have to do extra error handling.
>    Calling set_page_extent_mapped() as soon as possible can simply the
>    error handling for several call sites.
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
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/compression.c      | 10 ++++++--
>   fs/btrfs/extent_io.c        | 46 +++++++++++++++++++++++++++++++++----
>   fs/btrfs/extent_io.h        |  3 ++-
>   fs/btrfs/file.c             | 24 ++++++++-----------
>   fs/btrfs/free-space-cache.c | 15 +++++++++---
>   fs/btrfs/inode.c            | 14 +++++++----
>   fs/btrfs/ioctl.c            |  8 ++++++-
>   fs/btrfs/reflink.c          |  5 +++-
>   fs/btrfs/relocation.c       | 11 +++++++--
>   9 files changed, 103 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 5ae3fa0386b7..6d203acfdeb3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -542,13 +542,19 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   			goto next;
>   		}
>   
> -		end = last_offset + PAGE_SIZE - 1;
>   		/*
>   		 * at this point, we have a locked page in the page cache
>   		 * for these bytes in the file.  But, we have to make
>   		 * sure they map to this compressed extent on disk.
>   		 */
> -		set_page_extent_mapped(page);
> +		ret = set_page_extent_mapped(page);
> +		if (ret < 0) {
> +			unlock_page(page);
> +			put_page(page);
> +			break;
> +		}
> +
> +		end = last_offset + PAGE_SIZE - 1;
>   		lock_extent(tree, last_offset, end);
>   		read_lock(&em_tree->lock);
>   		em = lookup_extent_mapping(em_tree, last_offset,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 139a8a77ed72..eeee3213daaa 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3190,10 +3190,39 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
>   	return ret;
>   }
>   
> -void set_page_extent_mapped(struct page *page)
> +int set_page_extent_mapped(struct page *page)
>   {
> +	struct btrfs_fs_info *fs_info;
> +
> +	ASSERT(page->mapping);
> +
> +	if (PagePrivate(page))
> +		return 0;
> +
> +	fs_info = btrfs_sb(page->mapping->host->i_sb);
> +
> +	if (fs_info->sectorsize < PAGE_SIZE)
> +		return btrfs_attach_subpage(fs_info, page, BTRFS_SUBPAGE_DATA);
> +
> +	attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> +	return 0;
> +
> +}
> +
> +void clear_page_extent_mapped(struct page *page)
> +{
> +	struct btrfs_fs_info *fs_info;
> +
> +	ASSERT(page->mapping);
> +
>   	if (!PagePrivate(page))
> -		attach_page_private(page, (void *)EXTENT_PAGE_PRIVATE);
> +		return;
> +
> +	fs_info = btrfs_sb(page->mapping->host->i_sb);
> +	if (fs_info->sectorsize < PAGE_SIZE)
> +		return btrfs_detach_subpage(fs_info, page);
> +
> +	detach_page_private(page);
>   }
>   
>   static struct extent_map *
> @@ -3250,7 +3279,12 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>   	unsigned long this_bio_flag = 0;
>   	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
>   
> -	set_page_extent_mapped(page);
> +	ret = set_page_extent_mapped(page);
> +	if (ret < 0) {
> +		unlock_extent(tree, start, end);
> +		SetPageError(page);
> +		goto out;
> +	}
>   
>   	if (!PageUptodate(page)) {
>   		if (cleancache_get_page(page) == 0) {
> @@ -3690,7 +3724,11 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
>   		flush_dcache_page(page);
>   	}
>   
> -	set_page_extent_mapped(page);
> +	ret = set_page_extent_mapped(page);
> +	if (ret < 0) {
> +		SetPageError(page);
> +		goto done;
> +	}
>   
>   	if (!epd->extent_locked) {
>   		ret = writepage_delalloc(BTRFS_I(inode), page, wbc, start,
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 2d8187c84812..047b3e66897f 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -178,7 +178,8 @@ int btree_write_cache_pages(struct address_space *mapping,
>   void extent_readahead(struct readahead_control *rac);
>   int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>   		  u64 start, u64 len);
> -void set_page_extent_mapped(struct page *page);
> +int set_page_extent_mapped(struct page *page);
> +void clear_page_extent_mapped(struct page *page);
>   
>   struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   					  u64 start, u64 owner_root, int level);
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index d81ae1f518f2..63b290210eaa 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1369,6 +1369,12 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
>   			goto fail;
>   		}
>   
> +		err = set_page_extent_mapped(pages[i]);
> +		if (err < 0) {
> +			faili = i;
> +			goto fail;
> +		}
> +
>   		if (i == 0)
>   			err = prepare_uptodate_page(inode, pages[i], pos,
>   						    force_uptodate);
> @@ -1453,23 +1459,11 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
>   	}
>   
>   	/*
> -	 * It's possible the pages are dirty right now, but we don't want
> -	 * to clean them yet because copy_from_user may catch a page fault
> -	 * and we might have to fall back to one page at a time.  If that
> -	 * happens, we'll unlock these pages and we'd have a window where
> -	 * reclaim could sneak in and drop the once-dirty page on the floor
> -	 * without writing it.
> -	 *
> -	 * We have the pages locked and the extent range locked, so there's
> -	 * no way someone can start IO on any dirty pages in this range.
> -	 *
> -	 * We'll call btrfs_dirty_pages() later on, and that will flip around
> -	 * delalloc bits and dirty the pages as required.
> +	 * We should be called after prepare_pages() which should have
> +	 * locked all pages in the range.
>   	 */
> -	for (i = 0; i < num_pages; i++) {
> -		set_page_extent_mapped(pages[i]);
> +	for (i = 0; i < num_pages; i++)
>   		WARN_ON(!PageLocked(pages[i]));
> -	}
>   
>   	return ret;
>   }
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index fd6ddd6b8165..35e5c6ee0584 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -431,11 +431,22 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>   	int i;
>   
>   	for (i = 0; i < io_ctl->num_pages; i++) {
> +		int ret;
> +
>   		page = find_or_create_page(inode->i_mapping, i, mask);
>   		if (!page) {
>   			io_ctl_drop_pages(io_ctl);
>   			return -ENOMEM;
>   		}
> +
> +		ret = set_page_extent_mapped(page);
> +		if (ret < 0) {
> +			unlock_page(page);
> +			put_page(page);
> +			io_ctl_drop_pages(io_ctl);
> +			return ret;
> +		}
> +
>   		io_ctl->pages[i] = page;
>   		if (uptodate && !PageUptodate(page)) {
>   			btrfs_readpage(NULL, page);
> @@ -455,10 +466,8 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
>   		}
>   	}
>   
> -	for (i = 0; i < io_ctl->num_pages; i++) {
> +	for (i = 0; i < io_ctl->num_pages; i++)
>   		clear_page_dirty_for_io(io_ctl->pages[i]);
> -		set_page_extent_mapped(io_ctl->pages[i]);
> -	}
>   
>   	return 0;
>   }
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d1bb3cc8499b..a18e3c950f07 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4712,6 +4712,9 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> +	ret = set_page_extent_mapped(page);
> +	if (ret < 0)
> +		goto out_unlock;
>   
>   	if (!PageUptodate(page)) {
>   		ret = btrfs_readpage(NULL, page);
> @@ -4729,7 +4732,6 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>   	wait_on_page_writeback(page);
>   
>   	lock_extent_bits(io_tree, block_start, block_end, &cached_state);
> -	set_page_extent_mapped(page);
>   
>   	ordered = btrfs_lookup_ordered_extent(inode, block_start);
>   	if (ordered) {
> @@ -8107,7 +8109,7 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
>   {
>   	int ret = try_release_extent_mapping(page, gfp_flags);
>   	if (ret == 1)
> -		detach_page_private(page);
> +		clear_page_extent_mapped(page);
>   	return ret;
>   }
>   
> @@ -8266,7 +8268,7 @@ static void btrfs_invalidatepage(struct page *page, unsigned int offset,
>   	}
>   
>   	ClearPageChecked(page);
> -	detach_page_private(page);
> +	clear_page_extent_mapped(page);
>   }
>   
>   /*
> @@ -8345,7 +8347,11 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	wait_on_page_writeback(page);
>   
>   	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> -	set_page_extent_mapped(page);
> +	ret2 = set_page_extent_mapped(page);
> +	if (ret2 < 0) {
> +		ret = vmf_error(ret2);
> +		goto out_unlock;
> +	}

Sorry I missed this bit in my last reply, you need a

ret = vmf_error(ret2);
unlock_extent_cached(io_tree, page_start, page_end, &cached_state);
goto out_unlock;

Thanks,

Josef
