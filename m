Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D966343809
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Mar 2021 05:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVEss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Mar 2021 00:48:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36502 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhCVEsf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Mar 2021 00:48:35 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 4FB7D9DE9EE; Mon, 22 Mar 2021 00:48:31 -0400 (EDT)
Date:   Mon, 22 Mar 2021 00:48:31 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dsterba@suse.com
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
Message-ID: <20210322044830.GV28049@hungrycats.org>
References: <20210317012054.238334-1-davispuh@gmail.com>
 <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
 <20a5d997-740a-ca57-8cbc-b88c1e34c8fc@gmx.com>
 <CAOE4rSyX-qTWKS_MTS5dLpfuVnqS=LwfqThyCTP=iBEH5x2bOQ@mail.gmail.com>
 <01129192-1b93-2a93-2edd-f29f544fe340@gmx.com>
 <CAOE4rSwOLQY1JWr-Mdq06Y9nwU_WcQBnfXZx3VWhRQGnBThHUQ@mail.gmail.com>
 <f48c758a-39a3-c73e-fc50-5ab37d2280f9@gmx.com>
 <CAOE4rSzF3g4nA3sXkzEi9MJxFGZ+Sp+POAQHVsXV531y4CJTiA@mail.gmail.com>
 <7db8f3ca-785b-e985-99eb-474aba82281f@gmx.com>
 <CAOE4rSzy645eDZZEsdDrdTGtfePPrPgnU3XrW+xBToU3fUzr8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSzy645eDZZEsdDrdTGtfePPrPgnU3XrW+xBToU3fUzr8g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 22, 2021 at 05:13:13AM +0200, Dāvis Mosāns wrote:
> pirmd., 2021. g. 22. marts, plkst. 02:25 — lietotājs Qu Wenruo
> (<quwenruo.btrfs@gmx.com>) rakstīja:
> >
> >
> >
> > On 2021/3/22 上午5:54, Dāvis Mosāns wrote:
> > > sestd., 2021. g. 20. marts, plkst. 02:34 — lietotājs Qu Wenruo
> > > (<quwenruo.btrfs@gmx.com>) rakstīja:
> > >>
> > >>
> > >>
> > >> On 2021/3/19 下午11:34, Dāvis Mosāns wrote:
> > >>> ceturtd., 2021. g. 18. marts, plkst. 01:49 — lietotājs Qu Wenruo
> > >>> (<quwenruo.btrfs@gmx.com>) rakstīja:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 2021/3/18 上午5:03, Dāvis Mosāns wrote:
> > >>>>> trešd., 2021. g. 17. marts, plkst. 12:28 — lietotājs Qu Wenruo
> > >>>>> (<quwenruo.btrfs@gmx.com>) rakstīja:
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> On 2021/3/17 上午9:29, Dāvis Mosāns wrote:
> > >>>>>>> trešd., 2021. g. 17. marts, plkst. 03:18 — lietotājs Dāvis Mosāns
> > >>>>>>> (<davispuh@gmail.com>) rakstīja:
> > >>>>>>>>
> > >>>>>>>> Currently if there's any corruption at all in extent tree
> > >>>>>>>> (eg. even single bit) then mounting will fail with:
> > >>>>>>>> "failed to read block groups: -5" (-EIO)
> > >>>>>>>> It happens because we immediately abort on first error when
> > >>>>>>>> searching in extent tree for block groups.
> > >>>>>>>>
> > >>>>>>>> Now with this patch if `ignorebadroots` option is specified
> > >>>>>>>> then we handle such case and continue by removing already
> > >>>>>>>> created block groups and creating dummy block groups.
> > >>>>>>>>
> > >>>>>>>> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
> > >>>>>>>> ---
> > >>>>>>>>      fs/btrfs/block-group.c | 14 ++++++++++++++
> > >>>>>>>>      fs/btrfs/disk-io.c     |  4 ++--
> > >>>>>>>>      fs/btrfs/disk-io.h     |  2 ++
> > >>>>>>>>      3 files changed, 18 insertions(+), 2 deletions(-)
> > >>>>>>>>
> > >>>>>>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > >>>>>>>> index 48ebc106a606..827a977614b3 100644
> > >>>>>>>> --- a/fs/btrfs/block-group.c
> > >>>>>>>> +++ b/fs/btrfs/block-group.c
> > >>>>>>>> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
> > >>>>>>>>             ret = check_chunk_block_group_mappings(info);
> > >>>>>>>>      error:
> > >>>>>>>>             btrfs_free_path(path);
> > >>>>>>>> +
> > >>>>>>>> +       if (ret == -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
> > >>>>>>>> +               btrfs_put_block_group_cache(info);
> > >>>>>>>> +               btrfs_stop_all_workers(info);
> > >>>>>>>> +               btrfs_free_block_groups(info);
> > >>>>>>>> +               ret = btrfs_init_workqueues(info, NULL);
> > >>>>>>>> +               if (ret)
> > >>>>>>>> +                       return ret;
> > >>>>>>>> +               ret = btrfs_init_space_info(info);
> > >>>>>>>> +               if (ret)
> > >>>>>>>> +                       return ret;
> > >>>>>>>> +               return fill_dummy_bgs(info);
> > >>>>>>
> > >>>>>> When we hit bad things in extent tree, we should ensure we're mounting
> > >>>>>> the fs RO, or we can't continue.
> > >>>>>>
> > >>>>>> And we should also refuse to mount back to RW if we hit such case, so
> > >>>>>> that we don't need anything complex, just ignore the whole extent tree
> > >>>>>> and create the dummy block groups.
> > >>>>>>
> > >>>>>
> > >>>>> That's what we're doing here, `ignorebadroots` implies RO mount and
> > >>>>> without specifying it doesn't mount at all.
> > >>>>>
> > >>>>>>>
> > >>>>>>> This isn't that nice, but I don't really know how to properly clean up
> > >>>>>>> everything related to already created block groups so this was easiest
> > >>>>>>> way. It seems to work fine.
> > >>>>>>> But looks like need to do something about replay log aswell because if
> > >>>>>>> it's not disabled then it fails with:
> > >>>>>>>
> > >>>>>>> [ 1397.246869] BTRFS info (device sde): start tree-log replay
> > >>>>>>> [ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
> > >>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
> > >>>>>>> [ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
> > >>>>>>> on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
> > >>>>>>> [ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
> > >>>>>>> errno=-5 IO failure
> > >>>>>>> [ 1398.218828] BTRFS: error (device sde) in
> > >>>>>>> btrfs_run_delayed_refs:2124: errno=-5 IO failure
> > >>>>>>> [ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
> > >>>>>>> errno=-5 IO failure (Failed to recover log tree)
> > >>>>>>> [ 1398.229048] BTRFS error (device sde): open_ctree failed
> > >>>>>>
> > >>>>>> This is because we shouldn't allow to do anything write to the fs if we
> > >>>>>> have anything wrong in extent tree.
> > >>>>>>
> > >>>>>
> > >>>>> This is happening when mounting read-only. My assumption is that it
> > >>>>> only tries to replay in memory without writing anything to disk.
> > >>>>>
> > >>>>
> > >>>> We lacks the check on log tree.
> > >>>>
> > >>>> Normally for such forced RO mount, log replay is not allowed.
> > >>>>
> > >>>> We should output a warning to prompt user to use nologreplay, and reject
> > >>>> the mount.
> > >>>>
> > >>>
> > >>> I'm not familiar with log replay but couldn't there be something
> > >>> useful (ignoring ref counts) that would still be worth replaying in
> > >>> memory?
> > >>>
> > >> Log replay means metadata write.
> > >>
> > >> Any write needs a valid extent tree to find out free space for new
> > >> metadata/data.
> > >>
> > >> So no, we can't do anything but completely ignoring the log.
> > >>
> > >
> > > I see, updated patch. But even then it seems it could be possible to
> > > add new ramdisk and make allocations there (eg. create new extent tree
> > > there) thus allowing replay.
> >
> > The problem here is, since the extent tree is corrupted, we won't know
> > which range has metadata already.
> > While metadata CoW, just like its name, needs to CoW, which means it
> > can't writeback (even just in memory) to anywhere we have metadata.
> >
> > The worst case is, we choose a bytenr for the new metadata to be (in
> > memory), but it turns out later read needs to read metadata from the
> > exactly same location.
> >
> 
> The idea is if we add new disk then we would put it after last bytenr
> (which isn't mapped to any existing disks) thus there wouldn't be any
> overlap.

I wonder if that idea can be turned into an online recovery tool.
Rebuild the metadata by more or less reflinking the old filesystem's data
into a new filesystem created in the unallocated spaces between the old
filesystem's block groups (building new subvol trees in the process).
It would need the device and chunk trees to be intact, but you have to
have those for rescue= to work at all, and it's relatively rarer for those
to get damaged.  There's a complicated dance that has to be done to flip
a block group from the old filesystem to the new one, but maybe that can
be done by just making the entire old filesystem into a giant file image,
then making ordinary reflinks to it, then finish by deleting the old
image and running defrag to discard the unreferenced blocks that remain.
Think "btrfs-convert" but using a busted btrfs as source instead of ext4.

OK, way out of scope for this thread.

> > BTW, I'm curious what's your test cases? As it seems you're using
> > log-replay but if we hit anything wrong for the replayed data, it means
> > btrfs kernel module has something wrong.
> > Did you add extra corruption for the replayed data, or it's some bug
> > unexposed?
> 
> Basically I've a corrupted btrfs due to HBA card fault and before I
> nuke it I want to copy as much usable data as possible. So I was
> thinking if whatever is in replay log could be restored. The replay
> tree log itself is perfectly fine with valid checksum and there isn't
> any issues regarding that. I looked at it with `btrfs inspect
> dump-tree` and saw that there isn't anything important so it's fine
> ignoring it.

The log tree will only contain things that were fsync()ed after the
last completed transaction commit.  Unless you're hitting a delayed
refs latency issue or have non-default mount options, that's data from
only the last 30 seconds before the filesystem failed.

It might be desirable to replay the log tree if you had very high-value
data there, but it's the last 0.001% of the filesystem that requires
the last 99% of the development effort to recover.
