Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DDA797F24
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbjIGXQD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjIGXQD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D240BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:15:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 26664210DB;
        Thu,  7 Sep 2023 23:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcuK+E+GKznu0WrhiaCKTQq4yn4daah13HZz9gutAZQ=;
        b=CoVg5NDgbC+mFqEfptyBy21rcMSkvqYL2vQvuAG716OPHxt1MndrC9S37yfN7l0qufnris
        dJI31bbFc+IWfcORW78Qq1ArXGvCXZTGlcllJUxOG1vE12TCjQYo/7Ue1A2a4hRnqrUfcb
        1H1eWQonK+UWGql93J4vgW/41wqgWnI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1A6FC2C142;
        Thu,  7 Sep 2023 23:15:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C28CDA8C5; Fri,  8 Sep 2023 01:09:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/10] btrfs: drop __must_check annotations
Date:   Fri,  8 Sep 2023 01:09:27 +0200
Message-ID: <565b63e6e34c122ca9bbe1e0272f43d6327a6316.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop all __must_check annotations because they're used in random
functions and not consistently. All errors should be handled.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.h | 2 +-
 fs/btrfs/relocation.c  | 2 +-
 fs/btrfs/root-tree.h   | 6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index ab2016db17e8..2109c72aea2a 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -142,7 +142,7 @@ int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 int btrfs_pin_reserved_extent(struct btrfs_trans_handle *trans, u64 start, u64 len);
 int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans);
 int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans, struct btrfs_ref *generic_ref);
-int __must_check btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
+int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref,
 				     int for_reloc);
 int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9951a0caf5bb..ad67a88f2bbf 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -631,7 +631,7 @@ static int clone_backref_node(struct btrfs_trans_handle *trans,
 /*
  * helper to add 'address of tree root -> reloc tree' mapping
  */
-static int __must_check __add_reloc_root(struct btrfs_root *root)
+static int __add_reloc_root(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct rb_node *rb_node;
diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
index eb15768b9170..8b2c3859e464 100644
--- a/fs/btrfs/root-tree.h
+++ b/fs/btrfs/root-tree.h
@@ -20,10 +20,8 @@ int btrfs_del_root(struct btrfs_trans_handle *trans, const struct btrfs_key *key
 int btrfs_insert_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key,
 		      struct btrfs_root_item *item);
-int __must_check btrfs_update_root(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *root,
-				   struct btrfs_key *key,
-				   struct btrfs_root_item *item);
+int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root *root,
+		      struct btrfs_key *key, struct btrfs_root_item *item);
 int btrfs_find_root(struct btrfs_root *root, const struct btrfs_key *search_key,
 		    struct btrfs_path *path, struct btrfs_root_item *root_item,
 		    struct btrfs_key *root_key);
-- 
2.41.0

