Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BB25153B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380018AbiD2SfA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379450AbiD2Se6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:34:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B1665D0F
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E9A541F892;
        Fri, 29 Apr 2022 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qk8HPa41xsjvG/EHptKr5AXF5kJukrAI/Gvbnfohb5Y=;
        b=qvdfRnu7TWNFHE6HvZBS9zUmQcrpzkneKOiUhAwLB0Io4DVttuU21LhCOYj9Vt/nrmRTKg
        WFeAkQigZDs9inPEpk6bRuBI00K64DU2KcEaEeMsII6Rr0yiibFxrlKzlEyvi/wVvcd8Bn
        o7iitw8N6HIjoZBgRtMVi8tcLMO45k4=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E06552C141;
        Fri, 29 Apr 2022 18:31:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50284DA7DE; Fri, 29 Apr 2022 20:27:31 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/9] btrfs: remove btrfs_delayed_extent_op::is_data
Date:   Fri, 29 Apr 2022 20:27:31 +0200
Message-Id: <a6dec14ab56c4a831664d4864d63782679c0e5bf.1651255990.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1651255990.git.dsterba@suse.com>
References: <cover.1651255990.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The value of btrfs_delayed_extent_op::is_data is always false, we can
cascade the change and simplify code that depends on it, removing the
structure member eventually.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/delayed-ref.c | 4 +---
 fs/btrfs/delayed-ref.h | 1 -
 fs/btrfs/extent-tree.c | 6 ++----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4176df149d04..99f37fca2e96 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -930,7 +930,6 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
 	is_system = (generic_ref->tree_ref.owning_root == BTRFS_CHUNK_TREE_OBJECTID);
 
 	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
-	BUG_ON(extent_op && extent_op->is_data);
 	ref = kmem_cache_alloc(btrfs_delayed_tree_ref_cachep, GFP_NOFS);
 	if (!ref)
 		return -ENOMEM;
@@ -1103,8 +1102,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 
 	init_delayed_ref_head(head_ref, NULL, bytenr, num_bytes, 0, 0,
-			      BTRFS_UPDATE_DELAYED_HEAD, extent_op->is_data,
-			      false);
+			      BTRFS_UPDATE_DELAYED_HEAD, false, false);
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 91a3aabad150..d6304b690ec4 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -58,7 +58,6 @@ struct btrfs_delayed_extent_op {
 	u8 level;
 	bool update_key;
 	bool update_flags;
-	bool is_data;
 	u64 flags_to_set;
 };
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 446a95053a7a..7cea22039608 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1577,12 +1577,12 @@ static int run_delayed_extent_op(struct btrfs_trans_handle *trans,
 	u32 item_size;
 	int ret;
 	int err = 0;
-	int metadata = !extent_op->is_data;
+	int metadata = 1;
 
 	if (TRANS_ABORTED(trans))
 		return 0;
 
-	if (metadata && !btrfs_fs_incompat(fs_info, SKINNY_METADATA))
+	if (!btrfs_fs_incompat(fs_info, SKINNY_METADATA))
 		metadata = 0;
 
 	path = btrfs_alloc_path();
@@ -2192,7 +2192,6 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->flags_to_set = flags;
 	extent_op->update_flags = true;
 	extent_op->update_key = false;
-	extent_op->is_data = false;
 	extent_op->level = level;
 
 	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len, extent_op);
@@ -4951,7 +4950,6 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 		extent_op->flags_to_set = flags;
 		extent_op->update_key = skinny_metadata ? false : true;
 		extent_op->update_flags = true;
-		extent_op->is_data = false;
 		extent_op->level = level;
 
 		btrfs_init_generic_ref(&generic_ref, BTRFS_ADD_DELAYED_EXTENT,
-- 
2.34.1

