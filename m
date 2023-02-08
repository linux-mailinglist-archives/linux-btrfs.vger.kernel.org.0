Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3014468F606
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Feb 2023 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjBHRsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Feb 2023 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjBHRrv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Feb 2023 12:47:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D42E0D1
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 09:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 609C46177E
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515FFC4339B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Feb 2023 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675878413;
        bh=SrpgjZ5eSQNc3vXR70UsW8QhVddQeHyTQe7rLHRi70k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=REzN+LkkI3Lmb8p94E8AjKIyaSKNIOPh2RNbLl0u0Y6MTiUOYmegU3Qj5QGaMlj6P
         JCupMba6/Bj4zHzL1zeUyxLSINXpmHKrIjf1lEuuGEffOb0zwzOnZxoRHMPSA1/aSD
         7FkrJRxhZgvVoho3I5UnXgRzh4Gk8ztkDtWf3H33eNJ5yDpsDyNJPWGLwEfH8gEbkJ
         3WQUU5lmVZuI+B8hns81SIwrAv2iKQu2HhBA+5vH/a1pnC8hAF2o52TEG+vl8yjV/n
         Eqti/6/c8K2ramsUMEUJyKzTgxgxGSd1Ljne1Dtn3mXGWdHi/niBwcE4uaAus9ynO8
         DM6qyBE8Yd4qw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: eliminate extra call when doing binary search on extent buffer
Date:   Wed,  8 Feb 2023 17:46:48 +0000
Message-Id: <0b8ddfc0c2e415f31b3fcf1ae531b78abdafc494.1675877903.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1675877903.git.fdmanana@suse.com>
References: <cover.1675877903.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_bin_search() is just a wrapper around the function
generic_bin_search(), which passes the same arguments plus a default
low slot with a value of 0. This adds an unnecessary extra function
call, since btrfs_bin_search() is not static. So improve on this by
making btrfs_bin_search() an inline function that calls
generic_bin_search(), renaming the later to btrfs_generic_bin_search()
and exporting it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 16 +++-------------
 fs/btrfs/ctree.h | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4754c9101a4c..34c76b217b52 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -863,8 +863,8 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
  * Slot may point to the total number of items (i.e. one position beyond the last
  * key) if the key is bigger than the last key in the extent buffer.
  */
-static noinline int generic_bin_search(struct extent_buffer *eb, int low,
-				       const struct btrfs_key *key, int *slot)
+int btrfs_generic_bin_search(struct extent_buffer *eb, int low,
+			     const struct btrfs_key *key, int *slot)
 {
 	unsigned long p;
 	int item_size;
@@ -925,16 +925,6 @@ static noinline int generic_bin_search(struct extent_buffer *eb, int low,
 	return 1;
 }
 
-/*
- * Simple binary search on an extent buffer. Works for both leaves and nodes, and
- * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
- */
-int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
-		     int *slot)
-{
-	return generic_bin_search(eb, 0, key, slot);
-}
-
 static void root_add_used(struct btrfs_root *root, u32 size)
 {
 	spin_lock(&root->accounting_lock);
@@ -1869,7 +1859,7 @@ static inline int search_for_key_slot(struct extent_buffer *eb,
 		return 0;
 	}
 
-	return generic_bin_search(eb, search_low_slot, key, slot);
+	return btrfs_generic_bin_search(eb, search_low_slot, key, slot);
 }
 
 static int search_leaf(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6965703a81b6..322f2171275d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -507,6 +507,21 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range);
 /* ctree.c */
 int __init btrfs_ctree_init(void);
 void __cold btrfs_ctree_exit(void);
+
+int btrfs_generic_bin_search(struct extent_buffer *eb, int low,
+			     const struct btrfs_key *key, int *slot);
+
+/*
+ * Simple binary search on an extent buffer. Works for both leaves and nodes, and
+ * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
+ */
+static inline int btrfs_bin_search(struct extent_buffer *eb,
+				   const struct btrfs_key *key,
+				   int *slot)
+{
+	return btrfs_generic_bin_search(eb, 0, key, slot);
+}
+
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int *slot);
 int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
-- 
2.35.1

