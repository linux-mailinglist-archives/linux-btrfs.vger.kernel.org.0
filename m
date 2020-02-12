Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C51915A1E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBLHZ2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:25:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56384 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHZ1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:25:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R4BkbIQqThnCgZWEqCEkI+WObheyvlAJY7Qy0+QXFV8=; b=PE3nT39CztaAkde9egXKF0aZck
        o9PSh1z8mM/s6QYfPprG4MWm7aBPxgaEfa09Cw0/L1HluzaEln3ZcqLOkynCacVE/tbFNM+eaqgEw
        Ii/4Y3Z4X+X2OC14UYJimkV3pmllqvWnrKbttXwIddZOozctrP4m5pI4ZsdZk8Ft+KTjOHUnljy62
        E+0UDhnTp8ytqPDAZUrdDAwr84a7jEP4Y3teFsFKZOJvNJKJVWvyYNop+z4iaejEnKIwy4LeJeazb
        TpcrIjS9Ij3SRbVy5l0zatffgJRtIScBdDCP5mp1jjrz5U7HnR1LZomOS9z+qXb9CJdyCIie9Mt5Q
        45g0BsyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mOi-0000sC-TL; Wed, 12 Feb 2020 07:25:24 +0000
Date:   Tue, 11 Feb 2020 23:25:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 2/8] btrfs: don't kmap() pages from block devices
Message-ID: <20200212072524.GA30977@infradead.org>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212071704.17505-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 04:16:58PM +0900, Johannes Thumshirn wrote:
> Block device mappings are never in highmem so kmap() / kunmap() calls for
> pages from block devices are unneeded. Use page_address() instead of
> kmap() to get to the virtual addreses.
> 
> While we're at it, read_cache_page_gfp() doesn't return NULL on error,
> only an ERR_PTR, so use IS_ERR() to check for errors.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
