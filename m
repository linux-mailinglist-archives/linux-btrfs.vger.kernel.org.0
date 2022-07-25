Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFFA57F7BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 02:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiGYAAr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jul 2022 20:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAAr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jul 2022 20:00:47 -0400
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E4A5FEB
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 17:00:45 -0700 (PDT)
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 4E76D453C61; Sun, 24 Jul 2022 20:00:44 -0400 (EDT)
Date:   Sun, 24 Jul 2022 20:00:44 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Forza <forza@tnonline.net>, Chris Murphy <lists@colorremedies.com>,
        Goffredo Baroncelli <kreijack@inwind.it>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8]
 btrfs: introduce raid-stripe-tree")
Message-ID: <Yt3dLAZQk1QGhVo2@hungrycats.org>
References: <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
 <PH0PR04MB7416243FCD419B4BDDB04D8C9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
 <8b3cf3d0-4812-0e92-d850-09a8d08b8169@libero.it>
 <CAJCQCtTJ=gs7JT4Tdxt3cOVTjkDD1_rQRqv6rbfwohu-Escw6w@mail.gmail.com>
 <b62a80a.e3c8d435.182134a0f8d@tnonline.net>
 <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <829a9b85-db35-1527-bf3d-081c3f4211b2@gmx.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 19, 2022 at 09:19:21AM +0800, Qu Wenruo wrote:
> > > > Doing so we don't need any disk format change and it would be backward compatible.
> > 
> > Do we need to implement RAID56 in the traditional sense? As the
> user/sysadmin I care about redundancy and performance and cost. The
> option to create redundancy for any 'n drives is appealing from a cost
> perspective, otherwise I'd use RAID1/10.
> 
> Have you heard any recent problems related to dm-raid56?
> 
> If your answer is no, then I guess we already have an  answer to your
> question.

With plain dm-raid56 the problems were there since the beginning, so
they're not recent.  If there's a way to configure PPL or a journal
device with raid5 LVs on LVM, I can't find it.  AFAIK nobody who knows
what they're doing would choose dm-raid56 for high-value data, especially
when alternatives like ZFS exist.

Before btrfs, we had a single-digit-percentage rate of severe data losses
(more than 90% data lost) on filesystems and databases using mdadm +
ext3/4 with no journal in degraded mode.  Multiply by per-drive AFR
and that's a lot of full system rebuilds over the years.

> > Since the current RAID56 mode have several important drawbacks
> 
> Let me to be clear:
> 
> If you can ensure you didn't hit power loss, or after a power loss do a
> scrub immediately before any new write, then current RAID56 is fine, at
> least not obviously worse than dm-raid56.

I'm told that scrub doesn't repair parity errors on btrfs.  That was a
thing I got wrong in my raid5 bug list from 2020.  Scrub will fix data
blocks if they have csum errors, but it will not detect or correct
corruption in the parity blocks themselves.  AFAICT the only way to
get the parity blocks rewritten is to run something like balance,
which carries risks of its own due to the sheer volume of IO from
data and metadata updates.

Most of the raid56 bugs I've identified have nothing to do with power
loss.  The data on disks is fine, but the kernel can't read it correctly
in degraded mode, or the diagnostic data from scrub are clearly garbage.

I noticed you and others have done some work here recently, so some of
these issues might be fixed in 5.19.  I haven't re-run my raid5 tests
on post-5.18 kernels yet (there have been other bugs blocking testing).

> (There are still common problems shared between both btrfs raid56 and
> dm-raid56, like destructive-RMW)

Yeah, that's one of the critical things to fix because btrfs is in a good
position to do as well or better than dm-raid56.  btrfs has definitely
fallen behind the other available solutions in the 9 years since raid5 was
first added to btrfs, as btrfs implements only the basic configuration
of raid56 (no parity integrity or rmw journal) that is fully vulnerable
to write hole and drive-side data corruption.

> > - and that it's officially not recommended for production use - it
> is a good idea to reconstruct new btrfs 'redundant-n' profiles that
> doesn't have the inherent issues of traditional RAID.
> 
> I'd say the complexity is hugely underestimated.

I'd agree with that.  e.g. some btrfs equivalent of ZFS raidZ (put parity
blocks inline with extents during writes) is not much more complex to
implement on btrfs than compression; however, the btrfs kernel code
couldn't read compressed data correctly for 12 years out of its 14-year
history, and nobody wants to wait another decade or more for raid5
to work.

It seems to me the biggest problem with write hole fixes is that all
the potential fixes have cost tradeoffs, and everybody wants to veto
the fix that has a cost they don't like.

We could implement multiple fix approaches at the same time, as AFAIK
most of the proposed solutions are orthogonal to each other.  e.g. a
write-ahead log can safely enable RMW at a higher IO cost, while the
allocator could place extents to avoid RMW and thereby avoid the logging
cost as much as possible (paid for by a deferred relocation/garbage
collection cost), and using both at the same time would combine both
benefits.  Both solutions can be used independently for filesystems at
extreme ends of the performance/capacity spectrum (if the filesystem is
never more than 50% full, then logging is all cost with no gain compared
to allocator avoidance of RMW, while a filesystem that is always near
full will have to journal writes and also throttle writes on the journal.

> > For example a non-striped redundant-n profile as well as a striped redundant-n profile.
> 
> Non-striped redundant-n profile is already so complex that I can't
> figure out a working idea right now.
> 
> But if there is such way, I'm pretty happy to consider.
> 
> > 
> > > 
> > > My 2 cents...
> > > 
> > > Regarding the current raid56 support, in order of preference:
> > > 
> > > a. Fix the current bugs, without changing format. Zygo has an extensive list.
> > 
> > I agree that relatively simple fixes should be made. But it seems we will need quite a large rewrite to solve all issues? Is there a minium viable option here?
> 
> Nope. Just see my write-intent code, already have prototype (just needs
> new scrub based recovery code at mount time) working.
> 
> And based on my write-intent code, I don't think it's that hard to
> implement a full journal.

FWIW I think we can get a very usable btrfs raid5 with a small format
change (add a journal for stripe RMW, though we might disagree about
details of how it should be structured and used) and fixes to the
read-repair and scrub problems.  The read-side problems in btrfs raid5
were always much more severe than the write hole.  As soon as a disk
goes offline, the read-repair code is unable to read all the surviving
data correctly, and the filesystem has to be kept inactive or data on
the disks will be gradually corrupted as bad parity gets mixed with data
and written back to the filesystem.

A few of the problems will require a deeper redesign, but IMHO they're not
important problems.  e.g. scrub can't identify which drive is corrupted
in all cases, because it has no csum on parity blocks.  The current
on-disk format needs every data block in the raid5 stripe to be occupied
by a file with a csum so scrub can eliminate every other block as the
possible source of mismatched parity.  While this could be fixed by
a future new raid5 profile (and/or csum tree) specifically designed
to avoid this, it's not something I'd insist on having before deploying
a fleet of btrfs raid5 boxes.  Silent corruption failures are so
rare on spinning disks that I'd use the feature maybe once a decade.
Silent corruption due to a failing or overheating HBA chip will most
likely affect multiple disks at once and trash the whole filesystem,
so individual drive-level corruption reporting isn't helpful.

> Thanks,
> Qu
> 
> > 
> > > b. Mostly fix the write hole, also without changing the format, by
> > > only doing COW with full stripe writes. Yes you could somehow get
> > > corrupt parity still and not know it until degraded operation produces
> > > a bad reconstruction of data - but checksum will still catch that.
> > > This kind of "unreplicated corruption" is not quite the same thing as
> > > the write hole, because it isn't pernicious like the write hole.
> > 
> > What is the difference to a)? Is write hole the worst issue? Judging from the #brtfs channel discussions there seems to be other quite severe issues, for example real data corruption risks in degraded mode.
> > 
> > > c. A new de-clustered parity raid56 implementation that is not
> > > backwards compatible.
> > 
> > Yes. We have a good opportunity to work out something much better than current implementations. We could have  redundant-n profiles that also works with tired storage like ssd/nvme similar to the metadata on ssd idea.
> > 
> > Variable stripe width has been brought up before, but received cool responses. Why is that? IMO it could improve random 4k ios by doing equivalent to RAID1 instead of RMW, while also closing the write hole. Perhaps there is a middle ground to be found?
> > 
> > 
> > > 
> > > Ergo, I think it's best to not break the format twice. Even if a new
> > > raid implementation is years off.
> > 
> > I very agree here. Btrfs already suffers in public opinion from the lack of a stable and safe-for-data RAID56, and requiring several non-compatible chances isn't going to help.
> > 
> > I also think it's important that the 'temporary' changes actually leads to a stable filesystem. Because what is the point otherwise?
> > 
> > Thanks
> > Forza
> > 
> > > 
> > > Metadata centric workloads suck on parity raid anyway. If Btrfs always
> > > does full stripe COW won't matter even if the performance is worse
> > > because no one should use parity raid for this workload anyway.
> > > 
> > > 
> > > --
> > > Chris Murphy
> > 
> > 
