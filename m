Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954231AAB9C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 17:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393315AbgDOPPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 11:15:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393310AbgDOPP3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 11:15:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E162ABE7;
        Wed, 15 Apr 2020 15:15:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D06ADA727; Wed, 15 Apr 2020 17:14:48 +0200 (CEST)
Date:   Wed, 15 Apr 2020 17:14:47 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Make btrfs_read_disk_super return struct
 btrfs_disk_super
Message-ID: <20200415151447.GD5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200415125346.468-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415125346.468-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 15, 2020 at 03:53:46PM +0300, Nikolay Borisov wrote:
> Instead of returning both the page and the super block structure, make
> btrfs_read_disk_super just return a pointer to struct btrfs_disk_super.
> As a result the function signature is simplified. Also,
> read_cache_page_gfp can never return NULL so check its return value only
> for IS_ERR.
^^^^^^^^^^^^^

>  	/* pull in the page with our super */
> -	*page = read_cache_page_gfp(bdev->bd_inode->i_mapping,
> -				   index, GFP_KERNEL);
> +	page = read_cache_page_gfp(bdev->bd_inode->i_mapping, index,
> +				   GFP_KERNEL);
>  
> -	if (IS_ERR(*page))
> -		return 1;
> +	if (IS_ERR(page))
> +		return ERR_CAST(page);

There's no NULL check as mentioned in the changelog, or do you mean to
make it explicit that there's no NULL check? The docs of
read_cache_page_gfp say it returns ERR_PTR so I consider it clear
enough. The changelog wording confuses me a bit, but otherwise the patch
looks good.

> -	p = page_address(*page);
> +	p = page_address(page);
>  
>  	/* align our pointer to the offset of the super block */
> -	*disk_super = p + offset_in_page(bytenr);
> +	disk_super = p + offset_in_page(bytenr);
>  
> -	if (btrfs_super_bytenr(*disk_super) != bytenr ||
> -	    btrfs_super_magic(*disk_super) != BTRFS_MAGIC) {
> +	if (btrfs_super_bytenr(disk_super) != bytenr ||
> +	    btrfs_super_magic(disk_super) != BTRFS_MAGIC) {
>  		btrfs_release_disk_super(p);
> -		return 1;
> +		return ERR_PTR(-EUCLEAN);
>  	}
>  
> -	if ((*disk_super)->label[0] &&
> -		(*disk_super)->label[BTRFS_LABEL_SIZE - 1])
> -		(*disk_super)->label[BTRFS_LABEL_SIZE - 1] = '\0';
> +	if (disk_super->label[0] && disk_super->label[BTRFS_LABEL_SIZE - 1])
> +		disk_super->label[BTRFS_LABEL_SIZE - 1] = '\0';
>  
> -	return 0;
> +	return disk_super;
>  }
>  
>  int btrfs_forget_devices(const char *path)
> @@ -1319,7 +1319,6 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	bool new_device_added = false;
>  	struct btrfs_device *device = NULL;
>  	struct block_device *bdev;
> -	struct page *page;
>  	u64 bytenr;
>  
>  	lockdep_assert_held(&uuid_mutex);
> @@ -1337,7 +1336,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, fmode_t flags,
>  	if (IS_ERR(bdev))
>  		return ERR_CAST(bdev);
>  
> -	if (btrfs_read_disk_super(bdev, bytenr, &page, &disk_super)) {
> +	disk_super = btrfs_read_disk_super(bdev, bytenr);
> +	if (IS_ERR(disk_super)) {
>  		device = ERR_PTR(-EINVAL);
>  		goto error_bdev_put;
>  	}
> -- 
> 2.17.1
