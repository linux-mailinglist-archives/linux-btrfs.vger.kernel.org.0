Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC1DF616
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 21:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfJUTeb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 21 Oct 2019 15:34:31 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:37302 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJUTeb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 15:34:31 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id B42C448432C; Mon, 21 Oct 2019 15:34:29 -0400 (EDT)
Date:   Mon, 21 Oct 2019 15:34:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
Message-ID: <20191021193417.GP24379@hungrycats.org>
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <20191016194237.GP22121@hungrycats.org>
 <067d06fc-4148-b56f-e6b4-238c6b805c11@liland.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <067d06fc-4148-b56f-e6b4-238c6b805c11@liland.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 21, 2019 at 05:27:54PM +0200, Edmund Urbani wrote:
> On 10/16/19 9:42 PM, Zygo Blaxell wrote:
> >
> > For raid5 I'd choose btrfs -draid5 -mraid1 over mdadm raid5
> > sometimes--even with the write hole, I'd expect smaller average data
> > losses than mdadm raid5 + write hole mitigation due to the way disk
> > failure modes are distributed.  
> 
> What about the write hole and RAID-1? I understand the write hole is most
> commonly associated with RAID-5, but it is also a problem with other RAID levels.

Filesystem tree updates are atomic on btrfs.  Everything persistent on
btrfs is part of a committed tree.  The current writes in progress are
initially stored in an uncommitted tree, which consists of blocks that
are isolated from any committed tree block.  The algorithm relies on
two things:

	Isolation:  every write to any uncommitted data block must not
	affect the correctness of any data in any committed data block.

	Ordering:  a commit completes all uncommitted tree updates on
	all disks in any order, then updates superblocks to point to the
	updated tree roots.  A barrier is used to separate these phases
	of updates across disks.

Isolation and ordering make each transaction atomic.  If either
requirement is not implemented correctly, data or metadata may be
corrupted.  If metadata is corrupted, the filesystem can be destroyed.

Transactions close write holes in all btrfs RAID profiles except 5
and 6.  mdadm RAID levels 0, 1, 10, and linear have isolation properties
sufficient for btrfs.  mdadm RAID 4/5/6 work only if the mdadm write hole
mitigation feature is enabled to provide isolation.  All mdadm and btrfs
RAID profiles provide sufficient ordering.

The problem on mdadm/btrfs raid5/6 is that committed data blocks are not
fully isolated from uncommitted data blocks when they share a parity block
in the RAID5/6 layer (wherever that layer is).  This is why the problem
only affects raid5/6 on btrfs (and why it also applies to mdadm raid5/6).
In this case, writing to any single block within a stripe makes the parity
block inconsistent with previously committed data blocks.  This violates
the isolation requirement for CoW transactions: a committed data block
is related to uncommitted data blocks in the same stripe through the
parity block and the RAID5/6 data/parity equation.

The isolation failure affects only parity blocks.  You could kill
power all day long and not lose any committed data on any btrfs raid
profile--as long as none of the disks fail and each disk's firmware
implements write barriers correctly or write cache is disabled (sadly,
even in 2019, a few drive models still don't have working barriers).
btrfs on raid5/6 is as robust as raid0 if you ignore the parity blocks.

> You would need to scrub after a power failure to be sure that no meta data gets
> corrupted even with RAID-1. Otherwise you might still have inconsistent copies
> and the problem may only become apparent when one drive fails. 

There are no inconsistencies expected with RAID1 unless the hardware is
already failing (or there's a software/firmware bug).

Scrub after power failure is required only if raid5/6 is used.
All committed data and metadata blocks will be consistent on all
RAID profiles--even in raid5/6, only parity blocks are inconsistent.
Uncommitted data returns to free space when the filesystem is mounted,
so the the consistency of uncommitted data blocks doesn't matter.

Parity block updates are not handled by the btrfs transaction update
mechanism.  The scrub after power failure is required specifically
to repair inconsistent parity blocks.  This should happen as soon as
possible after a crash, while all the data blocks are still readable.

> Can we be certain that scrubbing is always able to fix such
> inconsistencies...

Scrub can reliably repair raid5/6 parity blocks assuming all data blocks
are still correct and readable.

> ...with RAID-1?

We cannot be certain that scrub fixes inconsistencies in the general case.
If the hardware is failing, scrub relies on crc32c to detect missing
writes.  Error detection and repair is highly likely, but not certain.

Collisions between old/bad data crc32c and correct data crc32c are
not detected.  nodatasum files (which have no csums) are corrupted.
Metadata has a greater chance of successful error detection because more
fields in metadata are checked than just CRC.

If all the errors are confined to a single drive, device 'replace' is more
appropriate than 'scrub'; however, it can be hard to determine if errors
are confined to a single disk without running 'scrub' first to find out.

> Regards,
>  Edmund
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
