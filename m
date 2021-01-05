Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B491A2EB25B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jan 2021 19:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbhAEST4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 5 Jan 2021 13:19:56 -0500
Received: from mail.eclipso.de ([217.69.254.104]:59140 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbhAEST4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 Jan 2021 13:19:56 -0500
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 560C4729
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jan 2021 19:19:14 +0100 (CET)
Date:   Tue, 05 Jan 2021 19:19:14 +0100
MIME-Version: 1.0
Message-ID: <8af92960a09701579b6bcbb9b51489cc@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <Cedric.dewijs@eclipso.eu>
Subject: Re: Re: Raid1 of a slow hdd and a fast(er) SSD, howto to prioritize the
        SSD?
Reply-To: " " <Cedric.dewijs@eclipso.eu>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     <linux-btrfs@vger.kernel.org>
In-Reply-To: <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
References: <28232f6c03d8ae635d2ddffe29c82fac@mail.eclipso.de>
        <3c670816-35b9-4bb7-b555-1778d61685c7@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>> I was expecting btrfs to do almost all reads from the fast SSD, as both
the data and the metadata is on that drive, so the slow hdd is only really
needed when there's a bitflip on the SSD, and the data has to be reconstructed.

> IIRC there will be some read policy feature to do that, but not yet
> merged, and even merged, you still need to manually specify the
> priority, as there is no way for btrfs to know which driver is faster
> (except the non-rotational bit, which is not reliable at all).

Manually specifying the priority drive would be a big step in the right direction. Maybe btrfs could get a routine that benchmarks the sequential and random read and write speed of the drives at (for instance) mount time, or triggered by an administrator? This could lead to misleading results if btrfs doesn't get the whole drive to itself.


>> Writing has to be done to both drives of course, but I don't expect
slowdowns from that, as the system RAM should cache that.

>Write can still slow down the system even you have tons of memory.
>Operations like fsync() or sync() will still wait for the writeback,
>thus in your case, it will also be slowed by the HDD no matter what.

>In fact, in real world desktop, most of the writes are from sometimes
>unnecessary fsync().

>To get rid of such slow down, you have to go dangerous by disabling
>barrier, which is never a safe idea.

I suggest a middle ground, where btrfs returns from fsync when one of the copies (instead of all the copies) of the data has been written completely to disk. This poses a small data risk, as this creates  moments that there's only one copy of the data on disk, while the software above btrfs thinks all data is written on two disks. one problem I see if the server is told to shut down while there's a big backlog of data to be written to the slow drive, while the big drive is already done. Then the server could cut the power while the slow drive is still being written.

i think this setting should be given to the system administrator, it's not a good idea to just blindly enable this behavior.

>>
>> Is there a way to tell btrfs to leave the slow hdd alone, and to prioritize
the SSD?

> Not in upstream kernel for now.

> Thus I guess you need something like bcache to do this.

Agreed. However, one of the problems of bcache, it that it can't use 2 SSD's in mirrored mode to form a writeback cache in front of many spindles, so this structure is impossible:
+-----------------------------------------------------------+--------------+--------------+
|                               btrfs raid 1 (2 copies) /mnt                              |
+--------------+--------------+--------------+--------------+--------------+--------------+
| /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 | /dev/bcache4 | /dev/bcache5 |
+--------------+--------------+--------------+--------------+--------------+--------------+
|                          Write Cache (2xSSD in raid 1, mirrored)                        |
|                                 /dev/sda2 and /dev/sda3                                 |
+--------------+--------------+--------------+--------------+--------------+--------------+
| Data         | Data         | Data         | Data         | Data         | Data         |
| /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   | /dev/sda13   | /dev/sda14   |
+--------------+--------------+--------------+--------------+--------------+--------------+

In order to get a system that has no data loss if a drive fails,  the user either has to live with only a read cache, or the user has to put a separate writeback cache in front of each spindle like this:
+-----------------------------------------------------------+
|                btrfs raid 1 (2 copies) /mnt               |
+--------------+--------------+--------------+--------------+
| /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |
+--------------+--------------+--------------+--------------+
| Write Cache  | Write Cache  | Write Cache  | Write Cache  |
|(Flash Drive) |(Flash Drive) |(Flash Drive) |(Flash Drive) |
| /dev/sda5    | /dev/sda6    | /dev/sda7    | /dev/sda8    |
+--------------+--------------+--------------+--------------+
| Data         | Data         | Data         | Data         |
| /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   |
+--------------+--------------+--------------+--------------+

In the mainline kernel is's impossible to put a bcache on top of a bcache, so a user does not have the option to have 4 small write caches below one fast, big read cache like this:
+-----------------------------------------------------------+
|                btrfs raid 1 (2 copies) /mnt               |
+--------------+--------------+--------------+--------------+
| /dev/bcache4 | /dev/bcache5 | /dev/bcache6 | /dev/bcache7 |
+--------------+--------------+--------------++-------------+
|                      Read Cache (SSD)                     |
|                        /dev/sda4                          |
+--------------+--------------+--------------+--------------+
| /dev/bcache0 | /dev/bcache1 | /dev/bcache2 | /dev/bcache3 |
+--------------+--------------+--------------+--------------+
| Write Cache  | Write Cache  | Write Cache  | Write Cache  |
|(Flash Drive) |(Flash Drive) |(Flash Drive) |(Flash Drive) |
| /dev/sda5    | /dev/sda6    | /dev/sda7    | /dev/sda8    |
+--------------+--------------+--------------+--------------+
| Data         | Data         | Data         | Data         |
| /dev/sda9    | /dev/sda10   | /dev/sda11   | /dev/sda12   |
+--------------+--------------+--------------+--------------+

>Thanks,
>Qu

Thank you,
Cedric


---

Take your mailboxes with you. Free, fast and secure Mail &amp; Cloud: https://www.eclipso.eu - Time to change!


