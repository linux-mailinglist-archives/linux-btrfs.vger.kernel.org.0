Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0B840BD90
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 04:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhIOCQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 22:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOCQH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 22:16:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E28C061574;
        Tue, 14 Sep 2021 19:14:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so1312074pfm.1;
        Tue, 14 Sep 2021 19:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=OZxKW41rRiV3r7hLzdXJx6nEq2egqky4eb6yLK/B+6c=;
        b=NuAk1FlecpUdhRtLIuTSEGt/u6LUpyRqLfVAGWtuPPc0xb/0mgnixRLQNgCFv1SwYS
         548pNDwhcj+Baf3lf94Z3ezovnY+9lTUzql9l4eIkL46ozge0SFahSY60oWbW6p32ZGW
         3ztitIugPNqLZr7koCkt5DEVRVn+EU5ALXbj2vfo6Md11lB5bLmaQRg2oKuwaYJpmM3F
         xH3/UQH3H475L4l9xRuX3DGW0GZF2fyB5SalhUVHPTVNjAa7OYU318fal6dhgQ1MA3yV
         1L8gPAkeT9SoJV7DGvAKhIDI8njMWcbdJrt2p3dLr1xDYW1OPuShPscd0JrnL0CCNoP0
         oG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=OZxKW41rRiV3r7hLzdXJx6nEq2egqky4eb6yLK/B+6c=;
        b=XPoqzcDru1/fJBhr4UEafVVrqGHZyhr42ZNrdZcx54Noq+2lKpfuOtfYESJrSEEhuv
         7M59hY0HWwNLQJem6dNwaRtlrxKXIFJmxbHRN4WAq22+p2ok89DMF8htvi9pSo/TCUxY
         O46GhuLVAOTIpHghqtA/O0veQG1eHOvQVzpb/OryFuJC1bMl5nkwdtiZ0QMV1UUGlufs
         VBFVWGSWJAIgVNrtHeuVDNbz7NDbezdRPFBPin/ZdTB5zfaSIMmlhACCzhhMcwp1SUvd
         E/dK1SIVCVfgvP8kcc9JrMqD5l7Zfc2FZZY9HyyXQwwx8pXTXNViFCajO0N5HS6iR7ZE
         Q8ng==
X-Gm-Message-State: AOAM533MNyDjVx/I6+//xVapeu9fd0pKVPtRS8dbQDSDG3nx/psxF7m/
        M+D3o9nRXqoF/yHi59/N8Mf//2omxULI4RkFV9Z9DgBEQaiYv/w=
X-Google-Smtp-Source: ABdhPJyg4/PuFOZhD3M68ujA5Cb7BWUFabmJjPKqsK8po5D5mmni7p5SwELEsgA6qISH5gJGXNe/N9XFYAnXllrLxIE=
X-Received: by 2002:aa7:8747:0:b0:3f2:78f:977d with SMTP id
 g7-20020aa78747000000b003f2078f977dmr7846472pfo.59.1631672088554; Tue, 14 Sep
 2021 19:14:48 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 10:14:37 +0800
Message-ID: <CACkBjsa0wQ5oDQh0CABfV-UoAa9czS6DAuAA0fBrM_HhVxd6+w@mail.gmail.com>
Subject: WARNING in btrfs_run_delayed_refs
To:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/1gd0dl74MyvvVAYqsCDKSGmcfpZszD0kt/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1WKQukijOJ7D0NYk1iKf47FESjYfAjrlz/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1Gi9-Mgbrjw1OI-ymO4zDVIFej2Qf4ppL/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop11: detected capacity change from 0 to 32768
BTRFS info (device loop11): disk space caching is enabled
BTRFS info (device loop11): has skinny extents
BTRFS info (device loop11): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x13c/0x160 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
 __btrfs_free_extent.isra.53+0x7b/0x1180 fs/btrfs/extent-tree.c:2942
 run_delayed_tree_ref fs/btrfs/extent-tree.c:1687 [inline]
 run_one_delayed_ref fs/btrfs/extent-tree.c:1711 [inline]
 btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1952 [inline]
 __btrfs_run_delayed_refs+0x83e/0x1a00 fs/btrfs/extent-tree.c:2017
 btrfs_run_delayed_refs+0xb1/0x2b0 fs/btrfs/extent-tree.c:2148
 btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
 btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
 btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7769 at fs/btrfs/extent-tree.c:2150
btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150
Modules linked in:
CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150
Code: 72 2d e8 ce a4 4d ff 8b 04 24 83 f8 fb 74 49 83 f8 e2 74 44 e8
bc a4 4d ff 8b 04 24 48 c7 c7 38 25 39 85 89 c6 e8 db ab 38 ff <0f> 0b
8b 04 24 89 04 24 e8 9e a4 4d ff 8b 04 24 ba 66 08 00 00 4c
RSP: 0018:ffffc9000509bcc8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888014054000 RCX: ffffc9000cb3c000
RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
RBP: ffff888014054000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801f13e800
R13: ffff8880091b2000 R14: ffff88801f13e800 R15: 0000000000000000
FS:  00007f8ac08c8700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc39085b000 CR3: 000000010e194000 CR4: 0000000000750ee0
DR0: 0000000000003000 DR1: 0000000000001000 DR2: 0000000000010000
DR3: 000000000000d000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
 btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
 btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
