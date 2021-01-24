Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD44F301E84
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Jan 2021 20:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbhAXTsm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 14:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAXTsk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 14:48:40 -0500
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E72C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 11:48:00 -0800 (PST)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1l3lKs-0008G7-IB; Sun, 24 Jan 2021 19:46:10 +0000
Date:   Sun, 24 Jan 2021 19:46:10 +0000
From:   Hugo Mills <hugo@carfax.org.uk>
To:     Jakob =?iso-8859-1?Q?Sch=F6ttl?= <jschoett@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Cannot resize filesystem: not enough free space
Message-ID: <20210124194610.GG4090@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        Jakob =?iso-8859-1?Q?Sch=F6ttl?= <jschoett@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <8735yqw5wm.fsf@gmail.com>
 <20210124182828.GF4090@savella.carfax.org.uk>
 <87mtwyup3q.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mtwyup3q.fsf@gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 24, 2021 at 08:11:37PM +0100, Jakob Schöttl wrote:
> 
> Hugo Mills <hugo@carfax.org.uk> writes:
> 
> > On Sun, Jan 24, 2021 at 07:23:21PM +0100, Jakob Schöttl wrote:
> > > 
> > > Help please, increasing the filesystem size doesn't work.
> > > 
> > > When mounting my btrfs filesystem, I had errors saying, "no space
> > > left
> > > on device". Now I managed to mount the filesystem with -o
> > > skip_balance but:
> > > 
> > > # btrfs fi df /mnt
> > > Data, RAID1: total=147.04GiB, used=147.02GiB
> > > System, RAID1: total=8.00MiB, used=48.00KiB
> > > Metadata, RAID1: total=1.00GiB, used=458.84MiB
> > > GlobalReserve, single: total=181.53MiB, used=0.00B
> > 
> >    Can you show the output of "sudo btrfs fi show" as well?
> > 
> >    Hugo.
> 
> Thanks, Hugo, for the quick response.
> 
> # btrfs fi show /mnt/
> Label: 'data'  uuid: fc991007-6ef3-4c2c-9ca7-b4d637fccafb
>        Total devices 2 FS bytes used 148.43GiB
>        devid    1 size 232.89GiB used 149.05GiB path /dev/sda
>        devid    2 size 149.05GiB used 149.05GiB path /dev/sdb
> 
> Oh, now I see! Resize only worked for one sda!
> 
> # btrfs fi resize 1:max /mnt/
> # btrfs fi resize 2:max /mnt/
> # btrfs fi show /mnt/
> Label: 'data'  uuid: fc991007-6ef3-4c2c-9ca7-b4d637fccafb
>        Total devices 2 FS bytes used 150.05GiB
>        devid    1 size 232.89GiB used 151.05GiB path /dev/sda
>        devid    2 size 465.76GiB used 151.05GiB path /dev/sdb
> 
> Now it works. Thank you!

   Note that the new configuration is going to waste about 232 GiB of
/dev/sdb, because you've got RAID-1, and there won't be spare space to
mirror anything onto once /dev/sda fills up.

   You can add a third device of 232 GiB (250 GB) or more to the FS
and that'll allow the use of the remaining space on /dev/sdb.

   Hugo.

> > > It is full and resize doesn't work although both block devices sda
> > > and
> > > sdb have more 250 GB and more nominal capacity (I don't have
> > > partitions,
> > > btrfs is directly on sda and sdb):
> > > 
> > > # fdisk -l /dev/sd{a,b}*
> > > Disk /dev/sda: 232.89 GiB, 250059350016 bytes, 488397168 sectors
> > > [...]
> > > Disk /dev/sdb: 465.76 GiB, 500107862016 bytes, 976773168 sectors
> > > [...]
> > > 
> > > I tried:
> > > 
> > > # btrfs fi resize 230G /mnt
> > > runs without errors but has no effect
> > > 
> > > # btrfs fi resize max /mnt
> > > runs without errors but has no effect
> > > 
> > > # btrfs fi resize +1G /mnt
> > > ERROR: unable to resize '/mnt': no enough free space
> > > 
> > > Any ideas? Thank you!
> 
> 

-- 
Hugo Mills             | Have found Lost City of Atlantis. High Priest is
hugo@... carfax.org.uk | winning at quoits.
http://carfax.org.uk/  |
PGP: E2AB1DE4          |                                       Terry Pratchett
