Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF85427AC2
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Oct 2021 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhJIOQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Oct 2021 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbhJIOQf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Oct 2021 10:16:35 -0400
X-Greylist: delayed 1856 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Oct 2021 07:14:38 PDT
Received: from savella.carfax.org.uk (2001-ba8-1f1-f0e6-0-0-0-2.autov6rev.bitfolk.space [IPv6:2001:ba8:1f1:f0e6::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6969C061570
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Oct 2021 07:14:38 -0700 (PDT)
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1mZCc4-0000wb-1z; Sat, 09 Oct 2021 14:42:08 +0100
Date:   Sat, 9 Oct 2021 14:42:07 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     FireFish5000 <firefish5000@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Bug / Suspected regression. Multiple block group profiles
 detected on newly created raid1.
Message-ID: <20211009134207.GE1127@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>,
        FireFish5000 <firefish5000@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <CADNS_H6MvByBaYQ7h94DMVQUU9ZjANN8bz90km_6DZykBh6mxw@mail.gmail.com>
 <08f71656-b775-3fe0-62f7-f04c44501858@gmx.com>
 <CADNS_H46D-Hrc90JRRpHS9JdUwvGr41mXsPOFSNb_e2C9h=6zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADNS_H46D-Hrc90JRRpHS9JdUwvGr41mXsPOFSNb_e2C9h=6zA@mail.gmail.com>
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Oct 09, 2021 at 08:24:51AM -0500, FireFish5000 wrote:
> Same warning in v5.14.2. Output is mostly the same except that it
> informs me it'd running a full device TRIM during mkfs.
> 
> >  If you want to use the fs, just do a btrfs balance with "start
> -musage=0" should remove that SINGLE metadata chunk.
> 
> Earlier I ran
> `btrfs balance start -mconvert=raid1,soft /mnt/tmp`
> which seemed to have done the trick. Any notable difference between
> the results of the two commands?

   Qu's takes all the empty metadata chunks and removes them. Mine
(from IRC) takes all the non-RAID-1 chunks and converts them to
RAID-1, whether they're empty or not.

   In this case, all the non-RAID-1 chunks are empty, so they have the
same practical result. If some of the single chunks had metadata in
them, then the convert= version would be the right thing to do.

   Hugo.

> Sincerely,
> A Fish on Fire
> 
> 
> On Sat, Oct 9, 2021 at 7:19 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2021/10/9 19:44, FireFish5000 wrote:
> > > After creating a new btrfs raid1 and was surprised to be greeted with
> > > the warning
> > >
> > > WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> > > WARNING:   Metadata: single, raid1
> > >
> > > I asked on the IRC, and darkling directed me to the mailing list
> > > suspecting this was a regression.
> > > I am on 5.14.8-gentoo-dist with btrfs-progs v5.14.1
> > >
> > > I have attached a script to reproduce this with temporary images/loop devices,
> > > Along with the full output I received when running the script.
> > >
> > > A shortened version of the commands that I ran on my *real drives* and
> > > the relevant output is also provided below for convenience. P at the
> > > end of the device path was inserted incase sleepy joe copies it
> > > thinking its the reproduction script:
> > >
> > > # mkfs.btrfs --force -R free-space-tree -L BtrfsRaid1Test -d raid1 -m
> >
> > This seems to be a recent bug in btrfs-progs which doesn't remove the
> > temporary chunk.
> >
> > You can try the latest v5.14.2 to see if it's solved.
> >
> > If you want to use the fs, just do a btrfs balance with "start
> > -musage=0" should remove that SINGLE metadata chunk.
> >
> > Thanks,
> > Qu
> > > raid1 /dev/sdaP /dev/sdbP; mount /dev/sda /mnt/tmp; btrfs filesystem
> > > df /mnt/tmp
> > > btrfs-progs v5.14.1
> > > ....truncated....
> > > ....truncated....
> > > Data, RAID1: total=1.00GiB, used=0.00B
> > > System, RAID1: total=8.00MiB, used=16.00KiB
> > > Metadata, RAID1: total=1.00GiB, used=176.00KiB
> > > Metadata, single: total=8.00MiB, used=0.00B
> > > GlobalReserve, single: total=3.25MiB, used=0.00B
> > > WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> > > WARNING:   Metadata: single, raid1
> > >

> 
> ##########
> # Get System Info
> uname -r
> + uname -r
> 5.14.8-gentoo-dist
> btrfs version
> + btrfs version
> btrfs-progs v5.14.2 
> 
> ##########
> # Create blank images
> fallocate -l 2G /tmp/tmpImgA
> + fallocate -l 2G /tmp/tmpImgA
> fallocate -l 2G /tmp/tmpImgB
> + fallocate -l 2G /tmp/tmpImgB
> 
> ##########
> # Prepare loopback devices
> modprobe loop
> + modprobe loop
> LOOP_A="$(losetup --show -fP /tmp/tmpImgA)"
> ++ losetup --show -fP /tmp/tmpImgA
> + LOOP_A=/dev/loop0
> LOOP_B="$(losetup --show -fP /tmp/tmpImgB)"
> ++ losetup --show -fP /tmp/tmpImgB
> + LOOP_B=/dev/loop1
> 
> ##########
> # Create raid1
> mkfs.btrfs --force -R free-space-tree -L TmpRaid1 -d raid1 -m raid1 "$LOOP_A" "$LOOP_B"
> + mkfs.btrfs --force -R free-space-tree -L TmpRaid1 -d raid1 -m raid1 /dev/loop0 /dev/loop1
> btrfs-progs v5.14.2 
> See http://btrfs.wiki.kernel.org for more information.
> 
> Performing full device TRIM /dev/loop0 (2.00GiB) ...
> Performing full device TRIM /dev/loop1 (2.00GiB) ...
> Label:              TmpRaid1
> UUID:               eae631be-d48f-484b-af09-8d65a291bbf1
> Node size:          16384
> Sector size:        4096
> Filesystem size:    4.00GiB
> Block group profiles:
>   Data:             RAID1           204.75MiB
>   Metadata:         RAID1           264.00MiB
>   System:           RAID1             8.00MiB
> SSD detected:       yes
> Zoned device:       no
> Incompat features:  extref, skinny-metadata
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  2
> Devices:
>    ID        SIZE  PATH
>     1     2.00GiB  /dev/loop0
>     2     2.00GiB  /dev/loop1
> 
> 
> ##########
> # Mount temp raid1
> mkdir /tmp/tmpRaid1
> + mkdir /tmp/tmpRaid1
> mount "$LOOP_A" /tmp/tmpRaid1
> + mount /dev/loop0 /tmp/tmpRaid1
> 
> ##########
> # Run btrfs df
> btrfs filesystem df /tmp/tmpRaid1
> + btrfs filesystem df /tmp/tmpRaid1
> WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
> WARNING:   Metadata: single, raid1
> Data, RAID1: total=204.75MiB, used=0.00B
> System, RAID1: total=8.00MiB, used=16.00KiB
> Metadata, RAID1: total=256.00MiB, used=128.00KiB
> Metadata, single: total=8.00MiB, used=0.00B
> GlobalReserve, single: total=3.25MiB, used=0.00B
> 
> ##########
> # cleanup
> umount /tmp/tmpRaid1
> + umount /tmp/tmpRaid1
> 
> losetup --detach "$LOOP_A"
> + losetup --detach /dev/loop0
> losetup --detach "$LOOP_B"
> + losetup --detach /dev/loop1
> 
> sync
> + sync
> rmdir /tmp/tmpRaid1/
> + rmdir /tmp/tmpRaid1/
> rm /tmp/tmpImgA
> + rm /tmp/tmpImgA
> rm /tmp/tmpImgB
> + rm /tmp/tmpImgB


-- 
Hugo Mills             | Great films about cricket: Crease
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
