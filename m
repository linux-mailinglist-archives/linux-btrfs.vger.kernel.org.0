Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9176142E3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiKABt1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 21:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKABtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 21:49:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28B315A28
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 18:49:21 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1Xxn5yDNzmV7S;
        Tue,  1 Nov 2022 09:49:17 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 09:49:19 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-btrfs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: Fix ulist memory leak in test_multiple_refs()
Date:   Tue, 1 Nov 2022 10:53:56 +0800
Message-ID: <20221101025356.1643836-4-zhangxiaoxu5@huawei.com>
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

There are some meory leak report when do sanity tests:

  unreferenced object 0xffff888296ab40c0 (size 32):
    comm "insmod", pid 76176, jiffies 4307414230 (age 309.541s)
    hex dump (first 32 bytes):
      01 00 00 00 00 00 00 00 90 8a b1 30 81 88 ff ff  ...........0....
      90 8a b1 30 81 88 ff ff a0 8a b1 30 81 88 ff ff  ...0.......0....
    backtrace:
      [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
      [<00000000836cc910>] ulist_alloc+0x55/0xe0 [btrfs]
      [<00000000eb3781d2>] btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
      [<00000000c7fe3cc7>] test_no_shared_qgroup.constprop.0+0x1f2/0x350 [btrfs]
      [<00000000f6a6b761>] btrfs_test_qgroups+0x2c8/0x300 [btrfs]
      [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
      [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
      [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
      [<00000000c5ed267e>] do_init_module+0xdf/0x320
      [<000000005f972694>] load_module+0x3006/0x3390
      [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
      [<00000000e7029c2b>] do_syscall_64+0x35/0x80
      [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
  unreferenced object 0xffff888130b18a80 (size 64):
    comm "insmod", pid 76176, jiffies 4307414230 (age 309.542s)
    hex dump (first 32 bytes):
      05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      c8 40 ab 96 82 88 ff ff c8 40 ab 96 82 88 ff ff  .@.......@......
    backtrace:
      [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
      [<00000000de27bc34>] ulist_add_merge.part.0+0x67/0x1f0 [btrfs]
      [<00000000fbdf3c21>] find_parent_nodes+0xd49/0x2880 [btrfs]
      [<00000000ba4d2155>] btrfs_find_all_roots_safe+0x120/0x1c0 [btrfs]
      [<00000000c7fe3cc7>] test_no_shared_qgroup.constprop.0+0x1f2/0x350 [btrfs]
      [<00000000f6a6b761>] btrfs_test_qgroups+0x2c8/0x300 [btrfs]
      [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
      [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
      [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
      [<00000000c5ed267e>] do_init_module+0xdf/0x320
      [<000000005f972694>] load_module+0x3006/0x3390
      [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
      [<00000000e7029c2b>] do_syscall_64+0x35/0x80
      [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
  unreferenced object 0xffff88812ae83100 (size 32):
    comm "insmod", pid 77664, jiffies 4307625383 (age 98.396s)
    hex dump (first 32 bytes):
      01 00 00 00 00 00 00 00 10 f7 7e 23 81 88 ff ff  ..........~#....
      10 f7 7e 23 81 88 ff ff 20 f7 7e 23 81 88 ff ff  ..~#.... .~#....
    backtrace:
      [<00000000e59989d0>] kmalloc_trace+0x27/0xa0
      [<00000000836cc910>] ulist_alloc+0x55/0xe0 [btrfs]
      [<00000000eb3781d2>] btrfs_find_all_roots_safe+0x9d/0x1c0 [btrfs]
      [<00000000cacfcca2>] test_multiple_refs.constprop.0+0x1e0/0x470 [btrfs]
      [<000000008613167f>] btrfs_test_qgroups+0x2da/0x300 [btrfs]
      [<0000000047d4f295>] btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
      [<00000000b09fac49>] init_btrfs_fs+0xec/0x154 [btrfs]
      [<000000002925cdf3>] do_one_initcall+0x87/0x2a0
      [<00000000c5ed267e>] do_init_module+0xdf/0x320
      [<000000005f972694>] load_module+0x3006/0x3390
      [<0000000070c88d9a>] __do_sys_finit_module+0x113/0x1b0
      [<00000000e7029c2b>] do_syscall_64+0x35/0x80
      [<000000008ffc1dab>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Let's free the ulist memory when the no shared qgroup tests finish.

Fixes: 442244c96332 ("btrfs: qgroup: Switch self test to extent-oriented qgroup mechanism.")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/btrfs/tests/qgroup-tests.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 4172bef5b4a1..043b139cfb8c 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -266,8 +266,10 @@ static int test_no_shared_qgroup(struct btrfs_root *root,
 	}
 
 	ret = remove_extent_item(root, nodesize, nodesize);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return -EINVAL;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -329,8 +331,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = insert_normal_tree_ref(root, nodesize, nodesize, 0,
 				BTRFS_FS_TREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -365,8 +369,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = add_tree_ref(root, nodesize, nodesize, 0,
 			BTRFS_FIRST_FREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
@@ -407,8 +413,10 @@ static int test_multiple_refs(struct btrfs_root *root,
 
 	ret = remove_extent_ref(root, nodesize, nodesize, 0,
 				BTRFS_FIRST_FREE_OBJECTID);
-	if (ret)
+	if (ret) {
+		ulist_free(old_roots);
 		return ret;
+	}
 
 	ret = btrfs_find_all_roots(&trans, fs_info, nodesize, 0, &new_roots, false);
 	if (ret) {
-- 
2.31.1

