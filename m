Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFD54F7E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381506AbiFQMxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 08:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiFQMxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 08:53:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE845AC3
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 05:53:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2303F1FDDB;
        Fri, 17 Jun 2022 12:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655470416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=7G8Zn2qayyTbvrJ+nHppxZuuPLkvkkCBC7miZqdIp4M=;
        b=lagFCdQibuym4fg66K9aXfzmt/4rTOHftcXFzJShDhdoA5dNqIk9YQCfQch5EbYIhm5JmQ
        7nO8IHCod2BoAKHjM5L3LEweVPY535XgoDaZ+sUvoVyH+xSHDoEtlxG2HK8Zf9HuXUMpyE
        6yE83FB2ej7LXuuuzcC4FdO9eaDq+GI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E71021348E;
        Fri, 17 Jun 2022 12:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u6rRNU95rGJ9BgAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 17 Jun 2022 12:53:35 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3] btrfs: Batch up release of reserved metadata for delayed items used for deletion
Date:   Fri, 17 Jun 2022 15:53:34 +0300
Message-Id: <20220617125334.1067259-1-nborisov@suse.com>
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
delete items. With this patch on top of Filipe's rework and running the
same test as provided in the description of a patch titled
"btrfs: improve batch deletion of delayed dir index items" I observe
the following change of the number of calls to btrfs_block_rsv_release:

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
V3:
 * Print the inode number in the tracepoint (this time for real)

 * Ensure batch release is called iff total_reserve_size is a positive number,
 this implies space is released from non log recover context.

V2:
 * Improved subject wording to make it more clear (Filipe)

 * Print the inode number in the tracepoint (Filipe)

 * More explicit referal to the test case in Filipe's initial patch to make it
 more clear how those numbers are derived.
 fs/btrfs/delayed-inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e1e856436ad5..9d618226005b 100644
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

@@ -841,14 +843,27 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 		nitems++;
 		curr = next;
 		list_add_tail(&curr->tree_list, &batch_list);
+		total_reserved_size += curr->bytes_reserved;
 	}

 	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
 	if (ret)
 		return ret;

+	/* In case of BTRFS_FS_LOG_RECOVERING items won't have reserved space */
+	if (total_reserved_size > 0) {
+		/*
+		 * Check btrfs_delayed_item_reserve_metadata() to see why we don't need
+		 * to release/reserve qgroup space.
+		 */
+		trace_btrfs_space_reservation(fs_info, "delayed_item",
+					      item->key.objectid, total_reserved_size,
+					      0);
+		btrfs_block_rsv_release(fs_info, &fs_info->delayed_block_rsv,
+					total_reserved_size, NULL);
+	}
+
 	list_for_each_entry_safe(curr, next, &batch_list, tree_list) {
-		btrfs_delayed_item_release_metadata(root, curr);
 		list_del(&curr->tree_list);
 		btrfs_release_delayed_item(curr);
 	}
--
2.25.1

