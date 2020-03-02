Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE02F175743
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 10:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCBJhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 04:37:12 -0500
Received: from savella.carfax.org.uk ([85.119.84.138]:45502 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBJhM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 04:37:12 -0500
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1j8hVd-0002AA-Hz; Mon, 02 Mar 2020 09:37:09 +0000
Date:   Mon, 2 Mar 2020 09:37:09 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Tomasz Chmielewski <mangoo@wpkg.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: balance conversion from RAID-1 to RAID-10 leaves some metadata
 in RAID-1?
Message-ID: <20200302093709.GL1235@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Tomasz Chmielewski <mangoo@wpkg.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56ef4bcdd854a9dde3cbe2f5760592ed@wpkg.org>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 01, 2020 at 07:30:34PM +0900, Tomasz Chmielewski wrote:
> Just finished a conversion from RAID-1 to RAID-10, on Linux 5.5.6:
> 
> # time btrfs balance start -dconvert=raid10 -mconvert=raid10 /data/lxd
> Done, had to relocate 2064 out of 2064 chunks
> 
> real    1811m51.427s
> user    0m0.000s
> sys     1259m34.448s
> 
> 
> # echo $?
> 0
> 
> # dmesg
> (...)
> [211862.205521] BTRFS info (device sda2): found 40805 extents
> [211910.773888] BTRFS info (device sda2): found 40805 extents
> [211965.321150] BTRFS info (device sda2): relocating block group
> 3492979671040 flags data|raid1
> [211972.743476] BTRFS info (device sda2): found 37221 extents
> [212020.193342] BTRFS info (device sda2): found 37221 extents
> [212084.580739] BTRFS info (device sda2): balance: ended with status: 0
> 
> 
> To my surprise, some metadata is still RAID-1 - is it expected?

   It's definitely something that can happen. I think what happens is
that new chunks are created while the balance process is going, so
they never get picked up by the converter. I'd guess it's most likely
to happen on an FS with active writes on it while the balance is
running.

   If it happens again, you can finish off just the unconverted chunks
by adding the "soft" option to the conversion filter:

# btrfs balance start -dconvert=raid10,sort -mconvert=raid10,soft /data/lxd

which will convert only those chunks that aren't already in the target
RAID level.

   Hugo.

> # btrfs fi usage /data/lxd
> Overall:
>     Device size:                   6.91TiB
>     Device allocated:              6.70TiB
>     Device unallocated:          210.40GiB
>     Device missing:                  0.00B
>     Used:                          3.96TiB
>     Free (estimated):              1.46TiB      (min: 1.46TiB)
>     Data ratio:                       2.00
>     Metadata ratio:                   2.00
>     Global reserve:              512.00MiB      (used: 0.00B)
> 
> Data,RAID10: Size:3.32TiB, Used:1.97TiB (59.20%)
>    /dev/sda2       1.66TiB
>    /dev/sdd2       1.66TiB
>    /dev/sdc2       1.66TiB
>    /dev/sdb2       1.66TiB
> 
> Metadata,RAID1: Size:2.00GiB, Used:85.02MiB (4.15%)
>    /dev/sdc2       2.00GiB
>    /dev/sdb2       2.00GiB
> 
> Metadata,RAID10: Size:29.00GiB, Used:12.55GiB (43.27%)
>    /dev/sda2      14.50GiB
>    /dev/sdd2      14.50GiB
>    /dev/sdc2      14.50GiB
>    /dev/sdb2      14.50GiB
> 
> System,RAID10: Size:64.00MiB, Used:400.00KiB (0.61%)
>    /dev/sda2      32.00MiB
>    /dev/sdd2      32.00MiB
>    /dev/sdc2      32.00MiB
>    /dev/sdb2      32.00MiB
> 
> Unallocated:
>    /dev/sda2      53.60GiB
>    /dev/sdd2      53.60GiB
>    /dev/sdc2      51.60GiB
>    /dev/sdb2      51.60GiB
> 
> 
> # btrfs fi df /data/lxd
> Data, RAID10: total=3.32TiB, used=1.97TiB
> System, RAID10: total=64.00MiB, used=400.00KiB
> Metadata, RAID10: total=29.00GiB, used=12.55GiB
> Metadata, RAID1: total=2.00GiB, used=85.02MiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
> 
> 
> # btrfs fi show /data/lxd
> Label: 'lxd5'  uuid: 2b77b498-a644-430b-9dd9-2ad3d381448a
>         Total devices 4 FS bytes used 1.98TiB
>         devid    1 size 1.73TiB used 1.67TiB path /dev/sda2
>         devid    3 size 1.73TiB used 1.67TiB path /dev/sdd2
>         devid    4 size 1.73TiB used 1.68TiB path /dev/sdc2
>         devid    5 size 1.73TiB used 1.68TiB path /dev/sdb2
> 
> 
> 
> 
> Tomasz Chmielewski
> https://lxadm.com

-- 
Hugo Mills             | The problem with programmers and the law is not that
hugo@... carfax.org.uk | they treat laws as code, but that they don't
http://carfax.org.uk/  | understand the VM it runs on.
PGP: E2AB1DE4          |
