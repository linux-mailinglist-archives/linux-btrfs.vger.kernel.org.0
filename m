Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19C4128C89
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2019 05:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLVEHs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Dec 2019 23:07:48 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:32925 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfLVEHs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Dec 2019 23:07:48 -0500
Received: by mail-wr1-f41.google.com with SMTP id b6so13284261wrq.0
        for <linux-btrfs@vger.kernel.org>; Sat, 21 Dec 2019 20:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=Kfoi5JytdQryCQ0rNQeMgvYlUhcalEs0U71Jr2sxfDM=;
        b=XU4FKT0WfZhR4I8vLFc7c0H6XB+eIDUJdUjZUEtM/ZpVF1PW9JPQh8u0RQNJmAwqCn
         fY21DTJvYFAj0CN3A/Et5kaMdX2SBrphvLnItQk82sqYGhQr8iLV0BAgUDWlCGXvxQ5d
         woTLpCV1T7xFEDda+tPxv7tOukqTRXZROSXtxoUu5sle2SzDev0jZLO2v4a6oDdKcS2I
         4SWPou6wHp/rvmSwjf03caeu0yVn+mYMSgghksjLUBAGD+gVVohOR1ocnyzQwdVpaGEY
         DXpVoWbOX3yErGgSoJm5S5KufyYRi6mlKJIt2gZiEHHUiprx1daNoSXiyOTruFqj7Kdf
         fzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Kfoi5JytdQryCQ0rNQeMgvYlUhcalEs0U71Jr2sxfDM=;
        b=kK6ifzDQXvJIW1gh/HXA3A1k9DGPNJuXDsfqN2F1JJzYAz1+dTVDWYUF9vPs03Mi6x
         56BexD/Vt41nUKExYl/jDwttt3Ve3k49ISOoeuYRv3V63KNyeadWlgDfA0OrbLq0st2P
         WkNdtH2clBczQk7MpWMs/mr17vcEUx6pEHLX5vk0qx8ETHi3oJwNe55GTRqt5g2f2p3A
         z9UyEOGD5Pe5T99+ou6zTRxAm+IsAoYx4j1XvmQknib1t1GtipZyl4dxiokpRvAhqlym
         /CJVKdXAWeyAv1qwbbMTgsUlNCXRPCb2lrA+zUmTj/mGHdBo7JStjNEWYplXPkR93Ffe
         N+MQ==
X-Gm-Message-State: APjAAAUXnV4OqZIWuLeF4iVUh7xhQVbAY+OXDRyRPYON6EKRtnIGUomM
        YhMGbEZgDG76nkuqk/4szr8jR0ipagsjd/8c6awnEgJIY2MKIA==
X-Google-Smtp-Source: APXvYqxYohrtFKRbgbECzO8Z5ErX6LXdUfdOYO82HMhRF3SKU7phPd+TuTAmgYNMgw+bl6Ou1phMBwCF9U9Da9euYFA=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr23179764wrp.167.1576987663058;
 Sat, 21 Dec 2019 20:07:43 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 21 Dec 2019 21:07:27 -0700
Message-ID: <CAJCQCtTfewPYKTqLEVJzCPw4rkLNx2w58EURWK5TJm8qFHrsQQ@mail.gmail.com>
Subject: 5.5.0rc2 circular lock warning while scrubbing
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000078f377059a430d62"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--00000000000078f377059a430d62
Content-Type: text/plain; charset="UTF-8"

5.5.0-0.rc2.git2.1.fc32.x86_64
btrfs-progs-5.4-1.fc31.x86_64

/dev/nvme0n1p7 on / type btrfs
(rw,noatime,seclabel,ssd,space_cache=v2,subvolid=274,subvol=/root)

Workload at the time of this call trace: fstrim + btrfs scrub (yeah
that's asking for trouble, but related to the slow fstrim thread).

Attaching the same dmesg snippet below as a txt file.

[ 3198.185485] hp_wmi: Unknown event_id - 131073 - 0x0

[ 3917.096295] ======================================================
[ 3917.096296] WARNING: possible circular locking dependency detected
[ 3917.096299] 5.5.0-0.rc2.git2.1.fc32.x86_64 #1 Not tainted
[ 3917.096300] ------------------------------------------------------
[ 3917.096301] btrfs/5199 is trying to acquire lock:
[ 3917.096303] ffffffffb5653e50 (cpu_hotplug_lock.rw_sem){++++}, at:
alloc_workqueue+0x3a2/0x480
[ 3917.096309]
               but task is already holding lock:
[ 3917.096310] ffff89832ad56120 (&fs_info->scrub_lock){+.+.}, at:
btrfs_scrub_dev+0xf6/0x650 [btrfs]
[ 3917.096339]
               which lock already depends on the new lock.

[ 3917.096340]
               the existing dependency chain (in reverse order) is:
[ 3917.096342]
               -> #8 (&fs_info->scrub_lock){+.+.}:
[ 3917.096346]        __mutex_lock+0xac/0x9e0
[ 3917.096366]        btrfs_scrub_dev+0xf6/0x650 [btrfs]
[ 3917.096386]        btrfs_ioctl+0x72a/0x2cb0 [btrfs]
[ 3917.096389]        do_vfs_ioctl+0x580/0x7b0
[ 3917.096391]        ksys_ioctl+0x5e/0x90
[ 3917.096393]        __x64_sys_ioctl+0x16/0x20
[ 3917.096396]        do_syscall_64+0x5c/0xa0
[ 3917.096398]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096399]
               -> #7 (&fs_devs->device_list_mutex){+.+.}:
[ 3917.096402]        __mutex_lock+0xac/0x9e0
[ 3917.096421]        btrfs_run_dev_stats+0x46/0x4a0 [btrfs]
[ 3917.096437]        commit_cowonly_roots+0xb5/0x300 [btrfs]
[ 3917.096452]        btrfs_commit_transaction+0x506/0xad0 [btrfs]
[ 3917.096481]        btrfs_sync_file+0x355/0x490 [btrfs]
[ 3917.096483]        do_fsync+0x38/0x70
[ 3917.096484]        __x64_sys_fsync+0x10/0x20
[ 3917.096486]        do_syscall_64+0x5c/0xa0
[ 3917.096488]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096489]
               -> #6 (&fs_info->tree_log_mutex){+.+.}:
[ 3917.096491]        __mutex_lock+0xac/0x9e0
[ 3917.096514]        btrfs_commit_transaction+0x4ae/0xad0 [btrfs]
[ 3917.096526]        btrfs_sync_file+0x355/0x490 [btrfs]
[ 3917.096527]        do_fsync+0x38/0x70
[ 3917.096528]        __x64_sys_fsync+0x10/0x20
[ 3917.096530]        do_syscall_64+0x5c/0xa0
[ 3917.096532]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096532]
               -> #5 (&fs_info->reloc_mutex){+.+.}:
[ 3917.096534]        __mutex_lock+0xac/0x9e0
[ 3917.096545]        btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[ 3917.096555]        start_transaction+0xbb/0x540 [btrfs]
[ 3917.096565]        btrfs_dirty_inode+0x44/0xd0 [btrfs]
[ 3917.096566]        file_update_time+0xeb/0x140
[ 3917.096577]        btrfs_page_mkwrite+0xfe/0x560 [btrfs]
[ 3917.096579]        do_page_mkwrite+0x4f/0x130
[ 3917.096581]        do_wp_page+0x2a0/0x3e0
[ 3917.096582]        __handle_mm_fault+0xc6c/0x15a0
[ 3917.096584]        handle_mm_fault+0x169/0x360
[ 3917.096586]        do_user_addr_fault+0x1fc/0x480
[ 3917.096587]        do_page_fault+0x31/0x210
[ 3917.096588]        page_fault+0x43/0x50
[ 3917.096589]
               -> #4 (sb_pagefaults){.+.+}:
[ 3917.096591]        __sb_start_write+0x149/0x230
[ 3917.096602]        btrfs_page_mkwrite+0x69/0x560 [btrfs]
[ 3917.096603]        do_page_mkwrite+0x4f/0x130
[ 3917.096605]        do_wp_page+0x2a0/0x3e0
[ 3917.096606]        __handle_mm_fault+0xc6c/0x15a0
[ 3917.096608]        handle_mm_fault+0x169/0x360
[ 3917.096609]        do_user_addr_fault+0x1fc/0x480
[ 3917.096610]        do_page_fault+0x31/0x210
[ 3917.096611]        page_fault+0x43/0x50
[ 3917.096612]
               -> #3 (&mm->mmap_sem#2){++++}:
[ 3917.096615]        __might_fault+0x60/0x80
[ 3917.096617]        _copy_to_user+0x1e/0x90
[ 3917.096619]        relay_file_read+0xb0/0x2e0
[ 3917.096621]        full_proxy_read+0x56/0x80
[ 3917.096623]        vfs_read+0xc5/0x180
[ 3917.096625]        ksys_read+0x68/0xe0
[ 3917.096626]        do_syscall_64+0x5c/0xa0
[ 3917.096628]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096629]
               -> #2 (&sb->s_type->i_mutex_key#3){++++}:
[ 3917.096632]        down_write+0x45/0x120
[ 3917.096635]        start_creating+0x5c/0xf0
[ 3917.096637]        __debugfs_create_file+0x3f/0x120
[ 3917.096639]        relay_create_buf_file+0x6d/0xa0
[ 3917.096641]        relay_open_buf.part.0+0x2a7/0x360
[ 3917.096644]        relay_open+0x191/0x2d0
[ 3917.096646]        do_blk_trace_setup+0x14f/0x2b0
[ 3917.096647]        __blk_trace_setup+0x54/0xb0
[ 3917.096649]        blk_trace_ioctl+0x92/0x140
[ 3917.096651]        blkdev_ioctl+0x131/0xb70
[ 3917.096653]        block_ioctl+0x3f/0x50
[ 3917.096655]        do_vfs_ioctl+0x580/0x7b0
[ 3917.096657]        ksys_ioctl+0x5e/0x90
[ 3917.096659]        __x64_sys_ioctl+0x16/0x20
[ 3917.096661]        do_syscall_64+0x5c/0xa0
[ 3917.096663]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096664]
               -> #1 (relay_channels_mutex){+.+.}:
[ 3917.096667]        __mutex_lock+0xac/0x9e0
[ 3917.096669]        relay_prepare_cpu+0x19/0xae
[ 3917.096671]        cpuhp_invoke_callback+0xb3/0x900
[ 3917.096673]        _cpu_up+0xa1/0x130
[ 3917.096675]        do_cpu_up+0x80/0xc0
[ 3917.096678]        smp_init+0x58/0xae
[ 3917.096681]        kernel_init_freeable+0x16a/0x27d
[ 3917.096683]        kernel_init+0xa/0x10b
[ 3917.096685]        ret_from_fork+0x3a/0x50
[ 3917.096687]
               -> #0 (cpu_hotplug_lock.rw_sem){++++}:
[ 3917.096691]        __lock_acquire+0xe13/0x1a30
[ 3917.096693]        lock_acquire+0xa2/0x1b0
[ 3917.096695]        cpus_read_lock+0x3e/0xb0
[ 3917.096698]        alloc_workqueue+0x3a2/0x480
[ 3917.096719]        __btrfs_alloc_workqueue+0x160/0x210 [btrfs]
[ 3917.096732]        btrfs_alloc_workqueue+0x53/0x170 [btrfs]
[ 3917.096760]        scrub_workers_get+0x5a/0x180 [btrfs]
[ 3917.096773]        btrfs_scrub_dev+0x1e5/0x650 [btrfs]
[ 3917.096800]        btrfs_ioctl+0x72a/0x2cb0 [btrfs]
[ 3917.096801]        do_vfs_ioctl+0x580/0x7b0
[ 3917.096803]        ksys_ioctl+0x5e/0x90
[ 3917.096804]        __x64_sys_ioctl+0x16/0x20
[ 3917.096806]        do_syscall_64+0x5c/0xa0
[ 3917.096807]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.096808]
               other info that might help us debug this:

[ 3917.096809] Chain exists of:
                 cpu_hotplug_lock.rw_sem -->
&fs_devs->device_list_mutex --> &fs_info->scrub_lock

[ 3917.096811]  Possible unsafe locking scenario:

[ 3917.096812]        CPU0                    CPU1
[ 3917.096812]        ----                    ----
[ 3917.096813]   lock(&fs_info->scrub_lock);
[ 3917.096814]                                lock(&fs_devs->device_list_mutex);
[ 3917.096815]                                lock(&fs_info->scrub_lock);
[ 3917.096816]   lock(cpu_hotplug_lock.rw_sem);
[ 3917.096817]
                *** DEADLOCK ***

[ 3917.096818] 3 locks held by btrfs/5199:
[ 3917.096819]  #0: ffff89832cb59498 (sb_writers#13){.+.+}, at:
mnt_want_write_file+0x22/0x60
[ 3917.096822]  #1: ffff89832bf7cee8
(&fs_devs->device_list_mutex){+.+.}, at: btrfs_scrub_dev+0x98/0x650
[btrfs]
[ 3917.096837]  #2: ffff89832ad56120 (&fs_info->scrub_lock){+.+.}, at:
btrfs_scrub_dev+0xf6/0x650 [btrfs]
[ 3917.096851]
               stack backtrace:
[ 3917.096854] CPU: 2 PID: 5199 Comm: btrfs Not tainted
5.5.0-0.rc2.git2.1.fc32.x86_64 #1
[ 3917.096855] Hardware name: HP HP Spectre Notebook/81A0, BIOS F.43 04/16/2019
[ 3917.096855] Call Trace:
[ 3917.096858]  dump_stack+0x8f/0xd0
[ 3917.096860]  check_noncircular+0x176/0x190
[ 3917.096863]  __lock_acquire+0xe13/0x1a30
[ 3917.096866]  lock_acquire+0xa2/0x1b0
[ 3917.096868]  ? alloc_workqueue+0x3a2/0x480
[ 3917.096870]  cpus_read_lock+0x3e/0xb0
[ 3917.096871]  ? alloc_workqueue+0x3a2/0x480
[ 3917.096873]  alloc_workqueue+0x3a2/0x480
[ 3917.096875]  ? rcu_read_lock_sched_held+0x52/0x90
[ 3917.096891]  __btrfs_alloc_workqueue+0x160/0x210 [btrfs]
[ 3917.096905]  btrfs_alloc_workqueue+0x53/0x170 [btrfs]
[ 3917.096920]  scrub_workers_get+0x5a/0x180 [btrfs]
[ 3917.096934]  btrfs_scrub_dev+0x1e5/0x650 [btrfs]
[ 3917.096938]  ? rcu_read_lock_any_held+0x83/0xb0
[ 3917.096939]  ? __sb_start_write+0x18f/0x230
[ 3917.096955]  btrfs_ioctl+0x72a/0x2cb0 [btrfs]
[ 3917.096959]  ? __lock_acquire+0x24d/0x1a30
[ 3917.096963]  ? do_vfs_ioctl+0x580/0x7b0
[ 3917.096986]  ? btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
[ 3917.096989]  do_vfs_ioctl+0x580/0x7b0
[ 3917.096994]  ksys_ioctl+0x5e/0x90
[ 3917.096996]  __x64_sys_ioctl+0x16/0x20
[ 3917.096998]  do_syscall_64+0x5c/0xa0
[ 3917.097001]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3917.097004] RIP: 0033:0x7fd57e33834b
[ 3917.097006] Code: 0f 1e fa 48 8b 05 3d 9b 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d 9b 0c 00 f7 d8 64 89
01 48
[ 3917.097008] RSP: 002b:00007fd57e23bd38 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[ 3917.097011] RAX: ffffffffffffffda RBX: 000055f345aa5420 RCX: 00007fd57e33834b
[ 3917.097012] RDX: 000055f345aa5420 RSI: 00000000c400941b RDI: 0000000000000003
[ 3917.097013] RBP: 0000000000000000 R08: 00007fd57e23c700 R09: 0000000000000000
[ 3917.097015] R10: 00007fd57e23c700 R11: 0000000000000246 R12: 00007ffe04f3614e
[ 3917.097017] R13: 00007ffe04f3614f R14: 00007ffe04f36150 R15: 00007fd57e23be40
[ 3917.097097] BTRFS info (device nvme0n1p7): scrub: started on devid 1
[ 3941.514878] BTRFS info (device nvme0n1p7): scrub: finished on devid
1 with status: 0
[chris@flap ~]$






-- 
Chris Murphy

--00000000000078f377059a430d62
Content-Type: text/plain; charset="US-ASCII"; name="5.5.0-rc2 circular lock scrub.txt"
Content-Disposition: attachment; 
	filename="5.5.0-rc2 circular lock scrub.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_k4ghmtce0>
X-Attachment-Id: f_k4ghmtce0

WyAzMTk4LjE4NTQ4NV0gaHBfd21pOiBVbmtub3duIGV2ZW50X2lkIC0gMTMxMDczIC0gMHgwCgpb
IDM5MTcuMDk2Mjk1XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KWyAzOTE3LjA5NjI5Nl0gV0FSTklORzogcG9zc2libGUgY2lyY3VsYXIgbG9j
a2luZyBkZXBlbmRlbmN5IGRldGVjdGVkClsgMzkxNy4wOTYyOTldIDUuNS4wLTAucmMyLmdpdDIu
MS5mYzMyLng4Nl82NCAjMSBOb3QgdGFpbnRlZApbIDM5MTcuMDk2MzAwXSAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KWyAzOTE3LjA5NjMwMV0g
YnRyZnMvNTE5OSBpcyB0cnlpbmcgdG8gYWNxdWlyZSBsb2NrOgpbIDM5MTcuMDk2MzAzXSBmZmZm
ZmZmZmI1NjUzZTUwIChjcHVfaG90cGx1Z19sb2NrLnJ3X3NlbSl7KysrK30sIGF0OiBhbGxvY193
b3JrcXVldWUrMHgzYTIvMHg0ODAKWyAzOTE3LjA5NjMwOV0gCiAgICAgICAgICAgICAgIGJ1dCB0
YXNrIGlzIGFscmVhZHkgaG9sZGluZyBsb2NrOgpbIDM5MTcuMDk2MzEwXSBmZmZmODk4MzJhZDU2
MTIwICgmZnNfaW5mby0+c2NydWJfbG9jayl7Ky4rLn0sIGF0OiBidHJmc19zY3J1Yl9kZXYrMHhm
Ni8weDY1MCBbYnRyZnNdClsgMzkxNy4wOTYzMzldIAogICAgICAgICAgICAgICB3aGljaCBsb2Nr
IGFscmVhZHkgZGVwZW5kcyBvbiB0aGUgbmV3IGxvY2suCgpbIDM5MTcuMDk2MzQwXSAKICAgICAg
ICAgICAgICAgdGhlIGV4aXN0aW5nIGRlcGVuZGVuY3kgY2hhaW4gKGluIHJldmVyc2Ugb3JkZXIp
IGlzOgpbIDM5MTcuMDk2MzQyXSAKICAgICAgICAgICAgICAgLT4gIzggKCZmc19pbmZvLT5zY3J1
Yl9sb2NrKXsrLisufToKWyAzOTE3LjA5NjM0Nl0gICAgICAgIF9fbXV0ZXhfbG9jaysweGFjLzB4
OWUwClsgMzkxNy4wOTYzNjZdICAgICAgICBidHJmc19zY3J1Yl9kZXYrMHhmNi8weDY1MCBbYnRy
ZnNdClsgMzkxNy4wOTYzODZdICAgICAgICBidHJmc19pb2N0bCsweDcyYS8weDJjYjAgW2J0cmZz
XQpbIDM5MTcuMDk2Mzg5XSAgICAgICAgZG9fdmZzX2lvY3RsKzB4NTgwLzB4N2IwClsgMzkxNy4w
OTYzOTFdICAgICAgICBrc3lzX2lvY3RsKzB4NWUvMHg5MApbIDM5MTcuMDk2MzkzXSAgICAgICAg
X194NjRfc3lzX2lvY3RsKzB4MTYvMHgyMApbIDM5MTcuMDk2Mzk2XSAgICAgICAgZG9fc3lzY2Fs
bF82NCsweDVjLzB4YTAKWyAzOTE3LjA5NjM5OF0gICAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0
ZXJfaHdmcmFtZSsweDQ5LzB4YmUKWyAzOTE3LjA5NjM5OV0gCiAgICAgICAgICAgICAgIC0+ICM3
ICgmZnNfZGV2cy0+ZGV2aWNlX2xpc3RfbXV0ZXgpeysuKy59OgpbIDM5MTcuMDk2NDAyXSAgICAg
ICAgX19tdXRleF9sb2NrKzB4YWMvMHg5ZTAKWyAzOTE3LjA5NjQyMV0gICAgICAgIGJ0cmZzX3J1
bl9kZXZfc3RhdHMrMHg0Ni8weDRhMCBbYnRyZnNdClsgMzkxNy4wOTY0MzddICAgICAgICBjb21t
aXRfY293b25seV9yb290cysweGI1LzB4MzAwIFtidHJmc10KWyAzOTE3LjA5NjQ1Ml0gICAgICAg
IGJ0cmZzX2NvbW1pdF90cmFuc2FjdGlvbisweDUwNi8weGFkMCBbYnRyZnNdClsgMzkxNy4wOTY0
ODFdICAgICAgICBidHJmc19zeW5jX2ZpbGUrMHgzNTUvMHg0OTAgW2J0cmZzXQpbIDM5MTcuMDk2
NDgzXSAgICAgICAgZG9fZnN5bmMrMHgzOC8weDcwClsgMzkxNy4wOTY0ODRdICAgICAgICBfX3g2
NF9zeXNfZnN5bmMrMHgxMC8weDIwClsgMzkxNy4wOTY0ODZdICAgICAgICBkb19zeXNjYWxsXzY0
KzB4NWMvMHhhMApbIDM5MTcuMDk2NDg4XSAgICAgICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NDkvMHhiZQpbIDM5MTcuMDk2NDg5XSAKICAgICAgICAgICAgICAgLT4gIzYgKCZm
c19pbmZvLT50cmVlX2xvZ19tdXRleCl7Ky4rLn06ClsgMzkxNy4wOTY0OTFdICAgICAgICBfX211
dGV4X2xvY2srMHhhYy8weDllMApbIDM5MTcuMDk2NTE0XSAgICAgICAgYnRyZnNfY29tbWl0X3Ry
YW5zYWN0aW9uKzB4NGFlLzB4YWQwIFtidHJmc10KWyAzOTE3LjA5NjUyNl0gICAgICAgIGJ0cmZz
X3N5bmNfZmlsZSsweDM1NS8weDQ5MCBbYnRyZnNdClsgMzkxNy4wOTY1MjddICAgICAgICBkb19m
c3luYysweDM4LzB4NzAKWyAzOTE3LjA5NjUyOF0gICAgICAgIF9feDY0X3N5c19mc3luYysweDEw
LzB4MjAKWyAzOTE3LjA5NjUzMF0gICAgICAgIGRvX3N5c2NhbGxfNjQrMHg1Yy8weGEwClsgMzkx
Ny4wOTY1MzJdICAgICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0OS8weGJl
ClsgMzkxNy4wOTY1MzJdIAogICAgICAgICAgICAgICAtPiAjNSAoJmZzX2luZm8tPnJlbG9jX211
dGV4KXsrLisufToKWyAzOTE3LjA5NjUzNF0gICAgICAgIF9fbXV0ZXhfbG9jaysweGFjLzB4OWUw
ClsgMzkxNy4wOTY1NDVdICAgICAgICBidHJmc19yZWNvcmRfcm9vdF9pbl90cmFucysweDQ0LzB4
NzAgW2J0cmZzXQpbIDM5MTcuMDk2NTU1XSAgICAgICAgc3RhcnRfdHJhbnNhY3Rpb24rMHhiYi8w
eDU0MCBbYnRyZnNdClsgMzkxNy4wOTY1NjVdICAgICAgICBidHJmc19kaXJ0eV9pbm9kZSsweDQ0
LzB4ZDAgW2J0cmZzXQpbIDM5MTcuMDk2NTY2XSAgICAgICAgZmlsZV91cGRhdGVfdGltZSsweGVi
LzB4MTQwClsgMzkxNy4wOTY1NzddICAgICAgICBidHJmc19wYWdlX21rd3JpdGUrMHhmZS8weDU2
MCBbYnRyZnNdClsgMzkxNy4wOTY1NzldICAgICAgICBkb19wYWdlX21rd3JpdGUrMHg0Zi8weDEz
MApbIDM5MTcuMDk2NTgxXSAgICAgICAgZG9fd3BfcGFnZSsweDJhMC8weDNlMApbIDM5MTcuMDk2
NTgyXSAgICAgICAgX19oYW5kbGVfbW1fZmF1bHQrMHhjNmMvMHgxNWEwClsgMzkxNy4wOTY1ODRd
ICAgICAgICBoYW5kbGVfbW1fZmF1bHQrMHgxNjkvMHgzNjAKWyAzOTE3LjA5NjU4Nl0gICAgICAg
IGRvX3VzZXJfYWRkcl9mYXVsdCsweDFmYy8weDQ4MApbIDM5MTcuMDk2NTg3XSAgICAgICAgZG9f
cGFnZV9mYXVsdCsweDMxLzB4MjEwClsgMzkxNy4wOTY1ODhdICAgICAgICBwYWdlX2ZhdWx0KzB4
NDMvMHg1MApbIDM5MTcuMDk2NTg5XSAKICAgICAgICAgICAgICAgLT4gIzQgKHNiX3BhZ2VmYXVs
dHMpey4rLit9OgpbIDM5MTcuMDk2NTkxXSAgICAgICAgX19zYl9zdGFydF93cml0ZSsweDE0OS8w
eDIzMApbIDM5MTcuMDk2NjAyXSAgICAgICAgYnRyZnNfcGFnZV9ta3dyaXRlKzB4NjkvMHg1NjAg
W2J0cmZzXQpbIDM5MTcuMDk2NjAzXSAgICAgICAgZG9fcGFnZV9ta3dyaXRlKzB4NGYvMHgxMzAK
WyAzOTE3LjA5NjYwNV0gICAgICAgIGRvX3dwX3BhZ2UrMHgyYTAvMHgzZTAKWyAzOTE3LjA5NjYw
Nl0gICAgICAgIF9faGFuZGxlX21tX2ZhdWx0KzB4YzZjLzB4MTVhMApbIDM5MTcuMDk2NjA4XSAg
ICAgICAgaGFuZGxlX21tX2ZhdWx0KzB4MTY5LzB4MzYwClsgMzkxNy4wOTY2MDldICAgICAgICBk
b191c2VyX2FkZHJfZmF1bHQrMHgxZmMvMHg0ODAKWyAzOTE3LjA5NjYxMF0gICAgICAgIGRvX3Bh
Z2VfZmF1bHQrMHgzMS8weDIxMApbIDM5MTcuMDk2NjExXSAgICAgICAgcGFnZV9mYXVsdCsweDQz
LzB4NTAKWyAzOTE3LjA5NjYxMl0gCiAgICAgICAgICAgICAgIC0+ICMzICgmbW0tPm1tYXBfc2Vt
IzIpeysrKyt9OgpbIDM5MTcuMDk2NjE1XSAgICAgICAgX19taWdodF9mYXVsdCsweDYwLzB4ODAK
WyAzOTE3LjA5NjYxN10gICAgICAgIF9jb3B5X3RvX3VzZXIrMHgxZS8weDkwClsgMzkxNy4wOTY2
MTldICAgICAgICByZWxheV9maWxlX3JlYWQrMHhiMC8weDJlMApbIDM5MTcuMDk2NjIxXSAgICAg
ICAgZnVsbF9wcm94eV9yZWFkKzB4NTYvMHg4MApbIDM5MTcuMDk2NjIzXSAgICAgICAgdmZzX3Jl
YWQrMHhjNS8weDE4MApbIDM5MTcuMDk2NjI1XSAgICAgICAga3N5c19yZWFkKzB4NjgvMHhlMApb
IDM5MTcuMDk2NjI2XSAgICAgICAgZG9fc3lzY2FsbF82NCsweDVjLzB4YTAKWyAzOTE3LjA5NjYy
OF0gICAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ5LzB4YmUKWyAzOTE3
LjA5NjYyOV0gCiAgICAgICAgICAgICAgIC0+ICMyICgmc2ItPnNfdHlwZS0+aV9tdXRleF9rZXkj
Myl7KysrK306ClsgMzkxNy4wOTY2MzJdICAgICAgICBkb3duX3dyaXRlKzB4NDUvMHgxMjAKWyAz
OTE3LjA5NjYzNV0gICAgICAgIHN0YXJ0X2NyZWF0aW5nKzB4NWMvMHhmMApbIDM5MTcuMDk2NjM3
XSAgICAgICAgX19kZWJ1Z2ZzX2NyZWF0ZV9maWxlKzB4M2YvMHgxMjAKWyAzOTE3LjA5NjYzOV0g
ICAgICAgIHJlbGF5X2NyZWF0ZV9idWZfZmlsZSsweDZkLzB4YTAKWyAzOTE3LjA5NjY0MV0gICAg
ICAgIHJlbGF5X29wZW5fYnVmLnBhcnQuMCsweDJhNy8weDM2MApbIDM5MTcuMDk2NjQ0XSAgICAg
ICAgcmVsYXlfb3BlbisweDE5MS8weDJkMApbIDM5MTcuMDk2NjQ2XSAgICAgICAgZG9fYmxrX3Ry
YWNlX3NldHVwKzB4MTRmLzB4MmIwClsgMzkxNy4wOTY2NDddICAgICAgICBfX2Jsa190cmFjZV9z
ZXR1cCsweDU0LzB4YjAKWyAzOTE3LjA5NjY0OV0gICAgICAgIGJsa190cmFjZV9pb2N0bCsweDky
LzB4MTQwClsgMzkxNy4wOTY2NTFdICAgICAgICBibGtkZXZfaW9jdGwrMHgxMzEvMHhiNzAKWyAz
OTE3LjA5NjY1M10gICAgICAgIGJsb2NrX2lvY3RsKzB4M2YvMHg1MApbIDM5MTcuMDk2NjU1XSAg
ICAgICAgZG9fdmZzX2lvY3RsKzB4NTgwLzB4N2IwClsgMzkxNy4wOTY2NTddICAgICAgICBrc3lz
X2lvY3RsKzB4NWUvMHg5MApbIDM5MTcuMDk2NjU5XSAgICAgICAgX194NjRfc3lzX2lvY3RsKzB4
MTYvMHgyMApbIDM5MTcuMDk2NjYxXSAgICAgICAgZG9fc3lzY2FsbF82NCsweDVjLzB4YTAKWyAz
OTE3LjA5NjY2M10gICAgICAgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDQ5LzB4
YmUKWyAzOTE3LjA5NjY2NF0gCiAgICAgICAgICAgICAgIC0+ICMxIChyZWxheV9jaGFubmVsc19t
dXRleCl7Ky4rLn06ClsgMzkxNy4wOTY2NjddICAgICAgICBfX211dGV4X2xvY2srMHhhYy8weDll
MApbIDM5MTcuMDk2NjY5XSAgICAgICAgcmVsYXlfcHJlcGFyZV9jcHUrMHgxOS8weGFlClsgMzkx
Ny4wOTY2NzFdICAgICAgICBjcHVocF9pbnZva2VfY2FsbGJhY2srMHhiMy8weDkwMApbIDM5MTcu
MDk2NjczXSAgICAgICAgX2NwdV91cCsweGExLzB4MTMwClsgMzkxNy4wOTY2NzVdICAgICAgICBk
b19jcHVfdXArMHg4MC8weGMwClsgMzkxNy4wOTY2NzhdICAgICAgICBzbXBfaW5pdCsweDU4LzB4
YWUKWyAzOTE3LjA5NjY4MV0gICAgICAgIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MTZhLzB4Mjdk
ClsgMzkxNy4wOTY2ODNdICAgICAgICBrZXJuZWxfaW5pdCsweGEvMHgxMGIKWyAzOTE3LjA5NjY4
NV0gICAgICAgIHJldF9mcm9tX2ZvcmsrMHgzYS8weDUwClsgMzkxNy4wOTY2ODddIAogICAgICAg
ICAgICAgICAtPiAjMCAoY3B1X2hvdHBsdWdfbG9jay5yd19zZW0peysrKyt9OgpbIDM5MTcuMDk2
NjkxXSAgICAgICAgX19sb2NrX2FjcXVpcmUrMHhlMTMvMHgxYTMwClsgMzkxNy4wOTY2OTNdICAg
ICAgICBsb2NrX2FjcXVpcmUrMHhhMi8weDFiMApbIDM5MTcuMDk2Njk1XSAgICAgICAgY3B1c19y
ZWFkX2xvY2srMHgzZS8weGIwClsgMzkxNy4wOTY2OThdICAgICAgICBhbGxvY193b3JrcXVldWUr
MHgzYTIvMHg0ODAKWyAzOTE3LjA5NjcxOV0gICAgICAgIF9fYnRyZnNfYWxsb2Nfd29ya3F1ZXVl
KzB4MTYwLzB4MjEwIFtidHJmc10KWyAzOTE3LjA5NjczMl0gICAgICAgIGJ0cmZzX2FsbG9jX3dv
cmtxdWV1ZSsweDUzLzB4MTcwIFtidHJmc10KWyAzOTE3LjA5Njc2MF0gICAgICAgIHNjcnViX3dv
cmtlcnNfZ2V0KzB4NWEvMHgxODAgW2J0cmZzXQpbIDM5MTcuMDk2NzczXSAgICAgICAgYnRyZnNf
c2NydWJfZGV2KzB4MWU1LzB4NjUwIFtidHJmc10KWyAzOTE3LjA5NjgwMF0gICAgICAgIGJ0cmZz
X2lvY3RsKzB4NzJhLzB4MmNiMCBbYnRyZnNdClsgMzkxNy4wOTY4MDFdICAgICAgICBkb192ZnNf
aW9jdGwrMHg1ODAvMHg3YjAKWyAzOTE3LjA5NjgwM10gICAgICAgIGtzeXNfaW9jdGwrMHg1ZS8w
eDkwClsgMzkxNy4wOTY4MDRdICAgICAgICBfX3g2NF9zeXNfaW9jdGwrMHgxNi8weDIwClsgMzkx
Ny4wOTY4MDZdICAgICAgICBkb19zeXNjYWxsXzY0KzB4NWMvMHhhMApbIDM5MTcuMDk2ODA3XSAg
ICAgICAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQpbIDM5MTcuMDk2
ODA4XSAKICAgICAgICAgICAgICAgb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcg
dGhpczoKClsgMzkxNy4wOTY4MDldIENoYWluIGV4aXN0cyBvZjoKICAgICAgICAgICAgICAgICBj
cHVfaG90cGx1Z19sb2NrLnJ3X3NlbSAtLT4gJmZzX2RldnMtPmRldmljZV9saXN0X211dGV4IC0t
PiAmZnNfaW5mby0+c2NydWJfbG9jawoKWyAzOTE3LjA5NjgxMV0gIFBvc3NpYmxlIHVuc2FmZSBs
b2NraW5nIHNjZW5hcmlvOgoKWyAzOTE3LjA5NjgxMl0gICAgICAgIENQVTAgICAgICAgICAgICAg
ICAgICAgIENQVTEKWyAzOTE3LjA5NjgxMl0gICAgICAgIC0tLS0gICAgICAgICAgICAgICAgICAg
IC0tLS0KWyAzOTE3LjA5NjgxM10gICBsb2NrKCZmc19pbmZvLT5zY3J1Yl9sb2NrKTsKWyAzOTE3
LjA5NjgxNF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvY2soJmZzX2RldnMtPmRl
dmljZV9saXN0X211dGV4KTsKWyAzOTE3LjA5NjgxNV0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGxvY2soJmZzX2luZm8tPnNjcnViX2xvY2spOwpbIDM5MTcuMDk2ODE2XSAgIGxvY2so
Y3B1X2hvdHBsdWdfbG9jay5yd19zZW0pOwpbIDM5MTcuMDk2ODE3XSAKICAgICAgICAgICAgICAg
ICoqKiBERUFETE9DSyAqKioKClsgMzkxNy4wOTY4MThdIDMgbG9ja3MgaGVsZCBieSBidHJmcy81
MTk5OgpbIDM5MTcuMDk2ODE5XSAgIzA6IGZmZmY4OTgzMmNiNTk0OTggKHNiX3dyaXRlcnMjMTMp
ey4rLit9LCBhdDogbW50X3dhbnRfd3JpdGVfZmlsZSsweDIyLzB4NjAKWyAzOTE3LjA5NjgyMl0g
ICMxOiBmZmZmODk4MzJiZjdjZWU4ICgmZnNfZGV2cy0+ZGV2aWNlX2xpc3RfbXV0ZXgpeysuKy59
LCBhdDogYnRyZnNfc2NydWJfZGV2KzB4OTgvMHg2NTAgW2J0cmZzXQpbIDM5MTcuMDk2ODM3XSAg
IzI6IGZmZmY4OTgzMmFkNTYxMjAgKCZmc19pbmZvLT5zY3J1Yl9sb2NrKXsrLisufSwgYXQ6IGJ0
cmZzX3NjcnViX2RldisweGY2LzB4NjUwIFtidHJmc10KWyAzOTE3LjA5Njg1MV0gCiAgICAgICAg
ICAgICAgIHN0YWNrIGJhY2t0cmFjZToKWyAzOTE3LjA5Njg1NF0gQ1BVOiAyIFBJRDogNTE5OSBD
b21tOiBidHJmcyBOb3QgdGFpbnRlZCA1LjUuMC0wLnJjMi5naXQyLjEuZmMzMi54ODZfNjQgIzEK
WyAzOTE3LjA5Njg1NV0gSGFyZHdhcmUgbmFtZTogSFAgSFAgU3BlY3RyZSBOb3RlYm9vay84MUEw
LCBCSU9TIEYuNDMgMDQvMTYvMjAxOQpbIDM5MTcuMDk2ODU1XSBDYWxsIFRyYWNlOgpbIDM5MTcu
MDk2ODU4XSAgZHVtcF9zdGFjaysweDhmLzB4ZDAKWyAzOTE3LjA5Njg2MF0gIGNoZWNrX25vbmNp
cmN1bGFyKzB4MTc2LzB4MTkwClsgMzkxNy4wOTY4NjNdICBfX2xvY2tfYWNxdWlyZSsweGUxMy8w
eDFhMzAKWyAzOTE3LjA5Njg2Nl0gIGxvY2tfYWNxdWlyZSsweGEyLzB4MWIwClsgMzkxNy4wOTY4
NjhdICA/IGFsbG9jX3dvcmtxdWV1ZSsweDNhMi8weDQ4MApbIDM5MTcuMDk2ODcwXSAgY3B1c19y
ZWFkX2xvY2srMHgzZS8weGIwClsgMzkxNy4wOTY4NzFdICA/IGFsbG9jX3dvcmtxdWV1ZSsweDNh
Mi8weDQ4MApbIDM5MTcuMDk2ODczXSAgYWxsb2Nfd29ya3F1ZXVlKzB4M2EyLzB4NDgwClsgMzkx
Ny4wOTY4NzVdICA/IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDUyLzB4OTAKWyAzOTE3LjA5
Njg5MV0gIF9fYnRyZnNfYWxsb2Nfd29ya3F1ZXVlKzB4MTYwLzB4MjEwIFtidHJmc10KWyAzOTE3
LjA5NjkwNV0gIGJ0cmZzX2FsbG9jX3dvcmtxdWV1ZSsweDUzLzB4MTcwIFtidHJmc10KWyAzOTE3
LjA5NjkyMF0gIHNjcnViX3dvcmtlcnNfZ2V0KzB4NWEvMHgxODAgW2J0cmZzXQpbIDM5MTcuMDk2
OTM0XSAgYnRyZnNfc2NydWJfZGV2KzB4MWU1LzB4NjUwIFtidHJmc10KWyAzOTE3LjA5NjkzOF0g
ID8gcmN1X3JlYWRfbG9ja19hbnlfaGVsZCsweDgzLzB4YjAKWyAzOTE3LjA5NjkzOV0gID8gX19z
Yl9zdGFydF93cml0ZSsweDE4Zi8weDIzMApbIDM5MTcuMDk2OTU1XSAgYnRyZnNfaW9jdGwrMHg3
MmEvMHgyY2IwIFtidHJmc10KWyAzOTE3LjA5Njk1OV0gID8gX19sb2NrX2FjcXVpcmUrMHgyNGQv
MHgxYTMwClsgMzkxNy4wOTY5NjNdICA/IGRvX3Zmc19pb2N0bCsweDU4MC8weDdiMApbIDM5MTcu
MDk2OTg2XSAgPyBidHJmc19pb2N0bF9nZXRfc3VwcG9ydGVkX2ZlYXR1cmVzKzB4MzAvMHgzMCBb
YnRyZnNdClsgMzkxNy4wOTY5ODldICBkb192ZnNfaW9jdGwrMHg1ODAvMHg3YjAKWyAzOTE3LjA5
Njk5NF0gIGtzeXNfaW9jdGwrMHg1ZS8weDkwClsgMzkxNy4wOTY5OTZdICBfX3g2NF9zeXNfaW9j
dGwrMHgxNi8weDIwClsgMzkxNy4wOTY5OThdICBkb19zeXNjYWxsXzY0KzB4NWMvMHhhMApbIDM5
MTcuMDk3MDAxXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDkvMHhiZQpbIDM5
MTcuMDk3MDA0XSBSSVA6IDAwMzM6MHg3ZmQ1N2UzMzgzNGIKWyAzOTE3LjA5NzAwNl0gQ29kZTog
MGYgMWUgZmEgNDggOGIgMDUgM2QgOWIgMGMgMDAgNjQgYzcgMDAgMjYgMDAgMDAgMDAgNDggYzcg
YzAgZmYgZmYgZmYgZmYgYzMgNjYgMGYgMWYgNDQgMDAgMDAgZjMgMGYgMWUgZmEgYjggMTAgMDAg
MDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCAwZCA5YiAw
YyAwMCBmNyBkOCA2NCA4OSAwMSA0OApbIDM5MTcuMDk3MDA4XSBSU1A6IDAwMmI6MDAwMDdmZDU3
ZTIzYmQzOCBFRkxBR1M6IDAwMDAwMjQ2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDEwClsgMzkx
Ny4wOTcwMTFdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA1NWYzNDVhYTU0MjAgUkNY
OiAwMDAwN2ZkNTdlMzM4MzRiClsgMzkxNy4wOTcwMTJdIFJEWDogMDAwMDU1ZjM0NWFhNTQyMCBS
U0k6IDAwMDAwMDAwYzQwMDk0MWIgUkRJOiAwMDAwMDAwMDAwMDAwMDAzClsgMzkxNy4wOTcwMTNd
IFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDA3ZmQ1N2UyM2M3MDAgUjA5OiAwMDAwMDAw
MDAwMDAwMDAwClsgMzkxNy4wOTcwMTVdIFIxMDogMDAwMDdmZDU3ZTIzYzcwMCBSMTE6IDAwMDAw
MDAwMDAwMDAyNDYgUjEyOiAwMDAwN2ZmZTA0ZjM2MTRlClsgMzkxNy4wOTcwMTddIFIxMzogMDAw
MDdmZmUwNGYzNjE0ZiBSMTQ6IDAwMDA3ZmZlMDRmMzYxNTAgUjE1OiAwMDAwN2ZkNTdlMjNiZTQw
ClsgMzkxNy4wOTcwOTddIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4xcDcpOiBzY3J1Yjogc3Rh
cnRlZCBvbiBkZXZpZCAxClsgMzk0MS41MTQ4NzhdIEJUUkZTIGluZm8gKGRldmljZSBudm1lMG4x
cDcpOiBzY3J1YjogZmluaXNoZWQgb24gZGV2aWQgMSB3aXRoIHN0YXR1czogMApbY2hyaXNAZmxh
cCB+XSQgCgoK
--00000000000078f377059a430d62--
