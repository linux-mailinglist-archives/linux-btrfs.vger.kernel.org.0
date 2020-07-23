Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522622B868
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 23:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGWVPx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWVPx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 17:15:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E343C0619D3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 14:15:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17so5472118otl.4
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jul 2020 14:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=1bMQIUT1BPjhLaEMXJy9KRw76V/gIozQQG8er+S/wug=;
        b=McmrgyqLcyAmjWva/LESmHYImQ+8/59voh5yNSJFC/fe4Jus8yOj6nAfgihZLiDnTL
         PsIsfWOXQ+mD5YZyIOw7Qb/N8JjJmZDXgB26VFgTCiHB1Gy3+b5uSzzArFi3kX2qJyY5
         V2ylDSegNyRwyweLVnOiykj3arjGA4bFEnIPIeLdmqDzb7RM/jNGXX1Xowf1ehj3zH5V
         67MArIHb10WUgw0bcsETaGK3X9EKc4eGDG7pe2xMfkM9YsCDLHlRRWprh/+vTdMgPlcI
         ahBhz/DEqbEjVSLaBQS2OmzfO51c+6xTFCXxyUHX6pLFxv3ZgNXaf+4j8V0J0yvW/jyQ
         D85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1bMQIUT1BPjhLaEMXJy9KRw76V/gIozQQG8er+S/wug=;
        b=EQEe8QBZx3sBwqMD72Jnat5gDzrpVKXeIcqTnSPDMHS3rE1+35ulimPatEvfAjuU34
         DN25Xufur45WIu0QHreQM6ozMmqNiKuM4/cBdWN+jeaFAlVaSNp+4lspDhbYbmBhnrP3
         /E4VF+JOec93p/7NtRGvbSi8y4EUYg8yv1f9y9rpkvwpDFxKR15ie8ZEfU0ATPdbtEYx
         IZrlrljnDuoEPKAcZTcdkkZOwbQN+EifJwj9Bq4JuSbiG9W8QKmIVu+ITz43nhmBNC2i
         y2U3Zv6VPQroGwWtIDdXqjY0F6GxeVy/A+P8qDk/hIEox12ZCMWG7acU3wTQg02MGNxW
         94Mg==
X-Gm-Message-State: AOAM530zj2JqLiNnNh991VfB+Lnajdy0IesB46t0LtYRSLEKm01J8sol
        rV4m1UxZHiqsBSNmvKJ5VpodzPv/EgBeLp6y33fkx5zLCV8=
X-Google-Smtp-Source: ABdhPJy5z7UxwbsTOS5qNyYo7cWkHVIqTU3U0lD/TPog5UJ6MxzNvxdL5r1TQ7LtKCXFVfCkNV/DC5lEfSckLyxpilY=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr5767153otc.123.1595538952413;
 Thu, 23 Jul 2020 14:15:52 -0700 (PDT)
MIME-Version: 1.0
From:   Davide Palma <dpfuturehacker@gmail.com>
Date:   Thu, 23 Jul 2020 23:15:40 +0200
Message-ID: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
Subject: Error: Failed to read chunk root, fs destroyed
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
What happened:

I had a Gentoo linux install on a standard, ssd, btrfs partition.
After I removed lots of files, I wanted to shrink the partition, so i
shrunk it as much as possible and started a balance operation to
squeeze out more unallocated space. However, the balance operation was
not progressing. (the behaviour was identical to the one described
here https://www.opensuse-forum.de/thread/43376-btrfs-balance-caught-in-write-loop/
). So I cancelled the balance and, following a piece of advice found
on the net, created a ramdisk that worked as a second device for a
raid1 setup.

dd if=/dev/zero of=/var/tmp/btrfs bs=1G count=5

losetup -v -f /var/tmp/btrfs
btrfs device add /dev/loop0 .

I tried running the balance again, but, as before, it wasn't
progressing. So I decided to remove the ramdisk and reconvert the now
raid1 partition to a single one. This is where the bad stuff began: As
the process of converting raid1 to single is a balance, the balance
looped and didn't progress. I also couldn't cancel it by ^C or SIGTERM
or SIGKILL. Since I didn't know what to do, I just rebooted the PC
(very bad decision!). The filesystem is now broken.
Please note I never tried dangerous options like zero-log or --repair.

I setted up an arch linux install on /dev/sda4 to keep on working and
to try recovery.

My environment:
Gentoo linux: kernel 5.7.8, btrfs-progs 5.7

Arch linux:
uname -a
Linux lenuovo 5.7.9-arch1-1 #1 SMP PREEMPT Thu, 16 Jul 2020 19:34:49
+0000 x86_64 GNU/Linux

btrfs --version
btrfs-progs v5.7

fdisk -l
Disk /dev/sda: 223,58 GiB, 240057409536 bytes, 468862128 sectors
Disk model: KINGSTON SUV400S
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: 472C32BA-DDF3-4063-BBF7-629C7A68C195

Dispositivo     Start      Fine   Settori   Size Tipo
/dev/sda1        2048   8194047   8192000   3,9G Linux swap
/dev/sda2     8194048   8521727    327680   160M EFI System
/dev/sda3     8521728 302680063 294158336 140,3G Linux filesystem
/dev/sda4   302680064 345087999  42407936  20,2G Linux filesystem
/dev/sda5   345088000 468860927 123772928    59G Microsoft basic data

The broken FS is /dev/sda3.

Any combination of mount options without degraded fails with:
BTRFS info (device sda3): disk space caching is enabled
BTRFS info (device sda3): has skinny extents
BTRFS error (device sda3): devid 2 uuid
bc7154d2-bf0e-4ff4-b7cb-44e118148976 is missing
BTRFS error (device sda3): failed to read the system array: -2
BTRFS error (device sda3): open_ctree failed

Any combination of mount options with degraded fails with:
BTRFS info (device sda3): allowing degraded mounts
BTRFS info (device sda3): disk space caching is enabled
BTRFS info (device sda3): has skinny extents
BTRFS warning (device sda3): devid 2 uuid
bc7154d2-bf0e-4ff4-b7cb-44e118148976 is missing
BTRFS error (device sda3): failed to read chunk root
BTRFS error (device sda3): open_ctree failed

This is also the error of every btrfs prog that tries to access the volume:
btrfs check /dev/sda3
Opening filesystem to check...
warning, device 2 is missing
bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
ERROR: cannot read chunk root
ERROR: cannot open file system

btrfs restore /dev/sda3 -i -l
warning, device 2 is missing
bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super
warning, device 2 is missing
bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
ERROR: cannot read chunk root
Could not open root, trying backup super
ERROR: superblock bytenr 274877906944 is larger than device size 150609068032
Could not open root, trying backup super

btrfs rescue super-recover /dev/sda3
All supers are valid, no need to recover

btrfs inspect-internal dump-super -f /dev/sda3
superblock: bytenr=65536, device=/dev/sda3
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0x3d057827 [match]
bytenr 65536
flags 0x1
( WRITTEN )
magic _BHRfS_M [match]
fsid 8e42af34-3102-4547-b3ff-f3d976eafa9d
metadata_uuid 8e42af34-3102-4547-b3ff-f3d976eafa9d
label gentoo
generation 8872486
root 110264320
sys_array_size 97
chunk_root_generation 8863753
root_level 1
chunk_root 315196702720
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 151926079488
bytes_used 89796988928
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 2
compat_flags 0x0
compat_ro_flags 0x0
incompat_flags 0x171
( MIXED_BACKREF |
 COMPRESS_ZSTD |
 BIG_METADATA |
 EXTENDED_IREF |
 SKINNY_METADATA )
cache_generation 8872486
uuid_tree_generation 283781
dev_item.uuid 877550b0-11cc-4b12-944f-83ac2a08201c
dev_item.fsid 8e42af34-3102-4547-b3ff-f3d976eafa9d [match]
dev_item.type 0
dev_item.total_bytes 148780351488
dev_item.bytes_used 148779302912
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0
sys_chunk_array[2048]:
item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 315196702720)
length 33554432 owner 2 stripe_len 65536 type SYSTEM
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 2 offset 38797312
dev_uuid bc7154d2-bf0e-4ff4-b7cb-44e118148976
backup_roots[4]:
backup 0:
backup_tree_root: 110264320 gen: 8872486 level: 1
backup_chunk_root: 315196702720 gen: 8863753 level: 1
backup_extent_root: 110280704 gen: 8872486 level: 2
backup_fs_root: 125812736 gen: 8872478 level: 3
backup_dev_root: 104220278784 gen: 8863753 level: 0
backup_csum_root: 125796352 gen: 8872486 level: 2
backup_total_bytes: 151926079488
backup_bytes_used: 89796988928
backup_num_devices: 2

backup 1:
backup_tree_root: 191561728 gen: 8872483 level: 1
backup_chunk_root: 315196702720 gen: 8863753 level: 1
backup_extent_root: 191578112 gen: 8872483 level: 2
backup_fs_root: 125812736 gen: 8872478 level: 3
backup_dev_root: 104220278784 gen: 8863753 level: 0
backup_csum_root: 297615360 gen: 8872483 level: 2
backup_total_bytes: 151926079488
backup_bytes_used: 89796988928
backup_num_devices: 2

backup 2:
backup_tree_root: 398196736 gen: 8872484 level: 1
backup_chunk_root: 315196702720 gen: 8863753 level: 1
backup_extent_root: 398213120 gen: 8872484 level: 2
backup_fs_root: 125812736 gen: 8872478 level: 3
backup_dev_root: 104220278784 gen: 8863753 level: 0
backup_csum_root: 45662208 gen: 8872484 level: 2
backup_total_bytes: 151926079488
backup_bytes_used: 89796988928
backup_num_devices: 2

backup 3:
backup_tree_root: 70385664 gen: 8872485 level: 1
backup_chunk_root: 315196702720 gen: 8863753 level: 1
backup_extent_root: 70402048 gen: 8872485 level: 2
backup_fs_root: 125812736 gen: 8872478 level: 3
backup_dev_root: 104220278784 gen: 8863753 level: 0
backup_csum_root: 76185600 gen: 8872485 level: 2
backup_total_bytes: 151926079488
backup_bytes_used: 89796988928
backup_num_devices: 2

chunk-recover:
https://pastebin.com/MieHVxbd

So, did I screw up btrfs so badly I don't deserve a recovery, or can
something be done?

Thank you,
David
