Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3877B540456
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 19:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiFGRG3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFGRG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 13:06:28 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94138FF5B8
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 10:06:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F0675C017E;
        Tue,  7 Jun 2022 13:06:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Jun 2022 13:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1654621583; x=1654707983; bh=4SUje2BtAp
        QsbeFUsdBQ0ZdxuBs0KxyBcS21WQ5jbvA=; b=bqYffdihaB6OE0DjlXjlQrGaPI
        f0fwAoHEt0+AAvHxqycuyK8gfmvOlV0Xdyi9R/yZD5Vn9ObLGgwve4CC5/Qx3x1S
        GjWyRb4DCeOUsDuGchIGFUn/k/exrbk5DjFbIkv+FgyoZfJJ/JSg3YjRLRwkRHgr
        0gLO08Amw5hb6FeLd679SjntiYLnZIwEU9kekcBsPW7VWO6Yqw/cObdHn3GOiVxW
        xXrcnaV4FPofY2eG4tsRKU0LusP5l4oZHA/q6rhi8Z8q8jUMmFql+92y4eaeJlWt
        Dt88J/4uQU1wHGKcuP44J1icKZRTp04mBAvC0XtxTP9JBtSkmaZchsT3N62w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1654621583; x=1654707983; bh=4SUje2BtApQsbeFUsdBQ0ZdxuBs0
        KxyBcS21WQ5jbvA=; b=FvEwyeCH7M9DJYpofIgZYw2TOBRgAwvyae9T4i9MCupm
        rfcTI4wqhqO+upB0Z06qB8C3KMy3hCkWpNUmW3JytfE2an2e63Z2hxG+Cw5iluQQ
        i53yQ0YrBXuWnLpqUcq+2xKDnco/CrWwVxwPPPCNPgc5yss33SF8Ehe0krMvaWrY
        ATA0Qdjimc37lzgwjezddQzUaAUbKh/FZEloea6cyiHrQmYxfSJLkHBl7cuKOYDA
        a3wsDDmQu3+7oIyeQ/lPkA9blWiwd7muba3spuJzCq1yx7ryhKk1X4SGz6a86Q4K
        y/KjxnNtTFG7g65vwvf0dvkMn26k7a0JlIy5tGujHw==
X-ME-Sender: <xms:joWfYmj6RQ_RyC0Zdokk2VJVb87yxeuuZoNEouZxH4fG2ZFouqj8Fg>
    <xme:joWfYnAqm6-xizGygMxL7SnnkgSDzsEFgC1ymFhhEX1js5NKDP5EFHJ8EbKBslui_
    q26VUH0PXFgr9bJRA8>
X-ME-Received: <xmr:joWfYuEJ0mOXsvLty4ZAxUW5lNECzs7MsE5mujm5nTq7OgCHjDDVAuz0QWQ0rNi_GwCCA82DV-3mvtD6F6b-VP1a80qgDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    ephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeiheetleeghedvfeegfeegnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:j4WfYvTGnbOaVsDKzydfMQip5HEO0ZkrVlRZ_alqeBjet_zSiN13ug>
    <xmx:j4WfYjyyIHgrdDhFcmVqlm2eXscWhYdzH0IOPiCIP8AjMrpVUkYwGQ>
    <xmx:j4WfYt5nRF7bcXNRlxbm79vprNDD_ScjeLLkzV72kS8ROdw9aaVQOA>
    <xmx:j4WfYso8g45cdnE86ccmb0D1wDWN9TtRiXy7OIpAWdBRBU_VNoA0qQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jun 2022 13:06:22 -0400 (EDT)
Date:   Tue, 7 Jun 2022 10:06:20 -0700
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] btrfs: use preallocated page for super block write
Message-ID: <Yp+FjFF3kKvN07dw@zen>
References: <20220607154229.9164-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607154229.9164-1-dsterba@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 07, 2022 at 05:42:29PM +0200, David Sterba wrote:
> Currently the super block page is from the mapping of the block device,
> this is result of direct conversion from the previous buffer_head to bio
> conversion.  We don't use the page cache or the mapping anywhere else,
> the page is a temporary space for the associated bio.
> 
> Allocate the page at device allocation time, also to avoid any later
> allocation problems when writing the super block. This simplifies the
> page reference tracking, but the page lock is still used as waiting
> mechanism for the write and write error is tracked in the page.
> 
> This was inspired by Matthew's question
> https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/disk-io.c | 42 +++++++++++-------------------------------
>  fs/btrfs/volumes.c |  6 ++++++
>  fs/btrfs/volumes.h |  2 ++
>  3 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0f926d18e6ca..d10ad62ba54d 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3873,7 +3873,6 @@ static void btrfs_end_super_write(struct bio *bio)
>  			SetPageUptodate(page);
>  		}
>  
> -		put_page(page);
>  		unlock_page(page);
>  	}
>  
> @@ -3960,7 +3959,6 @@ static int write_dev_supers(struct btrfs_device *device,
>  			    struct btrfs_super_block *sb, int max_mirrors)
>  {
>  	struct btrfs_fs_info *fs_info = device->fs_info;
> -	struct address_space *mapping = device->bdev->bd_inode->i_mapping;
>  	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>  	int i;
>  	int errors = 0;
> @@ -3975,7 +3973,6 @@ static int write_dev_supers(struct btrfs_device *device,
>  	for (i = 0; i < max_mirrors; i++) {
>  		struct page *page;
>  		struct bio *bio;
> -		struct btrfs_super_block *disk_super;
>  
>  		bytenr_orig = btrfs_sb_offset(i);
>  		ret = btrfs_sb_log_location(device, i, WRITE, &bytenr);
> @@ -3998,21 +3995,17 @@ static int write_dev_supers(struct btrfs_device *device,
>  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE,
>  				    sb->csum);
>  
> -		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> -					   GFP_NOFS);
> -		if (!page) {
> -			btrfs_err(device->fs_info,
> -			    "couldn't get super block page for bytenr %llu",
> -			    bytenr);
> -			errors++;
> -			continue;
> -		}
> -
> -		/* Bump the refcount for wait_dev_supers() */
> -		get_page(page);
> +		/*
> +		 * Super block is copied to a temporary page, which is locked
> +		 * and submitted for write. Page is unlocked after IO finishes.
> +		 * No page references are needed, write error is returned as
> +		 * page Error bit.
> +		 */
> +		page = device->sb_write_page;
> +		ClearPageError(page);
> +		lock_page(page);
>  
> -		disk_super = page_address(page);
> -		memcpy(disk_super, sb, BTRFS_SUPER_INFO_SIZE);
> +		memcpy(page_address(page), sb, BTRFS_SUPER_INFO_SIZE);
>  
>  		/*
>  		 * Directly use bios here instead of relying on the page cache
> @@ -4079,14 +4072,7 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  		    device->commit_total_bytes)
>  			break;
>  
> -		page = find_get_page(device->bdev->bd_inode->i_mapping,
> -				     bytenr >> PAGE_SHIFT);
> -		if (!page) {
> -			errors++;
> -			if (i == 0)
> -				primary_failed = true;
> -			continue;
> -		}
> +		page = device->sb_write_page;
>  		/* Page is submitted locked and unlocked once the IO completes */
>  		wait_on_page_locked(page);
>  		if (PageError(page)) {
> @@ -4094,12 +4080,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
>  			if (i == 0)
>  				primary_failed = true;
>  		}
> -
> -		/* Drop our reference */
> -		put_page(page);
> -
> -		/* Drop the reference from the writing run */
> -		put_page(page);
>  	}
>  
>  	/* log error, force error return */
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 7513e45c0c42..a9588c52c1f3 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -394,6 +394,7 @@ void btrfs_free_device(struct btrfs_device *device)
>  	rcu_string_free(device->name);
>  	extent_io_tree_release(&device->alloc_state);
>  	btrfs_destroy_dev_zone_info(device);
> +	__free_page(device->sb_write_page);
>  	kfree(device);
>  }
>  
> @@ -6910,6 +6911,11 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return ERR_PTR(-ENOMEM);
> +	dev->sb_write_page = alloc_page(GFP_KERNEL);
> +	if (!dev->sb_write_page) {
> +		kfree(dev);
> +		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	INIT_LIST_HEAD(&dev->dev_list);
>  	INIT_LIST_HEAD(&dev->dev_alloc_list);
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index a3c3a0d716bd..4a6c4a5f6fe6 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -158,6 +158,8 @@ struct btrfs_device {
>  	/* Bio used for flushing device barriers */
>  	struct bio flush_bio;
>  	struct completion flush_wait;
> +	/* Temporary page for writing the superblock */
> +	struct page *sb_write_page;
>  
>  	/* per-device scrub information */
>  	struct scrub_ctx *scrub_ctx;
> -- 
> 2.36.1
> 
