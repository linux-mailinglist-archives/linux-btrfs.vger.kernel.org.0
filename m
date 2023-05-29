Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9664714CD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 May 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjE2PRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 May 2023 11:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjE2PRZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 May 2023 11:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45CACF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 08:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A253615AF
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54030C4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 29 May 2023 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685373442;
        bh=63t7aAH+6PgEfoT27gIQNK1ccZQyKJ834QwBTcVgvr4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bjFvaAXO8sWoRpckxoNTm4miZZROMwZfFR/Kf2ppEeMmQ5Boi8Vhmw2URqUoerfbb
         ehgVqBGvbcYU3c/ohY0FeUYMq8UeXRwa9wgYwgQoVxVmi6ERpriyp+M/jN8rDuAFBS
         wFNqmteYrQSDl9SlAhVaBQYvZy2b8wPUiP6iwXdnV9Kpuk1Eobv9eP7JiSaRDixEJ5
         bzWXSS45VqvgUSeDq6I43vfLbl23tWjzyBkBCZRKrkSN1cmcxrpDdwho0LDJX0CVSR
         mK/0Ir9y/fu4VUfAMXOVTjJ+x++K5jPbLZA6MmBFdhxhXXoXekZ8cwGBWctEP1EQls
         uFshbgrXHpb0w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: use bool type for delayed ref head fields that are used as booleans
Date:   Mon, 29 May 2023 16:17:04 +0100
Message-Id: <52be0d3f3d1e7ae93770c95099c2fcf00f151747.1685363099.git.fdmanana@suse.com>
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

There's no point in have several fields defined as 1 bit unsigned int in
struct btrfs_delayed_ref_head, we can instead use a bool type, it makes
the code a bit more readable and it doesn't change the structure size.
So switch them to proper booleans.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 12 ++++++------
 fs/btrfs/delayed-ref.h |  8 ++++----
 fs/btrfs/extent-tree.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index c61af9012a82..bf8c2ac6c95e 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -531,7 +531,7 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 				href_node);
 	}
 
-	head->processing = 1;
+	head->processing = true;
 	WARN_ON(delayed_refs->num_heads_ready == 0);
 	delayed_refs->num_heads_ready--;
 	delayed_refs->run_delayed_start = head->bytenr +
@@ -549,7 +549,7 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 	RB_CLEAR_NODE(&head->href_node);
 	atomic_dec(&delayed_refs->num_entries);
 	delayed_refs->num_heads--;
-	if (head->processing == 0)
+	if (!head->processing)
 		delayed_refs->num_heads_ready--;
 }
 
@@ -697,7 +697,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 				  bool is_system)
 {
 	int count_mod = 1;
-	int must_insert_reserved = 0;
+	bool must_insert_reserved = false;
 
 	/* If reserved is provided, it must be a data extent. */
 	BUG_ON(!is_data && reserved);
@@ -722,9 +722,9 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	 * BTRFS_ADD_DELAYED_REF because other special casing is not required.
 	 */
 	if (action == BTRFS_ADD_DELAYED_EXTENT)
-		must_insert_reserved = 1;
+		must_insert_reserved = true;
 	else
-		must_insert_reserved = 0;
+		must_insert_reserved = false;
 
 	refcount_set(&head_ref->refs, 1);
 	head_ref->bytenr = bytenr;
@@ -736,7 +736,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->ref_tree = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&head_ref->ref_add_list);
 	RB_CLEAR_NODE(&head_ref->href_node);
-	head_ref->processing = 0;
+	head_ref->processing = false;
 	head_ref->total_ref_mod = count_mod;
 	spin_lock_init(&head_ref->lock);
 	mutex_init(&head_ref->mutex);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 9b103bf27185..b8e14b0ba5f1 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -116,10 +116,10 @@ struct btrfs_delayed_ref_head {
 	 * we need to update the in ram accounting to properly reflect
 	 * the free has happened.
 	 */
-	unsigned int must_insert_reserved:1;
-	unsigned int is_data:1;
-	unsigned int is_system:1;
-	unsigned int processing:1;
+	bool must_insert_reserved;
+	bool is_data;
+	bool is_system;
+	bool processing;
 };
 
 struct btrfs_delayed_tree_ref {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0aa775ac31e4..ffd4198c19b0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1497,7 +1497,7 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
-				int insert_reserved)
+				bool insert_reserved)
 {
 	int ret = 0;
 	struct btrfs_delayed_data_ref *ref;
@@ -1647,7 +1647,7 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 				struct btrfs_delayed_ref_node *node,
 				struct btrfs_delayed_extent_op *extent_op,
-				int insert_reserved)
+				bool insert_reserved)
 {
 	int ret = 0;
 	struct btrfs_delayed_tree_ref *ref;
@@ -1687,7 +1687,7 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_ref_node *node,
 			       struct btrfs_delayed_extent_op *extent_op,
-			       int insert_reserved)
+			       bool insert_reserved)
 {
 	int ret = 0;
 
@@ -1897,7 +1897,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_extent_op *extent_op;
 	struct btrfs_delayed_ref_node *ref;
-	int must_insert_reserved = 0;
+	bool must_insert_reserved;
 	int ret;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1939,7 +1939,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		 * spin lock.
 		 */
 		must_insert_reserved = locked_ref->must_insert_reserved;
-		locked_ref->must_insert_reserved = 0;
+		locked_ref->must_insert_reserved = false;
 
 		extent_op = locked_ref->extent_op;
 		locked_ref->extent_op = NULL;
-- 
2.34.1

