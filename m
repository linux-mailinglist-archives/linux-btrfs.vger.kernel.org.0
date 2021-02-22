Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC89132103A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 06:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhBVFXF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 00:23:05 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37500 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhBVFXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 00:23:03 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 53DAF99B2A3; Mon, 22 Feb 2021 00:22:21 -0500 (EST)
Date:   Mon, 22 Feb 2021 00:22:21 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: ERROR: failed to read block groups: Input/output error
Message-ID: <20210222052221.GM28049@hungrycats.org>
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <20210219192947.GJ32440@hungrycats.org>
 <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 21, 2021 at 01:45:10AM +0200, Dāvis Mosāns wrote:
> piektd., 2021. g. 19. febr., plkst. 07:16 — lietotājs Chris Murphy
> (<lists@colorremedies.com>) rakstīja:
[...]
> > btrfs check -b /dev/
> So I think btrfs check -b --repair should be able to fix most of things.

Why do you think that?  If the HBA was failing for more than a minute
before the filesystem detected a failure and went read-only, it will
have damaged metadata all over the tree.

> > You might try kernel 5.11 which has a new mount option that will skip
> > bad roots and csums. It's 'mount -o ro,rescue=all' and while it won't
> > let you fix it, in the off chance it mounts, it'll let you get data
> > out before trying to repair the file system, which sometimes makes
> > things worse.

rescue=all (or rescue=ignorebadroots) only takes effect if the extent
tree root cannot be found at all.  In this case, you have an available
extent tree root, but some of the leaves are damaged, so the filesystem
fails later on.

There's an opportunity for a patch here that doesn't even try to use the
extent tree, just pretends it wasn't found.  There is similar logic in the
patch for ignoredatacsums that can be used as a reference.  Maybe that's
what rescue=ignorebadroots should always do...I mean if we think the
non-essential roots are bad, why would we even try to use any of them?

On the other hand, such a patch would only get past this problem so
we can encounter the next problem.  You say you want to check csums,
so you need to read the csum tree, but the csum tree would probably be
similarly damaged.  Large numbers of csums may not be available without
rebuilding the csum tree.  Note this is not the same as recomputing the
csums--we just want to scrape up all the surviving csum tree metadata
leaf pages and build a new csum tree out of them.  I'm not sure if any
of the existing tools do that.

> It doesn't make any difference, still doesn't mount
> $ uname -r
> 5.11.0-arch2-1
> $ sudo mount -o ro,rescue=all /dev/sda ./RAID
> mount: /mnt/RAID: wrong fs type, bad option, bad superblock on
> /dev/sda, missing codepage or helper program, or other error.
> 
> BTRFS warning (device sdl): sdl checksum verify failed on
> 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
> BTRFS warning (device sdl): sdl checksum verify failed on
> 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> BTRFS error (device sdl): failed to read block groups: -5
> BTRFS error (device sdl): open_ctree failed
> 
> It seems there should be a way to mount with backup tree root like I
> did for check but strangly usebackuproot doesn't do that...

All but the last few backup trees are normally destroyed within a few
minutes by writes from new transactions.

> piektd., 2021. g. 19. febr., plkst. 21:29 — lietotājs Zygo Blaxell
> (<ce3g8jdj@umail.furryterror.org>) rakstīja:
> >
> > On Thu, Jan 14, 2021 at 01:09:40AM +0200, Dāvis Mosāns wrote:
> > > Hi,
> > >
> > > I've 6x 3TB HDD RAID1 BTRFS filesystem where HBA card failed and
> > > caused some corruption.
> > > When I try to mount it I get
> > > $ mount /dev/sdt /mnt
> > > mount: /mnt/: wrong fs type, bad option, bad superblock on /dev/sdt,
> > > missing codepage or helper program, or other error
> > > $ dmesg | tail -n 9
> > > [  617.158962] BTRFS info (device sdt): disk space caching is enabled
> > > [  617.158965] BTRFS info (device sdt): has skinny extents
> > > [  617.756924] BTRFS info (device sdt): bdev /dev/sdl errs: wr 0, rd
> > > 0, flush 0, corrupt 473, gen 0
> > > [  617.756929] BTRFS info (device sdt): bdev /dev/sdj errs: wr 31626,
> > > rd 18765, flush 178, corrupt 5841, gen 0
> > > [  617.756933] BTRFS info (device sdt): bdev /dev/sdg errs: wr 6867,
> > > rd 2640, flush 178, corrupt 1066, gen 0
> >
> > You have write errors on 2 disks, read errors on 3 disks, and raid1
> > tolerates only 1 disk failure, so successful recovery is unlikely.
> 
> Those wr/rd/corrupt error counts are inflated/misleading, in past when
> some HDD drops out I've had them increase in huge numbers, but after
> running scrub usually it was able to fix almost everything except like
> few files that could be just deleted. 

That is very bad.

With recoverable failures on raid1, scrub should be able to fix every
error, every time (to the extent that btrfs can detect errors, and there
is a known issue with writing to pages in memory while doing direct IO at
the same time).  If scrub fails to recover all errors then your system
was likely exceeding the RAID1 failure tolerances (at most 1 failure
per mirrored block) and if that is not fixed then loss of filesystem
is inevitable.

Healthy disks should never drop off the SATA bus.  If that is happening
then problem needs to be identified and resolved, i.e. find the bad cable,
bad PSU, bad HBA, bad disk, bad disk firmware, mismatched kernel/SCTERC
timeouts, failing disk, BIOS misconfiguration, etc. and replace the bad
hardware or fix the configuration.

> Only now it's possible that it
> failed while scrub was running making it a lot worse.

If the HBA is mangling command headers (turning reads into writes, or
changing the LBA of a write) then scrub could do some damage:  corrupted
reads would trigger self-repair which would try to overwrite the
affected blocks with correct data.  If the HBA corrupts the next write
command address then that data could end up written somewhere it's not
supposed to be.  The error rate would have to be very high or bursty
before scrub could damage metadata--~99% of btrfs scrub IO is data,
so metadata corruption caused by scrub is very rare.

Scrub will heat up the HBA chip which could increase the error rate
temporarily or trigger a more permanent failure if it was already faulty.
That theory is consistent with the observations so far.

The HBA could have been randomly corrupting data and dropping drives off
the bus the whole time, and finally the corruption landed on a metadata
block recently.  That theory is also consistent with the observations
so far.

> > > [  631.353725] BTRFS warning (device sdt): sdt checksum verify failed
> > > on 21057101103104 wanted 0x753cdd5f found 0x9c0ba035 level 0
> > > [  631.376024] BTRFS warning (device sdt): sdt checksum verify failed
> > > on 21057101103104 wanted 0x753cdd5f found 0xb908effa level 0
> >
> > Both copies of this metadata block are corrupted, differently.
> >
> > This is consistent with some kinds of HBA failure:  every outgoing block
> > from the host is potentially corrupted, usually silently.  Due to the HBA
> > failure, there is no indication of failure available to the filesystem
> > until after several corrupt blocks are written to disk.  By the time
> > failure is detected, damage is extensive, especially for metadata where
> > overwrites are frequent.
> 
> I don't think it's that bad here. My guess is that it failed while
> updating extent tree and some part of it didn't got written to disk. 

"some part of [the extent tree] didn't get written to disk" is the worst
case scenario.  It doesn't matter if the filesystem lost 1 extent tree
page or 1000.  If there are any missing interior nodes then the trees
need to be rebuilt before they are usable again.

If metadata interior nodes are missing, then the leaf pages behind them
are no longer accessible without brute-force search of all metadata
chunks.  There's no other way to find them because they could be anywhere
in a metadata chunk.  If leaf pages are missing then reference counts
are no longer reliable and safely writing to the filesystem is not
possible.

It's theoretically possible to scan for just the leaf pages and rebuild
the interior nodes so that read-only access to the data is possible,
but I don't know of an existing tool that does only that.  Check will
read from the subvol trees and try to rebuild the extent tree, which
is not quite the same thing.

> I
> want to check how it looks like on disk, is there some tool to map
> block number to offset in disk?

'btrfs-map-logical' does the translation internally, but it will go ahead
and read the block for you, it doesn't tell you the translation result.

> > This is failure mode that you need backups to recover from (or mirror
> > disks on separate, non-failing HBA hardware).
> 
> I don't know how btrfs decides in which disks it stores copies or if
> it's always in same disk. To prevent such failure in future I could
> split RAID1 across 2 different HBAs but it's not clear which disks
> would need to be seperated.

Ideally in any RAID system every disk gets its own separate controller.
There would be isolated hardware for every disk, including HBA and
power supply.  This isn't very practical or cost-effective (except
on purpose-built NAS and server hardware), so most people backup the
filesystem content on another host instead.

Using a separate host means you get easy and effective isolation from
failures in CPU, RAM, HBA, PCI bridges, power supply, cooling, kernel,
and any of a dozen other points of failure that could break a filesystem.

> I don't want to use --init-extent-tree because I don't want to reset
> everything, but only corrupted things. 

Same thing.

For read-write mounts, you can remove all the corrupted things,
but after that some of the reference data is missing from the tree,
so you have to verify the entire tree to remove the inconsistencies.
The easiest way to do that is to build a new consistent tree out of the
old metadata items so you can query it for duplicate and missing items,
but if you've already built a new consistent tree then you might as well
keep it and throw away the old one.

For read-only mounts, you will need to search for all the leaf pages of
the tree where an interior node is damaged and no longer points to the
leaf page.

> Also btrfs check --repair
> doesn't work as it aborts too quickly, only using with -b flag could
> fix it I think.

The difference between --repair and --init-extent-tree is that --repair
can make small fixes to trees that are otherwise intact.  If --repair
encounters something that cannot be repaired in place (like missing
interior nodes of the tree) then it will abort.  In such cases you will
need to do --init-extent-tree to make the filesystem writable again
(or even readable in some cases).

I would not advise trying to make this filesystem writable again.
I'd copy the data off, then mkfs and copy it back (or swap disks with
the copy).  The HBA failure has likely corrupted recently written data
too, so I'd stick with trying to recover older files and assume all new
files are bad.  Old files can be compared with backups to see if they
were damaged by misaddressed writes.

I wouldn't advise using this filesystem as a btrfs check --repair
test case.  It's easy to build a randomly corrupted filesystem for
development testing, and check --repair needs more development work to
cope with much gentler corruption cases.

> > Both methods are likely to fail in the presence of so much corruption
> > and they may take so long to run that mkfs + restore from backups could
> > be significantly faster.  Definitely extract any data from the filesystem
> > that you want to keep _before_ attempting any of these operations.
> 
> It's not really about time, I rather want to reduce possilble data
> loss as much as possible.
> I can't mount it even read-only so it seems the only way to get data
> out is by using btrfs restore which seems to work fine but does it
> verify file checksums? It looks like it doesn't... 

btrfs restore does not verify checksums (nor is it confused by metadata
inconsistency or corruption in the csum tree).  You get the data that
is on disk in all its corrupt glory.

There's another patch opportunity:  teach btrfs restore how to read the
csum tree.

Note that if you have damaged metadata, the file data checksums may no
longer be available, or a brute-force search may be required to locate
them, so even if you get csum verification working, it might not be
very useful.

> I have some files
> where it said:
> We seem to be looping a lot on ./something, do you want to keep going
> on ? (y/N/a)

That's normal, the looping detection threshold is very low.  Most people
hit 'a' here.  It doesn't affect correctness of output.  It only prevents
getting stuck in infinite loops when trying to locate the metadata page
for the next extent in the file.

> When I checked this file I see that it's corrupted. Basically I want
> restore only files with valid checksums and then have a list of
> corrupted files. From currupted files there are few I want to see if
> they can be recovered. I have lot of of snapshots but even the oldest
> ones are corrupted in exactly same way - they're identical. It seems I
> need to find previous copy of this file if it exsists at all... Any
> idea how to find previous version of file?

If they were snapshots then the files share physical storage, i.e. there
are not two distinct versions of the shared content, they are two
references to the same content, and corruption in one will appear in
the other.

> I tried
> $ btrfs restore -u 2 -t 21056933724160
> with different superblocks/tree roots but they all give same corrupted file.
> The file looks like this
> $ hexdump -C file | head -n 5
> 00000000  27 47 10 00 6d 64 61 74  7b 7b 7b 7b 7b 7b 7b 7b  |'G..mdat{{{{{{{{|
> 00000010  7a 7a 79 79 7a 7a 7a 7a  7b 7b 7b 7c 7c 7c 7b 7b  |zzyyzzzz{{{|||{{|
> 00000020  7c 7c 7c 7b 7b 7b 7b 7b  7c 7c 7c 7c 7c 7b 7b 7b  ||||{{{{{|||||{{{|
> 00000030  7b 7b 7b 7b 7b 7b 7b 7b  7b 7a 7a 7a 7a 79 79 7a  |{{{{{{{{{zzzzyyz|
> 00000040  7b 7b 7b 7b 7a 7b 7b 7c  7b 7c 7c 7b 7c 7c 7b 7b  |{{{{z{{|{||{||{{|

All tree roots will ultimately point to the same data blocks unless the
file was written in between.  Tree roots share all pages except for the
unique pages that are introduced in the tree root's transaction.

> Those repeated 7a/b/c is wrong data. Also I'm not sure if these files
> have been corrupted now or more in past... So I need to check if
> checksum matches.
> 
> > It might be possible to recover by manually inspecting the corrupted
> > metadata blocks and making guesses and adjustments, but that could take
> > even longer than check --repair if there are thousands of damaged pages.
> >
> 
> I want to look into this but not sure if there are any tools with
> which it would be easy to inspect data. dump-tree is nice but it
> doesn't work when checksum is incorrect.

It also doesn't work if an interior tree page is destroyed.  In that
case, nothing less than --init-extent-tree can find the page--and even
init-extent-tree needs to read a few pages to work.

> My current plan is:
> 1. btrfs restore only valid files, how? I don't want to mix good files
> with corrupted ones together
> 2. look into how exactly extent tree is corrupted
> 3. try to see if few of corrupted files can be recovered in some way
> 4. do btrfs check -b --repair (maybe if extent tree can be fixed then
> wouldn't need to use -b flag)
> 5. try to mount and btrfs scrub
> 6. maybe wipe and recreate new fielsystem
