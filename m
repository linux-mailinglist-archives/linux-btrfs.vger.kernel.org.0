Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE244F5C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Nov 2021 01:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhKNAEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Nov 2021 19:04:46 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:39490 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhKNAEp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Nov 2021 19:04:45 -0500
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Nov 2021 19:04:45 EST
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 030967B946; Sat, 13 Nov 2021 18:54:07 -0500 (EST)
Date:   Sat, 13 Nov 2021 18:54:07 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Alex Lieflander <atlief@icloud.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Fwd: Finding long-term data corruption
Message-ID: <20211113235407.GA17148@hungrycats.org>
References: <9A4FF989-58C9-4780-A06E-5E0F245EF2BC@icloud.com>
 <6CE25073-39BE-4EF1-AC3D-3483B38AA8A0@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6CE25073-39BE-4EF1-AC3D-3483B38AA8A0@icloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 09:48:12PM -0500, Alex Lieflander wrote:
> Hopefully I’m not pestering anyone, but I would really appreciate if
> someone could point me in the right direction. I can’t do much on my
> system until I figure out what my next, best course of action might be.
>
> I copied and rephrased my remaining questions here. In retrospect of
> the revised questions, much of the context might not have been needed
> in the first place, although it should be found near the question of
> the same base number in my original message (quoted below). Partial
> answers are welcome too.
>
> 1a. How likely is it that BTRFS would detect any corruption/damage
> (with and/or without scrubbing), such that it would refuse to `btrfs
> send` files/sub-volumes affected by it?

btrfs will detect corruption from lower layers in the storage stack
during the send as well as during scrub.

In your earlier message there are signs of a bcache, which introduces
some extra failure modes.  As you read the filesystem through a bcache,
bcache will write some data to the SSDs.  These writes can fail or be
corrupted (e.g. by SSD failure).  Later reads will fetch corrupt data
from the cache instead of the backing HDD, and these errors will be
detected by btrfs.

If you have a bcache (or lvmcache or dm-cache), and your symptoms are
"first btrfs scrub is OK, then I run btrfs scrub again or read some files,
and I now get csum errors", then you probably need to change SSD model
(if not vendor).

The underlying HDD may be intact, so if you have configured bcache in
writethrough mode, the simplest fix may be to remove the SSD cache.

> 1.b. If a sub-volume contains a file for which the source filesystem
> has no valid copy (detectably or not), but that file hasn’t changed
> between incremental `btrfs send`-ing, will the received/generated
> sub-volume still contain the file with its original, uncorrupted version
> (assuming that it already had a valid copy)?

Probably.  send -p tries to avoid resending data that already exists on
the receiving side.  No errors will be detected in data that is not read
on the sending side.

As long as the receiving host is healthy, previously received snapshots
should be unaffected by new data writes.

> 1.c. What about corruption/damage to the metadata related to such a file
> (detectable or not)?

Damage to metadata will result in EIO during any attempt to read the
data, or any metadata dependencies of the data (e.g. csums, directories,
the inode and extent references).

> 2.a. Could sending a (possibly affected) sub-volume from a
> corrupted/damaged filesystem cause any harm to the receiving filesystem
> (or to its existing files/sub-volumes)?

No.  send generates a series of normal filesystem operation commands.
btrfs receive executes those commands and executes them as a normal
process writing to the filesystem.  receive does not directly manipulate
metadata.

If the receiving host is not healthy (e.g. kernel bug, RAM failure,
bad SSD) then it will corrupt data and eventually destroy the receiving
filesystem, but that will happen whether you run btrfs receive or not.

> 4.a. If any of my filesystems currently contain any corrupted/damaged
> files (unbeknownst to BTRFS, even after `btrfs scrub`-ing), what things
> could I try to detect them (in my situation, please see the context
> of 1 and 2)?

If the host has certain kinds of RAM or cache failure, then new errors
will be injected continually as you use the filesystem.  It is critical
to eliminate these sources of corruption first.  If these issues are
not corrected, then any activity on the filesystem (including backups)
can only increase metadata damage and data loss.

> 4.b. Is there anything else that I should do or try?

The symptoms you describe are typical of low-end SSD failure in a bcache
stack.  Please post your SSD model and firmware revision.

> > Begin forwarded message:
> > 
> > From: Alex Lieflander <atlief@icloud.com>
> > Subject: Re: Finding long-term data corruption
> > Date: November 9, 2021 at 1:37:16 PM EST
> > To: Andrei Borzenkov <arvidjaar@gmail.com>
> > Cc: linux-btrfs@vger.kernel.org
> >
> >> On Nov 7, 2021, at 2:28 AM, Andrei Borzenkov <arvidjaar@gmail.com>
> wrote:
> >> 
> >>> On 06.11.2021 20:24, Alex Lieflander wrote:
> >>> 
> >>> Hello,
> >>> 
> >>> All of my files and data were exposed to an unknown amount of
> corruption, and I’d like to know how much I can recover and/or
> whether I can detect the extent of the damage. The steps that led
> me here are a bit complicated but (I think) relevant to the problem,
> so I’ve detailed them below.
> >>> 
> >>> I use BTRFS for most of my filesystems, and my system recently
> died. While investigating the issue, I found out that corruption had
> been detected months earlier (after an unclean shutdown) on one of
> them. Corruption was detected on another a few weeks later for unknown
> reasons. The number of detected corruptions continued to grow to about
> 160 and 30, respectively, before things began to noticeably malfunction.
> >>> 
> >>> During this time I’d been `btrfs sub snap -r`-ing and `btrfs send
> -p`-ing both to the third BTRFS filesystem as a backup method, with no
> errors except some warnings about the “capabilities” of particular
> files being “set multiple times". I reformatted my backup drive a
> few weeks ago for unrelated reasons (after corruption was detected,
> unbeknownst to me). Since then I continued to regularly “backup”
> in this way.
> >>> 
> >>> Once I noticed the corruption (that `btrfs scrub` couldn’t fix)
> I tried increasingly aggressive actions until both original filesystems
> were destroyed and unrecoverable. After that I reformatted and
> “sent” the corresponding sub-volumes back to their original drives
> (with the newly reformatted filesystems). Now scrub detects no errors
> on any of the filesystems, but btrfs-send can’t incrementally send on
> one of the filesystems. The parent I’m using is the one that I sent
> from the backup drive. On closer inspection, the received sub-volume
> has a few subtle permission changes from the sent one. These sub-volumes
> have always been read-only and I don’t think I ever modified them.
> >> 
> >> That most likely is the result of stale received UUID on the source side.
> >> 
> >> https://lore.kernel.org/linux-btrfs/CAL3q7H5y6z7rRu-ZsZe_WXeHteWx1edZi+L3-UL0aa0oYg+qQA@mail.gmail.com/
> > 
> > That problem has now been solved, thank you.
> > 
> >>> With the situation now described, I have a few questions that I’m hoping to find the answer to:
> >>> 
> >>> 1. Can corrupt data propagate through sent sub-volumes?
> >> 
> >> You did not really explain what kind of corruption it was or how you
> >> detected it in the first place. If you are talking about corruption
> >> detected by scrub - it should not, as btrfs should have either used good
> >> copy (in case of redundant profile) or failed btrfs send (if data was
> >> unreadable).
> > 
> > When I mention the initial instances of detected corruption, I’m referring to entries in my recovered syslog that are similar to:
> > 
> > [696136.626700] BTRFS error (device bcache0): bdev /dev/bcache0 errs: wr 0, rd 0, flush 0, corrupt 11, gen 0
> > [696211.391232] BTRFS warning (device bcache0): csum failed root 9219 ino 6967679 off 1415057616896 csum 0x9212d341 expected csum 0x8c30380c mirror 1
> > 
> > When I mention later instances of detected corruption, I’m (in addition) referring to syslog entries similar to:
> > 
> > [158941.583633] BTRFS error (device bcache0): bad tree block level 178 on 2811210498048
> > [   89.312657] BTRFS error (device dm-3): bad tree block start, want 6733332480 have 9811680321309906454
> > 
> > I also remember similar entires in `dmesg` (shortly before the failure) referring to “logical” and “physical” numbers, however I wasn’t able to recover any logs from it.
> > 
> > For the sake of brevity I’ll refer to the time surrounding the initial corruption detection as “the incident”.
> > 
> >>> 2. Can this corruption damage earlier, intact, sub-volumes?
> >> 
> >> Again - what corruption? Physical media errors may happen anywhere.
> >> RAID5 or RAID6 profiles errors may affect non-related data under some
> >> conditions.
> > 
> > I have another disk in another country with sub-volumes sent to it before and after the incident, and I have no evidence to suggest that it experienced direct damage. I think the only way it might have been damaged would be by receiving sub-volumes from the other two filesystems after the incident; I’m wondering how likely it is that sub-volumes sent before the incident would still contain the data exactly as it was stored/sent/received.
> > 
> > The earliest I would have access to that disk is in several months and it’s pretty outdated; having to use it would be a last resort.
> > 
> >>> 3. Does sub-volume sending include the checksums? Would a clean scrub report on the receiving filesystem be an actual indication of uncorrupted data?
> >> 
> >> As far as I know send stream does not include any checksums. btrfs
> >> receive is logical, it creates/writes files from user space so scrub
> >> results on receive side have no relation to content or state of
> >> filesystem on send side.
> >> 
> >>> 4. Is there a way that I could detect what data/files are currently corrupted? How so?
> >> 
> >> For the third time - explain what kind of corruption you are talking
> >> about. If corruption cannot be detected by btrfs, you need to use
> >> data/application specific methods to verify data integrity.
> >> 
> >>> 5. What might cause a sent sub-volume (with no parent) to differ between two filesystems? Is that a sign of corruption?
> >> 
> >> You need to show much more details before this can be answered. Full
> >> send is expected to have the same content. If you have evidences that
> >> this is not the case, provide logs/commands output/any facts that show
> >> how you determine that, starting with actual send/receive invocations
> >> you were using.
> > 
> > I’m not sure what you mean by invocations, but the versions of "btrfs-progs” I used were between 5.1 and 5.10.1. The command I used to send/receive the sub-volume was `btrfs send /path/to/backup_snapshot | pv -pterbas 2T | btrfs receive /path/to/newly_formatted/`. While collecting proof of the differences, I realized that the only difference was in the modification time of the top-level “directory” of the sub-volumes (according to `ls -lh`) by 4 days, which is probably normal.
> > 
> >>> 6. Is using sub-volumes in the way that I described appropriate for use as a backup solution?
> >> 
> >> You did not really describe much. If you refer to
> >> 
> >> "I’d been `btrfs sub snap -r`-ing and `btrfs send -p`-ing both to the
> >> third BTRFS filesystem as a backup method"
> >> 
> >> yes, it is. Do not forget received UUID pitfall and never ever (and I
> >> mean really *EVER*) change any subvolume from being read-only to
> >> read-write as part of restore from backup. Always create a clone
> >> (writable subvolume) of read-only snapshot and use it as recovered content.
> >> 
> >>> Thank you for your work on this interesting and extremely useful filesystem, and for reading this far!
> >>> 
> >>> Regards,
> >>> Alex Lieflander
> 
