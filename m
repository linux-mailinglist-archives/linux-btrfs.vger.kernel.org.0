Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B9513583
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Apr 2022 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347584AbiD1Nro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347589AbiD1Nrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 09:47:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77DB3DEF
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 06:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tPVxRfOuECWIZKbLTpfuOg3cX3+aY8J96Hb1iY1WuYg=; b=mDQ5f+esJfwCDnBqOZguUBty5k
        tMVlDDB9ELlfWmr8Sj+oNfR8NYUPlfK/s1Hg2RUIvEUrMNZomp7dsu9/fWmqjmj/dg4Gw2TUZEhkr
        zxb1H/VM21wiylcE6y6sJK5cPIPXOEgnC7wfw1cjpK2SGkPBbJ/dPrB0Kg6Nj3pyQQ9xyb6VWEz3H
        /lRkSFWpI2YuzdwlIw0/8hAbWz8+MCut7c5HqH7VyOnAHe7PxospohsJODPlURps/nLoM+ZOOs9xo
        6VDdXM9/LzyC4WEUAMQmpKJZiYpDY/Cfk6uD+K9zmx5r7fe5z09/rSRxPEOWAqB6qBPplTcnhhr0h
        gHE/cf9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nk4RX-007A5q-87; Thu, 28 Apr 2022 13:44:27 +0000
Date:   Thu, 28 Apr 2022 06:44:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC v2 05/12] btrfs: add a helper to queue a corrupted
 sector for read repair
Message-ID: <YmqaOynJjWS2XB76@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <a136fe858afe9efd29c8caa98d82cb7439d89677.1651043617.git.wqu@suse.com>
 <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd10883-5a4d-5cbd-d09f-7a30bb326a4a@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 01:20:37PM +0800, Qu Wenruo wrote:
> This function will get called very frequently, and I really want to avoid
> doing such re-search every time from the beginning of the original bio.
> 
> Maybe we can cache a bvec_iter and using the bi_size to check if the target
> offset is still beyond us (then advance), or re-wind and re-search from the
> beginning.
> 
> I guess there is no existing helper to do the same work, right?

It is basically impossible to review this because you just add a
standalone static helper without the callers.  Please split the
work into logical chunks that actually are reviewable.  Yes, that will
be a pretty large patch, but that's still much better than having to
jump around hal a dozen ones.

No, there is no way to efficiently look up what bvec in a bio some
offset falls into, because the bvecs are variable length.

It seems like the caller (at least the one added a little later, not
sure if there are more) is iterating over the bitmap and then calls
this for every bit set.  So for that you're much better off making
the __bio_for_each_segment the main loop, and then at the beginning of
the loop checking the bitmap if we need to handle this sector.


> > +	struct bio_list read_bios;

I'd just calls this bios.  Obviously they are used for reading here.

Also please be very careful about dead locks.  The mempool for the
btrfs_bios is small right now, you need to size it up by the
largerst number of bios that can be on this list.
