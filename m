Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5724D39AB83
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jun 2021 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCUJd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Thu, 3 Jun 2021 16:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCUJc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 16:09:32 -0400
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Jun 2021 13:07:47 PDT
Received: from mail.lichtvoll.de (lichtvoll.de [IPv6:2001:67c:14c:12f::11:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB46C06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Jun 2021 13:07:47 -0700 (PDT)
Received: from shanti.localnet (unknown [IPv6:2001:a62:1ab0:a300::ffe])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 7384B267405
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Jun 2021 21:59:10 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     linux-btrfs@vger.kernel.org
Subject: Scrub: Uncorrectable error due to SSD read error
Date:   Thu, 03 Jun 2021 21:59:09 +0200
Message-ID: <2440004.yYTOSnB24Y@shanti>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi!

I got read errors on a Samsung SSD 870 2 TB drive that is just a few months
old with BTRFS on Devuan Beowulf with 5.10.7 kernel from Debian Sid. The
affected BTRFS filesystem are running on top of LVM with LUKS. This is
on a ThinkPad L560.

BTRFS reported most of them during a scrub. One was an input/output
error during trying to backup a file with rsync – this one was not reported
by scrub. I fixed it by replacing the file from an older backup.

Most other scrub errors where related to a file. I fixed it them replacing
it from an older backup.

However two more scrub errors were not related to a file. One example:

[15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
[15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error at logical 176045789184 on dev /dev/mapper/sata-home
[15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0

(rd is 3 cause I did the scrub before already – these are on a different
BTRFS filesystem than the other errors, but on the same disk and the
same LVM)

I bet this error is somewhere in metadata.

So what is your best suggestion to fix up this one? btrfs check --repair?
Or just redoing the whole BTRFS from backup?


I reported the errors to the retailer I bought the SSD from, but their
suggestion was just to try updating the BIOS and try without
encryption. I got the impression they did not really understand that
LUKS is software based encryption. They did not really answer to
my question whether the SSD needs replacement. Turning of encryption
is nothing I would like to do.

The device reports SMART status clean, but has the error in SMART log.
So far it appears there are no further errors.

So far no further errors appeared, I find it difficult to judge whether the
drive needs replacement or these where just one time bad blocks that
the SSD firmware will not try to use again.


Here is a somewhat shortened excerpt of what the kernel reported for just
one of the read errors that BTRFS reported.

[15487.535977] BTRFS info (device dm-3): scrub: started on devid 1
[15784.497016] ata1.00: READ LOG DMA EXT failed, trying PIO
[15784.497903] ata1: failed to read log page 10h (errno=-5)
[15784.497928] ata1.00: exception Emask 0x1 SAct 0xff9fffff SErr 0x40000 action 0x0
[15784.497936] ata1.00: irq_stat 0x40000008
[15784.497944] ata1: SError: { CommWake }
[15784.497953] ata1.00: failed command: READ FPDMA QUEUED
[15784.497971] ata1.00: cmd 60/00:00:28:e5:b1/01:00:19:00:00/40 tag 0 ncq dma 131072 in
                        res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
[15784.497978] ata1.00: status: { DRDY }
[15784.497986] ata1.00: failed command: READ FPDMA QUEUED
[15784.498001] ata1.00: cmd 60/00:08:28:e6:b1/02:00:19:00:00/40 tag 1 ncq dma 262144 in
                        res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
[15784.498007] ata1.00: status: { DRDY }
[15784.498014] ata1.00: failed command: READ FPDMA QUEUED
[15784.498028] ata1.00: cmd 60/00:10:28:e8:b1/02:00:19:00:00/40 tag 2 ncq dma 262144 in
                        res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
[…]
[15784.498707] ata1.00: failed command: READ FPDMA QUEUED
[15784.498721] ata1.00: cmd 60/00:f8:28:f3:b1/01:00:19:00:00/40 tag 31 ncq dma 131072 in
                        res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1 (device error)
[15784.498726] ata1.00: status: { DRDY }
[15784.499040] ata1.00: both IDENTIFYs aborted, assuming NODEV
[15784.499049] ata1.00: revalidation failed (errno=-2)
[15784.499064] ata1: hard resetting link
[15784.810213] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[15784.812120] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15784.812131] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15784.812328] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15784.812339] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15784.812759] ata1.00: supports DRM functions and may not be fully accessible
[15784.815649] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15784.815658] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15784.815731] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15784.815738] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15784.816006] ata1.00: supports DRM functions and may not be fully accessible
[15784.817970] ata1.00: configured for UDMA/133
[15784.828580] ata1: EH complete
[15784.829623] ata1.00: Enabling discard_zeroes_data
[15785.021191] ata1: failed to read log page 10h (errno=-5)
[15785.021216] ata1.00: exception Emask 0x1 SAct 0xfffffff1 SErr 0x0 action 0x0
[15785.021222] ata1.00: irq_stat 0x40000008
[15785.021232] ata1.00: failed command: WRITE FPDMA QUEUED
[15785.021249] ata1.00: cmd 61/00:00:60:16:7c/02:00:00:00:00/40 tag 0 ncq dma 262144 out
                        res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
[15785.021257] ata1.00: status: { DRDY }
[15785.021264] ata1.00: failed command: READ FPDMA QUEUED
[15785.021280] ata1.00: cmd 60/00:20:28:d0:b1/06:00:19:00:00/40 tag 4 ncq dma 786432 in
                        res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
[15785.021286] ata1.00: status: { DRDY }
[15785.021293] ata1.00: failed command: READ FPDMA QUEUED
[15785.021308] ata1.00: cmd 60/00:28:d8:0d:b2/01:00:19:00:00/40 tag 5 ncq dma 131072 in
                        res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
[…]
[15785.021957] ata1.00: failed command: READ FPDMA QUEUED
[15785.021970] ata1.00: cmd 60/00:f8:28:e8:b1/02:00:19:00:00/40 tag 31 ncq dma 262144 in
                        res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1 (device error)
[15785.021976] ata1.00: status: { DRDY }
[15785.022456] ata1.00: both IDENTIFYs aborted, assuming NODEV
[15785.022464] ata1.00: revalidation failed (errno=-2)
[15785.022480] ata1: hard resetting link
[15785.333073] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[15785.335233] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15785.335244] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15785.335508] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15785.335519] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15785.336179] ata1.00: supports DRM functions and may not be fully accessible
[15785.341214] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15785.341226] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15785.341398] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15785.341406] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15785.341731] ata1.00: supports DRM functions and may not be fully accessible
[15785.344055] ata1.00: configured for UDMA/133
[15785.354541] ata1: EH complete
[15785.355149] ata1.00: Enabling discard_zeroes_data
[15785.553288] ata1: failed to read log page 10h (errno=-5)
[15785.553314] ata1.00: exception Emask 0x1 SAct 0x83ffffff SErr 0x0 action 0x0
[15785.553321] ata1.00: irq_stat 0x40000008
[15785.553330] ata1.00: failed command: READ FPDMA QUEUED
[15785.553348] ata1.00: cmd 60/00:00:28:d0:b1/06:00:19:00:00/40 tag 0 ncq dma 786432 in
                        res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15785.553356] ata1.00: status: { DRDY }
[15785.553363] ata1.00: failed command: WRITE FPDMA QUEUED
[15785.553379] ata1.00: cmd 61/00:08:60:16:7c/02:00:00:00:00/40 tag 1 ncq dma 262144 out
                        res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15785.553385] ata1.00: status: { DRDY }
[15785.553392] ata1.00: failed command: READ FPDMA QUEUED
[15785.553407] ata1.00: cmd 60/00:10:d8:20:b2/02:00:19:00:00/40 tag 2 ncq dma 262144 in
                        res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15785.553413] ata1.00: status: { DRDY }
[…]
[15785.553984] ata1.00: failed command: SEND FPDMA QUEUED
[15785.553998] ata1.00: cmd 64/01:c8:00:00:00/00:00:00:00:00/a0 tag 25 ncq dma 512 out
                        res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15785.554004] ata1.00: status: { DRDY }
[15785.554011] ata1.00: failed command: READ FPDMA QUEUED
[15785.554025] ata1.00: cmd 60/00:f8:d8:1e:b2/02:00:19:00:00/40 tag 31 ncq dma 262144 in
                        res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15785.554031] ata1.00: status: { DRDY }
[15785.554667] ata1.00: both IDENTIFYs aborted, assuming NODEV
[15785.554676] ata1.00: revalidation failed (errno=-2)
[15785.554692] ata1: hard resetting link
[15785.868941] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[15785.870412] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15785.870424] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15785.870554] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15785.870562] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15785.870946] ata1.00: supports DRM functions and may not be fully accessible
[15785.874186] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15785.874194] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15785.874288] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15785.874295] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15785.874583] ata1.00: supports DRM functions and may not be fully accessible
[15785.876723] ata1.00: configured for UDMA/133
[15785.887214] sd 0:0:0:0: [sda] tag#25 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[15785.887225] sd 0:0:0:0: [sda] tag#25 Sense Key : Illegal Request [current] 
[15785.887232] sd 0:0:0:0: [sda] tag#25 Add. Sense: Unaligned write command
[15785.887241] sd 0:0:0:0: [sda] tag#25 CDB: Write same(16) 93 08 00 00 00 00 1c 39 a6 30 00 00 00 40 00 00
[15785.887251] blk_update_request: I/O error, dev sda, sector 473540144 op 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0
[15785.887295] ata1: EH complete
[15785.887988] ata1.00: Enabling discard_zeroes_data
[15786.077348] ata1: failed to read log page 10h (errno=-5)
[15786.077367] ata1.00: NCQ disabled due to excessive errors
[15786.077377] ata1.00: exception Emask 0x1 SAct 0xf8807fff SErr 0x0 action 0x0
[15786.077383] ata1.00: irq_stat 0x40000008
[15786.077392] ata1.00: failed command: READ FPDMA QUEUED
[15786.077411] ata1.00: cmd 60/00:00:d8:66:b2/05:00:19:00:00/40 tag 0 ncq dma 655360 in
                        res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15786.077418] ata1.00: status: { DRDY }
[15786.077426] ata1.00: failed command: READ FPDMA QUEUED
[15786.077441] ata1.00: cmd 60/00:08:d8:6b:b2/05:00:19:00:00/40 tag 1 ncq dma 655360 in
                        res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15786.077448] ata1.00: status: { DRDY }
[15786.077454] ata1.00: failed command: READ FPDMA QUEUED
[15786.077469] ata1.00: cmd 60/00:10:d8:70:b2/05:00:19:00:00/40 tag 2 ncq dma 655360 in
                        res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15786.077475] ata1.00: status: { DRDY }
[15786.077481] ata1.00: failed command: READ FPDMA QUEUED
[15786.077497] ata1.00: cmd 60/00:18:d8:75:b2/02:00:19:00:00/40 tag 3 ncq dma 262144 in
                        res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[…]
[15786.077930] ata1.00: failed command: READ FPDMA QUEUED
[15786.077944] ata1.00: cmd 60/00:f8:d8:61:b2/05:00:19:00:00/40 tag 31 ncq dma 655360 in
                        res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1 (device error)
[15786.077950] ata1.00: status: { DRDY }
[15786.078721] ata1.00: both IDENTIFYs aborted, assuming NODEV
[15786.078730] ata1.00: revalidation failed (errno=-2)
[15786.078747] ata1: hard resetting link
[15786.390145] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[15786.391640] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15786.391652] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15786.391920] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15786.391932] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15786.392523] ata1.00: supports DRM functions and may not be fully accessible
[15786.397343] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succeeded
[15786.397354] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filtered out
[15786.397527] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succeeded
[15786.397536] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
[15786.397934] ata1.00: supports DRM functions and may not be fully accessible
[15786.400238] ata1.00: configured for UDMA/133
[15786.410829] ata1: EH complete
[15786.521139] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[15786.521158] ata1.00: irq_stat 0x40000001
[15786.521169] ata1.00: failed command: READ DMA EXT
[15786.521188] ata1.00: cmd 25/00:00:28:d0:b1/00:06:19:00:00/e0 tag 17 dma 786432 in
                        res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9 (media error)
[15786.521195] ata1.00: status: { DRDY ERR }
[15786.521202] ata1.00: error: { UNC }
[15786.521937] ata1.00: supports DRM functions and may not be fully accessible
[15786.525850] ata1.00: supports DRM functions and may not be fully accessible
[15786.528948] ata1.00: configured for UDMA/133
[15786.529028] sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=2s
[15786.529038] sd 0:0:0:0: [sda] tag#17 Sense Key : Medium Error [current] 
[15786.529047] sd 0:0:0:0: [sda] tag#17 Add. Sense: Unrecovered read error - auto reallocate failed
[15786.529055] sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 19 b1 d0 28 00 06 00 00
[15786.529066] blk_update_request: I/O error, dev sda, sector 431084232 op 0x0:(READ) flags 0x4000 phys_seg 63 prio class 0
[15786.529150] ata1: EH complete
[15786.533347] ata1.00: Enabling discard_zeroes_data
[15786.552084] ata1.00: Enabling discard_zeroes_data
[15786.820703] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
[15786.820718] ata1.00: irq_stat 0x40000001
[15786.820728] ata1.00: failed command: READ DMA EXT
[15786.820748] ata1.00: cmd 25/00:08:c8:d2:b1/00:00:19:00:00/e0 tag 18 dma 4096 in
                        res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9 (media error)
[15786.820756] ata1.00: status: { DRDY ERR }
[15786.820762] ata1.00: error: { UNC }
[15786.821313] ata1.00: supports DRM functions and may not be fully accessible
[15786.824200] ata1.00: supports DRM functions and may not be fully accessible
[15786.826515] ata1.00: configured for UDMA/133
[15786.826557] sd 0:0:0:0: [sda] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=0s
[15786.826567] sd 0:0:0:0: [sda] tag#18 Sense Key : Medium Error [current] 
[15786.826575] sd 0:0:0:0: [sda] tag#18 Add. Sense: Unrecovered read error - auto reallocate failed
[15786.826584] sd 0:0:0:0: [sda] tag#18 CDB: Read(10) 28 00 19 b1 d2 c8 00 00 08 00
[15786.826594] blk_update_request: I/O error, dev sda, sector 431084232 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
[15786.826643] ata1: EH complete
[15786.828426] ata1.00: Enabling discard_zeroes_data
[15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs: wr 0, rd 3, flush 0, corrupt 0, gen 0
[15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error at logical 176045789184 on dev /dev/mapper/sata-home
[15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with status: 0

Thanks
-- 
Martin


