Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A6E150292
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 09:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbgBCI3p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 03:29:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgBCI3o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 03:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UzHY2//8nge+6AVz84GBD+Hiv1MkHhsGePN/RRAL/cs=; b=R5Uub/j2Jo28TKhRreGG9CUlb
        L4WkOC7oIXbvx8zk1UOuQf7fLPmBgfXC/qq3bYoGjjZdWMuAWNbxKnOMPGohuXnLdEczq0aLhSKLX
        EvjwaCM91D24YH0KJyR9qrfYZ0vIcGRVi8fQegDE0zy2p9UGPX0FNuhV+t8jBZhPjBWvYKS1fptB4
        BBcTHVkMBOSQZEajpYRQOGYGiFF+j3WedTdsCrKTdtfdogVif4+m84FGw9jQ1DBxubexp1IFDF0/E
        fTF37QXlaWCbgMQLk+RG0WZA+rqzIRpMGDHt4GVqAo9Y0Ik4XHkaoBcZT7+2ZAHV+QL+liHBTVMxZ
        VETRHgVeA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyX6x-00078v-2d; Mon, 03 Feb 2020 08:29:39 +0000
Date:   Mon, 3 Feb 2020 00:29:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200203082939.GA25604@infradead.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz>
 <20200130133921.GA21841@infradead.org>
 <20200130161606.GV3929@twin.jikos.cz>
 <SN4PR0401MB3598374A2D00E21C275E5ED59B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598374A2D00E21C275E5ED59B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 31, 2020 at 01:43:19PM +0000, Johannes Thumshirn wrote:
> 
> I have a local version now, where btrfs_read_dev_one_super() uses 
> read_cache_page_gfp() and btrfs_scratch_superblocks() uses 
> write_one_page() offloading all the I/O to the pagecache. So far this 
> works as expected.
> 
> Now when I started converting write_dev_supers() and friends I wasn't 
> sure if I can/should mix up read_cache_page_gfp() and submit_bio_wait(). 
> I could also convert it to write_one_page() but this way we would loose 
> integrity checking for the super block.
> 
> Any advice?

You can mix it, although it needs some big fat comments explaining what
is going on there to the reader.
