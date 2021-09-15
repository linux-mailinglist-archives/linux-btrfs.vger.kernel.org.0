Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8708B40CC5D
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhIOSMK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 14:12:10 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36804 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOSMK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 14:12:10 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 5922EB7B491; Wed, 15 Sep 2021 14:10:34 -0400 (EDT)
Date:   Wed, 15 Sep 2021 14:10:34 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Sam Edwards <cfsworks@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
Message-ID: <20210915181021.GN29026@hungrycats.org>
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com>
 <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <20210911042414.GJ29026@hungrycats.org>
 <CAH5Ym4jNgs1iJufbmCDOS6N=k+YH4nZTSQ7j-MrM3mp8M0Yn2g@mail.gmail.com>
 <20210911165634.GK29026@hungrycats.org>
 <CAH5Ym4isja5hs73ibcACH5cm00=F43cG+m_sNtFjkJ_oRZJT1g@mail.gmail.com>
 <20210912230719.GL29026@hungrycats.org>
 <CAH5Ym4jUf9jz1OOSn=QuAqMe936ub+Rde=RhTQGRJKx4VA2XPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4jUf9jz1OOSn=QuAqMe936ub+Rde=RhTQGRJKx4VA2XPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 14, 2021 at 05:58:58PM -0600, Sam Edwards wrote:
> On Sun, Sep 12, 2021 at 5:07 PM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > There is less than 256MB distance from the first to the last, but they
> > occupy two separate 256MB-aligned regions (f800000000 and f810000000).
> > If there is dup metadata then these blocks occupy four separate 256MB
> > regions, as there is some space between duplicate regions (in logical
> > address space).
> 
> Okay, I see. You were looking at alignment, not range. I didn't think
> you were trying to determine LBA alignment because you were working
> from offsets within the LUKS space, without the benefit of the
> LUKS+partition offsets. (Adding in those offsets doesn't change the
> alignment situation much, by the way.)

Alignment is mostly meaningless anyway.  I've been looking for some
evidence to support the alignment theory, but nothing fits as well as
the more common and boring write-drop failure modes.

> Oh, for what it's worth: I don't think there was dup metadata. I
> didn't pass any flags to mkfs.btrfs when I built the filesystem (so it
> should have used the SSD default of single), and when I was (manually,
> scanning the LUKS volume) looking for duplicate metadata blocks to
> test my misdirected writes guess, I didn't find any two blocks with
> the same bytenr. I still have the filesystem image in case there's any
> doubt. But it also may not be pertinent at this point.

It appears I guessed wrong here.  In dmesg logs you can count the
number of metadata mirrors by counting repeated failure messages, as
the filesystem will try to read each mirror once before giving up and
emitting a different message.  This trick doesn't work with btrfs check
output, apparently.

> > 256MB is far too large for a plausible erase block size, 1GB is even
> > less likely.
> 
> Agreed - orders of magnitude too large, if you ask me. But I'm also
> not discounting the possibility that the erase block size is big
> enough to cover 256MiB worth of (SSD, not btrfs) metadata.
> 
> > That's not how write caches work--they are not giant FIFO queues.
> 
> Oh no, I think I didn't make myself clear. I wasn't suggesting
> anything to do with the order of the write operations, nor trying to
> indicate that I was confused about what I was seeing.
> 
> I feel bad now; you provided a good explanation of this stuff, and I
> appreciate the time taken to type all of that out, but I also didn't
> benefit from the explanation as I'm nowhere near as green to memory
> consistency as I am to btrfs internals. (Maybe someone reading this
> email thread in the future will find this info useful?)

I figure it's better to send more information than needed rather than
less, in case I'm misunderstanding something.  Whenever two experts talk,
each knows 90% of what the other knows, but not _which_ 90%, so most of
the exchange is figuring out which 10% isn't common knowledge.

Worst case, it might end up in a google search and help out a random
user some day.

> Hopefully I can rephrase what I was saying more clearly:
> During the incident, there was some x% chance of writes not taking
> effect. (And since there are a few metadata checksum errors indicating
> torn writes, I think I can safely say that x<100. Probably by a wide
> margin, given there are only 9000 unique error items, which is much
> less than your expectation of 60K.)
> The part that first caught my eye was that, for writes *not* to chunk
> 1065173909504, x=0. i.e. the probability of loss was conditional on
> LBA. Note that I am only using the chunk as a spatial grouping, not
> saying that the chunk itself is to blame.

I attach more or less zero significance to the LBA pattern.  Previously I
was thinking "is there some way a drive could generate this pattern?", but
a much easier question is "would btrfs ever generate any other pattern?"

btrfs uses a first-fit allocator for metadata.  Only huge transactions
(like balance or snapshot delete) span more than a few hundred MB.
btrfs only spreads out metadata writes if free space fragmentation forces
it to search over long distances to find a free block.  The normal case
is everything is contiguous or nearly contiguous within a transaction.
btrfs can move metadata anywhere on the disk to make metadata writes
contiguous, so it does exactly that to speed up metadata writes (it was
also handy for ZBD device support, though it turned out btrfs wasn't
writing quite 100% sequentially so some fixes had to be done).

> What then made me find this interesting (a better word is, perhaps,
> "distinctive"), was that the pattern of writes lost during
> transactions 66552, 66591, 66655, and 66684 all followed these very
> same statistics.

If we look at the block numbers and transactions from parent transid
verify failures, we get:

	block(hex)..end(hex)   transid

	f80ad70000..f80ad74000 66552 
	f80ad74000..f80ad78000 66552 contiguous with previous block
	f80c11c000..f80c120000 66552 
	f80c6dc000..f80c6e0000 66552 
	f80c6e8000..f80c6ec000 66552 
	f80c704000..f80c708000 66552 

	f80dd04000..f80dd08000 66591 
	f80e320000..f80e324000 66591 
	f80e3a4000..f80e3a8000 66591 
	f80e3cc000..f80e3d0000 66591 

	f8167c8000..f8167cc000 66655 
	f8167e0000..f8167e4000 66655 

	f818a68000..f818a6c000 66684 
	f818a6c000..f818a70000 66684 contig
	f818a70000..f818a74000 66684 contig
	f818a74000..f818a78000 66684 contig
	f818a7c000..f818a80000 66684 
	f818a80000..f818a84000 66684 contig
	f818a84000..f818a88000 66684 contig
	f818a8c000..f818a90000 66684 

Note that the write losses detected in each transaction are very close
together, contiguous in some cases, separated by only a few blocks
in others.  No transactions overlap.  Transactions appear in ascending
LBA order, as the allocator would allocate them (eventually it will go
back to reuse smaller values, but some data has to be deleted first).

transid 66684 is almost completely contiguous, except for only two blocks
(and we might only be missing those because the blocks that refer to
them are also lost).  Depending on request length and io merges, that
could be a _single_ dropped write command.  In any event it is not more
than 3 writes with merging, 8 without.

This is utterly normal when the lower layers drop writes.
In the power-fail case, there would be only one failed
transaction or a contiguous range of transaction numbers.  In the
drop-writes-but-stay-online cases, there will be dropped writes from
multiple transactions with successfully completed transactions between
them.

I think all this tells us is that the drive lost writes (however caused)
on at least 4 distinct occasions, and btrfs's forced-read-only was not
triggered until after the 4th one (either a 5th failure was detected
but the transaction was aborted so the 5th error was not persisted, or
btrfs reread old data and detected one of the previous 4 after the fact).

> That eliminates a whole class of bugs (because certain cache
> replacement policies and/or data structures cannot follow this
> pattern, so if the SSD uses one of those for its write cache, it means
> the culprit can't be the write cache) while making others more likely
> (e.g. if the SSD is not respecting flush and the write cache is
> keeping pages in a hash table bucketed by the first N bits of LBA,
> then this could easily be a failure of the write cache's hash table).
> 
> And if nothing else, it gives us a way to recognize this particular
> problem, in case someone else shows up with similar errors.

So far it looks like the aftermath of every other storage stack with
a write dropping issue between btrfs and the drive.  It's not an uncommon
problem, and I don't see anything unusual or unexplained in the check log.

The main distinguishing feature is the correlation with kernel version
5.14 and the other hangs and issues you were experiencing at the
same time.  Those facts are significant, and point to problems that
should equally affect any other filesystem with that combination of
kernel and hardware (though most other filesystems will require you to
run applications with robust data error detection built into them to be
able to detect the corruption).  If you run btrfs on a setup like that,
it will complain loudly and quickly.  All the integrity checking in btrfs
is there to detect precisely that type of silent storage stack failure,
and it seems to be working.

It's possible that there are two simultaneously occurring problems here:

	1.  the drive does drop writes from its cache on reset or error
	(which includes power failure, but also PCI bus reset and medium
	errors), and

	2.  Linux 5.14 is issuing a lot more bus resets than it should
	be, i.e. more than the one at boot.

Either one individually wouldn't cause data loss while the system is
otherwise running normally, but the combination causes data loss.

Problem 1 can often be worked around with hdparm -W0 (or "nvme set-feature
-f 6 -v 0") to disable write cache.  I've used it both to avoid power
failure losses and also UNC/bus reset losses on drives that have no
bad power failure behavior.  If that works, it provides data corruption
immunity for problem 2:  the resets cause no undetected write losses
because there are never writes that have been ACKed but not committed.

There are a lot of fault recovery paths that lead to the "disable the
write cache" action.  It's not just for power failures.

> > That often happens to drives as they fail.  Firmware reboots due to a
> > bug in error handling code or hardware fault, and doesn't remember what
> > was in its write cache.
> >
> > Also if there is a transport failure and the host resets the bus, the
> > drive firmware might have its write cache forcibly erased before being
> > able to write it.  The spec says that doesn't happen, but some vendors
> > are demonstrably unable to follow spec.
> 
> If the problem is in the command queue block, then the writes are
> being lost before the write cache is even involved.

If the command is lost while still in the queue, Linux should notice
it by command timeout if nothing else, and if Linux notices it, btrfs
will notice it and (assuming no bugs today) abort the transaction.

If the command is no longer in the queue (i.e. Linux received an ACK),
but its data is not yet persistent on storage media, it's in "write cache"
(or some equivalent nonpersistent storage block at the same point in the
storage stack where a write cache would be).  There might be multiple
components in the implementation, but from outside the disk we don't
see their effects separately.

> > That's an SSD-specific restatement of #1 (failure to persist data before
> > reporting successfully completed write to the host, and returning previous
> > versions of data on later reads of the same address).
> 
> But then here the writes are being lost *after* the write cache is
> involved. In case #1, I could just opt out of the write cache to get
> my SSD working reliably again, but I can't opt out of LBA remapping
> since it's required for the longevity of the drive.

That's true, but the write cache "off" switch might also change the
drive's LBA map update strategy at the same time, so it ends up being a
successful workaround anyway.  i.e. the firmware has multiple components
in play, but also multiple components change behavior in lockstep with
write cache on or off, so they still behave as a unit.

Changing write cache strategy definitely does affect write longevity.
We can see that in SSD model families where the "enterprise" version has
full power interrupt protection (every ACKed write committed) and the
"consumer" does not (strictly FIFO write cache without reordering,
but last N writes dropped on power failure) but neither model has
hold-up capacitors (so they're not relying on keeping a RAM cache alive
during commit).  The "enterprise" drive wear happens 2x faster than the
"consumer" drive despite the consumer drive having half the rated TBW
at the same capacity.  The "enterprise" drive is hitting the flash 4x
harder to implement its stronger persistence guarantees.

> > SSDs don't necessarily erase old blocks immediately--a large, empty or
> > frequently discarded SSD might not erase old blocks for months.
> 
> The blocks weren't erased even after a few days of analysis. But case
> #3 is really unlikely either way, because LBA mapper bugs should take
> a *bunch* of stuff down with them.

...or the drive silently works around them.  e.g. an empty page with
bits set on it might be interpreted as a media failure, and the drive
does some recovery action like map different flash, or it normally erases
the block at the start of the write operation without checking.

This is of course assuming the vendor bothered to implement basic error
checking procedures at all--some vendors demonstrably do not, and the
first and last indication of hardware failure is the errors from btrfs.

For almost every possible assumption or expectation of SSD firmware
behavior, there exists an implementation of the opposite behavior in
the field.  ;)

> > All of the above fit into the general category of "drive drops some
> > writes, out of order, when some triggering failure occurs."
> 
> Yep -- although I would include the nearby LBAs condition in the
> symptoms list. That's statistically significant, especially for SSD!
> :)
> 
> > If you have
> > access to the drive's firmware on github, you could check out the code,
> > determine which bug is occurring, and send a pull request with the fix.
> > If you don't, usually the practical solution is to choose a different
> > drive vendor, unless you're ordering enough units to cause drive
> > manufacturer shareholders to panic when you stop.
> 
> Oh man, there's sometimes drive firmware on GitHub?! I would be
> pleasantly surprised to find my SSD's firmware there. Alas, a cursory
> search suggests it isn't.

Yeah, no, that never happens in real life.  It's frequently suggested
as a way to solve chronic firmware quality problems in the storage
industry, though...usually by industry outsiders.

> I didn't choose the drive; it's a whitelabel OEM unit. If I can't get
> in touch with the vendor "officially" (which I probably can't), I'll
> try getting the attention of the employee/contractor responsible for
> maintaining the firmware. I've had moderate success with that in the
> past. That's a large part of my motivation for nailing down exactly
> *what* in the SSD is misbehaving (if indeed the SSD is misbehaving),
> to maximize my chances that such a bug report is deemed "worth their
> time." :)
> 
> > Yeah, if something horrible happened in the Linux 5.14 baremetal NVME
> > hardware drivers or PCIe subsystem in general, then it could produce
> > symptoms like these.  It wouldn't be the first time a regression in
> > other parts of Linux was detected by a flood of btrfs errors.
> >
> > Device resets might trigger write cache losses and then all the above
> > "firmware" symptoms (but the firmware is not at fault, it is getting
> > disrupted by the host) (unless you are a stickler for the letter of the
> > spec that says write cache must be immune to host action).
> 
> On the other hand, a problem that surfaces only with a new version of
> Linux isn't _necessarily_ a regression in Linux. My working hypothesis
> currently is that there's a corner-case in the SSD firmware, where
> certain (perfectly cromulent) sequences of NVMe commands would trigger
> this bug, and the reason it has never been detected in testing is that
> the first NVMe driver in the world to hit the corner-case is the
> version shipped in Linux 5.14, after the SSD was released. That'd be a
> nice outcome since Linux can spare other users a similar fate with the
> addition of a device quirk that avoids the corner-case.

That certainly does happen.  Linux steps on more than a few bugs where
the SSD vendor finally has to admit they didn't do more testing on Linux
than "run the Fedora installer with default options," and they didn't
catch bugs that brick the drive.  Vendors are pretty good at testing
compatibility with Windows though, so only Linux users are affected by
the bugs most of the time.

> But I haven't ruled out what you've said about a full-blown Linux
> regression, or even just a problem that happens every few weeks (due
> to some internal counter in the SSD overflowing, perhaps -- the
> problem did manifest awfully soon after the 2^16th transaction, after
> all). All possibilities remain open. :)

That's a _really_ tenuous connection.  How could it work?  The drive
counts flush commands?  Creating partitions and LVs and LUKS formatting
when setting up the drive will use some of those, so if anything, it
should fail long before transaction 65536.  Also there are at least
two flushes per transaction (one for everything that isn't superblock,
one for the superblocks) so 16-bit overflow should be near transid 32768
(unless it's a signed int16...).  Anyone who runs a database on such a
drive would hit the rollover before loading up a schema much less the
data inside it.

That said...I did notice how close the transids were to 65536...
Cool theory!  Alas, not supported by evidence.  ;)

> > Linux 5.14 btrfs on VMs seems OK.  I run tests continuously on new Linux
> > kernels to detect btrfs and lvm regressions early, and nothing like this
> > has happened on my humble fleet.  My test coverage is limited--it
> > won't detect a baremetal NVME transport issue, as that's handled by the
> > host kernel not the VM guest.
> 
> I wonder if there'd be some value in setting up PCIe passthrough
> straight into the VM for some/all of your NVMe devices? Does your VM
> host have an IOMMU to allow that? Any interest in me donating to you
> my SSD (which is M.2) if I decide to replace it?

The test VMs aren't using passthrough so that any storage hardware
failures can be cleanly identified by the host kernel separately from
btrfs issues in the guest kernel (the test workload does kill a disk
from time to time).  They're also obsolete hardware (anything current
is running production workloads instead) so problems with PCIe 4.0 won't
show up even with passthrough.

I test a lot of drives with _unknown_ issues to identify which drives
to buy (or not buy) more of.  95% of drive models work, so the easiest
and most reliable way to work around a bad model is to choose another
model at random.  It works 99.75% of the time, assuming the problem is
the drive model/firmware, and not something else in the system.

It would be better to donate a drive with known issues to someone
maintaining NVME or PCIe or whatever subsystem is actually failing
here--assuming your specific drive is a healthy specimen of that drive
model.  If the drive is simply a failing instance of that model then
it's best to return it to the vendor--all hardware fails eventually,
and a failed drive is only informative to its manufacturer.

> > Sound methodology.
> > > Wish me luck,
> > Good luck!
> 
> Thank you! And: start the clock. I've erased+rebuilt the filesystem
> today and am continuing to use it as I was before. I'll be making a
> second attempt at installing those package updates later as well.

Exactly as before, including single metadata?  Using dup metadata might
provide some useful extra information (we'd know if the problem affects
both copies or just one, and you're using luks so drive-side dedupe is
not possible and therefore not a confounding factor).  Though if you
have a storage stack that can trash 4 transactions before btrfs notices
the problem, then dup metadata won't save it.

> If there are any other questions, I'll happily answer. Otherwise I
> won't be following up unless/until I encounter more instances of this
> bug. So, to anyone reading this list archive well in the future: if
> this is the last message from me, it means the problem was one-off.
> Sorry.
> 
> Signing off,
> Sam
> 
