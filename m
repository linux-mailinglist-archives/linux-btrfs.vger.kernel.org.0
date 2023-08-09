Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6E477548D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Aug 2023 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjHIH5z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Aug 2023 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjHIH5z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Aug 2023 03:57:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB061736
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Aug 2023 00:57:53 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLMn83GKNzVkSM;
        Wed,  9 Aug 2023 15:55:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 15:57:50 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linux-btrfs@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] btrfs: Use LIST_HEAD to initialize splice
Date:   Wed, 9 Aug 2023 15:57:11 +0800
Message-ID: <20230809075711.1570163-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use LIST_HEAD() to initialize splice instead of open-coding it.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 fs/btrfs/disk-io.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index da51e5750443..89c18ad3f364 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4541,9 +4541,7 @@ static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
 static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&fs_info->ordered_root_lock);
 	list_splice_init(&fs_info->ordered_roots, &splice);
@@ -4649,9 +4647,7 @@ static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 {
 	struct btrfs_inode *btrfs_inode;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&root->delalloc_lock);
 	list_splice_init(&root->delalloc_inodes, &splice);
@@ -4684,9 +4680,7 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 static void btrfs_destroy_all_delalloc_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root;
-	struct list_head splice;
-
-	INIT_LIST_HEAD(&splice);
+	LIST_HEAD(splice);
 
 	spin_lock(&fs_info->delalloc_root_lock);
 	list_splice_init(&fs_info->delalloc_roots, &splice);
-- 
2.34.1

