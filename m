Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB815AE08
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 18:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLRGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 12:06:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgBLRGY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 12:06:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59E04AC62;
        Wed, 12 Feb 2020 17:06:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 53FDADA8DB; Wed, 12 Feb 2020 18:06:08 +0100 (CET)
Date:   Wed, 12 Feb 2020 18:06:08 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v7 8/8] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Message-ID: <20200212170608.GN2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-9-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212071704.17505-9-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 04:17:04PM +0900, Johannes Thumshirn wrote:
> @@ -762,29 +761,45 @@ static int btrfsic_process_superblock_dev_mirror(
>  	struct btrfs_fs_info *fs_info = state->fs_info;
>  	struct btrfs_super_block *super_tmp;
>  	u64 dev_bytenr;
> -	struct buffer_head *bh;
>  	struct btrfsic_block *superblock_tmp;
>  	int pass;
>  	struct block_device *const superblock_bdev = device->bdev;
> +	struct page *page;
> +	struct bio bio;
> +	struct bio_vec bio_vec;
> +	struct address_space *mapping = superblock_bdev->bd_inode->i_mapping;
> +	int ret;
>  
>  	/* super block bytenr is always the unmapped device bytenr */
>  	dev_bytenr = btrfs_sb_offset(superblock_mirror_num);
>  	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)
>  		return -1;
> -	bh = __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,
> -		     BTRFS_SUPER_INFO_SIZE);
> -	if (NULL == bh)
> +
> +	page = find_or_create_page(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NOFS);
> +	if (!page)
> +		return -1;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = dev_bytenr >> SECTOR_SHIFT;
> +	bio_set_dev(&bio, superblock_bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
> +
> +	ret = submit_bio_wait(&bio);
> +	if (ret)
>  		return -1;
> -	super_tmp = (struct btrfs_super_block *)
> -	    (bh->b_data + (dev_bytenr & (BTRFS_BDEV_BLOCKSIZE - 1)));
> +
> +	unlock_page(page);
> +
> +	super_tmp = kmap(page);

I beleve the same reasoning applies here regarding kmap, it's the bdev
mapping and we won't get a highmem page.

>  
>  	if (btrfs_super_bytenr(super_tmp) != dev_bytenr ||
>  	    btrfs_super_magic(super_tmp) != BTRFS_MAGIC ||
>  	    memcmp(device->uuid, super_tmp->dev_item.uuid, BTRFS_UUID_SIZE) ||
>  	    btrfs_super_nodesize(super_tmp) != state->metablock_size ||
>  	    btrfs_super_sectorsize(super_tmp) != state->datablock_size) {
> -		brelse(bh);
> -		return 0;
> +		ret = 0;
> +		goto out_unmap;
>  	}
>  
>  	superblock_tmp =
