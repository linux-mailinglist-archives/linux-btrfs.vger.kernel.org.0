Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F472130851
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAENjg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 5 Jan 2020 08:39:36 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:39245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAENjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 08:39:36 -0500
Received: from [192.168.177.20] ([91.63.166.112]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MMGAg-1j7Gu84BXy-00JNAD
 for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 14:39:35 +0100
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: Btrfs blocking disk access
Date:   Sun, 05 Jan 2020 13:39:33 +0000
Message-Id: <em802c94d1-16d7-490d-96e4-d46418d29222@ryzen>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/7.2.34062.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:yqsz3DvrMf07oaMqgwafknx8iHp07azI5z/glWb+6LBil13sAup
 +XGiH+8GQJ5lzFkFD6uvjDGdz4FTmVY/6kyt0XsV2z+xFrCdgII2OvTSZ/pGni4itCb4CgH
 rUHouoTr5UMk2WxqHzIGIyTCOox8VvO/2wTcEUjXBjeGWpfex07uPjfZMUq2qwAZFL1CwUz
 XR+W/hEmIOaGKr8433xKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PjegwR44M98=:EnNaFH/V+lKEWEIji2r8a8
 T53pMyPNQdDcqEqAU3J0dVEYEv7jSqSzS2rzpOR4YR8NLB9wqFaT/9YmZyWCA/4PdlYGljhAM
 ZeLSD3zcZALtjs5cE6wjsG5PSDjpqAovRnqT4lMQCZJktRYiseSQKBmgAmT2GHvPnYzphyaoR
 Z9RjIxDQejH86UiiG+0KLK0wlqXobpq5mIYd4ZUtgcBbHfNNDEnwb1oFUcEbIxmFr4qEQzYy5
 M2Qiaum4QWbQ50H0J9Ug//jlKNB6MG2TWlUPJC/sKpW9C51ew1egfLtp9nYzp7CS7KGBogANB
 eLEMcbw3J9Q1XnGm/M22IMRGMrhNGiQHnvYuLrhj9+4oP7joGJGVj/d/WKBi50/Iurnh9Nf1B
 Zk/cy+k26CLWEapUlG1ILW2GAz+c2VkntQ0yEzprzcvfYDXG6HqmHqT4w8Ldn9CEPxxHySTfB
 71Vv3TV57HjY5MCrWnKUgLgBrD5SysV6lLQxuLsN/0pcUQQWuUkYujKsFnM8hs+Vb331fDpl9
 bkpzaNYp/q/TI60ngsi8c9M1zE8hoHxrjgCahDpRzWfa8YXBPZJnAnZI3STejUGiTcjBkHtTP
 E7bG88Kd8qZ4vXTabcRrTSKB8Q+M5/wqFQHxpskt5K97+XtaODD0RdpTeqnV+9eIEKCn1LnYK
 GDqKuk1ZkTTjcs9u/uS4bRpnBLg4KNXHqo54zUio07cOGdqDDRXGu5BpapztXjVFBxMsD7N8s
 OYBBirZ21RxlVd3ElrsP6PwVKQ9UVDTKSMrpTy61eW6zg7sz7litT0Qi1O6PajU97V6kGWYS3
 lgUHRDzxmTq1oGexU3IiOKLmV2/rYz1j+8zZzmyEcfBnK7aLnnCku7E5LUL0CiwxgZOh+9vIi
 dQLxZiUI5nJ9p+CiBmtq7SnvwuUiUeeZ/JqfsQ6NE=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have seen this problem multiple times now in my log (every few days).
A btrfs scrub /drive ran without error.

[So Jan  5 13:49:21 2020] INFO: task dockerd:4076 blocked for more than 
120 seconds.
[So Jan  5 13:49:21 2020]       Tainted: G           OE     5.2.8 #1
[So Jan  5 13:49:21 2020] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
[So Jan  5 13:49:21 2020] dockerd         D    0  4076      1 0x00004000
[So Jan  5 13:49:21 2020] Call Trace:
[So Jan  5 13:49:21 2020]  ? __schedule+0x3e9/0x690
[So Jan  5 13:49:21 2020]  schedule+0x33/0x90
[So Jan  5 13:49:21 2020]  wait_for_commit+0x41/0x80 [btrfs]
[So Jan  5 13:49:21 2020]  ? remove_wait_queue+0x60/0x60
[So Jan  5 13:49:21 2020]  btrfs_commit_transaction+0x1ab/0x9d0 [btrfs]
[So Jan  5 13:49:21 2020]  ? block_rsv_release_bytes+0x9a/0x150 [btrfs]
[So Jan  5 13:49:21 2020]  create_subvol+0x3bf/0x820 [btrfs]
[So Jan  5 13:49:21 2020]  ? btrfs_mksubvol+0x30e/0x610 [btrfs]
[So Jan  5 13:49:21 2020]  btrfs_mksubvol+0x30e/0x610 [btrfs]
[So Jan  5 13:49:21 2020]  ? kmem_cache_alloc_trace+0x148/0x1c0
[So Jan  5 13:49:21 2020]  ? 
insert_reserved_file_extent.constprop.69+0x2f0/0x2f0 [btrfs]
[So Jan  5 13:49:21 2020]  ? _cond_resched+0x16/0x40
[So Jan  5 13:49:21 2020]  btrfs_ioctl_snap_create_transid+0x117/0x1a0 
[btrfs]
[So Jan  5 13:49:21 2020]  ? _copy_from_user+0x31/0x60
[So Jan  5 13:49:21 2020]  btrfs_ioctl_snap_create+0x66/0x80 [btrfs]
[So Jan  5 13:49:21 2020]  btrfs_ioctl+0x6b5/0x2ac0 [btrfs]
[So Jan  5 13:49:21 2020]  ? do_vfs_ioctl+0xa2/0x640
[So Jan  5 13:49:21 2020]  ? 
btrfs_ioctl_get_supported_features+0x30/0x30 [btrfs]
[So Jan  5 13:49:21 2020]  do_vfs_ioctl+0xa2/0x640
[So Jan  5 13:49:21 2020]  ? __do_sys_newfstat+0x3c/0x60
[So Jan  5 13:49:21 2020]  ksys_ioctl+0x70/0x80
[So Jan  5 13:49:21 2020]  __x64_sys_ioctl+0x16/0x20
[So Jan  5 13:49:21 2020]  do_syscall_64+0x55/0x110
[So Jan  5 13:49:21 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[So Jan  5 13:49:21 2020] RIP: 0033:0x55a9b81cd5a0
[So Jan  5 13:49:21 2020] Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 
20 49 c7 c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 
44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 
c7 44 24 30
[So Jan  5 13:49:21 2020] RSP: 002b:000000c4214c6720 EFLAGS: 00000206 
ORIG_RAX: 0000000000000010
[So Jan  5 13:49:21 2020] RAX: ffffffffffffffda RBX: 0000000000000000 
RCX: 000055a9b81cd5a0
[So Jan  5 13:49:21 2020] RDX: 000000c4214c6760 RSI: 000000005000940e 
RDI: 0000000000000076
[So Jan  5 13:49:21 2020] RBP: 000000c4214c7790 R08: 0000000000000000 
R09: 0000000000000000
[So Jan  5 13:49:21 2020] R10: 0000000000000000 R11: 0000000000000206 
R12: ffffffffffffffff
[So Jan  5 13:49:21 2020] R13: 0000000000000038 R14: 0000000000000037 
R15: 00000000000000aa
[So Jan  5 13:51:22 2020] INFO: task dockerd:2900 blocked for more than 
120 seconds.
[So Jan  5 13:51:22 2020]       Tainted: G           OE     5.2.8 #1
[So Jan  5 13:51:22 2020] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.

What could be the reason for this and how can I prevent/fix it?


About my system:

root@homeserver:~# uname -a
Linux homeserver 5.2.8 #1 SMP Thu Aug 15 21:22:00 CEST 2019 x86_64 
GNU/Linux
root@homeserver:~#   btrfs --version
btrfs-progs v4.20.2
root@homeserver:~#   btrfs fi show
Label: 'DockerImages'  uuid: 303256f2-6901-4564-892e-cdca9dda50e3
         Total devices 1 FS bytes used 12.47GiB
         devid    1 size 52.16GiB used 29.05GiB path /dev/sdf3

Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         Total devices 2 FS bytes used 7.22TiB
         devid    1 size 7.28TiB used 7.27TiB path /dev/sdg1
         devid    2 size 7.28TiB used 7.27TiB path /dev/sdc1


btrfs fi df /srv/dev-disk-by-label-DockerImages/
Data, single: total=25.01GiB, used=11.80GiB
System, single: total=32.00MiB, used=16.00KiB
Metadata, single: total=4.01GiB, used=842.02MiB
GlobalReserve, single: total=85.78MiB, used=0.00B

Yes, there are two btrfs filesystems. I am rather sure it is the 
DockerImages one, as I see no reason why the other would make docker 
hang.


Regards,
Hendrik

