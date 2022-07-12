Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3BD572591
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jul 2022 21:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbiGLTWz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jul 2022 15:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiGLTWk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jul 2022 15:22:40 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65380EFFB1
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 11:59:42 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1657652378; x=1657911578;
        bh=ZvYaW7tK/opRisMsih8uYudalHytbMaVEqj9AnhQZlY=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=doxz/O9I2MbumBR2jVMuw1UIbqs1HEWqfzF8O7gise9H6Hkurxw0PDa8IvXaIMuRr
         mRzihWUOhsOVNAPZg8hhB4slPE9w47Q8NMnN6jgPfNh9EgeQdWgfWmiYoAh6VdQHbY
         vkx4Gx3A1rdvoak1aFWFPAg1LfSXTXdjr5cDe/X0z5/n7KP58STs7b7CZq/nVt91d5
         NwmoSb0KnBH01RDFO4cn3vQh65Qr2E6FBxP9T47g6Rq6PWtKALwXxQ7BsVUWERYbUP
         I5yUvVzI4skL9GIzzr6gY6rPUxI0pw2hEx54fw09kgbGFUXXEN5s0ePPQG8OajRE+D
         odwNdWArU2q7w==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   bobbygiraffe <bobbygiraffe@proton.me>
Reply-To: bobbygiraffe <bobbygiraffe@proton.me>
Subject: BTRFS won't mount in degraded mode
Message-ID: <xFXHE0z7XTw4sOFxt_7BMNV8PKCJsG3Uys9piHu90uJuudz3onQfx7F9oBgnyhhYDbz2UogD_tKi2xr_aHuyKm0TzQHjNpe9g53Rmg3yILg=@proton.me>
Feedback-ID: 51767345:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I'm running a BTRFS filesystem with 8 devices. I believe the data was setup=
 in RAID5 mode, and the metadata was RAID1. Each drive is encrypted with lu=
ks, and decrypted on boot with /etc/crypttab. Recently I had a drive fail a=
nd completely stop working, and the system stopped booting (presumably beca=
use /etc/crypttab was failing). When the drive finally arrived, I took out =
the broken one and connected the new one.

My intention was to mount the filesystem in degraded mode and then use btrf=
s replace to replace the old missing drive with the new drive. However, I'v=
e been unable to mount them.

Here's my setup:

uname -a
Linux bob 5.13.19-2-pve #1 SMP PVE 5.13.19-4 (Mon, 29 Nov 2021 12:10:09 +01=
00) x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.10.1

btrfs fi show
bad tree block 30638080, bytenr mismatch, want=3D30638080, have=3D0
bad tree block 860242231296, bytenr mismatch, want=3D860242231296, have=3D0
ERROR: failed to read block groups: Input/output error
Label: 'BTRFS'  uuid: 76ce90e7-8225-4a34-90e1-2d35e0f4e89a
        Total devices 8 FS bytes used 26.80TiB
        devid    2 size 3.64TiB used 3.06TiB path /dev/mapper/HDDC
        devid    3 size 7.28TiB used 5.52TiB path /dev/mapper/HDDH
        devid    4 size 7.28TiB used 6.32TiB path /dev/mapper/HDDF
        devid    5 size 7.28TiB used 6.73TiB path /dev/mapper/HDDE
        devid    6 size 3.57TiB used 519.00GiB path /dev/mapper/HDDJ
        devid    7 size 3.64TiB used 593.06GiB path /dev/mapper/HDDG
        devid    8 size 3.64TiB used 594.00GiB path /dev/mapper/HDDD
        *** Some devices missing


The command I tried:
mount -t btrfs -o degraded /dev/mapper/HDDD /mnt/btrfs

Resulting in:

[  306.632524] BTRFS info (device dm-15): flagging fs with big metadata fea=
ture
[  306.632528] BTRFS info (device dm-15): allowing degraded mounts
[  306.632530] BTRFS info (device dm-15): disk space caching is enabled
[  306.632531] BTRFS info (device dm-15): has skinny extents
[  306.658947] BTRFS warning (device dm-15): devid 1 uuid b3429c81-83cc-440=
1-8e18-a85d89e320fd is missing
[  307.225260] BTRFS warning (device dm-15): failed to read root (objectid=
=3D9): -5
[  307.232646] BTRFS error (device dm-15): open_ctree failed

I have also checked
 btrfs rescue super-recover -v /dev/mapper/HDDD
All Devices:
        Device: id =3D 7, name =3D /dev/mapper/HDDG
        Device: id =3D 4, name =3D /dev/mapper/HDDF
        Device: id =3D 5, name =3D /dev/mapper/HDDE
        Device: id =3D 2, name =3D /dev/mapper/HDDC
        Device: id =3D 3, name =3D /dev/mapper/HDDH
        Device: id =3D 6, name =3D /dev/mapper/HDDJ
        Device: id =3D 8, name =3D /dev/mapper/HDDD

Before Recovering:
        [All good supers]:
                device name =3D /dev/mapper/HDDG
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDG
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDG
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDF
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDF
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDF
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDE
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDE
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDE
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDC
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDC
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDC
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDH
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDH
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDH
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDJ
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDJ
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDJ
                superblock bytenr =3D 274877906944

                device name =3D /dev/mapper/HDDD
                superblock bytenr =3D 65536

                device name =3D /dev/mapper/HDDD
                superblock bytenr =3D 67108864

                device name =3D /dev/mapper/HDDD
                superblock bytenr =3D 274877906944

        [All bad supers]:

All supers are valid, no need to recover

Another thing I have tried is
btrfs rescue zero-log /dev/mapper/HDDD

bad tree block 30638080, bytenr mismatch, want=3D30638080, have=3D0
bad tree block 31965184, bytenr mismatch, want=3D31965184, have=3D0
ERROR: could not open ctree

Any ideas on what to try next would be appreciated.
