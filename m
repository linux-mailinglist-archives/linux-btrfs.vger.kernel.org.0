Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FD66A83EB
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjCBOCB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCBOCB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:02:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C74548E24
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xaF8JislDkue6ksvzBXPMVD2zEMPRh4MlaKde8wjFHE=; b=VpqPTN6NnwgzEDnkkMfRPla31b
        hmIMX08l5H4Ap6Zn6L0EU3V7L71hT5U8gyZ5udQ+4vS75+HaDeRfuU2JxfXlMCjnL4uC8QeIuMtOL
        HR/Ynq2QolZ4UELgnCe/p6ago+H0N5aThhU5u1bjGLcLzvAFnf0SQYUCYLSjak08vrabSauc8y09g
        n5dNPlimHTl+NrUwZN8jgv1mWw1tnMl3P2SLzTxdVitW0AWtU2PGWRQEQsrXTLMds2VOt7+JEJwy5
        IEfkfYzDHowkNMGkQ7s55Wa2aL7AAQKEwpDE+B30v3c638uD1qhwME3NOfoX6m5T8rvbzutoVYnQ8
        dO5X5/Mg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXjVM-002OyV-NK; Thu, 02 Mar 2023 14:01:56 +0000
Date:   Thu, 2 Mar 2023 06:01:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 04/13] btrfs: add support for inserting raid stripe
 extents
Message-ID: <ZACsVI3mfprrj4j6@infradead.org>
References: <cover.1677750131.git.johannes.thumshirn@wdc.com>
 <94293952cdc120b46edf82672af874b0877e1e83.1677750131.git.johannes.thumshirn@wdc.com>
 <3e2d5ede-fb00-3aa8-e55e-d088b8df9e60@gmx.com>
 <b5bfe1a9-51dc-2a94-5ebd-4673b896d5ea@wdc.com>
 <6eabe69c-3abe-255b-797f-7917cd6a33cd@gmx.com>
 <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bd4ce91-58e6-f68b-6d69-3f9deff39ff5@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 11:58:13AM +0000, Johannes Thumshirn wrote:
> > Thus it can cause deadlock if the workqueue has one max_active, and the 
> > running one is finish_ordered_fn(), which then can be waiting for the 
> > RST work.
> > 
> > But the RST work can only be executed if the endio_workers has finished 
> > its current work, thus leading to a deadlock.
> 
> How about adding a new workqueue for RST updates? That should mitigate
> the deadlock.

The amount of weird workqueues in the btrfs end I/O path is worrysome.
What I plan to do, and might be ready to submit about next week is a
series to actually offload the I/O completion to a workqueue on a
per (original) btrfs_bio basis.  This means that RST updates,
ordered_extent processing, compressed write handling etc can all
run from the same end I/O worker.  As a bonus we remove all irqsave
locking from btrfs.
