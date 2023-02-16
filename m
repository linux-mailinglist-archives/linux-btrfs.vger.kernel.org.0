Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9B698FD3
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 10:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBPJaV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 04:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjBPJaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 04:30:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C151CAE7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 01:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EFZ2BXwFkMyBowHG13ErTQWRxsBkHRpaLPFUr4Las0w=; b=qi9dteTNc/IXSzPBnYW0B9EIKN
        DhqESM/931NRMUZXdqbbp+TBkQ3QW7QKoUtjNaz5T2OXByWzIv0plkOlR4sjA2MaOXIlwhIRX13Ha
        ufbKYnCL0yufnj437hfV4KftiMy3dLvYGkF1asu04xQT167HXygzUeXsbNHUzWnOn13dauLrFubAW
        1TpqEO9ngxsx9rYipMbjusYibyllVgDLkRwqrFCpxjVwxywum+QmYbhLJ821nVjLYTUGWnAFYmwfA
        pBzzZ3NAd57Q2W3UvNSqsROu3HFcxWgV6eiHXm81TGRbqRuTZFa7+evnjFoSwgYfqehV03fCpbCzL
        1HSf3IvQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSaao-009Ftr-1a; Thu, 16 Feb 2023 09:30:18 +0000
Date:   Thu, 16 Feb 2023 01:30:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Boris Burkov <boris@bur.io>
Cc:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: LMDB mdb_copy produces a corrupt database on btrfs, but not on
 ext4
Message-ID: <Y+33qhBxC592yw60@infradead.org>
References: <aa1fb69e-b613-47aa-a99e-a0a2c9ed273f@app.fastmail.com>
 <124a916c-786b-42ec-bc9d-db97bb081881@app.fastmail.com>
 <Y+1pAoetotjEuef7@zen>
 <Y+16BVPQiwf8e1J3@zen>
 <Y+2LCFrD4Qxff89Y@zen>
 <Y+3GHkKkytelqo3P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3GHkKkytelqo3P@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 09:58:54PM -0800, Christoph Hellwig wrote:
> The extract version if used for writes to zoned devices, which need
> to record a physical location on a per-write basis.  So what you done
> definitively works, as we already do it a little later for a subset of
> writes.
> 
> I also think it fundamentally is the right thing to do and was planning
> to do something similar for completely different reasons a little down
> the road.
> 
> The downside right now is that you pay the price of an extra ordered
> extent lookup for every submitted bio, and that an extra queue_work is
> required for the completion.  In my WIP work the former will eventually
> go away, and I've not found any benchmark impact from the latter.

Thinking out loud a bit more:

 - if we go down this route, calc_bio_boundaries also needs to set
   len_to_oe_boundary for non-zoned file system to ensure bios don't
   span ordered_extents.  They usually don't in my testing, and
   I have that change in my WIP tree for other reasons.
 - btrfs_extract_ordered_extent as-is actually is overkill for
   non-zone devices.  We'll need a version of it that doesn't do
   call split_zoned_em as that is only needed for the zoned case.
