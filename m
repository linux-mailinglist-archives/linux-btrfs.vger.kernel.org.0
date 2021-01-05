Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0A22EA582
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbhAEGjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 5 Jan 2021 01:39:47 -0500
Received: from mail.eclipso.de ([217.69.254.104]:52336 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbhAEGjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 01:39:47 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 26EF1C14
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 07:39:05 +0100 (CET)
Date:   Tue, 05 Jan 2021 07:39:05 +0100
MIME-Version: 1.0
Message-ID: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Raid1 of a slow hdd and a fast(er) SSD,  howto to prioritize the SSD?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

­I have put a SSD and a slow laptop HDD in btrfs raid. This was a bad idea, my system does not feel responsive. When i load a program, dstat shows half of the program is loaded from the SSD, and the rest from the slow hard drive.

I was expecting btrfs to do almost all reads from the fast SSD, as both the data and the metadata is on that drive, so the slow hdd is only really needed when there's a bitflip on the SSD, and the data has to be reconstructed.

Writing has to be done to both drives of course, but I don't expect slowdowns from that, as the system RAM should cache that. 

Is there a way to tell btrfs to leave the slow hdd alone, and to prioritize the SSD?

In detail:

# mkfs.btrfs -f -d raid1 -m raid1 /dev/sda1 /dev/sdb1

# btrfs filesystem show /
Label: none  uuid: 485952f9-0cfc-499a-b5c2-xxxxxxxxx
	Total devices 2 FS bytes used 63.62GiB
	devid    2 size 223.57GiB used 65.03GiB path /dev/sda1
	devid    3 size 149.05GiB used 65.03GiB path /dev/sdb1


 $ dstat -tdD sda,sdb --nocolor
----system---- --dsk/sda-- --dsk/sdb--
     time     | read  writ: read  writ
05-01 08:19:39|   0     0 :   0     0 
05-01 08:19:40|   0  4372k:   0  4096k
05-01 08:19:41|  61M 4404k:  16k 4680k
05-01 08:19:42|  52M    0 :6904k    0 
05-01 08:19:43|4556k   76k:  31M   76k
05-01 08:19:44|2640k    0 :  38M    0 
05-01 08:19:45|4064k    0 :  30M    0 
05-01 08:19:46|1252k    0 :  30M    0 
05-01 08:19:47|2572k    0 :  37M    0 
05-01 08:19:48|5840k    0 :  27M    0 
05-01 08:19:49|4480k  492k:  22M  492k
05-01 08:19:50|1284k    0 :  44M    0 
05-01 08:19:51|1184k    0 :  33M    0 
05-01 08:19:52|3592k    0 :  31M    0 
05-01 08:19:53|  14M  156k:8268k  156k
05-01 08:19:54|  22M 1956k:   0  1956k
05-01 08:19:55|   0     0 :   0     0 
05-01 08:19:56|7636k    0 :   0     0 
05-01 08:19:57|  23M  116k:   0   116k
05-01 08:19:58|2296k  552k:   0   552k
05-01 08:19:59| 624k  132k:   0   132k
05-01 08:20:00|   0     0 :   0     0 
05-01 08:20:01|6948k  188k:   0   188k
05-01 08:20:02|   0  1340k:4364k 1340k
05-01 08:20:03|   0     0 :   0     0 
05-01 08:20:04|   0   484k:   0   484k
05-01 08:20:05|   0     0 :   0     0 
05-01 08:20:06|   0     0 :   0     0 
05-01 08:20:07|   0     0 :   0     0 
05-01 08:20:08|   0    84k:   0    84k
05-01 08:20:09|   0   132k:   0   132k
05-01 08:20:10|   0     0 :   0     0 
05-01 08:20:11|   0  7616k:  96k 7584k
05-01 08:20:12|   0  2264k:   0  2296k
05-01 08:20:13|   0     0 :   0     0 
05-01 08:20:14|   0  1956k:   0  1956k
05-01 08:20:15|   0     0 :   0     0 
05-01 08:20:16|   0     0 :   0     0 

# fdisk -l
**This is the SSD**
Disk /dev/sda: 223.57 GiB, 240057409536 bytes, 468862128 sectors
Disk model: CT240BX200SSD1  
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: dos
Disk identifier: 0x12cfb9e1

Device     Boot Start       End   Sectors   Size Id Type
/dev/sda1        2048 468862127 468860080 223.6G 83 Linux

**This is the hard drive**
Disk /dev/sdb: 149.05 GiB, 160041885696 bytes, 312581808 sectors
Disk model: Hitachi HTS54321
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x20000000

Device     Boot Start       End   Sectors  Size Id Type
/dev/sdb1        2048 312581807 312579760  149G 83 Linux



---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


