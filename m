Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3977CF89C
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345460AbjJSMTj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjJSMTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19FA3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 05:19:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE3AC433C9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717976;
        bh=8/hJuPFsh50HkvaCTmLvVmX2w4SI2ppTiDQmeXOBCVM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=POR6proBzow1kM1dRGL2UfxsG6Se57zWxXhUw7TwDJhOaT0m7yJHdkkeIc4XUGTRt
         r1fjEGCAGYkrRcf/YBWr8WwRNOYgUfOKFYC7jUbio2rcBQC9r/LzBCgjmiwPQodSyH
         MADWBE9DVTKOXvLa76346SZ7yZs6UPgbtwEd5TjiLRaWQffqc4Fw4Z4e8kDH1wcCzH
         sdz1IIEPEy9tMyUJ62jJfBiGEUZ/r7iHn+3+dH5xkJdc/CAxSdw+N6E/7yVcbPncjz
         duRlnJHgGqEI3uR//I0/nh9qK2j6mDSJRZBXLmtmC4GeXFaVLcebOJ0jHLkcZxn8jK
         GlqQcGpzRyAXA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use bool for return type of btrfs_block_can_be_shared()
Date:   Thu, 19 Oct 2023 13:19:29 +0100
Message-Id: <7c7cede90b6aafe10821784396ee1033d0537022.1697716427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697716427.git.fdmanana@suse.com>
References: <cover.1697716427.git.fdmanana@suse.com>
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

Currently btrfs_block_can_be_shared() returns an int that is used as a
boolean. Since it all it needs is to return true or false, and it can't
return errors for example, change the return type from int to bool to
make it a bit more readable and obvious.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 12 ++++++------
 fs/btrfs/ctree.h |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 346f3104eee7..3cc3ec472497 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -370,9 +370,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 /*
  * check if the tree block can be shared by multiple trees
  */
-int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root,
-			      struct extent_buffer *buf)
+bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root,
+			       struct extent_buffer *buf)
 {
 	/*
 	 * Tree blocks not in shareable trees and tree roots are never shared.
@@ -385,7 +385,7 @@ int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
 	     btrfs_root_last_snapshot(&root->root_item) ||
 	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))) {
 		if (buf != root->commit_root)
-			return 1;
+			return true;
 		/*
 		 * An extent buffer that used to be the commit root may still be
 		 * shared because the tree height may have increased and it
@@ -393,10 +393,10 @@ int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
 		 * snapshoting a subvolume created in the current transaction.
 		 */
 		if (btrfs_header_generation(buf) == trans->transid)
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 99fe28bc013b..9c0800f5bdcb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -558,9 +558,9 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
-int btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
-			      struct btrfs_root *root,
-			      struct extent_buffer *buf);
+bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root,
+			       struct extent_buffer *buf);
 int btrfs_del_ptr(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct btrfs_path *path, int level, int slot);
 void btrfs_extend_item(struct btrfs_trans_handle *trans,
-- 
2.40.1

