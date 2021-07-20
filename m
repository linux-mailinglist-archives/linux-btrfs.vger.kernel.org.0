Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB63CFE86
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 18:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhGTPS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 11:18:58 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40766 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242291AbhGTPAc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 11:00:32 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9BC97AF2B4C; Tue, 20 Jul 2021 11:41:07 -0400 (EDT)
Date:   Tue, 20 Jul 2021 11:41:07 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
Message-ID: <20210720154107.GC10170@hungrycats.org>
References: <20210628101637.349718-1-wqu@suse.com>
 <20210720040542.GB10170@hungrycats.org>
 <306e11d5-60c7-3a30-fd9c-deaddc4eb21d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <306e11d5-60c7-3a30-fd9c-deaddc4eb21d@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 20, 2021 at 12:33:47PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/7/20 下午12:05, Zygo Blaxell wrote:
> > On Mon, Jun 28, 2021 at 06:16:34PM +0800, Qu Wenruo wrote:
> > > Since we're busting ghost subvolumes, the branch is now called
> > > ghost_busters:
> > > https://github.com/adam900710/linux/tree/ghost_busters
> > > 
> > > The first two patches are just cleanup found during the development.
> > > 
> > > The first is a missing check for subvolid range, the missing check
> > > itself won't cause any harm, just returning -ENOENT from dentry lookup,
> > > other than the expected -EINVAL.
> > > 
> > > The 2nd is a super old dead comment from the early age of btrfs.
> > > 
> > > The final patch is the real work to allow patched "btrfs subvolume delete -i"
> > > to delete ghost subvolume.
> > > Tested with the image dump of previous submitted btrfs-progs patchset.
> > > 
> > > Qu Wenruo (3):
> > >    btrfs: return -EINVAL if some user wants to remove uuid/data_reloc
> > >      tree
> > >    btrfs: remove dead comment on btrfs_add_dead_root()
> > >    btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
> > 
> > I hit this bug on several machines while they were running 5.11.  The
> > ghost subvols seem to occur naturally--I didn't change my usual workloads
> > to get them, they just showed up in fairly normal snapshot rotation.
> 
> And there is no powerloss involved?

There could be.  The test VMs have frequent simulated powerloss events
because we're testing for regressions in post-powerloss behavior (I
guess this is one?).  It also affected laptops that probably did have
a forced shutdown or two (WiFi and Bluetooth are huge crash generators
on new hardware).

Nothing running 5.11 on stable power seems to have been affected so far.

> Then it's a much serious problem than I thought.
> 
> Thanks,
> Qu
> > 
> > They don't seem to occur on 5.10 (up to .46) or on 5.12 and later, but
> > once they are created, they don't go away without using this patch to
> > remove them.

It's odd that it doesn't seem to happen on kernels other than 5.11.
That would suggest it was broken in 5.11-rc and fixed in 5.12, which
might be a useful range to search for regressions and accidental fixes.

In any case, if a user has been running 5.11, they're going to have
ghost subvols lying around on their filesystem, so we might as well get
ready to deal with them in the kernel and tools.

> > This patch does get rid of the ghost subvols after the fact, quite nicely.
> > 
> > Some users on IRC have hit the same problem.  One was running Debian's
> > backported 5.10, which doesn't fit the pattern of kernel versions I've
> > observed, but maybe Debian backported something?
> > 
> > >   fs/btrfs/ioctl.c       | 81 +++++++++++++++++++++++++++++++++++++++++-
> > >   fs/btrfs/transaction.c |  7 ++--
> > >   2 files changed, 84 insertions(+), 4 deletions(-)
> > > 
> > > --
> > > 2.32.0
> > > 
> > 
