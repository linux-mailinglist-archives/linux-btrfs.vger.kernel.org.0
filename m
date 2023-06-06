Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5E72463F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jun 2023 16:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjFFOfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jun 2023 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjFFOeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Jun 2023 10:34:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D61738
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Jun 2023 07:34:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2553663f71eso2714294a91.3
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Jun 2023 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062058; x=1688654058;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ABOC+h3uRVlVEsbsFosmPcJVLKpbQE83AKy/aosRZgE=;
        b=mTiaI3OlCYQecxeiKq3vEpjOZcICkoYZSHUbMp5YhEuwZvdcGCtZKgPx6kK8Kh3xLw
         VmaKNfQJ/fqKUcFRHGtmNythjA5z1pUtH+BjWzT3IdCF+bbs4xOwlhMbxS0aJZdjIE0S
         4lUAvOCm/75968P62D0vwY7yPn6WCzmhLP+hYwAWmgieapn7oDFy8NUAtfUm0GwXu5ZZ
         cTYx22yNQ/sJEsMK58kxMqLqeYsGYJgzMTQLKHaJM5grf5rRs226YHRpOQHg2djheuf9
         kRvja9PU3oH153HQYv51G8v0gYvIGYBwyiA81itOjmG7oLuRHU0qtSC8ieadhQuBF7Nl
         h22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062058; x=1688654058;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABOC+h3uRVlVEsbsFosmPcJVLKpbQE83AKy/aosRZgE=;
        b=WGDmIjAHdM6ayp/6qZ+ZykRU1xsjIT8u4SS9VU8mErrZXkJscJMDzCjytmTOeBMYmY
         Pd3Hr/Xa6SxkQrzoVzpm934Z2NLVRzbmE69mYgQlESyctz7h9rw/WWecIcNAYYTREN4d
         VN01YDmne4YcFvfxV3qJ2C3YcnWpzuBD8NckobgLSJmC5mWhZpSw1mKOvfaJveEnrwMO
         D/tOeGdISJ47JPonYoLd2VU0JP4PnJ9UUDW8/eZ992SCfqeWLpj9hhyC/qF7p8psfBv8
         igN7SNn9qI8R5f2j2hgq+V/vzp33qKrZT9tImBxAwiqcpV8GCwuZbtGUVc2VvJ+Mf8ry
         oclQ==
X-Gm-Message-State: AC+VfDwv9L/GMTYCX6uSGbOxmCM1IvDYXIWZ0i9CprQ5iQs6Ck8qumTn
        0hQzUVYLTg262hImLquvASjprKJPQyo82jb/NGnPtYYwjQw=
X-Google-Smtp-Source: ACHHUZ4LavIb+UouUWNgZaJrAd0SCBE6moC8Jx+w5h1PYH4/mS9Ji15ll4YZZ9Ft23ATRgr+/GKxeWOxlHkPIU5FH30=
X-Received: by 2002:a17:90a:384d:b0:255:4635:830c with SMTP id
 l13-20020a17090a384d00b002554635830cmr968916pjf.40.1686062058211; Tue, 06 Jun
 2023 07:34:18 -0700 (PDT)
MIME-Version: 1.0
From:   Massimiliano Alberti <xanatos78@gmail.com>
Date:   Tue, 6 Jun 2023 16:34:06 +0200
Message-ID: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
Subject: parent transid verify failed + Couldn't setup device tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was using my btrfs partition through a usb-sata box when there was a
power failure. Now I cannot mount it anymore. I'm using Ubuntu 22.04.

If I try to do a btrfs check:

root@ubuntu:/home/ubuntu# btrfs check /dev/sdc1

parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
parent transid verify failed on 4390576160768 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
ERROR: cannot open file system

The supers seems to be valid

root@ubuntu:~# btrfs rescue super-recover -v /dev/sdc1
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


The result of insp dump-s

btrfs insp dump-s /dev/sdc1

superblock: bytenr=65536, device=/dev/sdc1
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0xc93391cc [match]
bytenr 65536
flags 0x1
( WRITTEN )
magic _BHRfS_M [match]
fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
metadata_uuid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
label
generation 9196
root 4390576160768
sys_array_size 129
chunk_root_generation 9146
root_level 0
chunk_root 25559040
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 17965846102016
bytes_used 15526065344512
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 1
compat_flags 0x0
compat_ro_flags 0x3
( FREE_SPACE_TREE |
  FREE_SPACE_TREE_VALID )
incompat_flags 0x161
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA )
cache_generation 0
uuid_tree_generation 9196
dev_item.uuid 632b9c90-95bf-44f3-9374-dddc6c571136
dev_item.fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f [match]
dev_item.type 0
dev_item.total_bytes 17965846102016
dev_item.bytes_used 15723900436480
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0


and of dump-super

root@ubuntu:/home/ubuntu# btrfs inspect-internal dump-super --full /dev/sdc1

superblock: bytenr=65536, device=/dev/sdc1
---------------------------------------------------------
csum_type 0 (crc32c)
csum_size 4
csum 0xc93391cc [match]
bytenr 65536
flags 0x1
( WRITTEN )
magic _BHRfS_M [match]
fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
metadata_uuid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
label
generation 9196
root 4390576160768
sys_array_size 129
chunk_root_generation 9146
root_level 0
chunk_root 25559040
chunk_root_level 1
log_root 0
log_root_transid 0
log_root_level 0
total_bytes 17965846102016
bytes_used 15526065344512
sectorsize 4096
nodesize 16384
leafsize (deprecated) 16384
stripesize 4096
root_dir 6
num_devices 1
compat_flags 0x0
compat_ro_flags 0x3
( FREE_SPACE_TREE |
  FREE_SPACE_TREE_VALID )
incompat_flags 0x161
( MIXED_BACKREF |
  BIG_METADATA |
  EXTENDED_IREF |
  SKINNY_METADATA )
cache_generation 0
uuid_tree_generation 9196
dev_item.uuid 632b9c90-95bf-44f3-9374-dddc6c571136
dev_item.fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f [match]
dev_item.type 0
dev_item.total_bytes 17965846102016
dev_item.bytes_used 15723900436480
dev_item.io_align 4096
dev_item.io_width 4096
dev_item.sector_size 4096
dev_item.devid 1
dev_item.dev_group 0
dev_item.seek_speed 0
dev_item.bandwidth 0
dev_item.generation 0
sys_chunk_array[2048]:
item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
io_align 65536 io_width 65536 sector_size 4096
num_stripes 2 sub_stripes 1
stripe 0 devid 1 offset 22020096
dev_uuid 632b9c90-95bf-44f3-9374-dddc6c571136
stripe 1 devid 1 offset 30408704
dev_uuid 632b9c90-95bf-44f3-9374-dddc6c571136
backup_roots[4]:
backup 0:
backup_tree_root: 2633533751296 gen: 9193 level: 0
backup_chunk_root: 25559040 gen: 9146 level: 1
backup_extent_root: 2633547710464 gen: 9193 level: 2
backup_fs_root: 2633526263808 gen: 9193 level: 2
backup_dev_root: 39927808 gen: 9181 level: 1
backup_csum_root: 15490589523968 gen: 9179 level: 3
backup_total_bytes: 17965846102016
backup_bytes_used: 15526065311744
backup_num_devices: 1

backup 1:
backup_tree_root: 3518234607616 gen: 9194 level: 0
backup_chunk_root: 25559040 gen: 9146 level: 1
backup_extent_root: 3518158962688 gen: 9194 level: 2
backup_fs_root: 3518155571200 gen: 9194 level: 2
backup_dev_root: 39927808 gen: 9181 level: 1
backup_csum_root: 15490589523968 gen: 9179 level: 3
backup_total_bytes: 17965846102016
backup_bytes_used: 15526065328128
backup_num_devices: 1

backup 2:
backup_tree_root: 4390562365440 gen: 9195 level: 0
backup_chunk_root: 25559040 gen: 9146 level: 1
backup_extent_root: 3518246305792 gen: 9195 level: 2
backup_fs_root: 3518155571200 gen: 9194 level: 2
backup_dev_root: 39927808 gen: 9181 level: 1
backup_csum_root: 15490589523968 gen: 9179 level: 3
backup_total_bytes: 17965846102016
backup_bytes_used: 15526065344512
backup_num_devices: 1

backup 3:
backup_tree_root: 4390576160768 gen: 9196 level: 0
backup_chunk_root: 25559040 gen: 9146 level: 1
backup_extent_root: 4390576488448 gen: 9196 level: 2
backup_fs_root: 3518155571200 gen: 9194 level: 2
backup_dev_root: 39927808 gen: 9181 level: 1
backup_csum_root: 15490589523968 gen: 9179 level: 3
backup_total_bytes: 17965846102016
backup_bytes_used: 15526065344512
backup_num_devices: 1

I've already tried checking starting from the various root trees:

root@ubuntu:/home/ubuntu# btrfs check -r 2633533751296 /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 2633533751296 wanted 9196 found 3310
parent transid verify failed on 2633533751296 wanted 9196 found 3310
parent transid verify failed on 2633533751296 wanted 9196 found 3310
Ignoring transid failure
Couldn't setup device tree
ERROR: cannot open file system

root@ubuntu:/home/ubuntu# btrfs check -r 3518234607616 /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 3518234607616 wanted 9196 found 9122
parent transid verify failed on 3518234607616 wanted 9196 found 9122
parent transid verify failed on 3518234607616 wanted 9196 found 9122
Ignoring transid failure
ERROR: root [1 0] level 1 does not match 0

Couldn't read tree root
ERROR: cannot open file system

root@ubuntu:/home/ubuntu# btrfs check -r 4390562365440 /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 4390562365440 wanted 9196 found 3295
parent transid verify failed on 4390562365440 wanted 9196 found 3295
parent transid verify failed on 4390562365440 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
ERROR: cannot open file system

root@ubuntu:/home/ubuntu# btrfs check -r 4390562365440 /dev/sdc1
Opening filesystem to check...
parent transid verify failed on 4390562365440 wanted 9196 found 3295
parent transid verify failed on 4390562365440 wanted 9196 found 3295
parent transid verify failed on 4390562365440 wanted 9196 found 3295
Ignoring transid failure
Couldn't setup device tree
ERROR: cannot open file system

Someone has some idea/suggestion? Thanks!
