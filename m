Return-Path: <linux-btrfs+bounces-1759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6474383B3C2
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968D61C22D33
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 21:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8586B13541A;
	Wed, 24 Jan 2024 21:19:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8A132C36
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131152; cv=none; b=tvaqzmYo+WgpReJL/F6jpLpfkjBwHCLWCkrunOQmwyKx2NEN7TtoO6qASFz/85AySn0hecT4xjJvEx0q34QvLzxBIXZffzegLC23Hy7RGVO+9JXzhUaR9BukQNWw4gPcs/KQ4xpvLcAccdn+HuQsyJkHg3dwVmzpVDieWQkXbAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131152; c=relaxed/simple;
	bh=dlwrj/QWvnWmY9yGE/n7WoJL+++VYLXoW42RPSMFgQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdrUpyypMZLhKRN3Jy1yvLem9W9qJ6xcgN9nUc/KHO6Qi9ydHBBVtGTibkYz4SIPZJbIAIHDcb4rrITLVcksRzTMD/BTc2mIYgiS50LKdSkDTzGmx47D49gmDc0CMpAEA2SLzMz/KDzGpXJ483bHxJhxbcu24MawVadjlhgHrOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE05921F87;
	Wed, 24 Jan 2024 21:19:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE47013786;
	Wed, 24 Jan 2024 21:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HiNcMst+sWXwdwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 24 Jan 2024 21:19:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 17/20] btrfs: unify handling of return values of btrfs_insert_empty_items()
Date: Wed, 24 Jan 2024 22:18:46 +0100
Message-ID: <b73ee407b806da6c9fc609d2717f75d76affa514.1706130791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1706130791.git.dsterba@suse.com>
References: <cover.1706130791.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DE05921F87
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The error values returned by btrfs_insert_empty_items() are following
the common patter of 0/-errno, but some callers check for a value > 0,
which can't happen. Document that and update calls to not expect
positive values.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c     | 4 ++++
 fs/btrfs/file-item.c | 3 ---
 fs/btrfs/uuid-tree.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 33145da449cc..c878ca466b7c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4280,6 +4280,10 @@ void btrfs_setup_item_for_insert(struct btrfs_trans_handle *trans,
 /*
  * Given a key and some data, insert items into the tree.
  * This does all the path init required, making room in the tree if needed.
+ *
+ * Returns: 0        on success
+ *          -EEXIST  if the first key already exists
+ *          < 0      on other errors
  */
 int btrfs_insert_empty_items(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 81ac1d474bf1..8f573c8b5a7a 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -179,7 +179,6 @@ int btrfs_insert_hole_extent(struct btrfs_trans_handle *trans,
 				      sizeof(*item));
 	if (ret < 0)
 		goto out;
-	BUG_ON(ret); /* Can't happen */
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0],
 			      struct btrfs_file_extent_item);
@@ -1229,8 +1228,6 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 				      ins_size);
 	if (ret < 0)
 		goto out;
-	if (WARN_ON(ret != 0))
-		goto out;
 	leaf = path->nodes[0];
 csum:
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_csum_item);
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 5be74f9e47eb..d08511695e94 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -114,7 +114,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 
 	ret = btrfs_insert_empty_item(trans, uuid_root, path, &key,
 				      sizeof(subid_le));
-	if (ret >= 0) {
+	if (ret == 0) {
 		/* Add an item for the type for the first time */
 		eb = path->nodes[0];
 		slot = path->slots[0];
-- 
2.42.1


