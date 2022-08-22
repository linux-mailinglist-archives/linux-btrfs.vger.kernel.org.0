Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0420559C1E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 16:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235272AbiHVOrT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiHVOrR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 10:47:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6CF2A72A
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 07:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F52560A70
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5620CC433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661179635;
        bh=DlnyTL4MLomUE8RqoKwxXni7kbq12i9k6syLv96Y+kM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fdFbhv2ImZ3A/35KmIsJs4aKP8wWAJ8ezBOBNP3fdQErhjztlXKdJMlI5Rdyz0bWJ
         dAIPcB+N7pPGYzoT/WQVFAXPorb66Q8a06cbYIECWX/H54wIMX0P7sIIRCZbIae0nh
         WvnZkQKGOg1zXSw/Po472lfnH9ZHaVWO0UcJ26i+mzRVrqZUc8UMtaACkY93P8yXc7
         VQSlgIWFwI/ozmoGsISmkAChDdelOw1p/iO1uO+7a0QLRn6XVbpvDEk0F+QzyF4Htd
         7vidynPbNNQtqKJfiKc48YgtP718pCLEpHL1lEHSLZ28cgZ+Irn3fpUgG3Lu0axkGB
         6JPKW4SRVkgMA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: simplify error handling at btrfs_del_root_ref()
Date:   Mon, 22 Aug 2022 15:47:10 +0100
Message-Id: <5a96945dcc12befa8fd85f6c3766b52c1b652e41.1661179270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661179270.git.fdmanana@suse.com>
References: <cover.1661179270.git.fdmanana@suse.com>
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
 fs/btrfs/root-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index d647cb2938c0..e1f599d7a916 100644
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
@@ -360,18 +358,18 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
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
 			goto out;
-		}
-	} else
-		err = -ENOENT;
+	} else {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	if (key.type == BTRFS_ROOT_BACKREF_KEY) {
 		btrfs_release_path(path);
@@ -383,7 +381,7 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 
 out:
 	btrfs_free_path(path);
-	return err;
+	return ret;
 }
 
 /*
-- 
2.35.1

