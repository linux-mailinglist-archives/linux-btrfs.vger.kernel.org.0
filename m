Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3DF54E20F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 15:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376898AbiFPNfu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 09:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376839AbiFPNft (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 09:35:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16D71FCD3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 06:35:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C96E1F7AB;
        Thu, 16 Jun 2022 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655386547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lWK1HVslwaxt65D7vod2ElQCm6Tt/vn5O9RKQhxflpw=;
        b=n68GRaU5oXR3R06nDCrXXNxOyxwikj6uo3XCMaQtpFRFF2Hcg4wYwW9CEuuYGIIgMH2RuU
        7x5Eb8U4xhO3IXi/kXdQu1xWhTBHsJ7bmL0cGqtnPUjmwxlGTAXVWM//gTl8J/ZuUP4imL
        /22qhBMX0O+qhfzNnNoT7lmKniuVo90=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 599A113A70;
        Thu, 16 Jun 2022 13:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JXMeE7Mxq2I/HAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 16 Jun 2022 13:35:47 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Batch up release of delayed inode metadata
Date:   Thu, 16 Jun 2022 16:35:45 +0300
Message-Id: <20220616133545.1001959-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With Filipe's recent rework of the delayed inode code one aspect which
isn't batched is the release of the reserved metadata of delayed inode's
delete items. With this batch on top of his rework I see the following
change of the number of calls to btrfs_block_rsv_release:

Before this change:
@block_rsv_release: 1004
@btrfs_delete_delayed_items_total_time: 14602
@delete_batches: 505

After:
@block_rsv_release: 510
@btrfs_delete_delayed_items_total_time: 13643
@delete_batches: 507

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delayed-inode.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e1e856436ad5..6c06ddba5a7a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -800,11 +800,13 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 				    struct btrfs_path *path,
 				    struct btrfs_delayed_item *item)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_delayed_item *curr, *next;
 	struct extent_buffer *leaf = path->nodes[0];
 	LIST_HEAD(batch_list);
 	int nitems, slot, last_slot;
 	int ret;
+	u64 total_reserved_size = item->bytes_reserved;
 
 	ASSERT(leaf != NULL);
 
@@ -841,14 +843,23 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 		nitems++;
 		curr = next;
 		list_add_tail(&curr->tree_list, &batch_list);
+		total_reserved_size += curr->bytes_reserved;
 	}
 
 	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
 	if (ret)
 		return ret;
 
+	/*
+	 * Check btrfs_delayed_item_reserve_metadata() to see why we don't need
+	 * to release/reserve qgroup space.
+	 */
+	trace_btrfs_space_reservation(fs_info, "delayed_item", 0,
+				      total_reserved_size, 0);
+	btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
+				total_reserved_size, NULL);
+
 	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
-		btrfs_delayed_item_release_metadata(root, curr);
 		list_del(&curr->tree_list);
 		btrfs_release_delayed_item(curr);
 	}
-- 
2.25.1

