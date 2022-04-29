Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF61B514EC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 17:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377635AbiD2POp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 11:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiD2POm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 11:14:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C68D4473
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5/tzznkof2OwH+EMg315MHLXh49lHMTYBy97/A2xNOg=; b=VUi5ug5Ze/YB7OW2E7djq+yihY
        oYCBrCtThU5PKsVFq6GiE4B7x61wbKsuRa5UdHa8PTM+AdwI0ai9KEuXZthrkPP5AjFvbAz8QeId8
        46j9v4fABA+9S39q0tev4UGIp5gqno7CLtBs/UXz2t7CdDTV+yqAH6BieYq6zOtLETz17dIuwlofH
        mwz6Hql96FAWR5NJOqt4QOrIj8QKzp/gcBrnkZps3FIDx/K14URVpm159bGnJLqcRJ7q23+BTlQOv
        uFPjyRBORBFCBwNJQDkbRSYUH7RPWy6Gu4BZI2hja0nn6sQC8Bgn2i7+ryZ/EXYH/ybTKL3rKrqDe
        GOrjvPfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkSHA-00BinZ-4U; Fri, 29 Apr 2022 15:11:20 +0000
Date:   Fri, 29 Apr 2022 08:11:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 04/12] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Message-ID: <YmwAGKtOFn6pKcPg@infradead.org>
References: <cover.1651043617.git.wqu@suse.com>
 <ad61ab273c5f591cb4963f348c4b34302f705705.1651043617.git.wqu@suse.com>
 <YmqYm+iFDSRTbV5W@infradead.org>
 <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27d0b0f-89de-13a5-013b-323e03d7cc40@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> > the I/O completion work queues, which can be rather deadlock heavy.
> > Never mind that just failing an I/O repair/recovery when we are out
> > of memory seems like a rather bad idea.
> 
> That's why there is a btrfs_read_repair_ctrl::error member.
> 
> If we failed the memory allocation, then we will not do any repair.

And that's a little broken, isn't it?

> To me, memory allocation is a much bigger problem.
> 
> 
> Although we can put the bitmap into btrfs_bio structure, and
> pre-allocate it for every bio we're going to submit.
> 
> But I'm not sure if the pre-allocation way is a good idea, considering
> read-repair should be a relatively code path.

And that is what a mempool is for.

> 
> > it in a new read_repair.c instead of in the giant extent_io.c and
> > inode.c files?
> 
> I was considering putting it into read_repair.c, and since you're also
> mentioning that, I guess it's a good idea now.
> 
> And if we're going to make that structure private, I guess we have to
> pre-allocate it in btrfs_bio as a pointer then.

I really think a mempool is the right choice here.  This gives us a
guaranteed number of objects to make progress, even allowing for more
if memory pressure allows for it.
