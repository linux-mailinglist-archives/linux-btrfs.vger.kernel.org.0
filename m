Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18946F9116
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 May 2023 12:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEFKFe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 May 2023 06:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjEFKFd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 May 2023 06:05:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ACEE7
        for <linux-btrfs@vger.kernel.org>; Sat,  6 May 2023 03:05:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso4887711a12.3
        for <linux-btrfs@vger.kernel.org>; Sat, 06 May 2023 03:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683367529; x=1685959529;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gnSPbW6LzbkgBukpFOpkM7tOfyr229bKXXGWrQToeI0=;
        b=EtMHTXFHNZe/BmMd2sx3gjaN6nPHkJ/e0clKAytwE6X6Bu5VKv9JRNeSJew4Ys5QhW
         +2bVHukGXxBevdM+m2AuG5PhkNyy5Q/aGRQTm3qQ9RWSHdM9d9ZiRkSQl0zfD3zPVq3D
         /kaqWe5KBt6uzaOVgyvlgNv1QPM3qxWiGGwyAuuCiRFWL/e0RrXfau6Ws7BvLSugn082
         kyChYFLsm2b2CjraY0Fl7FTQZT88kKf8bKUuT/k6728nIzHzj6/Ta9RVi3BU7aPbWDJx
         BW07QdFflwc4ZPEO+TcyRecNQIDQ9BaFT3YJo3+2huWaotIR5sm4cAKDVScYFuzBWF3R
         wRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683367529; x=1685959529;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnSPbW6LzbkgBukpFOpkM7tOfyr229bKXXGWrQToeI0=;
        b=iUjkhMtYPdME0f45oaiOs5QIr5lmDA3z0i3lx4gTUoCYfL8EinrYXqpNZ9+G4s2+Gv
         3YGPIctxXPyZJPKId8CG249Y6nRCFUT3NUL8+nriQMtkD8aWBSPXccRR0iRwVfW1rlIU
         dnq2YmEhkS0cjGOcqNCXxL4pFHtZAPd2epBHA4gCRtmF0nnNobOkjV1W4sCRN8NK8Pks
         IWjR2HFcRh6yIJ+JSTDn1jz0X3K3BIM2XAgG9SKoT6VUZD1Z8618hf9TSkeXTsUQh78L
         Ldk3zcNj8EalLbPBzgUAfXREPm5z3MW36U/6Q9OMhjJJeVd+kyneFwKU7XDTLTcrMSx5
         2I9A==
X-Gm-Message-State: AC+VfDzkzfs3C6kYJUdRZ8uFz++9kPtE5dxV+zdJhfPQ2kvlKhd2Q4hL
        UnAk9h2AtZUbLP8vsr6L6cR7vMWpblvJ8mpSXBp3V/bKjfc=
X-Google-Smtp-Source: ACHHUZ7zw12ZuG19mgk/CDe6e7QXqpNrIUkQZJwHY+dXJyZo2U9+0dj9EEXGg7HcGB/it0qZ9+rPyDuX2XGDjxYHR+s=
X-Received: by 2002:a17:907:7e8b:b0:94e:5708:1564 with SMTP id
 qb11-20020a1709077e8b00b0094e57081564mr3415104ejc.22.1683367529066; Sat, 06
 May 2023 03:05:29 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Marcin_Weso=C5=82owski?= <marcinzwanywesolem@gmail.com>
Date:   Sat, 6 May 2023 12:05:18 +0200
Message-ID: <CABHgoeTJe_K63U35hkBc0RFyztdq5AcjORhN24PAjSr4YkF=3A@mail.gmail.com>
Subject: parent transid verify failed / ERROR: could not setup extent tree
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

I faced a power outage while copying large files between my
LUKS-encrypted btrfs partitions on a USB WD Elements drive (with an
external PSU). Later, it failed to mount or do basic btrfs check. I've
found a quite similar (I think) problem discussed here
https://www.spinics.net/lists/linux-btrfs/msg111522.html, looking less
fatal though.

This is a backup drive and I think I should have all its content
spread across other drives or PCs, but I was just about to finish a
long manual clean-up process, so if it was possible to recover I'd
spare quite a bit of time. So I just have two questions:
- is there anything else I could try to do to recover most of the
files? I made a mirror with dd, so it's safe to go wild with
experiments. I'm also not afraid of letting it run for a few days
(it's attached to a UPS now ;)
- if it doesn't work or is not feasible, is it possible to somehow
recover just the file and folder names? I'd then know what to look for
on other backups.

I'm running Ubuntu 20.04.4 LTS, btrfs-progs v5.4.1.

Thanks in advance!

Here's what I've tried so far (inspired by the thread pasted above).

# btrfs check /dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
Opening filesystem to check...
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
Ignoring transid failure
ERROR: could not setup extent tree
ERROR: cannot open file system

root@dell:/home/wesol# mount -o usebackuproot
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
/media/experiments
mount: /media/experiments: wrong fs type, bad option, bad superblock
on /dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a, missing
codepage or helper program, or other error.
root@dell:/home/wesol# mount -o ro,recovery
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
/media/experiments
mount: /media/experiments: wrong fs type, bad option, bad superblock
on /dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a, missing
codepage or helper program, or other error.
root@dell:/home/wesol# btrfs insp dump-s
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
superblock: bytenr=65536,
device=/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x64c7c8ad [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            b8ddc54a-94eb-46e8-a65d-6fc02eb04c72
metadata_uuid        b8ddc54a-94eb-46e8-a65d-6fc02eb04c72
label            smb00
generation        4073
root            5090687057920
sys_array_size        129
chunk_root_generation    4073
root_level        1
chunk_root        22052864
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        9654574776320
bytes_used        5761471766528
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x141
            ( MIXED_BACKREF |
              EXTENDED_IREF |
              SKINNY_METADATA )
cache_generation    4073
uuid_tree_generation    4073
dev_item.uuid        3607cd4c-fb8a-4f57-bba4-85352db5c418
dev_item.fsid        b8ddc54a-94eb-46e8-a65d-6fc02eb04c72 [match]
dev_item.type        0
dev_item.total_bytes    9654574776320
dev_item.bytes_used    5781051146240
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0

root@dell:/home/wesol# btrfs inspect-internal dump-super --full
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
superblock: bytenr=65536,
device=/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x64c7c8ad [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            b8ddc54a-94eb-46e8-a65d-6fc02eb04c72
metadata_uuid        b8ddc54a-94eb-46e8-a65d-6fc02eb04c72
label            smb00
generation        4073
root            5090687057920
sys_array_size        129
chunk_root_generation    4073
root_level        1
chunk_root        22052864
chunk_root_level    1
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        9654574776320
bytes_used        5761471766528
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x141
            ( MIXED_BACKREF |
              EXTENDED_IREF |
              SKINNY_METADATA )
cache_generation    4073
uuid_tree_generation    4073
dev_item.uuid        3607cd4c-fb8a-4f57-bba4-85352db5c418
dev_item.fsid        b8ddc54a-94eb-46e8-a65d-6fc02eb04c72 [match]
dev_item.type        0
dev_item.total_bytes    9654574776320
dev_item.bytes_used    5781051146240
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
    item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
        length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
        io_align 65536 io_width 65536 sector_size 4096
        num_stripes 2 sub_stripes 1
            stripe 0 devid 1 offset 22020096
            dev_uuid 3607cd4c-fb8a-4f57-bba4-85352db5c418
            stripe 1 devid 1 offset 30408704
            dev_uuid 3607cd4c-fb8a-4f57-bba4-85352db5c418
backup_roots[4]:
    backup 0:
        backup_tree_root:    5090646720512    gen: 4070    level: 1
        backup_chunk_root:    22511616    gen: 4070    level: 1
        backup_extent_root:    5090641772544    gen: 4070    level: 2
        backup_fs_root:        5090652487680    gen: 4071    level: 2
        backup_dev_root:    5090642771968    gen: 4070    level: 1
        backup_csum_root:    5090652536832    gen: 4071    level: 3
        backup_total_bytes:    9654574776320
        backup_bytes_used:    5757456617472
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    5090660990976    gen: 4071    level: 1
        backup_chunk_root:    22052864    gen: 4071    level: 1
        backup_extent_root:    5090653126656    gen: 4071    level: 2
        backup_fs_root:        5090652487680    gen: 4071    level: 2
        backup_dev_root:    5090653175808    gen: 4071    level: 1
        backup_csum_root:    5090652536832    gen: 4071    level: 3
        backup_total_bytes:    9654574776320
        backup_bytes_used:    5758862508032
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    5090674573312    gen: 4072    level: 1
        backup_chunk_root:    22511616    gen: 4072    level: 1
        backup_extent_root:    5090650488832    gen: 4072    level: 2
        backup_fs_root:        5090683322368    gen: 4073    level: 2
        backup_dev_root:    5090651111424    gen: 4072    level: 1
        backup_csum_root:    5090651209728    gen: 4072    level: 3
        backup_total_bytes:    9654574776320
        backup_bytes_used:    5760037130240
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    5090687057920    gen: 4073    level: 1
        backup_chunk_root:    22052864    gen: 4073    level: 1
        backup_extent_root:    5090661482496    gen: 4073    level: 2
        backup_fs_root:        5090683322368    gen: 4073    level: 2
        backup_dev_root:    5090661531648    gen: 4073    level: 1
        backup_csum_root:    5090683453440    gen: 4073    level: 3
        backup_total_bytes:    9654574776320
        backup_bytes_used:    5761471766528
        backup_num_devices:    1


root@dell:/home/wesol# btrfs check -r 5090646720512
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
Opening filesystem to check...
parent transid verify failed on 5090646720512 wanted 4073 found 4070
parent transid verify failed on 5090646720512 wanted 4073 found 4070
parent transid verify failed on 5090646720512 wanted 4073 found 4070
Ignoring transid failure
parent transid verify failed on 5090651602944 wanted 4070 found 4072
parent transid verify failed on 5090651602944 wanted 4070 found 4072
parent transid verify failed on 5090651602944 wanted 4070 found 4072
Ignoring transid failure
leaf parent key incorrect 5090651602944
ERROR: could not setup extent tree
ERROR: cannot open file system
root@dell:/home/wesol# btrfs check -r 5090660990976
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
Opening filesystem to check...
'ERROR: could not setup extent tree
ERROR: cannot open file system
root@dell:/home/wesol# btrfs check -r 5090674573312
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
Opening filesystem to check...
parent transid verify failed on 5090674573312 wanted 4073 found 4074
parent transid verify failed on 5090674573312 wanted 4073 found 4074
parent transid verify failed on 5090674573312 wanted 4073 found 4074
Ignoring transid failure
ERROR: could not setup extent tree
ERROR: cannot open file system
root@dell:/home/wesol# btrfs check -r 5090687057920
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
Opening filesystem to check...
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
Ignoring transid failure
ERROR: could not setup extent tree
ERROR: cannot open file system
root@dell:/home/wesol# btrfs check --init-extent-tree
/dev/mapper/luks-3870aa81-a158-47d0-86f1-530de7284d1a
WARNING:

    Do not use --repair unless you are advised to do so by a developer
    or an experienced user, and then only after having accepted that no
    fsck can successfully repair all types of filesystem corruption. Eg.
    some software or hardware bugs can fatally damage a volume.
    The operation will start in 10 seconds.
    Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
parent transid verify failed on 5090687057920 wanted 4073 found 4075
Ignoring transid failure
WARNING: could not setup extent tree, skipping it
Couldn't setup device tree
ERROR: cannot open file system
