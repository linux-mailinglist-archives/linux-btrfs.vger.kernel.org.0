Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF26CF7C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 01:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjC2XzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Mar 2023 19:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjC2XzC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Mar 2023 19:55:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9259DA
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 16:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HgdkPTqwo4HHY5xU9rsQlfJhKK2CJY+rjK/ubTbJ8WY=; b=azVfo8wsWfO8QCQ2WDCVkSPLNI
        jE7cBv+emDdsCdDpeQf/HyEAwPpdCl3k3jDyQzAN8MYtTljdnb8gKVg2RJ2/iM/B76/mZbVaPxLMQ
        dXVJzQASkn5FYYPVUsOrhfBzUpSDfpU9W2dTXurPPAyMhiKl2E7MySrYBGJYC3NVErpLH1gz6Bsjv
        FsypW8TfchZ84P0GSB1tgM/jaS1pmtVzB7Zg/OvMb/80wNQyaF+MFJv94CZZLhfsD+dnWqWLiJAP/
        w8B6seNwFQ4eJd/4kQdxfv2WppkJqSabuMAV8LDQ1BhEZ4SguCXJsg7u6eBWOwPEuOK1WwSJBsVwb
        t9U1O1OA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfd4-0026QQ-2T;
        Wed, 29 Mar 2023 23:54:58 +0000
Date:   Wed, 29 Mar 2023 16:54:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v7 02/13] btrfs: introduce a new allocator for scrub
 specific btrfs_bio
Message-ID: <ZCTP0j4y0rqk3pGz@infradead.org>
References: <cover.1680047473.git.wqu@suse.com>
 <c77fd4fd93c34a6d229765088ce0a88f7f8718d4.1680047473.git.wqu@suse.com>
 <ZCTKola6a+tbtyrL@infradead.org>
 <3289eba8-8492-3c14-6e3c-f6ef7df7cbb1@gmx.com>
 <ZCTOJ28lA8OR/LFy@infradead.org>
 <70968e38-20e6-0db6-5c46-a7904b4ca0df@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70968e38-20e6-0db6-5c46-a7904b4ca0df@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 30, 2023 at 07:51:10AM +0800, Qu Wenruo wrote:
> On 2023/3/30 07:47, Christoph Hellwig wrote:
> > On Thu, Mar 30, 2023 at 07:39:43AM +0800, Qu Wenruo wrote:
> > > But as my usual tendency, it would still be better to have some ASSERT()s to
> > > make sure we're properly populating @inode for needed call sites.
> > 
> > Well, where would you place them?  The only place where we could do it
> > would be in btrfs_submit_chunk, but without having the inode there is
> > no way to know if we would have needed one.
> 
> Can we do something like "if (bbio->file_offset) ASSERT(bbio->inode);"?

We could do it, but it's also a bit confusing as NULL is a perfectly
valid file offset as well.  But I guess the inverse would make a little
more sense

	ASSERT(bbio->inode || bbio->file_offset == 0);

