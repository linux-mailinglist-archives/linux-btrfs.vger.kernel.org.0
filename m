Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83A720047
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jun 2023 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234790AbjFBLT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jun 2023 07:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjFBLTx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jun 2023 07:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5122E5C
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 04:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 462BC64F1E
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336C5C433EF
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jun 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685704787;
        bh=WdZ3M1lrKYQadZXiaWiY0JUjwYKAm+xDVv9r91MdPCk=;
        h=From:To:Subject:Date:From;
        b=LYFnnlG42UodLUyBOIiFSPXTHld+sA4zLNqzon0Wl9eLmM6CGj2Vq/K5TsR4SCf9L
         vwrpKwgdE8w+xLA+iwQ8qfWGmnCGc7rP9Qp9b+AV42FQYtrvepxM9rmFvzHXWNlGN0
         BvKVXzVzZs4VbSTHCO0xKZm1trlLSAzVAwWIOh2tWRCCc09A/YI2ymphJsuiY5788P
         TK9y4j1VRKvF2t3B/yDD+IB3fu/v0H8Vktmw4e4yonJtyZo1VA1EA5n0jbeJEWj7uQ
         B2cdxfX489BtbgGK/38U3XJUzAU83txjFmz81L2lBGqBh0wVzXyj25Er9GPqJwjs/J
         aj2UX5zvDTjGg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: make btrfs_destroy_delayed_refs() return void
Date:   Fri,  2 Jun 2023 12:19:42 +0100
Message-Id: <44301b9e5e365a7b0f5bc57b72811aa4467427c2.1685704678.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_destroy_delayed_refs() always returns 0 and its single caller does
not check its return value, as it also returns void, and so does the
callers' caller and so on. This is because we are in the transaction abort
path, where we have no way to deal with errors (we are in a critical
situation) and all cleanup of resources works in a best effort fashion.
So make btrfs_destroy_delayed_refs() return void.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Make it explicit in the changelog that we are in the transaction
    abort path and therefore have no way to deal with errors.

    V1 was part of a patchset that was merged except for this patch:
    https://lore.kernel.org/linux-btrfs/cover.1685363099.git.fdmanana@suse.com/

 fs/btrfs/disk-io.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 90f998ac68f0..0bd437fbe07d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4555,13 +4555,12 @@ static void btrfs_destroy_all_ordered_extents(struct btrfs_fs_info *fs_info)
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 }
 
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info)
+static void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
+				       struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4569,7 +4568,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_debug(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4630,8 +4629,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	btrfs_qgroup_destroy_extent_records(trans);
 
 	spin_unlock(&delayed_refs->lock);
-
-	return ret;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.34.1

