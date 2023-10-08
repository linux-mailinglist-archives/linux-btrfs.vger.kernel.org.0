Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859937BCAF1
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Oct 2023 02:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjJHAud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 7 Oct 2023 20:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjJHAuG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 7 Oct 2023 20:50:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C4116;
        Sat,  7 Oct 2023 17:49:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D58DC433C9;
        Sun,  8 Oct 2023 00:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726178;
        bh=UYSefizVr14cWWvX4haPsFd3HvauvR5lpVixyIMDA5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGvVmZk3HnbiFgMDA/yShn7RjR6oOedqCWsg05si0heFrmOObbkCXElPIyZMRwh7A
         uza/rsWfMZfvTZe0AS/jAqr8EDwY3fL3LpQob0aY8GOlLTxRBF0AqJzGq+bCSsRWx1
         SGp31gdXnBQiYo8WtUdPg5m4NZzbBApq/Xc6jW2viGepn7uhqd2j7UaxzRvetCF35N
         xsuBAH9HUITFMVRc2sccQ3j2JkE9jOoUxYGC/U9m4LrwoXR7ilIg1NNWMPtxE4GES3
         I43KdseFL7iuliaQOJGyrFf1FSuAxrCmXLxLvfKDsVWKX//wrR4Ls9EaAxwMVTz0dj
         kFSr2sTBcF1Mw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] btrfs: return -EUCLEAN for delayed tree ref with a ref count not equals to 1
Date:   Sat,  7 Oct 2023 20:49:22 -0400
Message-Id: <20231008004929.3767992-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004929.3767992-1-sashal@kernel.org>
References: <20231008004929.3767992-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.56
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

[ Upstream commit 1bf76df3fee56d6637718e267f7c34ed70d0c7dc ]

When running a delayed tree reference, if we find a ref count different
from 1, we return -EIO. This isn't an IO error, as it indicates either a
bug in the delayed refs code or a memory corruption, so change the error
code from -EIO to -EUCLEAN. Also tag the branch as 'unlikely' as this is
not expected to ever happen, and change the error message to print the
tree block's bytenr without the parenthesis (and there was a missing space
between the 'block' word and the opening parenthesis), for consistency as
that's the style we used everywhere else.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 08ff10a81cb90..2a7c9088fe1f8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1663,12 +1663,12 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
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

