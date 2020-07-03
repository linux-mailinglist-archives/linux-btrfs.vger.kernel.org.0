Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654D2137D8
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jul 2020 11:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgGCJn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jul 2020 05:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33398 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgGCJn3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jul 2020 05:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56D23AECB;
        Fri,  3 Jul 2020 09:43:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7E69DDA87C; Fri,  3 Jul 2020 11:43:10 +0200 (CEST)
Date:   Fri, 3 Jul 2020 11:43:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, waxhead@dirtcellar.net,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][RFC] btrfs: introduce rescue=onlyfs
Message-ID: <20200703094310.GW27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>, waxhead@dirtcellar.net,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200701144438.7613-1-josef@toxicpanda.com>
 <4adbc15c-d8ff-6132-5044-9b6117ef4f5e@dirtcellar.net>
 <bf383512-71fd-27b1-2e45-b8a0c8e2ba3f@toxicpanda.com>
 <20200702033016.GA10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200702033016.GA10769@hungrycats.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 01, 2020 at 11:30:17PM -0400, Zygo Blaxell wrote:
> On Wed, Jul 01, 2020 at 03:53:40PM -0400, Josef Bacik wrote:
> > On 7/1/20 3:43 PM, waxhead wrote:
> > > Josef Bacik wrote:
> > > > One of the things that came up consistently in talking with Fedora about
> > > > switching to btrfs as default is that btrfs is particularly vulnerable
> > > > to metadata corruption.  If any of the core global roots are corrupted,
> > > > the fs is unmountable and fsck can't usually do anything for you without
> > > > some special options.
> > > > 
> > > > Qu addressed this sort of with rescue=skipbg, but that's poorly named as
> > > > what it really does is just allow you to operate without an extent root.
> > > > However there are a lot of other roots, and I'd rather not have to do
> > > > 
> > > > mount -o rescue=skipbg,rescue=nocsum,rescue=nofreespacetree,rescue=blah
> > > > 
> > > > Instead take his original idea and modify it so it just works for
> > > > everything.  Turn it into rescue=onlyfs, and then any major root we fail
> > > > to read just gets left empty and we carry on.
> > > > 
> > > > Obviously if the fs roots are screwed then the user is in trouble, but
> > > > otherwise this makes it much easier to pull stuff off the disk without
> > > > needing our special rescue tools.  I tested this with my TEST_DEV that
> > > > had a bunch of data on it by corrupting the csum tree and then reading
> > > > files off the disk.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > 
> > > Just an idea inspired from RAID1c3 and RAID1c3, how about introducing
> > > DUP2 and/or even DUP3 making multiple copies of the metadata to increase
> > > the chance to recover metadata on even a single storage device?
> 
> I don't think extra dup copies are very useful.  The disk firmware
> behavior that breaks 2-copy dup will break 3-copy and 4-copy too.
> 
> > Because this only works on HDD.  On SSD's concurrent writes will often be
> > shunted to the same erase block, and if the whole erase block goes, so do
> > all of your copies.  This is why we default to 'single' for SSD's.
> 
> That's true on higher end SSDs that have "data reduction" feature sets
> (compress and dedupe).  In theory these drives could dedupe metadata
> pages even if they are slightly different, so schemes like labelling the
> two dup copies won't work.  A sufficiently broken flash page will wipe
> out both metadata copies, possibly even if you arrange a delay buffer
> to write both copies several minutes apart.
> 
> On low-end SSD, though, there's not only no dedupe, there's also plenty of
> single-bit (or sector) errors that don't destroy both copies of metadata.
> It's one of the reasons why low-end drives have the write endurance of
> mayflies compared to their high-end counterparts--even with the same
> flash technology underneath, the high-end drives do clever things behind
> the scenes, while the low-end drives just write every sector they're told
> to, and the resulting TBW lifespan is very different.  I've had Kingston
> SSDs recover from several single-sector csum failure events in btrfs
> metadata blocks thanks to dup metadata.  Those would have been 'mkfs &
> start over' events had I used default mkfs options with single metadata.
> 
> Dup metadata should be the default on all single-drive filesystems.
> Single metadata should be reserved for extreme performance/robustness
> tradeoffs, like the nobarrier mount option, where the filesystem is not
> intended to survive a crash.  Dup metadata won't affect write endurance
> or robustness on drives that dedupe writes, but it can save a filesystem
> from destruction on drives that don't.
> 
> I think we might want to look into having some kind of delayed write
> buffer to spread out writes to the same disk over a sufficiently long
> period of time to defeat various firmware bugs.  e.g. I had a filesystem
> killed by WD Black (HDD) firmware when it mishandled a UNC sector and
> dropped the write cache during error handling.  If the two metadata copies
> had been written on either side of the UNC error, the filesystem would
> have survived, but since both metadata copies were destroyed by the
> firmware bug, the filesystem was lost.

From all that experience, the model of storage we've been working so far
is insufficient, hardware is unreliable crap and we need to implement
more filesystem features once we know how hardware creatively fails.

The simplified model is that writes are not ordered, disks have caches
that need to be flushed, barriers can be relied on.

The errors that can happen are eg. misdirected writes, lost writes,
bitflips - that should be covered by checksums, storing generation and
location of the data. Enough to catch bad hardware.

With the SSD optimizations it could become an arms race, so far we avoid
dup because of the drive deduplication. As you say it depends on
class/model and we've never had enough information to decide either for
tools or users what exacly one can expect from the device.

If we want to go the way to guess what firmware does, delay writes, move
dup copies apart, that's still working with assumptions and may help on
average. Until the drive firmware gets adapted to that, but I'm not
against implementing the countermeasures for the time being.
