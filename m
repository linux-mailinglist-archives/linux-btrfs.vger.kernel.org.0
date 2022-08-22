Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C393559BDDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiHVKv7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiHVKvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972B3123C
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6458961000
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC96C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165512;
        bh=/1WURF2Y9G9fQ69S2W9mZ3IrBKFe0uDBOg3UOwjD/2A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a5SIFXq2E9OpqG/cNRf2wN5eScPzGnfvVddcwLkVHfqwzkTv0ytc4qpvrsFVsfswl
         jfGMK3w+0pw1iEs4ORAuviaX/xDj7HfANNEBlbzWsR/fcmNcXD9TWjHfmgV30bZcuJ
         Om/Vv20+tdK2CuApJx5+9ZoJPFHsGC24c1YLzxZOtMHeQjGAgUJZ3teSqk2agLKAxs
         VDePHhNjFPzatuFgJv+Z2nY30R6tp6gtus8ZefLwwTVRjNIMLybwRTf/SlhkHAwYoZ
         Dwuh2HLlKlsHXl4leciUVgFOXy6AiETZNUyje0nAki1ezY9Dt2gfgk5V3LkMU9tC13
         KPGlcjdnxV6Rw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/15] btrfs: avoid memory allocation at log_new_dir_dentries() for common case
Date:   Mon, 22 Aug 2022 11:51:34 +0100
Message-Id: <bc593419a15094dc0ecbcfa5a8c7355b2fdcf585.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
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

