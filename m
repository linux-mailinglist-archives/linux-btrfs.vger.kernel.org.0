Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9835153B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 20:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380015AbiD2Se6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380013AbiD2Se5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 14:34:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988125FF15
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 11:31:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C59B621877;
        Fri, 29 Apr 2022 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651257096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX4AO4qDiWk9Tt4sRPFDaN4kshANgCINlep2X3sd2ic=;
        b=TVT/qlJw6XbNb2Tef6A4SYsfAp8waDjl/qe9WsjAQQvhxIqukZINlpmfK4KCvGh6bXx6jR
        eDAgh/j5Qx3MdnI9AQL0k4/1MMzRD0cjDKwftCcM56PgvtqjaDJ3oxt2lF2t2cZKbJadls
        W+vXh8tRj820qGx1RfR+3xEdhZyXsg8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BCF282C141;
        Fri, 29 Apr 2022 18:31:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2DC21DA7DE; Fri, 29 Apr 2022 20:27:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/9] btrfs: sink parameter is_data to btrfs_set_disk_extent_flags
Date:   Fri, 29 Apr 2022 20:27:29 +0200
Message-Id: <1153dbbc81cafc6ab780541b93dfc0b1b37527c5.1651255990.git.dsterba@suse.com>
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

The parameter has been added in 2009 in the infamous monster commit
5d4f98a28c7d ("Btrfs: Mixed back reference  (FORWARD ROLLING FORMAT
CHANGE)") but not used ever since. We can sink it and allow further
simplifications.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c       | 2 +-
 fs/btrfs/ctree.h       | 3 +--
 fs/btrfs/extent-tree.c | 6 +++---
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1e24695ede0a..6e556031a8f3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -343,7 +343,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			int level = btrfs_header_level(buf);
 
 			ret = btrfs_set_disk_extent_flags(trans, buf,
-							  new_flags, level, 0);
+							  new_flags, level);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 371f3f6c4ea4..6834d6913b3d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2810,8 +2810,7 @@ int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int full_backref);
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags,
-				int level, int is_data);
+				struct extent_buffer *eb, u64 flags, int level);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 963160a0c393..446a95053a7a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2180,7 +2180,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 				struct extent_buffer *eb, u64 flags,
-				int level, int is_data)
+				int level)
 {
 	struct btrfs_delayed_extent_op *extent_op;
 	int ret;
@@ -2192,7 +2192,7 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	extent_op->flags_to_set = flags;
 	extent_op->update_flags = true;
 	extent_op->update_key = false;
-	extent_op->is_data = is_data ? true : false;
+	extent_op->is_data = false;
 	extent_op->level = level;
 
 	ret = btrfs_add_delayed_extent_op(trans, eb->start, eb->len, extent_op);
@@ -5136,7 +5136,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		ret = btrfs_dec_ref(trans, root, eb, 0);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_set_disk_extent_flags(trans, eb, flag,
-						  btrfs_header_level(eb), 0);
+						  btrfs_header_level(eb));
 		BUG_ON(ret); /* -ENOMEM */
 		wc->flags[level] |= flag;
 	}
-- 
2.34.1

