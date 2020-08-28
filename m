Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E11825530D
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Aug 2020 04:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgH1CeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 22:34:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46506 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgH1CeM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 22:34:12 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 46B9A1F66E;
        Fri, 28 Aug 2020 02:34:12 +0000 (UTC)
Date:   Fri, 28 Aug 2020 02:34:12 +0000
From:   Eric Wong <e@80x24.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, linux-btrfs@vger.kernel.org
Subject: Re: adding new devices to degraded raid1
Message-ID: <20200828023412.GA308@dcvr>
References: <20200827124147.GA16923@dcvr>
 <862ab235-298a-12eb-647b-04ec01d95293@libero.it>
 <20200828003037.GU5890@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828003037.GU5890@hungrycats.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Zygo Blaxell <ce3g8jdj@umail.furryterror.org> wrote:
> Note that add/remove is orders of magnitude slower than replace.
> Replace might take hours or even a day or two on a huge spinning drive.
> Add/remove might take _months_, though if you have 8-year-old disks
> then it's probably a few days, weeks at most.

Btw, any explanation or profiling done on why remove is so much
slower than replace?  Especially since btrfs raid1 ought to be
fairly mature at this point (and I run recent stable kernels).

Converting a single drive to raid1 was not slow at all, either.
RAID 1 ought to be straightforward if there's plenty of free
space, one would think...

> Add/remove does work for raid1* (i.e. raid1, raid10, raid1c3, raid1c4).
> At the moment only 'replace' works reliably for raid5/raid6.

Noted, I'm staying far, far away from raid5/6 :)  Thanks for
your posts on that topic, by the way.

> On Thu, Aug 27, 2020 at 07:14:18PM +0200, Goffredo Baroncelli wrote:
> > Instead of
> > 
> >  	btrfs device remove broken /mnt/foo
> > 
> > You should do
> > 
> > 	btrfs device remove missing /mnt/foo
> > 
> > ("missing" has to be write as is, it is a special term, see man page)

Thanks Goffredo, noted.

> > and
> > 
> > 	btrfs balance start /mnt/foo
> 
> If the replacement disks are larger than half the size of the failed disk
> then device remove may do sufficient data relocation and you won't need
> balance.  Once all the disks have equal amounts of unallocated space in
> 'btrfs fi usage' you can cancel any balances that are running.
> 
> On the other hand, if the replacement disks are close to half the size
> of the failed disk, then some careful balance filtering is required in
> order to utilize all the available space.  This filtering is more than
> what the stock tool offers.  You have to make sure that there are no block
> groups with a mirror copy on both of the small disks, as any such block
> group removes 1GB of available mirror space for data on the largest disk.

Yikes, that balancing sounds like a pain.  I'm not super-limited
on space, and a fair bit gets overwritten or replaced as time
goes on, anyways.

I wonder how far I could get with some lossless rewrites which
might make sense, anyways.

1) full "git gc" (I have a fair amount of git repos)
   Maybe setting pack.compression=0 will even help dedupe
   similar repos (but they'll be no fun to serve over network)

2) replacing some manually-compressed files with uncompressed
   versions (let btrfs compression handle it).  I expect that'll
   let dedupe work better, too.

   I have a lot of FLAC that could live as uncompressed .sox
   files.  I expect FLAC to be more efficient on single files,
   but dedupe could save on cuts that are/were used for editing.
   I won't miss FLAC MD5 checksums when btrfs has checksums, either.

3) is this also something defrag can help with?

Thanks again.
