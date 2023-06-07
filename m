Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492B7269A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjFGTZD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjFGTYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEED1FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C59639BC
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F392AC433EF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165890;
        bh=Vgcvw+1J0gJ4ISmqjEBgkY4hK3nil+z9oZA3FU5CMFE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OaB58xWdFiEbc8yhkUuTlTHwhKTDDpJKPuxB6pXYhX3lbRB7LfOseRFCbAiqqgOg8
         C/j1QFVpYzqtR7GdZsIUSa3jSOSTCrmOixFia1XIF8rQI/b/GlVCNoo/Gw5C/4nhoV
         A34Oi7ct5R7+tgr/RWAr9GYiSU6rgsxhRimUP9kPXZYHra8WjvlzxWy7CBrjTxQDjc
         VRTNXk14iXP1pWABxtqhyxD7p9fsPQWqIK40nBCecqFyeJCkTMinRc/m7MsFSFWDhP
         D2LLhlhoBNydNNI3JkJP9DvW3V8WZE47N+ZrWRSitreNBDYVZlnIqUptmODal1a4W2
         34TIW4ThDjSgA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/13] btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
Date:   Wed,  7 Jun 2023 20:24:34 +0100
Message-Id: <3dfd1a4c01795433444b45268da1ae75563642c1.1686164820.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2971e7d70d04..e3c949fa136f 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1300,7 +1300,12 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
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
@@ -1355,7 +1360,12 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
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

