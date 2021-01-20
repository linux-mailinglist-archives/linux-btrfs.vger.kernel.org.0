Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892462FD401
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 16:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390776AbhATP3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 10:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390295AbhATP2w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:28:52 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20FC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:28:11 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id d11so11040257qvo.11
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hMGvjDFGKDUGNA7Ul+2WAdQucrEtPIB4UXQarWkCXTU=;
        b=Xqp+kJAE4wLvRpn7Pl2fDKEcMfNKo2HOXyYmDnfvsECdx9eWag/9XgHILQfkakTfek
         cnqbuh16q54WVGt3s2msXj2XXBLfLUfLRUyIkYICTCxosl8VbU1v/t7HrGG1SbVvT1oq
         FoN2tlZk2bEVcNeXQ4MOTNuaeYqChanc8nKARZ4HXK5wkuRUGzQ9+KoyqJlTunZj4p4P
         Nl+Hu5mYWo5cHG15HFgTi3clGs0E9BU1lAlkUanPrEyl3HgKYeWucxk6ZxXS3ITA/xkP
         XzmUq7khKqXSU1ZJnwYkaZV4lEEyBmnqAhQJ/ti6jjBN9YqUtX3XrIRZs4Ntyol1RAlq
         rxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hMGvjDFGKDUGNA7Ul+2WAdQucrEtPIB4UXQarWkCXTU=;
        b=jmwhm53Qr3PbC+DURi1THTfOHLKGcUUpiz99ANeWpNaR/U7o3ufB2OHQf/hSFbYpzK
         EwUX81RrSOFN4ERvU0QU2r79lo4NFPrTn83bV1UGFnKnbsVHocuC4Hcds0F+XlDQ4AP0
         +YHDbGRGWl0gGO5nc+YoIi3wj6rbxHEwkgLPopo5ip7evVCaCqlSfSYTrWiYAmf+fytb
         vRrF5VnmItquKeGZjh4TDVt1BcQptk63C8h1nqS+m64KURvNci1AZttSfZMj28uZoNPs
         6lnKQPVv4fN+YWjRlIwniknLfgh/XLbCKGSYpCVzY9CXXFFXMFvIKpyzQUfIIPD6S4k1
         bFiA==
X-Gm-Message-State: AOAM5312eEUacF6Z4BqP8e8iC9AoBYMQBORMvocRHQr+g426X/iMInnr
        GPjMa9yqxu4vvkvn0ZWxCLnSuH7wD3V1J6bJVkw=
X-Google-Smtp-Source: ABdhPJwUWKJF65zf2I/h8SoF/g6iDGwqMSpGBf94XvCSxB5LII3bqA+cKLf1UYHYSq1KPQRMHy14Fw==
X-Received: by 2002:a0c:a8e7:: with SMTP id h39mr5942925qvc.45.1611156490309;
        Wed, 20 Jan 2021 07:28:10 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm1524407qke.123.2021.01.20.07.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:28:08 -0800 (PST)
Subject: Re: [PATCH v4 16/18] btrfs: introduce btrfs_subpage for data inodes
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210116071533.105780-1-wqu@suse.com>
 <20210116071533.105780-17-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <886e0c40-67e6-9700-1373-b29de2e3be95@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:28:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210116071533.105780-17-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/16/21 2:15 AM, Qu Wenruo wrote:
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
> ---
>   fs/btrfs/compression.c      | 10 ++++++--
>   fs/btrfs/extent_io.c        | 46 +++++++++++++++++++++++++++++++++----
>   fs/btrfs/extent_io.h        |  3 ++-
>   fs/btrfs/file.c             | 24 ++++++++-----------
>   fs/btrfs/free-space-cache.c | 15 +++++++++---
>   fs/btrfs/inode.c            | 12 ++++++----
>   fs/btrfs/ioctl.c            |  5 +++-
>   fs/btrfs/reflink.c          |  5 +++-
>   fs/btrfs/relocation.c       | 12 ++++++++--
>   9 files changed, 99 insertions(+), 33 deletions(-)
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
> index 35fbef15d84e..4bce03fed205 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3194,10 +3194,39 @@ static int attach_extent_buffer_page(struct extent_buffer *eb,
>   	return 0;
>   }
>   
> -void set_page_extent_mapped(struct page *page)
> +int __must_check set_page_extent_mapped(struct page *page)
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
> +		return btrfs_attach_subpage(fs_info, page);
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
> @@ -3254,7 +3283,12 @@ int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
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
> @@ -3694,7 +3728,11 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
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
> index bedf761a0300..357a3380cd42 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -178,7 +178,8 @@ int btree_write_cache_pages(struct address_space *mapping,
>   void extent_readahead(struct readahead_control *rac);
>   int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
>   		  u64 start, u64 len);
> -void set_page_extent_mapped(struct page *page);
> +int __must_check set_page_extent_mapped(struct page *page);
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
> index fd6ddd6b8165..379bef967e1d 100644
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
> +			return -ENOMEM;
> +		}

If we're going to declare ret here we might as well

return ret;

otherwise we could just lose the error if we add some other error in the future.

<snip>

> @@ -8345,7 +8347,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   	wait_on_page_writeback(page);
>   
>   	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
> -	set_page_extent_mapped(page);
> +	ret2 = set_page_extent_mapped(page);
> +	if (ret2 < 0)
> +		goto out_unlock;
>   

We lose the error in this case, you need

if (ret2 < 0) {
	ret = vmf_error(ret2);
	goto out_unlock;
}

>   	/*
>   	 * we can't set the delalloc bits if there are pending ordered
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 7f2935ea8d3a..50a9d784bdc2 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1314,6 +1314,10 @@ static int cluster_pages_for_defrag(struct inode *inode,
>   		if (!page)
>   			break;
>   
> +		ret = set_page_extent_mapped(page);
> +		if (ret < 0)
> +			break;
> +

You are leaving a page locked and leaving it referenced here, you need

if (ret < 0) {
	unlock_page(page);
	put_page(page);
	break;
}

thanks,

Josef
