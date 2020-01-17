Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D613B140D82
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 16:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgAQPMD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 10:12:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAQPMC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 10:12:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6741CB401;
        Fri, 17 Jan 2020 15:12:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D3449DA871; Fri, 17 Jan 2020 16:11:46 +0100 (CET)
Date:   Fri, 17 Jan 2020 16:11:45 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
Message-ID: <20200117151145.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20200117125105.20989-1-johannes.thumshirn@wdc.com>
 <20200117125105.20989-3-johannes.thumshirn@wdc.com>
 <6bdb46de-db12-27da-016d-773c362de254@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bdb46de-db12-27da-016d-773c362de254@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 05:01:35PM +0200, Nikolay Borisov wrote:
> > @@ -3494,26 +3507,20 @@ static int write_dev_supers(struct btrfs_device *device,
> >  				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> >  		crypto_shash_final(shash, sb->csum);
> >  
> > -		/* One reference for us, and we leave it for the caller */
> > -		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
> > -			      BTRFS_SUPER_INFO_SIZE);
> > -		if (!bh) {
> > +		page = find_or_create_page(device->bdev->bd_inode->i_mapping,
> > +					   bytenr >> PAGE_SHIFT, gfp_mask);
> 
> You introduce asymmetry here. Because the write path now utilizes the
> page cache whereas the read path uses plain page alloc. I'm not sure but
> could this lead to reading garbage from the super block because now you
> don't have synchronization between the read and write path. This reminds
> me why I was using the page cache and not a plain page. Also by
> utilising the page cache you will potentially be reducing IO to disk
> since you can be fetching the sb data directly from cache.

There won't be any data in the cache anyway, because
btrfs_get_bdev_and_sb calls invalidate_bdev just before reading the
superblock. But otherwise I agree that the cache must be used,
effectively the same way as __bread does with BH.
