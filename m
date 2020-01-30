Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E5F14DEB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgA3QPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:15:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3QPV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6WTdxoiFNjCmTHlkvQv5iOQXy7xNNujzJuuUyLd663Q=; b=HC8+dHs1mEYu8McQ1tItaHk9U
        iUbYwwMoxj8yDkGnXM1cifvJF3Ht75EkmoJK5QDNg7IxOCNmest5ljtCjvz0CPeEWQarMo2yubNer
        2jQ6iMd6zcA9+xorElDHaqaWxe4CCcyZsgg0czV1KIh3tu9+XaMYrELOTD3LxU84lrVroOP7uNwH9
        CxIck1ZxQLHv3Kpu1akyfmJ4h68bDy5qBKHRCDuEK6iXczvz2KvgqUGMdlU0G1W0C613QrYtHKR6a
        t0QEN7qDPIFk3/2MDO9ci4b3nDytI7fg8IZrhzLlGZIJix4gUq6qn39XPRapw+ru1cg/UzZzeWawl
        G9RF/jGbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixCTP-0006to-Jf; Thu, 30 Jan 2020 16:15:19 +0000
Date:   Thu, 30 Jan 2020 08:15:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200130161519.GA15541@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz>
 <20200130133921.GA21841@infradead.org>
 <DM5PR0401MB35915F7AE2B1A679213ED4AD9B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <20200130155616.GA14682@infradead.org>
 <DM5PR0401MB3591C0E5FE103FF1142005099B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR0401MB3591C0E5FE103FF1142005099B040@DM5PR0401MB3591.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 04:09:45PM +0000, Johannes Thumshirn wrote:
> > alloc_page - you should be able to use the already cached superblock
> > as the destination and source of I/O, assuming they are properly aligned
> > (and if not that could be fixed easily).
> > 
> 
> Care to elaborate? Who would have cached the superblock, when we haven't 
> mounted the FS yet.

You use one allocation, which then gets owned by the in-memory suprblock
once probed.  No need to allocate memory again to write it out.

> 
> So here's the answer from that thread:
> 
> "IIRC we had some funny bugs when mount and device scan (udev) raced 
> just after mkfs, the page cache must be used so there's no way to read 
> stale data."
> https://lore.kernel.org/linux-btrfs/20200117151352.GK3929@twin.jikos.cz/

Well, XFS has not used the page cache for any metadata since 2011, and
we've not run into those problems.  But then again XFS doesn't use
the page cache for mkfs, does btrfs?
