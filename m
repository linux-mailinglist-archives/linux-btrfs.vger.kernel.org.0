Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F1059BF04
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiHVLyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 07:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbiHVLyJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 07:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B09837F86
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 04:53:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B24F6108F
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 11:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F340CC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661169232;
        bh=348hi8rzhwBF+bD3QAH3y+7ujtiqooOhp31PQVO/1BY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=O61CAHaoB41H+YuFUW3+JIprk4UOBHiQ8wqOrgzpvBFknv2DRoKaj4gMcjaKYAt8s
         K89eTrG6MD7oRZS43ZYCGloaqDkZ6ELajPydqj7rCGNYwdQJGRHEd3cckb3+1syWpV
         iHNEXJqovetZbsWkSsohEo/BwxQFjFrhygDvGE/rOEU8IjVDWmcYozlo+E4YIN4G+W
         RICr1aGrybmnrqN5vCT8TiIQSvAPFIv8RRVxs6mSw962nd1fyqUooi5pdicbDnQvdn
         MQ5rOs1fOK4il+7W6o2uQFRmvOVhRCLUgz6OSjXuevNSKVC2fAwojIi0Qgbpeb4QpR
         2JqecRzb864xQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: simplify error handling at btrfs_del_root_ref()
Date:   Mon, 22 Aug 2022 12:53:47 +0100
Message-Id: <739133f2ad552017ad7a57b23c0ccc5db83d9e1d.1661168931.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661168931.git.fdmanana@suse.com>
References: <cover.1661168931.git.fdmanana@suse.com>
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

At btrfs_del_root_ref() we are using two return variables, named 'ret' and
'err'. This makes it harder to follow and easier to return the wrong value
in case an error happens - the previous patch in the series, which has the
subject "btrfs: fix silent failure when deleting root reference", fixed a
bug due to confusion created by these two variables.

So change the function to use a single variable for tracking the return
value of the function, using only 'ret', which is consistent with most of
the codebase.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index d647cb2938c0..3975a24c3fdc 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -337,7 +337,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	unsigned long ptr;
-	int err = 0;
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -350,7 +349,6 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 again:
 	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
 	if (ret < 0) {
-		err = ret;
 		goto out;
 	} else if (ret == 0) {
 		leaf = path->nodes[0];
@@ -360,18 +358,28 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
 		    (btrfs_root_ref_name_len(leaf, ref) != name_len) ||
 		    memcmp_extent_buffer(leaf, name, ptr, name_len)) {
-			err = -ENOENT;
+			ret = -ENOENT;
 			goto out;
 		}
 		*sequence = btrfs_root_ref_sequence(leaf, ref);
 
 		ret = btrfs_del_item(trans, tree_root, path);
-		if (ret) {
-			err = ret;
+		if (ret)
+			goto out;
+	} else {
+		if (key.type == BTRFS_ROOT_REF_KEY) {
+			/*
+			 * We've searched for a BTRFS_ROOT_BACKREF_KEY item and
+			 * for a BTRFS_ROOT_REF_KEY item, so error out.
+			 */
+			ret = -ENOENT;
 			goto out;
 		}
-	} else
-		err = -ENOENT;
+		/*
+		 * We have only searched for a BTRFS_ROOT_BACKREF_KEY item, so
+		 * fallback below to search for BTRFS_ROOT_REF_KEY item.
+		 */
+	}
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
 		btrfs_release_path(path);
@@ -383,7 +391,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 
 out:
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 /*
-- 
2.35.1

