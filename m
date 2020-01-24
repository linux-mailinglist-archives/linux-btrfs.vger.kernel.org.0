Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D3E1486B6
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbgAXOQQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:16:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:52512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388691AbgAXOQQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:16:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC539AD07;
        Fri, 24 Jan 2020 14:16:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 612C5DA730; Fri, 24 Jan 2020 15:15:56 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:15:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] btrfs: remove use of buffer_heads from superblock
 writeout
Message-ID: <20200124141554.GK3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123081849.23397-4-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 23, 2020 at 05:18:46PM +0900, Johannes Thumshirn wrote:
> @@ -3507,26 +3520,22 @@ static int write_dev_supers(struct btrfs_device *device,
>  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  		crypto_shash_final(shash, sb->csum);
>  
> -		/* One reference for us, and we leave it for the caller */
> -		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
> -			      BTRFS_SUPER_INFO_SIZE);
> -		if (!bh) {
> +		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> +					   gfp_mask);

Note the difference: bh used BDEV_BLOCKSIZE which is fixed value of 4kb,
while bios use page size

With bh the bh_data always point to the requested 4KiB multiple, while
for the page it could be different. Now this will not break in practice
because all offsets of superblocks are multiples of 64KiB which is
probably the largest page size available on arches today.

> +		if (!page) {
>  			btrfs_err(device->fs_info,
> -			    "couldn't get super buffer head for bytenr %llu",
> +			    "couldn't get superblock page for bytenr %llu",
>  			    bytenr);
>  			errors++;
>  			continue;
>  		}
>  
> -		memcpy(bh->b_data, sb, BTRFS_SUPER_INFO_SIZE);
> -
> -		/* one reference for submit_bh */
> -		get_bh(bh);
> +		/* Bump the refcount for wait_dev_supers() */
> +		get_page(page);
>  
> -		set_buffer_uptodate(bh);
> -		lock_buffer(bh);
> -		bh->b_end_io = btrfs_end_buffer_write_sync;
> -		bh->b_private = device;
> +		ptr = kmap(page);
> +		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);

Copy superblock buffer to the beginning of the page, that's fine.

> +		kunmap(page);
>  
>  		/*
>  		 * we fua the first super.  The others we allow
> @@ -3535,9 +3544,17 @@ static int write_dev_supers(struct btrfs_device *device,
>  		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
>  		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
>  			op_flags |= REQ_FUA;
> -		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
> -		if (ret)
> -			errors++;
> +
> +		bio = bio_alloc(gfp_mask, 1);
> +		bio_set_dev(bio, device->bdev);
> +		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio->bi_private = device;
> +		bio->bi_end_io = btrfs_end_super_write;
> +		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> +			     offset_in_page(bytenr));

Now bytenr offset in page will be always 0 due to the 64K alignment, and
this also means that the correct data from sb are going to be written.

What bothers me is the implicit behaviour and dependence on the
alignment, either it should be offset_in_page everywhere or nowhere with
asserts to catch future 128KiB page capable CPUs.

> +
> +		bio_set_op_attrs(bio, REQ_OP_WRITE, op_flags);
> +		btrfsic_submit_bio(bio);
>  	}
>  	return errors < i ? 0 : -1;
>  }
