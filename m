Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D177E36A458
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 05:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhDYDMn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 23:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYDMm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 23:12:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED08C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 20:12:03 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n127so16300065wmb.5
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t91z5MXtn1up78+3fik4u2Ke1E27QR/Ol+UYuswiepw=;
        b=qiltCTzkp55bQpbTCEcHci+mErO0NFXNDRzt0joDNSzbwxUYz0FuJDRLBlBMjV/xJq
         vSW0mobBkXHYB5yFjqdTuBPGg6UDJnqBZeHuzg3jFaFkMSFxSXqeW+1Y8Y4GcKFZquUd
         Ana6Z0/qXpv7oXBX6f9PpaUVJcfssfREFvRRSmnFD7gznZnVNEXQjRvFnOVv11vww9xh
         qLWD/pnodgUsE4DbRG2VH6J/vKSqKrvIOUMwAp7hC2ySog06X99BQ82DPYlPNETniiny
         7feN21QQC2cgc5ZDP8eilstrSFkUmjIgLIghIN7eEqcX/6FzbH4vMKnoNeewKkQgd0D7
         2YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t91z5MXtn1up78+3fik4u2Ke1E27QR/Ol+UYuswiepw=;
        b=NrQ4kCracisTRJS1jJKjL/LEBiFw9TEql+h4qap3tSI9qB2reDCVWL6cagdueouUex
         +iX36wph01aqWVNZxKAjoaLcRDwSPngjU54u8DYBkuhSeNPwrz19upxtNU7W7dFLd6WO
         2Gx1qOvn9vVstOH9TWWQXGq6EtwQod+pIdp1CLrkI9i7luBPwBh/Hxo+3UbjIjfglT/0
         tdl1MzgDx6CAkvM7IQA0YapW+JDUchxzt5ggOakU4RSn6A03wRrU1oiah1sCvFN98kxH
         qKPN8OjScFd2r8CZOm/YbMC7tYCFBlZgsCsKBKevYpRAiRPR7VVSWWWdT0K0nZreIgdn
         l9/Q==
X-Gm-Message-State: AOAM530z90tbVRveOhagVJtIcptT/EUtxEA/JRIc2z1BK4Np8O7S+VZd
        msPBt6k5Ih3I5vn/ZQzR2hGm1l66gST1Oj0l/NlAaDqFB6pj+/6W
X-Google-Smtp-Source: ABdhPJxBjkWC4hIpXeBUf+xXIOjdBvfN2/+eewi44KMT/zEsvfkZ+IgHssAS4nVy0s8oJoyqMivIeJmDqVQ9pphxWMU=
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr13482325wmk.182.1619320321370;
 Sat, 24 Apr 2021 20:12:01 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 24 Apr 2021 21:11:45 -0600
Message-ID: <CAJCQCtQzVWt8CBTgkjBDWE-ZP1HN6gdLd6_7HD5rhxrPypjHYg@mail.gmail.com>
Subject: fstrim bug with seed+sprout
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.11.12-300.fc34.x86_64
btrfs-progs v5.11.1

When I create a seed device, add a 2nd device and remount rw. The seed
has not been removed. Then fstrim the mounted file system, there is no
error.

Later, I notice I can still mount the sprout without error, but the
seed can't be mounted.

# btrfs fi show
Label: 'btresq'  uuid: 4ed49145-a1d4-45f7-9131-3e9ef71d0bc4
    Total devices 1 FS bytes used 2.36GiB
    devid    1 size 3.27GiB used 3.27GiB path /dev/vda3

Label: 'btrsprout'  uuid: ded321fb-c2d5-41e2-83f3-b29c56559492
    Total devices 2 FS bytes used 2.36GiB
    devid    1 size 3.27GiB used 3.27GiB path /dev/vda3
    devid    2 size 28.13GiB used 1.28GiB path /dev/vda4

# mount /dev/vda3 /mnt
mount: /mnt: wrong fs type, bad option, bad superblock on /dev/vda3,
missing codepage or helper program, or other error.
# dmesg | grep -i btrfs

[  209.944938] BTRFS info (device vda3): using free space tree
[  209.944954] BTRFS info (device vda3): has skinny extents
[  209.950240] BTRFS error (device vda3): bad tree block start, want
5373952 have 0
[  209.950278] BTRFS warning (device vda3): couldn't read tree root
[  209.951611] BTRFS error (device vda3): open_ctree failed
# btrfs check /dev/vda3
Opening filesystem to check...
checksum verify failed on 5373952 wanted 0x0000000000000000 found
0x3e76427c81028f58
checksum verify failed on 5373952 wanted 0x0000000000000000 found
0x3e76427c81028f58
bad tree block 5373952, bytenr mismatch, want=3D5373952, have=3D0
Couldn't read tree root
ERROR: cannot open file system
# mount /dev/vda4 /mnt
# btrfs scrub start /mnt
scrub started on /mnt, fsid ded321fb-c2d5-41e2-83f3-b29c56559492 (pid=3D250=
8)
# btrfs scrub status /mnt
UUID:             ded321fb-c2d5-41e2-83f3-b29c56559492
Scrub started:    Sat Apr 24 22:45:53 2021
Status:           aborted
Duration:         0:00:00
Total to scrub:   2.36GiB
Rate:             0.00B/s
Error summary:    no errors found
[root@localhost-live ~]# dmesg
...
[  235.034276] BTRFS info (device vda4): using free space tree
[  235.034292] BTRFS info (device vda4): has skinny extents
[  244.815594] BTRFS error (device vda4): scrub on devid 1: filesystem
on /dev/vda3 is not writable
[  244.815689] BTRFS info (device vda4): scrub: started on devid 2
[  244.818387] BTRFS info (device vda4): scrub: finished on devid 2
with status: 0


/dev/vda3 "seed"
dev_item.total_bytes    3512729600
dev_item.bytes_used    3510632448

lsblk --bytes
=E2=94=9C=E2=94=80vda3      252:3    0  3512729600  0 part


/dev/vda4 "sprout"
dev_item.total_bytes    30204211200
dev_item.bytes_used    301989888

lsblk --bytes
=E2=94=94=E2=94=80vda4      252:4    0 30204214784  0 part

# btrfs-image -c9 -t4 /dev/vda3 vda3.btrfsimage
checksum verify failed on 5373952 wanted 0x0000000000000000 found
0x3e76427c81028f58
checksum verify failed on 5373952 wanted 0x0000000000000000 found
0x3e76427c81028f58
bad tree block 5373952, bytenr mismatch, want=3D5373952, have=3D0
Couldn't read tree root
ERROR: open ctree failed
ERROR: create failed: -5
# btrfs-image -c9 -t4 /dev/vda4 vda4.btrfsimage

21.5M image file:
https://drive.google.com/file/d/1yhbijHXACWu5FvRfTrf2EjTBzIaFx8wQ/view?usp=
=3Dsharing

I haven't tried to reproduce this yet, so I'm not certain it was the
fstrim. But it seems pretty clear that the file system on vda3 "seed"
is damaged and it's OK on vda4 "sprout", and the damage show metadata
has been zero'd out consistent with misapplied trim. And vda4 probably
survives because enough metadata has already been cow'd to the sprout.

# btrfs rescue chunk -v /dev/vda3
this device is seed device
recover prepare error
Chunk tree recovery failed
# btrfs rescue chunk -v /dev/vda4
All Devices:
    Device: id =3D 2, name =3D /dev/vda4

Scanning: DONE in dev0
DEVICE SCAN RESULT:
Filesystem Information:
    sectorsize: 4096
    nodesize: 16384
    tree root generation: 60
    chunk root generation: 58

All Devices:
    Device: id =3D 2, name =3D /dev/vda4

All Block Groups:
    Block Group: start =3D 5242880, len =3D 8388608, flag =3D 4
    Block Group: start =3D 1095761920, len =3D 268435456, flag =3D 4
    Block Group: start =3D 3511681024, len =3D 268435456, flag =3D 4
    Block Group: start =3D 3813670912, len =3D 33554432, flag =3D 2
    Block Group: start =3D 3847225344, len =3D 1073741824, flag =3D 1

All Chunks:
    Chunk: start =3D 5242880, len =3D 8388608, type =3D 4, num_stripes =3D =
1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 5242880
    Chunk: start =3D 13631488, len =3D 8388608, type =3D 1, num_stripes =3D=
 1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 13631488
    Chunk: start =3D 22020096, len =3D 1073741824, type =3D 1, num_stripes =
=3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 22020096
    Chunk: start =3D 1095761920, len =3D 268435456, type =3D 4, num_stripes=
 =3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 1095761920
    Chunk: start =3D 1364197376, len =3D 1073741824, type =3D 1, num_stripe=
s =3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 1364197376
    Chunk: start =3D 2437939200, len =3D 1073741824, type =3D 1, num_stripe=
s =3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 1, offset =3D 2437939200
    Chunk: start =3D 3511681024, len =3D 268435456, type =3D 4, num_stripes=
 =3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 2, offset =3D 1048576
    Chunk: start =3D 3813670912, len =3D 33554432, type =3D 2, num_stripes =
=3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 2, offset =3D 303038464
    Chunk: start =3D 3847225344, len =3D 1073741824, type =3D 1, num_stripe=
s =3D 1
        Stripes list:
        [ 0] Stripe: devid =3D 2, offset =3D 336592896

All Device Extents:
    Device extent: devid =3D 1, start =3D 5242880, len =3D 8388608, chunk
offset =3D 5242880
    Device extent: devid =3D 1, start =3D 13631488, len =3D 8388608, chunk
offset =3D 13631488
    Device extent: devid =3D 1, start =3D 22020096, len =3D 1073741824,
chunk offset =3D 22020096
    Device extent: devid =3D 1, start =3D 1095761920, len =3D 268435456,
chunk offset =3D 1095761920
    Device extent: devid =3D 1, start =3D 1364197376, len =3D 1073741824,
chunk offset =3D 1364197376
    Device extent: devid =3D 1, start =3D 2437939200, len =3D 1073741824,
chunk offset =3D 2437939200
    Device extent: devid =3D 2, start =3D 1048576, len =3D 268435456, chunk
offset =3D 3511681024
    Device extent: devid =3D 2, start =3D 303038464, len =3D 33554432, chun=
k
offset =3D 3813670912
    Device extent: devid =3D 2, start =3D 336592896, len =3D 1073741824,
chunk offset =3D 3847225344

CHECK RESULT:
Recoverable Chunks:
  Chunk: start =3D 5242880, len =3D 8388608, type =3D 4, num_stripes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 5242880
      Block Group: start =3D 5242880, len =3D 8388608, flag =3D 4
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 5242880, len =3D
8388608, chunk offset =3D 5242880
  Chunk: start =3D 1095761920, len =3D 268435456, type =3D 4, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 1095761920
      Block Group: start =3D 1095761920, len =3D 268435456, flag =3D 4
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 1095761920, len =3D
268435456, chunk offset =3D 1095761920
  Chunk: start =3D 3511681024, len =3D 268435456, type =3D 4, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 1048576
      Block Group: start =3D 3511681024, len =3D 268435456, flag =3D 4
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 1048576, len =3D
268435456, chunk offset =3D 3511681024
  Chunk: start =3D 3813670912, len =3D 33554432, type =3D 2, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 303038464
      Block Group: start =3D 3813670912, len =3D 33554432, flag =3D 2
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 303038464, len =3D
33554432, chunk offset =3D 3813670912
  Chunk: start =3D 3847225344, len =3D 1073741824, type =3D 1, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 2, offset =3D 336592896
      Block Group: start =3D 3847225344, len =3D 1073741824, flag =3D 1
      Device extent list:
          [ 0]Device extent: devid =3D 2, start =3D 336592896, len =3D
1073741824, chunk offset =3D 3847225344
  Chunk: start =3D 13631488, len =3D 8388608, type =3D 1, num_stripes =3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 13631488
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 13631488, len =3D
8388608, chunk offset =3D 13631488
  Chunk: start =3D 22020096, len =3D 1073741824, type =3D 1, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 22020096
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 22020096, len =3D
1073741824, chunk offset =3D 22020096
  Chunk: start =3D 1364197376, len =3D 1073741824, type =3D 1, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 1364197376
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 1364197376, len =3D
1073741824, chunk offset =3D 1364197376
  Chunk: start =3D 2437939200, len =3D 1073741824, type =3D 1, num_stripes =
=3D 1
      Stripes list:
      [ 0] Stripe: devid =3D 1, offset =3D 2437939200
      No block group.
      Device extent list:
          [ 0]Device extent: devid =3D 1, start =3D 2437939200, len =3D
1073741824, chunk offset =3D 2437939200
Unrecoverable Chunks:

Total Chunks:        9
  Recoverable:        9
  Unrecoverable:    0

Orphan Block Groups:

Orphan Device Extents:

Check chunks successfully with no orphans
Chunk tree recovered successfully


--=20
Chris Murphy
