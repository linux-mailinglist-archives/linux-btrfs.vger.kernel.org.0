Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB0C7269A8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjFGTYp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjFGTYn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFDA1FDA
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7736C63C4E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FFEC4339B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165881;
        bh=YHNbVFkwKYnyewFiOqNTvq9LerY5z38n7rvU6SvY23o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=akWnLc3cnUderQ91GHjIdiW3TDMEYGOIWUbVg5HiXM8s7MkuYqSOvUPFl8rLzbaZ6
         foknS2D7g7bhtEQDkqXUh5mqr2fynArhWASxplFFVn4PWIIthRzLHdNGshlBwz9yIj
         lUVBev38TSPS31GrARRYrzxHq5qPUU/rY8azfkZdE4o7DtPBmxwQ6sxbRqelu5pGTu
         zrXu3OX2tV4Be1oBSxpBHRTxEdb+D02gvEWOEMipLAPVNS7Vw3K6vOURhVYO8t1eKm
         uGwd5nYxtASasZlXnqQdJ7UTyMi2P0eZGl5fK5mnT9mcVoePg1QNw+4lKjGgVimNtZ
         kL7lELhNgrhGg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/13] btrfs: add missing error handling when logging operation while COWing extent buffer
Date:   Wed,  7 Jun 2023 20:24:25 +0100
Message-Id: <8cb7f172ba4c37685955b891ba91f57aa3daea76.1686164800.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
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

