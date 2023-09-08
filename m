Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99597986C8
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243188AbjIHMJh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjIHMJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4571BE7
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E3BC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174973;
        bh=GTYnnmyLnu0IU8cRjayrFZxrRQzQmEQx7o/wt+0N+iM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oooNllZzAf8oy2szWj7WeIjhQ1x7CWEjy2XUH3WdgneOLkL9fQyKpv7jNzZJAhCTa
         ouUJc9XHXlALrQNSGb3QTVInKg4iOlX6p3412e8K16RpII36Q1J7gosATVRf/JE0t2
         ifqygkHYstb78vwDaY/7JNL4qDpJoVmb9+KUZH0L8NRhXS5rQKIi8JBNrW6mxcAQFU
         LKaI050MorlOBjyo8hX32+25x0svslq+xvPJxJDj/bA8K4u8OsMlL3F/ajfUnjvA2q
         rww1U9NUNnBCw6ul2SiFtOJZLri23pEWHU3VuwnGTgnDW6KCtEdB9gaXyP6X/VYg4h
         VHabEeD+qarCQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/21] btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
Date:   Fri,  8 Sep 2023 13:09:08 +0100
Message-Id: <a8109a354d0aa8bbe376f98cce8952e61b342ee8.1694174371.git.fdmanana@suse.com>
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

When running a delayed tree reference, if we find a ref count different
from 1, we return -EIO. This isn't an IO error, as it indicates either a
bug in the delayed refs code or a memory corruption, so change the error
code from -EIO to -EUCLEAN. Also tag the branch as 'unlikely' as this is
not expected to ever happen, and change the error message to print the
tree block's bytenr without the parenthesis (and there was a missing space
between the 'block' word and the opening parenthesis), for consistency as
that's the style we used everywhere else.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 929fbb620d68..8fca9c2b8917 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1699,12 +1699,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
 		parent = ref->parent;
 	ref_root = ref->root;
 
-	if (node->ref_mod != 1) {
+	if (unlikely(node->ref_mod != 1)) {
 		btrfs_err(trans->fs_info,
-	"btree block(%llu) has %d references rather than 1: action %d ref_root %llu parent %llu",
+	"btree block %llu has %d references rather than 1: action %d ref_root %llu parent %llu",
 			  node->bytenr, node->ref_mod, node->action, ref_root,
 			  parent);
-		return -EIO;
+		return -EUCLEAN;
 	}
 	if (node->action == BTRFS_ADD_DELAYED_REF && insert_reserved) {
 		BUG_ON(!extent_op || !extent_op->update_flags);
-- 
2.40.1

