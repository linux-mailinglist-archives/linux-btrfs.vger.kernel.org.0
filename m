Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9148522A0FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 22:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgGVUzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 16:55:22 -0400
Received: from mail.xmyslivec.cz ([83.167.247.77]:48818 "EHLO
        mail.xmyslivec.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVUzV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 16:55:21 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2020 16:55:19 EDT
Received: from [172.21.42.192] (ip-78-102-107-142.net.upcbroadband.cz [78.102.107.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.xmyslivec.cz (Postfix) with ESMTPSA id 14CC3405C4;
        Wed, 22 Jul 2020 22:47:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xmyslivec.cz;
        s=master; t=1595450862;
        bh=VVhbb6GoR//ESa8iVCkWKcW2wFDYfLyMPGuwZBdgnQc=;
        h=From:Cc:To:Subject:Date:From;
        b=EYF1fSzuyYIw0Fd5xgWL3Oi/l3NurpTyJugVChZUQ7Ou7MmHjN2dEP0/9Ekfm+hSl
         yywdJ3BfP8QhvwG+Z8GrMt1O3fIZ9YGBxR2duT2o+3jOif04QGlJi3j1mMs08CQRTq
         YLU3UQgfg1XAaCf2qTH+zMmmmtbb4x1OvI02DuYywYxeP/YjFPQb9cNu8wGouM8xES
         +P29spN4rFHJzkK3j2IKaGj1RB2k9roMFz1otpr2GHEiGjoBE/+/kLdWaQyc2V4DrE
         ULK2w0c3ARKI7X2mNgGckLEiBOwbyWNXDaSBIOm4SU84KScwmqYgS4sh+pmSJjm8BJ
         IMuurvs7XduEQ==
From:   Vojtech Myslivec <vojtech@xmyslivec.cz>
Autocrypt: addr=vojtech@xmyslivec.cz; prefer-encrypt=mutual; keydata=
 mDMEXDk3FBYJKwYBBAHaRw8BAQdAxYGS4sOZd1kASDXgtvBZa7SMJqicmc0FaSpmSZh9S420
 J1ZvanRlY2ggTXlzbGl2ZWMgPHZvanRlY2hAeG15c2xpdmVjLmN6PoiZBBMWCABBAhsDBQkD
 wmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEcy0E0v45eOJcDrwyzG9czj6y/JMFAlw8
 uhkCGQEACgkQzG9czj6y/JMKtQD9Fe633NqvTgifhCogsl3u6nYbOprbqyH9YVPniWhBRioB
 APNejTQYM1gvWAWhtV0rtDjER8i1tIHwq4sJUw594HQDuDgEXDk3FBIKKwYBBAGXVQEFAQEH
 QDR6xHA2ZcMD6DRi7xqX5spgU+7EJJI03zmAE6936SJtAwEIB4h+BBgWCAAmFiEEcy0E0v45
 eOJcDrwyzG9czj6y/JMFAlw5NxQCGwwFCQPCZwAACgkQzG9czj6y/JPF6wEAz8Um0I7iFLGI
 kxHnWDeYKFgnkRyQgShZWm0/xmBToCYA/iT0Ug9beOLu/pbptwA9V5QQ//78SZ7R0PoXwxTf
 MqIIuDMEXDy4fRYJKwYBBAHaRw8BAQdAsd+asyPI2WagjyIEmoDI7mjcy45kZs3LEU0LgXeG
 4IKI9QQYFggAJhYhBHMtBNL+OXjiXA68MsxvXM4+svyTBQJcPLh9AhsCBQkDwmcAAIEJEMxv
 XM4+svyTdiAEGRYIAB0WIQTRAYeGgCc08YdlVnm4uGCQpsyH1wUCXDy4fQAKCRC4uGCQpsyH
 106rAQDZjQVT6qDwg5WNk4DTZmbzg4usw7Q08gs0hDazIz0H9AEAmEj8bg68fvjJUMO3GYY0
 HzfSH0m6wiJpNrPPbQunhQ1vpwEAwkISc77KHnx3pKeZ6Ilx5O6w5S8uJetnQIiNuUZkkcMB
 AIXDxrKP3h8c416yo4gjtRH4bdtsMkgv8jtRXXSty+YA
Cc:     Michal Moravec <michal.moravec@logicworks.cz>
To:     linux-btrfs@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Linux RAID with btrfs stuck and consume 100 % CPU
Message-ID: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
Date:   Wed, 22 Jul 2020 22:47:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------AEBF12DB90E8ADA7E54186F2"
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------AEBF12DB90E8ADA7E54186F2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello,

I would like to file an issue related to a btrfs filesystem on a md RAID
and I am not sure which one is the cause of this problem. So I write to
both mailing lists at once.

My colleague, who spent a lot of time experiencing and trying to
workaround the issue, is in CC:

Thank you for any help,
Vojtech Myslivec



The issue
=========

During last several weeks, I am experiencing annoying issue on my
physical server with Linux software RAID 6 with write journal and btrfs
filesystem on top of it. Disks setup is described below.

This host serves as a backup server and it runs regular backup tasks.
When a backup is performed, one (read only) snapshot of one of my
subvolumes on the btrfs filesystem is created and one snapshot is
deleted afterwards.

Once in several days (irregularly, as I noticed), the `md1_raid6`
process starts to consume 100 % of one CPU core and during that time,
creating a snapshot (during the regular backup process) of a btrfs
subvolume get stucked. User space processes accessing this particular
subvolume then start to hang in *disk sleep* state. Access to other
subvolumes seems to be unaffected until another backup process tries to
create another snapshot (of different subvolume).

In most cases, after several "IO" actions like listing files (ls),
accessing btrfs information (`btrfs filesystem`, `btrfs subvolume`), or
accessing the device (with `dd` or whatever), the filesystem gets
magically unstucked and `md1_raid6` process released from its "live
lock" (or whatever it is cycled in). Snapshots are then created as
expected and all processes finish their job.

Once in a week approximately, it takes tens of minutes to unstuck these
processes. During that period, I try to access affected btrfs subvolumes
in several shell sessions to wake it up.

If I let the system untouched and let just let it be, the system unstuck
itself after several hours. This happens often during a night when I am
not awake to try to unstuck the filesystem manually.

Also, the worse case happens sometimes, when I am not successful with
this "magic unstucking". I am not able to even kill the processes
stucked in disk sleep state then and I am forced to restart the system.

When my issue happens, I found very often similar messages in kernel
dmesg log:

    INFO: task md1_reclaim:910 blocked for more than 120 seconds.

with included call trace.

However, there are some more "blocked" tasks, like `btrfs` and
`btrfs-transaction` with call trace also included.


Questions
=========

1. What should be the cause of this problem?
2. What should I do to mitigate this issue?
3. Could it be a hardware problem? How can I track this?


What I have done so far
=======================

- I keep the system up-to-date, with latest stable kernel provided by
  Debian packages

- I run both `btrfs scrub` and `fsck.btrfs` to exclude btrfs filesystem
  issue.

- I have read all the physical disks (with dd command) and perform SMART
  self tests to exclude disks issue (though read/write badblocks were
  not checked yet).

- I have also moved all the files out of the affected filesystem, create
  a new btrfs filesystem (with recent btrfs-progs) and moved files
  back. This issue, none the less, appeared again.

- I have tried to attach strace to cycled md1 process, but
  unsuccessfully (is it even possible to strace running kernel thread?)

- Of course, I have tried to find similar issues around the web, but I
  was not successful.


Some detailed facts
===================

OS
--

- Debian 10 buster (stable release)
- Linux kernel 5.5 (from Debian backports)
- btrfs-progs 5.2.1 (from Debian backports)

Hardware
--------

- 8 core/16 threads amd64 processor (AMD EPYC 7251)
- 6 SATA HDD disks (Seagate Enterprise Capacity)
- 2 SSD disks (Intel D3-S4610)

RAID
----

- All Linux MD RAID (no HW RAID used)
- RAID1 over 2 SSD (md0)
    - On top of this RAID1 is a LVM with logical volumes for:
        - root filesystem
        - swap
        - RAID6 write journal
- RAID6 over 6 HDD and 1 LV as write journal (md1)
    - This is the affected device

btrfs
-----
- Several subvolumes, tens of snapshots
- Default mount options: rw,noatime,space_cache,subvolid=5,subvol=/
- No compression, autodefrag or so
- I have tried to use quotas in the past but they are disabled for
  a long time

Usage
-----

- Affected RAID6 block device is directly formatted to btrfs
- This filesystem is used to store backups
- Backups are performed via rsnapshot
- rsnapshot is configured to use btrfs snapshots for hourly and daily
  backups and rsync to copy new backups

Other IO operations
-------------------

- There is ongoing monitoring through Icinga which uses iostat
  internally to monitor I/O
- SMART selftests run periodically (on weekly and monthly basis)



--------------AEBF12DB90E8ADA7E54186F2
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg-btrfs.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg-btrfs.log"

[  +0,000032] INFO: task btrfs:14183 blocked for more than 120 seconds.
[  +0,000030]       Not tainted 5.5.0-0.bpo.2-amd64 #1 Debian 5.5.17-1~bp=
o10+1
[  +0,000033] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[  +0,000036] btrfs           D    0 14183  14177 0x00004000
[  +0,000002] Call Trace:
[  +0,000003]  ? __schedule+0x2db/0x700
[  +0,000001]  ? mempool_alloc+0x67/0x190
[  +0,000002]  schedule+0x40/0xb0
[  +0,000007]  md_write_start+0x14b/0x220 [md_mod]
[  +0,000002]  ? finish_wait+0x80/0x80
[  +0,000002]  ? finish_wait+0x80/0x80
[  +0,000005]  raid5_make_request+0x83/0xb50 [raid456]
[  +0,000004]  ? bio_add_page+0x39/0x90
[  +0,000023]  ? submit_extent_page+0xd8/0x200 [btrfs]
[  +0,000002]  ? finish_wait+0x80/0x80
[  +0,000002]  ? __blk_queue_split+0x403/0x4c0
[  +0,000002]  ? finish_wait+0x80/0x80
[  +0,000005]  md_handle_request+0x119/0x190 [md_mod]
[  +0,000006]  md_make_request+0x8a/0x190 [md_mod]
[  +0,000003]  generic_make_request+0xcf/0x310
[  +0,000026]  ? btrfs_dev_stat_inc_and_print+0x50/0x50 [btrfs]
[  +0,000001]  submit_bio+0x42/0x1c0
[  +0,000025]  btrfs_map_bio+0x1c0/0x380 [btrfs]
[  +0,000022]  btrfs_submit_bio_hook+0x8c/0x170 [btrfs]
[  +0,000024]  submit_one_bio+0x31/0x50 [btrfs]
[  +0,000024]  extent_writepages+0x6b/0xa0 [btrfs]
[  +0,000002]  do_writepages+0x41/0xd0
[  +0,000024]  ? merge_state.part.43+0x3f/0x160 [btrfs]
[  +0,000002]  __filemap_fdatawrite_range+0xcb/0x100
[  +0,000023]  btrfs_fdatawrite_range+0x1b/0x50 [btrfs]
[  +0,000025]  __btrfs_write_out_cache+0x467/0x4c0 [btrfs]
[  +0,000026]  btrfs_write_out_cache+0x92/0xe0 [btrfs]
[  +0,000023]  btrfs_start_dirty_block_groups+0x270/0x4e0 [btrfs]
[  +0,000023]  btrfs_commit_transaction+0xc5/0xa40 [btrfs]
[  +0,000020]  ? btrfs_record_root_in_trans+0x56/0x60 [btrfs]
[  +0,000021]  ? start_transaction+0xbc/0x4d0 [btrfs]
[  +0,000024]  btrfs_mksubvol+0x4f0/0x530 [btrfs]
[  +0,000026]  btrfs_ioctl_snap_create_transid+0x170/0x180 [btrfs]
[  +0,000024]  btrfs_ioctl_snap_create_v2+0x11c/0x180 [btrfs]
[  +0,000024]  btrfs_ioctl+0x11c2/0x2de0 [btrfs]
[  +0,000004]  ? tomoyo_path_number_perm+0x68/0x1e0
[  +0,000005]  ? do_vfs_ioctl+0xa4/0x680
[  +0,000001]  do_vfs_ioctl+0xa4/0x680
[  +0,000003]  ksys_ioctl+0x60/0x90
[  +0,000001]  __x64_sys_ioctl+0x16/0x20
[  +0,000004]  do_syscall_64+0x52/0x170
[  +0,000002]  entry_SYSCALL_64_after_hwframe+0x44/0xa9


--------------AEBF12DB90E8ADA7E54186F2
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg-btrfs-transaction.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg-btrfs-transaction.log"

[  +0,000008] INFO: task btrfs-transacti:949 blocked for more than 120 se=
conds.
[  +0,000032]       Not tainted 5.5.0-0.bpo.2-amd64 #1 Debian 5.5.17-1~bp=
o10+1
[  +0,000033] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[  +0,000035] btrfs-transacti D    0   949      2 0x80004000
[  +0,000002] Call Trace:
[  +0,000003]  ? __schedule+0x2db/0x700
[  +0,000002]  schedule+0x40/0xb0
[  +0,000002]  io_schedule+0x12/0x40
[  +0,000004]  wait_on_page_bit+0x15c/0x230
[  +0,000002]  ? file_fdatawait_range+0x20/0x20
[  +0,000002]  __filemap_fdatawait_range+0x89/0xf0
[  +0,000027]  ? __clear_extent_bit+0x2bd/0x440 [btrfs]
[  +0,000002]  filemap_fdatawait_range+0xe/0x20
[  +0,000022]  __btrfs_wait_marked_extents.isra.20+0xc2/0x100 [btrfs]
[  +0,000022]  btrfs_write_and_wait_transaction.isra.24+0x67/0xd0 [btrfs]=

[  +0,000022]  btrfs_commit_transaction+0x754/0xa40 [btrfs]
[  +0,000022]  ? start_transaction+0xbc/0x4d0 [btrfs]
[  +0,000022]  transaction_kthread+0x144/0x170 [btrfs]
[  +0,000021]  ? btrfs_cleanup_transaction+0x5e0/0x5e0 [btrfs]
[  +0,000002]  kthread+0x112/0x130
[  +0,000001]  ? kthread_park+0x80/0x80
[  +0,000002]  ret_from_fork+0x22/0x40



--------------AEBF12DB90E8ADA7E54186F2
Content-Type: text/x-log; charset=UTF-8;
 name="dmesg-md1_reclaim.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="dmesg-md1_reclaim.log"

[=C4=8Den 1 13:05] INFO: task md1_reclaim:910 blocked for more than 120 s=
econds.
[  +0,000057]       Not tainted 5.5.0-0.bpo.2-amd64 #1 Debian 5.5.17-1~bp=
o10+1
[  +0,000033] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[  +0,000035] md1_reclaim     D    0   910      2 0x80004000
[  +0,000003] Call Trace:
[  +0,000012]  ? __schedule+0x2db/0x700
[  +0,000004]  ? check_preempt_curr+0x62/0x90
[  +0,000004]  ? wbt_exit+0x30/0x30
[  +0,000001]  ? __wbt_done+0x30/0x30
[  +0,000002]  schedule+0x40/0xb0
[  +0,000002]  io_schedule+0x12/0x40
[  +0,000003]  rq_qos_wait+0xfa/0x170
[  +0,000002]  ? karma_partition+0x210/0x210
[  +0,000002]  ? wbt_exit+0x30/0x30
[  +0,000001]  wbt_wait+0x99/0xe0
[  +0,000002]  __rq_qos_throttle+0x23/0x30
[  +0,000004]  blk_mq_make_request+0x12a/0x5d0
[  +0,000003]  generic_make_request+0xcf/0x310
[  +0,000002]  submit_bio+0x42/0x1c0
[  +0,000010]  ? md_super_write.part.70+0x98/0x120 [md_mod]
[  +0,000007]  md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
[  +0,000008]  r5l_do_reclaim+0x32a/0x3b0 [raid456]
[  +0,000003]  ? schedule_timeout+0x161/0x310
[  +0,000002]  ? prepare_to_wait_event+0xb6/0x140
[  +0,000006]  ? md_register_thread+0xd0/0xd0 [md_mod]
[  +0,000004]  md_thread+0x94/0x150 [md_mod]
[  +0,000002]  ? finish_wait+0x80/0x80
[  +0,000003]  kthread+0x112/0x130
[  +0,000002]  ? kthread_park+0x80/0x80
[  +0,000002]  ret_from_fork+0x22/0x40



--------------AEBF12DB90E8ADA7E54186F2--
