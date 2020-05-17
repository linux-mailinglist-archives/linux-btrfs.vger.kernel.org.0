Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B101D6C9F
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 May 2020 21:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEQTya (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 May 2020 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTya (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 May 2020 15:54:30 -0400
X-Greylist: delayed 160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 May 2020 12:54:29 PDT
Received: from mxa2.seznam.cz (mxa2.seznam.cz [IPv6:2a02:598:2::90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0775C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 17 May 2020 12:54:29 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc1b.ng.seznam.cz (email-smtpc1b.ng.seznam.cz [10.23.13.15])
        id 1e2a13ce64de791f1e2a11b9;
        Sun, 17 May 2020 21:54:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1589745268; bh=OF46sT8Rut0RW+IZX4RejcJRVh7Xm2AC8J2YkrZr3L8=;
        h=Received:Message-ID:Subject:From:To:Date:Content-Type:X-Mailer:
         Mime-Version:Content-Transfer-Encoding;
        b=M36ssdTXTTc3iJ9tj62Hn4sLX0UGoer0XxeE3nkUFhDvgrzv8iKN/9VYvI/U4zd96
         psyOJvi57fIPOdFFgSZHLzAXBjI4msxMpj7WzutXh4fijdTIzaVjv7ntjE/Q+n+54u
         QIXj0/QTOxj1CAgkyKavjJmvhYhN40mnEkTCUpfc=
Received: from lisicky.cdnet.czf (82-150-191-10.client.rionet.cz [82.150.191.10])
        by email-relay8.ng.seznam.cz (Seznam SMTPD 1.3.114) with ESMTP;
        Sun, 17 May 2020 21:51:44 +0200 (CEST)  
Message-ID: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
Subject: I can't mount image
From:   =?UTF-8?Q?Ji=C5=99=C3=AD_Lisick=C3=BD?= <jiri_lisicky@seznam.cz>
To:     linux-btrfs@vger.kernel.org
Date:   Sun, 17 May 2020 21:51:43 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-5.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I have Jolla 1 Phone, which use btrfs. With bad battery, phone x times suddenly turned off. Now is bricked. I go into recovery mode
and copy image to my PC with Fedora Live 31 with kernel 5.6.6.

~ # losetup --find --show /home/jirka/tmp/jolla.img
/dev/loop0

~ # btrfs fi show
Label: 'sailfish'  uuid: 86180ca0-d351-4551-b262-22b49e1adf47
 Total devices 1 FS bytes used 4.73GiB
  devid    1 size 13.75GiB used 13.75GiB path /dev/loop0

~ # mount -t btrfs /dev/loop0 ~/mnt
mount: /dev/loop0: can't read superblock

~ # mount -t btrfs -o usebackuproot /dev/loop0 ~/mnt
mount: /dev/loop0: can't read superblock

~ # btrfs rescue super-recover /dev/loop0
All supers are valid, no need to recover

~ # LC_ALL=C btrfs rescue zero-log /dev/loop0
Clearing log on /dev/loop0, previous log_root 0, level 0

~ # LC_ALL=C mount -t btrfs /dev/loop0 ~/mnt
mount: mount /dev/loop0 on /root/mnt failed: No space left on device

~ # mount -t btrfs -o ro /dev/loop0 ~/mnt

~ # btrfs fi df ~/mnt
Data, single: total=13.08GiB, used=4.51GiB
System, DUP: total=8.00MiB, used=4.00KiB
System, single: total=4.00MiB, used=0.00B
Metadata, DUP: total=330.00MiB, used=224.30MiB
Metadata, single: total=8.00MiB, used=0.00B
GlobalReserve, single: total=512.00MiB, used=406.37MiB

~ # truncate --size=2GB ~/tmp/space
~ # losetup --find --show ~/tmp/space
/dev/loop1

~ # btrfs device add /dev/loop1 ~/mnt/
Performing full device TRIM /dev/loop1 (1.86GiB) ...
ERROR: error adding device '/dev/loop1': Read-only file system

When I mount, in syslog appears:
BTRFS info (device loop0): disk space caching is enabled
BTRFS info (device loop0): creating UUID tree
BTRFS warning (device loop0): block group 144703488 has wrong amount of free space
BTRFS warning (device loop0): failed to load free space cache for block group 144703488, rebuilding it now
BTRFS warning (device loop0): failed to create the UUID tree: -28
BTRFS: open_ctree failed

So now I can mount readonly, but is there any way to repair this filesystem?
Thanks Jirka

