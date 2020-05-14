Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27F31D3891
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENRoL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 14 May 2020 13:44:11 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37960 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENRoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 13:44:10 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 989BF6C35E2; Thu, 14 May 2020 13:44:09 -0400 (EDT)
Date:   Thu, 14 May 2020 13:44:09 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Balance loops: what we know so far
Message-ID: <20200514174409.GC10769@hungrycats.org>
References: <20200428045500.GA10769@hungrycats.org>
 <4bebdd24-ccaa-1128-7870-b59b08086d83@gmx.com>
 <20200512134306.GV10769@hungrycats.org>
 <20200512141108.GW10769@hungrycats.org>
 <b7b8bbf8-119b-02ea-5fad-0f7c3abab07d@gmx.com>
 <20200513052452.GY10769@hungrycats.org>
 <6fcccf0b-108d-75d2-ad53-3f7837478319@gmx.com>
 <20200513122140.GA10769@hungrycats.org>
 <3b3c805d-7c75-5fe7-1ed8-4a7841b16647@gmx.com>
 <70689a06-dc5f-5102-c0bb-23eadad88383@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <70689a06-dc5f-5102-c0bb-23eadad88383@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 14, 2020 at 04:55:18PM +0800, Qu Wenruo wrote:
> 
> 
> On 2020/5/14 下午4:08, Qu Wenruo wrote:
> > 
> > 
> > On 2020/5/13 下午8:21, Zygo Blaxell wrote:
> >> On Wed, May 13, 2020 at 07:23:40PM +0800, Qu Wenruo wrote:
> >>>
> >>>
> > [...]
> >>
> >> Kernel log:
> >>
> >> 	[96199.614869][ T9676] BTRFS info (device dm-0): balance: start -d
> >> 	[96199.616086][ T9676] BTRFS info (device dm-0): relocating block group 4396679168000 flags data
> >> 	[96199.782217][ T9676] BTRFS info (device dm-0): relocating block group 4395605426176 flags data
> >> 	[96199.971118][ T9676] BTRFS info (device dm-0): relocating block group 4394531684352 flags data
> >> 	[96220.858317][ T9676] BTRFS info (device dm-0): found 13 extents, loops 1, stage: move data extents
> >> 	[...]
> >> 	[121403.509718][ T9676] BTRFS info (device dm-0): found 13 extents, loops 131823, stage: update data pointers
> >> 	(qemu) stop
> >>
> >> btrfs-image URL:
> >>
> >> 	http://www.furryterror.org/~zblaxell/tmp/.fsinqz/image.bin
> >>
> > The image shows several very strange result.
> > 
> > For one, although we're relocating block group 4394531684352, the
> > previous two block groups doesn't really get relocated.
> > 
> > There are still extents there, all belongs to data reloc tree.
> > 
> > Furthermore, the data reloc tree inode 620 should be evicted when
> > previous block group relocation finishes.
> > 
> > So I'm considering something went wrong in data reloc tree, would you
> > please try the following diff?
> > (Either on vanilla kernel or with my previous useless patch)
> 
> Oh, my previous testing patch is doing wrong inode put for data reloc
> tree, thus it's possible to lead to such situation.
> 
> Thankfully the v2 for upstream gets the problem fixed.
> 
> Thus it goes back to the original stage, still no faster way to
> reproduce the problem...

Can we attack the problem by logging kernel activity?  Like can we
log whenever we add or remove items from the data reloc tree, or
why we don't?

I can get a filesystem with a single data block group and a single
(visible) extent that loops, and somehow it's so easy to do that that I'm
having problems making filesystems _not_ do it.  What can we do with that?

What am I (and everyone else with this problem) doing that you are not?
Usually that difference is "I'm running bees" but we're running out of
bugs related to LOGICAL_INO and the dedupe ioctl, and I think other people
are reporting the problem without running bees.  I'm also running balance
cancels, which seem to increase the repro rate (though they might just
be increasing the number of balances tested per day, and there could be
just a fixed percentage of balances that loop).

I will see if I can build a standalone kvm image that generates balance
loops on blank disks.  If I'm successful, you can download it and then
run all the experiments you want.

I also want to see if reverting the extended reloc tree lifespan patch
(d2311e698578 "btrfs: relocation: Delay reloc tree deletion after
merge_reloc_roots") stops the looping on misc-next.  I found that
reverting that patch stops the balance looping on 5.1.21 in an earlier
experiment.  Maybe there are two bugs here, and we've already fixed one,
but the symptom won't go away because some second bug has appeared.


> Thanks,
> Qu
> > 
> > Thanks,
> > Qu
> > 
> > diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> > index 9afc1a6928cf..ef9e18bab6f6 100644
> > --- a/fs/btrfs/relocation.c
> > +++ b/fs/btrfs/relocation.c
> > @@ -3498,6 +3498,7 @@ struct inode *create_reloc_inode(struct
> > btrfs_fs_info *fs_info,
> >         BTRFS_I(inode)->index_cnt = group->start;
> > 
> >         err = btrfs_orphan_add(trans, BTRFS_I(inode));
> > +       WARN_ON(atomic_read(inode->i_count) != 1);
> >  out:
> >         btrfs_put_root(root);
> >         btrfs_end_transaction(trans);
> > @@ -3681,6 +3682,7 @@ int btrfs_relocate_block_group(struct
> > btrfs_fs_info *fs_info, u64 group_start)
> >  out:
> >         if (err && rw)
> >                 btrfs_dec_block_group_ro(rc->block_group);
> > +       WARN_ON(atomic_read(inode->i_count) != 1);
> >         iput(rc->data_inode);
> >         btrfs_put_block_group(rc->block_group);
> >         free_reloc_control(rc);
> > 
> 



