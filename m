Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE63E3ED10E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 11:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhHPJ3Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 05:29:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41214 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhHPJ3X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 05:29:23 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DC8E1FD38;
        Mon, 16 Aug 2021 09:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629106131; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aezrShMK5XzAlwkkp0YHHoIB2zbBqncqNI+wtYdIHfY=;
        b=CHVOrlMcH5n3cMCeh2x+n+FrpGat+91J3dtkzsdgR52Y6exhT6a5XWYx/IGF5B0ExnBZ15
        MgMBOtITWgmi97lPxosiTqCYXE51GLFn4WEd+jEXmiIfrdpNJb1SIq5OssK3sahkA57rXu
        FIoUhvOELvGzUBA+AbmytbZOYU0F1sM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 770FB13301;
        Mon, 16 Aug 2021 09:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8iCAGtMvGmFVfQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 16 Aug 2021 09:28:51 +0000
Subject: Re: [PATCH 1/2] btrfs: introduce btrfs_subpage_bitmap_info
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210816060036.57788-1-wqu@suse.com>
 <20210816060036.57788-2-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <35622671-e0e3-6600-cfbc-1e48da29b806@suse.com>
Date:   Mon, 16 Aug 2021 12:28:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816060036.57788-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.21 г. 9:00, Qu Wenruo wrote:
> Currently we use fixed size u16 bitmap for subpage bitmap.
> This is fine for 4K sectorsize with 64K page size.
> 
> But for 4K sectorsize and larger page size, the bitmap is too small,
> while for smaller page size like 16K, u16 bitmaps waste too much space.
> 
> Here we introduce a new helper structure, btrfs_subpage_bitmap_info, to
> record the proper bitmap size, and where each bitmap should start at.
> 
> By this, we can later compact all subpage bitmaps into one u32 bitmap.
> 
> This patch is the first step towards such compact bitmap.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/ctree.h   |  1 +
>  fs/btrfs/disk-io.c | 12 ++++++++++--
>  fs/btrfs/subpage.c | 35 +++++++++++++++++++++++++++++++++++
>  fs/btrfs/subpage.h | 28 ++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4a69aa604ac5..a98fd6a24113 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -898,6 +898,7 @@ struct btrfs_fs_info {
>  	struct btrfs_workqueue *scrub_workers;
>  	struct btrfs_workqueue *scrub_wr_completion_workers;
>  	struct btrfs_workqueue *scrub_parity_workers;
> +	struct btrfs_subpage_info *subpage_info;
>  
>  	struct btrfs_discard_ctl discard_ctl;
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 1510a9d92858..f35b875f9e53 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1644,6 +1644,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
>  	btrfs_extent_buffer_leak_debug_check(fs_info);
>  	kfree(fs_info->super_copy);
>  	kfree(fs_info->super_for_commit);
> +	kfree(fs_info->subpage_info);
>  	kvfree(fs_info);
>  }
>  
> @@ -3393,11 +3394,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	}
>  
>  	if (sectorsize != PAGE_SIZE) {
> +		struct btrfs_subpage_info *subpage_info;
> +
> +		ASSERT(sectorsize < PAGE_SIZE);

nit: Simply make the check sectorsize < PAGE_SIZE and that renders the
assert redundant.

> +
>  		btrfs_warn(fs_info,
>  	"read-write for sector size %u with page size %lu is experimental",
>  			   sectorsize, PAGE_SIZE);
> -	}
> -	if (sectorsize != PAGE_SIZE) {
>  		if (btrfs_super_incompat_flags(fs_info->super_copy) &
>  			BTRFS_FEATURE_INCOMPAT_RAID56) {
>  			btrfs_err(fs_info,
> @@ -3406,6 +3409,11 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  			err = -EINVAL;
>  			goto fail_alloc;
>  		}
> +		subpage_info = kzalloc(sizeof(*subpage_info), GFP_NOFS);
> +		if (!subpage_info)
> +			goto fail_alloc;
> +		btrfs_init_subpage_info(subpage_info, sectorsize);
> +		fs_info->subpage_info = subpage_info;
>  	}
>  
>  	ret = btrfs_init_workqueues(fs_info, fs_devices);
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index a61aa33aeeee..014256d47beb 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -63,6 +63,41 @@
>   *   This means a slightly higher tree locking latency.
>   */
>  
> +void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
> +			     u32 sectorsize)
> +{
> +	unsigned int cur = 0;
> +	unsigned int nr_bits;
> +
> +	/*
> +	 * Just in case we have super large PAGE_SIZE that unsigned int is not
> +	 * enough to contain the number of sectors for the minimal sectorsize.
> +	 */
> +	BUILD_BUG_ON(UINT_MAX * SZ_4K < PAGE_SIZE);
> +
> +	ASSERT(IS_ALIGNED(PAGE_SIZE, sectorsize));
> +
> +	nr_bits = PAGE_SIZE / sectorsize;
> +	subpage_info->bitmap_nr_bits = nr_bits;
> +
> +	subpage_info->uptodate_start = cur;
> +	cur += nr_bits;
> +
> +	subpage_info->error_start = cur;
> +	cur += nr_bits;
> +
> +	subpage_info->dirty_start = cur;
> +	cur += nr_bits;
> +
> +	subpage_info->writeback_start = cur;
> +	cur += nr_bits;
> +
> +	subpage_info->ordered_start = cur;
> +	cur += nr_bits;
> +
> +	subpage_info->total_nr_bits = cur;

So those values are really consts, however due to them being allocated
on the heap you can't simply define them as const and initialize them.
What a bummer...


On the other hand the namings are a bit generic, those are really
offsets into subpage->bitmaps. As such I'd prefer something along the
lines of
writeback_bitmap_offset
ordered_bitmap_offset etc.

Also I believe a graphical representation is in order i.e


[u][u][u][u][e][e][e][e][e]
^			  ^
|-uptodate_start	  |- error_start etc

Since it's a bit unexpected to have multiple, logically independent
bitmaps be tracked in the same physical location.
> +}
> +
>  int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>  			 struct page *page, enum btrfs_subpage_type type)
>  {
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 9aa40d795ba9..ea90ba42c97b 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -11,6 +11,32 @@
>   */
>  #define BTRFS_SUBPAGE_BITMAP_SIZE	16
>  
> +/*
> + * Extra info for subpapge bitmap.
> + *
> + * For subpage we integrate all uptodate/error/dirty/writeback/ordered
> + * bitmaps into one larger bitmap.
> + * This structure records the basic info.
> + */
> +struct btrfs_subpage_info {
> +	/* Number of bits for each bitmap*/
> +	unsigned int bitmap_nr_bits;
> +
> +	/* Total number of bits for the whole bitmap */
> +	unsigned int total_nr_bits;
> +
> +	/*
> +	 * *_start indicates where the bitmap starts, the length
> +	 * is always @bitmap_size, which is calculated from
> +	 * PAGE_SIZE / sectorsize.
> +	 */
> +	unsigned int uptodate_start;
> +	unsigned int error_start;
> +	unsigned int dirty_start;
> +	unsigned int writeback_start;
> +	unsigned int ordered_start;
> +};
> +
>  /*
>   * Structure to trace status of each sector inside a page, attached to
>   * page::private for both data and metadata inodes.
> @@ -53,6 +79,8 @@ enum btrfs_subpage_type {
>  	BTRFS_SUBPAGE_DATA,
>  };
>  
> +void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info,
> +			     u32 sectorsize);
>  int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
>  			 struct page *page, enum btrfs_subpage_type type);
>  void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
> 
