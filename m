Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8941346E94
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfFOGV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 02:21:59 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:46277 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfFOGV7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 02:21:59 -0400
Received: by mail-vs1-f52.google.com with SMTP id l125so3092564vsl.13
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 23:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paulsen.at; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=J1TQCp3rDY9vY3U+dfd2ngdxVayWXEJJd1SXd/jo4f0=;
        b=GlSogb2rQwto5k7mJ0JqXoyjEM5xK5nSDj861BQ2fau75zEptGwxExxgejINoxFMyg
         iKVuu7ylsuybqN3Sb+mGpjP5UG6S2QqPKZmDrbdX+49/ondxY7SnfTZs8Mh+cvYqerFl
         +dSuM+DRlKdQJTPlH25nAwZSWC16wBpOcLiNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=J1TQCp3rDY9vY3U+dfd2ngdxVayWXEJJd1SXd/jo4f0=;
        b=mkANQEFvownaTAlYNpe/VTW2u8gVVQgxArr66aDXx3UiW55gSau4FDSxH+7SGom77b
         VnT5zTX996pc6dhFG4OcWWNZl0xDFVHW0ToD7THOP7La5xYFpY2JH+qKjajPCo5M013K
         PdKMmPczV4YdrrQRIbtKv0CF0XH0SrsD7UQhRFOHj50OroGmn9g274JbUihe/Wh8ZkOb
         yxt1Yu2d9NOGfuuaBCWM9Hi8WofmUu5FjbXlJpFj3ogtaEEfAJccipUw0qYYUHJ/DzTW
         HDMrmdY2ZtDeTgh1qC0Y8LXq9v1Y0DCUZJ3YreCyEvtdQ2lh5t3jeBxsqTAouz3J+02L
         0AQA==
X-Gm-Message-State: APjAAAXPPZwY4tuRqXrBm++f9VgJkZgHfQbIpeRxK1qT3bhemOqS+yy5
        WxilFkMiKkL5mQSoFWO3+/T7TzC6+Ywk5jgnNvNKPulH
X-Google-Smtp-Source: APXvYqxq6kg7QjLvd7jLhlmra9948vtNHWAuJAYroa0vl61WLAGLKr6Wnh9oTOLMI0tlBKVO+SzSgUy+fiQOnDktbys=
X-Received: by 2002:a67:6d44:: with SMTP id i65mr54518861vsc.106.1560579716616;
 Fri, 14 Jun 2019 23:21:56 -0700 (PDT)
MIME-Version: 1.0
From:   "Paulsen, Alexander" <alexander@paulsen.at>
Date:   Sat, 15 Jun 2019 08:21:44 +0200
Message-ID: <CAKTMA7ZgoOB65h3PXqK+0Ffsxefd5hDj=zWEN7UkekPWNk6amw@mail.gmail.com>
Subject: raid6 fails to mount after disk failure with unclean shutdown
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

My raid6 fails to mount after a disk failure with unclean shutdown

From other posts I understand that if there is a still working chunk
root I could still get some data back
I have the really important data in backups, but most of my holiday
photos/videos are only on the array, so I'm happy about any partial
data that you could help me restore

I've listed below the output of what I've tried so far below

Hope you can help

Regards,
Alexander

====================
uname -a
Linux fileserver 4.19.44-gentoo #1 SMP Thu May 30 18:05:14 CEST 2019
x86_64 Intel(R) Atom(TM) CPU C2550 @ 2.40GHz GenuineIntel GNU/Linux

====================
btrfs --version
btrfs-progs v5.1

====================
btrfs fi show
warning, device 5 is missing
warning, device 5 is missing
checksum verify failed on 24535404544000 found B267AF82 wanted 3AA9B87A
checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32
checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32
bad tree block 24535404544000, bytenr mismatch, want=24535404544000,
have=2218124645305391268
Couldn't read chunk tree
Label: 'storageraid'  uuid: 3d64f87e-ad07-4699-b1b8-3f7641e06a40
        Total devices 7 FS bytes used 6.33TiB
        devid    1 size 3.64TiB used 1.29TiB path /dev/sdd
        devid    2 size 3.64TiB used 1.29TiB path /dev/sde
        devid    3 size 3.64TiB used 1.29TiB path /dev/sdc
        devid    4 size 2.73TiB used 1.29TiB path /dev/sdh
        devid    6 size 2.73TiB used 1.29TiB path /dev/sdg
        devid    7 size 2.73TiB used 1.29TiB path /dev/sdf
        *** Some devices missing

====================
btrfs-find-root /dev/sdc
warning, device 5 is missing
warning, device 5 is missing
Couldn't read chunk tree
ERROR: open ctree failed

====================
btrfs check /dev/sdc
Opening filesystem to check...
warning, device 5 is missing
warning, device 5 is missing
checksum verify failed on 24535404544000 found B267AF82 wanted 3AA9B87A
checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32
checksum verify failed on 24535404544000 found 76ED7CB0 wanted 8F0CFD32
bad tree block 24535404544000, bytenr mismatch, want=24535404544000,
have=2218124645305391268
Couldn't read chunk tree
ERROR: cannot open file system

====================
mount -o ro,degraded,recovery /dev/sdc /media/storageraid/
mount: /media/storageraid: wrong fs type, bad option, bad superblock
on /dev/sdc, missing codepage or helper program, or other error.

[14387.814655] BTRFS info (device sdd): allowing degraded mounts
[14387.814660] BTRFS warning (device sdd): 'recovery' is deprecated,
use 'usebackuproot' instead
[14387.814662] BTRFS info (device sdd): trying to use backup root at mount time
[14387.814663] BTRFS info (device sdd): disk space caching is enabled
[14387.814665] BTRFS info (device sdd): has skinny extents
[14387.815969] BTRFS warning (device sdd): devid 5 uuid
19311aa5-8c43-4451-9a5a-dca5232433ee is missing
[14388.061497] BTRFS warning (device sdd): devid 5 uuid
19311aa5-8c43-4451-9a5a-dca5232433ee is missing
[14388.232021] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.232360] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.252358] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.272443] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.309782] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.329857] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.349639] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.349982] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.354073] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.374161] BTRFS error (device sdd): bad tree block start, want
23698850185216 have 0
[14388.771856] BTRFS error (device sdd): open_ctree failed


====================
btrfs rescue chunk-recover -v /dev/sdc
All Devices:
        Device: id = 6, name = /dev/sdg
        Device: id = 4, name = /dev/sdh
        Device: id = 2, name = /dev/sde
        Device: id = 7, name = /dev/sdf
        Device: id = 1, name = /dev/sdd
        Device: id = 3, name = /dev/sdc

Scanning: 109959925760 in dev0, 81973956608 in dev1, 122966462464 in
dev2, 102231920640 in dev3, 123404374016 in dev4, 119399600128 in
dev5Segmentation fault

[13286.275585] btrfs[7207]: segfault at 7f124fb40799 ip
000056380b12dd98 sp 00007f11db7fdc10 error 4 in
btrfs[56380b0c9000+d3000]
[13286.275595] Code: 48 8d 14 92 49 89 f6 41 55 48 8d 14 92 49 89 fd
41 54 55 53 48 8d 64 24 f8 8b 9c 17 f6 00 00 00 bf 01 00 00 00 48 8d
6c 18 65 <0f> b7 75 2c 49 89 f7 48 c1 e6 05 48 81 c6 a8 00 00 00 e8 11
e9 fa

====================
btrfs rescue super-recover -v /dev/sdc
All Devices:
        Device: id = 6, name = /dev/sdg
        Device: id = 4, name = /dev/sdh
        Device: id = 2, name = /dev/sde
        Device: id = 7, name = /dev/sdf
        Device: id = 1, name = /dev/sdd
        Device: id = 3, name = /dev/sdc

Before Recovering:
        [All good supers]:
                device name = /dev/sdg
                superblock bytenr = 65536

                device name = /dev/sdg
                superblock bytenr = 67108864

                device name = /dev/sdg
                superblock bytenr = 274877906944

                device name = /dev/sdh
                superblock bytenr = 65536

                device name = /dev/sdh
                superblock bytenr = 67108864

                device name = /dev/sdh
                superblock bytenr = 274877906944

                device name = /dev/sde
                superblock bytenr = 65536

                device name = /dev/sde
                superblock bytenr = 67108864

                device name = /dev/sde
                superblock bytenr = 274877906944

                device name = /dev/sdf
                superblock bytenr = 65536

                device name = /dev/sdf
                superblock bytenr = 67108864

                device name = /dev/sdf
                superblock bytenr = 274877906944

                device name = /dev/sdd
                superblock bytenr = 65536

                device name = /dev/sdd
                superblock bytenr = 67108864

                device name = /dev/sdd
                superblock bytenr = 274877906944

                device name = /dev/sdc
                superblock bytenr = 65536

                device name = /dev/sdc
                superblock bytenr = 67108864

                device name = /dev/sdc
                superblock bytenr = 274877906944

        [All bad supers]:

All supers are valid, no need to recover

====================
btrfs inspect-internal dump-super -f -a /dev/sdc
superblock: bytenr=65536, device=/dev/sdc
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x2e19b950 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
label                   storageraid
generation              106736
root                    24113334845440
sys_array_size          578
chunk_root_generation   102377
root_level              1
chunk_root              24675241885696
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             24004733018112
bytes_used              6955368067072
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             7
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e9
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        106736
uuid_tree_generation    106736
dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
dev_item.type           0
dev_item.total_bytes    4000787030016
dev_item.bytes_used     1416768782336
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          3
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 3 offset 152908595200
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 1 devid 2 offset 3230662656
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 2 devid 1 offset 3250585600
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 2369598259200
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 4 offset 2369598259200
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 5 devid 6 offset 2369598259200
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
                        stripe 6 devid 7 offset 2369598259200
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 2 offset 3247439872
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 1 devid 3 offset 152690491392
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 2 devid 1 offset 3267362816
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 1395026558976
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 7 offset 1395026558976
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
                        stripe 5 devid 4 offset 1395026558976
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 6 devid 6 offset 1395026558976
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
backup_roots[4]:
        backup 0:
                backup_tree_root:       24113327718400  gen: 106733     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113327734784  gen: 106733     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113327833088  gen: 106733     level: 1
                backup_csum_root:       24113327931392  gen: 106733     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 1:
                backup_tree_root:       24113330208768  gen: 106734     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113330438144  gen: 106734     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113330814976  gen: 106734     level: 1
                backup_csum_root:       24113331830784  gen: 106734     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 2:
                backup_tree_root:       24113332600832  gen: 106735     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113332617216  gen: 106735     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113333010432  gen: 106735     level: 1
                backup_csum_root:       24113333403648  gen: 106735     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 3:
                backup_tree_root:       24113334845440  gen: 106736     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113334927360  gen: 106736     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113335107584  gen: 106736     level: 1
                backup_csum_root:       24113339006976  gen: 106736     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7


superblock: bytenr=67108864, device=/dev/sdc
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x8e78919e [match]
bytenr                  67108864
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
label                   storageraid
generation              106736
root                    24113334845440
sys_array_size          578
chunk_root_generation   102377
root_level              1
chunk_root              24675241885696
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             24004733018112
bytes_used              6955368067072
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             7
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e9
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        106736
uuid_tree_generation    106736
dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
dev_item.type           0
dev_item.total_bytes    4000787030016
dev_item.bytes_used     1416768782336
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          3
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 3 offset 152908595200
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 1 devid 2 offset 3230662656
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 2 devid 1 offset 3250585600
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 2369598259200
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 4 offset 2369598259200
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 5 devid 6 offset 2369598259200
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
                        stripe 6 devid 7 offset 2369598259200
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 2 offset 3247439872
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 1 devid 3 offset 152690491392
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 2 devid 1 offset 3267362816
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 1395026558976
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 7 offset 1395026558976
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
                        stripe 5 devid 4 offset 1395026558976
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 6 devid 6 offset 1395026558976
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
backup_roots[4]:
        backup 0:
                backup_tree_root:       24113327718400  gen: 106733     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113327734784  gen: 106733     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113327833088  gen: 106733     level: 1
                backup_csum_root:       24113327931392  gen: 106733     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 1:
                backup_tree_root:       24113330208768  gen: 106734     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113330438144  gen: 106734     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113330814976  gen: 106734     level: 1
                backup_csum_root:       24113331830784  gen: 106734     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 2:
                backup_tree_root:       24113332600832  gen: 106735     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113332617216  gen: 106735     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113333010432  gen: 106735     level: 1
                backup_csum_root:       24113333403648  gen: 106735     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 3:
                backup_tree_root:       24113334845440  gen: 106736     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113334927360  gen: 106736     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113335107584  gen: 106736     level: 1
                backup_csum_root:       24113339006976  gen: 106736     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7


superblock: bytenr=274877906944, device=/dev/sdc
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x73ffc7af [match]
bytenr                  274877906944
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    3d64f87e-ad07-4699-b1b8-3f7641e06a40
metadata_uuid           3d64f87e-ad07-4699-b1b8-3f7641e06a40
label                   storageraid
generation              106736
root                    24113334845440
sys_array_size          578
chunk_root_generation   102377
root_level              1
chunk_root              24675241885696
chunk_root_level        1
log_root                0
log_root_transid        0
log_root_level          0
total_bytes             24004733018112
bytes_used              6955368067072
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             7
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x1e9
                        ( MIXED_BACKREF |
                          COMPRESS_LZO |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          RAID56 |
                          SKINNY_METADATA )
cache_generation        106736
uuid_tree_generation    106736
dev_item.uuid           47b75b3c-d5fa-467b-baa3-8d655334dd54
dev_item.fsid           3d64f87e-ad07-4699-b1b8-3f7641e06a40 [match]
dev_item.type           0
dev_item.total_bytes    4000787030016
dev_item.bytes_used     1416768782336
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          3
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 24535403790336)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 3 offset 152908595200
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 1 devid 2 offset 3230662656
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 2 devid 1 offset 3250585600
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 2369598259200
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 4 offset 2369598259200
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 5 devid 6 offset 2369598259200
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
                        stripe 6 devid 7 offset 2369598259200
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
        item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 24675241885696)
                length 83886080 owner 2 stripe_len 65536 type SYSTEM|RAID6
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 7 sub_stripes 1
                        stripe 0 devid 2 offset 3247439872
                        dev_uuid 7365879e-fec3-4f58-b592-ee5d266f6311
                        stripe 1 devid 3 offset 152690491392
                        dev_uuid 47b75b3c-d5fa-467b-baa3-8d655334dd54
                        stripe 2 devid 1 offset 3267362816
                        dev_uuid e5a1ef35-39f3-49fe-b462-08ad165d6a8b
                        stripe 3 devid 5 offset 1395026558976
                        dev_uuid 19311aa5-8c43-4451-9a5a-dca5232433ee
                        stripe 4 devid 7 offset 1395026558976
                        dev_uuid e94c7ab3-c05a-49b3-866e-3c69b2094159
                        stripe 5 devid 4 offset 1395026558976
                        dev_uuid 2999ef12-9a84-4eb1-b78b-f13318741fec
                        stripe 6 devid 6 offset 1395026558976
                        dev_uuid 79cafe3d-e51f-432b-ba00-6c3354092e91
backup_roots[4]:
        backup 0:
                backup_tree_root:       24113327718400  gen: 106733     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113327734784  gen: 106733     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113327833088  gen: 106733     level: 1
                backup_csum_root:       24113327931392  gen: 106733     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 1:
                backup_tree_root:       24113330208768  gen: 106734     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113330438144  gen: 106734     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113330814976  gen: 106734     level: 1
                backup_csum_root:       24113331830784  gen: 106734     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 2:
                backup_tree_root:       24113332600832  gen: 106735     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113332617216  gen: 106735     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113333010432  gen: 106735     level: 1
                backup_csum_root:       24113333403648  gen: 106735     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7

        backup 3:
                backup_tree_root:       24113334845440  gen: 106736     level: 1
                backup_chunk_root:      24675241885696  gen: 102377     level: 1
                backup_extent_root:     24113334927360  gen: 106736     level: 2
                backup_fs_root:         14085070520320  gen: 102373     level: 3
                backup_dev_root:        24113335107584  gen: 106736     level: 1
                backup_csum_root:       24113339006976  gen: 106736     level: 3
                backup_total_bytes:     24004733018112
                backup_bytes_used:      6955368067072
                backup_num_devices:     7
