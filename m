Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1047798B67
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245408AbjIHRU6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbjIHRU5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F772199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CAFC433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193653;
        bh=/9zl7CzhPubtrhywg73kyoR9t3NquCE4wttMRFycPMk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S7vvDLKouN8IDTLpvTFG+OJgaA6VmYlEIpX4rkRewVDRG85A1dGlrt/VtOA4aWXhQ
         9RdMpltj/Z00FnsIyw6Kgr0BF4tcwDMdY+fYcdfEOd5lO73+sxO/9UBkspPtH+mGzv
         3NXm7MgFJb32EFOGBVyMozQ2nVEQc5+zMjslt5VVi3uAw6yeEZPVTX5IbA8dgQM1qR
         Jnf0JRKn2SmprP+N6rCF3TBVlkfdGcSFijp3hIVKH6XHrnbyR5VEi3N4nV4Xi2bzbt
         ugDBRfxoRTukMuTmj0lCgkcH/GtNbl62sgp5VznPnJdnc4WSMjGPyz6XUWLR8v8JSK
         Sh4R2xG1C2ogQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/21] btrfs: remove pointless 'ref_root' variable from run_delayed_data_ref()
Date:   Fri,  8 Sep 2023 18:20:28 +0100
Message-Id: <f102170ba3bb50280b585b420f45702f0dd10af8.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
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

The 'ref_root' variable, at run_delayed_data_ref(), is not really needed
as we can always use ref->root directly, plus its initialization to 0 is
completely pointless as we assign it ref->root before its first use.
So just drop that variable and use ref->root directly.

This may help avoid some warnings with clang tools such as the one
reported/fixed by commit 966de47ff0c9 ("btrfs: remove redundant
initialization of variables in log_new_ancestors").

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 16c7122bdfb5..21049609c5fc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1536,7 +1536,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	struct btrfs_delayed_data_ref *ref;
 	u64 parent = 0;
-	u64 ref_root = 0;
 	u64 flags = 0;
 
 	ref = btrfs_delayed_node_to_data_ref(node);
@@ -1544,7 +1543,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 
 	if (node->type == BTRFS_SHARED_DATA_REF_KEY)
 		parent = ref->parent;
-	ref_root = ref->root;
 
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		struct btrfs_key key;
@@ -1556,17 +1554,17 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
 		key.type = BTRFS_EXTENT_ITEM_KEY;
 		key.offset = node->num_bytes;
 
-		ret = alloc_reserved_file_extent(trans, parent, ref_root,
+		ret = alloc_reserved_file_extent(trans, parent, ref->root,
 						 flags, ref->objectid,
 						 ref->offset, &key,
 						 node->ref_mod);
 	} else if (node->action == BTRFS_ADD_DELAYED_REF) {
-		ret = __btrfs_inc_extent_ref(trans, node, parent, ref_root,
+		ret = __btrfs_inc_extent_ref(trans, node, parent, ref->root,
 					     ref->objectid, ref->offset,
 					     extent_op);
 	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
 		ret = __btrfs_free_extent(trans, node, parent,
-					  ref_root, ref->objectid,
+					  ref->root, ref->objectid,
 					  ref->offset, extent_op);
 	} else {
 		BUG();
-- 
2.40.1

