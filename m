Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A693D919C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 17:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235620AbhG1PPp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhG1PPo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 11:15:44 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B7C061757
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 08:15:43 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id o20so4091532oiw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jul 2021 08:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=coImX2G12/OXkLGnZmUjoot4SI90/LBVQXXBdRQgmf8=;
        b=JwsZDzy9pBIP3rKs4oeT+LDtIb63S/DPlXSMwojc31ru42KGHV8XA1y/4FYWw9x6kZ
         jXK5Typ8bgNLYaBtPqut9TrCzR4i1vA7UsRe1gdSBnDmAS4FdmNmeE5WrbIm/JBYiB+C
         UFPmQlDP1u6igwLzVCib0+PiNDSsXpaLQY7ArPkNKah4GlhXDMx9Lv4gD7kDYNzv0RnT
         S7L8OB568uL9ayTQplrv9Yl3TGrtikjA/hvd+e4zU2QndjYQMIQFrQGgtxhghWV27Hop
         ZCjpUla/AQ/CjjompcmRv591nEzgFvwiAPADGambuMZPZscqHhvodbfzyJXV8sFhNaYq
         czbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=coImX2G12/OXkLGnZmUjoot4SI90/LBVQXXBdRQgmf8=;
        b=MQIbj6iMPsQS14Ar0uVVBFih3CVVoqUBCWrLpL4YYU5H0+1JrbWrkySo9nAhpo6P8U
         MkbM75yy+iwYWcmLpRnNBx9kMugaauktCRJD/9YcT8Kadzp/CzFIbNrom24k6+Z1YpMz
         pDy9Wbn8GbEqBD3qc+zIDoUiUrwttT1Lbh239PUDpzjU4EWtu+n46Zl2spk5UWhXiZBZ
         oEEuljy/li8Er6RMoQV+p8s/7ZPBeACWq+ns4nQmiGKC+wJPGMiV7s4PzGpoHvBHVbn7
         r1Qyw+tgMAFOOqnu6x59Jt+/4O88iKJvTJtEsj7hkIiUo2UWOVl2E2gOrURCqtzNMtbP
         T1pQ==
X-Gm-Message-State: AOAM533V4mLRiH+UuVvv5GW/ZppXFifSoCZ/0Gw0hh3TY0NnjwfBVTgK
        zBvjd715GA95VcuUVthAk5QpF20ThjOY0ayjClQ+KNhTEbw=
X-Google-Smtp-Source: ABdhPJx1xaQIqr+Wz6lXj7Y7Qr0fahzHI8Rpuxaez/PkLegUbjaKIvRXcreerxoKTfncQuR+IWaauEECoJo4eI2pPdI=
X-Received: by 2002:aca:ad10:: with SMTP id w16mr6734025oie.26.1627485342505;
 Wed, 28 Jul 2021 08:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdWbB5YL40HiF9E0RxCdO96MS7tKg1=CRPT2YSe+vR3eGZUgQ@mail.gmail.com>
 <20210727214049.GH10170@hungrycats.org>
In-Reply-To: <20210727214049.GH10170@hungrycats.org>
From:   Dave T <davestechshop@gmail.com>
Date:   Wed, 28 Jul 2021 11:15:31 -0400
Message-ID: <CAGdWbB61NtG5roK3RUSWRN8i8Zo6qMno0LXhE6zaDLHSWhH3RA@mail.gmail.com>
Subject: Re: BTRFS scrub reports an error but check doesn't find any errors.
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 27, 2021 at 5:44 PM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Sun, Jul 25, 2021 at 01:39:55PM -0400, Dave T wrote:
> > What does the list recommend I do in this case?
> >
> > starting btrfs scrub ...
> > scrub done for 56cea9cf-5374-4a43-b19d-6b0b143dc635
> > Scrub started:    Sun Jul 25 00:40:43 2021
> > Status:           finished
> > Duration:         2:52:45
> > Total to scrub:   1.26TiB
> > Rate:             113.72MiB/s
> > Error summary:    read=3D1
> >   Corrected:      0
> >   Uncorrectable:  1
> >   Unverified:     0
> > ERROR: there are uncorrectable errors
>
> This is a read failure (data not available from device), not a csum error
> (data available but not correct).

Thank you.

>
> > dmesg | grep "checksum error at" | tail -n 20
> > (no output)
>
> You should be looking for a IO failure on the underlying device (the
> one below /dev/mapper/userluks).

That would be /dev/sde in my case.

> Look for log messages that appear just
> before btrfs errors, or errors mentioning the device itself:
>
>         dmesg | grep -B99 -i btrfs
>
>         dmesg | grep -C9 sda
>

Here is the complete output from a new scrub, including the output of
the commands above.

# fpath=3D"/home/userdata"

# check_space "$fpath"
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/userluks  2.8T  1.2T  1.7T  42% /home/userdata
Data, single: total=3D1.25TiB, used=3D1.11TiB
System, DUP: total=3D32.00MiB, used=3D160.00KiB
Metadata, DUP: total=3D6.00GiB, used=3D5.32GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

# balance "$fpath"
starting btrfs balance for /home/userdata
Done, had to relocate 10 out of 1284 chunks

real    101m35.135s
user    0m0.000s
sys     0m32.991s
-----------------------

# scrub "$fpath"
starting btrfs scrub ...
scrub done for 56cea9cf-5374-4a43-b19d-6b0b143dc635
Scrub started:    Tue Jul 27 19:46:25 2021
Status:           finished
Duration:         2:09:17
Total to scrub:   1.25TiB
Rate:             151.98MiB/s
Error summary:    read=3D1
  Corrected:      0
  Uncorrectable:  1
  Unverified:     0
ERROR: there are uncorrectable errors


# btrfs fi us /home/userdata/
Overall:
    Device size:                   2.73TiB
    Device allocated:              1.25TiB
    Device unallocated:            1.48TiB
    Device missing:                  0.00B
    Used:                          1.12TiB
    Free (estimated):              1.60TiB      (min: 883.62GiB)
    Free (statfs, df):             1.60TiB
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)
    Multiple profiles:                  no

Data,single: Size:1.24TiB, Used:1.11TiB (90.10%)
   /dev/mapper/userluks    1.24TiB

Metadata,DUP: Size:6.00GiB, Used:5.35GiB (89.17%)
   /dev/mapper/userluks   12.00GiB

System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
   /dev/mapper/userluks   64.00MiB

Unallocated:
   /dev/mapper/userluks    1.48TiB

# lsblk
NAME         LABEL      UUID                                 PARTUUID
                           MODEL                 SIZE SERIAL
    MOUNTPOINT

sde
                           ST3000DM001-1CH166    2.7T XXXXXXX
=E2=94=94=E2=94=80sde1                  56cea9cf-3566-49f3-8abf-e59246f88a4=
3
5db1ed2f-572e-4388-920b-6e4bfabf9e72                       2.7T
  =E2=94=94=E2=94=80userluks USERCOMMON 56cea9cf-5374-4a43-b19d-6b0b143dc63=
5
                                                 2.7T
    /mnt/temp/user


dmesg | grep -B99 -i btrfs
The only relevant output is:

[  +0.025578] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[  +0.000983] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[  +0.026646] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[  +0.001383] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[Jul28 00:03] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[  +0.001119] BTRFS warning (device dm-4): qgroup rescan init failed,
qgroup is not enabled
[  +1.828343] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +0.001132] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +0.029263] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +0.000969] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +0.068749] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +0.005558] BTRFS warning (device dm-0): qgroup rescan init failed,
qgroup is not enabled
[  +2.872178] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled
[  +0.024708] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled
[  +0.041130] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled
[  +4.115641] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled
[  +0.032633] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled
[  +0.059885] BTRFS warning (device dm-2): qgroup rescan init failed,
qgroup is not enabled

# dmesg | grep -C9 sde
(no output)

The journal shows:

Jul 27 21:54:39 server kernel: ata10.00: exception Emask 0x0 SAct
0xffffffff SErr 0x0 action 0x0
Jul 27 21:54:39 server kernel: ata10.00: irq_stat 0x40000008
Jul 27 21:54:39 server kernel: ata10.00: failed command: READ FPDMA QUEUED
Jul 27 21:54:39 server kernel: ata10.00: cmd
60/00:90:98:2f:9f/03:00:a4:00:00/40 tag 18 ncq dma 393216 in
                                         res
41/40:00:20:32:9f/00:03:a4:00:00/00 Emask 0x409 (media error) <F>
Jul 27 21:54:39 server kernel: ata10.00: status: { DRDY ERR }
Jul 27 21:54:39 server kernel: ata10.00: error: { UNC }
Jul 27 21:54:39 server kernel: ata10.00: configured for UDMA/133
Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE cmd_age=3D3s
Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Sense Key :
Medium Error [current]
Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 Add. Sense:
Unrecovered read error - auto reallocate failed
Jul 27 21:54:39 server kernel: sd 9:0:0:0: [sde] tag#18 CDB: Read(16)
88 00 00 00 00 00 a4 9f 2f 98 00 00 03 00 00 00
Jul 27 21:54:39 server kernel: blk_update_request: I/O error, dev sde,
sector 2761896480 op 0x0:(READ) flags 0x0 phys_seg 15 prio class 0
Jul 27 21:54:39 server kernel: ata10: EH complete
Jul 27 21:54:45 server kernel: ata10.00: exception Emask 0x0 SAct
0x4000000 SErr 0x0 action 0x0
Jul 27 21:54:45 server kernel: ata10.00: irq_stat 0x40000008
Jul 27 21:54:45 server kernel: ata10.00: failed command: READ FPDMA QUEUED
Jul 27 21:54:45 server kernel: ata10.00: cmd
60/08:d0:20:32:9f/00:00:a4:00:00/40 tag 26 ncq dma 4096 in
                                         res
41/40:08:20:32:9f/00:00:a4:00:00/00 Emask 0x409 (media error) <F>
Jul 27 21:54:45 server kernel: ata10.00: status: { DRDY ERR }
Jul 27 21:54:45 server kernel: ata10.00: error: { UNC }
Jul 27 21:54:45 server kernel: ata10.00: configured for UDMA/133
Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 FAILED Result:
hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE cmd_age=3D4s
Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Sense Key :
Medium Error [current]
Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 Add. Sense:
Unrecovered read error - auto reallocate failed
Jul 27 21:54:45 server kernel: sd 9:0:0:0: [sde] tag#26 CDB: Read(16)
88 00 00 00 00 00 a4 9f 32 20 00 00 00 08 00 00
Jul 27 21:54:45 server kernel: blk_update_request: I/O error, dev sde,
sector 2761896480 op 0x0:(READ) flags 0x800 phys_seg 1 prio class 0
Jul 27 21:54:45 server kernel: ata10: EH complete
Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
at logical 1567691653120 on dev /dev/mapper/userluks, physical
1414087852032, root 19911, inode 624993, offset 5717954560, length
4096, links 1 (path: path/to/file/filename.ext)
Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
at logical 1567691653120 on dev /dev/mapper/userluks, physical
1414087852032, root 19989, inode 624993, offset 5717954560, length
4096, links 1 (path: path/to/file/filename.ext)
Jul 27 21:54:45 server kernel: BTRFS warning (device dm-2): i/o error
at logical 1567691653120 on dev /dev/mapper/userluks, physical
1414087852032, root 20199, inode 624993, offset 5717954560, length
4096, links 1 (path: path/to/file/filename.ext)
Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): bdev
/dev/mapper/userluks errs: wr 0, rd 2, flush 0, corrupt 0, gen 0
Jul 27 21:54:45 server kernel: BTRFS error (device dm-2): unable to
fixup (regular) error at logical 1567691653120 on dev
/dev/mapper/userluks
Jul 27 21:55:42 server kernel: BTRFS info (device dm-2): scrub:
finished on devid 1 with status: 0


btrfs su li /home/userdata/

...
ID 19911 gen 152144 top level 257 path @usertop/18053/snapshot
ID 19989 gen 152144 top level 257 path @usertop/18131/snapshot
ID 20199 gen 152144 top level 257 path @usertop/18313/snapshot
...

snapper -c userdata ls

...
18053  | single |       | Fri 01 Jan 2021 12:00:18 AM EST | root |
timeline | timeline         |
18131  | single |       | Mon 04 Jan 2021 12:00:15 AM EST | root |
timeline | timeline         |
18313  | single |       | Mon 11 Jan 2021 12:00:20 AM EST | root |
timeline | timeline         |
...

There are snapshots after that date without any errors. The live (r/w)
file system does not show any errors.

The volume is a 3TB disk, model ST3000DM001-1CH166 (Seagate Barracuda
SATA HDD).

Is there a way to mark sectors on the disk as bad? If so, is it
advisable to keep using this physical disk?

Thanks for sharing your knowledge. This is very helpful.

> > # dmesg | grep -i checksum
> > [  +0.001698] xor: automatically using best checksumming function   avx
> > (not related to BTRFS, right?)
> >
> > # btrfs fi us /path/to/xyz
> > Overall:
> >     Device size:                   2.73TiB
> >     Device allocated:              1.26TiB
> >     Device unallocated:            1.47TiB
> >     Device missing:                  0.00B
> >     Used:                          1.12TiB
> >     Free (estimated):              1.60TiB      (min: 888.70GiB)
> >     Free (statfs, df):             1.60TiB
> >     Data ratio:                       1.00
> >     Metadata ratio:                   2.00
> >     Global reserve:              512.00MiB      (used: 0.00B)
> >     Multiple profiles:                  no
> >
> > Data,single: Size:1.25TiB, Used:1.11TiB (89.38%)
> >    /dev/mapper/userluks    1.25TiB
> >
> > Metadata,DUP: Size:6.00GiB, Used:5.26GiB (87.67%)
> >    /dev/mapper/userluks   12.00GiB
> >
> > System,DUP: Size:32.00MiB, Used:160.00KiB (0.49%)
> >    /dev/mapper/userluks   64.00MiB
>
> Since the error was not corrected, it likely occurred in the data blocks.

Yes, it appears so from the info above.

>
> A metadata error would be correctable, so check wouldn't report it becaus=
e
> the scrub will have already corrected it (assuming the underlying drive
> is still healthy enough to remap bad sectors).
>
> > Unallocated:
> >    /dev/mapper/userluks    1.47TiB
> >
> > # btrfs check /dev/mapper/xyz
>
> That command won't read any data blocks, so it won't see any errors there=
.
>
> > Opening filesystem to check...
> > Checking filesystem on /dev/mapper/xyz
> > UUID: 56cea9cf-5374-4a43-b19d-6b0b143dc635
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 1230187327496 bytes used, no error found
> > total csum bytes: 1195610680
> > total tree bytes: 5648285696
> > total fs tree bytes: 4011016192
> > total extent tree bytes: 379256832
> > btree space waste bytes: 827370015
> > file data blocks allocated: 5497457123328
> >  referenced 5523039584256
> >
> > If more info is needed, please let me know. Recommendations and advice
> > are appreciated.
> > Thank you.
