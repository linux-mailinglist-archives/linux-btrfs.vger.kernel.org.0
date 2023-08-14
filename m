Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202377B0F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjHNF4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjHNFzf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 01:55:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F85171A;
        Sun, 13 Aug 2023 22:55:00 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso6024338e87.1;
        Sun, 13 Aug 2023 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691992496; x=1692597296;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aNaVHgQHFoGPaGiijKQ12shcWZzFHJxzUgemaDebrww=;
        b=NcLGAhbR33X1cqx2EytGZlE56fCqTflSR/Q5uOoprgG42mpS0F+RzoVd78seW7WZfx
         Ss9vLkfCfF+fDCGnhc6GzJ531jMwVY0+eySG7k5UA7pmlb14Y/s1xcAQ+WyVzzwFmVO7
         N/HMcN5LGQUc/728uzC3xITk/PIGWZtj9Q9sSo9vZYRWUV7foAZZMe6kdQ7SaS3xxGP5
         cmCH5rtq6DPJV2WareXMDhxXv5rcwguTeBVX+3scKY8+RWXVtNqkgdm78A6Bptay/OpS
         +VmGiFY3QY7v/zWs6Dwa4yRUh0uS6FuZ9aOYMrpKGLJQMFV+CgdaPowQqWjzri0fcDfX
         CLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691992496; x=1692597296;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNaVHgQHFoGPaGiijKQ12shcWZzFHJxzUgemaDebrww=;
        b=HpCo3uh+Cnvwi1equgKazEn4Lclbu4DZXfTVuMB4PCZFJ9DaFURcFp+mFcI11if0DM
         E62s3XbmgEWmtByi4CR67Bakexc1clPdjRFF23QMblXALmKBCNa5Y45G4mvtxeESZNfF
         Tr2m/lTIO59agD5i0qEe/2YpPOk+QtTBjvD7z2Fra0xEu+77cupNJmyNCqbk9qEw22vq
         EufB++Ad6wIke4h/2UfNVglGl4gccZJ/6yoLqc6QnBn7FgXTDY6LVUXNIfIJDiAdl6My
         06z+X2rRyMUHNR90A9Zzo7Vc4QjoMkPRXfuzWSlHqB81d5CzTwWRiicc1DFJJeX7LR2N
         Y5rQ==
X-Gm-Message-State: AOJu0Yy6ys85ycusmYa8uw7hrTBEy37lwvn0HNJNp7jlMK9uqx7JaguQ
        hVmbk1p1BUJPS4AWjw/tjbBnSXy0Pajc1oAGQ5g=
X-Google-Smtp-Source: AGHT+IG4blEj73jIx2ElUZD7NPiMsd3nHaUp9VhSD0HoaE4lNc7vNeAgk/AaWHYk+ceQ0LEHbWkTvc1lmBOsBtZIedA=
X-Received: by 2002:a05:6512:b95:b0:4fb:9f24:bba9 with SMTP id
 b21-20020a0565120b9500b004fb9f24bba9mr7384044lfv.5.1691992495835; Sun, 13 Aug
 2023 22:54:55 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Mon, 14 Aug 2023 13:54:44 +0800
Message-ID: <CALcu4rZGQeGRmUgoBiu4GkJOqHzQF19iP6h4+vQimRopq-WETg@mail.gmail.com>
Subject: kernel BUG in clear_state_bit
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the Linux-6.5-rc5,  the following crash
was triggered.

HEAD commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f (tag: v6.5-rc5)
git tree: upstream

console output:
https://drive.google.com/file/d/1Sg6yYFkElzsBtyrCnV1-KrAy3ISleEvr/view?usp=drive_link
kernel config:https://drive.google.com/file/d/1zEu1BZEIdK-LvdXWJNlXAqTIhwLV0K43/view?usp=drive_link
C reproducer:https://drive.google.com/file/d/1mXRNm3yxXlUHkygzsV7KkLCb7ANtGtp4/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1Hnkz53xSI9zzPvcQmXa3vXMuPUEkPbR4/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


loop1: detected capacity change from 0 to 32768
BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
transid 7 /dev/loop1 scanned by syz-executor (8792)
BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop1): disk space caching is enabled
BTRFS info (device loop1): enabling ssd optimizations
BTRFS info (device loop1): auto enabling async discard
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 8792 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x132/0x150 lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x49f/0x5b0 lib/fault-inject.c:153
 should_failslab+0x5/0x10 mm/slab_common.c:1471
 slab_pre_alloc_hook mm/slab.h:711 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x61/0x350 mm/slub.c:3509
 kmalloc_trace+0x22/0xd0 mm/slab_common.c:1076
 kmalloc include/linux/slab.h:582 [inline]
 ulist_add_merge fs/btrfs/ulist.c:210 [inline]
 ulist_add_merge+0x16f/0x660 fs/btrfs/ulist.c:198
 add_extent_changeset fs/btrfs/extent-io-tree.c:191 [inline]
 add_extent_changeset fs/btrfs/extent-io-tree.c:178 [inline]
 clear_state_bit+0x151/0x3a0 fs/btrfs/extent-io-tree.c:514
 __clear_extent_bit+0x586/0xbc0 fs/btrfs/extent-io-tree.c:686
 __btrfs_qgroup_release_data+0x319/0x8f0 fs/btrfs/qgroup.c:3924
 cow_file_range_inline+0x431/0xa30 fs/btrfs/inode.c:691
 cow_file_range+0xa28/0xdb0 fs/btrfs/inode.c:1439
 btrfs_run_delalloc_range+0xc1d/0x1190 fs/btrfs/inode.c:2435
 writepage_delalloc+0x1b0/0x330 fs/btrfs/extent_io.c:1242
 __extent_writepage fs/btrfs/extent_io.c:1492 [inline]
 extent_write_cache_pages+0x79e/0x19b0 fs/btrfs/extent_io.c:2160
 extent_writepages+0x216/0x4a0 fs/btrfs/extent_io.c:2286
 do_writepages+0x1a4/0x630 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc mm/filemap.c:393 [inline]
 filemap_fdatawrite_wbc+0x143/0x1b0 mm/filemap.c:383
 __filemap_fdatawrite_range+0xb4/0xf0 mm/filemap.c:426
 btrfs_fdatawrite_range+0x46/0x110 fs/btrfs/file.c:3850
 start_ordered_ops.constprop.0+0x8d/0xd0 fs/btrfs/file.c:1725
 btrfs_sync_file+0x27d/0x1310 fs/btrfs/file.c:1800
 vfs_fsync_range+0x140/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2499 [inline]
 btrfs_do_write_iter+0x56f/0x11c0 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:1877 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_pwrite64 fs/read_write.c:699 [inline]
 __do_sys_pwrite64 fs/read_write.c:709 [inline]
 __se_sys_pwrite64 fs/read_write.c:706 [inline]
 __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f254c6ec068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f254c6cc000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:515!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8792 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:clear_state_bit+0x314/0x3a0 fs/btrfs/extent-io-tree.c:515
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 32 8b
5d 7c e9 b5 fe ff ff e8 c5 56 f7 fd 0f 0b eb 98 e8 bc 56 f7 fd <0f> 0b
4c 89 f7 e8 a2 21 47 fe e9 79 fd ff ff 4c 89 f7 e8 95 21 47
RSP: 0018:ffffc900073aee08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90002d69000
RDX: 0000000000040000 RSI: ffffffff838903d4 RDI: 0000000000000005
RBP: ffff88802c812c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000039373854 R12: ffff88802b2c9cb0
R13: 0000000000000000 R14: ffff88802c812c7c R15: 0000000000000fff
FS:  00007f254c6ec640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 000000002b4f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 __clear_extent_bit+0x586/0xbc0 fs/btrfs/extent-io-tree.c:686
 __btrfs_qgroup_release_data+0x319/0x8f0 fs/btrfs/qgroup.c:3924
 cow_file_range_inline+0x431/0xa30 fs/btrfs/inode.c:691
 cow_file_range+0xa28/0xdb0 fs/btrfs/inode.c:1439
 btrfs_run_delalloc_range+0xc1d/0x1190 fs/btrfs/inode.c:2435
 writepage_delalloc+0x1b0/0x330 fs/btrfs/extent_io.c:1242
 __extent_writepage fs/btrfs/extent_io.c:1492 [inline]
 extent_write_cache_pages+0x79e/0x19b0 fs/btrfs/extent_io.c:2160
 extent_writepages+0x216/0x4a0 fs/btrfs/extent_io.c:2286
 do_writepages+0x1a4/0x630 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc mm/filemap.c:393 [inline]
 filemap_fdatawrite_wbc+0x143/0x1b0 mm/filemap.c:383
 __filemap_fdatawrite_range+0xb4/0xf0 mm/filemap.c:426
 btrfs_fdatawrite_range+0x46/0x110 fs/btrfs/file.c:3850
 start_ordered_ops.constprop.0+0x8d/0xd0 fs/btrfs/file.c:1725
 btrfs_sync_file+0x27d/0x1310 fs/btrfs/file.c:1800
 vfs_fsync_range+0x140/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2499 [inline]
 btrfs_do_write_iter+0x56f/0x11c0 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:1877 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_pwrite64 fs/read_write.c:699 [inline]
 __do_sys_pwrite64 fs/read_write.c:709 [inline]
 __se_sys_pwrite64 fs/read_write.c:706 [inline]
 __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f254c6ec068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f254c6cc000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_state_bit+0x314/0x3a0 fs/btrfs/extent-io-tree.c:515
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 32 8b
5d 7c e9 b5 fe ff ff e8 c5 56 f7 fd 0f 0b eb 98 e8 bc 56 f7 fd <0f> 0b
4c 89 f7 e8 a2 21 47 fe e9 79 fd ff ff 4c 89 f7 e8 95 21 47
RSP: 0018:ffffc900073aee08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90002d69000
RDX: 0000000000040000 RSI: ffffffff838903d4 RDI: 0000000000000005
RBP: ffff88802c812c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000039373854 R12: ffff88802b2c9cb0
R13: 0000000000000000 R14: ffff88802c812c7c R15: 0000000000000fff
FS:  00007f254c6ec640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 000000002b4f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554


invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8792 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:clear_state_bit+0x314/0x3a0 fs/btrfs/extent-io-tree.c:515
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 32 8b
5d 7c e9 b5 fe ff ff e8 c5 56 f7 fd 0f 0b eb 98 e8 bc 56 f7 fd <0f> 0b
4c 89 f7 e8 a2 21 47 fe e9 79 fd ff ff 4c 89 f7 e8 95 21 47
RSP: 0018:ffffc900073aee08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90002d69000
RDX: 0000000000040000 RSI: ffffffff838903d4 RDI: 0000000000000005
RBP: ffff88802c812c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000039373854 R12: ffff88802b2c9cb0
R13: 0000000000000000 R14: ffff88802c812c7c R15: 0000000000000fff
FS:  00007f254c6ec640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 000000002b4f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 __clear_extent_bit+0x586/0xbc0 fs/btrfs/extent-io-tree.c:686
 __btrfs_qgroup_release_data+0x319/0x8f0 fs/btrfs/qgroup.c:3924
 cow_file_range_inline+0x431/0xa30 fs/btrfs/inode.c:691
 cow_file_range+0xa28/0xdb0 fs/btrfs/inode.c:1439
 btrfs_run_delalloc_range+0xc1d/0x1190 fs/btrfs/inode.c:2435
 writepage_delalloc+0x1b0/0x330 fs/btrfs/extent_io.c:1242
 __extent_writepage fs/btrfs/extent_io.c:1492 [inline]
 extent_write_cache_pages+0x79e/0x19b0 fs/btrfs/extent_io.c:2160
 extent_writepages+0x216/0x4a0 fs/btrfs/extent_io.c:2286
 do_writepages+0x1a4/0x630 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc mm/filemap.c:393 [inline]
 filemap_fdatawrite_wbc+0x143/0x1b0 mm/filemap.c:383
 __filemap_fdatawrite_range+0xb4/0xf0 mm/filemap.c:426
 btrfs_fdatawrite_range+0x46/0x110 fs/btrfs/file.c:3850
 start_ordered_ops.constprop.0+0x8d/0xd0 fs/btrfs/file.c:1725
 btrfs_sync_file+0x27d/0x1310 fs/btrfs/file.c:1800
 vfs_fsync_range+0x140/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2499 [inline]
 btrfs_do_write_iter+0x56f/0x11c0 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:1877 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_pwrite64 fs/read_write.c:699 [inline]
 __do_sys_pwrite64 fs/read_write.c:709 [inline]
 __se_sys_pwrite64 fs/read_write.c:706 [inline]
 __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f254c6ec068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f254c6cc000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_state_bit+0x314/0x3a0 fs/btrfs/extent-io-tree.c:515
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 32 8b
5d 7c e9 b5 fe ff ff e8 c5 56 f7 fd 0f 0b eb 98 e8 bc 56 f7 fd <0f> 0b
4c 89 f7 e8 a2 21 47 fe e9 79 fd ff ff 4c 89 f7 e8 95 21 47
RSP: 0018:ffffc900073aee08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90002d69000
RDX: 0000000000040000 RSI: ffffffff838903d4 RDI: 0000000000000005
RBP: ffff88802c812c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000039373854 R12: ffff88802b2c9cb0
R13: 0000000000000000 R14: ffff88802c812c7c R15: 0000000000000fff
FS:  00007f254c6ec640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 000000002b4f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

PKRU: 55555554
Call Trace:
 <TASK>
 __clear_extent_bit+0x586/0xbc0 fs/btrfs/extent-io-tree.c:686
 __btrfs_qgroup_release_data+0x319/0x8f0 fs/btrfs/qgroup.c:3924
 cow_file_range_inline+0x431/0xa30 fs/btrfs/inode.c:691
 cow_file_range+0xa28/0xdb0 fs/btrfs/inode.c:1439
 btrfs_run_delalloc_range+0xc1d/0x1190 fs/btrfs/inode.c:2435
 writepage_delalloc+0x1b0/0x330 fs/btrfs/extent_io.c:1242
 __extent_writepage fs/btrfs/extent_io.c:1492 [inline]
 extent_write_cache_pages+0x79e/0x19b0 fs/btrfs/extent_io.c:2160
 extent_writepages+0x216/0x4a0 fs/btrfs/extent_io.c:2286
 do_writepages+0x1a4/0x630 mm/page-writeback.c:2553
 filemap_fdatawrite_wbc mm/filemap.c:393 [inline]
 filemap_fdatawrite_wbc+0x143/0x1b0 mm/filemap.c:383
 __filemap_fdatawrite_range+0xb4/0xf0 mm/filemap.c:426
 btrfs_fdatawrite_range+0x46/0x110 fs/btrfs/file.c:3850
 start_ordered_ops.constprop.0+0x8d/0xd0 fs/btrfs/file.c:1725
 btrfs_sync_file+0x27d/0x1310 fs/btrfs/file.c:1800
 vfs_fsync_range+0x140/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2499 [inline]
 btrfs_do_write_iter+0x56f/0x11c0 fs/btrfs/file.c:1677
 call_write_iter include/linux/fs.h:1877 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_pwrite64 fs/read_write.c:699 [inline]
 __do_sys_pwrite64 fs/read_write.c:709 [inline]
 __se_sys_pwrite64 fs/read_write.c:706 [inline]
 __x64_sys_pwrite64+0x1ef/0x240 fs/read_write.c:706
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x47959d
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b4 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f254c6ec068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f254c6cc000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:clear_state_bit+0x314/0x3a0 fs/btrfs/extent-io-tree.c:515
Code: b6 14 02 4c 89 f0 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 32 8b
5d 7c e9 b5 fe ff ff e8 c5 56 f7 fd 0f 0b eb 98 e8 bc 56 f7 fd <0f> 0b
4c 89 f7 e8 a2 21 47 fe e9 79 fd ff ff 4c 89 f7 e8 95 21 47
RSP: 0018:ffffc900073aee08 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 00000000fffffff4 RCX: ffffc90002d69000
RDX: 0000000000040000 RSI: ffffffff838903d4 RDI: 0000000000000005
RBP: ffff88802c812c00 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000039373854 R12: ffff88802b2c9cb0
R13: 0000000000000000 R14: ffff88802c812c7c R15: 0000000000000fff
FS:  00007f254c6ec640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 000000002b4f2000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
