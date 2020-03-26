Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0CE219368F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 04:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZDLJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 25 Mar 2020 23:11:09 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43474 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgCZDLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 23:11:09 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 119A1633D19; Wed, 25 Mar 2020 23:10:58 -0400 (EDT)
Date:   Wed, 25 Mar 2020 23:10:58 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Goffredo Baroncelli <kreijack@inwind.it>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
Message-ID: <20200326031058.GX13306@hungrycats.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
 <8977ac3d-7af6-65a7-5515-caab07983672@inwind.it>
 <8a53cf8d-980d-8c41-e35d-c8b70db1bbdc@gmail.com>
 <3dfbf173-7ac2-887f-d3eb-ec1b6c610d01@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <3dfbf173-7ac2-887f-d3eb-ec1b6c610d01@inwind.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 25, 2020 at 06:14:05PM +0100, Goffredo Baroncelli wrote:
> On 3/25/20 5:09 AM, Andrei Borzenkov wrote:
> > 24.03.2020 20:59, Goffredo Baroncelli пишет:
> > > On 3/24/20 5:55 AM, Anand Jain wrote:
> > > > On 3/21/20 1:56 AM, Goffredo Baroncelli wrote:
> > > > > Hi all,
> > > [..]
> > > > > Looking at the code it seems to me that the logic is the following
> > > > > (from btrfs_reduce_alloc_profile())
> > > > > 
> > > > >           if (allowed & BTRFS_BLOCK_GROUP_RAID6)
> > > > >                   allowed = BTRFS_BLOCK_GROUP_RAID6;
> > > > >           else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
> > > > >                   allowed = BTRFS_BLOCK_GROUP_RAID5;
> > > > >           else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
> > > > >                   allowed = BTRFS_BLOCK_GROUP_RAID10;
> > > > >           else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
> > > > >                   allowed = BTRFS_BLOCK_GROUP_RAID1;
> > > > >           else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
> > > > >                   allowed = BTRFS_BLOCK_GROUP_RAID0;
> > > > > 
> > > > >           flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
> > > > > 
> > > > > So in the case above the profile will be RAID6. And in the general if
> > > > > a RAID6 chunk is a filesystem, it wins !
> > > > 
> > > >    That's arbitrary and doesn't make sense to me, IMO mkfs should save
> > > >    default profile in the super-block (which can be changed using ioctl)
> > > >    and kernel can create chunks based on the default profile.
> > > 
> > > I'm working on this idea (storing the target profile in super-block).
> > 
> > What about per-subvolume profile? This comes up every now and then, like
> > 
> > https://lore.kernel.org/linux-btrfs/cd82d247-5c95-18cd-a290-a911ff69613c@dirtcellar.net/
> > 
> > May be it could be subvolume property?

...or inode.

> The idea is nice. However I fear the mess that it could cause. Even now, with a
> more simpler system where there is a "per filesystem" profile, there are a lot of corner
> cases when something goes wrong (an interrupted balance, or a disk failed).

It can't be worse than qgroups.  (only half kidding)

Thinking aloud, you could even set up coarse-but-fast quotas that
way--limit the number of data block groups allocated to a subvol.
No sharing of block groups between subvols though, unless one subvol is a
snapshot of the other.  Also, limiting usage by block group includes free
space within the block group, so it's inaccurate (i.e. coarse, effectively
allocating space with multi-GB granularity and large error bars).
If you have 20 users, and you want to give them each about 400GB but
don't really care if they get 390GB or 410GB, then maybe it's not so bad.

> In case of multiple profiles on sub-volume basis there is no simple answer in situation like:
> - when I make a snapshot of a sub-volumes, and then I change the profile of the original one,
> which is the profile of the files contained in the snapshot and in the original subvolumes ?

It shouldn't be different from compress:  you look up either the inode
or the root, and it tells you what kind of extent you can allocate next.
Any existing data stays where it is until it is deleted (or overwritten
by CoW).  If you start cloning between subvols then things get a
little interesting (especially if you balance those afterwards) but not
unsolvable if "when two or more answers are possible, it's undefined
which one btrfs picks" is allowed in the solution.

You'd have the same problem with no-longer-allocatable block groups that
don't match the currently selected profile as you do now with mixed
block group profiles.  As the unallocatable block groups empty out,
the storage density of the used space within them goes up, space appears
to disappear, etc.  This is state #3, after all, and it would take some
work to make btrfs as happy in this state as it is in state #1.

> Frankly speaking, if you want different profiles you need different filesystem...

Well, there is that.  Keeping the status quo (or small modifications
thereof) is far easier to document, and it's not like we don't have a
huge list of RAID-related things to fix already.

> BR
> G.Baroncelli
> 
> > 
> > > Of
> > > course this increase the consistency, but
> > > doesn't prevent the possibility that a mixed profiles filesystem could
> > > happen. And in this case is the user that
> > > has to solve the issue.
> > > 
> > > Zygo, suggested also to add a mixed profile warning to btrfs (prog). And
> > > I agree with him. I think that we can use
> > > the space info ioctl (which doesn't require root privileges).
> > > 
> > > BR
> > > G.Baroncelli
> > > 
> > > > This
> > > >    approach also fixes chunk size inconsistency between progs and kernel
> > > >    as reported/fixed here
> > > >      https://patchwork.kernel.org/patch/11431405/
> > > > 
> > > > Thanks, Anand
> > > > 
> > > > > But I am not sure.. Moreover I expected to see also reference to DUP
> > > > > and/or RAID1C[34] ...
> > > > > 
> > > > > Does someone have any suggestion ?
> > > > > 
> > > > > BR
> > > > > G.Baroncelli
> > > > > 
> > > > 
> > > 
> > > 
> > 
> 
> 
> -- 
> gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
> Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
