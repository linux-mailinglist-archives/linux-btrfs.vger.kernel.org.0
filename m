Return-Path: <linux-btrfs+bounces-9009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CEF9A4EDB
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54EF92857D9
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A264A149C4F;
	Sat, 19 Oct 2024 14:52:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B73120E31D
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349557; cv=none; b=MRZFRR/tSbRRQfLHF33Q/LLKRsx/m7jfavfGs511oh7ysvR4/paRqHMh5KeAZv26AbEIdcetg3ly4cFLbv18dbdkSfA/oOQkrRRc04GykGyFVbMKNC0HPk8D74WQO6Z5sojpQMmGqoJTG9Q2p1rCL3DbxmtuSLQZGQxnCKZr7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349557; c=relaxed/simple;
	bh=KA8yJdjsW6w9jLd/TRgk/5n5D32EUqI1FQHbvpg9mdc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XbbvG7OEq0F6plfB4q74kCoQr3oln03lbziwZ3L606HujfHZApLuZW9J9L/uRNF6UMlqjGnhrZE3VvTj81FzOo7EHDxejpVAmdC69IxY2/BvTzhknIj4yoY4xesusGOrF5+/HIaCGPUKzb7tvLlwsE/cegd5uC1PNYpfYwnMnZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bllue.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bllue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e59746062fso224947a91.2
        for <linux-btrfs@vger.kernel.org>; Sat, 19 Oct 2024 07:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349554; x=1729954354;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OZ/aZ0j0KYp+K/OY9ZHA3hvZih6ulcH5Zf2RN44ta9M=;
        b=Ce4jJOYVWLffC4FXCI8jmwsB+PpqAFx65FgHh+vl1aNPLq7GibHjv6vRYMegACv+pr
         ok2A/IOfcGRwV74LuP8BLOqljhYkMzw743oETVR5SzqRZ6+3yFCj7BhMIUjX68J/e305
         dj3NFszUr4BGFFFdtsQudxww9g9pNJ9v5wNFaA2A9pNhi4A/o6BTwwyVEH4eBrbBI/hJ
         YMOU20Mx2BjojgOnEomV2zM4TUzBWRaJiAAkTOZx9NyHc/pZcfqBOWxQpVcctrVIK5B2
         +2qr+IAyi7kF1MP3R2ko+BjE5CWkCNUDh1mo8NYS1bicpyNETdS0CtU5PPfUWgEYFyeQ
         r2bw==
X-Gm-Message-State: AOJu0YxG1UZ96QgPk2OZz8p4aLruoppqaY2v8KH8vX45skPjXaraJNBC
	o9z6PzPFNHpw2uO5kdSynClu4Db973u11apcKtvuQkgTzUPwsHR94Kh8XWsZTGura9XxtNWFvte
	u5FkqDjJe8diK5Jg9aChDKA1xLEuGnIMR
X-Google-Smtp-Source: AGHT+IGL3BnYi31Dh7FF4vhYSdbN+Kck+S82iKjMI2aHJhYHXeiXZx4X/XE4RfyzKErAIRyMLra1cx/1SmxPHZ7HUtA=
X-Received: by 2002:a17:90a:4942:b0:2e2:cd2f:b919 with SMTP id
 98e67ed59e1d1-2e5616ed0a6mr7195072a91.28.1729349553573; Sat, 19 Oct 2024
 07:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ken <ken@bllue.org>
Date: Sat, 19 Oct 2024 10:52:22 -0400
Message-ID: <CAE6xmHK2WV+n1NFwiUGy5h0ir6xxeiC+G1NOf4KCPvdEN50PZw@mail.gmail.com>
Subject: btrfs filesystem so full I cannot mount it.
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have a filesystem that (I think) is so full I cannot mount it.  when
I do, it seems stuck in btrfs_start_pre_rw_mount->btrfs_orphan_cleanup
forever.  I have let it run for a few hours, and it seems to be
incrementally reading/writing the filesystem, but I'm not sure if
that's a good thing or a bad thing.   Below is a kernel stack of mount
when this is happening.  I'm running btrfs check right now, and it's
still on step 4/7 but I'm committed to letting it finish this time, so
I can be sure that there's no underlying issues.

I've tried to mount clear_cache which seemed to run, but it didn't
hange that I'm stuck in orphan_cleanup.  There are no btrfs error
messages in journald.

I'd like to get back to normal, my backups are a bit old, so even a
read-only mount would be nice (I haven't yet tried) but I'm hoping for
a resolution where I can just mount the thing, and free up a bunch of
space.  My next great idea is just adding another disk to the
filesystem, but I thought it's time to ask for guidance from the list.
this filesystem is -d single -m raid1 and uses space group v2, which
was great because it used to take 5 minutes to mount the filesystem.


Any guidance would be most appreciated, I've tried to include a
cursory detail of what's happening below.  Please let me know if
there's anything more I can provide or steps I should take.




Oct 19 01:07:43 myhost kernel: task:mount           state:D stack:0
 pid:13675 tgid:13675 ppid:12146  flags:0x00004002
Oct 19 01:07:43 myhost kernel: Call Trace:
Oct 19 01:07:43 myhost kernel:  <TASK>
Oct 19 01:07:43 myhost kernel:  __schedule+0x400/0x1720
Oct 19 01:07:43 myhost kernel:  schedule+0x27/0xf0
Oct 19 01:07:43 myhost kernel:  io_schedule+0x46/0x70
Oct 19 01:07:43 myhost kernel:  bit_wait_io+0x11/0x70
Oct 19 01:07:43 myhost kernel:  __wait_on_bit+0x45/0x160
Oct 19 01:07:43 myhost kernel:  ? __pfx_bit_wait_io+0x10/0x10
Oct 19 01:07:43 myhost kernel:  out_of_line_wait_on_bit+0x94/0xc0
Oct 19 01:07:43 myhost kernel:  ? __pfx_wake_bit_function+0x10/0x10
Oct 19 01:07:43 myhost kernel:  read_extent_buffer_pages+0x1de/0x220
Oct 19 01:07:43 myhost kernel:  btrfs_read_extent_buffer+0x94/0x1c0
Oct 19 01:07:43 myhost kernel:  read_tree_block+0x32/0x90
Oct 19 01:07:43 myhost kernel:  read_block_for_search+0x247/0x360
Oct 19 01:07:43 myhost kernel:  btrfs_search_slot+0x375/0x1060
Oct 19 01:07:43 myhost kernel:  ? btrfs_extent_root+0x85/0xb0
Oct 19 01:07:43 myhost kernel:  lookup_inline_extent_backref+0x174/0x810
Oct 19 01:07:43 myhost kernel:  ? __slab_free+0xdf/0x2e0
Oct 19 01:07:43 myhost kernel:  lookup_extent_backref+0x41/0xd0
Oct 19 01:07:43 myhost kernel:  __btrfs_free_extent.isra.0+0x110/0xa10
Oct 19 01:07:43 myhost kernel:  __btrfs_run_delayed_refs+0x592/0xfc0
Oct 19 01:07:43 myhost kernel:  ? release_extent_buffer+0xb1/0xd0
Oct 19 01:07:43 myhost kernel:  ? __write_extent_buffer+0x14b/0x1a0
Oct 19 01:07:43 myhost kernel:  ? btrfs_release_path+0x2b/0x190
Oct 19 01:07:43 myhost kernel:  ? update_block_group_item+0x16d/0x1b0
Oct 19 01:07:43 myhost kernel:  btrfs_run_delayed_refs+0x3b/0xd0
Oct 19 01:07:43 myhost kernel:  btrfs_start_dirty_block_groups+0x303/0x530
Oct 19 01:07:43 myhost kernel:  btrfs_commit_transaction+0xb5/0xc90
Oct 19 01:07:43 myhost kernel:  ? start_transaction+0x22c/0x830
Oct 19 01:07:43 myhost kernel:  flush_space+0xfa/0x5b0
Oct 19 01:07:43 myhost kernel:  ? btrfs_reduce_alloc_profile+0x9e/0x1d0
Oct 19 01:07:43 myhost kernel:  priority_reclaim_metadata_space+0x94/0x150
Oct 19 01:07:43 myhost kernel:  __reserve_bytes+0x2a7/0x6e0
Oct 19 01:07:43 myhost kernel:  ? __slab_free+0xdf/0x2e0
Oct 19 01:07:43 myhost kernel:  btrfs_reserve_metadata_bytes+0x1d/0xc0
Oct 19 01:07:43 myhost kernel:  btrfs_block_rsv_refill+0x6b/0xa0
Oct 19 01:07:43 myhost kernel:  evict_refill_and_join+0x4b/0xc0
Oct 19 01:07:43 myhost kernel:  btrfs_evict_inode+0x30a/0x3c0
Oct 19 01:07:43 myhost kernel:  evict+0x10e/0x2c0
Oct 19 01:07:43 myhost kernel:  ? unlock_new_inode+0x4c/0x60
Oct 19 01:07:43 myhost kernel:  ? _atomic_dec_and_lock+0x39/0x50
Oct 19 01:07:43 myhost kernel:  btrfs_orphan_cleanup+0x209/0x2e0
Oct 19 01:07:43 myhost kernel:  btrfs_start_pre_rw_mount+0x1ab/0x480
Oct 19 01:07:43 myhost kernel:  open_ctree+0x1063/0x1426
Oct 19 01:07:43 myhost kernel:  btrfs_get_tree.cold+0x6b/0x10e
Oct 19 01:07:43 myhost kernel:  ? vfs_dup_fs_context+0x2d/0x1e0
Oct 19 01:07:43 myhost kernel:  vfs_get_tree+0x29/0xd0
Oct 19 01:07:43 myhost kernel:  fc_mount+0x12/0x40
Oct 19 01:07:43 myhost kernel:  btrfs_get_tree+0x30e/0x700
Oct 19 01:07:43 myhost kernel:  vfs_get_tree+0x29/0xd0
Oct 19 01:07:43 myhost kernel:  vfs_cmd_create+0x65/0xf0
Oct 19 01:07:43 myhost kernel:  __do_sys_fsconfig+0x43c/0x670
Oct 19 01:07:43 myhost kernel:  do_syscall_64+0x82/0x160
Oct 19 01:07:43 myhost kernel:  ? do_faccessat+0x1e4/0x2e0
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? syscall_exit_to_user_mode+0x72/0x220
Oct 19 01:07:43 myhost kernel:  ? do_syscall_64+0x8e/0x160
Oct 19 01:07:43 myhost kernel:  ? exc_page_fault+0x7e/0x180
Oct 19 01:07:43 myhost kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Oct 19 01:07:43 myhost kernel: RIP: 0033:0x7fee827a383e
Oct 19 01:07:43 myhost kernel: RSP: 002b:00007ffde9f8d058 EFLAGS:
00000246 ORIG_RAX: 00000000000001af
Oct 19 01:07:43 myhost kernel: RAX: ffffffffffffffda RBX:
000055927b56fa90 RCX: 00007fee827a383e
Oct 19 01:07:43 myhost kernel: RDX: 0000000000000000 RSI:
0000000000000006 RDI: 0000000000000003
Oct 19 01:07:43 myhost kernel: RBP: 00007ffde9f8d1a0 R08:
0000000000000000 R09: 00007fee82896b20
Oct 19 01:07:43 myhost kernel: R10: 0000000000000000 R11:
0000000000000246 R12: 00007fee8291cb00
Oct 19 01:07:43 myhost kernel: R13: 0000000000000000 R14:
000055927b570bd0 R15: 00007fee82911561
Oct 19 01:07:43 myhost kernel:  </TASK>


# btrfs check -p /dev/mapper/cprt-50
Opening filesystem to check...
Checking filesystem on /dev/mapper/cprt-50
UUID: b8b8786b-77ad-41aa-bd17-4607d4a7c428
[1/8] checking log skipped (none written)
[1/7] checking root items                      (0:35:12 elapsed,
60022243 items checked)
[2/7] checking extents                         (0:40:49 elapsed,
6069209 items checked)
[3/7] checking free space tree                 (0:36:47 elapsed, 63245
items checked)
[4/7] checking fs roots                        (6:20:51 elapsed,
453264 items checked)


# btrfs filesystem show /dev/mapper/cprt-50
Label: 'dtm'  uuid: b8b8786b-77ad-41aa-bd17-4607d4a7c428
        Total devices 4 FS bytes used 61.75TiB
        devid    1 size 16.37TiB used 16.37TiB path /dev/mapper/cprt-62
        devid    2 size 16.37TiB used 16.37TiB path /dev/mapper/cprt-63
        devid    3 size 14.55TiB used 14.55TiB path /dev/mapper/cprt-50
        devid    4 size 14.55TiB used 14.55TiB path /dev/mapper/cprt-53


# messages, this filesystem is label dtm/ b8b8786b-77ad-41aa-bd17-4607d4a7c428
Oct 18 18:06:48 static.bllue.org kernel: Btrfs loaded, zoned=yes, fsverity=yes
Oct 18 18:06:57 static.bllue.org kernel: BTRFS: device label dtm devid
4 transid 790228 /dev/dm-0 (253:0) scanned by (udev-worker) (722)
Oct 18 18:06:58 static.bllue.org kernel: BTRFS: device label ex:home2
devid 1 transid 290610 /dev/dm-2 (253:2) scanned by (udev-worker)
(722)
Oct 18 18:07:02 static.bllue.org kernel: BTRFS: device label dtm devid
1 transid 790228 /dev/dm-5 (253:5) scanned by (udev-worker) (719)
Oct 18 18:07:03 static.bllue.org kernel: BTRFS: device label ex:home2
devid 2 transid 290610 /dev/dm-6 (253:6) scanned by (udev-worker)
(722)
Oct 18 18:07:11 static.bllue.org kernel: BTRFS: device label ex:home2b
devid 2 transid 847454 /dev/dm-12 (253:12) scanned by (udev-worker)
(722)
Oct 18 18:07:15 static.bllue.org kernel: BTRFS: device label dtm devid
3 transid 790228 /dev/dm-17 (253:17) scanned by (udev-worker) (722)
Oct 18 18:07:19 static.bllue.org kernel: BTRFS: device label dtm devid
2 transid 790228 /dev/dm-22 (253:22) scanned by (udev-worker) (719)
Oct 18 18:07:20 static.bllue.org kernel: BTRFS: device label ex:home2b
devid 1 transid 847454 /dev/dm-23 (253:23) scanned by (udev-worker)
(719)
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23):
first mount of filesystem 60eb6265-d748-406b-9301-2c4e5b3e71c0
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23):
using crc32c (crc32c-intel) checksum algorithm
Oct 18 18:07:21 static.bllue.org kernel: BTRFS info (device dm-23):
using free-space-tree
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5):
first mount of filesystem b8b8786b-77ad-41aa-bd17-4607d4a7c428
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5):
using crc32c (crc32c-intel) checksum algorithm
Oct 18 23:47:18 static.bllue.org kernel: BTRFS info (device dm-5):
using free-space-tree






# for i in cprt-62 cprt-63 cprt-50 cprt-53; do echo == $i ==; btrfs
inspect-internal dump-super /dev/mapper/$i;done
== cprt-62 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-62
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xb3f048e8 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID |
                          BLOCK_GROUP_TREE )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           c066323f-76b6-47d8-8c6c-bcd5fa0ec116
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    18000189063168
dev_item.bytes_used     18000188014592
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          1
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-63 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-63
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x385ea4fd [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID |
                          BLOCK_GROUP_TREE )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           fe160407-2ae0-4d04-9df5-fc7ed52b827a
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    18000189063168
dev_item.bytes_used     18000188014592
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          2
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-50 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-50
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0xe7c8676d [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID |
                          BLOCK_GROUP_TREE )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           072a8618-1b73-400a-8fee-1a3a07998748
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    16000881786880
dev_item.bytes_used     16000880738304
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          3
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0

== cprt-53 ==
superblock: bytenr=65536, device=/dev/mapper/cprt-53
---------------------------------------------------------
csum_type               0 (crc32c)
csum_size               4
csum                    0x8f5d73e9 [match]
bytenr                  65536
flags                   0x1
                        ( WRITTEN )
magic                   _BHRfS_M [match]
fsid                    b8b8786b-77ad-41aa-bd17-4607d4a7c428
metadata_uuid           00000000-0000-0000-0000-000000000000
label                   dtm
generation              790364
root                    26705528995840
sys_array_size          129
chunk_root_generation   788411
root_level              0
chunk_root              27131904
chunk_root_level        1
log_root                0
log_root_transid (deprecated)   0
log_root_level          0
total_bytes             68002141700096
bytes_used              67893970526208
sectorsize              4096
nodesize                16384
leafsize (deprecated)   16384
stripesize              4096
root_dir                6
num_devices             4
compat_flags            0x0
compat_ro_flags         0xb
                        ( FREE_SPACE_TREE |
                          FREE_SPACE_TREE_VALID |
                          BLOCK_GROUP_TREE )
incompat_flags          0x361
                        ( MIXED_BACKREF |
                          BIG_METADATA |
                          EXTENDED_IREF |
                          SKINNY_METADATA |
                          NO_HOLES )
cache_generation        0
uuid_tree_generation    790364
dev_item.uuid           7651b9c3-0b25-4aa5-b3c8-d28602e1779f
dev_item.fsid           b8b8786b-77ad-41aa-bd17-4607d4a7c428 [match]
dev_item.type           0
dev_item.total_bytes    16000881786880
dev_item.bytes_used     16000880738304
dev_item.io_align       4096
dev_item.io_width       4096
dev_item.sector_size    4096
dev_item.devid          4
dev_item.dev_group      0
dev_item.seek_speed     0
dev_item.bandwidth      0
dev_item.generation     0


Ken

