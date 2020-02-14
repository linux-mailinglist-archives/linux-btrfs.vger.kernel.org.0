Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A608015DA24
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgBNPDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 10:03:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:47648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgBNPDL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 10:03:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5B4E0AC4A;
        Fri, 14 Feb 2020 15:03:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4978FDA703; Fri, 14 Feb 2020 16:02:54 +0100 (CET)
Date:   Fri, 14 Feb 2020 16:02:54 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Message-ID: <20200214150253.GX2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200213152436.13276-1-johannes.thumshirn@wdc.com>
 <20200213152436.13276-6-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213152436.13276-6-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 14, 2020 at 12:24:33AM +0900, Johannes Thumshirn wrote:
> +		bio = bio_alloc(GFP_NOFS, 1);
> +		bio_set_dev(bio, device->bdev);
> +		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
> +		bio->bi_private = device;
> +		bio->bi_end_io = btrfs_end_super_write;
> +		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
> +			       offset_in_page(bytenr));
>  
>  		/*
> -		 * we fua the first super.  The others we allow
> +		 * We fua the first super.  The others we allow
>  		 * to go down lazy.
>  		 */
> -		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
> +		bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_META | REQ_PRIO;
>  		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
> -			op_flags |= REQ_FUA;
> -		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
> -		if (ret)
> -			errors++;
> +			bio->bi_opf |= REQ_FUA;
> +
> +		btrfsic_submit_bio(bio);

btrfsic_submit_bh forwards the return values, and could increase error
counter, now btrfsic_submit_bio does not forward submit_bio return
value.

I traced it to generic_make_request, the comment says it does not return
error, so not handling it is ok.

>  static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)

>  	for (i = 0; i < max_mirrors; i++) {
> +		struct page *page;
> +
>  		bytenr = btrfs_sb_offset(i);
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
>  		    device->commit_total_bytes)
>  			break;
>  
> -		bh = __find_get_block(device->bdev,
> -				      bytenr / BTRFS_BDEV_BLOCKSIZE,
> -				      BTRFS_SUPER_INFO_SIZE);
> -		if (!bh) {
> +		page = find_get_page(device->bdev->bd_inode->i_mapping,
> +				     bytenr >> PAGE_SHIFT);
> +		if (!page) {
>  			errors++;
>  			if (i == 0)
>  				primary_failed = true;
>  			continue;
>  		}
> -		wait_on_buffer(bh);
> -		if (!buffer_uptodate(bh)) {
> +		wait_on_page_locked(page);

And here it's checking the result that could be set by
btrfs_end_super_write (SetPageError). The waiting part is due to the
PG_Locked bit. Please add some comments.

> +		if (PageError(page)) {
>  			errors++;
>  			if (i == 0)
>  				primary_failed = true;
>  		}
>  
>  		/* drop our reference */
> -		brelse(bh);
> +		put_page(page);
>  
>  		/* drop the reference from the writing run */
> -		brelse(bh);
> +		put_page(page);
>  	}
>  
>  	/* log error, force error return */
> -- 
> 2.24.1
