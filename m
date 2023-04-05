Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD026D8548
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 19:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjDERxF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 13:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjDERxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 13:53:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D01E7680
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 10:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B309263D4D
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EDEC433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 17:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680717147;
        bh=WbspzsKYY9RzMXkT9OrDPtCnAlNjTvJbKF6IFya+ADs=;
        h=From:To:Subject:Date:From;
        b=E7POtQs/r/U2QiQdX8dMe+jjrH97caFbCiCjZBp8R0ephoAydD8+f+V3CiHt+7x3J
         IOwezNsYSbs42owuZdG5WYC4rS0WhUjXbgUS2tpd257KGZUJb0VbVaW4SLZszX12rs
         59SnhSaImDD2Hyx2PXKdp+44Zq64aU7ugZSAyzZU1h5ATTNmvx/QqFT9Upv2Uughzq
         pp/RiPHeBkB18UBSjzRPKO9TAtN5FSx7geoxOnGE5QZnGJ2I0kzugzOh5iHhFLK43V
         mFEtHfYxrn0NK6f43oYzyVGpRa0ysHEKKeHf/nalbx3zvAfT1o+IWqRX+namNd6hrs
         NX/h8VdJ71IyQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove pointless loop at btrfs_get_next_valid_item()
Date:   Wed,  5 Apr 2023 18:52:23 +0100
Message-Id: <aa1b109d4ae1739890dfd379f10dc0540164e1cb.1680716909.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

It's pointless to have a while loop at btrfs_get_next_valid_item(), as if
the slot on the current leaf is beyond the last item, we call
btrfs_next_leaf(), which leaves us at a valid slot of the next leaf (or
a valid slot in the current leaf if after releasing the path an item gets
pushed from the next leaf to the current leaf).

So just call btrfs_next_leaf() if the current slot on the current leaf is
beyond the last item.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3b956176b038..3c983c70028a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2490,26 +2490,15 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
 int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
 			      struct btrfs_path *path)
 {
-	while (1) {
+	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
 		int ret;
-		const int slot = path->slots[0];
-		const struct extent_buffer *leaf = path->nodes[0];
 
-		/* This is where we start walking the path. */
-		if (slot >= btrfs_header_nritems(leaf)) {
-			/*
-			 * If we've reached the last slot in this leaf we need
-			 * to go to the next leaf and reset the path.
-			 */
-			ret = btrfs_next_leaf(root, path);
-			if (ret)
-				return ret;
-			continue;
-		}
-		/* Store the found, valid item in @key. */
-		btrfs_item_key_to_cpu(leaf, key, slot);
-		break;
+		ret = btrfs_next_leaf(root, path);
+		if (ret)
+			return ret;
 	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], key, path->slots[0]);
 	return 0;
 }
 
-- 
2.34.1

