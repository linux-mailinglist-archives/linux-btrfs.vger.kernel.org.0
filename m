Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F1846E688
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 11:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbhLIK2s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 05:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLIK2q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 05:28:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB7C061746
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 02:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03EAFB81FA7
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 10:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464F4C004DD;
        Thu,  9 Dec 2021 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639045510;
        bh=NScd/y+c6upGU5N+FGfpVvYxP4rePuLVFFUntuXW4kQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MrkH0FRkVMhZYeqLTO6DocHlsTvFF5i0Q6l32IoUmwTEkR8HzgVBODSpzcm28zNfv
         sGlD/msEJ3lZKvihpvgapPUKWQ9f3qDOrEtrGE++fem0gZB4AfitPqkIlVJvWOCbUM
         RfIMMfVpSc8elpRqex1hmsblqBIbW/ov0lOH2tMmNgLmdxVogS10nJHCpoFgFU9zk0
         GnwoRlHgcEXT7m0lB1L7Yub5nEVWaUhQAcTejRIraghuTkR7Ij1DuR8PT+Qm6HaBFQ
         wPQnibpugd7wOJrsY8iD71WgpIGeGKFCXkJc7/0LKDUd2QOtxo22cfKdN/CPTh7TXo
         JXg4FNgMFpL9w==
Date:   Thu, 9 Dec 2021 10:25:08 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
Message-ID: <YbHZhGGpBvqoqfiT@debian9.Home>
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
 <20211207145329.GW28560@twin.jikos.cz>
 <20211207154048.GX28560@twin.jikos.cz>
 <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
 <20211208140411.GK28560@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208140411.GK28560@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 03:04:11PM +0100, David Sterba wrote:
> On Tue, Dec 07, 2021 at 03:53:22PM +0000, Filipe Manana wrote:
> > > > I'm doing some tests, in a VM on a dedicated HDD.
> > >
> > > There's some measurable difference:
> > >
> > > With readahead:
> > >
> > > Duration:         0:00:20
> > > Total to scrub:   7.02GiB
> > > Rate:             236.92MiB/s
> > >
> > > Duration:         0:00:48
> > > Total to scrub:   12.02GiB
> > > Rate:             198.02MiB/s
> > >
> > > Without readahead:
> > >
> > > Duration:         0:00:22
> > > Total to scrub:   7.02GiB
> > > Rate:             215.10MiB/s
> > >
> > > Duration:         0:00:50
> > > Total to scrub:   12.02GiB
> > > Rate:             190.66MiB/s
> > >
> > > The setup is: data/single, metadata/dup, no-holes, free-space-tree,
> > > there are 8 backing devices but all reside on one HDD.
> > >
> > > Data generated by fio like
> > >
> > > fio --rw=randrw --randrepeat=1 --size=3000m \
> > >          --bsrange=512b-64k --bs_unaligned \
> > >          --ioengine=libaio --fsync=1024 \
> > >          --name=job0 --name=job1 \
> > >
> > > and scrub starts right away this. VM has 4G or memory and 4 CPUs.
> > 
> > How about using bare metal? And was it a debug kernel, or a default
> > kernel config from a distro?
> 
> It was the debug config I use for normal testing, I'll try to redo it on
> another physical box.
> 
> > Those details often make all the difference (either for the best or
> > for the worse).
> > 
> > I'm curious to see as well the results when:
> > 
> > 1) The reada.c code is changed to work with commit roots;
> > 
> > 2) The standard btree readahead (struct btrfs_path::reada) is used
> > instead of the reada.c code.
> > 
> > >
> > > The difference is 2 seconds, roughly 4% but the sample is not large
> > > enough to be conclusive.
> > 
> > A bit too small.
> 
> What's worse, I did a few more rounds and the results were too unstable,
> from 44 seconds to 25 seconds (all on the removed readahead branch), but
> the machine was not quiescent.

I get such huge variations too when using a debug kernel and virtualized
disks for any tests, even for single threaded tests.

That's why I use a default, non-debug, kernel config from a popular distro
and without any virtualization (or at least have qemu use a raw device, not
a file backed disk on top of another filesystem) when measuring performance.

