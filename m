Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DF4473D77
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 08:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhLNHOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 02:14:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbhLNHOa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 02:14:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4927212BA
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 07:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639466069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=jCgXdbgPQyEbhUsII0QFpUo1zgnr8wqcAwBG3zoK6bY=;
        b=iN8zwdhIGM7/fzGWfixY1ZrMOKYye3eKPQ2Fn2Gkosr8+gR9unDVoJVpkTkOSxuE7N2iQj
        CXcREP0b2GmhCj1xJwuce0Zh7kmCH6iaZfuuRP8OIg+FznR/Bbya/0m/RYynaKfPvH5dy6
        PidjaQ9tYj4Zmoy+KxrhU4DRmsOuSG0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 314F113CF7
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 07:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id acrvOlREuGFhcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Dec 2021 07:14:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove some duplicated checks in btrfs_previous_*_item()
Date:   Tue, 14 Dec 2021 15:14:11 +0800
Message-Id: <20211214071411.48324-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_previous_item() and btrfs_previous_extent_item() we check
btrfs_header_nritems() in a loop.

But in fact we don't need to do it in a loop at all.

Firstly, if a tree block is empty, the whole tree is empty and nodes[0]
is the tree root.
We don't need to do anything and can exit immediately.

Secondly, the only timing we could get a slots[0] >= nritems is when the
function get called. After the first slots[0]--, the slot should always
be <= nritems.

So this patch will move all the nritems related checks out of the loop
by:

- Check nritems of nodes[0] to do a quick exit

- Sanitize path->slots[0] before entering the loop
  I doubt if there is any caller setting path->slots[0] beyond
  nritems + 1 (setting to nritems is possible when item is not found).
  Sanitize path->slots[0] to nritems won't hurt anyway.

- Unconditionally reduce path->slots[0]
  Since we're sure all tree blocks should not be empty, and
  btrfs_prev_leaf() will return with path->slots[0] == nritems, we
  can safely reduce slots[0] unconditionally.
  Just keep an extra ASSERT() to make sure no tree block is empty.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 52 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 781537692a4a..555345aed84d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4704,23 +4704,39 @@ int btrfs_previous_item(struct btrfs_root *root,
 {
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
-	u32 nritems;
+	const u32 nritems = btrfs_header_nritems(path->nodes[0]);
 	int ret;
 
+	/*
+	 * Check nritems first, if the tree is empty we exit immediately.
+	 * And if this leave is not empty, none of the tree blocks of this root
+	 * should be empty.
+	 */
+	if (nritems == 0)
+		return 1;
+
+	/*
+	 * If we're several slots beyond nritems, we reset slot to nritems,
+	 * and it will be handled properly inside the loop.
+	 */
+	if (unlikely(path->slots[0] > nritems))
+		path->slots[0] = nritems;
+
 	while (1) {
 		if (path->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
-		} else {
-			path->slots[0]--;
 		}
 		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		if (nritems == 0)
-			return 1;
-		if (path->slots[0] == nritems)
-			path->slots[0]--;
+		ASSERT(btrfs_header_nritems(leaf));
+		/*
+		 * This is for both regular case and above btrfs_prev_leaf() case.
+		 * As btrfs_prev_leaf() will return with path->slots[0] == nritems,
+		 * and we're sure no tree block is empty, we can go safely
+		 * reduce slots[0] here.
+		 */
+		path->slots[0]--;
 
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		if (found_key.objectid < min_objectid)
@@ -4745,23 +4761,27 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 {
 	struct btrfs_key found_key;
 	struct extent_buffer *leaf;
-	u32 nritems;
+	const u32 nritems = btrfs_header_nritems(path->nodes[0]);
 	int ret;
 
+	/*
+	 * Refer to btrfs_previous_item() for the reason of all nritems related
+	 * checks/modifications.
+	 */
+	if (nritems == 0)
+		return 1;
+	if (unlikely(path->slots[0] > nritems))
+		path->slots[0] = nritems;
+
 	while (1) {
 		if (path->slots[0] == 0) {
 			ret = btrfs_prev_leaf(root, path);
 			if (ret != 0)
 				return ret;
-		} else {
-			path->slots[0]--;
 		}
 		leaf = path->nodes[0];
-		nritems = btrfs_header_nritems(leaf);
-		if (nritems == 0)
-			return 1;
-		if (path->slots[0] == nritems)
-			path->slots[0]--;
+		ASSERT(btrfs_header_nritems(leaf));
+		path->slots[0]--;
 
 		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
 		if (found_key.objectid < min_objectid)
-- 
2.34.1

