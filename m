Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097E740A30C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhINCJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhINCJC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:09:02 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65287C061574;
        Mon, 13 Sep 2021 19:07:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id v123so10664188pfb.11;
        Mon, 13 Sep 2021 19:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=d+5EAlpLu1PtcmGdfK1WhWtt4geqe+e2PpqZC+9r8tA=;
        b=QKz0KdDFi5Z+Vss4BxmJF5+lJI3jzEVLqeORWX/Lx0WZlQiwwxECv4MbQ1GJV3OFZe
         Khs6yEPNTIQJSXT4eeEQuAl3lPYD3JYtaPFjokLJjrNOGvYQtXcTdeISFPSFfsficrrz
         grukKrYa37dBQtBJhkaester5bdEYt0Nb8QhzQcffJ9Cd4KRIXS3Sn2TtRhqomyz/KE2
         ihwySEn1/OAUfcF+auufRIHsL7VUyA4SAASu5Tz7SNM3Yu6AkT9DXHKKvf12JiUs1Wtw
         Z6cqsfAqefC63Ml9OhFNoJaOZMJLEi1rtjxMoooY06Xx/mWAbtM9zUtfltxO7hwsswUi
         6JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=d+5EAlpLu1PtcmGdfK1WhWtt4geqe+e2PpqZC+9r8tA=;
        b=8PcW/hdOU424FcXybQy9ePNxbrkgf+z12bNlipKfxPM4HOfhiTd89c9zxFHt1IfClA
         VX2CfSlDDShedC+vEqC2YW1+VpanUe9jTnshURtE4fTf7XrK7SE9eoYUqhtioUadnfEO
         YmwHwP3iiU37tIpjo2V7n3BpadHNeN4Sic5uUA2NoPkZSioqAqd9Y3zJANnY5cXoBGZb
         KypMeQtx7ebr7rtdPGaiys5yadaqQaCmV4XTNbc7qnt1VHF6TtV9ra+Abd35wQu27alr
         w7zLfJqHdOhviZw5U/YK9nj9wLICSXpmIIiIb8cSf5ZCBnSy1ATkJVvqhhrAU7dkOqIT
         mnwA==
X-Gm-Message-State: AOAM530Gk/xRBHW6cAgo0tTVuSOowzEECEiERnvKz6z9OkYahCr46fK+
        3N00OsJ2FRdxVPsAQWpPB8cfhaiTIpL9us+L4D7QjvQAlxXc
X-Google-Smtp-Source: ABdhPJxfy9qVUYn9NTSwUpmXsaMo0A7YZF9pxtdIuChCFfh0IZfF1MijWCLOtitKMYEFMBCsIlhFlIVG8tkWzM/lo8I=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr2408112pfj.43.1631585265690; Mon, 13 Sep
 2021 19:07:45 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:07:34 +0800
Message-ID: <CACkBjsbyFhwDgK0oBuu3P9Z0EqSpsb==9K_S+dxNwBj=qU_n=g@mail.gmail.com>
Subject: kernel BUG in btrfs_free_tree_block
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
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
https://drive.google.com/file/d/1Dj7_zR7EzzSb0ba9M7QS43O3jrWBdaGW/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/19Of7kky0AvoVCnDh45TfsFDgQ_HBZW67/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/10Ltk6J-pt41zI95k8B5gI-sZBZjI4Wyh/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop13: detected capacity change from 0 to 32768
BTRFS: device fsid 88a22be4-8cb5-4ed2-8c2d-1957ce391952 devid 1
transid 7 /dev/loop13 scanned by syz-executor (7196)
BTRFS info (device loop13): disk space caching is enabled
BTRFS info (device loop13): has skinny extents
BTRFS info (device loop13): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 3 PID: 7196 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 btrfs_add_delayed_tree_ref+0xa1/0x580 fs/btrfs/delayed-ref.c:913
 btrfs_free_tree_block+0x14c/0x440 fs/btrfs/extent-tree.c:3296
 __btrfs_cow_block+0x5f6/0x7d0 fs/btrfs/ctree.c:465
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
 btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
 btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
 lookup_open+0x660/0x780 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x465/0xe20 fs/namei.c:3557
 do_filp_open+0xe3/0x170 fs/namei.c:3588
 do_sys_openat2+0x357/0x4a0 fs/open.c:1200
 do_sys_open+0x87/0xd0 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ffa345c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007f0ffa345c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd3f5c1ed0
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-tree.c:3297!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 3 PID: 7196 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_free_tree_block+0x159/0x440 fs/btrfs/extent-tree.c:3297
Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 81 9d 4d ff 31 d2 4c 89 e7
48 89 e6 e8 e4 96 09 00 85 c0 0f 84 68 ff ff ff e8 67 9d 4d ff <0f> 0b
e8 60 9d 4d ff 48 83 bd df 01 00 00 fa 74 27 e8 51 9d 4d ff
RSP: 0018:ffffc9000528f7c8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff888104ba4d80 RCX: ffffc9000125d000
RDX: 0000000000040000 RSI: ffffffff81e9f499 RDI: ffffffff853cbec6
RBP: ffff888103c67000 R08: 0000000000000068 R09: 0000000000000001
R10: ffffc9000528f638 R11: 0000000000000005 R12: ffff888106374000
R13: 0000000000000001 R14: ffff88810965c000 R15: 0000000000000000
FS:  00007f0ffa346700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000788000 CR3: 000000001aa9c000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __btrfs_cow_block+0x5f6/0x7d0 fs/btrfs/ctree.c:465
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
 btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
 btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
 lookup_open+0x660/0x780 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x465/0xe20 fs/namei.c:3557
 do_filp_open+0xe3/0x170 fs/namei.c:3588
 do_sys_openat2+0x357/0x4a0 fs/open.c:1200
 do_sys_open+0x87/0xd0 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ffa345c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007f0ffa345c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd3f5c1ed0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 917bc653bd051886 ]---
RIP: 0010:btrfs_free_tree_block+0x159/0x440 fs/btrfs/extent-tree.c:3297
Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 81 9d 4d ff 31 d2 4c 89 e7
48 89 e6 e8 e4 96 09 00 85 c0 0f 84 68 ff ff ff e8 67 9d 4d ff <0f> 0b
e8 60 9d 4d ff 48 83 bd df 01 00 00 fa 74 27 e8 51 9d 4d ff
RSP: 0018:ffffc9000528f7c8 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff888104ba4d80 RCX: ffffc9000125d000
RDX: 0000000000040000 RSI: ffffffff81e9f499 RDI: ffffffff853cbec6
RBP: ffff888103c67000 R08: 0000000000000068 R09: 0000000000000001
R10: ffffc9000528f638 R11: 0000000000000005 R12: ffff888106374000
R13: 0000000000000001 R14: ffff88810965c000 R15: 0000000000000000
FS:  00007f0ffa346700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000788000 CR3: 000000001aa9c000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
