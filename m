Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8331B5459A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbiFJBke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jun 2022 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJBkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Jun 2022 21:40:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717706898A
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jun 2022 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+0hNehEcDnALTDzREMyqZiv3+JRJtMXaARAqV1CDObw=; b=YbyqvaK2IH5jD2/TXXwHHjL+6W
        tKKNtPCorz9HkMBF6azup8Cq/6W0IRZ/SpNu21lxYL5PZMtcQIbyAyVrsUXNh1WYwgInFjjuL+wP7
        eAHzzBwDxPjHl5VSsHPWDG7poXlWtRVsaBkMC6zPluQfdJYLuS4ujmLTSrG876ApvoaKmlDV3W5wV
        XqPYH2kUffvojCHviozljiNTEYrctY/sE7fiqfejVBG9Orx+nPsH34NjBFb8djo4JYkZRf4loZwmj
        cEBKfQeDvtem2Cefl7gu9u3vF1qypVmM7BIWYnm1mu2SQ/7rh/+K2fmEziIEhLY75rGUI3io485Il
        nSqRrF3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzTdQ-00E1AF-PD; Fri, 10 Jun 2022 01:40:24 +0000
Date:   Fri, 10 Jun 2022 02:40:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        nborisov@suse.com
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Message-ID: <YqKhCDu0tOcdGpKA@casper.infradead.org>
References: <20220609164629.30316-1-dsterba@suse.com>
 <17d8d373-f836-5d23-2939-d9dfcb65ae7e@gmx.com>
 <20220609225906.GX20633@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609225906.GX20633@twin.jikos.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 12:59:06AM +0200, David Sterba wrote:
> On Fri, Jun 10, 2022 at 06:58:00AM +0800, Qu Wenruo wrote:
> > > v2:
> > >
> > > - allocate 3 pages per device to keep parallelism, otherwise the
> > >    submission would be serialized on the page lock
> > 
> > Wouldn't this cause extra memory overhead for non-4K page size systems?
> > 
> > Would simpler kmalloc() fulfill the requirement for both 4K and non-4K
> > page size systems?
> 
> Yeah on pages larger than 4K it's a bit wasteful. kmalloc should be
> possible, for bios we need the page pointer but we should be able to get
> it from the kmalloc address. I'd rather do that in a separate change
> though.

Slab uses the entirety of the struct page; if you use kmalloc, you
need a separate side structure to keep your metadata in rather than
using the struct page for your metadata.
