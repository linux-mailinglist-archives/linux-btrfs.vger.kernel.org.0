Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CB6142E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 02:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiKABtZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 21:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiKABtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 21:49:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EBD15833
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 18:49:21 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1Xsl69HgzpVsy;
        Tue,  1 Nov 2022 09:45:47 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 09:49:19 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-btrfs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: Fix uaf of the ulist in test_multiple_refs()
Date:   Tue, 1 Nov 2022 10:53:55 +0800
Message-ID: <20221101025356.1643836-3-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
References: <20221101025356.1643836-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a use-after-free report when do sanity tests:

  BUG: KASAN: use-after-free in ulist_free+0x25/0xa0 [btrfs]
  Read of size 8 at addr ffff888296ab4748 by task insmod/78078

  CPU: 7 PID: 78078 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report+0xb7/0x140
   ulist_free+0x25/0xa0 [btrfs]
   test_multiple_refs.constprop.0+0x411/0x470 [btrfs]
   btrfs_test_qgroups+0x2da/0x300 [btrfs]
   btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
   init_btrfs_fs+0xec/0x154 [btrfs]
   do_one_initcall+0x87/0x2a0
   do_init_module+0xdf/0x320
   load_module+0x3006/0x3390
   __do_sys_finit_module+0x113/0x1b0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Allocated by task 78078:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_kmalloc+0x7a/0x90
   ulist_alloc+0x55/0xe0 [btrfs]
   btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
   test_multiple_refs.constprop.0+0x1e0/0x470 [btrfs]
   btrfs_test_qgroups+0x2da/0x300 [btrfs]
   btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
   init_btrfs_fs+0xec/0x154 [btrfs]
   do_one_initcall+0x87/0x2a0
   do_init_module+0xdf/0x320
   load_module+0x3006/0x3390
   __do_sys_finit_module+0x113/0x1b0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Freed by task 78078:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x40
   ____kasan_slab_free+0x143/0x1b0
   __kmem_cache_free+0xc8/0x330
   btrfs_qgroup_account_extent+0x402/0x770 [btrfs]
   test_multiple_refs.constprop.0+0x243/0x470 [btrfs]
   btrfs_test_qgroups+0x2da/0x300 [btrfs]
   btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
   init_btrfs_fs+0xec/0x154 [btrfs]
   do_one_initcall+0x87/0x2a0
   do_init_module+0xdf/0x320
   load_module+0x3006/0x3390
   __do_sys_finit_module+0x113/0x1b0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

Since the ulist already freed after update the qgroup refcnt, the ulist
should be set to NULL before the next reuse the variable.

Fixes: 442244c96332 ("btrfs: qgroup: Switch self test to extent-oriented qgroup mechanism.")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/btrfs/tests/qgroup-tests.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index eee1e4459541..4172bef5b4a1 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -347,6 +347,9 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
+	old_roots = NULL;
+	new_roots = NULL;
+
 	if (btrfs_verify_qgroup_counts(fs_info, BTRFS_FS_TREE_OBJECTID,
 				       nodesize, nodesize)) {
 		test_err("qgroup counts didn't match expected values");
@@ -380,6 +383,9 @@ static int test_multiple_refs(struct btrfs_root *root,
 		return ret;
 	}
 
+	old_roots = NULL;
+	new_roots = NULL;
+
 	if (btrfs_verify_qgroup_counts(fs_info, BTRFS_FS_TREE_OBJECTID,
 					nodesize, 0)) {
 		test_err("qgroup counts didn't match expected values");
-- 
2.31.1

