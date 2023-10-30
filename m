Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B347DC197
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjJ3VHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjJ3VHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 17:07:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4E7ED
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 14:07:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6E33E2188D
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698700060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=M6BrcOLNAKbsghhJeTyExgvY1BtZCBdC0Y9ZGXqWQ7o=;
        b=l9ndTPzGL1xwF0HAACJLR7apVQp4L6wQws0ZuhZjw3E5ik75xqvfke01kk0/NQKBQlHonP
        K0zqg71rEMjlT51xcJMypXR3JBnjkuhMptVQWybNlrDisL+uVTt3BW0MWZDW5D5SAK2jXc
        eJE/pc1+LlnR9OLt1vZUvU455E/NpGU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72CDA138F8
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 21:07:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5K3uCBsbQGUpGAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 21:07:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: do not utilize goto to implement delayed inode ref deletion
Date:   Tue, 31 Oct 2023 07:37:20 +1030
Message-ID: <e81eab657c200a78dd43747fb28e942289082f98.1698698978.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
The function __btrfs_update_delayed_inode() is doing something not
meeting the code standard of today:

	path->slots[0]++
	if (path->slots[0] >= btrfs_header_nritems(leaf))
		goto search;
again:
	if (!is_the_target_inode_ref())
		goto out;
	ret = btrfs_delete_item();
	/* Some cleanup. */
	return ret;

search:
	ret = search_for_the_last_inode_ref();
	goto again;

With the tag named "again", it's pretty common to think it's a loop, but
the truth is, we only need to do the search once, to locate the last
(also the first, since there should only be one INODE_REF or
INODE_EXTREF now) ref of the inode.

[FIX]
Instead of the weird jumps, just do them in a stream-lined fashion.
This removes those weird tags, and add extra comments on why we can do
the different searches.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
CHANGELOG
v2:
- Move the leaf assignment into the if branch where we do the search
  This is where the leaf get updated, no need to update @leaf
  unconditionally which can be confusing.

This is just a cleanup while I was investigating a weird bug inside the
same function.

The bug is, the mentioned function returned -ENOENT and caused
transaction abort.
The weird part is, when that happened (btrfs_lookup_inode() failed) dump
tree (only one case though) showed there is indeed no INODE_ITEM, but we
still have the INODE_REF and even one EXTENT_DATA.

Any clue would be very appreciated.
---
 fs/btrfs/delayed-inode.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index c640f87038a6..0f8fa9751b5d 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1036,14 +1036,34 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 	if (!test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &node->flags))
 		goto out;
 
-	path->slots[0]++;
-	if (path->slots[0] >= btrfs_header_nritems(leaf))
-		goto search;
-again:
+	/*
+	 * Now we're going to delete the INODE_REF/EXTREF, which should be
+	 * the only one ref left.
+	 * Check if the next item is an INODE_REF/EXTREF.
+	 *
+	 * But if we're the last item already, release and search for the last
+	 * INODE_REF/EXTREF
+	 */
+	if (path->slots[0] + 1 >= btrfs_header_nritems(leaf)) {
+		key.objectid = node->inode_id;
+		key.type = BTRFS_INODE_EXTREF_KEY;
+		key.offset = (u64)-1;
+
+		btrfs_release_path(path);
+		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+		if (ret < 0)
+			goto err_out;
+		ASSERT(ret > 0);
+		ASSERT(path->slots[0] > 0);
+		ret = 0;
+		path->slots[0]--;
+		leaf = path->nodes[0];
+	} else {
+		path->slots[0]++;
+	}
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.objectid != node->inode_id)
 		goto out;
-
 	if (key.type != BTRFS_INODE_REF_KEY &&
 	    key.type != BTRFS_INODE_EXTREF_KEY)
 		goto out;
@@ -1070,22 +1090,6 @@ static int __btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
 		btrfs_abort_transaction(trans, ret);
 
 	return ret;
-
-search:
-	btrfs_release_path(path);
-
-	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = -1;
-
-	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
-	if (ret < 0)
-		goto err_out;
-	ASSERT(ret);
-
-	ret = 0;
-	leaf = path->nodes[0];
-	path->slots[0]--;
-	goto again;
 }
 
 static inline int btrfs_update_delayed_inode(struct btrfs_trans_handle *trans,
-- 
2.42.0

