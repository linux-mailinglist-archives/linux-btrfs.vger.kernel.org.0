Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8993168ABCA
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Feb 2023 19:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjBDSQq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 4 Feb 2023 13:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDSQq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Feb 2023 13:16:46 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AB5301AD
        for <linux-btrfs@vger.kernel.org>; Sat,  4 Feb 2023 10:16:43 -0800 (PST)
Date:   Sat, 04 Feb 2023 18:16:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slash.cl;
        s=protonmail; t=1675534600; x=1675793800;
        bh=mRVNA7S6KRPvnMdhf81MBwUKsUJP20mKDRZXEBQE9aE=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=XvljaZw0eRyTGQLB7kIR9ynwoeuqIlqiI0GtNZ1Ipf1RiPJGG149cyFOeM03HbCo1
         VHOeAq3APm1puWBjClk7YPZETiwf/ib16t9M+rKwuoZorM6e6tKYFF7FH70kaXvVpG
         vCMOk8+WI9FD+Tnb3h5/c4jzz3n0VQa7BiZW7kCACu3cYVMVmH4XXUPXW0qZWaX9Ys
         5TIhpFAAQZbSTZgyXaYFUfdeRjBMJ4Gd6KnmRHM+Gy1ul5JnsgNgLP2A4ObnhOdAsA
         nWNF5UeOCCuvUI7oCLCp6eJlTX4uBFUwfZi4lXyHI9NxPHW0sPymIrMRWKQErYmcYx
         nDlRWg0KMG5Uw==
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   WalterCool <waltercool@slash.cl>
Subject: BTRFS is unable to mount
Message-ID: <hzltG1LW9bQTZew6noHePoh_1Iy5cBkzSLCGdscpswGwKEiva5G0NRyLlEv3HvnBhb4I3SZcwzHIJJizN8LM7bxUMj3jrwJvbVPsY9G024g=@slash.cl>
Feedback-ID: 8489026:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi everyone,

Experienced a power issue on my server, but only my BTRFS partition was imp=
acted, now it refuses to work again due "superblock checksum mismatch"

Any command I try to use, it fails with same error and "open_ctree failed"

Attaching dump-supper as suggested on Libera chat.

superblock: bytenr=3D65536, device=3D/dev/mapper/asd
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x929ccdc3 [DON'T MATCH]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    a8556b6d-b904-4e02-b8fd-630439ef36fc
metadata_uuid           a8556b6d-b904-4e02-b8fd-630439ef36fc
label                   external
generation              2703026
root                    5295286026240
sys_array_size          129
chunk_root_generation   2362122
root_level              1
chunk_root              6381378781184
chunk_root_level        1
log_root                5295282438144
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             8001490501632
bytes_used              5122518732800
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x171
                        ( MIXED_BACKREF |
                          COMPRESS_ZSTD |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        2703026
uuid_tree_generation    2703026
dev_item.uuid           01cd44bf-8d38-4360-a130-905efaa86684
dev_item.fsid           a8556b6d-b904-4e02-b8fd-630439ef36fc [match]
dev_item.type           0
dev_item.total_bytes    8001490501632
dev_item.bytes_used     6477959921664
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 6381378732032)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 5799318388736
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
                        stripe 1 devid 1 offset 5799351943168
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
backup_roots[4]:
        backup 0:
                backup_tree_root:       5295279702016   gen: 2703024    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295274295296   gen: 2703024    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295274082304   gen: 2703024    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518683648
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       5295273754624   gen: 2703025    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270789120   gen: 2703025    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295270117376   gen: 2703025    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518708224
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       5295273525248   gen: 2703022    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270100992   gen: 2703022    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295269707776   gen: 2703022    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518650880
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       5295267217408   gen: 2703023    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295262859264   gen: 2703023    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295262121984   gen: 2703023    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518667264
                backup_num_devices:     1


superblock: bytenr=3D67108864, device=3D/dev/mapper/asd
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xc0e6f770 [DON'T MATCH]
bytenr                  67108864
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    a8556b6d-b904-4e02-b8fd-630439ef36fc
metadata_uuid           a8556b6d-b904-4e02-b8fd-630439ef36fc
label                   external
generation              2703026
root                    5295286026240
sys_array_size          129
chunk_root_generation   2362122
root_level              1
chunk_root              6381378781184
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             8001490501632
bytes_used              5122518732800
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x171
                        ( MIXED_BACKREF |
                          COMPRESS_ZSTD |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        2703026
uuid_tree_generation    2703026
dev_item.uuid           01cd44bf-8d38-4360-a130-905efaa86684
dev_item.fsid           a8556b6d-b904-4e02-b8fd-630439ef36fc [match]
dev_item.type           0
dev_item.total_bytes    8001490501632
dev_item.bytes_used     6477959921664
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 6381378732032)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 5799318388736
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
                        stripe 1 devid 1 offset 5799351943168
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
backup_roots[4]:
        backup 0:
                backup_tree_root:       5295279702016   gen: 2703024    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295274295296   gen: 2703024    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295274082304   gen: 2703024    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518683648
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       5295273754624   gen: 2703025    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270789120   gen: 2703025    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295270117376   gen: 2703025    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518708224
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       5295273525248   gen: 2703022    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270100992   gen: 2703022    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295269707776   gen: 2703022    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518650880
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       5295267217408   gen: 2703023    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295262859264   gen: 2703023    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295262121984   gen: 2703023    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518667264
                backup_num_devices:     1


superblock: bytenr=3D274877906944, device=3D/dev/mapper/asd
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x3d61a141 [DON'T MATCH]
bytenr                  274877906944
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    a8556b6d-b904-4e02-b8fd-630439ef36fc
metadata_uuid           a8556b6d-b904-4e02-b8fd-630439ef36fc
label                   external
generation              2703026
root                    5295286026240
sys_array_size          129
chunk_root_generation   2362122
root_level              1
chunk_root              6381378781184
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             8001490501632
bytes_used              5122518732800
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             1
compat_flags            0x0
compat_ro_flags         0x0
incompat_flags          0x171
                        ( MIXED_BACKREF |
                          COMPRESS_ZSTD |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA )
cache_generation        2703026
uuid_tree_generation    2703026
dev_item.uuid           01cd44bf-8d38-4360-a130-905efaa86684
dev_item.fsid           a8556b6d-b904-4e02-b8fd-630439ef36fc [match]
dev_item.type           0
dev_item.total_bytes    8001490501632
dev_item.bytes_used     6477959921664
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0
sys_chunk_array[2048]:
        item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 6381378732032)
                length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
                io_align 65536 io_width 65536 sector_size 4096
                num_stripes 2 sub_stripes 1
                        stripe 0 devid 1 offset 5799318388736
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
                        stripe 1 devid 1 offset 5799351943168
                        dev_uuid 01cd44bf-8d38-4360-a130-905efaa86684
backup_roots[4]:
        backup 0:
                backup_tree_root:       5295279702016   gen: 2703024    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295274295296   gen: 2703024    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295274082304   gen: 2703024    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518683648
                backup_num_devices:     1

        backup 1:
                backup_tree_root:       5295273754624   gen: 2703025    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270789120   gen: 2703025    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295270117376   gen: 2703025    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518708224
                backup_num_devices:     1

        backup 2:
                backup_tree_root:       5295273525248   gen: 2703022    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295270100992   gen: 2703022    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295269707776   gen: 2703022    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518650880
                backup_num_devices:     1

        backup 3:
                backup_tree_root:       5295267217408   gen: 2703023    lev=
el: 1
                backup_chunk_root:      6381378781184   gen: 2362122    lev=
el: 1
                backup_extent_root:     5295262859264   gen: 2703023    lev=
el: 2
                backup_fs_root:         30408704        gen: 1470494    lev=
el: 0
                backup_dev_root:        1308561145856   gen: 2362122    lev=
el: 1
                csum_root:      5295262121984   gen: 2703023    level: 3
                backup_total_bytes:     8001490501632
                backup_bytes_used:      5122518667264
                backup_num_devices:     1


--
WalterCool
