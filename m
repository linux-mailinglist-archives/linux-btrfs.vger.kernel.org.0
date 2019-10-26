Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B75E5757
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 02:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbfJZACB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 25 Oct 2019 20:02:01 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36904 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbfJZACB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 20:02:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D365C48E443; Fri, 25 Oct 2019 20:01:57 -0400 (EDT)
Date:   Fri, 25 Oct 2019 20:01:57 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
Message-ID: <20191026000157.GA1046@hungrycats.org>
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <20191016194237.GP22121@hungrycats.org>
 <067d06fc-4148-b56f-e6b4-238c6b805c11@liland.com>
 <20191021193417.GP24379@hungrycats.org>
 <81f11e36-fd40-967c-74e8-f5c29803dacf@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <81f11e36-fd40-967c-74e8-f5c29803dacf@liland.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 06:32:04PM +0200, Edmund Urbani wrote:
> On 10/21/19 9:34 PM, Zygo Blaxell wrote:
> > On Mon, Oct 21, 2019 at 05:27:54PM +0200, Edmund Urbani wrote:
> >> On 10/16/19 9:42 PM, Zygo Blaxell wrote:
> >>> For raid5 I'd choose btrfs -draid5 -mraid1 over mdadm raid5
> >>> sometimes--even with the write hole, I'd expect smaller average data
> >>> losses than mdadm raid5 + write hole mitigation due to the way disk
> >>> failure modes are distributed.  
> >> What about the write hole and RAID-1? I understand the write hole is most
> >> commonly associated with RAID-5, but it is also a problem with other RAID levels.
> > Filesystem tree updates are atomic on btrfs.  Everything persistent on
> > btrfs is part of a committed tree.  The current writes in progress are
> > initially stored in an uncommitted tree, which consists of blocks that
> > are isolated from any committed tree block.  The algorithm relies on
> > two things:
> >
> > 	Isolation:  every write to any uncommitted data block must not
> > 	affect the correctness of any data in any committed data block.
> >
> > 	Ordering:  a commit completes all uncommitted tree updates on
> > 	all disks in any order, then updates superblocks to point to the
> > 	updated tree roots.  A barrier is used to separate these phases
> > 	of updates across disks.
> >
> > Isolation and ordering make each transaction atomic.  If either
> > requirement is not implemented correctly, data or metadata may be
> > corrupted.  If metadata is corrupted, the filesystem can be destroyed.
> 
> Ok, the ordering enforced with the barrier ensures that all uncommitted data is
> persisted before the superblocks are updated. But eg. a power loss could still
> cause the superblock to be updated on only 1 of 2 RAID-1 drives. But I assume
> that is not an issue because mismatching superblocks can be easily detected
> (automatically fixed?) on mount. Otherwise you could still end up with 2 RAID-1
> disks that seem consistent in and of themselves but that hold a different state
> (until the superblocks are overwritten on both). 

During the entire time interval between the first and last superblock
update, both the old and new filesystem tree roots are already completely
written to on all disks.  Either is the correct state of the filesystem.
fsync() and similar functions only require that the function not return
to userspace until after the new state is persisted--they don't specify
what happens if the power fails before fsync() returns.  In btrfs,
metadata trees will be fully updated or fully rolled back.

If an array is fully online before and after a power failure, the worst
possible superblock inconsistency is that some superblocks point to the
tree root for commit N and the others point to N+1 (there's a very small
window this, superblocks are almost always consistent).  If N is chosen
during mount, transaction N+1 is overwritten by a new transaction N+1
after the filesystem is mounted.  If N+1 is chosen during mount then
the filesystem simply proceeds to transaction N+2.

If you split a RAID1 pair after a power failure and mount each mirror
drive on two separate machines, you could see different filesystem
contents on the two machines.  One disk may present the contents
for transid N, the other N+1.  It is not a good idea to recombine the
disks if the separated mirrors are both mounted read-write.  Both disks
will contain data that passes transid and csum consistency checks, but
reflect the contents of different transaction histories.  Choose one
disk to keep, and wipe the other before reinserting it into the array.
mdadm does this better--there are event counts and timestamps that can
more reliably reject inconsistent disks.

> > The isolation failure affects only parity blocks.  You could kill
> > power all day long and not lose any committed data on any btrfs raid
> > profile--as long as none of the disks fail and each disk's firmware
> > implements write barriers correctly or write cache is disabled (sadly,
> > even in 2019, a few drive models still don't have working barriers).
> > btrfs on raid5/6 is as robust as raid0 if you ignore the parity blocks.
> I hope my WD Reds implement write barriers correctly. Does anyone know for certain?

Some WD Red and Green models definitely do not have correct write barrier
behavior.  Some WD Black models are OK until they have bad sectors,
then during sector reallocation events they discard the contents of the
write cache, corrupting the filesystem.

This seems to affect older models more than newer ones, but drives with
bad firmware can sit in sales channels for years before they reach end
consumers.  Also when a drive is failing its write caching correctness may
change, turning a trivially repairable bad sector event into irreparable
filesystem loss for single-disk filesystems.

When in doubt, disable write cache (hdparm -W0) at boot and after any
SATA bus reset (bus resets revert to the default and re-enable the
write cache).

> 
> 
> 
> -- 
> *Liland IT GmbH*
> 
> 
> Ferlach ● Wien ● München
> Tel: +43 463 220111
> Tel: +49 89 
> 458 15 940
> office@Liland.com
> https://Liland.com <https://Liland.com> 
> 
> 
> 
> Copyright © 2019 Liland IT GmbH 
> 
> Diese Mail enthaelt vertrauliche und/oder 
> rechtlich geschuetzte Informationen. 
> Wenn Sie nicht der richtige Adressat 
> sind oder diese Email irrtuemlich erhalten haben, informieren Sie bitte 
> sofort den Absender und vernichten Sie diese Mail. Das unerlaubte Kopieren 
> sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet. 
> 
> This 
> email may contain confidential and/or privileged information. 
> If you are 
> not the intended recipient (or have received this email in error) please 
> notify the sender immediately and destroy this email. Any unauthorised 
> copying, disclosure or distribution of the material in this email is 
> strictly forbidden.
> 
> 
