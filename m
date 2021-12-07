Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244B046BA7E
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhLGL7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 06:59:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58394 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhLGL7p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 06:59:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37610B81754
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 11:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B79AC341C3;
        Tue,  7 Dec 2021 11:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638878173;
        bh=x7TokKRtFEtSUh4d/iexvijhD8JoHr5NDVDNVWsmOQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSFJDUFsJc/OnNV2YlwOsbUll0NVsblSzlBbod/kUwzjdcmQbxqbYZCcmjuING365
         fX7zgizIhpyIHZhc3B1Ng3h7iOw50WQ4HvK0m2xU0qLLoo5JtXnYD9VVrUHE/9cp+r
         cv+J+viBpod5iddmEtwq1QAphWh479jnWnQ9t2i4jMMmOcydkJLAXy18vSVnuFJ5/T
         mxlNS5nKrFglaKDBs8Qe0K0pPfkcjrdHi1dH5DFQfO95OoM3OmUb2vYp1ybJWgazT4
         tvCe5OU78CmdMNCW6pQ31y67882jBHBLxXK76jLwTOf0VtM6BfmkgZoBoyfNXZ2qYl
         7gMv3nIU5Vjxw==
Date:   Tue, 7 Dec 2021 11:56:10 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <Ya9L2qSe+XKgtesq@debian9.Home>
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/12/7 19:02, Filipe Manana wrote:
> > On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
> > > This is originally just my preparation for scrub refactors, but when the
> > > readahead is involved, it won't just be a small cleanup.
> > > 
> > > The metadata readahead code is introduced in 2011 (surprisingly, the
> > > commit message even contains changelog), but now only one user for it,
> > > and even for the only one user, the readahead mechanism can't provide
> > > much help in fact.
> > > 
> > > Scrub needs readahead for commit root, but the existing one can only do
> > > current root readahead.
> > 
> > If support for the commit root is added, is there a noticeable speedup?
> > Have you tested that?
> > 
> 
> Will craft a benchmark for that.
> 
> Although I don't have any HDD available for benchmark, thus would only
> have result from SATA SSD.
> 
> > > 
> > > And the code is at a very bad layer inside btrfs, all metadata are at
> > > btrfs logical address space, but the readahead is kinda working at
> > > device layer (to manage the in-flight readahead).
> > > 
> > > Personally speaking, I don't think such "optimization" is really even
> > > needed, since we have better way like setting IO priority.
> > 
> > Have you done any benchmarks?
> > How? On physical machines or VMs?
> > 
> > Please include such details in the changelogs.
> > 
> > > 
> > > I really prefer to let the professional block layer guys do whatever
> > > they are good at (and in fact, those block layer guys rock!).
> > > Immature optimization is the cause of bugs, and it has already caused
> > > several bugs recently.
> > > 
> > > Nowadays we have btrfs_path::reada to do the readahead, I doubt if we
> > > really need such facility.
> > 
> > btrfs_path:reada is important and it makes a difference.
> > I recently changed send to use it, and benchmarks can be found in the
> > changelogs.
> 
> For the "such facility" I mean the btrfs_reada_add() facility, not the
> btrfs_path::reada one.
> 
> > 
> > There are also other places where it makes a difference, such as when
> > reading a large chunk tree during mount or when reading a large directory.
> > 
> > It's all about reading other leaves/nodes in the background that will be
> > needed in the near future while the task is doing something else. Even if
> > the nodes/leaves are not physically contiguous on disk (that's the main
> > reason why the mechanism exists).
> 
> Unfortunately, not really in the background.
> 
> For scrub usage, it kicks readahead and wait for it, not really doing it
> in the background.
> 
> (Nor btrfs_path::reada either though, btrfs_path reada also happens at
> tree search time, and it's synchronous).

No, the btrfs_path::reada mechanism is not synchronous - it does not wait
for the reads (IO) to complete.

btrfs_readahead_node_child() triggers a read for the extent buffer's
pages but does not wait for the reads to complete. I.e. we end up calling:

    read_extent_buffer_pages(eb, WAIT_NONE, 0);

So it does not wait on the read bios to complete.
Otherwise that would be pointless.

> 
> Another reason why the existing btrfs_reada_add() facility is not
> suitable for scrub is, our default tree block size is way larger than
> the scrub data length.
> 
> The current data length is 16 pages (64K), while even one 16K leaf can
> contain at least csum for 8M (CRC32) or 1M (SHA256).
> This means for most readahead, it doesn't make much sense as it won't
> cross leaf boundaries that frequently.
> 
> (BTW, in this particular case, btrfs_path::reada may perform better than
> the start/end based reada, as that would really do some readahead)
> 
> Anyway, only benchmark can prove whether I'm correct or wrong.

Yep, and preferably on a spinning disk and bare metal (no VM).

Thanks.

> 
> Thanks,
> Qu
> > 
> > > 
> > > So here I purpose to completely remove the old and under utilized
> > > metadata readahead system.
> > > 
> > > Qu Wenruo (2):
> > >    btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
> > >    btrfs: remove reada mechanism
> > > 
> > >   fs/btrfs/Makefile      |    2 +-
> > >   fs/btrfs/ctree.h       |   25 -
> > >   fs/btrfs/dev-replace.c |    5 -
> > >   fs/btrfs/disk-io.c     |   20 +-
> > >   fs/btrfs/extent_io.c   |    3 -
> > >   fs/btrfs/reada.c       | 1086 ----------------------------------------
> > >   fs/btrfs/scrub.c       |   64 +--
> > >   fs/btrfs/super.c       |    1 -
> > >   fs/btrfs/volumes.c     |    7 -
> > >   fs/btrfs/volumes.h     |    7 -
> > >   10 files changed, 17 insertions(+), 1203 deletions(-)
> > >   delete mode 100644 fs/btrfs/reada.c
> > > 
> > > --
> > > 2.34.1
> > > 
