Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26034CE85
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhC2LLf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Mar 2021 07:11:35 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhC2LLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 07:11:31 -0400
Received: from [192.168.177.84] ([91.56.89.170]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis) id
 1MEVmm-1lP8yh3SWY-00G24A for <linux-btrfs@vger.kernel.org>; Mon, 29 Mar 2021
 13:11:29 +0200
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     linux-btrfs@vger.kernel.org
Subject: Filesystem sometimes Hangs
Date:   Mon, 29 Mar 2021 11:11:30 +0000
Message-Id: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
User-Agent: eM_Client/8.1.1060.0
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:H2RcMQ7bF9F1qdrlhoH51mpEined0LnefTj+LUhqyoD5vlWHhfh
 7Js1nvBb8KRQlNMXzh2uM08aGf836rNbfz+IumpesRg6KGSSqjz3RCwKYzG8W2IgjtwrHBN
 AMwvONVCsTAcqLiPEsb1HlrMcPiumfAzvixqFxWsiynzrDn+qWkETQmHFdV4206FF+GqL3m
 4L686SfNvN3Muj3XnXu/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:42bFpFLyLzc=:d7vaE+Afa5Qo+B5QxIGm9f
 P4HwKcGKtKWgVGHXaP2QQroQdEKau1ey5hcIEdGWLM3y5QE1pO89MrUAPi5/NeUNx4aKuxmLy
 vYZLCLGB7vysWST+Pp8BewcAXAfHsVAf0OyemRh5+Nc+T0u8MMzkEvz1gftXBfN5CXeMZ3Ptq
 eNk9E1J6hhizH6+X82n0lfgo5eYt4UYcLeEHWOc3mCPfdpYRrTQZZkq/27gbn2jFrTttsv8Yk
 H5ScqSMbvnvBOavrOHPl0GSa12uRVJ8q6nM/ekvqEBWYUkT+sjT9svoRm8kQC6aLou4FNC1vv
 HkBkt3UZ+ez+7MfJ8/DWDCx7XwAJ4zXG2SWv6c/BPsvajuJdlagCTy/mrXTQ1y8szEoVtojqU
 oYNnvQjaf7ZZoTor2HrqtMUflfG1DsbM+vjz22Fuk6M8Crmp7rzsKL1UemNx7tiGri5trVk5L
 ji0klwiVKD1FXY1z2X0rwBfYcP4Ipv0toMlT0y23T6s/sf5P7/0R
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a filesystem which is sometimes very slow, or even currently 
hangs deleting a file (plain and simple rm in bash).

Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
         Total devices 2 FS bytes used 5.65TiB
         devid    1 size 7.28TiB used 6.71TiB path /dev/sda1
         devid    2 size 7.28TiB used 6.71TiB path /dev/sdh1

I did run a scrub without errors.

Checking the logs, I find:
dmesg -T |grep -i btrfs
[Mo Mär 29 09:29:16 2021] Btrfs loaded, crc32c=crc32c-intel
[Mo Mär 29 09:29:16 2021] BTRFS: device label DataPool1 devid 2 transid 
649014 /dev/sdh1 scanned by btrfs (213)
[Mo Mär 29 09:29:16 2021] BTRFS: device label DataPool1 devid 1 transid 
649014 /dev/sda1 scanned by btrfs (213)
[Mo Mär 29 09:29:16 2021] BTRFS: device label Daten devid 1 transid 
254377 /dev/sdd2 scanned by btrfs (213)
[Mo Mär 29 09:29:16 2021] BTRFS: device label DockerImages devid 1 
transid 209067 /dev/sdc2 scanned by btrfs (213)
[Mo Mär 29 09:29:21 2021] BTRFS info (device sda1): disk space caching 
is enabled
[Mo Mär 29 09:29:21 2021] BTRFS info (device sda1): has skinny extents
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdd2): enabling ssd 
optimizations
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdd2): disk space caching 
is enabled
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdd2): has skinny extents
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdc2): turning on sync 
discard
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdc2): enabling ssd 
optimizations
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdc2): disk space caching 
is enabled
[Mo Mär 29 09:29:21 2021] BTRFS info (device sdc2): has skinny extents
[Mo Mär 29 09:29:22 2021] BTRFS info (device sda1): bdev /dev/sda1 errs: 
wr 133, rd 133, flush 0, corrupt 0, gen 1

Maybe, the last line is concerning?


Syslog tells me:
Mar 28 20:22:19 homeserver kernel: [1297978.357508] task:btrfs-cleaner   
state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
Mar 28 20:22:19 homeserver kernel: [1297978.357547]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357564]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357577]  
btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357594]  ? 
btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357609]  
btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357622]  
cleaner_kthread+0xfa/0x120 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.357636]  ? 
btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.360473]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.360488]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.360503]  
btrfs_create+0x58/0x1f0 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.363057]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.363072]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:22:19 homeserver kernel: [1297978.363086]  
btrfs_rmdir+0x5c/0x180 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024321] task:btrfs-cleaner   
state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
Mar 28 20:26:20 homeserver kernel: [1298220.024382]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024419]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024442]  
btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024476]  ? 
btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024504]  
btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024531]  
cleaner_kthread+0xfa/0x120 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.024558]  ? 
btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.030300]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.030331]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:26:20 homeserver kernel: [1298220.030361]  
btrfs_create+0x58/0x1f0 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854109] task:btrfs-cleaner   
state:D stack:    0 pid:20078 ppid:     2 flags:0x00004000
Mar 28 20:28:21 homeserver kernel: [1298340.854151]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854169]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854183]  
btrfs_drop_snapshot+0x90/0x7f0 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854202]  ? 
btrfs_delete_unused_bgs+0x3e/0x850 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854218]  
btrfs_clean_one_deleted_snapshot+0xd7/0x130 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854232]  
cleaner_kthread+0xfa/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.854247]  ? 
btrfs_alloc_root+0x3d0/0x3d0 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857610]  
wait_current_trans+0xc2/0x120 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857627]  
start_transaction+0x46d/0x540 [btrfs]
Mar 28 20:28:21 homeserver kernel: [1298340.857643]  
btrfs_create+0x58/0x1f0 [btrfs]
Mar 28 20:58:34 homeserver kernel: [1300153.336160] task:btrfs-transacti 
state:D stack:    0 pid:20080 ppid:     2 flags:0x00004000
Mar 28 20:58:34 homeserver kernel: [1300153.336215]  
btrfs_commit_transaction+0x92b/0xa50 [btrfs]
Mar 28 20:58:34 homeserver kernel: [1300153.336246]  
transaction_kthread+0x15d/0x180 [btrfs]
Mar 28 20:58:34 homeserver kernel: [1300153.336273]  ? 
btrfs_cleanup_transaction+0x590/0x590 [btrfs]


What could I do to find the cause?

Regards,
Hendrik

