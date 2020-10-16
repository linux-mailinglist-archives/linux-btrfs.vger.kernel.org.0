Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579FA29001F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 10:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404142AbgJPIqU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 04:46:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394772AbgJPIqP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 04:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D47D3ADE0;
        Fri, 16 Oct 2020 08:46:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 916201E133E; Fri, 16 Oct 2020 10:46:13 +0200 (CEST)
Date:   Fri, 16 Oct 2020 10:46:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, fdmanana@kernel.org,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test the correctness of several cases of
 RWF_NOWAIT writes
Message-ID: <20201016084613.GJ7037@quack2.suse.cz>
References: <aa8318c5beb380a9e99142d1b5e776b739d04bdb.1602774113.git.fdmanana@suse.com>
 <20201015161355.GI7037@quack2.suse.cz>
 <20201016055757.GA7322@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016055757.GA7322@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri 16-10-20 16:57:57, Dave Chinner wrote:
> On Thu, Oct 15, 2020 at 06:13:56PM +0200, Jan Kara wrote:
> > On Thu 15-10-20 16:36:38, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > > 
> > > Verify some attempts to write into a file using RWF_NOWAIT:
> > > 
> > > 1) Writing into a fallocated extent that starts at eof should work;
> > 
> > Why? We need to update i_size which requires transaction start and e.g.
> > ext4 does not support that in non-blocking mode...
> 
> Right, different filesystems behave differently given similar
> pre-conditions. That's not a bug, that's exactly how RWF_NOWAIT is
> expected to be implemented by each filesystem....
> 
> > > 2) Writing into a hole should fail;
> > > 3) Writing into a range that is partially allocated should fail.
> 
> Same for these - these are situations where a -specific filesystem
> implementation- might block, not a situation where the RWF_NOWAIT
> API specification says that IO submission "should fail" and hence
> return EAGAIN.
> 
> > > This is motivated by several bugs that btrfs and ext4 had and were fixed
> > > by the following kernel commits:
> > > 
> > >   4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
> > >   260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> > >   0b3171b6d195 ("ext4: do not block RWF_NOWAIT dio write on unallocated space")
> > > 
> > > At the moment, on a 5.9-rc6 kernel at least, ext4 is failing for case 1),
> > > but when I found and fixed case 1) in btrfs, around kernel 5.7, it was not
> > > failing on ext4, so some regression happened in the meanwhile. For xfs and
> > > btrfs on a 5.9 kernel, all the three cases pass.
> 
> Sure, until we propagate IOMAP_NOWAIT far enough into the allocation
> code that allocation will either succeed without blocking or fail
> without changing anything.  At which point, the filesystem behaviour
> is absolutely correct according to the RWF_NOWAIT specification, but
> the test is most definitely wrong.
> 
> IOWs, I think any test that says "RWF_NOWAIT IO in a <specific
> situation> must do <specific thing>" is incorrect. RWF_NOWAIT simply
> does not not define behaviour like this, and different filesystems
> will do different things given the same file layouts...

I agree with this. That being said it would be still worthwhile to have
some tests verifying RWF_NOWAIT behavior is sane - that we don't block with
RWF_NOWAIT (this is a requirement), and that what used to work with
RWF_NOWAIT didn't unexpectedly regress (this is more a sanity check)... I'm
not sure how to test that in an automated way through.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
