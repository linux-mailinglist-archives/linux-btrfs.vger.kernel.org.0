Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF85D39B393
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 09:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFDHJb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Fri, 4 Jun 2021 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDHJa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 03:09:30 -0400
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A2C06174A
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Jun 2021 00:07:45 -0700 (PDT)
Received: from shanti.localnet (unknown [IPv6:2001:a62:1ad3:9100::ffe])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 880DD267993;
        Fri,  4 Jun 2021 09:07:42 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Scrub: Uncorrectable error due to SSD read error
Date:   Fri, 04 Jun 2021 09:07:39 +0200
Message-ID: <4030217.cPEZuEdVPn@shanti>
In-Reply-To: <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
References: <2440004.yYTOSnB24Y@shanti> <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy - 04.06.21, 07:50:27 CEST:
> On Thu, Jun 3, 2021 at 2:08 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
> > I got read errors on a Samsung SSD 870 2 TB drive that is just a few months
> > old with BTRFS on Devuan Beowulf with 5.10.7 kernel from Debian Sid. The
> > affected BTRFS filesystem are running on top of LVM with LUKS. This is
> > on a ThinkPad L560.
> >
> > BTRFS reported most of them during a scrub. One was an input/output
> > error during trying to backup a file with rsync – this one was not reported
> > by scrub. I fixed it by replacing the file from an older backup.
> >
> > Most other scrub errors where related to a file. I fixed it them replacing
> > it from an older backup.
> >
> > However two more scrub errors were not related to a file. One example:
> >
> > [15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
> > [15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error at logical 176045789184 on dev /dev/mapper/sata-home
> > [15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0
> >
> > (rd is 3 cause I did the scrub before already – these are on a different
> > BTRFS filesystem than the other errors, but on the same disk and the
> > same LVM)
> >
> > I bet this error is somewhere in metadata.
> >
> > So what is your best suggestion to fix up this one? btrfs check --repair?
> 
> btrfs check --readonly
> 
> Let's see what the problem is first.

Ok, will do.

Interestingly one of the scrub read errors of that filesystem disappeared
in the scrub I did yesterday. It was there about a week ago. Maybe BTRFS
got rid of the block. So it may be that, if I make sure those errors do not
happen again, the other one may also disappear. Let's see.

> > Here is a somewhat shortened excerpt of what the kernel reported for just
> > one of the read errors that BTRFS reported.
> 
> The vast majority of these messages are from libata. Not dm-crypt or
> btrfs. This is the part of the kernel that talks to the drive, and
> many are errors being reported by the drive itself...

Yeah, I am aware of that.

> > [15487.535977] BTRFS info (device dm-3): scrub: started on devid 1
> > [15784.497016] ata1.00: READ LOG DMA EXT failed, trying PIO
> > [15784.497903] ata1: failed to read log page 10h (errno=-5)
> > [15784.497928] ata1.00: exception Emask 0x1 SAct 0xff9fffff SErr 0x40000 action 0x0
> > [15784.497936] ata1.00: irq_stat 0x40000008
> > [15784.497944] ata1: SError: { CommWake }
> > [15784.497953] ata1.00: failed command: READ FPDMA QUEUED
> > [15784.497971] ata1.00: cmd 60/00:00:28:e5:b1/01:00:19:00:00/40 tag 0 ncq dma 131072 in
> >                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15784.497978] ata1.00: status: { DRDY }
> > [15784.497986] ata1.00: failed command: READ FPDMA QUEUED
> > [15784.498001] ata1.00: cmd 60/00:08:28:e6:b1/02:00:19:00:00/40 tag 1 ncq dma 262144 in
> >                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15784.498007] ata1.00: status: { DRDY }
> > [15784.498014] ata1.00: failed command: READ FPDMA QUEUED
> > [15784.498028] ata1.00: cmd 60/00:10:28:e8:b1/02:00:19:00:00/40 tag 2 ncq dma 262144 in
> >                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
> > […]
> > [15784.498707] ata1.00: failed command: READ FPDMA QUEUED
> > [15784.498721] ata1.00: cmd 60/00:f8:28:f3:b1/01:00:19:00:00/40 tag 31 ncq dma 131072 in
> >                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15784.498726] ata1.00: status: { DRDY }
> > [15784.499040] ata1.00: both IDENTIFYs aborted, assuming NODEV
> > [15784.499049] ata1.00: revalidation failed (errno=-2)
> > [15784.499064] ata1: hard resetting link
> > [15784.810213] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [15784.812120] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15784.812131] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15784.812328] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15784.812339] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15784.812759] ata1.00: supports DRM functions and may not be fully accessible
> > [15784.815649] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15784.815658] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15784.815731] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15784.815738] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15784.816006] ata1.00: supports DRM functions and may not be fully accessible
> > [15784.817970] ata1.00: configured for UDMA/133
> > [15784.828580] ata1: EH complete
> > [15784.829623] ata1.00: Enabling discard_zeroes_data
> > [15785.021191] ata1: failed to read log page 10h (errno=-5)
> > [15785.021216] ata1.00: exception Emask 0x1 SAct 0xfffffff1 SErr 0x0 action 0x0
> > [15785.021222] ata1.00: irq_stat 0x40000008
> > [15785.021232] ata1.00: failed command: WRITE FPDMA QUEUED
> > [15785.021249] ata1.00: cmd 61/00:00:60:16:7c/02:00:00:00:00/40 tag 0 ncq dma 262144 out
> >                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
> > [15785.021257] ata1.00: status: { DRDY }
> > [15785.021264] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.021280] ata1.00: cmd 60/00:20:28:d0:b1/06:00:19:00:00/40 tag 4 ncq dma 786432 in
> >                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
> > [15785.021286] ata1.00: status: { DRDY }
> > [15785.021293] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.021308] ata1.00: cmd 60/00:28:d8:0d:b2/01:00:19:00:00/40 tag 5 ncq dma 131072 in
> >                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
> > […]
> > [15785.021957] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.021970] ata1.00: cmd 60/00:f8:28:e8:b1/02:00:19:00:00/40 tag 31 ncq dma 262144 in
> >                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
> > [15785.021976] ata1.00: status: { DRDY }
> > [15785.022456] ata1.00: both IDENTIFYs aborted, assuming NODEV
> > [15785.022464] ata1.00: revalidation failed (errno=-2)
> > [15785.022480] ata1: hard resetting link
> > [15785.333073] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [15785.335233] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.335244] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15785.335508] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.335519] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15785.336179] ata1.00: supports DRM functions and may not be fully accessible
> > [15785.341214] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.341226] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15785.341398] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.341406] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15785.341731] ata1.00: supports DRM functions and may not be fully accessible
> > [15785.344055] ata1.00: configured for UDMA/133
> > [15785.354541] ata1: EH complete
> > [15785.355149] ata1.00: Enabling discard_zeroes_data
> > [15785.553288] ata1: failed to read log page 10h (errno=-5)
> > [15785.553314] ata1.00: exception Emask 0x1 SAct 0x83ffffff SErr 0x0 action 0x0
> > [15785.553321] ata1.00: irq_stat 0x40000008
> > [15785.553330] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.553348] ata1.00: cmd 60/00:00:28:d0:b1/06:00:19:00:00/40 tag 0 ncq dma 786432 in
> >                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15785.553356] ata1.00: status: { DRDY }
> > [15785.553363] ata1.00: failed command: WRITE FPDMA QUEUED
> > [15785.553379] ata1.00: cmd 61/00:08:60:16:7c/02:00:00:00:00/40 tag 1 ncq dma 262144 out
> >                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15785.553385] ata1.00: status: { DRDY }
> > [15785.553392] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.553407] ata1.00: cmd 60/00:10:d8:20:b2/02:00:19:00:00/40 tag 2 ncq dma 262144 in
> >                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15785.553413] ata1.00: status: { DRDY }
> > […]
> > [15785.553984] ata1.00: failed command: SEND FPDMA QUEUED
> > [15785.553998] ata1.00: cmd 64/01:c8:00:00:00/00:00:00:00:00/a0 tag 25 ncq dma 512 out
> >                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15785.554004] ata1.00: status: { DRDY }
> > [15785.554011] ata1.00: failed command: READ FPDMA QUEUED
> > [15785.554025] ata1.00: cmd 60/00:f8:d8:1e:b2/02:00:19:00:00/40 tag 31 ncq dma 262144 in
> >                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15785.554031] ata1.00: status: { DRDY }
> > [15785.554667] ata1.00: both IDENTIFYs aborted, assuming NODEV
> > [15785.554676] ata1.00: revalidation failed (errno=-2)
> > [15785.554692] ata1: hard resetting link
> > [15785.868941] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [15785.870412] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.870424] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15785.870554] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.870562] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15785.870946] ata1.00: supports DRM functions and may not be fully accessible
> > [15785.874186] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.874194] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15785.874288] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15785.874295] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15785.874583] ata1.00: supports DRM functions and may not be fully accessible
> > [15785.876723] ata1.00: configured for UDMA/133
> > [15785.887214] sd 0:0:0:0: [sda] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
> > [15785.887225] sd 0:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current]
> > [15785.887232] sd 0:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
> > [15785.887241] sd 0:0:0:0: [sda] tag#25 CDB: Write same(16) 93 08 00 00 00 00 1c 39 a6 30 00 00 00 40 00 00
> > [15785.887251] blk_update_request: I/O error, dev sda, sector 473540144 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
> 
> What mount options are you using? Please list all of them from fstab
> or /proc/mounts. In particular though it looks like the discard mount
> option is being used? Remove it.

Mount options look like this.
 
rw,relatime,lazytime,compress=zstd:3,ssd,discard=async,space_cache,subvolid=257,subvol=/home

I am removing "discard=async". I thought this would be safe with modern
SSDs.

I always used fstrim manually before, because I was aware of SSDs having
issue with discard, but when BTRFS introduced queued or batched discard
I thought I give it a try on a modern SSD.
 
> Also it might be worth looking at mainline kernel source and see if
> this model is in the deny list for any discard related things. And if
> not, maybe report your findings to the proper list. I'm not sure if
> that would be libata, scsi, or block. But this would work around the
> problem by not sending commands that the drive firmware can't handle.
> Yes, that means the kernel is working around known manufacturing
> device defects. That's where things are.
>
> > [15785.887295] ata1: EH complete
> > [15785.887988] ata1.00: Enabling discard_zeroes_data
> > [15786.077348] ata1: failed to read log page 10h (errno=-5)
> > [15786.077367] ata1.00: NCQ disabled due to excessive errors
> > [15786.077377] ata1.00: exception Emask 0x1 SAct 0xf8807fff SErr 0x0 action 0x0
> > [15786.077383] ata1.00: irq_stat 0x40000008
> > [15786.077392] ata1.00: failed command: READ FPDMA QUEUED
> > [15786.077411] ata1.00: cmd 60/00:00:d8:66:b2/05:00:19:00:00/40 tag 0 ncq dma 655360 in
> >                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15786.077418] ata1.00: status: { DRDY }
> > [15786.077426] ata1.00: failed command: READ FPDMA QUEUED
> > [15786.077441] ata1.00: cmd 60/00:08:d8:6b:b2/05:00:19:00:00/40 tag 1 ncq dma 655360 in
> >                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15786.077448] ata1.00: status: { DRDY }
> > [15786.077454] ata1.00: failed command: READ FPDMA QUEUED
> > [15786.077469] ata1.00: cmd 60/00:10:d8:70:b2/05:00:19:00:00/40 tag 2 ncq dma 655360 in
> >                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15786.077475] ata1.00: status: { DRDY }
> > [15786.077481] ata1.00: failed command: READ FPDMA QUEUED
> > [15786.077497] ata1.00: cmd 60/00:18:d8:75:b2/02:00:19:00:00/40 tag 3 ncq dma 262144 in
> >                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > […]
> > [15786.077930] ata1.00: failed command: READ FPDMA QUEUED
> > [15786.077944] ata1.00: cmd 60/00:f8:d8:61:b2/05:00:19:00:00/40 tag 31 ncq dma 655360 in
> >                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
> > [15786.077950] ata1.00: status: { DRDY }
> > [15786.078721] ata1.00: both IDENTIFYs aborted, assuming NODEV
> > [15786.078730] ata1.00: revalidation failed (errno=-2)
> > [15786.078747] ata1: hard resetting link
> > [15786.390145] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > [15786.391640] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15786.391652] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15786.391920] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15786.391932] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15786.392523] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.397343] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
> > [15786.397354] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
> > [15786.397527] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
> > [15786.397536] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
> > [15786.397934] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.400238] ata1.00: configured for UDMA/133
> > [15786.410829] ata1: EH complete
> > [15786.521139] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> > [15786.521158] ata1.00: irq_stat 0x40000001
> > [15786.521169] ata1.00: failed command: READ DMA EXT
> > [15786.521188] ata1.00: cmd 25/00:00:28:d0:b1/00:06:19:00:00/e0 tag 17 dma 786432 in
> >                         res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9 (media error)
> > [15786.521195] ata1.00: status: { DRDY ERR }
> > [15786.521202] ata1.00: error: { UNC }
> > [15786.521937] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.525850] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.528948] ata1.00: configured for UDMA/133
> > [15786.529028] sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=2s
> > [15786.529038] sd 0:0:0:0: [sda] tag#17 Sense Key : Medium Error [current]
> > [15786.529047] sd 0:0:0:0: [sda] tag#17 Add. Sense: Unrecovered read error - auto reallocate failed
> > [15786.529055] sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 19 b1 d0 28 00 06 00 00
> > [15786.529066] blk_update_request: I/O error, dev sda, sector 431084232 op 0x0:(READ) flags 0x4000 phys_seg 63 prio class 0
> > [15786.529150] ata1: EH complete
> > [15786.533347] ata1.00: Enabling discard_zeroes_data
> > [15786.552084] ata1.00: Enabling discard_zeroes_data
> 
> Yeah here's a pretty good bet that discard is included in the btrfs
> mount option for this file system. I don't think discards happen
> without the file system issuing them, and dm-crypt and device-mapper
> for the LVM layer each have discard pass down enabled. It's frequently
> the default for LVM these days, but not dm-crypt (it is the default on
> Fedora though, for example).

I think it is passing discards through by default on Debian 10 as well.

> So the drive is not handling queued discard properly is what I
> suspect. It gets confused. Face plants. Libata then does a hard reset
> to try to get the drive to come back to reality. And then another
> discard gets issued and the drive wigs out again.

Thank you. Where did you read this from? I find it challenging to interpret
the error message the kernel ata layer puts out. They are very detailed and
I think that is good, but I just do not understand most of it.

> I'd say it's some kind of defect. Is it unique to this particular
> drive and thus a warranty issue? Maybe. Or is it buggy firmware that
> affects this entire make/model/firmware? Maybe. If removing discard
> mount option fixes the problem, it's probably the latter. But still
> worth searching mainline kernel and 5.10.42 if it's in the deny list
> for queued trim. If not, worth letting the proper upstream list know
> about this problem. If they get more reports, then they'll add the
> make/model to the appropriate deny list.

Will do so. At least there does not seem to be a firmware update available.
(Or Samsung does not provide those through LVFS. Need to check.)

% fwupdmgr update
Devices with no available firmware updates: 
[…]
 • Samsung SSD 870 EVO 2TB
[…]

> A better option any is scheduled fstrim once a week. Or for very heavy
> write, delete, write workloads where it's useful to provide hinting
> for unused blocks more often than once per week, use discard=async.

Well that is what I use. "discard=async"

> But for a few weeks at least, I suggest no discard option at all to
> see if the problem goes away.

Will do so.

> > [15786.820703] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> > [15786.820718] ata1.00: irq_stat 0x40000001
> > [15786.820728] ata1.00: failed command: READ DMA EXT
> > [15786.820748] ata1.00: cmd 25/00:08:c8:d2:b1/00:00:19:00:00/e0 tag 18 dma 4096 in
> >                         res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9 (media error)
> > [15786.820756] ata1.00: status: { DRDY ERR }
> > [15786.820762] ata1.00: error: { UNC }
> > [15786.821313] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.824200] ata1.00: supports DRM functions and may not be fully accessible
> > [15786.826515] ata1.00: configured for UDMA/133
> > [15786.826557] sd 0:0:0:0: [sda] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
> > [15786.826567] sd 0:0:0:0: [sda] tag#18 Sense Key : Medium Error [current]
> > [15786.826575] sd 0:0:0:0: [sda] tag#18 Add. Sense: Unrecovered read error - auto reallocate failed
> > [15786.826584] sd 0:0:0:0: [sda] tag#18 CDB: Read(10) 28 00 19 b1 d2 c8 00 00 08 00
> > [15786.826594] blk_update_request: I/O error, dev sda, sector 431084232 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> > [15786.826643] ata1: EH complete
> > [15786.828426] ata1.00: Enabling discard_zeroes_data
> > [15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
> > [15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error at logical 176045789184 on dev /dev/mapper/sata-home
> > [15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0
[…]
> Yeah I'm not sure if this metadata corruption is the result of
> discards. Could be. But the first underlying problem to figure out are
> all these ata errors, which point to the drive itself not liking
> discards (queued trim), and not something btrfs or device-mapper are
> doing wrong.

I did not suspect Linux doing anything wrong here. I was pretty sure it
would be something with the drive, yet did not know that it is discard
related.

Ciao,
-- 
Martin


