Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE0339B227
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 07:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFDFxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 01:53:32 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:40602 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFDFxc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 01:53:32 -0400
Received: by mail-wm1-f48.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so7140112wmd.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jun 2021 22:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vv8w33jdtPojnBG9NxoavmX1SLTbvcByXiYwOt2iNG0=;
        b=njCVIEJUCMT9hBailaU/pZ+dTsmIlOUVtjauRfQcitxi4uiJKK4jxOkR2n/WN1Ac/8
         imYZeV+uiaEYW+BxaTioIxVClj97MJP3Mny4eBFZ6V9lv3EP8h115CIha1sBkp8AQ9J3
         LaoVN8S8LB3HgbXbx4pmWV1QcYAs8PUTQqCbnrO9nq4LgzD+7Qu2+Ga+QqjBGX8DwcJs
         Q7vAOA7jFxqysGy7ajRXXZEJiPfvTsrSDrEf6oMihN3wn8TbL7yKSeb0nirpUDLd4f7i
         uSzMDhjUXP01DcGFqLz4eLsJUpbJjhR0HTaXP1kWIj7qeGFsUoD+ka7O3wDv2AjjwJFe
         rzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vv8w33jdtPojnBG9NxoavmX1SLTbvcByXiYwOt2iNG0=;
        b=RYid0pyHxulLw+/UtD7CqnBcQalBxKcG5E9Q7aJM8AVCIkESMe1v0vLRPNsB0ZqwUz
         ixkSeoL/eRUwnuglN6FJR4Arz0EHLD2RuXdAX6mzgETZVSIB2BvMD+SYN9uFqZkZIwua
         PN/Z4qrlB9ByDmf3n+/UDQKtTdcIYF/8HolwmeLnyE/I+YMUQvQIhKAXKvToiVuvnoWG
         0qViM0ShC7xRP2KU8uZvZ7WYRSIO9PNcrjK+rRbsLlChoH4pZmlHAm51TWljj06PRg7X
         SCV5hwBMo3z64obbv6XRV6kKBKyBCj4TamNpowPtjiWA5NoNnh4hbv9Vryt4/R5YZO1m
         q7mw==
X-Gm-Message-State: AOAM531B0nKUQZt6cIFps5uzuNkBwQ7kO6xu1eQ+/LH03JywusP0z8B7
        ZCT7vSnSSyM32SEZpHHC1Niy4f3659p4mmxm2Us62w==
X-Google-Smtp-Source: ABdhPJyQeQwuj7y1knO4nBQ0juJOdmvVOKI+b7l8dNTiX1G4W6H8G7FMLV/845meEzhIh7LJo4FUJCsz9nRnfnPRVL8=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr1831131wmj.128.1622785845309;
 Thu, 03 Jun 2021 22:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <2440004.yYTOSnB24Y@shanti>
In-Reply-To: <2440004.yYTOSnB24Y@shanti>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 3 Jun 2021 23:50:27 -0600
Message-ID: <CAJCQCtQLYHb7G4YTmsY_cHsBHDzXM6-qQ39YNGHp2mk0mLkLEw@mail.gmail.com>
Subject: Re: Scrub: Uncorrectable error due to SSD read error
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 3, 2021 at 2:08 PM Martin Steigerwald <martin@lichtvoll.de> wro=
te:
>
> Hi!
>
> I got read errors on a Samsung SSD 870 2 TB drive that is just a few mont=
hs
> old with BTRFS on Devuan Beowulf with 5.10.7 kernel from Debian Sid. The
> affected BTRFS filesystem are running on top of LVM with LUKS. This is
> on a ThinkPad L560.
>
> BTRFS reported most of them during a scrub. One was an input/output
> error during trying to backup a file with rsync =E2=80=93 this one was no=
t reported
> by scrub. I fixed it by replacing the file from an older backup.
>
> Most other scrub errors where related to a file. I fixed it them replacin=
g
> it from an older backup.
>
> However two more scrub errors were not related to a file. One example:
>
> [15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs=
: wr 0, rd 3, flush 0, corrupt 0, gen 0
> [15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error=
 at logical 176045789184 on dev /dev/mapper/sata-home
> [15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with =
status: 0
>
> (rd is 3 cause I did the scrub before already =E2=80=93 these are on a di=
fferent
> BTRFS filesystem than the other errors, but on the same disk and the
> same LVM)
>
> I bet this error is somewhere in metadata.
>
> So what is your best suggestion to fix up this one? btrfs check --repair?

btrfs check --readonly

Let's see what the problem is first.

>
>
> Here is a somewhat shortened excerpt of what the kernel reported for just
> one of the read errors that BTRFS reported.

The vast majority of these messages are from libata. Not dm-crypt or
btrfs. This is the part of the kernel that talks to the drive, and
many are errors being reported by the drive itself...


>
> [15487.535977] BTRFS info (device dm-3): scrub: started on devid 1
> [15784.497016] ata1.00: READ LOG DMA EXT failed, trying PIO
> [15784.497903] ata1: failed to read log page 10h (errno=3D-5)
> [15784.497928] ata1.00: exception Emask 0x1 SAct 0xff9fffff SErr 0x40000 =
action 0x0
> [15784.497936] ata1.00: irq_stat 0x40000008
> [15784.497944] ata1: SError: { CommWake }
> [15784.497953] ata1.00: failed command: READ FPDMA QUEUED
> [15784.497971] ata1.00: cmd 60/00:00:28:e5:b1/01:00:19:00:00/40 tag 0 ncq=
 dma 131072 in
>                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15784.497978] ata1.00: status: { DRDY }
> [15784.497986] ata1.00: failed command: READ FPDMA QUEUED
> [15784.498001] ata1.00: cmd 60/00:08:28:e6:b1/02:00:19:00:00/40 tag 1 ncq=
 dma 262144 in
>                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15784.498007] ata1.00: status: { DRDY }
> [15784.498014] ata1.00: failed command: READ FPDMA QUEUED
> [15784.498028] ata1.00: cmd 60/00:10:28:e8:b1/02:00:19:00:00/40 tag 2 ncq=
 dma 262144 in
>                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [=E2=80=A6]
> [15784.498707] ata1.00: failed command: READ FPDMA QUEUED
> [15784.498721] ata1.00: cmd 60/00:f8:28:f3:b1/01:00:19:00:00/40 tag 31 nc=
q dma 131072 in
>                         res 40/00:c8:28:d8:b1/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15784.498726] ata1.00: status: { DRDY }
> [15784.499040] ata1.00: both IDENTIFYs aborted, assuming NODEV
> [15784.499049] ata1.00: revalidation failed (errno=3D-2)
> [15784.499064] ata1: hard resetting link
> [15784.810213] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [15784.812120] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15784.812131] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15784.812328] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15784.812339] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15784.812759] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15784.815649] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15784.815658] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15784.815731] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15784.815738] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15784.816006] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15784.817970] ata1.00: configured for UDMA/133
> [15784.828580] ata1: EH complete
> [15784.829623] ata1.00: Enabling discard_zeroes_data
> [15785.021191] ata1: failed to read log page 10h (errno=3D-5)
> [15785.021216] ata1.00: exception Emask 0x1 SAct 0xfffffff1 SErr 0x0 acti=
on 0x0
> [15785.021222] ata1.00: irq_stat 0x40000008
> [15785.021232] ata1.00: failed command: WRITE FPDMA QUEUED
> [15785.021249] ata1.00: cmd 61/00:00:60:16:7c/02:00:00:00:00/40 tag 0 ncq=
 dma 262144 out
>                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1=
 (device error)
> [15785.021257] ata1.00: status: { DRDY }
> [15785.021264] ata1.00: failed command: READ FPDMA QUEUED
> [15785.021280] ata1.00: cmd 60/00:20:28:d0:b1/06:00:19:00:00/40 tag 4 ncq=
 dma 786432 in
>                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1=
 (device error)
> [15785.021286] ata1.00: status: { DRDY }
> [15785.021293] ata1.00: failed command: READ FPDMA QUEUED
> [15785.021308] ata1.00: cmd 60/00:28:d8:0d:b2/01:00:19:00:00/40 tag 5 ncq=
 dma 131072 in
>                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1=
 (device error)
> [=E2=80=A6]
> [15785.021957] ata1.00: failed command: READ FPDMA QUEUED
> [15785.021970] ata1.00: cmd 60/00:f8:28:e8:b1/02:00:19:00:00/40 tag 31 nc=
q dma 262144 in
>                         res 40/00:e0:88:4a:67/00:00:07:00:00/40 Emask 0x1=
 (device error)
> [15785.021976] ata1.00: status: { DRDY }
> [15785.022456] ata1.00: both IDENTIFYs aborted, assuming NODEV
> [15785.022464] ata1.00: revalidation failed (errno=3D-2)
> [15785.022480] ata1: hard resetting link
> [15785.333073] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [15785.335233] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.335244] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15785.335508] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.335519] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15785.336179] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15785.341214] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.341226] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15785.341398] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.341406] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15785.341731] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15785.344055] ata1.00: configured for UDMA/133
> [15785.354541] ata1: EH complete
> [15785.355149] ata1.00: Enabling discard_zeroes_data
> [15785.553288] ata1: failed to read log page 10h (errno=3D-5)
> [15785.553314] ata1.00: exception Emask 0x1 SAct 0x83ffffff SErr 0x0 acti=
on 0x0
> [15785.553321] ata1.00: irq_stat 0x40000008
> [15785.553330] ata1.00: failed command: READ FPDMA QUEUED
> [15785.553348] ata1.00: cmd 60/00:00:28:d0:b1/06:00:19:00:00/40 tag 0 ncq=
 dma 786432 in
>                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15785.553356] ata1.00: status: { DRDY }
> [15785.553363] ata1.00: failed command: WRITE FPDMA QUEUED
> [15785.553379] ata1.00: cmd 61/00:08:60:16:7c/02:00:00:00:00/40 tag 1 ncq=
 dma 262144 out
>                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15785.553385] ata1.00: status: { DRDY }
> [15785.553392] ata1.00: failed command: READ FPDMA QUEUED
> [15785.553407] ata1.00: cmd 60/00:10:d8:20:b2/02:00:19:00:00/40 tag 2 ncq=
 dma 262144 in
>                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15785.553413] ata1.00: status: { DRDY }
> [=E2=80=A6]
> [15785.553984] ata1.00: failed command: SEND FPDMA QUEUED
> [15785.553998] ata1.00: cmd 64/01:c8:00:00:00/00:00:00:00:00/a0 tag 25 nc=
q dma 512 out
>                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15785.554004] ata1.00: status: { DRDY }
> [15785.554011] ata1.00: failed command: READ FPDMA QUEUED
> [15785.554025] ata1.00: cmd 60/00:f8:d8:1e:b2/02:00:19:00:00/40 tag 31 nc=
q dma 262144 in
>                         res 40/00:78:d8:47:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15785.554031] ata1.00: status: { DRDY }
> [15785.554667] ata1.00: both IDENTIFYs aborted, assuming NODEV
> [15785.554676] ata1.00: revalidation failed (errno=3D-2)
> [15785.554692] ata1: hard resetting link
> [15785.868941] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [15785.870412] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.870424] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15785.870554] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.870562] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15785.870946] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15785.874186] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.874194] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15785.874288] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15785.874295] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15785.874583] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15785.876723] ata1.00: configured for UDMA/133
> [15785.887214] sd 0:0:0:0: [sda] tag#25 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [15785.887225] sd 0:0:0:0: [sda] tag#25 Sense Key : Illegal Request [curr=
ent]
> [15785.887232] sd 0:0:0:0: [sda] tag#25 Add. Sense: Unaligned write comma=
nd
> [15785.887241] sd 0:0:0:0: [sda] tag#25 CDB: Write same(16) 93 08 00 00 0=
0 00 1c 39 a6 30 00 00 00 40 00 00
> [15785.887251] blk_update_request: I/O error, dev sda, sector 473540144 o=
p 0x3:(DISCARD) flags 0x800 phys_seg 1 prio class 0

What mount options are you using? Please list all of them from fstab
or /proc/mounts. In particular though it looks like the discard mount
option is being used? Remove it.

Also it might be worth looking at mainline kernel source and see if
this model is in the deny list for any discard related things. And if
not, maybe report your findings to the proper list. I'm not sure if
that would be libata, scsi, or block. But this would work around the
problem by not sending commands that the drive firmware can't handle.
Yes, that means the kernel is working around known manufacturing
device defects. That's where things are.


> [15785.887295] ata1: EH complete
> [15785.887988] ata1.00: Enabling discard_zeroes_data
> [15786.077348] ata1: failed to read log page 10h (errno=3D-5)
> [15786.077367] ata1.00: NCQ disabled due to excessive errors
> [15786.077377] ata1.00: exception Emask 0x1 SAct 0xf8807fff SErr 0x0 acti=
on 0x0
> [15786.077383] ata1.00: irq_stat 0x40000008
> [15786.077392] ata1.00: failed command: READ FPDMA QUEUED
> [15786.077411] ata1.00: cmd 60/00:00:d8:66:b2/05:00:19:00:00/40 tag 0 ncq=
 dma 655360 in
>                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15786.077418] ata1.00: status: { DRDY }
> [15786.077426] ata1.00: failed command: READ FPDMA QUEUED
> [15786.077441] ata1.00: cmd 60/00:08:d8:6b:b2/05:00:19:00:00/40 tag 1 ncq=
 dma 655360 in
>                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15786.077448] ata1.00: status: { DRDY }
> [15786.077454] ata1.00: failed command: READ FPDMA QUEUED
> [15786.077469] ata1.00: cmd 60/00:10:d8:70:b2/05:00:19:00:00/40 tag 2 ncq=
 dma 655360 in
>                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15786.077475] ata1.00: status: { DRDY }
> [15786.077481] ata1.00: failed command: READ FPDMA QUEUED
> [15786.077497] ata1.00: cmd 60/00:18:d8:75:b2/02:00:19:00:00/40 tag 3 ncq=
 dma 262144 in
>                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [=E2=80=A6]
> [15786.077930] ata1.00: failed command: READ FPDMA QUEUED
> [15786.077944] ata1.00: cmd 60/00:f8:d8:61:b2/05:00:19:00:00/40 tag 31 nc=
q dma 655360 in
>                         res 40/00:28:d8:7e:b2/00:00:19:00:00/40 Emask 0x1=
 (device error)
> [15786.077950] ata1.00: status: { DRDY }
> [15786.078721] ata1.00: both IDENTIFYs aborted, assuming NODEV
> [15786.078730] ata1.00: revalidation failed (errno=3D-2)
> [15786.078747] ata1: hard resetting link
> [15786.390145] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [15786.391640] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15786.391652] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15786.391920] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15786.391932] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15786.392523] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.397343] ata1.00: ACPI cmd ef/02:00:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15786.397354] ata1.00: ACPI cmd ef/10:03:00:00:00:a0 (SET FEATURES) filt=
ered out
> [15786.397527] ata1.00: ACPI cmd ef/10:09:00:00:00:a0 (SET FEATURES) succ=
eeded
> [15786.397536] ata1.00: ACPI cmd f5/00:00:00:00:00:a0 (SECURITY FREEZE LO=
CK) filtered out
> [15786.397934] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.400238] ata1.00: configured for UDMA/133
> [15786.410829] ata1: EH complete
> [15786.521139] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [15786.521158] ata1.00: irq_stat 0x40000001
> [15786.521169] ata1.00: failed command: READ DMA EXT
> [15786.521188] ata1.00: cmd 25/00:00:28:d0:b1/00:06:19:00:00/e0 tag 17 dm=
a 786432 in
>                         res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9=
 (media error)
> [15786.521195] ata1.00: status: { DRDY ERR }
> [15786.521202] ata1.00: error: { UNC }
> [15786.521937] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.525850] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.528948] ata1.00: configured for UDMA/133
> [15786.529028] sd 0:0:0:0: [sda] tag#17 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE cmd_age=3D2s
> [15786.529038] sd 0:0:0:0: [sda] tag#17 Sense Key : Medium Error [current=
]
> [15786.529047] sd 0:0:0:0: [sda] tag#17 Add. Sense: Unrecovered read erro=
r - auto reallocate failed
> [15786.529055] sd 0:0:0:0: [sda] tag#17 CDB: Read(10) 28 00 19 b1 d0 28 0=
0 06 00 00
> [15786.529066] blk_update_request: I/O error, dev sda, sector 431084232 o=
p 0x0:(READ) flags 0x4000 phys_seg 63 prio class 0
> [15786.529150] ata1: EH complete
> [15786.533347] ata1.00: Enabling discard_zeroes_data
> [15786.552084] ata1.00: Enabling discard_zeroes_data

Yeah here's a pretty good bet that discard is included in the btrfs
mount option for this file system. I don't think discards happen
without the file system issuing them, and dm-crypt and device-mapper
for the LVM layer each have discard pass down enabled. It's frequently
the default for LVM these days, but not dm-crypt (it is the default on
Fedora though, for example).

So the drive is not handling queued discard properly is what I
suspect. It gets confused. Face plants. Libata then does a hard reset
to try to get the drive to come back to reality. And then another
discard gets issued and the drive wigs out again.

I'd say it's some kind of defect. Is it unique to this particular
drive and thus a warranty issue? Maybe. Or is it buggy firmware that
affects this entire make/model/firmware? Maybe. If removing discard
mount option fixes the problem, it's probably the latter. But still
worth searching mainline kernel and 5.10.42 if it's in the deny list
for queued trim. If not, worth letting the proper upstream list know
about this problem. If they get more reports, then they'll add the
make/model to the appropriate deny list.

A better option any is scheduled fstrim once a week. Or for very heavy
write, delete, write workloads where it's useful to provide hinting
for unused blocks more often than once per week, use discard=3Dasync.
But for a few weeks at least, I suggest no discard option at all to
see if the problem goes away.


> [15786.820703] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x0
> [15786.820718] ata1.00: irq_stat 0x40000001
> [15786.820728] ata1.00: failed command: READ DMA EXT
> [15786.820748] ata1.00: cmd 25/00:08:c8:d2:b1/00:00:19:00:00/e0 tag 18 dm=
a 4096 in
>                         res 51/40:00:c8:d2:b1/00:00:19:00:00/e0 Emask 0x9=
 (media error)
> [15786.820756] ata1.00: status: { DRDY ERR }
> [15786.820762] ata1.00: error: { UNC }
> [15786.821313] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.824200] ata1.00: supports DRM functions and may not be fully acces=
sible
> [15786.826515] ata1.00: configured for UDMA/133
> [15786.826557] sd 0:0:0:0: [sda] tag#18 FAILED Result: hostbyte=3DDID_OK =
driverbyte=3DDRIVER_SENSE cmd_age=3D0s
> [15786.826567] sd 0:0:0:0: [sda] tag#18 Sense Key : Medium Error [current=
]
> [15786.826575] sd 0:0:0:0: [sda] tag#18 Add. Sense: Unrecovered read erro=
r - auto reallocate failed
> [15786.826584] sd 0:0:0:0: [sda] tag#18 CDB: Read(10) 28 00 19 b1 d2 c8 0=
0 00 08 00
> [15786.826594] blk_update_request: I/O error, dev sda, sector 431084232 o=
p 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
> [15786.826643] ata1: EH complete
> [15786.828426] ata1.00: Enabling discard_zeroes_data
> [15786.830191] BTRFS error (device dm-3): bdev /dev/mapper/sata-home errs=
: wr 0, rd 3, flush 0, corrupt 0, gen 0
> [15786.830206] BTRFS error (device dm-3): unable to fixup (regular) error=
 at logical 176045789184 on dev /dev/mapper/sata-home
> [15930.966633] BTRFS info (device dm-3): scrub: finished on devid 1 with =
status: 0


Yeah I'm not sure if this metadata corruption is the result of
discards. Could be. But the first underlying problem to figure out are
all these ata errors, which point to the drive itself not liking
discards (queued trim), and not something btrfs or device-mapper are
doing wrong.


--=20
Chris Murphy
