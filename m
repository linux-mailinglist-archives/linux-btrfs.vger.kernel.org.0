Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470A446B9B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbhLGLFw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 06:05:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:41540 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbhLGLFw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 06:05:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CD9E2CE1A08
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 11:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705EDC341C1;
        Tue,  7 Dec 2021 11:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638874939;
        bh=pLrDdIJAdCN/zO0K12YGW3iJ/ceOzKNw4RnZrwM/II0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o39LABwsmOvnRfgiy7ReL0vhLfOV0s8YdLQhFivtrrpSlkp6klLKWQUV9JkAboKia
         aekVqn/YKWhlPE8TP56X9PV6wLjaPtczbxeuBs1havqj9vGcF9F8iq0CEuEZifuVzN
         5mYLog2ZTOxfNg6h7GJVo5ErgVeUaqQsQx3K9l3TDRS58LcjNdBETTg9trI57lXGWm
         pTytGDWa7rRGmSICjuJutE1V23GZWJqPPP37SP5fwkgk5B5/pg1PWMe2bi96S1bYGC
         vvCGS+4TyLcoJK4G1Fw5z8p+JyY32k8udbGtpy/+e2rTIF4vG5pN3S5qsK5wL2FiFk
         RygLbWF5oB0+g==
Date:   Tue, 7 Dec 2021 11:02:14 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <Ya8/NpvxmCCouKqg@debian9.Home>
References: <20211207074400.63352-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207074400.63352-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
> This is originally just my preparation for scrub refactors, but when the
> readahead is involved, it won't just be a small cleanup.
> 
> The metadata readahead code is introduced in 2011 (surprisingly, the
> commit message even contains changelog), but now only one user for it,
> and even for the only one user, the readahead mechanism can't provide
> much help in fact.
> 
> Scrub needs readahead for commit root, but the existing one can only do
> current root readahead.

If support for the commit root is added, is there a noticeable speedup?
Have you tested that?

> 
> And the code is at a very bad layer inside btrfs, all metadata are at
> btrfs logical address space, but the readahead is kinda working at
> device layer (to manage the in-flight readahead).
> 
> Personally speaking, I don't think such "optimization" is really even
> needed, since we have better way like setting IO priority.

Have you done any benchmarks?
How? On physical machines or VMs?

Please include such details in the changelogs.

> 
> I really prefer to let the professional block layer guys do whatever
> they are good at (and in fact, those block layer guys rock!).
> Immature optimization is the cause of bugs, and it has already caused
> several bugs recently.
> 
> Nowadays we have btrfs_path::reada to do the readahead, I doubt if we
> really need such facility.

btrfs_path:reada is important and it makes a difference.
I recently changed send to use it, and benchmarks can be found in the
changelogs.

There are also other places where it makes a difference, such as when
reading a large chunk tree during mount or when reading a large directory.

It's all about reading other leaves/nodes in the background that will be
needed in the near future while the task is doing something else. Even if
the nodes/leaves are not physically contiguous on disk (that's the main
reason why the mechanism exists).

> 
> So here I purpose to completely remove the old and under utilized
> metadata readahead system.
> 
> Qu Wenruo (2):
>   btrfs: remove the unnecessary path parameter for scrub_raid56_parity()
>   btrfs: remove reada mechanism
> 
>  fs/btrfs/Makefile      |    2 +-
>  fs/btrfs/ctree.h       |   25 -
>  fs/btrfs/dev-replace.c |    5 -
>  fs/btrfs/disk-io.c     |   20 +-
>  fs/btrfs/extent_io.c   |    3 -
>  fs/btrfs/reada.c       | 1086 ----------------------------------------
>  fs/btrfs/scrub.c       |   64 +--
>  fs/btrfs/super.c       |    1 -
>  fs/btrfs/volumes.c     |    7 -
>  fs/btrfs/volumes.h     |    7 -
>  10 files changed, 17 insertions(+), 1203 deletions(-)
>  delete mode 100644 fs/btrfs/reada.c
> 
> -- 
> 2.34.1
> 
