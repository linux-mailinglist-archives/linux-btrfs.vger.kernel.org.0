Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E6C6142E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 02:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKABt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 21:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKABtW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 21:49:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24DF15834
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 18:49:21 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1Xsl3PRBzpVjJ;
        Tue,  1 Nov 2022 09:45:47 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 09:49:18 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-btrfs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: Fix wrong check in btrfs_free_dummy_root()
Date:   Tue, 1 Nov 2022 10:53:54 +0800
Message-ID: <20221101025356.1643836-2-zhangxiaoxu5@huawei.com>
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

The btrfs_alloc_dummy_root() use ERR_PTR as the error return value
rather than NULL, if error happened, there will be a null-ptr-deref
when free the dummy root:

  BUG: KASAN: null-ptr-deref in btrfs_free_dummy_root+0x21/0x50 [btrfs]
  Read of size 8 at addr 000000000000002c by task insmod/258926

  CPU: 2 PID: 258926 Comm: insmod Tainted: G        W          6.1.0-rc2+ #5
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   kasan_report+0xb7/0x140
   kasan_check_range+0x145/0x1a0
   btrfs_free_dummy_root+0x21/0x50 [btrfs]
   btrfs_test_free_space_cache+0x1a8c/0x1add [btrfs]
   btrfs_run_sanity_tests+0x65/0x80 [btrfs]
   init_btrfs_fs+0xec/0x154 [btrfs]
   do_one_initcall+0x87/0x2a0
   do_init_module+0xdf/0x320
   load_module+0x3006/0x3390
   __do_sys_finit_module+0x113/0x1b0
   do_syscall_64+0x35/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: aaedb55bc08f ("Btrfs: add tests for btrfs_get_extent")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/btrfs/tests/btrfs-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 9c478fa256f6..d43cb5242fec 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -200,7 +200,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 
 void btrfs_free_dummy_root(struct btrfs_root *root)
 {
-	if (!root)
+	if (IS_ERR_OR_NULL(root))
 		return;
 	/* Will be freed by btrfs_free_fs_roots */
 	if (WARN_ON(test_bit(BTRFS_ROOT_IN_RADIX, &root->state)))
-- 
2.31.1

