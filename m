Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB531BB8
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jun 2019 14:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfFAMfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 1 Jun 2019 08:35:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34651 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFAMfw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 1 Jun 2019 08:35:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id j24so12151646ljg.1
        for <linux-btrfs@vger.kernel.org>; Sat, 01 Jun 2019 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=90uKMYT3HWtK8USy57F4LJmGLYiuY9r9KPHRhwDOR8Y=;
        b=IVzqVcz5gMjvwXHgTbuXbaSUDyIt5leOD0GxhuzmhEG0gX7T+uXTDxi2OMPEUpKQNL
         d5wri7yCtIh/+Z2Y58Hnu7eUhiV7T2R4R+1sUIkkDPTODdIHNevKgH0Ky2x8JEZKOTyn
         mVNNr/Dqs6+e31WpQn4GYkhfn2RQkGKisbcI759FUPjN/CMBG8r9xHyjnXrsIXpfbmAn
         jbNHk7cI6p4Xx14yI0XzpMvZ55e6nzfU0FjGUBxAvx3MfbZkiLCKr8Cczy6eio26Qvqq
         8xyIX5MOCNNn9LkLTuwQDkHI3ZZznF/1r9C6/LrDL1qqp7hmjsNhuUhJrKTSmgrbFSi2
         DDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=90uKMYT3HWtK8USy57F4LJmGLYiuY9r9KPHRhwDOR8Y=;
        b=SY3Cpq7DHz2eYEkkmtEUrO79PYa6aooNQRgfJSVXNyvzlyXCLO0E3NVGBjrKht1g4x
         JT6xUs+3S48Rxurgmw34kVye07810o9F+en73T0xbOWGQl8dml0ghliQ8MLVG2FR3UUj
         igSM7WT8ElQziePg+3brBtis5e/fTdUdIyxeOuxj+3QX80opC8KRXPTdKMSxu/MTyOaF
         gxslLHfZqGBEacz4X/CA6eixY3Y8ENlVLpHQ1HtiHTd7bGpOfW5yyuKTCS8qIObrZxqw
         hQ0zXuUDI/gQFJ2r3A7QrmcDadSN0rdePehbvOB7HaND6zmdOoZsKHYVHxXWa39vwt1q
         QC7A==
X-Gm-Message-State: APjAAAUASa0ByIVpAbpikXb2v3L4R/kMV+aaYxHOdjFLx3Rk8NVJvX9c
        TbVdhZRj5dNOeurvDeV80+jeg9tuVutlPKRmgZCCHw==
X-Google-Smtp-Source: APXvYqwvZVe1TVSqc0RVWz2o7zNm/ggA8IWVzxzUImeq4w97KIUpDBPtoGJWq6JpbZoDyhRsot6Ik6Ptkitj+DGOYhI=
X-Received: by 2002:a2e:824d:: with SMTP id j13mr8581663ljh.137.1559392549541;
 Sat, 01 Jun 2019 05:35:49 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Hjalmarsson <kanelxake@gmail.com>
Date:   Sat, 1 Jun 2019 14:35:38 +0200
Message-ID: <CALpSwpiYWtje4dDKeOuXVFFguYLKN62+A-3XipV0iaZBz6sG+g@mail.gmail.com>
Subject: Re: 'watch btrfs fi show' crash while 'btrfs device delete'
To:     lists@colorremedies.com
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I was the one reporting the issue to the Red Hat Bugzilla, and was
able to reproduce it as well

The problem is related to resizing a btrfs filesystem (at least with
the helpf of "btrfs dev del") and being able to hit "btrfs fi sh" at
the same time as the size is changed..
Something in the logic for "btrfs filesystem show" will run some tests
against the size of the filesystem, and if there are mismatches in
their results (like in a before and after removing a device) then the
btrfs tool will SIGABRT
I think that the btrfs tool could handle this more pretty, like giving
a message "device resize in progress" istead of SIGABRT.

The oiginal system is a x86_64 based machine with a couple of HDDs in
a btrfs raid setup.

I was able to reproduce this on the following testsystem:
A Raspberry pi 3 running Fedora 30 aarch64 from SD-card
The two HDDs partitioned in two equal sized partitions for a total of
four partitions
The testsystem was used since when using SSD or a RAM-based storage it
seems it is harder t hit this (possibly due to access-speeds
involved).

After this I ran:
# mkfs.btrfs -d raid1 -m raid1 /dev/sd[a-b][1-2]
<..>
# mkdir /mnt/test && mount /dev/sda1 /mnt/test
# btrfs fi df /mnt/test/
Data, RAID1: total=1.00GiB, used=0.00B
System, RAID1: total=8.00MiB, used=16.00KiB
Metadata, RAID1: total=1.00GiB, used=112.00KiB
GlobalReserve, single: total=16.00MiB, used=0.00B
# btrfs fi sh
Label: none  uuid: c34e4190-674b-4111-ba37-8128c1f120f4
        Total devices 4 FS bytes used 128.00KiB
        devid    1 size 149.04GiB used 1.00GiB path /dev/sda1
        devid    2 size 149.04GiB used 1.00GiB path /dev/sda2
        devid    3 size 149.04GiB used 1.01GiB path /dev/sdb1
        devid    4 size 149.04GiB used 1.01GiB path /dev/sdb2
# btrfs dev del /dev/sda2 /mnt/test
# btrfs dev del /dev/sdb2 /mnt/test
# btrfs dev add /dev/sda2 /mnt/test
# btrfs dev add /dev/sdb2 /mnt/test
# btrfs fi sh
Label: none  uuid: c34e4190-674b-4111-ba37-8128c1f120f4
        Total devices 4 FS bytes used 640.00KiB
        devid    1 size 149.04GiB used 2.03GiB path /dev/sda1
        devid    3 size 149.04GiB used 2.03GiB path /dev/sdb1
        devid    4 size 149.04GiB used 0.00B path /dev/sda2
        devid    5 size 149.04GiB used 0.00B path /dev/sdb2


This makes it possible to maximize the amount of device add/remove
from a volume, as removeing any of sda2 or sdb2 does not require
moving any big amount of data, and the add/remove seems to be what
triggered the behaviour from "btrfs fi sh".
Then I ditch "watch" and run a sime "while true"-loop for "btrfs fi
sh" to prevent that the device add/remove happends while watch does it
2 s sleep.

So after this I start the following in one shell:
---
i="0"
while true
do echo $((i++))
btrfs dev del /dev/sda2 /mnt/test/
btrfs dev add /dev/sda2 /mnt/test/
btrfs dev del /dev/sdb2 /mnt/test/
btrfs dev add /dev/sdb2 /mnt/test/
done
---

And in the other shell:
---
while btrfs fi sh ; do true ; done
---


Often the last commando does not need to go for more then 3 to 4 times
before a message like the following:

corrupted size vs. prev_size
Aborted (core dumped)

This one leave the following in the journal:
May 24 13:57:14 localhost systemd-coredump[3198]: Process 3193 (btrfs)
of user 0 dumped core.

                                                      Stack trace of
thread 3193:
                                                      #0
0x0000ffffb669fca0 raise (libc.so.6)
                                                      #1
0x0000ffffb668daa8 abort (libc.so.6)
                                                      #2
0x0000ffffb66d9a0c __libc_message (libc.so.6)
                                                      #3
0x0000ffffb66dffd4 malloc_printerr (libc.so.6)
                                                      #4
0x0000ffffb66e0730 unlink_chunk.isra.0 (libc.so.6)
                                                      #5
0x0000ffffb66e193c _int_free (libc.so.6)
                                                      #6
0x0000ffffb6709c40 closedir (libc.so.6)
                                                      #7
0x0000aaaab1debf48 close_file_or_dir (btrfs)
                                                      #8
0x0000aaaab1dece00 get_fs_info (btrfs)
                                                      #9
0x0000aaaab1e027cc btrfs_scan_kernel (btrfs)
                                                      #10
0x0000aaaab1dcc8dc main (btrfs)
                                                      #11
0x0000ffffb668deec __libc_start_main (libc.so.6)
                                                      #12
0x0000aaaab1dccad8 .annobin_stubs.c_end.startup (btrfs)
                                                      #13
0x0000aaaab1dccad8 .annobin_stubs.c_end.startup (btrfs)
May 24 13:57:14 localhost kernel: BTRFS info (device sda1): device
deleted: /dev/sdb2


I also get this from time to time:

free(): invalid next size (normal)
Aborted (core dumped)

May 24 14:02:32 localhost systemd-coredump[5153]: Process 5148 (btrfs)
of user 0 dumped core.

                                                      Stack trace of
thread 5148:
                                                      #0
0x0000ffffa1491ca0 raise (libc.so.6)
                                                      #1
0x0000ffffa147faa8 abort (libc.so.6)
                                                      #2
0x0000ffffa14cba0c __libc_message (libc.so.6)
                                                      #3
0x0000ffffa14d1fd4 malloc_printerr (libc.so.6)
                                                      #4
0x0000ffffa14d3920 _int_free (libc.so.6)
                                                      #5
0x0000aaaac0ed18c8 btrfs_scan_kernel (btrfs)
                                                      #6
0x0000aaaac0e9b8dc main (btrfs)
                                                      #7
0x0000ffffa147feec __libc_start_main (libc.so.6)
                                                      #8
0x0000aaaac0e9bad8 .annobin_stubs.c_end.startup (btrfs)
                                                      #9
0x0000aaaac0e9bad8 .annobin_stubs.c_end.startup (btrfs)
May 24 14:02:32 localhost kernel: BTRFS info (device sda1): device
deleted: /dev/sda2

Please ask if you need more info.

Best Regard,
Peter
