Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4284016B0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 09:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhIFHB7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Sep 2021 03:01:59 -0400
Received: from mail-4323.protonmail.ch ([185.70.43.23]:34607 "EHLO
        mail-4323.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbhIFHB7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Sep 2021 03:01:59 -0400
Date:   Mon, 06 Sep 2021 07:00:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1630911653; bh=PnsFzpoajL4VAQ7uj9p3Xi2k8uWKiL77YJLScBb4hGQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=lIELCXm4VbpsQ7LIaYI5kJ79egzkfJUY8pkBFnvuU2YzBMOnOToWPrxWV60dnsp/+
         SbvuqZ5jkQBLd8Y+9+lHesckp6N6NoigBpfPYCn1EjS+KOAS3CT0djKHstD5rw7Kr0
         Nc3W7R+B57w7l0rvviYpCUr4vs7ilUR0HM4V/L4vZ56pXuC2JYFNJmoJmsDyEHaOZM
         7aGiR9AbF+FFDBQYzhyVt5aTdkL7Q9Xjj9/dRyvumFVOkJvl/cDyjnT1AoB+M977bF
         finxGL2NluVYL/FDMHaY8GjKGxAQgjMcJRGy9MLO0APng0MFqp1w12Bxeq6vfnRbOb
         1kUG6K/Wzw+rQ==
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
From:   ahipp0 <ahipp0@pm.me>
Cc:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Reply-To: ahipp0 <ahipp0@pm.me>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <C5tOxTE7_J1eoIcALQiUE09PG9c3gVTon54gyKHZRgDJlTI0QOVoff0zeu2REq4iHD2cWwsVmIbMTmxnBUW3Uv4_grN69kCgSRAXcWusVsY=@pm.me>
In-Reply-To: <7de2d71d-5c75-8215-d5c9-35b4c4f092ca@gmx.com>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me> <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com> <ozcaaGlwEFFj_mq4ZFf_hu1RHtOGruGz8Dwb8HHPEUhCn8Sn3G5BhbJxsMefPbtwacd-dcCJmCv6TbdX1Fdx4r-J_GoHa1rAbB4L4QQWZb0=@pm.me> <5ebaf4e2-a96e-a34a-f509-2a29154149eb@gmx.com> <tDw4sk7EvCGMpj-jprKJJ0hhti2ZS7oRNek_3A3F8IUrhpxQpMPgKRxrhBmWJoMqhA6iZ_OkO2qRUVYrtnB44rv02yPUh0YZe8Adc0IX1R8=@pm.me> <44dc1e9a-7739-f007-5189-00fd81c0ef26@suse.com> <nlXbBH0TVIiMesk038DMLcR8tUOPa5gWVCWyxtyMLXSgC0l-MItGpoGQQSzXKNC1ZHcj1NXtZqU2czoEA-BTgSgWY6fwv-HPClN7D0PTxIc=@pm.me> <a043852e-d552-1ce3-4b35-bdbb1793f8ad@suse.com> <BhXDP0Vx_AExb9FuTS6hEpr1eRkrux_n7AoNG-T1HOvtJaM7mkRN2Yifk5tIoodD5wSEfErIrpbNISVqeQyJU_w6-VePY5T060AxrmLqOf0=@pm.me> <7de2d71d-5c75-8215-d5c9-35b4c4f092ca@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------0b9cf88ac98f102ee31705d1afdef912559962066e026fb03c2c96e7b5ced55d"; charset=utf-8
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0b9cf88ac98f102ee31705d1afdef912559962066e026fb03c2c96e7b5ced55d
Content-Type: multipart/mixed;boundary=---------------------5ca69195cc0ae1fa187a178f1f9d8d0d

-----------------------5ca69195cc0ae1fa187a178f1f9d8d0d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Monday, September 6th, 2021 at 2:28 AM, Qu wrote:

<snip>

> > $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p4
> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > ERROR: root 257 EXTENT_DATA[488887 4096] csum missing, have: 0, expect=
ed: 12288
> > ERROR: root 257 EXTENT_DATA[488889 4096] csum missing, have: 0, expect=
ed: 16384
> > ERROR: root 257 EXTENT_DATA[488895 0] csum missing, have: 0, expected:=
 12288
> > ERROR: root 257 EXTENT_DATA[488963 0] csum missing, have: 0, expected:=
 8192
> > ERROR: root 257 EXTENT_DATA[488964 0] csum missing, have: 0, expected:=
 8192
> > ERROR: root 257 EXTENT_DATA[488966 0] csum missing, have: 0, expected:=
 8192
> > ERROR: root 257 EXTENT_DATA[488967 0] csum missing, have: 0, expected:=
 8192
> > ERROR: errors found in fs roots
> > found 70414278656 bytes used, error(s) found
> > total csum bytes: 68552088
> > total tree bytes: 209338368
> > total fs tree bytes: 111853568
> > total extent tree bytes: 14024704
> > btree space waste bytes: 41823418
> > file data blocks allocated: 73253691392
> > referenced 70072770560
> =


> Even at this stage, your fs is considered clean already.
> =


> The missing csum is really not a big deal.

Ah, ok.

<snip>

> > =


> > After deleting the whole /mnt/hippo//home-andrey/.steam/debian-install=
ation/config/htmlcache/Cache directory,
> > it seems the filesystem is clean.
> > =


> > $ sudo ./btrfs check /dev/nvme0n1p4
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p4
> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 70097395712 bytes used, no error found
> > total csum bytes: 68235972
> > total tree bytes: 206290944
> > total fs tree bytes: 109363200
> > total extent tree bytes: 13598720
> > btree space waste bytes: 41683028
> > file data blocks allocated: 72939855872
> > referenced 69761359872
> > =


> > $ sudo ./btrfs check --mode=3Dlowmem /dev/nvme0n1p4
> > Opening filesystem to check...
> > Checking filesystem on /dev/nvme0n1p4
> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > [4/7] checking fs roots
> > [5/7] checking only csums items (without verifying data)
> > [6/7] checking root refs done with fs roots in lowmem mode, skipping
> > [7/7] checking quota groups skipped (not enabled on this FS)
> > found 70097395712 bytes used, no error found
> > total csum bytes: 68235972
> > total tree bytes: 206290944
> > total fs tree bytes: 109363200
> > total extent tree bytes: 13598720
> > btree space waste bytes: 41683028
> > file data blocks allocated: 72939855872
> > referenced 69761359872
> > =


> > $ sudo ./btrfs scrub status /mnt/hippo/
> > UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> > Scrub started: Mon Sep 6 02:06:54 2021
> > Status: finished
> > Duration: 0:00:22
> > Total to scrub: 65.28GiB
> > Rate: 2.97GiB/s
> > Error summary: no errors found
> > =


> > Can the filesystem now be considered clean as in "never corrupted"?
> > =


> > Or is there still a reason to reformat it?
> =


> It's completely clean now, congratulations.

Woo-hoo, awesome, thank you so much for your help!!

BTRFS rocks!

> BTW, you may want to migrate to v2 space cache.

Ah, OK, migrated.
I guess I used v1 just because it's the default.

$ sudo ./btrfs check --clear-space-cache v1 /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
Free space cache cleared

$ sudo ./btrfs check --clear-space-cache v2 /dev/nvme0n1p4
Opening filesystem to check...
Checking filesystem on /dev/nvme0n1p4
UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
no free space cache v2 to clear

$ mount -o noatime,subvol=3Dandrey,space_cache=3Dv2 /dev/nvme0n1p4 /mnt/hi=
ppo/
$


> The relation between v1 cache problem and the block group item mismatch
> problem is still unknown, but I guess v1 space cache may cause the probl=
em.
> =


> Thus going to v2 would be a little more safe, and faster.

Huh, ok, let's see how v2 performs now.

> > Would using DUP profile for metadata and system help with this kind of=
 corruption?
> =


> Nope, the original corruption looks like some bug in btrfs code,
> DUP/RAID1 won't help to prevent it at all.

Oh, even RAID1 wouldn't have helped?

> But v5.11 kernel (and newer) can prevent such problem, with their
> boosted sanity check.

That's great!

> > Would it be generally advisable to use it going forward?
> You can use the fs without any problem.

Nice!

Is it generally advisable to use DUP profile for metadata and system going=
 forward?

> =


> Thanks,
> =


> Qu
-----------------------5ca69195cc0ae1fa187a178f1f9d8d0d--

--------0b9cf88ac98f102ee31705d1afdef912559962066e026fb03c2c96e7b5ced55d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYKAAYFAmE1vH8AIQkQansmvPyL2SsWIQSmC4s1WhXLLzG+OkVqeya8
/IvZKyghAP9BTtMufJUYieizB1Zqj/ZxjafNRzVTAH1nWKNqOTEyGQEAjvG+
+kV90YSXgX06dxPsfVDI1bem05j/7aJMv4zidQU=
=07tF
-----END PGP SIGNATURE-----


--------0b9cf88ac98f102ee31705d1afdef912559962066e026fb03c2c96e7b5ced55d--

