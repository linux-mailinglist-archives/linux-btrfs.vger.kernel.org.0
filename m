Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A97714CD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjE2PRg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE2PRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5CC9
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F3FC615DD
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79342C4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373440;
        bh=liZg0k6dA9xK9FgwVhiFcWh0ae7z5w7Slls3N/dBNRk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cxWNnT/qsf+0g5kiEY05uz1BvD/STtzPmQFP+FLS9zFg6EBCj5UWhA1DCPKe/FXJw
         BBsi5AVjDrVPvzHSyhhs9GjVfg11EbV+G5Yv6aHQwjEAbtK4Mo4g0MGdZZGLPStnxq
         OS7/JxlPeq93WqY1BrKDfMohZTB5jydKVYs0rgvgn24ZZJE2zWOHOc41xJFenaKTIZ
         8D33eXQ+NmaXvtlXgJiajy9UmXB4DpLHkidSsWZv96/jGKToQ8PAV1KONeytxbFr0o
         WjnK9QjF4vq0QRnQyh0bopVPCfIULl0J4hiSe51xgNSPMfzIevsckpbXKBGIvDCjRF
         2ZvjXur2KI45Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: make insert_delayed_ref() return a bool instead of an int
Date:   Mon, 29 May 2023 16:17:01 +0100
Message-Id: <3913b547b4fb8c1c99cc69e8e489d076c494a49c.1685363099.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685363099.git.fdmanana@suse.com>
References: <cover.1685363099.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

insert_delayed_ref() can only return 0 or 1, to indicate if the given
delayed reference was added to the head reference or if it was merged
into an existing delayed ref, respectively. So just make it return a
boolean instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 0bcec428766c..c3da7c3185de 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -555,16 +555,17 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 /*
  * Helper to insert the ref_node to the tail or merge with tail.
  *
- * Return 0 for insert.
- * Return >0 for merge.
+ * Return false if the ref was inserted.
+ * Return true if the ref was merged into an existing one (and therefore can be
+ * freed by the caller).
  */
-static int insert_delayed_ref(struct btrfs_delayed_ref_root *root,
-			      struct btrfs_delayed_ref_head *href,
-			      struct btrfs_delayed_ref_node *ref)
+static bool insert_delayed_ref(struct btrfs_delayed_ref_root *root,
+			       struct btrfs_delayed_ref_head *href,
+			       struct btrfs_delayed_ref_node *ref)
 {
 	struct btrfs_delayed_ref_node *exist;
 	int mod;
-	int ret = 0;
+	bool ret = false;
 
 	spin_lock(&href->lock);
 	exist = tree_insert(&href->ref_tree, ref);
@@ -572,7 +573,7 @@ static int insert_delayed_ref(struct btrfs_delayed_ref_root *root,
 		goto inserted;
 
 	/* Now we are sure we can merge */
-	ret = 1;
+	ret = true;
 	if (exist->action == ref->action) {
 		mod = ref->ref_mod;
 	} else {
@@ -874,9 +875,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_qgroup_extent_record *record = NULL;
 	bool qrecord_inserted;
 	bool is_system;
+	bool merged;
 	int action = generic_ref->action;
 	int level = generic_ref->tree_ref.level;
-	int ret;
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
@@ -932,7 +933,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
+	merged = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -944,7 +945,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	trace_add_delayed_tree_ref(fs_info, &ref->node, ref,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
-	if (ret > 0)
+	if (merged)
 		kmem_cache_free(btrfs_delayed_tree_ref_cachep, ref);
 
 	if (qrecord_inserted)
@@ -967,7 +968,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_qgroup_extent_record *record = NULL;
 	bool qrecord_inserted;
 	int action = generic_ref->action;
-	int ret;
+	bool merged;
 	u64 bytenr = generic_ref->bytenr;
 	u64 num_bytes = generic_ref->len;
 	u64 parent = generic_ref->parent;
@@ -1024,7 +1025,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	head_ref = add_delayed_ref_head(trans, head_ref, record,
 					action, &qrecord_inserted);
 
-	ret = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
+	merged = insert_delayed_ref(delayed_refs, head_ref, &ref->node);
 	spin_unlock(&delayed_refs->lock);
 
 	/*
@@ -1036,7 +1037,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
 	trace_add_delayed_data_ref(trans->fs_info, &ref->node, ref,
 				   action == BTRFS_ADD_DELAYED_EXTENT ?
 				   BTRFS_ADD_DELAYED_REF : action);
-	if (ret > 0)
+	if (merged)
 		kmem_cache_free(btrfs_delayed_data_ref_cachep, ref);
 
 
-- 
2.34.1

