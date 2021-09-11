Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE040753B
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Sep 2021 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhIKFIb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 11 Sep 2021 01:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhIKFIa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 11 Sep 2021 01:08:30 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB45C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 22:07:18 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 109so2549266uag.13
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 22:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx7j7R6bDUGjcV+UWenHA/iMxhtkoOQLuEbFMTeXuJI=;
        b=WMKybrNa/LXWra/LTMT+18H6dWcUnz+PsUm2WvRjd5ggI9DMwARHf2Cu9AVxbrMG1o
         Ve+9TQq3LFYqSRbKuWhHPCpg0wPvliM5CjuVieXgZNqr1A2/HtBIfUajQczMeE8zrQFM
         qPY1Wguq7RU62OObRCHC+nairJnqmB7pl2KoWk4/NHpWO96cAWtuEHrIs0OATF9S2Hhj
         v+pk+Tp7Rs+4l4IBOrEu1ydSWXgVx8aD1lZKVjrJiSzYVhch2adttfs3MAjncDHplaUX
         J/8hSaeo6fBojTYyfdqoot3e2EZfuNGhzNDzjm4rfcZM3TYSIPmfC2aHRFPwaIMEabu2
         iTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx7j7R6bDUGjcV+UWenHA/iMxhtkoOQLuEbFMTeXuJI=;
        b=rzBT7k5y/0BtKn/RCvLwLoHK52lTw/eKgpXBirV2sjNsy+NTvkb3fVlgcD5X+OFqP2
         39S21WjhCQja/iOctJaewfsv/rp2Kwj11iPfmYQReQV6HQIzZqZP9X0aBggDwNfMZHJb
         RJSlWD0dums6AA1rbgjnovzJcHVLX+3T3rBIS91O44zwV57CjwYAVHJYwm5fOBS20TP7
         UAHvNyTHhTTg2afIaq9rBk0vylMSZueYBdgG3HRlwK8pWhSfZJ7gZcdWU5hS9igIVDA8
         /Bfdt2DV5utIcB//yRNR9DmXoWdZBKXfM41se6O1je4yOQ4+HLk827nVL7u1ulq4JcK/
         C+1A==
X-Gm-Message-State: AOAM530mcCSq4TIEi2iUHk1hwz0xUzbTFxF38hDbPPsuJ4BT5m2B15dL
        JjUmi+Qyvs28YB3eL7L8EwHhnB4J13WRuNJOSQ0=
X-Google-Smtp-Source: ABdhPJwvLNIk35pXMETK1epCtsCURteuKAUJCRhlo/8sH/YDq2qAsEphkJtlEduga2TVllaoxllSBH7WNEWb/XuRdS8=
X-Received: by 2002:ab0:448:: with SMTP id 66mr464423uav.64.1631336836976;
 Fri, 10 Sep 2021 22:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com> <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <20210911042414.GJ29026@hungrycats.org>
In-Reply-To: <20210911042414.GJ29026@hungrycats.org>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Fri, 10 Sep 2021 23:07:04 -0600
Message-ID: <CAH5Ym4jNgs1iJufbmCDOS6N=k+YH4nZTSQ7j-MrM3mp8M0Yn2g@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pretty much everything you've said scans with what I'm seeing over here.

Sadly I can't easily replace, remove, or augment the drive. It's
inside a laptop that doesn't look like it was designed for user
serviceability. I don't even have any assurances that it isn't
soldered to the board.

I included the SMART information when I posted my Gist. Take whatever
info you need.

Best,
Sam


On Fri, Sep 10, 2021 at 10:24 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Fri, Sep 10, 2021 at 01:44:51AM -0600, Sam Edwards wrote:
> > Hi Qu,
> >
> > Thank you very much for your insight. It is also helpful to know that
> > I appear to be understanding the btrfs internals properly. :)
> >
> > On Fri, Sep 10, 2021 at 12:17 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > But for SSD/HDD, we're more cautious about any transid error.
> > >
> > > There are already known bad disks which don't follow FLUSH requests,
> > > thus leads to super easy transid mismatch on powerloss:
> > >
> > > https://btrfs.wiki.kernel.org/index.php/Hardware_bugs
> >
> > I strongly believe now that the SSD hardware/firmware is not the
> > issue. Not only was the last "power loss"-type event on the 5th (which
> > appears to have caused no damage), the issue appeared while the system
> > was running -- a SSD firmware problem of that magnitude should have
> > been apparent long before I upgraded to 5.14.1.
>
> Have you reported the model and firmware revision of the SSD?
> This is critical information for identifying firmware problems.
>
> Write cache firmware failures are not only triggered by power losses.
> They can be triggered by underlying media failures and SSD embedded DRAM
> failures.  This kind of firmware bug would show zero symptoms before
> (and sometimes during) the triggering failure event.  When it happens,
> there may be no indication of failure other than a whole lot of "parent
> transid verify failed" and related errors that appear out of nowhere
> during otherwise normal operation.  Such failures are often accompanied
> by bus timeouts and resets, but it can also happen with no external
> indication if there is no write in progress at the time of failure.
>
> There are roughly 40 distinct block addresses affected in your check log,
> clustered in two separate 256 MB blocks.  That looks fairly normal--the
> btrfs allocator packs related updates close together to take advantage
> of sequential write performance, so all of a dropped transaction's
> writes would have nearby addresses.  The variation in transid is also
> normal--the new tree pages refer to old tree pages of various ages and
> replace old tree pages of various ages themselves.
>
> The parent transid verify messages appear in identical pairs, which is
> consistent with a dropped cache write on a single drive with dup metadata.
> Btrfs will try to read both mirror copies if the first one is wrong.
> Both writes occur at the same time, so both writes can be in the drive's
> write cache when the contents of the drive's DRAM are lost.
>
> The other errors are consistent with consequences of these failures.
> Leaf pages of the metadata trees are no longer reachable because a path
> to these leaf nodes, or the nodes themselves, do not exist on disk.
> Items within the missing leaf pages (like csums, inodes, dirents, and
> backrefs) cannot be found when references to these items from other
> parts of the filesystem are checked, so you get a lot of missing
> directory entries, backrefs, and csums.
>
> Other failure modes can generate this pattern (e.g. host RAM corruption
> and kernel bugs) but other failure modes often leave other indications
> that are not present in these logs.  There's no information here
> that points to some failure mode other than a write cache failure.
> btrfs is designed to reliably detect write cache failures, so based on
> the information so far I wouldn't suspect anything else.
>
> > > > So, question: does the btrfs module use 256 MiB as a default size for
> > > > write-back cache pages anywhere?
> > >
> > > No.
> > >
> > > > Or might this problem reside deeper
> > > > in the block storage system?
> > >
> > > So if possible, please test without dm-crypto to make sure it's really
> > > btrfs causing the problem.
> >
> > Since you don't find the 256 MiB size evocative of any component of
> > btrfs, I am also willing to say that this likely isn't a fault in
> > btrfs. So, I think this is now an exercise in ruling out btrfs
> > completely (before I move on to investigating devicemapper, the crypto
> > target, the NVMe driver, and the block storage system as a whole) and
> > further studying the filesystem to gain insight as to how this
> > happened.
> >
> > > > Also, for what it's worth: the last generation to be written before
> > > > these inconsistencies seems to be 66303. Files written as part of that
> > > > transaction have a birth date of Sep. 7. That's during the same boot
> > > > as the failure to read-only,
> > >
> > > That's interesting.
> > >
> > > Btrfs aborts transaction when it hits critical metadata problems to
> > > prevent further damage, but I still remember some possible corruption
> > > caused by aborting transaction in the old days.
> > > But those corruptions should not exist in v5.14.
> >
> > I understand "aborts" to mean, "if btrfs is in the middle of a write
> > transaction, and in the process discovers existing metadata corruption
> > (e.g. tree node generation mismatch) already on-disk, it will undo any
> > earlier modifications already written to disk as part of that
> > transaction" -- is this correct? If so, I don't believe there was any
> > existing metadata corruption on the disk beforehand, so I doubt the
> > abort mechanism is at fault here.
> >
> > > Furthermore, the read-only flips itself is more important, do you have
> > > the dmesg of that incident?
> >
> > Sadly, I wasn't able to save the dmesg (for obvious reasons), but I do
> > recall logs complaining of checksum failures and transid mismatches. I
> > did make note of the block bytenrs, which were in the interval
> > [1065332047872, 1065391243264] which itself appears to be part of the
> > same 256 MiB "slice" as I found before.
> >
> > > Recently we also see some corrupted free space cache causing problems.
> >
> > I infer "problems" to mean, "free space cache indicates block X is
> > free though it is not, so btrfs allocates a new tree node or extent at
> > that location, overwriting necessary data"?
> >
> > If so, I don't think this is the case here either. If an older node is
> > overwritten with a newer one, I would expect the transid mismatches to
> > be that the found IDs are *greater* than the wanted IDs. I am finding
> > valid, but *older*, tree nodes in the affected region. This seems like
> > a "lost writes" kind of problem to me, not overwrites.
> >
> > However I did note some free space cache errors in my timeline.txt
> > file over on the Github Gist. If you believe that this is still a
> > likelihood, I can investigate further.
> >
> > > If you're going to re-test this, mind to use space cache v2 to do the
> > > tests?
> > >
> > > > which suggests that the cached buffer
> > > > wasn't merely "not saved before a previous shutdown" but rather
> > > > "discarded without being written back." Thoughts?
> > >
> > > This should not be a thing for btrfs.
> > >
> > > Btrfs COW protects its metadata, as long as there is no problem in btrfs
> > > itself allocating new tree blocks to ex you're reporting some RO
> > > incidents, then I guess the COW mechanism may be broken at that time
> > > alreadyisting blocks in the same transaction, we're completely safe.
> >
> > Again, making sure I understand you correctly: Btrfs, by design,
> > *never* modifies an active tree node/leaf. It will instead copy the
> > node/leaf it wishes to modify into memory, perform the modifications
> > there, save the modified copy at a free location on disk, and then
> > recursively modify parents (using the same process) all the way back
> > to the superblock(s).
> >
> > And so, if power is lost in the middle of this process (i.e. before
> > the superblock is updated), then the old paths down the trees are
> > intact. The transaction is lost, but existing metadata is protected.
> > Correct?
>
> If btrfs stops writing to the filesystem immediately, either because a
> power failure stopped the kernel running, or a metadata integrity failure
> error was detected, then existing metadata is protected.
>
> If btrfs does _not_ stop writing immediately (e.g. the disk does not
> notify btrfs of write failure) and commits a transaction after writes are
> dropped, then metadata will be destroyed by later transactions because
> they will assume the previously written data is present on disk when it
> is not.
>
> > > But considering you're reporting some RO incidents, then I guess the COW
> > > mechanism may be broken at that time already.
> > > (Maybe abort leads to some corrupted free space cache?)
> >
> > Hypothetically, suppose one were to try this experiment:
> > 1. Set up a brand-new machine, which has 2 independent but equally-sized disks.
> > 2. On disk A, create a btrfs and mount it. Use it as a normal rootfs
> > for a while, and then unmount it.
> > 3. Image disk A to disk B (perhaps obfuscating the image so that it
> > doesn't confuse btrfs's RAID logic).
> > 4. Remount disk A and begin using it heavily (reads and writes). At a
> > random moment, instantly copy a 256 MiB slice from disk B onto disk A,
> > choosing an offset that has recently been written on disk A, while
> > disk A is still mounted.
> >
> > Would this cause csum failures, transid mismatches, a RO incident, and
> > the general output from "btrfs check" that I posted?
>
> It would, but in far larger quantities (thousands of blocks instead of
> just a few dozen).
>
> If you have two disks you could run btrfs raid1 on them.  Failures on
> one disk will be corrected by reading from the other.  Pairing disks by
> different vendors in large numbers is an excellent way to quickly learn
> which models are bad.
>
> > If so, I think the problem is that a write-back cache, somewhere
> > deeper in the block storage stack (i.e. not btrfs) simply...
> > *discarded* a contiguous 256 MiB worth of data that btrfs thought had
> > been successfully written, and the RO incident was due to btrfs
> > suddenly seeing old data resurface. Does this seem like the best
> > working hypothesis currently?
>
> No, we would expect _much_ more damage than your check run reported.
>
> > Also: Per your expert opinion, what would be the best way to repair
> > disk A (without the benefit of disk B, heh) in the experiment above? I
> > imagine the affected slice itself is not salvageable, and will have to
> > be forcibly marked as free space, and in the process throwing out any
> > references to tree nodes that happened to reside there, meaning I'll
> > lose a whole bunch of extents, inodes, csum tree entries, and so on...
> > and in turn I'd lose a random assortment of files. I'm actually okay
> > with that, because I can diff the surviving files against my last
> > backup and restore whatever was deleted.
>
> You'd have to reinsert all the surviving (and up to date) leaf nodes
> into new trees, then remove any dangling references, then verify all
> the surviving data.  That's more total IO than mkfs + restore, and
> requires significant memory and CPU as well.
>
> > Or is the whole thing FUBAR at this point and I should just zero the
> > partition and restore from backups?
>
> If you have backups, it's usually faster to restore them.
>
> I'd put that drive on probation for a while--maybe use it only in raid1
> setups, or turn off its write cache, or run a stress test for a while
> to see if it fails again.
>
> Certainly if you suspect the 5.14 kernel then it would be worthwhile to
> retest the drive with an older kernel, or test different drives with a
> newer kernel.  If you can reproduce the issue with multiple drives that
> is always an interesting bug report.
>
> We want to know your drive model and firmware revision.  If everyone who
> owns one of these drives reports the same problem, we know the problem
> is in the drive firmware.  If we see the problem across multiple drives
> then we know it's somewhere else.
>
> > Thank you for your time,
> > Sam
> >
> > > Thanks,
> > > Qu
> > >
> > > >
> > > > Cheers,
> > > > Sam
> > > >
> > > >
> > > > On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrote:
> > > >>
> > > >> Hello list,
> > > >>
> > > >> First, I should say that there's no urgency here on my part.
> > > >> Everything important is very well backed up, and even the
> > > >> "unimportant" files (various configs) seem readable. I imaged the
> > > >> partition without even attempting a repair. Normally, my inclination
> > > >> would be to shrug this off and recreate the filesystem.
> > > >>
> > > >> However, I'd like to help investigate the root cause, because:
> > > >> 1. This happened suspiciously soon (see my timeline in the link below)
> > > >> after upgrading to kernel 5.14.1, so may be a serious regression.
> > > >> 2. The filesystem was created less than 5 weeks ago, so the possible
> > > >> causes are relatively few.
> > > >> 3. My last successful btrfs scrub was just before upgrading to 5.14.1,
> > > >> hopefully narrowing possible root causes even more.
> > > >> 4. I have imaged the partition and am thus willing to attempt risky
> > > >> experimental repairs. (Mostly for the sake of reporting if they work.)
> > > >>
> > > >> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no LVM)
> > > >> OS: Gentoo
> > > >> Earliest kernel ever used: 5.10.52-gentoo
> > > >> First kernel version used for "real" usage: 5.13.8
> > > >> Relevant information: See my Gist,
> > > >> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
> > > >> Misc. notes: I have run "fstrim /" on occasion, but don't have
> > > >> discards enabled automatically. I doubt TRIM is the culprit, but I
> > > >> can't rule it out.
> > > >>
> > > >> My primary hypothesis is that there's some write bug in Linux 5.14.1.
> > > >> I installed some package updates right before btrfs detected the
> > > >> problem, and most of the files in the `btrfs check` output look like
> > > >> they were created as part of those updates.
> > > >>
> > > >> My secondary hypothesis is that creating and/or using the swapfile
> > > >> caused some kind of silent corruption that didn't become a detectable
> > > >> issue until several further writes later.
> > > >>
> > > >> Let me know if there's anything else I should try/provide!
> > > >>
> > > >> Regards,
> > > >> Sam
