Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6849528FDDD
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Oct 2020 07:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390599AbgJPF6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Oct 2020 01:58:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36921 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390173AbgJPF6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Oct 2020 01:58:02 -0400
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0850C3AAF43;
        Fri, 16 Oct 2020 16:57:57 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kTIkX-0012SF-0l; Fri, 16 Oct 2020 16:57:57 +1100
Date:   Fri, 16 Oct 2020 16:57:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test the correctness of several cases of
 RWF_NOWAIT writes
Message-ID: <20201016055757.GA7322@dread.disaster.area>
References: <aa8318c5beb380a9e99142d1b5e776b739d04bdb.1602774113.git.fdmanana@suse.com>
 <20201015161355.GI7037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015161355.GI7037@quack2.suse.cz>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Ubgvt5aN c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=afefHYAZSVUA:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
        a=7-415B0cAAAA:8 a=OwwBgDynDYpeuBj-idcA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 15, 2020 at 06:13:56PM +0200, Jan Kara wrote:
> On Thu 15-10-20 16:36:38, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Verify some attempts to write into a file using RWF_NOWAIT:
> > 
> > 1) Writing into a fallocated extent that starts at eof should work;
> 
> Why? We need to update i_size which requires transaction start and e.g.
> ext4 does not support that in non-blocking mode...

Right, different filesystems behave differently given similar
pre-conditions. That's not a bug, that's exactly how RWF_NOWAIT is
expected to be implemented by each filesystem....

> > 2) Writing into a hole should fail;
> > 3) Writing into a range that is partially allocated should fail.

Same for these - these are situations where a -specific filesystem
implementation- might block, not a situation where the RWF_NOWAIT
API specification says that IO submission "should fail" and hence
return EAGAIN.

> > This is motivated by several bugs that btrfs and ext4 had and were fixed
> > by the following kernel commits:
> > 
> >   4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
> >   260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")
> >   0b3171b6d195 ("ext4: do not block RWF_NOWAIT dio write on unallocated space")
> > 
> > At the moment, on a 5.9-rc6 kernel at least, ext4 is failing for case 1),
> > but when I found and fixed case 1) in btrfs, around kernel 5.7, it was not
> > failing on ext4, so some regression happened in the meanwhile. For xfs and
> > btrfs on a 5.9 kernel, all the three cases pass.

Sure, until we propagate IOMAP_NOWAIT far enough into the allocation
code that allocation will either succeed without blocking or fail
without changing anything.  At which point, the filesystem behaviour
is absolutely correct according to the RWF_NOWAIT specification, but
the test is most definitely wrong.

IOWs, I think any test that says "RWF_NOWAIT IO in a <specific
situation> must do <specific thing>" is incorrect. RWF_NOWAIT simply
does not not define behaviour like this, and different filesystems
will do different things given the same file layouts...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
