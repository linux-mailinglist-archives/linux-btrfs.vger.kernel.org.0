Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8696615A1FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBLH2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:28:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgBLH2s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h3nZuZHtK5fROe5f3hx6w8CTTNcF23z8RHqxMlxIOh0=; b=FhlYTcQ3yjCExhYNZjVXOFo0QK
        oFvuOvYrnu16dIz1l6aA2JSszQbrDUOq/Rh/eBsmLp5pgWjEEOKAQtT0TgBigrXXBs+E1RSCP7NMk
        5yqjR7oB5ut9JUvAwdJdgQd2UpbXok5uwHjeOphNpdrsJHSo3VolkJ0uCDdSOc3/m9ukdDAmsnSa9
        xie5d6mVq0wB/2vr1IUjZQXMZfg1IvPdJW0DuwLVvGfinR7YhJu9EVk/sM84kkMwkeCknuFS5pOo1
        XrxbpqIbeo/qHHai0ZV3q/p/5g1xqQI0cn7XJq38iiqc+f9WUEPPovIGrzswkYmAdpJd5nyA2NW3c
        00pDJBIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mRy-0001bw-A7; Wed, 12 Feb 2020 07:28:46 +0000
Date:   Tue, 11 Feb 2020 23:28:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 4/8] btrfs: use the page-cache for super block reading
Message-ID: <20200212072846.GC30977@infradead.org>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-5-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212071704.17505-5-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 04:17:00PM +0900, Johannes Thumshirn wrote:
> Super-block reading in BTRFS is done using buffer_heads. Buffer_heads have
> some drawbacks, like not being able to propagate errors from the lower
> layers.
> 
> Directly use the page cache for reading the super-blocks from disk or
> invalidating an on-disk super-block. We have to use the page-cache so to
> avoid races between mkfs and udev. See also 6f60cbd3ae44 ("btrfs: access
> superblock via pagecache in scan_one_device").
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> ---
> Changes to v6:
> - Warn if we can't write out a page for a superblock (David)

Shouldn't there be some real error handling instead of just a warning?
At least shut down the file system?
