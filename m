Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1805A439AB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Oct 2021 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhJYPrf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Oct 2021 11:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhJYPra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Oct 2021 11:47:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B9C061745;
        Mon, 25 Oct 2021 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/4DvD0e1FZPOTxEhYNHi1otDSuS1bS0YBpl8+6thuZA=; b=EWLAZEeDAHe7eHhWv76S28SF5B
        +zNXkIx+VgqQndT7hBAgmBomvweuitB5mHtJMgAAkts72ISvoadRquNMKlJPiJ/507DGVSfPcjqgc
        uwVp0bqYUOUO/OOrYdze4fr7jLBVqTjMiKFQWReiM1xWe7z97SGWHSKPL6NIMaFgAbgZZzLP04SUe
        7qmjyZxR/Y37FjY3h/9+ohKowcIXdc+f1zdb433Iv9ZHpB8xa0uT1g4wsM7BPbUYuzPfKf8YRgAeR
        /FLvIqxWBr/SCSQ8mgp7BZ1I9N+JsEl0XPSbzgJ5PBNj2BuFmc5M3e0KmdyWtPnZ9/KI3HS1m+8Ez
        A/OHawDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mf28B-00GELE-CE; Mon, 25 Oct 2021 15:43:41 +0000
Date:   Mon, 25 Oct 2021 16:43:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Shared memory for shared extents
Message-ID: <YXbQm6TxaWcLnpal@casper.infradead.org>
References: <cover.1634933121.git.rgoldwyn@suse.com>
 <YXNoxZqKPkxZvr3E@casper.infradead.org>
 <20211025145301.hk627p2qcotxegrd@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025145301.hk627p2qcotxegrd@fiona>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 25, 2021 at 09:53:01AM -0500, Goldwyn Rodrigues wrote:
> On  2:43 23/10, Matthew Wilcox wrote:
> > On Fri, Oct 22, 2021 at 03:15:00PM -0500, Goldwyn Rodrigues wrote:
> > > This is an attempt to reduce the memory footprint by using a shared
> > > page(s) for shared extent(s) in the filesystem. I am hoping to start a
> > > discussion to iron out the details for implementation.
> > 
> > When you say "Shared extents", you mean reflinks, which are COW, right?
> 
> Yes, shared extents are extents which are shared on disk by two or more
> files. Yes, same as reflinks. Just to explain with an example:
> 
> If two files, f1 and f2 have shared extent(s), and both files are read. Each
> file's mapping->i_pages will hold a copy of the contents of the shared
> extent on disk. So, f1->mapping will have one copy and f2->mapping will
> have another copy.
> 
> For reads (and only reads), if we use underlying device's mapping, we
> can save on duplicate copy of the pages.

Yes; I'm familiar with the problem.  Dave Chinner and I had a great
discussion about it at LCA a couple of years ago.

The implementation I've had in mind for a while is that the filesystem
either creates a separate inode for a shared extent, or (as you've
done here) uses the bdev's inode.  We can discuss the pros/cons of
that separately.

To avoid the double-lookup problem, I was intending to generalise DAX
entries into PFN entries.  That way, if the read() (or mmap read fault)
misses in the inode's cache, we can look up the shared extent cache,
and then cache the physical address of the memory in the inode.

That makes reclaim/eviction of the page in the shared extent more
expensive because you have to iterate all the inodes which share the
extent and remove the PFN entries before the page can be reused.

Perhaps we should have a Zoom meeting about this before producing duelling
patch series?  I can host if you're interested.
