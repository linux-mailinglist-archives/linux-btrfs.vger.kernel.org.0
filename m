Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1633921CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 May 2021 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhEZVOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 May 2021 17:14:10 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:39382 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEZVOJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 May 2021 17:14:09 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id E7366A79431; Wed, 26 May 2021 17:12:36 -0400 (EDT)
Date:   Wed, 26 May 2021 17:12:36 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Andreas Falk <mail@andreasfalk.se>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs check discovered possibly inconsistent journal and now the
 errors are gone
Message-ID: <20210526211236.GD11733@hungrycats.org>
References: <CADw67XBxEvo_doMWCFChUhEhQxDVg4XuzQvTTMOhE=A+wFbuMg@mail.gmail.com>
 <20210523201550.GC11733@hungrycats.org>
 <bcbfd681-7e98-39fa-71d1-231bf676fb8b@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcbfd681-7e98-39fa-71d1-231bf676fb8b@gmx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 24, 2021 at 07:20:31AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/5/24 上午4:15, Zygo Blaxell wrote:
> > On Sun, May 23, 2021 at 04:55:16PM +0100, Andreas Falk wrote:
> > > Hey,
> > > 
> > > I want to start with clarifying that I've got backups of my important
> > > data so what I'm asking here is primarily for my own education to
> > > understand how btrfs works and to make restoring things more
> > > convenient.
> > > 
> > > I'm running a small home server with family photos etc with btrfs in
> > > raid1 and we recently experienced a power cut. I wasn't around when it
> > > got turned back on and when I finally got to it everything had run for
> > > ~2h with the filesystem mounted in readwrite mode so I ran (after the
> > > fact I realized that I should have probably unmounted immediately and
> > > made sure /etc/fstab had everything in readonly mode):
> > > 
> > > $ sudo btrfs check --readonly --force /dev/sdb
> > 
> > Did you run that with the filesystem mounted?  If so, it explains all
> > of the following errors, and the way they seem to appear and disappear.
> > They are the result of btrfs check losing races against the filesystem
> > while the filesystem moves metadata around.
> > 
> > Don't run btrfs check on a mounted filesystem.  It won't work.
> > 
> > Don't run btrfs check at all, unless there are errors the kernel cannot
> > recover from with a scrub.  btrfs check necessarily has fewer data
> > integrity checks than the kernel (otherwise it would not be able to repair
> > anything)
> 
> I can't agree with that part though.
> 
> The truth is, although kernel has tree-checker, it doesn't do
> cross-check for things like extent backref or anything crosses leaf
> boundary.
> 
> Thus btrfs check can still detect problem better than kernel.
>  
> For things can be rejected by kernel tree-checker, it's still a
> rejection, it's still a problem.
> Not to mention sometimes tree-checker can be a little too sensitive,
> like inode transid/generation problems, which won't really affect user
> data at all.
> 
> I agree with the don't run btrfs check on mounted fs, unless it's RO
> mounted.
> But if possible, we still want user to run btrfs check and report back
> any problem found.
> 
> > but that means check can stumble into problems that the kernel
> > would have easily avoided, and can cause damage with --repair as a result.
> > 
> > If you suspect damage to the filesystem (e.g. due to buggy firmware in
> > the drives + power loss), then run btrfs scrub first.  If that reports no
> > errors (or corrects all the errors it does find), then there is usually
> > no need to do anything else.
> 
> But corrupted extent tree like missing backref won't be detected by
> scrub at all.

That's OK, buggy firmware in the drives and simple power loss can't
create that kind of failure[1].  External assaults on the filesystem
(bad drives, power failures, crashes) are best recovered with scrub.
Internal assults on the filesystem (kernel bugs, host CPU/RAM failures)
are where check is needed and useful.  Check is very heavy to run and
almost never finds problems in production kernel/machines, so the cost /
benefit ratio isn't worth it most of the time.

Also, to clarify, when I said "there is usually no need to do anything
else", I meant in terms of running more btrfs recovery tools.  Obviously
if the drives are having csum failures or dropping writes, or the host is
going bad and injecting errors into btrfs, then some corrective action
is required (e.g. replace or reconfigure hardware).  The response focus
should be on "make the damage stop" not "try to repair the damage each
individual time it occurs."

> As scrub just checks the csum of data and metadata, it never checks the
> contents of the metadata.

scrub checks the forward refs of the extent and csum trees, since it
has to walk over them to get to the csums and metadata.  It is true that
scrub doesn't verify everything semantically.

On the other hand, after a simple power failure or crash, only the
csums and forward references _need_ to be verified.  Everything else is
protected by CoW and transactional updates, or it was already corrupted
by a kernel bug or host RAM/CPU failure before the power failure or crash.

If there is a kernel bug, it could occur at any time, most likely _not_
during the short time window of a power failure.  So even if there
is a good reason to run check, it's not _because_ there was a recent
power loss.  The opposite is more likely:  problems that require check
will mostly appear during long periods of continuous uptime.

> Such extent tree mismatch can later lead to broken COW.
> 
> Thus at least for now, btrfs check is still a very needed tool.

There are two cases where a check might be required that are related to
power issues.

One, a host running on residential grid power with no filtering or
conditioning might experience CPU/RAM undervoltages from time to time
that could cause corrupted metadata to be persisted with good csums
on the drives.  Maybe running btrfs check at regular intervals (not
necessarily after reboots, though it may be more convenient to run check
then)  makes sense in that situation, like a deeper kind of scrub.

Even then, this check would not be a first response to a power outage--the
errors are more likely to be persisted on disk at every _other_ time, as
a simple power outage would normally prevent the disks from completing
a transaction with bad metadata (especially on spinning disks where
seeking to update superblocks requires more energy).  The check would
have to be run e.g. every few months to detect these, as ext3/ext4 does.

The problem here is that running check on such a machine is likely to do
bad things to the filesystem (or give false error reports that encourage
the user to do bad things to the filesystem) for the same reasons that the
kernel does.  Bad power breaks all software.  If the machine flips bits
in kernel metadata here and there, it will flip bits in btrfs check too.

Two, there may be a problem specific to fast SSDs and power outages.
The faster NVME devices and even high-end SATA SSDs can stay powered
long enough to persist a lot of garbage metadata as the host CPU/RAM
lose power.  Maybe even long enough to cross multiple btrfs transaction
boundaries with bad metadata and good csums.  Scrub will not detect
that kind of failure unless it's obvious enough for the kernel's checks
to fail.  Check would be needed to catch some of those cases, though
check can't catch them all either.

On the other hand, if this failure event is happening, btrfs would need a
significant new feature to survive on such hardware at all (e.g. multiple
working backup roots); otherwise, damage to the btrfs metadata would be
a routine event, and irreparable damage would be inevitable.

[1] That said, we have seen a number of users on IRC running multiple
kernel versions reporting unexplained and apparently valid tree checker
issues after power outages running btrfs on faster SSD models.  So maybe
non-simple power failures really are happening in the field, we're just
not looking for them?

> Thanks,
> Qu
> 
> > 
> > > and it seemed to mostly run fine but after a while it started printing
> > > messages like this along with what looked like some paths that were
> > > problematic (from what I remember, but these are not my exact
> > > messages):
> > > 
> > > parent transid verify failed on 31302336512 wanted 62455 found 62456
> > > parent transid verify failed on 31302336512 wanted 62455 found 62456
> > > parent transid verify failed on 31302336512 wanted 62455 found 62456
> > > 
> > > along with (these are my exact messages from a log that I saved):
> > > 
> > > The following tree block(s) is corrupted in tree 259:
> > > tree block bytenr: 17047541170176, level: 0, node key:
> > > (18446744073709551606, 128, 25115695316992)
> > > The following tree block(s) is corrupted in tree 260:
> > > tree block bytenr: 17047541170176, level: 0, node key:
> > > (18446744073709551606, 128, 25115695316992)
> > > tree block bytenr: 17047547396096, level: 0, node key:
> > > (18446744073709551606, 128, 25187668619264)
> > > tree block bytenr: 17047547871232, level: 0, node key:
> > > (18446744073709551606, 128, 25124709920768)
> > > tree block bytenr: 17047549526016, level: 0, node key:
> > > (18446744073709551606, 128, 25195576877056)
> > > tree block bytenr: 17047551426560, level: 0, node key:
> > > (18446744073709551606, 128, 25162283048960)
> > > tree block bytenr: 17047551803392, level: 0, node key:
> > > (18446744073709551606, 128, 25177327333376)
> > > 
> > > I didn't have time to look into it deeper at the time and decided to
> > > just shut it down cleanly until today when I'd have some time to look
> > > further at it. I booted it today (still in readwrite unfortunately)
> > > and immediately modified /etc/fstab to not mount any of the volumes,
> > > disabled services that might touch them and then rebooted it again to
> > > make sure it's not touching the disks anymore. Then I ran a check
> > > again:
> > > 
> > > $ sudo btrfs check --readonly --progress /dev/sdb
> > 
> > If the filesystem is readonly then btrfs check has a lower chance of
> > failure.  Still not zero, though.  btrfs check should only be run on
> > unmounted filesystems, if it should be run at all.
> > 
> > > and now it's no longer finding any problems or printing any paths that
> > > are problematic.
> > > 
> > > >From what I've understood from this[a] article, the errors I saw were
> > > likely due to an inconsistent journal.
> > 
> > One rule of thumb for finding bad advice about btrfs on the Internet is to
> > ask if the author believes in the existence of a 'btrfs journal'.  If so,
> > it's a safe bet that the author has no idea what they're writing about.
> > 
> > btrfs doesn't use a journal.  It uses wandering trees for metadata
> > integrity, and a log tree for fsync().  These store different things
> > than a journal, and have very different failure behavior compared to
> > journals in other filesystems.
> > 
> > > Now for my questions:
> > > 
> > > 1. I'm guessing that my reboots, in particular the ones where I still
> > > had it mounted in readwrite mode somehow cleared the journal and
> > > that's why I'm no longer seeing any errors. Does this sound
> > > plausible/correct?
> > 
> > Well, there's no journal, so that can't be part of any correct theory.
> > 
> > It is most likely that there were no errors on disk in the first place.
> > If btrfs check is reading metadata while btrfs was modifying it, then
> > it will always see an inconsistent view of the filesystem.  Each time
> > you run btrfs check, it will see a different inconsistent view of the
> > filesystem, so old errors will disappear, and new ones could appear.
> > 
> > That said, self-correction is not impossible.  Normally btrfs raid1 will
> > automatically correct a corrupted mirror using data from a good mirror.
> > This uniformly handles cases ranging from bits flipped in drive DRAM,
> > writes that were dropped on their way to the disk (due to UNC sector,
> > firmware bug, power loss, misdirected write, FTL failure, or hundreds
> > of other possible reasons), and drives that temporarily disconnected
> > from arrays.
> > 
> > > The errors being gone without me manually clearing
> > > them feels scary to me.
> > 
> > btrfs will usually report such events in the kernel log and increment the
> > 'btrfs dev stats' counters, though there are a handful of exceptions.
> > 
> > The correction is automatic when possible.  It occurs both on normal
> > reads and during scrubs.
> > 
> > > 2. Is there any way to identify the paths again that were problematic
> > > based on the values in the log that I posted above so I can figure out
> > > what to restore from backups rather than doing a full restore?
> > 
> > The error messages you posted are all metadata tree issues.  Paths are
> > in a higher layer of the filesystem.  Depending on which metadata is
> > affected, anywhere from a few hundred paths to the entire filesystem
> > may be affected.
> > 
> > Note that if you ran 'btrfs check' on a mounted filesystem, the errors
> > reported are most likely a result of that mistake, and you should ignore
> > all of check's output under those conditions.
> > 
> > If there are really unrecovered metadata errors on the disks then paths
> > do not matter very much.  The filesystem cannot be safely modified in
> > this case, so only a full mkfs + restore (or successful 'btrfs check
> > --repair --init-extent-tree' run) can make the filesystem writable again.
> > 
> > Note that we have no evidence that you are in this situation, or indeed
> > any evidence of a problem at all.  Power failures are totally routine
> > events for btrfs, and most drive firmware will handle them with no
> > problems (though there are one or two popular drive models out there
> > that won't).
> > 
> > > a. https://ownyourbits.com/2019/03/03/how-to-recover-a-btrfs-partition/
> > 
> > This article features a random mashup of btrfs recovery commands and
> > error messages.  Half of it is simply wrong:  zero-log cannot fix a
> > parent transid verify failed error, all but two btrfs errors imply that
> > you don't need to run chunk-recover, there is no journal...
> > 
> > > Thank you,
> > > Andreas
