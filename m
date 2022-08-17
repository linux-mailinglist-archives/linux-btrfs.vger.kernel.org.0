Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87A596D7D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiHQLXD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbiHQLXC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:23:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FF6E2EA
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:23:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 276EFB81CC2
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6745BC433D7
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735378;
        bh=/1WURF2Y9G9fQ69S2W9mZ3IrBKFe0uDBOg3UOwjD/2A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uWC25OdhyTDWvEFcCq858yb1TIAZ+3EAKkJHppNt9FObdelmAZWmdqaWgzCd4EoyW
         zqJL3OZG0skqtQEo3lFlg69SQ1CZdLvLAmZadrmkyKgskMUZBtsX+OIzHdGvndjejh
         vtrf7t4MSfHEjW7O+usdc4Es1l/bm4nm+4MgIUvNVuxCNK5uDPi7BK1MQPCNHTMeJD
         WORU94Tg8+JZjteI9ZQEZiQHE/38mmoG9sbz8W/JtVYEFL/mFbuy4uaiFSi/uxT/AM
         MGL40F8ANML5ANayMMzB1Jo1opSaHva9va2qqUUhb8tr4KWLUgpo+xK42RVxpDBJu7
         UHsgbgoiepNcg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/15] btrfs: avoid memory allocation at log_new_dir_dentries() for common case
Date:   Wed, 17 Aug 2022 12:22:38 +0100
Message-Id: <40fb8d577df3c5473b0316e78c3c0070786a1d37.1660735025.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At log_new_dir_dentries() we always start by allocating a list element
for the starting inode and then do a while loop with the condition being
a list emptiness check.

This however is not needed, we can avoid allocating this initial list
element and then just check for the list emptiness at the end of the
loop's body. So just do that to save one memory allocation from the
kmalloc-32 slab.

This allows for not doing any memory allocation when we don't have any
subdirectory to log, which is a very common case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index bd50509e9839..94026098bb68 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5977,6 +5977,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	LIST_HEAD(dir_list);
 	struct btrfs_dir_list *dir_elem;
+	u64 ino = btrfs_ino(start_inode);
 	int ret = 0;
 
 	/*
@@ -5991,28 +5992,13 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 	if (!path)
 		return -ENOMEM;
 
-	dir_elem = kmalloc(sizeof(*dir_elem), GFP_NOFS);
-	if (!dir_elem) {
-		btrfs_free_path(path);
-		return -ENOMEM;
-	}
-	dir_elem->ino = btrfs_ino(start_inode);
-	list_add_tail(&dir_elem->list, &dir_list);
-
-	while (!list_empty(&dir_list)) {
+	while (true) {
 		struct extent_buffer *leaf;
 		struct btrfs_key min_key;
-		u64 ino;
 		bool continue_curr_inode = true;
 		int nritems;
 		int i;
 
-		dir_elem = list_first_entry(&dir_list, struct btrfs_dir_list,
-					    list);
-		ino = dir_elem->ino;
-		list_del(&dir_elem->list);
-		kfree(dir_elem);
-
 		min_key.objectid = ino;
 		min_key.type = BTRFS_DIR_INDEX_KEY;
 		min_key.offset = 0;
@@ -6023,7 +6009,7 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			break;
 		} else if (ret > 0) {
 			ret = 0;
-			continue;
+			goto next;
 		}
 
 		leaf = path->nodes[0];
@@ -6086,6 +6072,15 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
 			min_key.offset++;
 			goto again;
 		}
+
+next:
+		if (list_empty(&dir_list))
+			break;
+
+		dir_elem = list_first_entry(&dir_list, struct btrfs_dir_list, list);
+		ino = dir_elem->ino;
+		list_del(&dir_elem->list);
+		kfree(dir_elem);
 	}
 out:
 	btrfs_free_path(path);
-- 
2.35.1

