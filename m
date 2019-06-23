Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ACD4FBC4
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jun 2019 15:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFWNXK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jun 2019 09:23:10 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:38480 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWNXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jun 2019 09:23:10 -0400
Received: by mail-vs1-f44.google.com with SMTP id k9so6871598vso.5
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Jun 2019 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Oamyf+ikJdYguYxlUCUBok9UZcaLjruk1dofndU7FJc=;
        b=NbcOtM70mF8cm3nhapHQBpH72rXieEvZUKI1sZ3gRr+S4NfRqvIk5mRP1g4WuQlUQL
         d6cyJPMtTbzeS4MXkSNR8PB4I7NmryL1yMxRN0EvmCZihJZUL++gzdLVB81yT7LVZq7G
         YdoOgvifCH+QLcTkoCcy0Ghmje2efyCyJDbli4iHc77iyG3j8oGNkwpfCYsj5I1LyyKj
         RxZ8nYqWBbTgYZJD4fs0gY1MnKRYAI4QBfumcizTwoZ4TbFDuZPQaqh6a9YKxer1O455
         m4I1eq8N9NCLV6c+XLnJYBrN57RKSic6PWj6mKyCMdD8joClFTjiAI9F0wjtC5J1ijVx
         mI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Oamyf+ikJdYguYxlUCUBok9UZcaLjruk1dofndU7FJc=;
        b=ZRwHeIr/dvnZw6p1DFe2VPzsiIxwvVZQxgTZd2F1Kr4fpNaDQu83Hp5IsZ6qs1peBM
         7DkWQuoM8xi8ligJzm1o9x8Ah+39mCX4y+DX68whK/II/ilTyF+xktm+pT4boSTClBB0
         HZKizsL2QoVVEJnaPnXgvoogW9jKk38Cng+shlCTbM/OEl6bAPsytWu2bdZdaQdgjl9n
         3swelK0+hrtKkDgvboysZIjCpxQcZtpN6GzIxJwanG3XihhKMT4lEOZAv2qKbNnwVGC2
         l7P0Ecq+CC4sBKBj8nunr+KWrzrxCjyZReGj81M4SLxsgPNj7mFCXnaA8Xs1Lh4QKuxe
         GmbQ==
X-Gm-Message-State: APjAAAXfaRxfwAwA+yfal8IUH7HsuJBDbEanWhGMkzRM+e4bwjn9enFl
        FTYEAbKME0jZWgVZL+nq0psHVbeiutcV+2kP0xXoSERe
X-Google-Smtp-Source: APXvYqxZJkz4j3sb3+v9WEkT71v/KpJBS3jyDOlIBjzWIQRd+knODmh5ksuuqF4zX1fwzGv72xp+l3J5OAS+doBNvoo=
X-Received: by 2002:a67:8d03:: with SMTP id p3mr53608129vsd.173.1561296188369;
 Sun, 23 Jun 2019 06:23:08 -0700 (PDT)
MIME-Version: 1.0
From:   Robert <robertgt4@gmail.com>
Date:   Sun, 23 Jun 2019 15:22:56 +0200
Message-ID: <CAPfCsGuLi6J_CW8_FgA4DQR8-SrOUhmFjZs4imTVW05ta7RXMw@mail.gmail.com>
Subject: Recover files from broken btrfs
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all

I have a ReadyNAS device with 4 4TB disks. It was working all right
for couple of years. At one point the system became read-only, and
after reboot data is inaccessible.
Can anyone give some advise how to recover data from the file system?

system details are
root@Dyskietka:~# uname -a
Linux Dyskietka 4.4.116.armada.1 #1 SMP Mon Feb 19 22:05:00 PST 2018
armv7l GNU/Linux
root@Dyskietka:~# btrfs --version
btrfs-progs v4.12
root@Dyskietka:~# btrfs fi show
Label: '2fe4f8e6:data'  uuid: 0970e8c4-fd47-43d3-aa93-593006e3d0c3
        Total devices 1 FS bytes used 8.11TiB
        devid    1 size 10.90TiB used 8.11TiB path /dev/md127

root@Dyskietka:~# btrfs fi df /dev/md127
ERROR: not a btrfs filesystem: /dev/md127

dmesg
[Sat Jun  1 13:18:48 2019] md/raid:md1: device sdc2 operational as raid disk 0
[Sat Jun  1 13:18:48 2019] md/raid:md1: device sda2 operational as raid disk 3
[Sat Jun  1 13:18:48 2019] md/raid:md1: device sdb2 operational as raid disk 2
[Sat Jun  1 13:18:48 2019] md/raid:md1: device sdd2 operational as raid disk 1
[Sat Jun  1 13:18:48 2019] md/raid:md1: allocated 4294kB
[Sat Jun  1 13:18:48 2019] md/raid:md1: raid level 6 active with 4 out
of 4 devices, algorithm 2
[Sat Jun  1 13:18:48 2019] RAID conf printout:
[Sat Jun  1 13:18:48 2019]  --- level:6 rd:4 wd:4
[Sat Jun  1 13:18:48 2019]  disk 0, o:1, dev:sdc2
[Sat Jun  1 13:18:48 2019]  disk 1, o:1, dev:sdd2
[Sat Jun  1 13:18:48 2019]  disk 2, o:1, dev:sdb2
[Sat Jun  1 13:18:48 2019]  disk 3, o:1, dev:sda2
[Sat Jun  1 13:18:48 2019] md1: detected capacity change from 0 to 1071644672
[Sat Jun  1 13:18:49 2019] EXT4-fs (md0): mounted filesystem with
ordered data mode. Opts: (null)
[Sat Jun  1 13:18:49 2019] systemd[1]: Failed to insert module
'kdbus': Function not implemented
[Sat Jun  1 13:18:49 2019] systemd[1]: systemd 230 running in system
mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS
+KMOD +IDN)
[Sat Jun  1 13:18:49 2019] systemd[1]: Detected architecture arm.
[Sat Jun  1 13:18:49 2019] systemd[1]: Set hostname to <Dyskietka>.
[Sat Jun  1 13:18:50 2019] systemd[1]: Started Dispatch Password
Requests to Console Directory Watch.
[Sat Jun  1 13:18:50 2019] systemd[1]: Listening on /dev/initctl
Compatibility Named Pipe.
[Sat Jun  1 13:18:50 2019] systemd[1]: Listening on Journal Socket (/dev/log).
[Sat Jun  1 13:18:50 2019] systemd[1]: Listening on udev Kernel Socket.
[Sat Jun  1 13:18:50 2019] systemd[1]: Created slice System Slice.
[Sat Jun  1 13:18:50 2019] systemd[1]: Created slice
system-serial\x2dgetty.slice.
[Sat Jun  1 13:18:50 2019] systemd[1]: Reached target Encrypted Volumes.
[Sat Jun  1 13:18:50 2019] systemd[1]: Started Forward Password
Requests to Wall Directory Watch.
[Sat Jun  1 13:18:50 2019] systemd[1]: Listening on Journal Socket.
[Sat Jun  1 13:18:50 2019] systemd[1]: Started ReadyNAS LCD splasher.
[Sat Jun  1 13:18:50 2019] systemd[1]: Starting ReadyNASOS system prep...
[Sat Jun  1 13:18:50 2019] systemd[1]: Mounting RPC Pipe File System...
[Sat Jun  1 13:18:50 2019] systemd[1]: Starting Remount Root and
Kernel File Systems...
[Sat Jun  1 13:18:50 2019] systemd[1]: Starting Create list of
required static device nodes for the current kernel...
[Sat Jun  1 13:18:50 2019] systemd[1]: Mounting POSIX Message Queue
File System...
[Sat Jun  1 13:18:50 2019] systemd[1]: Created slice User and Session Slice.
[Sat Jun  1 13:18:50 2019] systemd[1]: Reached target Slices.
[Sat Jun  1 13:18:50 2019] systemd[1]: Created slice system-getty.slice.
[Sat Jun  1 13:18:50 2019] systemd[1]: Starting Load Kernel Modules...
[Sat Jun  1 13:18:50 2019] systemd[1]: Mounting RPC Pipe File System...
[Sat Jun  1 13:18:50 2019] systemd[1]: Starting Journal Service...
[Sat Jun  1 13:18:50 2019] systemd[1]: Listening on udev Control Socket.
[Sat Jun  1 13:18:50 2019] systemd[1]: Reached target Paths.
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounted RPC Pipe File System.
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounted RPC Pipe File System.
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounted POSIX Message Queue File System.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started ReadyNASOS system prep.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Remount Root and Kernel
File Systems.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Create list of required
static device nodes for the current kernel.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Load Kernel Modules.
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting Apply Kernel Variables...
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounting FUSE Control File System...
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounting Configuration File System...
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting Create Static Device
Nodes in /dev...
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting Load/Save Random Seed...
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting Rebuild Hardware Database...
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounted Configuration File System.
[Sat Jun  1 13:18:51 2019] systemd[1]: Mounted FUSE Control File System.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Apply Kernel Variables.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Load/Save Random Seed.
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Create Static Device
Nodes in /dev.
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting udev Kernel Device Manager...
[Sat Jun  1 13:18:51 2019] systemd[1]: Started udev Kernel Device Manager.
[Sat Jun  1 13:18:51 2019] systemd[1]: Starting MD arrays...
[Sat Jun  1 13:18:51 2019] systemd[1]: Started Journal Service.
[Sat Jun  1 13:18:51 2019] systemd-journald[1058]: Received request to
flush runtime journal from PID 1
[Sat Jun  1 13:18:52 2019] md: md127 stopped.
[Sat Jun  1 13:18:52 2019] md: bind<sdd3>
[Sat Jun  1 13:18:52 2019] md: bind<sdb3>
[Sat Jun  1 13:18:52 2019] md: bind<sda3>
[Sat Jun  1 13:18:52 2019] md: bind<sdc3>
[Sat Jun  1 13:18:52 2019] md/raid:md127: device sdc3 operational as raid disk 0
[Sat Jun  1 13:18:52 2019] md/raid:md127: device sda3 operational as raid disk 3
[Sat Jun  1 13:18:52 2019] md/raid:md127: device sdb3 operational as raid disk 2
[Sat Jun  1 13:18:52 2019] md/raid:md127: device sdd3 operational as raid disk 1
[Sat Jun  1 13:18:52 2019] md/raid:md127: allocated 4294kB
[Sat Jun  1 13:18:52 2019] md/raid:md127: raid level 5 active with 4
out of 4 devices, algorithm 2
[Sat Jun  1 13:18:52 2019] RAID conf printout:
[Sat Jun  1 13:18:52 2019]  --- level:5 rd:4 wd:4
[Sat Jun  1 13:18:52 2019]  disk 0, o:1, dev:sdc3
[Sat Jun  1 13:18:52 2019]  disk 1, o:1, dev:sdd3
[Sat Jun  1 13:18:52 2019]  disk 2, o:1, dev:sdb3
[Sat Jun  1 13:18:52 2019]  disk 3, o:1, dev:sda3
[Sat Jun  1 13:18:52 2019] md127: detected capacity change from 0 to
11987456360448
[Sat Jun  1 13:18:53 2019] Adding 1046524k swap on /dev/md1.
Priority:-1 extents:1 across:1046524k
[Sat Jun  1 13:18:53 2019] BTRFS: device label 2fe4f8e6:data devid 1
transid 155439 /dev/md127
[Sat Jun  1 13:18:53 2019] BTRFS info (device md127): setting nodatasum
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS critical (device md127): unable to
find logical 62139990016 len 4096
[Sat Jun  1 13:18:54 2019] BTRFS error (device md127): failed to read chunk root
[Sat Jun  1 13:18:54 2019] BTRFS error (device md127): open_ctree failed


-- 
regards
Robert
