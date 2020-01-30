Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D414DE41
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 16:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgA3P4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 10:56:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgA3P4U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 10:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2ve9RFjV1zEjq3HlDmXvOzf7B800nayYPRGd6wc2S5k=; b=RhspnQoYwFA8buRZcvkB+xu0k
        5RCKlHwdDtfLdiz+Q2Iwwtc/HtCFYHqAOzENKb6zBAUegy1nIqd11CDZzGLym0lno66dzxLmbvoxE
        qHIeYZdGOEycgJX+XPYbNhDefr+wroMUReEgsYyvpZPqZxDj/Ph8LzLhyLZa1Ly9XFFVWQWbafYV1
        nGhlDdlEXA7Ncx9NSaQ/ECOZ5awhqoaYn2FZ7J99wMzpUUAQX2bUIrBJK09pwZMcHLXTcB2WOhUnC
        Ua4hvgTx/u2urf0BC+41l+2FLMARjrGPOWxZfMKYmW2AiJTU56Y5zh/F7knks8YcnlI8YqfaDK+Iw
        HCtfSFCDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixCAy-0005Re-LN; Thu, 30 Jan 2020 15:56:16 +0000
Date:   Thu, 30 Jan 2020 07:56:16 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200130155616.GA14682@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz>
 <20200130133921.GA21841@infradead.org>
 <DM5PR0401MB35915F7AE2B1A679213ED4AD9B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0401MB35915F7AE2B1A679213ED4AD9B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 03:53:37PM +0000, Johannes Thumshirn wrote:
> On 30/01/2020 14:39, Christoph Hellwig wrote:
> > On Thu, Jan 30, 2020 at 01:15:30PM +0100, David Sterba wrote:
> >>> Sure but with hch's proposed change to using read_cache_page_gfp() this
> >>> doesn't make too much sense anymore at least for the read path.
> >>>
> >>> Maybe "use page cache for superblock reading"?
> >>
> >> That works too. We might need a new iteration that summarizes up all the
> >> feedback so far, so we have same code to refer to.
> > 
> > Per my question on the second patch:  why even use the page cache at
> > all.  btrfs already caches the value outside the pagecache, so why
> > even bother with the page cache overhead?
> > 
> This is what my first version did, alloc_page() and submit_bio() 
> directly [1]. But reviewers told me to go the route via page cache.

I only see your patch at the url, not any reply.  What is the issue
of not using the page cache?  Also you really shoudn't need a separate
alloc_page - you should be able to use the already cached superblock
as the destination and source of I/O, assuming they are properly aligned
(and if not that could be fixed easily).
