Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D145977B184
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 08:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjHNGYP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 02:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjHNGYI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 02:24:08 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AF6E63;
        Sun, 13 Aug 2023 23:24:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so59499831fa.2;
        Sun, 13 Aug 2023 23:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691994245; x=1692599045;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4f/br1kEgPXGLDjaFc3DMuIfQEl8THKzsVSuhxAFsk=;
        b=G0fyKqqvZj6yvvP+NQWRub62Yp68biFPsbjMhQtNZSS0mZVDJ91bQVK6ugW4sTBXfz
         HNwUMGWT5Y4KKyIkz5ZKl/sUgfu8KUFqavtSAQWw44kdTeAufpc1sl6zbiTY4rX6moM0
         nvdQigPlFDSKA61tHP9ny/oFIWn7eZJqfAro6MS3HVwgCyqAF6tsP8MtvHBLLlafu4mE
         q75SB/YJA4IJIJ/brBhuC/E/2aklfrlfYCK7XiEBQNy6oWkYRIM4kbgx5VZ2SiqpumDf
         DToUFpn+3Ixk05Dd6LtDl6bypE+zXdfFv0wLwsYNT6BmsZdTR33dAWz6tufiW0xF0YTI
         V13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691994245; x=1692599045;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4f/br1kEgPXGLDjaFc3DMuIfQEl8THKzsVSuhxAFsk=;
        b=fq6LvMWs+zH4zMhAhv8EbF1R1IsDtSD/+bJ6EUm+LmrRuUw32HSFqHwPCxvEuyU0jw
         p6P2YA7eldy++a45TMswirEDxl9lHVjVOqh2Mxp9W31b9I7reSvQ22v10vDxMlMc+mbe
         UtUfDD1oMYOFEAearoght1JujjZRgvpkgQ42m5qgrb2DqLtWU7GYSgjJTsnF1xJRb274
         Db1d1CIupoBv3sWkDSbU5uOm6unb1eldPwRELDmTlAeUXpe1Rlyu1f5N3n19sm1dhK7i
         YBjuUQlL3xMvczqF5zDmdBRKWDwjX0/otmwqQcezTwEDYaFV5S+2fGI8OR9bQzMFuMrv
         1KhQ==
X-Gm-Message-State: AOJu0YxPem+xS+8MMcLfaHmSZxpQYtLPtxCXc3FpSWxvbglvjJ44C+b5
        AuecN+mlahnOAJUDQmx+uAhmf/ugkSWcHuFHhZc=
X-Google-Smtp-Source: AGHT+IHyg2USMBzckv0yrJlzr6B1qmN4GjU4sPu0joKWEQ/3xGSXMBiwh9EY6C9uyKl+xOxiSDbJlgrb7GgDQrDd9uk=
X-Received: by 2002:a2e:6a13:0:b0:2b6:e2e4:7d9a with SMTP id
 f19-20020a2e6a13000000b002b6e2e47d9amr5957690ljc.38.1691994244422; Sun, 13
 Aug 2023 23:24:04 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Mon, 14 Aug 2023 14:23:53 +0800
Message-ID: <CALcu4rZGym6uSKJqgMJpSmGgiGX=8sHRrukqR85VCiEPDFddkA@mail.gmail.com>
Subject: kernel BUG in set_state_bits
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
https://drive.google.com/file/d/1KuE7x7TW_pt_aNWWr2GAdehfYixsgeOO/view?usp=drive_link
kernel config:https://drive.google.com/file/d/1b_em6R2Zl98np83b818BzE1FrxbiaGuh/view?usp=drive_link
C reproducer:https://drive.google.com/file/d/1HlzFbWr3wqzlLi8I2_ZCQumS71WDLXj1/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/1Bu70LrWxOzsbkilELLuxo8VnjcAFiH1Y/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>


memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=8428 'syz-executor'
loop1: detected capacity change from 0 to 32768
BTRFS: device fsid 84eb0a0b-d357-4bc1-8741-9d3223c15974 devid 1
transid 7 /dev/loop1 scanned by syz-executor (8428)
BTRFS info (device loop1): using xxhash64 (xxhash64-generic) checksum algorithm
BTRFS info (device loop1): disk space caching is enabled
BTRFS info (device loop1): enabling ssd optimizations
BTRFS info (device loop1): auto enabling async discard
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 1
CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
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
 set_state_bits.isra.0+0x11f/0x1c0 fs/btrfs/extent-io-tree.c:378
 insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
 __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
 set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
 qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
 btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
 btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
 btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
 btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
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
RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:379!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:379
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
 __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
 set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
 qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
 btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
 btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
 btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
 btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
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
RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:379
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554


invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8428 Comm: syz-executor Not tainted 6.5.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:379
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
 __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
 set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
 qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
 btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
 btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
 btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
 btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
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
RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:379
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554

RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 insert_state_fast fs/btrfs/extent-io-tree.c:437 [inline]
 __set_extent_bit+0x418/0x15b0 fs/btrfs/extent-io-tree.c:1034
 set_record_extent_bits+0x53/0x90 fs/btrfs/extent-io-tree.c:1705
 qgroup_reserve_data+0x233/0xa80 fs/btrfs/qgroup.c:3800
 btrfs_qgroup_reserve_data+0x2b/0xc0 fs/btrfs/qgroup.c:3843
 btrfs_check_data_free_space+0x114/0x290 fs/btrfs/delalloc-space.c:154
 btrfs_buffered_write+0x4ec/0x1330 fs/btrfs/file.c:1250
 btrfs_do_write_iter+0xb75/0x11c0 fs/btrfs/file.c:1670
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
RSP: 002b:00007f4717e0f068 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 000000000047959d
RDX: 0000000000000027 RSI: 0000000020005840 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 000000000059c0ac
R13: 000000000000000b R14: 0000000000437250 R15: 00007f4717def000
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:379
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 be 72 f7 fd 44 89 e0 44
09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 a5 72 f7 fd <0f> 0b
4c 89 ef e8 8b 3d 47 fe e9 e6 fe ff ff 4c 89 ef e8 7e 3d 47
RSP: 0018:ffffc9000675f850 EFLAGS: 00010212
RAX: 000000000003f702 RBX: ffff88802100cc00 RCX: ffffc90002e49000
RDX: 0000000000040000 RSI: ffffffff8388e7eb RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000032343854 R12: 0000000000000800
R13: ffff88802100cc7c R14: 0000000000000fff R15: 0000000000000000
FS:  00007f4717e0f640(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000505c10 CR3: 0000000018d77000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
