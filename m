Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4419CC21
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbgDBUz0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 16:55:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44731 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389956AbgDBUzX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 16:55:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so4732077lji.11
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Apr 2020 13:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XhpCWHFp5u10QH7CUINeHjfNbQrwjCIcWBG9SNSh0yQ=;
        b=pG8tKfG9uCU7/Yf7nmDNsZz0TnU+ygGHUYG0NwUdd85PuB7sMxO3lJaxo+QPADXTIs
         cWXkZsQXHZDjYJjiFnvLXduG7ZPnAiEa+K5z+ZCEf9b5zFtMJjWKkGxSBudYhPRgdl1B
         8m2+/VHLvYck4A5vZXnKR87U+ZlFLwdyAxe7SaIMqKJn9Pbpd9PwD4Wiu0hkguv1GGIt
         pgBYhUoBfl3nwihB77scibFX6PDLBypGkhcQ5vUea6iIdk9O2ckhEpT3vjWfsILedumY
         VNKynIbj+zBUhMGe6A2QojHjVGlgluF4b0d2cqzNatFcZve5sxy74PsTMuNNO7Zc7nlH
         jAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XhpCWHFp5u10QH7CUINeHjfNbQrwjCIcWBG9SNSh0yQ=;
        b=tScL4LKBusFbL01eeLX9u3X2/3MChDiJTDQqhAZXDWCTwT5c4mUwH8EWb0suHb4dpr
         B+OwDtwa6/ny3WfzTFZup8bJQahKa3Xos00nKbi/q2cypYvwjaAEanQBrRurHa0ZTzUm
         P9Vk2WwMRWu/sfw4Cfw5SCd6NxlyMTZStdoygvS5PD7IeeIrshhZnz6AUMGE65G26tbf
         EWDlbyDqu+qC5AjHmZJSFK8t9NUUGzVTeC6vjgrbWN3fd8b9X0iBb/rTY7cgLuL/M/s9
         T9ay8yr/6Xvk94y0Xs6xk01wnFIjt9tIVwANg1SKWeSp+0CRb3S+JWLra4NUbM75FDpa
         CS0w==
X-Gm-Message-State: AGi0PuZ8xxBQ+W9jZWLgXqfkTrHyowymrzrUpO8Zp14lDAHKI/ajf8/T
        ZuvkdKlIxASq5WkFyIHJrSMgaJwtj0G7tnomCv7a6YGb73E=
X-Google-Smtp-Source: APiQypLCIoWSy1xcH19bq9iBbY0Qwp7ipoCSRshSZnZDTEA8PfmBJdNdLtfIemTeIs4b3ji891iTuU734qmnhClXRoM=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr3101379lji.156.1585860920668;
 Thu, 02 Apr 2020 13:55:20 -0700 (PDT)
MIME-Version: 1.0
From:   Helper Son <helperson2000@gmail.com>
Date:   Thu, 2 Apr 2020 17:55:08 -0300
Message-ID: <CANs+87QtdRhxx8gSsHzweMfbznJXLXRdn3SQDPd5uv-K-BZM=w@mail.gmail.com>
Subject: btrfs filesystem takes too long to mount, fails the first time it
 attempts during system boot
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I'm running a fully updated Manjaro install on kernel
5.5.13-1-MANJARO, but this problem occurs on other kernel versions as
well. I believe I tried 5.4 and 5.6.

I have a btrfs filesystem that looks like this:

Overall:
    Device size:                  14.55TiB
    Device allocated:             10.75TiB
    Device unallocated:            3.80TiB
    Device missing:                  0.00B
    Used:                         10.74TiB
    Free (estimated):              3.81TiB      (min: 1.91TiB)
    Data ratio:                       1.00
    Metadata ratio:                   2.00
    Global reserve:              512.00MiB      (used: 0.00B)

Data,single: Size:10.71TiB, Used:10.70TiB (99.92%)
   /dev/sda        5.35TiB
   /dev/sdb        5.36TiB

Metadata,RAID1: Size:21.00GiB, Used:20.12GiB (95.82%)
   /dev/sda       21.00GiB
   /dev/sdb       21.00GiB

System,RAID1: Size:32.00MiB, Used:1.22MiB (3.81%)
   /dev/sda       32.00MiB
   /dev/sdb       32.00MiB

Unallocated:
   /dev/sda        1.90TiB
   /dev/sdb        1.90TiB

Label: 'data'  uuid: 3b1f936a-62d0-4d5e-a5e3-e751ce332100
        Total devices 2 FS bytes used 10.72TiB
        devid    2 size 7.28TiB used 5.37TiB path /dev/sda
        devid    3 size 7.28TiB used 5.38TiB path /dev/sdb

Data, single: total=10.71TiB, used=10.70TiB
System, RAID1: total=32.00MiB, used=1.22MiB
Metadata, RAID1: total=21.00GiB, used=20.12GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

And a fstab entry that looks like this:

UUID=3b1f936a-62d0-4d5e-a5e3-e751ce332100    /data    btrfs
noatime,nofail,nossd,autodefrag,compress-force=lzo 0 0

When the system was at only a couple terabytes of usage, everything
was fine. But, as it got progressively filled with more data, it
started to take longer to mount during bootup. At one point it
extrapolated the 90 second limit and the system failed to boot because
of that; I then added nofail to the fstab entry so boot would continue
while the system mounted.

However, even after taking around two minutes to mount, it still fails:

[    4.446819] BTRFS: device label data devid 2 transid 66582 /dev/sda
scanned by systemd-udevd (444)
[    4.446864] BTRFS: device label data devid 3 transid 66582 /dev/sdb
scanned by systemd-udevd (417)
[    4.590357] BTRFS info (device sda): enabling auto defrag
[    4.590365] BTRFS info (device sda): force lzo compression, level 0
[    4.590372] BTRFS info (device sda): using free space tree
[    4.590375] BTRFS info (device sda): has skinny extents
[  129.164306] BTRFS error (device sda): open_ctree failed

After this happens, I issue a sudo mount -a command. It takes another
two minutes to run, but the filesystem mounts successfully this time.

This shows up as soon as I issue the mount -a command, and about two
minutes later the filesystem is available.

[  241.330917] BTRFS info (device sda): enabling auto defrag
[  241.330920] BTRFS info (device sda): force lzo compression, level 0
[  241.330922] BTRFS info (device sda): using free space tree
[  241.330922] BTRFS info (device sda): has skinny extents

I have run full balance operations (-musage=95 -dusage=95), a couple
full scrubs and even a full defrag with absolutely no problems or
errors. All the data is there and working properly and I have no
issues accessing it. If I unmount the filesystem and try to mount it
again it takes another two minutes to finish again, but works fine
otherwise.

Is there anything I can do to fix this? Other than running balances,
scrubs and defrags I also tried converting my free space cache to v2
(space_cache=v2) but nothing changed. I don't have a problem with the
filesystem taking a long time to mount (even though it is annoying)
since I only do that once per boot up, but I'd prefer it didn't and
specially don't like to have to mount it manually after the automatic
mount fails.

Any ideas?
