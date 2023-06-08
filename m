Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39FC727CC9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjFHK2N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbjFHK2F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65942D47
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4087C64BED
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C192C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220082;
        bh=/NwhbxooaOzBj78AOKlRUm1NUPy2BeSQeB3lzIVqn4E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=imlz5aAuNld0yYISrLrL9Heop5CQPFBO1Sr5kzFmy2Cf0OnXmlW5vYzEtgEquDgkE
         CN2SUAq7G3fhLU1W+lx70av7x6n/NkkxsX0q6WJP/bG9IQDtBEi/QAG2JgwHEjw2EH
         K1fELBwwc2OcWPQzoR5jNxzdMWbXkXgHseQDzr3/jwkhr6JmMpj7C93wYSmSavmrD9
         ZtiHo/WLrJ03XTBkz6Soa0QI/IUzapL+nZUhH1S47g4HfMq3b8Y6kRpQNCCkw8TUCV
         cFuV7Uf5HhJChtfqVSZll7XdhKwqJ/yxVkSciqpIiRTssIavlVJthhB12L9As5lIR1
         z91yNEjpmb7gw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/13] btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
Date:   Thu,  8 Jun 2023 11:27:46 +0100
Message-Id: <68bfdb05319f038009821dc0b5d4f1380f0e5657.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
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

At push_nodes_for_insert(), instead of doing a BUG_ON() in case we fail to
record tree mod log operations, do a transaction abort and return the
error to the caller. There's really no need for the BUG_ON() as we can
release all resources in this context, and we have to abort because other
future tree searches that use the tree mod log (btrfs_search_old_slot())
may get inconsistent results if other operations modify the tree after
that failure and before the tree mod log based search.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0449b3d819a9..620ed3a3e51e 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1308,7 +1308,12 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			btrfs_node_key(mid, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_tree_unlock(left);
+				free_extent_buffer(left);
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			btrfs_set_node_key(parent, &disk_key, pslot);
 			btrfs_mark_buffer_dirty(parent);
 			if (btrfs_header_nritems(left) > orig_slot) {
@@ -1363,7 +1368,12 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			btrfs_node_key(right, &disk_key, 0);
 			ret = btrfs_tree_mod_log_insert_key(parent, pslot + 1,
 					BTRFS_MOD_LOG_KEY_REPLACE);
-			BUG_ON(ret < 0);
+			if (ret < 0) {
+				btrfs_tree_unlock(right);
+				free_extent_buffer(right);
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
 			btrfs_set_node_key(parent, &disk_key, pslot + 1);
 			btrfs_mark_buffer_dirty(parent);
 
-- 
2.34.1

