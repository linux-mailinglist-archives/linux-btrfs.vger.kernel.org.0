Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9B5A14DC1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgA3NjZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 08:39:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3NjZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 08:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BaJshAr22CaKcM0UOV3hgnNZiVpLcu9aI8ljbX4iyc0=; b=Tnfgt7+8wRJD1nPf4+Qufbalw
        vO6IglycUd42qnKx/KgYZsqHyEtqiUucJjuyWdEyPjX92X6rNEBMfZ0ePAHxE3ABvq6BXyGrW5tgL
        WCmtgD2UenO2yEGydau2oueOtTz0i+GTVBBERMv0AZ0d6PKSMboVWQyv/CNE7ufD9l3wwhNcAgG+Y
        +QueUrWMkCGySJnLW3qo3XQjh+ibYHYpudUwhGZudy3oU9lfPzI+Nyzv5AX8VAqDqVpi2xcrpYjJV
        We/IH0G/SRRpuQKbtMc8Wbl6TTn1mr1iVyzqkovfrEE1cKAjkTxjIo+TXflVbr6CYvdCs4J4dSCQb
        FIL5Hn3QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixA2T-0006Kh-Gt; Thu, 30 Jan 2020 13:39:21 +0000
Date:   Thu, 30 Jan 2020 05:39:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200130133921.GA21841@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130121530.GO3929@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 01:15:30PM +0100, David Sterba wrote:
> > Sure but with hch's proposed change to using read_cache_page_gfp() this 
> > doesn't make too much sense anymore at least for the read path.
> > 
> > Maybe "use page cache for superblock reading"?
> 
> That works too. We might need a new iteration that summarizes up all the
> feedback so far, so we have same code to refer to.

Per my question on the second patch:  why even use the page cache at
all.  btrfs already caches the value outside the pagecache, so why
even bother with the page cache overhead?
