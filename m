Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4B371551F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 May 2023 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjE3Fnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 May 2023 01:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjE3FnM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 May 2023 01:43:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F531BD
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 22:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yxjHxkAlsSsnWEq0SPQr3kgVvuS+MFbc3I5FugBmR4Y=; b=yg7Y5ZPrywuUVB4xfmNie2YebR
        scfwmcoeQfj2NqvoQwYXAc1iWjIL5D3bNs5jbcZombtu4JnzQBtt3GCjnbDpQNjnaS4Y+wgj9AV8C
        nz1yYsLzwWPMwxd1clKRdlpmt4soNBTxxHm5+TREqcykex3pe0Ti4Xb6XXeXsWR0Rr2uVTJF9TQLn
        NkChV1fXVSNA3xAnmLtsMc9GJVE7QKSaNcflDCNnGXFu4y655XKdxhCayZ5mAzR0Tcma2VZIA5xbr
        isxnXr6nSkF5sWzohjpCe1QtOXRw6FdyK1zDOeFIXt+eW2enncZUel6S+030wlqMx0IT2Ej9JBT4F
        CEDqNbJQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q3s7H-00CUty-0q;
        Tue, 30 May 2023 05:41:55 +0000
Date:   Mon, 29 May 2023 22:41:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: use the same @uptodate variable for
 end_bio_extent_readpage()
Message-ID: <ZHWMozxgqRFosAyh@infradead.org>
References: <cover.1685411033.git.wqu@suse.com>
 <65fed3703d077362b9a7b3ec393452c40b6895db.1685411033.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65fed3703d077362b9a7b3ec393452c40b6895db.1685411033.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 30, 2023 at 09:45:28AM +0800, Qu Wenruo wrote:
> In function end_bio_extent_readpage() we call
> endio_readpage_release_extent() to unlock the extent io tree.
> 
> However we pass PageUptodate(page) as @uptodate parameter for it, while
> for previous end_page_read() call, we use a dedicated @uptodate local
> variable.
> 
> This is not a big deal, as even for subpage cases, either the bio only
> covers part of the page, then the @uptodate is always false, and the
> subpage ranges can still be merged.
> 
> But for the sake of consistency, always use @uptodate variable when
> possible.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
