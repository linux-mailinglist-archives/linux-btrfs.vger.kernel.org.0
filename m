Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0B14DEC2
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 17:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA3QQb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 11:16:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:58124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgA3QQa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 11:16:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA4C3ACD6;
        Thu, 30 Jan 2020 16:16:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 883E2DA84C; Thu, 30 Jan 2020 17:16:08 +0100 (CET)
Date:   Thu, 30 Jan 2020 17:16:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] btrfs: remove buffer heads form superblock
 handling
Message-ID: <20200130161606.GV3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200129142526.GE3929@twin.jikos.cz>
 <SN4PR0401MB359858CB7DFD0082B44D57379B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200130121530.GO3929@twin.jikos.cz>
 <20200130133921.GA21841@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130133921.GA21841@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 30, 2020 at 05:39:21AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 30, 2020 at 01:15:30PM +0100, David Sterba wrote:
> > > Sure but with hch's proposed change to using read_cache_page_gfp() this 
> > > doesn't make too much sense anymore at least for the read path.
> > > 
> > > Maybe "use page cache for superblock reading"?
> > 
> > That works too. We might need a new iteration that summarizes up all the
> > feedback so far, so we have same code to refer to.
> 
> Per my question on the second patch:  why even use the page cache at
> all.  btrfs already caches the value outside the pagecache, so why
> even bother with the page cache overhead?

I'd like to remove the buffer_head interface in two steps. First remove
the wrappers and open code the calls, so the functionality is unchanged.
Then have another look if we can optimize that further, eg. removing the
page cache.

We've had subtle bugs when mount/scanning ioctl/mkfs interacted and did
not see a consistent state. See 6f60cbd3ae442cb35861bb522f388db123d42ec1
("btrfs: access superblock via pagecache in scan_one_device"). It's been
a few years so I don't recall all details, but it was quite hard to
catch. Mkfs followed by mount sometimes did not work.

So page cache is the common access point for all the parts and for now
we rely on that. If removing is possible, I'd like to see a good
explanation why and not such change lost in a well meant cleanup.
