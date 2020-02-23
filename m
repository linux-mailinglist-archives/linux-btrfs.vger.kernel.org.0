Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE761699CF
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2020 20:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgBWTfa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Feb 2020 14:35:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39001 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgBWTfa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Feb 2020 14:35:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id e16so4107792qkl.6
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2020 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xAbtzoTBnhudYVI5hUHGZbjuOmdj+fBCHR7Za3hyb9k=;
        b=e+/an9WUziQK2U8gJypbtfx2oUZ3hv5uTVhMERGuo77SrK5KR/dNdskXLBTQUYVP3N
         YkhhfatYDjClDCPc147VZtne71qtJGoIlSF+m6WhormCB4ZeK3zW+LfX0Gq1OQ8nUob/
         3ktr8ZkDFaSwxXUZtkzCvrRl29+oXhg3U1v6/7FmoUB/hK9sE5RmGOPBUtncbSpmHK5A
         nykva3iT116oBSmNgU6DK0ucrD1vtsVGEOcWgHEgVRznugUh7g0uoOghYi5WHiWpzJkW
         /C83OkMm1uNQmqaOvqYov21WXy6Q7Pr50NVC9laZGR+9ft1u/Ac16r+ZK8i8lpFx6DRX
         YeRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xAbtzoTBnhudYVI5hUHGZbjuOmdj+fBCHR7Za3hyb9k=;
        b=aZri2Qxb+3k8ZLCz7oS88UZ4ZlG39vX//zZTuQu7CZz1eJav4X4bExtyrLf6dntRPv
         6l9taoXRT8Rwl0c47XGfVWFE784aP1t/OZwPCpVk07/Soh4VeRaJGSF+yPbzbRHT4Zrr
         Mh/ebMcWa8FhCA9N5DQka/u8IYklfS6BPSG8lvpCD30TZVKdo081/L1F7qxT8/FNuTPM
         E6vtYakbRjxSIx65Ue9OFV1h8huGRc8agXWP+t1BmKYoLWuctVCcFozBUH0YYCaB2eP1
         y5ISrdQhbqvJk5OCG0fgzyEVMoYdpEz5B6qAQcLHYA9Qm6i3JkcAUdX1az+p4VBlNpFj
         lQTg==
X-Gm-Message-State: APjAAAU81Xy2N3FZ/Ftap5A1Vn0IBnjLGRr8MNnfir8fnrnHWBH+hOIp
        yum7UWXm9jnTBEDzd5QMf+Z1aYeeEBWj9cxmZMMccz+H
X-Google-Smtp-Source: APXvYqzOZKgFZ/Hwj+m8n+dDc0V4Kv83xU9SudtsNLeZuDFdKxWWcyhysgWQj1Wkzyh6tLnBNHbEOD5YDPHLlAd0HGs=
X-Received: by 2002:a37:9587:: with SMTP id x129mr16763190qkd.500.1582486528279;
 Sun, 23 Feb 2020 11:35:28 -0800 (PST)
MIME-Version: 1.0
From:   Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Date:   Sun, 23 Feb 2020 20:35:17 +0100
Message-ID: <CAPRPZsBEJyK_1BH1rG6+_t5hYKM8ZUP7xnEx2cWU1Gs=4Bzzag@mail.gmail.com>
Subject: Recommended procedure for device replacement in BTRFS RAID5
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,


I have an array of 4 3TB disks in a BTRFS RAID5 configuration. This
array has been running for 6 years now, but one of the disks is
starting to report raw read errors, which it didn't before. The 3
other members of the array also do not report any of these errors.
Though the SMART value of 200 is nowhere near the threshold of 51,
that very disk is reported with two read errors in 'btrfs device stats
/dev/sdb', as shown in the output below.

On the other hand, I see more than 2 sdb exceptions in dmesg (see
below as well), and 3 of these also seem to occur on the same sector.
There are no UDMA CRC errors reported in smartctl so the link seems to
be good.

Unless someone can explain it isn't necessary to do so, I want to
replace /dev/sdb. I have basically found two approaches: a) remove
/dev/sdb, add a new device and rebalance, and b) use the replace
command. But I found a later report that recommended to remove and
add, and avoid replace. In addition, I found no reports of successful
RAID5 recovery, only failed ones. Also, users tend to ask for help
when they already took wrong steps. That is why I'm posting here now.
I have done exactly nothing yet, not even smartctl testing.

What is the current recommended procedure for this situation ?

The computer has no spare SATA ports, but I can temporarily use a SATA
port that is currently in use by an optical drive.

I have backups, so testing is possible. Kernel is 5.3.0, btrfs tools
are 5.2.1. The array was created 6 years ago by a different kernel and
tools. The devices are used without partitions, and the kernel can
boot without the array, if needed. I have a replacement drive ready.

Regards and thanks,


J.


---

[/dev/sdb].write_io_errs    0
[/dev/sdb].read_io_errs     2
[/dev/sdb].flush_io_errs    0
[/dev/sdb].corruption_errs  0
[/dev/sdb].generation_errs  0

---

Label: none  uuid: 81f5565e-e4e4-4f45-938a-9bd0ba435271
        Total devices 4 FS bytes used 4.40TiB
        devid    1 size 2.73TiB used 1.77TiB path /dev/sdd
        devid    2 size 2.73TiB used 1.77TiB path /dev/sdc
        devid    3 size 2.73TiB used 1.77TiB path /dev/sdb
        devid    4 size 2.73TiB used 1.77TiB path /dev/sda

---

Data, single: total=8.00MiB, used=0.00B
Data, RAID5: total=5.29TiB, used=4.38TiB
System, single: total=4.00MiB, used=0.00B
System, RAID5: total=12.00MiB, used=448.00KiB
Metadata, single: total=8.00MiB, used=0.00B
Metadata, RAID5: total=22.59GiB, used=16.77GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

---

Feb 21 07:03:49 zacate kernel: [1708259.487023] ata2.00: failed
command: READ FPDMA QUEUED
Feb 21 07:03:49 zacate kernel: [1708259.495124] ata2.00: cmd
60/80:80:80:d4:ba/00:00:ea:00:00/40 tag 16 ncq dma 65536 in
Feb 21 07:03:49 zacate kernel: [1708259.495124]          res
41/40:00:d0:d4:ba/00:00:ea:00:00/40 Emask 0x409 (media error) <F>
Feb 21 07:03:49 zacate kernel: [1708259.511334] ata2.00: status: { DRDY ERR }
Feb 21 07:03:49 zacate kernel: [1708259.519358] ata2.00: error: { UNC }
Feb 21 07:03:49 zacate kernel: [1708259.528850] ata2.00: configured for UDMA/133
Feb 21 07:03:49 zacate kernel: [1708259.528946] sd 2:0:0:0: [sdb]
tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Feb 21 07:03:49 zacate kernel: [1708259.528953] sd 2:0:0:0: [sdb]
tag#16 Sense Key : Medium Error [current]
Feb 21 07:03:49 zacate kernel: [1708259.528958] sd 2:0:0:0: [sdb]
tag#16 Add. Sense: Unrecovered read error - auto reallocate failed
Feb 21 07:03:49 zacate kernel: [1708259.528965] sd 2:0:0:0: [sdb]
tag#16 CDB: Read(16) 88 00 00 00 00 00 ea ba d4 80 00 00 00 80 00 00
Feb 21 07:03:49 zacate kernel: [1708259.528970] blk_update_request:
I/O error, dev sdb, sector 3938112720 op 0x0:(READ) flags 0x0 phys_seg
2 prio class 0
Feb 21 07:03:49 zacate kernel: [1708259.533355] ata2: EH complete

Feb 21 07:47:50 zacate kernel: [1710901.394294] ata2.00: exception
Emask 0x0 SAct 0xd1fe0 SErr 0x0 action 0x0
Feb 21 07:47:50 zacate kernel: [1710901.402408] ata2.00: irq_stat 0x40000008
Feb 21 07:47:51 zacate kernel: [1710901.410724] ata2.00: failed
command: READ FPDMA QUEUED
Feb 21 07:47:51 zacate kernel: [1710901.418797] ata2.00: cmd
60/60:28:00:b0:85/00:00:10:01:00/40 tag 5 ncq dma 49152 in
Feb 21 07:47:51 zacate kernel: [1710901.418797]          res
41/40:00:47:b0:85/00:00:10:01:00/40 Emask 0x409 (media error) <F>
Feb 21 07:47:51 zacate kernel: [1710901.434987] ata2.00: status: { DRDY ERR }
Feb 21 07:47:51 zacate kernel: [1710901.443094] ata2.00: error: { UNC }
Feb 21 07:47:51 zacate kernel: [1710901.462648] ata2.00: configured for UDMA/133
Feb 21 07:47:51 zacate kernel: [1710901.462701] sd 2:0:0:0: [sdb]
tag#5 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Feb 21 07:47:51 zacate kernel: [1710901.462708] sd 2:0:0:0: [sdb]
tag#5 Sense Key : Medium Error [current]
Feb 21 07:47:51 zacate kernel: [1710901.462713] sd 2:0:0:0: [sdb]
tag#5 Add. Sense: Unrecovered read error - auto reallocate failed
Feb 21 07:47:51 zacate kernel: [1710901.462720] sd 2:0:0:0: [sdb]
tag#5 CDB: Read(16) 88 00 00 00 00 01 10 85 b0 00 00 00 00 60 00 00
Feb 21 07:47:51 zacate kernel: [1710901.462726] blk_update_request:
I/O error, dev sdb, sector 4572164096 op 0x0:(READ) flags 0x0 phys_seg
11 prio class 0
Feb 21 07:47:51 zacate kernel: [1710901.467188] ata2: EH complete

Feb 22 09:25:56 zacate kernel: [1803187.270074] ata2.00: exception
Emask 0x0 SAct 0x1e0046fc SErr 0x0 action 0x0
Feb 22 09:25:56 zacate kernel: [1803187.278275] ata2.00: irq_stat 0x40000008
Feb 22 09:25:56 zacate kernel: [1803187.286383] ata2.00: failed
command: READ FPDMA QUEUED
Feb 22 09:25:56 zacate kernel: [1803187.294445] ata2.00: cmd
60/e0:70:00:8e:85/00:00:10:01:00/40 tag 14 ncq dma 114688 in
Feb 22 09:25:56 zacate kernel: [1803187.294445]          res
41/40:00:40:8e:85/00:00:10:01:00/40 Emask 0x409 (media error) <F>
Feb 22 09:25:56 zacate kernel: [1803187.310632] ata2.00: status: { DRDY ERR }
Feb 22 09:25:56 zacate kernel: [1803187.318767] ata2.00: error: { UNC }
Feb 22 09:25:56 zacate kernel: [1803187.328334] ata2.00: configured for UDMA/133
Feb 22 09:25:56 zacate kernel: [1803187.328435] sd 2:0:0:0: [sdb]
tag#14 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Feb 22 09:25:56 zacate kernel: [1803187.328447] sd 2:0:0:0: [sdb]
tag#14 Sense Key : Medium Error [current]
Feb 22 09:25:56 zacate kernel: [1803187.328457] sd 2:0:0:0: [sdb]
tag#14 Add. Sense: Unrecovered read error - auto reallocate failed
Feb 22 09:25:56 zacate kernel: [1803187.328468] sd 2:0:0:0: [sdb]
tag#14 CDB: Read(16) 88 00 00 00 00 01 10 85 8e 00 00 00 00 e0 00 00
Feb 22 09:25:56 zacate kernel: [1803187.328478] blk_update_request:
I/O error, dev sdb, sector 4572155392 op 0x0:(READ) flags 0x0 phys_seg
16 prio class 0
Feb 22 09:25:56 zacate kernel: [1803187.332836] ata2: EH complete

Feb 22 13:45:28 zacate kernel: [14956.006814] ata2.00: exception Emask
0x0 SAct 0xffffffff SErr 0x0 action 0x0
Feb 22 13:45:28 zacate kernel: [14956.006848] ata2.00: irq_stat 0x40000008
Feb 22 13:45:28 zacate kernel: [14956.006874] ata2.00: failed command:
READ FPDMA QUEUED
Feb 22 13:45:28 zacate kernel: [14956.006907] ata2.00: cmd
60/80:a0:00:8e:85/00:00:10:01:00/40 tag 20 ncq dma 65536 in
Feb 22 13:45:28 zacate kernel: [14956.006907]          res
41/40:00:40:8e:85/00:00:10:01:00/40 Emask 0x409 (media error) <F>
Feb 22 13:45:28 zacate kernel: [14956.006915] ata2.00: status: { DRDY ERR }
Feb 22 13:45:28 zacate kernel: [14956.006922] ata2.00: error: { UNC }
Feb 22 13:45:28 zacate kernel: [14956.008302] ata2.00: configured for UDMA/133
Feb 22 13:45:28 zacate kernel: [14956.008449] sd 2:0:0:0: [sdb] tag#20
FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Feb 22 13:45:28 zacate kernel: [14956.008460] sd 2:0:0:0: [sdb] tag#20
Sense Key : Medium Error [current]
Feb 22 13:45:28 zacate kernel: [14956.008470] sd 2:0:0:0: [sdb] tag#20
Add. Sense: Unrecovered read error - auto reallocate failed
Feb 22 13:45:28 zacate kernel: [14956.008481] sd 2:0:0:0: [sdb] tag#20
CDB: Read(16) 88 00 00 00 00 01 10 85 8e 00 00 00 00 80 00 00
Feb 22 13:45:28 zacate kernel: [14956.008492] blk_update_request: I/O
error, dev sdb, sector 4572155392 op 0x0:(READ) flags 0x0 phys_seg 12
prio class 0
Feb 22 13:45:28 zacate kernel: [14956.008570] ata2: EH complete

Feb 22 13:47:46 zacate kernel: [15094.214922] ata2.00: exception Emask
0x0 SAct 0x80fff803 SErr 0x0 action 0x0
Feb 22 13:47:46 zacate kernel: [15094.214938] ata2.00: irq_stat 0x40000008
Feb 22 13:47:46 zacate kernel: [15094.214950] ata2.00: failed command:
READ FPDMA QUEUED
Feb 22 13:47:46 zacate kernel: [15094.214970] ata2.00: cmd
60/80:68:00:8e:85/00:00:10:01:00/40 tag 13 ncq dma 65536 in
Feb 22 13:47:46 zacate kernel: [15094.214970]          res
41/40:00:40:8e:85/00:00:10:01:00/40 Emask 0x409 (media error) <F>
Feb 22 13:47:46 zacate kernel: [15094.214979] ata2.00: status: { DRDY ERR }
Feb 22 13:47:46 zacate kernel: [15094.214986] ata2.00: error: { UNC }
Feb 22 13:47:46 zacate kernel: [15094.217259] ata2.00: configured for UDMA/133
Feb 22 13:47:46 zacate kernel: [15094.217359] sd 2:0:0:0: [sdb] tag#13
FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
Feb 22 13:47:46 zacate kernel: [15094.217366] sd 2:0:0:0: [sdb] tag#13
Sense Key : Medium Error [current]
Feb 22 13:47:46 zacate kernel: [15094.217371] sd 2:0:0:0: [sdb] tag#13
Add. Sense: Unrecovered read error - auto reallocate failed
Feb 22 13:47:46 zacate kernel: [15094.217378] sd 2:0:0:0: [sdb] tag#13
CDB: Read(16) 88 00 00 00 00 01 10 85 8e 00 00 00 00 80 00 00
Feb 22 13:47:46 zacate kernel: [15094.217384] blk_update_request: I/O
error, dev sdb, sector 4572155392 op 0x0:(READ) flags 0x0 phys_seg 16
prio class 0
Feb 22 13:47:46 zacate kernel: [15094.217440] ata2: EH complete
