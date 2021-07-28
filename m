Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0543D95F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 21:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhG1TUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 15:20:02 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:38912 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhG1TUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 15:20:01 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 63559B08157; Wed, 28 Jul 2021 15:19:59 -0400 (EDT)
Date:   Wed, 28 Jul 2021 15:19:59 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Dave T <davestechshop@gmail.com>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
Message-ID: <20210728191959.GJ10170@hungrycats.org>
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
 <20210727214049.GH10170@hungrycats.org>
 <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
 <9b64bb41-dcae-8571-0b92-1f0cffc97792@gmail.com>
 <CAGdWbB7vQOA-DvfFzGmPxca23uPd=hzssKO-zvMc4Uy2PpH+UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGdWbB7vQOA-DvfFzGmPxca23uPd=hzssKO-zvMc4Uy2PpH+UA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 28, 2021 at 12:21:43PM -0400, Dave T wrote:
> On Wed, Jul 28, 2021 at 12:11 PM Andrei Borzenkov <arvidjaar@gmail.com> wrote:
> >
> > On 28.07.2021 18:15, Dave T wrote:
> > ...
> > >
> > > Jul 27 21:54:39 server kernel: ata10.00: exception Emask 0x0 SAct
> > > 0xffffffff SErr 0x0 action 0x0
> > > Jul 27 21:54:39 server kernel: ata10.00: irq_stat 0x40000008
> > > Jul 27 21:54:39 server kernel: ata10.00: failed command: READ FPDMA QUEUED
> > > Jul 27 21:54:39 server kernel: ata10.00: cmd
> > > 60/00:90:98:2f:9f/03:00:a4:00:00/40 tag 18 ncq dma 393216 in
> > >                                          res
> > > 41/40:00:20:32:9f/00:03:a4:00:00/00 Emask 0x409 (media error) <F>
> > > Jul 27 21:54:39 server kernel: ata10.00: status: { DRDY ERR }
> > > Jul 27 21:54:39 server kernel: ata10.00: error: { UNC }
> > > Jul 27 21:54:39 server kernel: ata10.00: configured for UDMA/133
> > > Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=3s
> > > Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Sense Key :
> > > Medium Error [current]
> > > Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Add. Sense:
> > > Unrecovered read error - auto reallocate failed
> > > Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 CDB: Read(16)
> > > 88 00 00 00 00 00 a4 9f 2f 98 00 00 03 00 00 00
> > > Jul 27 21:54:39 server kernel: blk_update_request: I/O error, dev sde,
> > > sector 2761896480 op 0x0:(READ) flags 0x0 phys_seg 15 prio class 0
> > > Jul 27 21:54:39 server kernel: ata10: EH complete
> > > Jul 27 21:54:45 server kernel: ata10.00: exception Emask 0x0 SAct
> > > 0x4000000 SErr 0x0 action 0x0
> > > Jul 27 21:54:45 server kernel: ata10.00: irq_stat 0x40000008
> > > Jul 27 21:54:45 server kernel: ata10.00: failed command: READ FPDMA QUEUED
> > > Jul 27 21:54:45 server kernel: ata10.00: cmd
> > > 60/08:d0:20:32:9f/00:00:a4:00:00/40 tag 26 ncq dma 4096 in
> > >                                          res
> > > 41/40:08:20:32:9f/00:00:a4:00:00/00 Emask 0x409 (media error) <F>
> > > Jul 27 21:54:45 server kernel: ata10.00: status: { DRDY ERR }
> > > Jul 27 21:54:45 server kernel: ata10.00: error: { UNC }
> > > Jul 27 21:54:45 server kernel: ata10.00: configured for UDMA/133
> > > Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 FAILED Result:
> > > hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=4s
> > > Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Sense Key :
> > > Medium Error [current]
> > > Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Add. Sense:
> > > Unrecovered read error - auto reallocate failed
> > > Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 CDB: Read(16)
> > > 88 00 00 00 00 00 a4 9f 32 20 00 00 00 08 00 00
> > > Jul 27 21:54:45 server kernel: blk_update_request: I/O error, dev sde,
> > > sector 2761896480 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> > > Jul 27 21:54:45 server kernel: ata10: EH complete
> > > Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> > > at logical 1567691653120 on dev /dev/mapper/userluks, physical
> > > 1414087852032, root 19911, inode 624993, offset 5717954560, length
> > > 4096, links 1 (path: path/to/file/filename.ext)
> > > Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> > > at logical 1567691653120 on dev /dev/mapper/userluks, physical
> > > 1414087852032, root 19989, inode 624993, offset 5717954560, length
> > > 4096, links 1 (path: path/to/file/filename.ext)
> > > Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
> > > at logical 1567691653120 on dev /dev/mapper/userluks, physical
> > > 1414087852032, root 20199, inode 624993, offset 5717954560, length
> > > 4096, links 1 (path: path/to/file/filename.ext)
> > > Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): bdev
> > > /dev/mapper/userluks errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
> > > Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): unable to
> > > fixup (regular) error at logical 1567691653120 on dev
> > > /dev/mapper/userluks
> > > Jul 27 21:55:42 server kernel: BTRFS info (device dm-2): scrub:
> > > finished on devid 1 with status: 0
> > >
> > ...>
> > > The volume is a 3TB disk, model ST3000DM001-1CH166 (Seagate Barracuda
> > > SATA HDD).
> > >
> > > Is there a way to mark sectors on the disk as bad? If so, is it
> >
> > Directly overwriting sector may "fix" it (of course, data is still lost)
> > or trigger sector replacement. hdparm has --write-sector command
> > although I do not have any experience with it. Or simple dd may suffice.
> > Difference is that hdparm will bypass any kernel block layer recovery.
> > If you had redundant data profile, btrfs scrub would likely have fixed
> > it for you.
> 
> I never knew BTRFS could duplicate data without RAID. This looks like
> a great feature for my situation. I think I may upgrade this disk to a
> larger one and enable DUP for data.
> 
> Is this a good tutorial to follow?
> https://zejn.net/b/2017/04/30/single-device-data-redundancy-with-btrfs/
> 
> Should I expect my data to take twice as much space after enabling DUP?

Twice as much space, and also there is a seeking cost because the data is
written in two locations some distance apart on the media.  It doesn't
help if the entire device fails, so at best it typically only delays
the inevitable total failure...but maybe that gives you time to finish
a backup before the drive dies.

> > > advisable to keep using this physical disk?
> > >
> >
> > Well, this happens, if this is just one sector so far I would say yes.
> > You probably need to keep an eye on it though.
> 
> Thanks. My guess is that this is an isolated issue. It doesn't seem to
> be growing, but I will watch it.
