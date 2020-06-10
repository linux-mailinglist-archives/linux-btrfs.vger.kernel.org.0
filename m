Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0543B1F4B95
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 04:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFJCpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 22:45:34 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:33054 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCpe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Jun 2020 22:45:34 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 7050A709831; Tue,  9 Jun 2020 22:45:33 -0400 (EDT)
Date:   Tue, 9 Jun 2020 22:45:32 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Adam Gold <adam@adamgold.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs raid1 encryption alternatives
Message-ID: <20200610024528.GI10769@hungrycats.org>
References: <em5570d4e3-0ca2-4d92-91a4-3e9eec9a337b@desktop-31mlcgh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em5570d4e3-0ca2-4d92-91a4-3e9eec9a337b@desktop-31mlcgh>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 03, 2020 at 11:59:12AM +0000, Adam Gold wrote:
> I'm intending to create a raid1 mirror using usb3 disks attached to an
> overclocked Raspberry Pi 4. It might not be going into a data center any
> time soon but I've done it before and it ran without fault. It will be used
> for used for general backup and media.
> 
> Last time I used btrfs only, but I want an encryption layer this time for
> which I'm going to use plain-dmcrypt. My understanding is that, like with
> zfs, btrfs should be proximate to the disk sectors so one can make best use
> of all its features (compression, scrubbing etc). I'm considering the
> following two options:
> 
> 1) sda+sdb --> PV --> VG --> btrfs_pool_LV (100% of VG) --> plain-dmcrypt
> 2) sda+sdb --> plain-dmcrypt --> /dev/mapper/btrfs_raid1 --> /mnt/btrfs

Both are wrong for btrfs raid1.  It should be:

        sda -> PV1 -> btrfs_LV1 -> dm-crypt1 -> btrfs_dev1
        sdb -> PV2 -> btrfs_LV2 -> dm-crypt2 -> btrfs_dev2

(i.e. pvcreate /dev/sda1; pvcreate /dev/sdb1; vgcreate VG /dev/sda1 /dev/sdb1;
      lvcreate VG -n btrfs_LV1 /dev/sda1 -l 100%PVS;
      lvcreate VG -n btrfs_LV2 /dev/sdb1 -l 100%PVS;
      cryptsetup luksOpen btrfs_LV1 btrfs_dev1;
      cryptsetup luksOpen btrfs_LV2 btrfs_dev2)

or:

        sda -> dm-crypt1 -> PV1 -> LV btrfs_dev1
        sdb -> dm-crypt2 -> PV2 -> LV btrfs_dev2

(i.e. cryptsetup luksOpen /dev/sda1 PV1;
      cryptsetup luksOpen /dev/sdb1 PV2;
      vgcreate VG /dev/mapper/PV1 /dev/mapper/PV2;
      lvcreate VG -n btrfs_dev1 /dev/mapper/PV1 -l 100%PVS;
      lvcreate VG -n btrfs_dev2 /dev/mapper/PV2 -l 100%PVS)

followed by:

        mkfs.btrfs btrfs_dev1 btrfs_dev2 -mraid1 -draid1

Most block-layer raid1 implementations will not detect corruption on the
drives, and will randomly propagate all data (including corrupted data)
between drives.  If you run single-device btrfs on top of a block-level
raid1 device, btrfs can only tell you about the data you have already
lost.  If you run raid1 btrfs on top of two single block devices, btrfs
can repair corruption errors when they are detected on one of the drives,
and also identify exactly which disk is silently corrupting data so you
can replace the drive.

The first option (plain PVs, encrypted LVs) is required if you need to
have multiple LVs with different encryption keys (or no encryption at all,
e.g. /boot).

The second option (two encrypted PVs, plain LVs inside) is preferable
if you have more LVs than just btrfs, and you want only one key for all
of them, or you want to encrypt the LVM metadata too.

Aside:  it's a really good idea to put a partition table on USB disks,
even if there's only one parition that spans the entire disk.  In an
emergency, you don't want to plug the device into something that looks
at your luksv2 header, doesn't see a partition table, and says "I see
you have a blank disk, let me format it for you..."

> I look at 1) and wonder whether the lvm layers are redundant but they (I
> believe transparently) allow btrfs to format sda+sdb directly .
> 
> My question is, then, in 2) once /dev/mapper/btrfs_raid1 has been opened, is
> it de facto identical to /dev/sda+/dev/sdb from scenario 1) and will
> therefore allow btrfs to use all its capabilities. I believe that in
> scenario 1) will only have to decrypt the LV whereas in 2) I'll have to
> decrypt both disks but I'm not too fussed about that.

This is optimizing in the wrong direction for data integrity.  Each disk
should be fully redundant and isolated.  Until we have multi-device
dm-crypt, that redundancy and isolation includes the crypto layer.

> Thanks in advance for your attention.
