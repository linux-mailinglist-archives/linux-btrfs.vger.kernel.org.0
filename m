Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9089F37FFDE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 May 2021 23:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhEMVpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 May 2021 17:45:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12702 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233525AbhEMVpU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 May 2021 17:45:20 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DLYdfk190603
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 17:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=anvD9LnwEq4efGGLL9KHJjk5XAX8ZMZ1WvLdzJ1+2zo=;
 b=LewEH3NreRwWHGMT6aF7E2opZiWiH5Y5IepreFtpGQU4CmhupwRNS0Npsif2LAcBx/BE
 RILNRqeAr3lNNP1o552LwTroQgizcNUwipCKbxwU2U5cNjQQjlW2bVRGlAsKxxhJ8Lf+
 ish91/hWvZubcj/haQH8Pp0jo/w6fZ6j5SzoBgpsKyEKrvQ4rGao0VDhNPBlU2MzcuT4
 cGuYGC0Yf5celBes7wkxVEKZI04Ur0ZoV8L5YTV8VtvNMMBbSMV+k9svvGvhomL6ofv7
 Jw/REqTSx36MndD+8uFhcz/W20TqId6srv7nbe0lwWWaJwtlw4H8NLKbmGXQEtq3T5Hy qA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38hc59r4r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 17:44:09 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14DLbuwE003184
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:44:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 38hc6pg01g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:44:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14DLhc2831981854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:43:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8F2A42041
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:44:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CEED4203F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:44:05 +0000 (GMT)
Received: from localhost (unknown [9.77.196.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
        for <linux-btrfs@vger.kernel.org>; Thu, 13 May 2021 21:44:05 +0000 (GMT)
Date:   Fri, 14 May 2021 03:14:04 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     linux-btrfs@vger.kernel.org
Subject: btrfs/112 failure causing lockdep warning?
Message-ID: <20210513214404.xks77p566fglzgum@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ISVir4i1n8XQVM9HQ1khaBqsrqJ0i7DD
X-Proofpoint-GUID: ISVir4i1n8XQVM9HQ1khaBqsrqJ0i7DD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-13_14:2021-05-12,2021-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=620 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130151
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I am seeing below failure on v5.13-rc1. I could recall that I see the similar
warning on 5.12 as well. Is this a known issue?

btrfs/112 3s ... 	[21:34:13][   41.306155] run fstests btrfs/112 at 2021-05-13 21:34:13

[   46.305677] BTRFS: device fsid 4e2f15b9-c61b-4b0e-9734-fa8ca5a2aac7 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3741)
[   46.365416] BTRFS info (device vdc): disk space caching is enabled
[   46.367401] BTRFS info (device vdc): has skinny extents
[   46.381101] BTRFS info (device vdc): checking UUID tree
[   46.580634]
[   46.580704] ======================================================
[   46.580752] WARNING: possible circular locking dependency detected
[   46.580799] 5.13.0-rc1 #28 Not tainted
[   46.580832] ------------------------------------------------------
[   46.580877] cloner/3835 is trying to acquire lock:
[   46.580918] c00000001301d638 (sb_internal#2){.+.+}-{0:0}, at: clone_copy_inline_extent+0xe4/0x5a0
[   46.581167]
[   46.581167] but task is already holding lock:
[   46.581217] c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
[   46.581293]
[   46.581293] which lock already depends on the new lock.
[   46.581293]
[   46.581351]
[   46.581351] the existing dependency chain (in reverse order) is:
[   46.581410]
[   46.581410] -> #1 (btrfs-tree-00){++++}-{3:3}:
[   46.581464]        down_read_nested+0x68/0x200
[   46.581536]        __btrfs_tree_read_lock+0x70/0x1d0
[   46.581577]        btrfs_read_lock_root_node+0x88/0x200
[   46.581623]        btrfs_search_slot+0x298/0xb70
[   46.581665]        btrfs_set_inode_index+0xfc/0x260
[   46.581708]        btrfs_new_inode+0x26c/0x950
[   46.581749]        btrfs_create+0xf4/0x2b0
[   46.581782]        lookup_open.isra.57+0x55c/0x6a0
[   46.581855]        path_openat+0x418/0xd20
[   46.581888]        do_filp_open+0x9c/0x130
[   46.581920]        do_sys_openat2+0x2ec/0x430
[   46.581961]        do_sys_open+0x90/0xc0
[   46.581993]        system_call_exception+0x3d4/0x410
[   46.582037]        system_call_common+0xec/0x278
[   46.582078]
[   46.582078] -> #0 (sb_internal#2){.+.+}-{0:0}:
[   46.582135]        __lock_acquire+0x1e90/0x2c50
[   46.582176]        lock_acquire+0x2b4/0x5b0
[   46.582263]        start_transaction+0x3cc/0x950
[   46.582308]        clone_copy_inline_extent+0xe4/0x5a0
[   46.582353]        btrfs_clone+0x5fc/0x880
[   46.582388]        btrfs_clone_files+0xd8/0x1c0
[   46.582434]        btrfs_remap_file_range+0x3d8/0x590
[   46.582481]        do_clone_file_range+0x10c/0x270
[   46.582558]        vfs_clone_file_range+0x1b0/0x310
[   46.582605]        ioctl_file_clone+0x90/0x130
[   46.582651]        do_vfs_ioctl+0x874/0x1ac0
[   46.582697]        sys_ioctl+0x6c/0x120
[   46.582733]        system_call_exception+0x3d4/0x410
[   46.582777]        system_call_common+0xec/0x278
[   46.582822]
[   46.582822] other info that might help us debug this:
[   46.582822]
[   46.582888]  Possible unsafe locking scenario:
[   46.582888]
[   46.582942]        CPU0                    CPU1
[   46.582984]        ----                    ----
[   46.583028]   lock(btrfs-tree-00);
[   46.583062]                                lock(sb_internal#2);
[   46.583119]                                lock(btrfs-tree-00);
[   46.583174]   lock(sb_internal#2);
[   46.583212]
[   46.583212]  *** DEADLOCK ***
[   46.583212]
[   46.583266] 6 locks held by cloner/3835:
[   46.583299]  #0: c00000001301d448 (sb_writers#12){.+.+}-{0:0}, at: ioctl_file_clone+0x90/0x130
[   46.583382]  #1: c00000000f6d3768 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: lock_two_nondirectories+0x58/0xc0
[   46.583477]  #2: c00000000f6d72a8 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
[   46.583574]  #3: c00000000f6d7138 (&ei->i_mmap_lock){+.+.}-{3:3}, at: btrfs_remap_file_range+0xd0/0x590
[   46.583657]  #4: c00000000f6d35f8 (&ei->i_mmap_lock/1){+.+.}-{3:3}, at: btrfs_remap_file_range+0xe0/0x590
[   46.583743]  #5: c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
[   46.583828]
[   46.583828] stack backtrace:
[   46.583872] CPU: 1 PID: 3835 Comm: cloner Not tainted 5.13.0-rc1 #28
[   46.583931] Call Trace:
[   46.583955] [c0000000167c7200] [c000000000c1ee78] dump_stack+0xec/0x144 (unreliable)
[   46.584052] [c0000000167c7240] [c000000000274058] print_circular_bug.isra.32+0x3a8/0x400
[   46.584123] [c0000000167c72e0] [c0000000002741f4] check_noncircular+0x144/0x190
[   46.584191] [c0000000167c73b0] [c000000000278fc0] __lock_acquire+0x1e90/0x2c50
[   46.584259] [c0000000167c74f0] [c00000000027aa94] lock_acquire+0x2b4/0x5b0
[   46.584317] [c0000000167c75e0] [c000000000a0d6cc] start_transaction+0x3cc/0x950
[   46.584388] [c0000000167c7690] [c000000000af47a4] clone_copy_inline_extent+0xe4/0x5a0
[   46.584457] [c0000000167c77c0] [c000000000af525c] btrfs_clone+0x5fc/0x880
[   46.584514] [c0000000167c7990] [c000000000af5698] btrfs_clone_files+0xd8/0x1c0
[   46.584583] [c0000000167c7a00] [c000000000af5b58] btrfs_remap_file_range+0x3d8/0x590
[   46.584652] [c0000000167c7ae0] [c0000000005d81dc] do_clone_file_range+0x10c/0x270
[   46.584722] [c0000000167c7b40] [c0000000005d84f0] vfs_clone_file_range+0x1b0/0x310
[   46.584793] [c0000000167c7bb0] [c00000000058bf80] ioctl_file_clone+0x90/0x130
[   46.584861] [c0000000167c7c10] [c00000000058c894] do_vfs_ioctl+0x874/0x1ac0
[   46.584922] [c0000000167c7d10] [c00000000058db4c] sys_ioctl+0x6c/0x120
[   46.584978] [c0000000167c7d60] [c0000000000364a4] system_call_exception+0x3d4/0x410
[   46.585046] [c0000000167c7e10] [c00000000000d45c] system_call_common+0xec/0x278
[   46.585114] --- interrupt: c00 at 0x7ffff7e22990
[   46.585160] NIP:  00007ffff7e22990 LR: 00000001000010ec CTR: 0000000000000000
[   46.585224] REGS: c0000000167c7e80 TRAP: 0c00   Not tainted  (5.13.0-rc1)
[   46.585280] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000244  XER: 00000000
[   46.585374] IRQMASK: 0
[   46.585374] GPR00: 0000000000000036 00007fffffffdec0 00007ffff7f17100 0000000000000004
[   46.585374] GPR04: 000000008020940d 00007fffffffdf40 0000000000000000 0000000000000000
[   46.585374] GPR08: 0000000000000004 0000000000000000 0000000000000000 0000000000000000
[   46.585374] GPR12: 0000000000000000 00007ffff7ffa940 0000000000000000 0000000000000000
[   46.585374] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   46.585374] GPR20: 0000000000000000 000000009123683e 00007fffffffdf40 0000000000000000
[   46.585374] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000004
[   46.585374] GPR28: 0000000100030260 0000000100030280 0000000000000003 000000000000005f
[   46.585919] NIP [00007ffff7e22990] 0x7ffff7e22990
[   46.585964] LR [00000001000010ec] 0x1000010ec
[   46.586010] --- interrupt: c00

[   51.018340] BTRFS: device fsid 09d13397-1bb3-425e-8b98-ff3771442441 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3841)
[   51.058553] BTRFS info (device vdc): use zlib compression, level 3
[   51.058641] BTRFS info (device vdc): disk space caching is enabled
[   51.058690] BTRFS info (device vdc): has skinny extents
[   51.080240] BTRFS info (device vdc): checking UUID tree

[   55.631182] BTRFS: device fsid 0254de1a-5b6a-40d8-b75a-8940477d1853 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (3940)
[   55.663889] BTRFS info (device vdc): disk space caching is enabled
[   55.664206] BTRFS info (device vdc): has skinny extents
[   55.700305] BTRFS info (device vdc): checking UUID tree
[   55.737159] random: crng init done
[   55.737430] random: 7 urandom warning(s) missed due to ratelimiting
[   56.268773] BTRFS: device fsid e5ce6c0b-cd36-4fc5-a9cf-059897fb1b84 devid 1 transid 5 /dev/vdc scanned by mkfs.btrfs (4040)
[   56.303277] BTRFS info (device vdc): use zlib compression, level 3
[   56.304065] BTRFS info (device vdc): disk space caching is enabled
[   56.304132] BTRFS info (device vdc): has skinny extents
[   56.329306] BTRFS info (device vdc): checking UUID tree

_check_dmesg: something found in dmesg (see /results/btrfs/results-64k/btrfs/112.dmesg)

-ritesh
