Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058AC3D4A0A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 23:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGXUeu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 16:34:50 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:41718 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXUeu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 16:34:50 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B23CAAFE3FE; Sat, 24 Jul 2021 17:15:20 -0400 (EDT)
Date:   Sat, 24 Jul 2021 17:15:20 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Forza <forza@tnonline.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>, waxhead <waxhead@dirtcellar.net>,
        dsterba@suse.cz, Roman Mamedov <rm@romanrm.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: allow degenerate raid0/raid10
Message-ID: <20210724211520.GD10170@hungrycats.org>
References: <20210722192955.18709-1-dsterba@suse.com>
 <db9e2f31-73a5-0d0d-a1da-7acde6fb118e@gmx.com>
 <20210723140843.GE19710@twin.jikos.cz>
 <20210723222730.1d23f9b4@natsu>
 <20210723192145.GF19710@suse.cz>
 <18a1bdd5-321e-68d3-517f-84c8d9bacb9c@dirtcellar.net>
 <20210724123050.GD992@savella.carfax.org.uk>
 <7cdf230d-8b0d-03e0-9b32-57bead264870@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdf230d-8b0d-03e0-9b32-57bead264870@tnonline.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 24, 2021 at 03:54:18PM +0200, Forza wrote:
> 
> 
> On 2021-07-24 14:30, Hugo Mills wrote:
> > On Sat, Jul 24, 2021 at 01:04:19PM +0200, waxhead wrote:
> > > David Sterba wrote:
> > > 
> > > > Maybe it's still too new so nobody is used to it and we've always had
> > > > problems with the raid naming scheme anyway.
> > > 
> > > Perhaps slightly off topic , but I see constantly that people do not
> > > understand how BTRFS "RAID" implementation works. They tend to confuse it
> > > with regular RAID and get angry because they run into "issues" simply
> > > because they do not understand the differences.
> > > 
> > > I have been an enthusiastic BTRFS user for years, and I actually caught
> > > myself incorrectly explaining how regular RAID works to a guy a while ago.
> > > This happened simply because my mind was so used to how BTRFS uses this
> > > terminology that I did not think about it.
> > > 
> > > As BTRFS is getting used more and more it may be increasingly difficult (if
> > > not impossible) to get rid of the "RAID" terminology, but in my opinion also
> > > increasingly more important as well.
> > > 
> > > Some years ago (2018) there was some talk about a new naming scheme
> > > https://marc.info/?l=linux-btrfs&m=136286324417767
> > > 
> > > While technically spot on I found Hugo's naming scheme difficult. It was
> > > based on this idea:
> > > numCOPIESnumSTRIPESnumPARITY
> > > 
> > > 1CmS1P = Raid5 or 1 copy, max stripes, 1 parity.
> > > 
> > > I also do not agree with the use of 'copy'. The Oxford dictionary defines
> > > 'copy' as "a thing that is made to be the same as something else, especially
> > > a document or a work of art"

> > > And while some might argue that copying something on disk from memory makes
> > > it a copy, it ceases to be a copy once the memory contents is erased. 

That last sentence doesn't make sense.  A copy does not cease to be a
copy because the original (or some upstream copy) was destroyed.

I think the usage of "copy" is fine, and also better than the alternatives
proposed so far.  "copy" is shorter than "mirror", "replica", or
"instance", and "copy" or its abbreviation "c" already appears in various
btrfs documents, code, and symbolic names.

Most users on IRC understand "raid1 stores 2 copies of the data" as
an explanation, more successfully than "2 mirrors" or "2 replicas"
which usually require clarification.  As far as I can tell, "instances"
has never been used to describe btrfs profile-level data replication
before today.

"Instance" does have the advantage of being less ambiguous.  The other
words imply the existence of one additional extra thing, an "original"
that has been copied, mirrored, or replicated, which causes off-by-one
errors when people try to understand whether "two mirrors" without context
means 2 or 3 identical instances.  The disadvantage of "instance" is that
it abbreviates to "i", which causes problems when people write "I1" in a
sans-serif font.  We could use "n" instead, though people like to write
"array of N" disks.  Probably all of the letters are bad in some way.
I'll use "n" for now, as none of the non-instance words use that letter.

> > > I therefore think that replicas is a far better terminology.

> > > I earlier suggested Rnum.Snum.Pnum as a naming scheme which I think is far
> > > more readable so if I may dare to be as bold....

Right now the btrfs profile names are all snowflakes:  there is a short
string name, and we have to look up in a table what behavior to expect
when that name is invoked.  This matches the implementation, which uses
a single bit for all of the above names, and indeed does use a lookup
table to get the parameters (though the code also uses far too many 'if'
statements as well).

Here's the list of names adjusted according to comments so far, plus some
corrections (lowercase axis name, 1-based instance count, capitalize
'M', fix the number of stripes, and use correct btrfs profile names):

single  = n1.s1.p0 (1 instance, 1 stripe, no parity)
dup     = n2.s1.p0 (2 instances, 1 stripe, no parity)
raid0   = n1.sM.p0 (1 instance, (1..avail_disks) stripes, no parity)
raid1   = n2.s1.p0 (2 instances, 1 stripe, no parity)
raid1c3 = n3.s1.p0 (3 instances, 1 stripe, no parity)
raid1c4 = n4.s1.p0 (4 instances, 1 stripe, no parity)
raid10  = n1.sM.p0 (2 instances, 2..floor(avail_disks / num_instances) stripes, no parity)
raid5   = n1.sM.p1 (1 instance, 1..(avail_disks - parity) stripes, 1 parity)
raid6   = n1.sM.p2 (1 instance, 1..(avail_disks - parity) stripes, 2 parity)

There are three problems:

1.  Orthogonal naming conventions make it look like we should be able
to derive parameters by analyzing the names (e.g. RAID5 on RAID1 mirror
pairs is "n2.sM.p1", RAID1 of two RAID5 groups is...also "n2.sM.p1"...OK
there are 3 problems), but btrfs implements exactly the 9 profiles above
and nothing else.  We can only use the subset of orthogonal names that
exist in the implementation.

2.  The orthogonal-looking dimensions are not fully independent.
Is "n2.sM.p1" RAID5 of RAID1 mirror pairs, or RAID1 of 2x RAID5 parity
groups?  Arguably that's not so bad since neither exist yet--we could
say it must be the first one, since that's closer to what RAID10 does,
so it would basically be RAID10 with an extra (pair of) parity devices.

3.  Future profiles and even some of the existing profiles do not fit
in the orthogonal dimensions of this naming convention.

All the existing btrfs profiles except dup can be derived from a
formula with these 3 parameters.  2 copies implies min_devs == 2, so
"n2.s1.p0" is raid1, not dup.  There's no way to specify dup with the
3 parameters given.  That might not be a problem--we could say "nope,
'dup' does not fit the pattern, so we keep calling that profile 'dup'.
It's a special non-orthogonal case, and users must read the manual
to see exactly what it does."  Note that all forms of overloading the
"s" parameter are equivalent to an exceptional name for dup or a new
orthogonal parameter, because there's no integer we can plug into RAID
layout formulas to get the btrfs dup profile behavior.

RAID-Z from ZFS or the proposed extent-tree-v2 stripe tree would be named
"n1.sM.p1", the same name we have for the existing btrfs raid5 profile,
despite having completely different parity mechanics.  We'd need another
dimension in the profile name to describe how the parity blocks are
managed.  We can't write something like "pZ" or "pM" because we still
need the number of parity blocks.  If we write something like "pz2" or
"pm1" (for raid-z-style 2-parity or stripe-tree 1-parity respectively)
we are still sending the user to the manual to understand what the extra
letter means, and we're not much further ahead.

The window for defining these names seems to have closed about 13
years ago.  Even if we agreed the orthogonal names are better, we'd
have to make "n2.s1.p0" a non-canonical alias of the canonical "raid1"
name so we don't instantly break over a decade of existing tooling,
documentation, and user training.  We'd still have to explain over and
over to new users that "raid1" is "n2.s1.p0" in btrfs, not "nM.s1.p0"
as it is in mdadm raid1.

TL;DR I think this is somewhere between "not a good idea" and "a bad
idea" for naming storage profiles; however, there are some places where
we can still use parts of the proposal.

If the proposal includes _implementing_ an orthogonally parameterized
umbrella raid profile, then the above objection doesn't apply--but to
fit into btrfs with its single-bit-per-profile on-disk schema, all of
the orthogonally named raid profiles would be parameters for one new
btrfs "parameterized raid" profile.  We'd still need to have all the
old profiles with their old names to be compatible with old on-disk
filesystems, even if they were internally implemented by translating to
the parameterized implementation.

What I do like about this proposal is that it is useful as a _reporting_
format, and the reporting tools need help with that.  Right now we have
"RAID10" or "RAID10/6" for "RAID10 over 6 disks".  We could have tools
report "RAID/n2.s3.p0" instead, assuming we fixed all the quirky parts
of btrfs where the specific profile bit matters.  If we don't fix the
quirks, then we still need the full btrfs profile bit name reported,
because we need to be able to distinguish between "single/n1.s1.p0" and
"RAID0/n1.s1.p0" in a few corner cases.

"dup" would still be "dup", though it might have a suffix for the number
of distinct devices that are used for the instances (e.g. "dup/d2"
for instances on 2 devices, vs "dup/d1" for both instances on the same
device).  The suffix doesn't have to fit into the orthogonal naming
convention because the profile can select the parameter space.

If we implement a new btrfs raid profile that doesn't fit the pattern,
we can use the new profile's name as a prefix, e.g. on 5 disks, RAID-Z1
"raidz/n1.s4.p1" is distinguishable from btrfs RAID5 "raid5/n1.s4.p1",
so it's clear how many copies, parity, stripes, and disks there are,
and which parity mechanism is used.

> >     Sorry, I missed a detail here that someone pointed out on IRC.
> > 
> >     "r0" makes no sense to me, as that says there's no data. I would
> > argue strongly to add one to all of your r values. (Note that
> > "RAID1c2" isn't one of the current btrfs RAID levels, and by extension
> > from the others, it's equivalent to the current RAID1, and we have
> > RAID1c4 which is four complete instances of any item of data).
> > 
> >     My proposal counted *instances* of the data, not the redundancy.
> > 
> >     Hugo.
> > 
> 
> I think Hugu is right that the terminology of "instance"[1] is easier to
> understand than copies or replicas.
> 
> Example:
> "single" would be 1 instance
> "dup" would be 2 instances
> "raid1" would be 2 instances, 1 stripe, 0 parity
> "raid1c3" would be 3 instances, 1 stripe, 0 parity
> "raid1c4" would be 4 instances, 1 stripe, 0 parity
> ... and so on.
> 
> Shortened we could then use i<num>.s<num>.p<num> for Instances, Stripes and
> Parities.
> 
> Do we need a specific term for level of "redundancy"? In the current
> suggestions we can have redundancy either because of parity or of multiple
> instances. Perhaps the output of btrfs-progs could mention redundancy level
> such as this:
> 
> # btrfs fi us /mnt/btrfs/ -T
> Overall:
>     Device size:                  18.18TiB
>     Device allocated:             11.24TiB
>     Device unallocated:            6.93TiB
>     Device missing:                  0.00B
>     Used:                         11.21TiB
>     Free (estimated):              6.97TiB      (min: 3.50TiB)
>     Free (statfs, df):             6.97TiB
>     Data ratio:                       1.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
>     Multiple profiles:                  no
> 
>              Data     Metadata System
> Mode:        i1,s0,p0 i2,s0,p0 i2,s0,p0
> Redundancy:  0        1        1
> ------------ -------- -------- -------- -----------
> Id Path                                 Unallocated
> -- --------- -------- -------- -------- -----------
>  3 /dev/sdb2  5.61TiB 17.00GiB 32.00MiB     3.47TiB
>  4 /dev/sdd2  5.60TiB 17.00GiB 32.00MiB     3.47TiB
> -- --------- -------- -------- -------- -----------
>    Total     11.21TiB 17.00GiB 32.00MiB     6.94TiB
>    Used      11.18TiB 15.76GiB  1.31MiB
> 
> 
> 
> 
> Thanks
> ~Forza
> 
> 
> 
> [1] https://www.techopedia.com/definition/16325/instance
