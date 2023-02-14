Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706C66958B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 06:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBNFxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 00:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBNFw7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 00:52:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B41B55B9
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 21:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EG5WuNaIYmQ3BsGo88oykDHj/TOdmwnsiUsqMC28A4Q=; b=wAS9xD7t18pGYM5Qt5rMf6qlzm
        vzaMMrqw+39QWzxYdM63ORholUqq7k8V7fLTdXyXSqIGX3UOoeLAoL0rjC1GE8FdfLT6bhaY4UkeM
        3FVmitLlzn+RyDfVxvFEbN0SxqH16V5VlqMqmRf9RzG5q2IEPxNnqxY9FH3l2g+GDHyujfEr5XEWw
        D0CEAHIaIHcjgIUFYZe48OZuI0NTrYbVBgVj52pzN+5uC/1eIopLy+N2UmtLxQHGvregS9f/9v9yl
        Yh5UM3K++FFf0JdiqOMJIhi3+5Qx+m+SrOiqwdD6PYM12wDdTq382GUzQ6bxJoMLdhULfm9IXes/q
        L2riSzlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRoFM-00HaKp-35; Tue, 14 Feb 2023 05:52:56 +0000
Date:   Mon, 13 Feb 2023 21:52:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Message-ID: <Y+shuDJBzsZYZwFs@infradead.org>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
 <873579y0kr.fsf@vps.thesusis.net>
 <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
 <87y1p1wigj.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1p1wigj.fsf@vps.thesusis.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 12:56:09PM -0500, Phillip Susi wrote:
> 
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:
> 
> > There is no guarantee for that, no. The block layer can theoretically
> > re-order all WRITEs. This is why btrfs also needs the mq-deadline IO
> 
> Unless you submit barriers to prevent that right?  Why not do that?

There is no such thing as a "barrier" since 2.6.10 or so.  And that's
a good thing as they are extremely costly.

> I would think that to prevent fragmentation, you would want to try to
> flush a large portion of data from a particular file in order then move
> to another file.  If you have large streaming writes to two files at the
> same time and the allocator decides to put them in the same zone, and
> they are just submitted to the stack to do in any order, isn't this
> likely to lead to a lot of fragmentation?

If you submit small chunks of different files to the same block group
you're always going to get fragmentation, zones or not.  Zones will
make it even worse due to the lack of preallocations or sparse use
of the block groups, though.
