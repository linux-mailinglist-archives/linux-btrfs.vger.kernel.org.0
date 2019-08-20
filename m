Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FC89699E
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfHTTmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 15:42:45 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38692 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTTmp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 15:42:45 -0400
Received: by mail-lj1-f182.google.com with SMTP id x3so6256094lji.5
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 12:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4gGrjZS+obQL6IT5pBT5f5JXMoNT1nne8XuRmR+mh7w=;
        b=dqXxuGYn8XjKhqYQh2iMvN5Cieg45nxppF++aeg3JBJGSccbo2jFZobvDVj4OQ8cOb
         b96iNRIwRt6FMB2cQTOdUpEDcEXcc95yXA/BxQiNTSxKpwQycvlPBL+KpzyQkfUGWFF/
         ldK4MNNw4O74rhGpk4xd5hokO8svmZs8vdxDhtJIIHLKdenFfJaFVKfbVcjoDZh96F6e
         a3W78AUlE1hlFKJxpVzOEgap44oO6JW6wbklTHZ23zpWjLCjxWhDofIlvh5NEFVwv2XA
         7KkocV0KY6532yx/N1wCPGASJ87Pgm3/D6U8phAyLrHPlbRB/YMMknxBElf7R+C8hpgh
         zuPg==
X-Gm-Message-State: APjAAAVgcbGS1mIXpABr8yHWONEbRCSrEfIWvcZ7yWyAdhWv6AeCZ60W
        mDHpUMuZsNC99L0xhXwkAI0r826OD4eVXO6Ahl2uMUfD
X-Google-Smtp-Source: APXvYqzeb/As3F+zhtcU22OGIpZZc6GNGzZyxL5pOWl9x+ffQbWV0p2rbhjmPezqifLsb6msD7H3hDWBwpWn3kA+H0I=
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr16538743lji.41.1566330162497;
 Tue, 20 Aug 2019 12:42:42 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Clarke <dan@e-dan.co.uk>
Date:   Tue, 20 Aug 2019 20:42:31 +0100
Message-ID: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
Subject: BTRFS unable to mount after one failed disk in RAID 1
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

I'm having some trouble recovering my data after a single disk has
failed in a raid1 two disk setup.

The original setup:
mkfs.btrfs -L MASTER /dev/sdb1
mount -o compress=zstd,noatime /dev/sdb1 /mnt/master
btrfs subvolume create /mnt/master/home
btrfs device add /dev/sdc1 /mnt/master
btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/master

Mount after in fstab:

UUID=70a651ab-4837-4891-9099-a6c8a52aa40f /mnt/master     btrfs
defaults,noatime,compress=zstd 0      0

Was working fine for about 8 months, however I found the filesystem
went to read only, and after a restart, would not mount at all. A
failed disk seems to be the cause.

I'm trying to get the files off the other disk, but it will not mount.

Some info:
~$ blkid /dev/sdc1
/dev/sdc1: LABEL="MASTER" UUID="70a651ab-4837-4891-9099-a6c8a52aa40f"
UUID_SUB="150986ba-521c-4eb0-85ec-9435edecaf2a" TYPE="btrfs"
PARTUUID="50a736da-aba8-224a-8e82-f1322ede466f"

~$ btrfs --version
btrfs-progs v4.15.1

~$ btrfs fi show
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
Label: 'MASTER'  uuid: 70a651ab-4837-4891-9099-a6c8a52aa40f
Total devices 2 FS bytes used 1001.59GiB
devid    1 size 1.82TiB used 1003.03GiB path /dev/sdc1
*** Some devices missing

Things I've tried:

~$ mount -t btrfs -o ro,usebackuproot,compress=zstd /dev/sdc1 /mnt/maindisk
mount: /mnt/maindisk: wrong fs type, bad option, bad superblock on
/dev/sdc1, missing codepage or helper program, or other error.

In dmesg:
[ 4044.456472] BTRFS info (device sdc1): trying to use backup root at mount time
[ 4044.456478] BTRFS info (device sdc1): use zstd compression, level 0
[ 4044.456481] BTRFS info (device sdc1): disk space caching is enabled
[ 4044.456482] BTRFS info (device sdc1): has skinny extents
[ 4044.802419] BTRFS error (device sdc1): devid 2 uuid
a3889c61-07b3-4165-bc37-e9918e41ea8d is missing
[ 4044.802426] BTRFS error (device sdc1): failed to read chunk tree: -2
[ 4044.863400] BTRFS error (device sdc1): open_ctree failed

Pretty much the same thing with other mount options, with same
messages in dmesg.

~$ btrfs check --init-extent-tree /dev/sdc1
warning, device 2 is missing
Checking filesystem on /dev/sdc1
UUID: 70a651ab-4837-4891-9099-a6c8a52aa40f
Creating a new extent tree
bytenr mismatch, want=1058577645568, have=0
Error reading tree block
error pinning down used bytes
ERROR: attempt to start transaction over already running one
extent buffer leak: start 1768503115776 len 16384

~$ btrfs rescue super-recover -v /dev/sdc1
All Devices:
Device: id = 1, name = /dev/sdc1

Before Recovering:
[All good supers]:
device name = /dev/sdc1
superblock bytenr = 65536

device name = /dev/sdc1
superblock bytenr = 67108864

device name = /dev/sdc1
superblock bytenr = 274877906944

[All bad supers]:

All supers are valid, no need to recover


~$ sudo btrfs restore -mxs /dev/sdc1 /mnt/ssd1/
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
Could not open root, trying backup super
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
Could not open root, trying backup super
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
Could not open root, trying backup super

~$ btrfs check /dev/sdc1
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
ERROR: cannot open file system

~$ btrfs rescue zero-log /dev/sdc1
warning, device 2 is missing
bytenr mismatch, want=1057828618240, have=0
ERROR: could not open ctree

I'm only interested in getting it read-only mounted so I can copy
somewhere else. Any ideas you have are welcome!

Many Thanks,

Daniel Clarke
