Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F3814B3C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 12:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1Lwl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 06:52:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgA1Lwl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 06:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AUnLnP8oxFX+CXSCJN94E2iaEDh3JvVJcq2FACyQriw=; b=JbhZbWWUciWZQAmv/Z3p043uO
        lv/SF9DBgsMw37Ry0zyCTZfl41h0TLp/BWmbwL4hLNZLFWFJvgNTZx6BWqspGOvijnyx+5IXiwJrw
        DWt+z2yoBwmftxmR2/KWewPgLHM2n54iUKDM4+zeuQn6tTB0a2u9TMwgJJ3FWQVzgPIYNoCxm3Hsv
        gjTyg2mJYiWboNi2qUDJXnBLXom3SZltp/4PXFkkY8JFtopW0idLNpsNe3+IYhY3KlRx9hxvRRHWq
        XaKspYsHxLAc40xFpZWwjlPpn1uo/iTDQ1G46V6vSSJ3Bfwacd2xo9hQQzOAbFrctjimw/RcOagz8
        GI5JQMseQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwPQ7-0001qa-O1; Tue, 28 Jan 2020 11:52:39 +0000
Date:   Tue, 28 Jan 2020 03:52:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 2/5] btrfs: remove use of buffer_heads from superblock
 writeout
Message-ID: <20200128115239.GB17444@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200127155931.10818-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127155931.10818-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 12:59:28AM +0900, Johannes Thumshirn wrote:
> Similar to the superblock read path, change the write path to using BIOs
> and pages instead of buffer_heads. This allows us to skip over the
> buffer_head code, for writing the superblock to disk.

Hmm, the previous patch already changed one place that wrote the sb..

> -		/* One reference for us, and we leave it for the caller */
> -		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
> -			      BTRFS_SUPER_INFO_SIZE);
> -		if (!bh) {
> +		page = find_or_create_page(mapping, bytenr >> PAGE_SHIFT,
> +					   gfp_mask);
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

> +		/* Bump the refcount for wait_dev_supers() */
> +		get_page(page);
>  
> -		/* one reference for submit_bh */
> -		get_bh(bh);
> -
> -		set_buffer_uptodate(bh);
> -		lock_buffer(bh);
> -		bh->b_end_io = btrfs_end_buffer_write_sync;
> -		bh->b_private = device;
> +		ptr = kmap(page);
> +		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);
> +		kunmap(page);

What is the point of using the page cache here given that you are
always using a local copy of the data anyway?

> +		wait_on_page_locked(page);
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

Why not use an inflight count + completion instead of messing
with the page lock like that?
