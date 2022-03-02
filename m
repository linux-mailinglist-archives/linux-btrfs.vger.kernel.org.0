Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C094CAAC6
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Mar 2022 17:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiCBQvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Mar 2022 11:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243530AbiCBQvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Mar 2022 11:51:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20CCA739
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Mar 2022 08:50:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B939218B0;
        Wed,  2 Mar 2022 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646239822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=crDsiwbz6UoOwR51+Te8QxRNZkcRQe9R/X4QVK6hghE=;
        b=epEi/pSJF9DoUyu9P50QUaY9EgHWeUPOsDe7rRBeF2R/KAdk0hYsHwjiv4Rze8qhKxADGv
        mzaxM8kCWxYWJaVw7H+s7eQ3rOGIAjyqibzMVSwTPktZMaxhITsqxHomuc2KGaxMRS6Fzw
        G1es4KPEQ1nG/GpihYtFJUy/vrbhpGs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B78C13A93;
        Wed,  2 Mar 2022 16:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yHBmEE6gH2LdOwAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 02 Mar 2022 16:50:22 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 01/14] btrfs: Introduce btrfs_for_each_slot iterator macro
Date:   Wed,  2 Mar 2022 17:48:16 +0100
Message-Id: <20220302164829.17524-2-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302164829.17524-1-gniebler@suse.com>
References: <20220302164829.17524-1-gniebler@suse.com>
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

There is a common pattern when searching for a key in btrfs:

* Call btrfs_search_slot to find the slot for the key
* Enter an endless loop:
	* If the found slot is larger than the no. of items in the current leaf,
	  check the next leaf
	* If it's still not found in the next leaf, terminate the loop
	* Otherwise do something with the found key
	* Increment the current slot and continue

To reduce code duplication, we can replace this code pattern with an iterator
macro, similar to the existing for_each_X macros found elsewhere in the kernel.
This also makes the code easier to understand for newcomers by putting a name
to the encapsulated functionality.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/ctree.c | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h | 24 ++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a7db3f6f1b7b..d735bd472616 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2277,6 +2277,39 @@ int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
 	return ret;
 }
 
+/* Search for a valid slot for the given path.
+ *
+ * @root: The root node of the tree.
+ * @key: Will contain a valid item if found.
+ * @path: The starting point to validate the slot.
+ *
+ * Return 0 if the item is valid, 1 if not found and < 0 if error.
+ */
+int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
+			      struct btrfs_path *path)
+{
+	while (1) {
+		int ret;
+		const int slot = path->slots[0];
+		const struct extent_buffer *leaf = path->nodes[0];
+		/* this is where we start walking through the path */
+		if (slot >= btrfs_header_nritems(leaf)) {
+			/*
+			 * if we've reached the last slot in this leaf we need
+			 * to go to the next leaf and reset the path
+			 */
+			ret = btrfs_next_leaf(root, path);
+			if (ret)
+				return ret;
+			continue;
+		}
+		/* store the found, valid item in key */
+		btrfs_item_key_to_cpu(leaf, key, slot);
+		break;
+	}
+	return 0;
+}
+
 /*
  * adjust the pointers going up the tree, starting at level
  * making sure the right key of each node is points to 'key'.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 947f04789389..98091334b749 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2976,6 +2976,30 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
 			   struct btrfs_path *path);
 
+int btrfs_get_next_valid_item(struct btrfs_root *root, struct btrfs_key *key,
+			      struct btrfs_path *path);
+
+/* Search in @root for a given @key, and store the slot found in @found_key.
+ *
+ * @root: The root node of the tree.
+ * @key: The key we are looking for.
+ * @found_key: Will hold the found item.
+ * @path: Holds the current slot/leaf.
+ * @iter_ret: Contains the value returned from btrfs_search_slot or
+ *            btrfs_get_next_valid_item, whichever was executed last.
+ *
+ * The iter_ret is an output variable that will contain the return value of
+ * btrfs_search_slot, if it encountered an error, or the value returned from
+ * btrfs_get_next_valid_item, otherwise. That return value can be 0, if a valid
+ * slot was found, 1 if there were no more leaves, and <0 if there was an error.
+ */
+#define btrfs_for_each_slot(root, key, found_key, path, iter_ret)		\
+	for (iter_ret = btrfs_search_slot(NULL, root, key, path, 0, 0);		\
+		iter_ret >= 0 &&						\
+		(iter_ret = btrfs_get_next_valid_item(root, found_key, path)) == 0; \
+		path->slots[0]++						  \
+	)
+
 static inline int btrfs_next_old_item(struct btrfs_root *root,
 				      struct btrfs_path *p, u64 time_seq)
 {
-- 
2.35.1

