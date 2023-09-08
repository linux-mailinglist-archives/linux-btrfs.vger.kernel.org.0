Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4816C798B66
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbjIHRU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbjIHRUz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59550199F
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7349AC433CD
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193652;
        bh=LdoCaAHdILvGMagXDNJCdW6byGwG+gSiARwnBDld4c0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UfpHZWzr1ewttu8V1cs0fv+J05UdcORFaDMWxAOJdv06Eo0/xR3KiY5oJeXN8heMh
         DcA+8LJTDTxae3BfS/X8Jvqkwhd9L3NsZjDxw51vBDGhJTwwdxoK0qtpRNCesRSWaN
         MaUCO5vn9J/YY2hdNsTm7f4vIBFELo0ceJe1RIveqTqd7uB3KFG/zYgxLwqPbwDiV4
         /qrtiEjO+0BV3GfJWE4WN7VupQKQi+jslA7SAf4RDs9ItIOtb9VbOwbjo3WiDt0QHs
         UGu3W3kMc2IPs8MI+9/KgwPEcli1cTahrC1DgiHoTHSqk18f5lJFP4tYAZUaKPQyfp
         fik9MnmkmwUkw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/21] btrfs: initialize key where it's used when running delayed data ref
Date:   Fri,  8 Sep 2023 18:20:27 +0100
Message-Id: <5b936afa138b6e190a322987e7d6c9b2ad7230f1.1694192469.git.fdmanana@suse.com>
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

At run_delayed_data_ref() we are always initializing a key but the key
is only needed and used if we are inserting a new extent. So move the
declaration and initialization of the key to 'if' branch where it's used.
Also rename the key from 'ins' to 'key', as it's a more clear name.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

