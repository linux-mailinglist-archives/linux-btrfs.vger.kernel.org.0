Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8254815992A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgBKSx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 13:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgBKSx2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 13:53:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE7A0AF92;
        Tue, 11 Feb 2020 18:53:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 33194DA703; Tue, 11 Feb 2020 19:53:13 +0100 (CET)
Date:   Tue, 11 Feb 2020 19:53:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 3/7] btrfs: use the page-cache for super block reading
Message-ID: <20200211185312.GF2902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200210183225.10137-1-johannes.thumshirn@wdc.com>
 <20200210183225.10137-4-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200210183225.10137-4-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 11, 2020 at 03:32:21AM +0900, Johannes Thumshirn wrote:
> @@ -7327,16 +7324,20 @@ void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_pat
>  
>  	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
>  		copy_num++) {
> +		struct page *page;
>  
> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> +		disk_super = btrfs_read_dev_one_super(bdev, copy_num);
> +		if (IS_ERR(disk_super))
>  			continue;
>  
> -		disk_super = (struct btrfs_super_block *)bh->b_data;
> -
>  		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> -		set_buffer_dirty(bh);
> -		sync_dirty_buffer(bh);
> -		brelse(bh);
> +
> +		page = virt_to_page(disk_super);
> +		set_page_dirty(page);
> +		lock_page(page); /* write_on_page() unlocks the page */
> +		write_one_page(page);

fs/btrfs/volumes.c: In function ‘btrfs_scratch_superblocks’:
fs/btrfs/volumes.c:7338:3: warning: ignoring return value of ‘write_one_page’, declared with attribute warn_unused_result [-Wunused-result]
 7338 |   write_one_page(page);

> +		btrfs_release_disk_super(disk_super);
> +
>  	}
>  
>  	/* Notify udev that device has changed */
