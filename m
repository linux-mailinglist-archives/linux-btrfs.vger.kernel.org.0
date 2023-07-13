Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A21C751FF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjGMLcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 07:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjGMLcq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 07:32:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE87270D
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 04:32:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD3921FD8E;
        Thu, 13 Jul 2023 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689247961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oyq/R68zA9i9MrOMH2THhNFvOednoz8gGojgSJ/u5ao=;
        b=cIbrstJ2+gjjTQXFB6zYYTSNfYzJsdVLrJa2OY/JVCZflDvBpoZU6NCQ9wTH9KVhi4Bp1R
        BuhABsfAd+tZTaeFpXexjwU+ipdep5LYtQxH2kLRkCqo+JqN8LogGjncIsf3bFHnA3qYXn
        mqS7KVuHZosYalVfKSkdIukO7NW/OS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689247961;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oyq/R68zA9i9MrOMH2THhNFvOednoz8gGojgSJ/u5ao=;
        b=zYWAg3eRLUVaclAuLVUfH3IE1iNHMWowlF/cSrhOglSSuOBLrQWAZIV7UuDmzbY3z3ji5e
        de5btlKHx+s9zoAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8771E13489;
        Thu, 13 Jul 2023 11:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0n5LH9ngr2QVDgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 13 Jul 2023 11:32:41 +0000
Date:   Thu, 13 Jul 2023 13:26:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/6] btrfs: preparation patches for the incoming
 metadata folio conversion
Message-ID: <20230713112605.GO30916@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1689143654.git.wqu@suse.com>
 <ZK7XwgBJZDpWFuz6@infradead.org>
 <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff78f3e8-6438-4b29-02c0-c14fb5949360@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 13, 2023 at 07:58:17AM +0800, Qu Wenruo wrote:
> On 2023/7/13 00:41, Christoph Hellwig wrote:
> > On Wed, Jul 12, 2023 at 02:37:40PM +0800, Qu Wenruo wrote:
> >> One of the biggest problem for metadata folio conversion is, we still
> >> need the current page based solution (or folios with order 0) as a
> >> fallback solution when we can not get a high order folio.
> > 
> > Do we?  btrfs by default uses a 16k nodesize (order 2 on x86), with
> > a maximum of 64k (order 4).  IIRC we should be able to get them pretty
> > reliably.
> 
> If it can be done as reliable as order 0 with NOFAIL, I'm totally fine 
> with that.

I have mentioned my concerns about the allocation problems with higher
order than 0 in the past. Allocator gives some guarantees about not
failing for certain levels, now it's 1 (mm/fail_page_alloc.c
fail_page_alloc.min_oder = 1).

Per comment in page_alloc.c:rmqueue()

2814         /*
2815          * We most definitely don't want callers attempting to
2816          * allocate greater than order-1 page units with __GFP_NOFAIL.
2817          */
2818         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));

For allocations with higher order, eg. 4 to match the default 16K nodes,
this increases pressure and can trigger compaction, logic around
PAGE_ALLOC_COSTLY_ORDER which is 3.

> > If not the best thning is to just a virtually contigous allocation as
> > fallback, i.e. use vm_map_ram.

So we can allocate 0-order pages and then map them to virtual addresses,
which needs manipulation of PTE (page table entries), and requires
additional memory. This is what xfs does,
fs/xfs_buf.c:_xfs_buf_map_pages(), needs some care with aliasing memory,
so vm_unmap_aliases() is required and brings some overhead, and at the
end vm_unmap_ram() needs to be called, another overhead but probably
bearable.

With all that in place there would be a contiguous memory range
representing the metadata, so a simple memcpy() can be done. Sure,
with higher overhead and decreased reliability due to potentially
failing memory allocations - for metadata operations.

Compare that to what we have:

Pages are allocated as order 0, so there's much higher chance to get
them under pressure and not increasing the pressure otherwise.  We don't
need any virtual mappings. The cost is that we have to iterate the pages
and do the partial copying ourselves, but this is hidden in helpers.

We have different usage pattern of the metadata buffers than xfs, so
that it does something with vmapped contiguous buffers may not be easily
transferable to btrfs and bring us new problems.

The conversion to folios will happen eventually, though I don't want to
sacrifice reliability just for API use convenience. First the conversion
should be done 1:1 with pages and folios both order 0 before switching
to some higher order allocations hidden behind API calls.
