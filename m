Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B34457D2F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Nov 2021 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhKTKuX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Nov 2021 05:50:23 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43674 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhKTKuW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Nov 2021 05:50:22 -0500
Received: by mail-io1-f72.google.com with SMTP id j13-20020a0566022ccd00b005e9684c80c6so7339301iow.10
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Nov 2021 02:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MJjI4cvN/BPhkXjmQc2rFZTbU8bkZhZ+sZ8+470Z8vU=;
        b=ivDGjbuGsCJOXM3B48QS9HVKcBFqlrd5SzTgXO+s4EqiOnM80hbI7aW4uoF4Z6e3xE
         gVhn2UEVA01KRQnBM3ZznpkXm+XG88yvOIzfxyr3b593LTSOgvnA6kpQCxP06VoGfWHo
         mhQ8vtweo48Qn9afx3Q/tXSWU0GOSLGC7NgMrwFJQm0zQWKdmsOR5brdxlngB6inQOrN
         HCVngkePUaYl1aYULgdXYLuWce505wDQEascWwifIsH+85R2cgcKlm0PPWU8lEBQVNdD
         pdzLTNp76mYH1k8/HJGawK4eSNI/0SVOZGjH6Ti+surQPniWOOnKnQmCctKVNTEoveq5
         zE0A==
X-Gm-Message-State: AOAM531HwAdFBILMqKxLj2Tg9KRfG6ByfpQrq0+9gIWPikuxuUoRrSdw
        lCp4ZHixifzPp+6XOmVUlp20hFNvWk86Io0N0LehPoFcRjGQ
X-Google-Smtp-Source: ABdhPJyxM+6jI1sEWhP32bX3K0Krcan5uTMiVImWtryPyi1enEpO9sQAeYABduZcxUPzKh6lCLGNc5VJRRGFWhchHQQQ+j+Ngbz5
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1d0:: with SMTP id w16mr10492401iot.140.1637405239303;
 Sat, 20 Nov 2021 02:47:19 -0800 (PST)
Date:   Sat, 20 Nov 2021 02:47:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a4618905d1361d3e@google.com>
Subject: [syzbot] KMSAN: uninit-value in btrfs_clean_tree_block (2)
From:   syzbot <syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, glider@google.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    412af9cd936d ioremap.c: move an #include around
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14365606b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
dashboard link: https://syzkaller.appspot.com/bug?extid=fba8e2116a12609b6c59
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fba8e2116a12609b6c59@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in btrfs_clean_tree_block+0x2c3/0x370 fs/btrfs/disk-io.c:1126
 btrfs_clean_tree_block+0x2c3/0x370 fs/btrfs/disk-io.c:1126
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4741 [inline]
 btrfs_alloc_tree_block+0x745/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 commit_cowonly_roots+0x1c5/0x14c0 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 commit_cowonly_roots+0x1c5/0x14c0 fs/btrfs/transaction.c:1241
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_clean_tree_block+0x2c3/0x370 fs/btrfs/disk-io.c:1126
 btrfs_clean_tree_block+0x2c3/0x370 fs/btrfs/disk-io.c:1126
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4741 [inline]
 btrfs_alloc_tree_block+0x745/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:627 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:603 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x805/0xc30 fs/btrfs/ctree.c:777
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:627 [inline]
 comp_keys fs/btrfs/ctree.c:603 [inline]
 generic_bin_search+0x805/0xc30 fs/btrfs/ctree.c:777
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:627 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:603 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x805/0xc30 fs/btrfs/ctree.c:777
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:627 [inline]
 comp_keys fs/btrfs/ctree.c:603 [inline]
 generic_bin_search+0x805/0xc30 fs/btrfs/ctree.c:777
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:631 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:603 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x87d/0xc30 fs/btrfs/ctree.c:777
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:631 [inline]
 comp_keys fs/btrfs/ctree.c:603 [inline]
 generic_bin_search+0x87d/0xc30 fs/btrfs/ctree.c:777
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:633 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:603 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x896/0xc30 fs/btrfs/ctree.c:777
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:633 [inline]
 comp_keys fs/btrfs/ctree.c:603 [inline]
 generic_bin_search+0x896/0xc30 fs/btrfs/ctree.c:777
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in btrfs_comp_cpu_keys fs/btrfs/ctree.c:635 [inline]
BUG: KMSAN: uninit-value in comp_keys fs/btrfs/ctree.c:603 [inline]
BUG: KMSAN: uninit-value in generic_bin_search+0x8d0/0xc30 fs/btrfs/ctree.c:777
 btrfs_comp_cpu_keys fs/btrfs/ctree.c:635 [inline]
 comp_keys fs/btrfs/ctree.c:603 [inline]
 generic_bin_search+0x8d0/0xc30 fs/btrfs/ctree.c:777
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in generic_bin_search+0x8e8/0xc30 fs/btrfs/ctree.c:779
 generic_bin_search+0x8e8/0xc30 fs/btrfs/ctree.c:779
 btrfs_search_slot+0x1f12/0x3de0 fs/btrfs/ctree.c:1816
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in update_dev_stat_item fs/btrfs/volumes.c:7723 [inline]
BUG: KMSAN: uninit-value in btrfs_run_dev_stats+0xa6d/0x1350 fs/btrfs/volumes.c:7792
 update_dev_stat_item fs/btrfs/volumes.c:7723 [inline]
 btrfs_run_dev_stats+0xa6d/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6663 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 check_eb_range fs/btrfs/extent_io.c:6663 [inline]
 write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xbfe/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xbfe/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xbfe/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6663 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 check_eb_range fs/btrfs/extent_io.c:6663 [inline]
 write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xcb1/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xcb1/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xcb1/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in check_eb_range fs/btrfs/extent_io.c:6663 [inline]
BUG: KMSAN: uninit-value in write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 check_eb_range fs/btrfs/extent_io.c:6663 [inline]
 write_extent_buffer+0x54b/0xf20 fs/btrfs/extent_io.c:6824
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xd61/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 write_extent_buffer+0x5a8/0xf20 fs/btrfs/extent_io.c:6830
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xd61/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inline]
 btrfs_run_dev_stats+0x449/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
=====================================================
=====================================================
BUG: KMSAN: uninit-value in write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 write_extent_buffer+0xece/0xf20 fs/btrfs/extent_io.c:6829
 btrfs_set_dev_stats_value fs/btrfs/volumes.c:7615 [inline]
 update_dev_stat_item fs/btrfs/volumes.c:7752 [inline]
 btrfs_run_dev_stats+0xd61/0x1350 fs/btrfs/volumes.c:7792
 commit_cowonly_roots+0x2ef/0x14c0 fs/btrfs/transaction.c:1249
 btrfs_commit_transaction+0x1d8a/0x4b10 fs/btrfs/transaction.c:2288
 btrfs_commit_super+0x1b7/0x1f0 fs/btrfs/disk-io.c:4303
 close_ctree+0x4e4/0xfbd fs/btrfs/disk-io.c:4370
 btrfs_put_super+0x53/0x70 fs/btrfs/super.c:340
 generic_shutdown_super+0x2bb/0x660 fs/super.c:465
 kill_anon_super+0x63/0xb0 fs/super.c:1057
 btrfs_kill_super+0x61/0x90 fs/btrfs/super.c:2348
 deactivate_locked_super+0x10d/0x1e0 fs/super.c:335
 deactivate_super+0x19e/0x1a0 fs/super.c:366
 cleanup_mnt+0x797/0x870 fs/namespace.c:1137
 __cleanup_mnt+0x3b/0x50 fs/namespace.c:1144
 task_work_run+0x1f0/0x2c0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop+0x3fc/0x490 kernel/entry/common.c:176
 exit_to_user_mode_prepare kernel/entry/common.c:208 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x80/0xc0 kernel/entry/common.c:302
 __do_fast_syscall_32+0xa5/0xf0 arch/x86/entry/common.c:183
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Uninit was created at:
 __alloc_pages+0x8b3/0xfb0 mm/page_alloc.c:5422
 alloc_pages+0xa39/0xde0 mm/mempolicy.c:2191
 __page_cache_alloc mm/filemap.c:1022 [inline]
 pagecache_get_page+0x1384/0x1ec0 mm/filemap.c:1940
 find_or_create_page include/linux/pagemap.h:420 [inline]
 alloc_extent_buffer+0x8c5/0x3420 fs/btrfs/extent_io.c:6124
 btrfs_find_create_tree_block+0xb2/0xd0 fs/btrfs/disk-io.c:1090
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:4717 [inline]
 btrfs_alloc_tree_block+0x507/0x20c0 fs/btrfs/extent-tree.c:4818
 __btrfs_cow_block+0x823/0x2490 fs/btrfs/ctree.c:415
 btrfs_cow_block+0xa4a/0xc80 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x1933/0x3de0 fs/btrfs/ctree.c:1768
 update_dev_stat_item fs/btrfs/volumes.c:7715 [inlin

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
