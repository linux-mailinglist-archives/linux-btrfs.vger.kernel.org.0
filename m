Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64EBD618
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbfIYB0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 21:26:39 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46591 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389140AbfIYB0j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 21:26:39 -0400
Received: by mail-wr1-f46.google.com with SMTP id o18so4222643wrv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=VCG85OEGtb+DYdEfL3cNCNJIv89++Ufc/J/YjyrlLgU=;
        b=Db3//C+u/XM57lo9mPGADa7oZ3zx89cGczrLXqQRGC2YsxOD0iSQq0SjGU4k+LVoI1
         dsWoCu3wa+fPgB4YKqAqm8KrMNP/pp9wT+zvJcmATA5tnig9jAzVWTRYaeZMAYWV4x6Y
         JC++qdsHuOWcD9Sn7WvAPuvTJnqSSiouf4apSvcHMVZA241Ig1Ve8AxBGaSAyQRodqz9
         BpC5nuXziXo25DezYJtWg4e8NP7KiwIYZH+v/bIA/8qkHrCAZM+iomm9coT7fDRd03Pe
         Y83MHxmHupOVB5nVF+v2Dsol0Wca/cyJobfroClknyMfpD8jjk1pQPpmsWm4rjngVosJ
         96IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VCG85OEGtb+DYdEfL3cNCNJIv89++Ufc/J/YjyrlLgU=;
        b=nBSsGmEaQY/KjwySYE9/ojvDRZkAdbNA6bRF1mgZcubvT+2D72hgUBYC4bQBha+rcv
         zuxOeOZy+fVx4P8TPEXKt8rrDEHjyV90oRmxapYFXnIfpRi6SnMPzAJOcYikS50Y1Jfl
         IbqLAWCDcHeQVwkEHFxS/k+2OHi16FomwZQloAlCVS+LSHC9yLTiv0CteQx5CdIDQyO9
         oRBa5fajK2YBtATskKAL6/YIo5pfu2q8syqlcuJOVz2NVHOZpVwfYVjGjk6ddiQ1vhGn
         Tt6we7BLJ4J34Mryc9vx3Lvc5QpNyueCXdMsyhHgwmwt6+Qg4m/Rwlr+gAOdyHUKBdGx
         5ubQ==
X-Gm-Message-State: APjAAAVtrervCDk5m1Jz1YGgHXm6mNc9AFSIkO1epbS9orPwMCp5b/pD
        RO9JNfE2Ng7HVnoBallibP9h+54NSnEjbEpEEf5gUGO39w32vg==
X-Google-Smtp-Source: APXvYqyQCCeiEAdMlOlP7faCrpr/SAEvcIwTc4phA1jwksB4iUikRpFBEBSPexowGV8MsbOOXH7b2M9ch3Ne6k9s+r4=
X-Received: by 2002:adf:efcb:: with SMTP id i11mr2885507wrp.69.1569374796965;
 Tue, 24 Sep 2019 18:26:36 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 19:26:25 -0600
Message-ID: <CAJCQCtS6uHcH3CmM5WpTOGrZ8EFPkFr8Xo92X+Q+VxvBiaW4ug@mail.gmail.com>
Subject: error: invalid convert data profile single
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.3.0-1.fc31.x86_64
btrfs-progs-5.2.1-1.fc31.x86_64

 sudo btrfs balance start -dconvert=single,soft /
ERROR: error during balancing '/': Invalid argument
There may be more info in syslog - try dmesg | tail
$ sudo btrfs balance start -dconvert=single /
ERROR: error during balancing '/': Invalid argument
There may be more info in syslog - try dmesg | tail


[372342.643440] BTRFS error (device sdb3): balance: invalid convert
data profile single
[372378.271689] BTRFS error (device sdb3): balance: invalid convert
data profile single

Huh? I had just today accidentally started converting data to DUP. I
had intended to change metadata to DUP. I cancelled the data DUP
convert pretty early on. But now I appear stuck.

$ sudo btrfs fi us /
Overall:
    Device size:                  25.00GiB
    Device allocated:             19.57GiB
    Device unallocated:            5.43GiB
    Device missing:                  0.00B
    Used:                         11.15GiB
    Free (estimated):              7.82GiB      (min: 5.52GiB)
    Data ratio:                       1.08
    Metadata ratio:                   2.00
    Global reserve:               43.34MiB      (used: 0.00B)

Data,single: Size:11.01GiB, Used:8.98GiB
   /dev/sdb3      11.01GiB

Data,DUP: Size:1.00GiB, Used:508.62MiB
   /dev/sdb3       2.00GiB

Metadata,DUP: Size:3.25GiB, Used:603.25MiB
   /dev/sdb3       6.50GiB

System,DUP: Size:32.00MiB, Used:32.00KiB
   /dev/sdb3      64.00MiB

Unallocated:
   /dev/sdb3       5.43GiB
$ sudo btrfs balance start -v -dconvert=single,soft /
Dumping filters: flags 0x1, state 0x0, force is off
  DATA (flags 0x300): converting, target=281474976710656, soft is on
ERROR: error during balancing '/': Invalid argument
There may be more info in syslog - try dmesg | tail
$ sudo btrfs balance start -v -f -dconvert=single,soft /
Dumping filters: flags 0x9, state 0x0, force is on
  DATA (flags 0x300): converting, target=281474976710656, soft is on
ERROR: error during balancing '/': Invalid argument
There may be more info in syslog - try dmesg | tail
$ sudo btrfs insp dump-s /dev/sdb3
superblock: bytenr=65536, device=/dev/sdb3
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xabe229b9 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            3d93d834-ab33-40d1-8468-26fdc3eac4e0
metadata_uuid        3d93d834-ab33-40d1-8468-26fdc3eac4e0
label            fedoraFIT
generation        96541
root            18306990080
sys_array_size        129
chunk_root_generation    96449
root_level        0
chunk_root        18141446144
chunk_root_level    0
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        26843545600
bytes_used        10804428800
sectorsize        4096
nodesize        32768
leafsize (deprecated)    32768
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x171
            ( MIXED_BACKREF |
              COMPRESS_ZSTD |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA )
cache_generation    7
uuid_tree_generation    86563
dev_item.uuid        f695e038-833e-4600-9a0c-0a13fb4d9f0e
dev_item.fsid        3d93d834-ab33-40d1-8468-26fdc3eac4e0 [match]
dev_item.type        0
dev_item.total_bytes    26843545600
dev_item.bytes_used    21021851648
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
$



-- 
Chris Murphy
