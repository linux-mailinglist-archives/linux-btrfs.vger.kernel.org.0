Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A310B154765
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBFPL6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:11:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37532 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgBFPLn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZFk7IOgbesF7yVq11kopj6A6elmWy+W9AHpajAqV7CE=; b=QLJk1DSSipqWnEpF2DbSQ3LSPj
        SzI2RXW9pjb+WPUuPVsg9tLxNCvwnsiEkhlg4cfj96bfW79i0JFaG0UiZKgJSanPdh5lzvdiggLj2
        CbXEfVq8q/44MIuKTHgslsjGXRqwtRak3ESd8W7ee8VjspSKtf8Qb4f2Bwvgr+sSEpRg1Eks/XFFO
        HTHQm7MyBwHpsqAiH4c2DgOn5bbGqjguu9YSP0eXMkDALYH2T5qabnAerjjeCnKRGbwUk2KCtmxOh
        PHZwmUFjYjRebG0K+8/TjL5q6ieqaaimzAFA6PmvbyyNZ1xKOe+kyYBYlmv1347sYreL7JbMDHgaL
        9vuBYmmg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izibP-0006UI-3f; Thu, 06 Feb 2020 14:57:59 +0000
Date:   Thu, 6 Feb 2020 06:57:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Message-ID: <20200206145759.GA24780@infradead.org>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
 <20200205165319.GA6326@infradead.org>
 <SN4PR0401MB359854D81C504BBE28B8B2EB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359854D81C504BBE28B8B2EB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 06, 2020 at 08:17:20AM +0000, Johannes Thumshirn wrote:
> >> +	super = kmap(page);
> >>   	if (btrfs_super_bytenr(super) != bytenr ||
> >>   		    btrfs_super_magic(super) != BTRFS_MAGIC) {
> >> -		brelse(bh);
> >> +		kunmap(page);
> >> +		put_page(page);
> >>   		return -EINVAL;
> >>   	}
> >> +	kunmap(page);
> > 
> > Also last time I wondered why we can't leave the page mapped for the
> > caller and also return the virtual address?  That would keep the
> > callers a little cleaner.  Note that you don't need to pass the
> > struct page in that case as the unmap helper can use kmap_to_page (and
> > I think a helper would be really nice for the unmap and put anyway).
> > 
> 
> There's btrfs_release_disk_super() but David didn't like the use of it 
> in v2 of this series. But when using a 'struct btrfs_disk_super' instead 
> of a 'struct page' I think he could be ok.

Also I just noticed don't even need the kmap/kunmap at all given that the
block device mapping is never in highmem.
