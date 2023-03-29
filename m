Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF526CF7A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjC2Xr6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC2Xrz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:47:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BB559EA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yGKzLjOhCsTc4RJ6kPAIDwvNzZeCKzRZ6dWC1Bdm9Fg=; b=qHPNpBjoIeIzVvL0PBTwa0kVve
        TaMHpGPorPFEOnK1ZOb2+lOFIer6ZdMc/qyx5Of/C5cyg2Tj9aAb57QUvZf8jcCizRGkvudVzp27j
        E2n2pi3086ztjmKxE9L/uU31J31wyUsBsNc+3CtlaA93N1DyG0g9nGQEkERi3sd2vx5c8GYDRWTtA
        Z4bbEqRmPHqob+V0Vfk0YyhyKSwKjb+3Z4xlofQZyPBs8Z7wmUPCKcd/u9IGJDwtihyOhaitKcLZz
        TkOW09nbMK0l4TNVw9vMo9HTTXEbfzAYdJ+t5LRhDXIKplEmjRLBtoT1fraklvL934kJWCisPPyk3
        jFpY6Dtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfWB-0025wS-1W;
        Wed, 29 Mar 2023 23:47:51 +0000
Date:   Wed, 29 Mar 2023 16:47:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
Message-ID: <ZCTOJ28lA8OR/LFy@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
 <ZCTKola6a+tbtyrL@infradead.org>
 <3289eba8-8492-3c14-6e3c-f6ef7df7cbb1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3289eba8-8492-3c14-6e3c-f6ef7df7cbb1@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 07:39:43AM +0800, Qu Wenruo wrote:
> But as my usual tendency, it would still be better to have some ASSERT()s to
> make sure we're properly populating @inode for needed call sites.

Well, where would you place them?  The only place where we could do it
would be in btrfs_submit_chunk, but without having the inode there is
no way to know if we would have needed one.

> Or we can easily pass some bbio, which should go through csum verification,
> without a valid @inode pointer, and to be treated as NODATACSUM.
> Such problem can be very hard to detect.

That's what we have tests or that check that csums were there and used
to detect and fix problems.

In the new world order I'd rather see bbio->inode != NULL as flag to
run the checksumming and repair infrastructure.  Especially as with a
bit more work I'll be able to never set bbio->inode for all metadata
I/O either, and possibly get rid of the btree inode entirely.
