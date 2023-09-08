Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB47986D1
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243207AbjIHMJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbjIHMJl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5821BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82462C433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174977;
        bh=CS7FgnFp/TxGQmnTgzs1JupmjaJP8GemUnGDTXUwpyc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kUKtTpLqseSAO8vPGuX6L0Zar60fHM+kujt03o9KUbMCEtaOcXs+0ajidyEBHR8Q8
         d9yfP1T/izeeM6LTiA9bFH3Sy/J6UIQBTgKpyzEdGglfXU/BuZbHM5HVO7auaK47Ty
         B5qfDJb8rUmWJGCryyRao83d1TsRsC830ZKCCrQczAnOK0sE+baAdi7rwF6tXYkKL5
         NQYSptbk4b/mvXN6C7HJsvICWHozU5FvhTVTjiP7ZcFD1xJrI3+uySjK07G1R1m7/X
         a3xjosNWHX1M0NcES8IFfdaYwnVjJmq7CXaMYgEek44bAD69pP292qR6LK8AWdo4iZ
         IsajaFYEMm5QA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/21] btrfs: initialize key where it's used when running delayed data ref
Date:   Fri,  8 Sep 2023 13:09:12 +0100
Message-Id: <f834c7cc57a73507473d43d40d6c909ebb65fe2b.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At run_delayed_data_ref() we are always initializing a key but the key
is only needed and used if we are inserting a new extent. So move the
declaration and initialization of the key to 'if' branch where it's used.
Also rename the key from 'ins' to 'key', as it's a more clear name.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index de63e873be3a..16c7122bdfb5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1535,15 +1535,10 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 {
 	int ret = 0;
 	struct btrfs_delayed_data_ref *ref;
-	struct btrfs_key ins;
 	u64 parent = 0;
 	u64 ref_root = 0;
 	u64 flags = 0;
 
-	ins.objectid = node->bytenr;
-	ins.offset = node->num_bytes;
-	ins.type = BTRFS_EXTENT_ITEM_KEY;
-
 	ref = btrfs_delayed_node_to_data_ref(node);
 	trace_run_delayed_data_ref(trans->fs_info, node, ref, node->action);
 
@@ -1552,11 +1547,18 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	ref_root = ref->root;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
+		struct btrfs_key key;
+
 		if (extent_op)
 			flags |= extent_op->flags_to_set;
+
+		key.objectid = node->bytenr;
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+		key.offset = node->num_bytes;
+
 		ret = alloc_reserved_file_extent(trans, parent, ref_root,
 						 flags, ref->objectid,
-						 ref->offset, &ins,
+						 ref->offset, &key,
 						 node->ref_mod);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
 		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
-- 
2.40.1

