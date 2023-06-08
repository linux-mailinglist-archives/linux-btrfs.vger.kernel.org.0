Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B777727CC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbjFHK2B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjFHK16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D8A2720
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E0761245
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B82C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220074;
        bh=2xj6K4f9L9IMyjj4gJit320EouHT+9Kp/oA4noDcPBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CrQpzG/t0pBSA9TQoTAB7DN9khhjibUz3pwd05Yv0ZFyUBzIM1yesOT7Tnfc5HKTI
         Zis0jpA8YKdjyIjShu/tEiyusfsPL2Dx9LOZmfkXMKHRiFNLC+xFtzq5fI5Kf1ODre
         sqGGnPEodkpZw8u8/aSYDtLQo93LAgBvdFeUrq9N+b9EbeqMvktQjz+sQt8f+opa4o
         FWEyKks94K2ZTv5qXRqPB7lnE/Os+KR7w++NKrjFjrT+m/HCJoVx5znqvHyQuNXny8
         hgIuiAenYDRyOeLvb5YecqGo3bxjvLOGNpqMheCb0VRccYF3ikRCUYTahB6qeSfj8g
         Rik1obO4UF2Zw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 01/13] btrfs: add missing error handling when logging operation while COWing extent buffer
Date:   Thu,  8 Jun 2023 11:27:37 +0100
Message-Id: <d1fe214ef129d6e5ee913ca1f1a02782492eae10.1686219923.git.fdmanana@suse.com>
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

When COWing an extent buffer that is not the root node, we need to log in
the tree mod log that we replaced a pointer in the parent node, otherwise
a tree mod log user doing a search on the b+tree can return incorrect
results (that miss something). We are doing the call to
btrfs_tree_mod_log_insert_key() but we totally ignore its return value.

So fix this by adding the missing error handling, resulting in a
transaction abort and freeing the COWed extent buffer.

Fixes: f230475e62f7 ("Btrfs: put all block modifications into the tree mod log")
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 385524224037..7f7f13965fe9 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -595,8 +595,14 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
 		add_root_to_dirty_list(root);
 	} else {
 		WARN_ON(trans->transid != btrfs_header_generation(parent));
-		btrfs_tree_mod_log_insert_key(parent, parent_slot,
-					      BTRFS_MOD_LOG_KEY_REPLACE);
+		ret = btrfs_tree_mod_log_insert_key(parent, parent_slot,
+						    BTRFS_MOD_LOG_KEY_REPLACE);
+		if (ret) {
+			btrfs_tree_unlock(cow);
+			free_extent_buffer(cow);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
 		btrfs_set_node_blockptr(parent, parent_slot,
 					cow->start);
 		btrfs_set_node_ptr_generation(parent, parent_slot,
-- 
2.34.1

