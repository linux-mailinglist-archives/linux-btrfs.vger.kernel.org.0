Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CEB054D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 23:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfIKVmM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 11 Sep 2019 17:42:12 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48086 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbfIKVmM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 17:42:12 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 45EA4420C69; Wed, 11 Sep 2019 17:42:11 -0400 (EDT)
Date:   Wed, 11 Sep 2019 17:42:11 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     webmaster@zedlx.com
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
Message-ID: <20190911214211.GC22121@hungrycats.org>
References: <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911160101.Horde.mYR8sgLb1dgpIs3fD4D5Cfy@server53.web-hosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190911160101.Horde.mYR8sgLb1dgpIs3fD4D5Cfy@server53.web-hosting.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 04:01:01PM -0400, webmaster@zedlx.com wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
> > On 2019-09-11 13:20, webmaster@zedlx.com wrote:
> > > 
> > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> > > 
> > > > On 2019-09-10 19:32, webmaster@zedlx.com wrote:
> > > > > 
> > > > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> > > > > 
> > > 
> > > > > 
> > > > > === I CHALLENGE you and anyone else on this mailing list: ===
> > > > > 
> > > > >  - Show me an exaple where splitting an extent requires
> > > > > unsharing, and this split is needed to defrag.
> > > > > 
> > > > > Make it clear, write it yourself, I don't want any machine-made outputs.
> > > > > 
> > > > Start with the above comment about all writes unsharing the
> > > > region being written to.
> > > > 
> > > > Now, extrapolating from there:
> > > > 
> > > > Assume you have two files, A and B, each consisting of 64
> > > > filesystem blocks in single shared extent.  Now assume somebody
> > > > writes a few bytes to the middle of file B, right around the
> > > > boundary between blocks 31 and 32, and that you get similar
> > > > writes to file A straddling blocks 14-15 and 47-48.
> > > > 
> > > > After all of that, file A will be 5 extents:
> > > > 
> > > > * A reflink to blocks 0-13 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 14-15
> > > > * A reflink to blocks 16-46 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 47-48
> > > > * A reflink to blocks 49-63 of the original extent.
> > > > 
> > > > And file B will be 3 extents:
> > > > 
> > > > * A reflink to blocks 0-30 of the original extent.
> > > > * A single isolated extent consisting of the new blocks 31-32.
> > > > * A reflink to blocks 32-63 of the original extent.
> > > > 
> > > > Note that there are a total of four contiguous sequences of
> > > > blocks that are common between both files:
> > > > 
> > > > * 0-13
> > > > * 16-30
> > > > * 32-46
> > > > * 49-63
> > > > 
> > > > There is no way to completely defragment either file without
> > > > splitting the original extent (which is still there, just not
> > > > fully referenced by either file) unless you rewrite the whole
> > > > file to a new single extent (which would, of course, completely
> > > > unshare the whole file).  In fact, if you want to ensure that
> > > > those shared regions stay reflinked, there's no way to
> > > > defragment either file without _increasing_ the number of
> > > > extents in that file (either file would need 7 extents to
> > > > properly share only those 4 regions), and even then only one of
> > > > the files could be fully defragmented.
> > > > 
> > > > Such a situation generally won't happen if you're just dealing
> > > > with read-only snapshots, but is not unusual when dealing with
> > > > regular files that are reflinked (which is not an uncommon
> > > > situation on some systems, as a lot of people have `cp` aliased
> > > > to reflink things whenever possible).
> > > 
> > > Well, thank you very much for writing this example. Your example is
> > > certainly not minimal, as it seems to me that one write to the file
> > > A and one write to file B would be sufficient to prove your point,
> > > so there we have one extra write in the example, but that's OK.
> > > 
> > > Your example proves that I was wrong. I admit: it is impossible to
> > > perfectly defrag one subvolume (in the way I imagined it should be
> > > done).
> > > Why? Because, as in your example, there can be files within a SINGLE
> > > subvolume which share their extents with each other. I didn't
> > > consider such a case.
> > > 
> > > On the other hand, I judge this issue to be mostly irrelevant. Why?
> > > Because most of the file sharing will be between subvolumes, not
> > > within a subvolume.
> 
> > Not necessarily. Even ignoring the case of data deduplication (which
> > needs to be considered if you care at all about enterprise usage, and is
> > part of the whole point of using a CoW filesystem), there are existing
> > applications that actively use reflinks, either directly or indirectly
> > (via things like the `copy_file_range` system call), and the number of
> > such applications is growing.
> 
> The same argument goes here: If data-deduplication was performed, then the
> user has specifically requested it.
> Therefore, since it was user's will, the defrag has to honor it, and so the
> defrag must not unshare deduplicated extents because the user wants them
> shared. This might prevent a perfect defrag, but that is exactly what the
> user has requested, either directly or indirectly, by some policy he has
> choosen.
> 
> If an application actively creates reflinked-copies, then we can assume it
> does so according to user's will, therefore it is also a command by user and
> defrag should honor it by not unsharing and by being imperfect.
> 
> Now, you might point out that, in case of data-deduplication, we now have a
> case where most sharing might be within-subvolume, invalidating my assertion
> that most sharing will be between-subvolumes. But this is an invalid (more
> precisely, irelevant) argument. Why? Because the defrag operation has to
> focus on doing what it can do, while honoring user's will. All
> within-subvolume sharing is user-requested, therefore it cannot be part of
> the argument to unshare.
> 
> You can't both perfectly defrag and honor deduplication. Therefore, the
> defrag has to do the best possible thing while still honoring user's will.
> <<<!!! So, the fact that the deduplication was performed is actually the
> reason FOR not unsharing, not against it, as you made it look in that
> paragraph. !!!>>>

IMHO the current kernel 'defrag' API shouldn't be used any more.  We need
a tool that handles dedupe and defrag at the same time, for precisely
this reason:  currently the two operations have no knowledge of each
other and duplicate or reverse each others work.  You don't need to defrag
an extent if you can find a duplicate, and you don't want to use fragmented
extents as dedupe sources.

> If the system unshares automatically after deduplication, then the user will
> need to run deduplication again. Ridiculous!
> 
> > > When a user creates a reflink to a file in the same subvolume, he is
> > > willingly denying himself the assurance of a perfect defrag.
> > > Because, as your example proves, if there are a few writes to BOTH
> > > files, it gets impossible to defrag perfectly. So, if the user
> > > creates such reflinks, it's his own whish and his own fault.
> 
> > The same argument can be made about snapshots.  It's an invalid argument
> > in both cases though because it's not always the user who's creating the
> > reflinks or snapshots.
> 
> Um, I don't agree.
> 
> 1) Actually, it is always the user who is creating reflinks, and snapshots,
> too. Ultimately, it's always the user who does absolutely everything,
> because a computer is supposed to be under his full control. But, in the
> case of reflink-copies, this is even more true
> because reflinks are not an essential feature for normal OS operation, at
> least as far as today's OSes go. Every OS has to copy files around. Every OS
> requires the copy operation. No current OS requires the reflinked-copy
> operation in order to function.

If we don't do reflinks all day, every day, our disks fill up in a matter
of hours...

> 2) A user can make any number of snapshots and subvolumes, but he can at any
> time select one subvolume as a focus of the defrag operation, and that
> subvolume can be perfectly defragmented without any unsharing (except that
> the internal-reflinked files won't be perfectly defragmented).
> Therefore, the snapshoting operation can never jeopardize a perfect defrag.
> The user can make many snapshots without any fears (I'd say a total of 100
> snapshots at any point in time is a good and reasonable limit).
> 
> > > Such situations will occur only in some specific circumstances:
> > > a) when the user is reflinking manually
> > > b) when a file is copied from one subvolume into a different file in
> > > a different subvolume.
> > > 
> > > The situation a) is unusual in normal use of the filesystem. Even
> > > when it occurs, it is the explicit command given by the user, so he
> > > should be willing to accept all the consequences, even the bad ones
> > > like imperfect defrag.
> > > 
> > > The situation b) is possible, but as far as I know copies are
> > > currently not done that way in btrfs. There should probably be the
> > > option to reflink-copy files fron another subvolume, that would be
> > > good.
> > > 
> > > But anyway, it doesn't matter. Because most of the sharing will be
> > > between subvolumes, not within subvolume. So, if there is some
> > > in-subvolume sharing, the defrag wont be 100% perfect, that a minor
> > > point. Unimportant.
> 
> > You're focusing too much on your own use case here.
> 
> It's so easy to say that. But you really don't know. You might be wrong. I
> might be the objective one, and you might be giving me some
> groupthink-induced, badly thought out conclusions from years ago, which was
> never rechecked because that's so hard to do. And then everybody just
> repeats it and it becomes the truth. As Goebels said, if you repeat anything
> enough times, it becomes the truth.
> 
> > Not everybody uses snapshots, and there are many people who are using
> > reflinks very actively within subvolumes, either for deduplication or
> > because it saves time and space when dealing with multiple copies of
> > mostly identical tress of files.
> 
> Yes, I guess there are many such users. Doesn't matter. What you are
> proposing is that the defrag should break all their reflinks and
> deduplicated data they painstakingly created. Come on!
> 
> Or, maybe the defrag should unshare to gain performance? Yes, but only WHEN
> USER REQUESTS IT. So the defrag can unshare,
> but only by request. Since this means that user is reversing his previous
> command to not unshare, this has to be explicitly requested by the user, not
> part of the default defrag operation.
> 
> 
> > As mentioned in the previous email, we actually did have a (mostly)
> > working reflink-aware defrag a few years back.  It got removed because
> > it had serious performance issues.  Note that we're not talking a few
> > seconds of extra time to defrag a full tree here, we're talking
> > double-digit _minutes_ of extra time to defrag a moderate sized (low
> > triple digit GB) subvolume with dozens of snapshots, _if you were lucky_
> > (if you weren't, you would be looking at potentially multiple _hours_ of
> > runtime for the defrag).  The performance scaled inversely proportionate
> > to the number of reflinks involved and the total amount of data in the
> > subvolume being defragmented, and was pretty bad even in the case of
> > only a couple of snapshots.
> > 
> > Ultimately, there are a couple of issues at play here:
> 
> I'll reply to this in another post. This one is getting a bit too long.
> 
> 
