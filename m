Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5E5218E70
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 19:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGHRkQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 13:40:16 -0400
Received: from mail.robco.com ([64.119.213.201]:58510 "EHLO mail.robco.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbgGHRkP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 13:40:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id 394F9D3F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 13:40:15 -0400 (EDT)
Received: from mail.robco.com ([127.0.0.1])
        by localhost (mail.robco.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Q41kyV8zUfun for <linux-btrfs@vger.kernel.org>;
        Wed,  8 Jul 2020 13:40:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id 10C9DD83
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 13:40:15 -0400 (EDT)
X-Virus-Scanned: amavisd-new at robco.com
Received: from mail.robco.com ([127.0.0.1])
        by localhost (mail.robco.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PS65Wg59Tw6j for <linux-btrfs@vger.kernel.org>;
        Wed,  8 Jul 2020 13:40:14 -0400 (EDT)
Received: from mail.robco.com (localhost [127.0.0.1])
        by mail.robco.com (Postfix) with ESMTP id CE13CD3F
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 13:40:14 -0400 (EDT)
Date:   Wed, 8 Jul 2020 13:40:14 -0400 (EDT)
From:   Lai Wei-Hwa <whlai@robco.com>
To:     linux-btrfs@vger.kernel.org
Message-ID: <1296241258.348726.1594230014650.JavaMail.zimbra@robco.com>
Subject: bytenr mismatch - Can I fix this?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.10.1]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Index: 6R0QIKe8KBCo/NgmboGpVPKw6geQdQ==
Thread-Topic: bytenr mismatch - Can I fix this?
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Hi there,

I have an unmountable volume. Is it possible to recover my data? Can someone advise on how to proceed?

# btrfs check --repair Pool-1.img.broken
enabling repair mode
checksum verify failed on 90201440256 found E4E3BDB6 wanted 00000000
checksum verify failed on 90201440256 found E4E3BDB6 wanted 00000000
checksum verify failed on 90201440256 found E4E3BDB6 wanted 00000000
checksum verify failed on 90201440256 found E4E3BDB6 wanted 00000000
bytenr mismatch, want=90201440256, have=0
ERROR: cannot open file system

================================================================
================================================================

# btrfs inspect-internal dump-super -Ffa /var/snap/lxd/common/lxd/disks/Pool-1.img.broken

superblock: bytenr=65536, device=/var/snap/lxd/common/lxd/disks/Pool-1.img.broken
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0x009450b6 [match]
bytenr            65536
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            ce7401fb-f189-4341-8464-e69dfe5ad268
label           
generation        1537924
root            710590464
sys_array_size        129
chunk_root_generation    255534
root_level        1
chunk_root        22020096
chunk_root_level    0
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        132212252672
bytes_used        127395315712
sectorsize        4096
nodesize        16384
leafsize (deprecated)        16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x161
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA )
cache_generation    1537924
uuid_tree_generation    1537924
dev_item.uuid        809ccac5-d38c-4294-819a-f21f1cc8fdd5
dev_item.fsid        ce7401fb-f189-4341-8464-e69dfe5ad268 [match]
dev_item.type        0
dev_item.total_bytes    132212252672
dev_item.bytes_used    132211146752
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
        num_stripes 2 sub_stripes 0
            stripe 0 devid 1 offset 22020096
            dev_uuid 809ccac5-d38c-4294-819a-f21f1cc8fdd5
            stripe 1 devid 1 offset 30408704
            dev_uuid 809ccac5-d38c-4294-819a-f21f1cc8fdd5
backup_roots[4]:
    backup 0:
        backup_tree_root:    710410240    gen: 1537922    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    709427200    gen: 1537922    level: 2
        backup_fs_root:        711000064    gen: 1537922    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    709754880    gen: 1537922    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127397171200
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    713179136    gen: 1537923    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    709066752    gen: 1537923    level: 2
        backup_fs_root:        708689920    gen: 1537923    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    708952064    gen: 1537923    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127395315712
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    710590464    gen: 1537924    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    710606848    gen: 1537924    level: 2
        backup_fs_root:        708689920    gen: 1537923    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    710868992    gen: 1537924    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127395315712
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    708706304    gen: 1537921    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    708198400    gen: 1537921    level: 2
        backup_fs_root:        707084288    gen: 1537921    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    708116480    gen: 1537921    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127396753408
        backup_num_devices:    1


superblock: bytenr=67108864, device=/var/snap/lxd/common/lxd/disks/Pool-1.img.broken
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xa0f57878 [match]
bytenr            67108864
flags            0x1
            ( WRITTEN )
magic            _BHRfS_M [match]
fsid            ce7401fb-f189-4341-8464-e69dfe5ad268
label           
generation        1537924
root            710590464
sys_array_size        129
chunk_root_generation    255534
root_level        1
chunk_root        22020096
chunk_root_level    0
log_root        0
log_root_transid    0
log_root_level        0
total_bytes        132212252672
bytes_used        127395315712
sectorsize        4096
nodesize        16384
leafsize (deprecated)        16384
stripesize        4096
root_dir        6
num_devices        1
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x161
            ( MIXED_BACKREF |
              BIG_METADATA |
              EXTENDED_IREF |
              SKINNY_METADATA )
cache_generation    1537924
uuid_tree_generation    1537924
dev_item.uuid        809ccac5-d38c-4294-819a-f21f1cc8fdd5
dev_item.fsid        ce7401fb-f189-4341-8464-e69dfe5ad268 [match]
dev_item.type        0
dev_item.total_bytes    132212252672
dev_item.bytes_used    132211146752
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
        num_stripes 2 sub_stripes 0
            stripe 0 devid 1 offset 22020096
            dev_uuid 809ccac5-d38c-4294-819a-f21f1cc8fdd5
            stripe 1 devid 1 offset 30408704
            dev_uuid 809ccac5-d38c-4294-819a-f21f1cc8fdd5
backup_roots[4]:
    backup 0:
        backup_tree_root:    710410240    gen: 1537922    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    709427200    gen: 1537922    level: 2
        backup_fs_root:        711000064    gen: 1537922    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    709754880    gen: 1537922    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127397171200
        backup_num_devices:    1

    backup 1:
        backup_tree_root:    713179136    gen: 1537923    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    709066752    gen: 1537923    level: 2
        backup_fs_root:        708689920    gen: 1537923    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    708952064    gen: 1537923    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127395315712
        backup_num_devices:    1

    backup 2:
        backup_tree_root:    710590464    gen: 1537924    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    710606848    gen: 1537924    level: 2
        backup_fs_root:        708689920    gen: 1537923    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    710868992    gen: 1537924    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127395315712
        backup_num_devices:    1

    backup 3:
        backup_tree_root:    708706304    gen: 1537921    level: 1
        backup_chunk_root:    22020096    gen: 255534    level: 0
        backup_extent_root:    708198400    gen: 1537921    level: 2
        backup_fs_root:        707084288    gen: 1537921    level: 2
        backup_dev_root:    1012645888    gen: 255534    level: 0
        backup_csum_root:    708116480    gen: 1537921    level: 2
        backup_total_bytes:    132212252672
        backup_bytes_used:    127396753408
        backup_num_devices:    1

# btrfs-find-root Pool-1.img.broken
Superblock thinks the generation is 1537924
Superblock thinks the level is 1
Found tree root at 710590464 gen 1537924 level 1
Well block 710410240(gen: 1537922 level: 1) seems good, but generation/level doesn't match, want gen: 1537924 level: 1
Well block 705495040(gen: 1537920 level: 1) seems good, but generation/level doesn't match, want gen: 1537924 level: 1
Well block 683982848(gen: 1537919 level: 1) seems good, but generation/level doesn't match, want gen: 1537924 level: 1
...... (clipped for space - all other lines are similar - i.e. Well block n seems good but generation/level doesn't match)


Lai
