Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87C7612982
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Oct 2022 10:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJ3Jhk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Oct 2022 05:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Jhj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Oct 2022 05:37:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DC4C4C;
        Sun, 30 Oct 2022 02:37:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z97so13636201ede.8;
        Sun, 30 Oct 2022 02:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/hwiuCOoze5MBJHlgoRKvMktr+mDhmLrvDk3mUFONdU=;
        b=ckCiSQ1eGLiGsH2cUKYiXaXygupPq846v3jcOSm3g2/A0PtMr4T9hGIeywUK2z5WV9
         d/lYMTigKKRSIX/8Yh1oQt9qNvk2+HIryuVu5dKxp5BHF5ttdVKqUOFM3lZzQrmcQYxl
         MIsP9zKESg2+hST9ZWvMG/3tGca8Mu/SHEMYnABXd6qB2Q+uBnSWJCcQNU1y5ZqBCjfy
         8ErKa8swl6NtHL0GvsOSCGEQFnA4lE9A1ZRXr4zL47o/geOg1/Ol7NsUH3z3+LeDlsYt
         qrRbNJgMOhTq+G25t09bVcPK5whthi25a+lN5hlwQV5xgGTWPXGUPp2zuQk6sio1Xkmq
         pcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hwiuCOoze5MBJHlgoRKvMktr+mDhmLrvDk3mUFONdU=;
        b=FYKwREn6df+N+R+6P4alHTfNWj22ZjTWOdNWKqY0U4vVShVJY7i2LW89Y3uXdMqfwR
         gGtxgLttRykeOwV4g30jSMBxP0srKnW0OLwaTk5w8zReEJWN5LqbErLlAfTKwkEvYkSg
         M7xU8z/ANVCYw22yGzIHcnSyNxpHBppe61XU8Febp/SGI7yhEo1KiUd8DkOckRhEXBd2
         MXz8gIm9ZlZzQSOAhLbTm2VoCWrpjUyZfI9OnLNV9YrNYMzNpCh7Mz6btSYC87bqb4jC
         YbkVNLJKsa6hgBaaFULeSilwiSFwMg+4CplD8aco1XEazT9cvRipLhr+Pc9Ir4t9jFV3
         gTjg==
X-Gm-Message-State: ACrzQf3Pwg2Ut45UwiNTvymaYVUc51kPoe4OzHu79raRNwAWkN43dKu+
        5VPMdEkVE0AhKSM/HlJrgq5fu/XjaNifAwh46gjwaqlwgS3Tpg==
X-Google-Smtp-Source: AMsMyM6KQmew4Cp5SnTJblk3Kus7S2IviuQiJl0RhIXggqulfKXCt7q0cr/UtDrvA6QKKq40vjgF4XOJY1leIzl6lqQ=
X-Received: by 2002:aa7:c14b:0:b0:461:c47d:48cf with SMTP id
 r11-20020aa7c14b000000b00461c47d48cfmr7752270edp.83.1667122656803; Sun, 30
 Oct 2022 02:37:36 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:37:00 +0800
Message-ID: <CAO4mrfcorHn-uTvjLUWyfMB6XhMBa6X=M3h-eCexRo0Lw8SLSQ@mail.gmail.com>
Subject: possible deadlock in btrfs_chunk_alloc
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/16S-XGN2bCukp9yV3RX3yA4HSLMhaRXn0/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

loop0: detected capacity change from 0 to 264192
======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc5 #1 Not tainted
------------------------------------------------------
syz-executor.0/3767 is trying to acquire lock:
ffff8880171388c8 (&fs_info->chunk_mutex){+.+.}-{3:3}, at:
btrfs_chunk_alloc+0x1d1/0x8c0

but task is already holding lock:
ffff888013a947b8 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_lock+0x2e/0x210

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (btrfs-chunk-00){++++}-{3:3}:
       down_read_nested+0x3e/0x150
       __btrfs_tree_read_lock+0x2e/0x210
       btrfs_read_lock_root_node+0x4f/0x230
       btrfs_search_slot+0xb0c/0x1310
       btrfs_update_device+0x7a/0x1f0
       btrfs_chunk_alloc_add_chunk_item+0x14e/0x520
       btrfs_chunk_alloc+0x4ff/0x8c0
       find_free_extent+0x1a67/0x25a0
       btrfs_reserve_extent+0xe2/0x280
       btrfs_alloc_tree_block+0x103/0x700
       __btrfs_cow_block+0x1bc/0x900
       btrfs_cow_block+0x159/0x3d0
       btrfs_search_slot+0x93b/0x1310
       btrfs_insert_empty_items+0x8a/0x110
       btrfs_insert_empty_inode+0x61/0x90
       create_reloc_inode.isra.34+0x1d3/0x590
       btrfs_relocate_block_group+0x1af/0x520
       btrfs_relocate_chunk+0x46/0x190
       btrfs_balance+0x12d3/0x1f40
       btrfs_ioctl_balance+0x41a/0x530
       btrfs_ioctl+0x1230/0x4520
       __x64_sys_ioctl+0xe8/0x140
       do_syscall_64+0x34/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&fs_info->chunk_mutex){+.+.}-{3:3}:
       __lock_acquire+0x126a/0x1d60
       lock_acquire+0xd7/0x330
       __mutex_lock+0x96/0x9a0
       btrfs_chunk_alloc+0x1d1/0x8c0
       find_free_extent+0x1a67/0x25a0
       btrfs_reserve_extent+0xe2/0x280
       btrfs_alloc_tree_block+0x103/0x700
       __btrfs_cow_block+0x1bc/0x900
       btrfs_cow_block+0x159/0x3d0
       btrfs_search_slot+0x93b/0x1310
       relocate_tree_blocks+0x7e6/0xad0
       relocate_block_group+0x223/0x620
       btrfs_relocate_block_group+0x289/0x520
       btrfs_relocate_chunk+0x46/0x190
       btrfs_balance+0x12d3/0x1f40
       btrfs_ioctl_balance+0x41a/0x530
       btrfs_ioctl+0x1230/0x4520
       __x64_sys_ioctl+0xe8/0x140
       do_syscall_64+0x34/0xb0
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-chunk-00);
                               lock(&fs_info->chunk_mutex);
                               lock(btrfs-chunk-00);
  lock(&fs_info->chunk_mutex);

 *** DEADLOCK ***

5 locks held by syz-executor.0/3767:
 #0: ffff888013cf7460 (sb_writers#18){.+.+}-{0:0}, at:
btrfs_ioctl_balance+0x57/0x530
 #1: ffff88801713a098 (&fs_info->reclaim_bgs_lock){+.+.}-{3:3}, at:
btrfs_balance+0xd85/0x1f40
 #2: ffff888017138838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at:
btrfs_relocate_block_group+0x281/0x520
 #3: ffff888013cf7650 (sb_internal#2){.+.+}-{0:0}, at:
relocate_block_group+0xd0/0x620
 #4: ffff888013a947b8 (btrfs-chunk-00){++++}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x210

stack backtrace:
CPU: 0 PID: 3767 Comm: syz-executor.0 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack_lvl+0xcd/0x134
 check_noncircular+0xfe/0x110
 __lock_acquire+0x126a/0x1d60
 lock_acquire+0xd7/0x330
 __mutex_lock+0x96/0x9a0
 btrfs_chunk_alloc+0x1d1/0x8c0
 find_free_extent+0x1a67/0x25a0
 btrfs_reserve_extent+0xe2/0x280
 btrfs_alloc_tree_block+0x103/0x700
 __btrfs_cow_block+0x1bc/0x900
 btrfs_cow_block+0x159/0x3d0
 btrfs_search_slot+0x93b/0x1310
 relocate_tree_blocks+0x7e6/0xad0
 relocate_block_group+0x223/0x620
 btrfs_relocate_block_group+0x289/0x520
 btrfs_relocate_chunk+0x46/0x190
 btrfs_balance+0x12d3/0x1f40
 btrfs_ioctl_balance+0x41a/0x530
 btrfs_ioctl+0x1230/0x4520
 __x64_sys_ioctl+0xe8/0x140
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4692c9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde662c7c38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004692c9
RDX: 0000000000000000 RSI: 00000000c4009420 RDI: 0000000000000005
RBP: 000000000119bfb0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119bfac
R13: 0000000000000000 R14: 000000000119bfa0 R15: 00007ffe41266cf0

Best,
Wei
