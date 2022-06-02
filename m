Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9622253BCC3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiFBQr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 12:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbiFBQrO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 12:47:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354A183A4;
        Thu,  2 Jun 2022 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uif769frfrYihV6YiWxMGs5eBDpigCO/7kp1qxb3WTw=; b=X1J8cjMICzgCsxkFRDuSKDibuq
        +hwtjZyiS864Fr7r7uq4aQq4PFJK8VVPtTvA3dgtknuPKyw4EBX1JB9s+nB3KGFIgggx0e3+GLv3u
        vbMu5+YaAl+ytycERctp3YK+2C3G7+LSwiYpjGTDu3vDFtLiYXFNWI6jC5/2Q830MFIX++tvDHvXZ
        YvlqbcBvFT8uBesnZGkUqv2HHz+vBTH52qY0pR6Zv4ulCVylu2shMJjutQoPXpL42ScCwY04aQYHA
        3aDk5gG94UFrHq7cR6qV4Oihdo5S6BMUAH89Wa7kSar0mhBXuMzt/ZEiI+pTDTLkoWTa+hq31TEtr
        btMsSDLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwnyC-007HMt-Qg; Thu, 02 Jun 2022 16:46:48 +0000
Date:   Thu, 2 Jun 2022 17:46:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     David Sterba <dsterba@suse.cz>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: Replace kmap() with kmap_local_page()
Message-ID: <YpjpeMsFsVUxuh3W@casper.infradead.org>
References: <20220531145335.13954-1-fmdefrancesco@gmail.com>
 <20220601132545.GM20633@twin.jikos.cz>
 <Ypjjt87qL+ROFBtM@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ypjjt87qL+ROFBtM@iweiny-desk3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 02, 2022 at 09:22:15AM -0700, Ira Weiny wrote:
> On Wed, Jun 01, 2022 at 03:25:45PM +0200, David Sterba wrote:
> > On Tue, May 31, 2022 at 04:53:32PM +0200, Fabio M. De Francesco wrote:
> > > This is the first series of patches aimed towards the conversion of Btrfs
> > > filesystem from the use of kmap() to kmap_local_page().
> > 
> > We've already had patches converting kmaps and you're changing the last
> > ones, so this is could be the last series, with two exceptions.
> > 
> > 1) You've changed lzo.c and zlib. but the same kmap/kunmap pattern is
> >    used in zstd.c.
> 
> I checked out zstd.c and one of the issues there is the way that the input
> workspace is mapped page by page while iterating those pages.
> 
> This got me thinking about what Willy said at LSFmm concerning something like
> kmap_local_range().  Mapping more than 1 page at a time could save some
> unmap/remap of output pages required for kmap_local_page() ordering.

Umm ... Not entirely sure what I said, but it'd be really hard to kmap
multiple pages with the current PAE implementation.  I've steered away
from doing that for now, and kmap_local_folio() just guarantees the
page that the offset lands in is mapped.

I don't think the right answer is having a kmap_folio() that will map
the entire folio.  I'd be more tempted to add vmap_folio() for that.
My understanding is that PAE systems have more address space available
for vmap than they do for kmap.

> Unfortunately, I think the length of the input is probably to long in many
> cases.  And some remapping may still be required.
> 
> Cc: Willy
> 
> As an aside, Willy, I'm thinking that a kmap_local_range() should return a
> folio in some way.  Would you agree?

I imagine it taking a folio to describe the range that's being accessed.
But maybe it should be a phys_addr_t?  I tend to prefer phys_addr_t over
pfn + offset as it's more compact on 64-bit systems and the same on
32-bit systems.
