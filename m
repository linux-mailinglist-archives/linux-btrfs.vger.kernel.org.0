Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09316545A84
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 05:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiFJDbi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 23:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJDbh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 23:31:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BDC647A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 20:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H3YWPqMTh5FI0O0OkL+oZL6QN6mZoq2W3Uakq7sncm4=; b=IoWaWe14dwfo+LTL/lxuLF0Mlk
        E3UlNR17gSSQkbQe0CpaeNJM5HNQLjTRb4G2CKUsIUcaaRN6EJvPP1RMXcjKCBe6/rs6MLJ8ccLXG
        jKKtJ6aDybScDXcdVgd/2YUcJFVM07q56jZ2ipc5686Ry1NE6q+povyyETDe8MOMYnmW4/Jnf9nHa
        6FByAMYRanyasxMoQbvB8lHH8j/5/oDTmr7F/Bs2XTJgJkPCmn0ofZUGQF99nYPQAYyjGu6xpsgB8
        USNTyl3SfIPPfURvuT9W2D1n8VpbHvp+ZtNTypzB0ikYgV+Icxu/UseYeMOtrD8UXK2IoqJRWXqkD
        Yy4OzROA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzVMz-00E6yJ-OI; Fri, 10 Jun 2022 03:31:33 +0000
Date:   Fri, 10 Jun 2022 04:31:33 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dsterba@suse.cz, David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <YqK7FZrz+xVxl541@casper.infradead.org>
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
 <YqKhCDu0tOcdGpKA@casper.infradead.org>
 <60abd620-0ec0-9ab2-74ac-8fc06e21d193@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60abd620-0ec0-9ab2-74ac-8fc06e21d193@gmx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 10:46:18AM +0800, Qu Wenruo wrote:
> On 2022/6/10 09:40, Matthew Wilcox wrote:
> > On Fri, Jun 10, 2022 at 12:59:06AM +0200, David Sterba wrote:
> > > On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
> > > > > v2:
> > > > > 
> > > > > - allocate 3 pages per device to keep parallelism, otherwise the
> > > > >     submission would be serialized on the page lock
> > > > 
> > > > Wouldn't this cause extra memory overhead for non-4K page size systems?
> > > > 
> > > > Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
> > > > page size systems?
> > > 
> > > Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
> > > possible, for bios we need the page pointer but we should be able to get
> > > it from the kmalloc address. I'd rather do that in a separate change
> > > though.
> > 
> > Slab uses the entirety of the struct page; if you use kmalloc, you
> > need a separate side structure to keep your metadata in rather than
> > using the struct page for your metadata.
> 
> Any idea what structure in page we need for this super block write scenario?
> 
> Currently in btrfs_end_super_write(), it only handle PageUptodate and
> PageError.
> 
> But we only set them, and never really utilize them, resulting btrfs to
> ignore any IO error on superblocks.

Huh?  I see btrfs reporting errors using them.  eg write_all_supers()
sums up total_errors.

I mean, it's your filesystem; you decide what information you need to
keep about each write.

