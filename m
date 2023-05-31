Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051D9718149
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbjEaNUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjEaNUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:20:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B4598
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 06:20:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 336E768B05; Wed, 31 May 2023 15:20:32 +0200 (CEST)
Date:   Wed, 31 May 2023 15:20:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: new scrub code vs zoned file systems
Message-ID: <20230531132032.GA30016@lst.de>
References: <20230531125224.GB27468@lst.de> <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <546fad79-f436-c561-8b9b-0d9a7db09522@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 31, 2023 at 01:10:55PM +0000, Johannes Thumshirn wrote:
> So it looks like we're calling btrfs_lookup_ordered_extent() with a NULL
> inode.
> 
> This actually makes sense as the current scrub code does not have an inode
> in the bbio so:
> 
> btrfs_simple_end_io(bio)
> `-> btrfs_record_physical_zoned(btrfs_bio(bio))
>     `-> btrfs_lookup_ordered_extent(bbio->inode, ...)
>         `-> tree = &inode->ordered_tree;
>             spin_lock_irqsave(&tree->lock, flags); <--- BOOM
> 
> We don't really need the inode in the zoned code, but the ordered_extent.
> 
> I've just quickly skimmed over "add an ordered_extent pointer to struct 
> btrfs_bio v2" but didn't find anything that adds it for scrub writes as well.

That is correct, but as far as I can tell it is just the symptom.

The underlying issue is that the scrub code has no zone awareness at
all, and just tries to rewrite sectors in place.  The old code OTOH
tried to always migrate the entire BG (aka zone).

> 
> 
---end quoted text---
