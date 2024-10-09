Return-Path: <linux-btrfs+bounces-8719-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75AC996DFF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204031C219E9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8B31A0B0E;
	Wed,  9 Oct 2024 14:32:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E1199FB4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484346; cv=none; b=AtS2OdBDOHYBtFBtNJk9VwrG9srySrXPWPsWAk5pKfoHa5cJ4pqUdb+xEyaYu3lIURXjpTRdXP0ZHjF+/tsgrXRVzt69BvIPbwg8IRH45RHH83ccVrWsXa4nZkPVseW/CtEcuIalU7lbuIjuvE3QPypwWJWYfxHd9l795VXaC84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484346; c=relaxed/simple;
	bh=Yj78/QFQWU/tnE8ZvyTHPL+LItK/2LuMWDP+CQegbp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M676Yz05h7NBhyCt4jX4iFESY7xIBYqj3eUnTvLofe+WUKzjWPa5yj2i/wou8M4RlhCKOW9H1Y+k8zQ44XAbMgIqRONqguLjMDAQFUTxmwNv2zJlYOo0oWvzjmWjLVJTxUt2sBEHoyhh7WO2sLZV+JmdfgAAEzfVIn+J6d+/gCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8BD21EB2;
	Wed,  9 Oct 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FF1F136BA;
	Wed,  9 Oct 2024 14:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WUiaD/eTBmeTRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 24/25] btrfs: drop unused parameter fs_info from btrfs_match_dir_item_name()
Date: Wed,  9 Oct 2024 16:32:22 +0200
Message-ID: <cb4133727ec448a44cb9fe940bbd172a9423dcc0.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4B8BD21EB2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Cascaded removal of fs_info that is not needed in several functions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/dir-item.c | 11 ++++-------
 fs/btrfs/dir-item.h |  3 +--
 fs/btrfs/send.c     |  3 +--
 fs/btrfs/xattr.c    |  5 ++---
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 001c0c2f872c..d3093eba54a5 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -27,7 +27,6 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 						   const char *name,
 						   int name_len)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	char *ptr;
 	struct extent_buffer *leaf;
@@ -35,7 +34,7 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 	ret = btrfs_insert_empty_item(trans, root, path, cpu_key, data_size);
 	if (ret == -EEXIST) {
 		struct btrfs_dir_item *di;
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(path, name, name_len);
 		if (di)
 			return ERR_PTR(-EEXIST);
 		btrfs_extend_item(trans, path, data_size);
@@ -190,7 +189,7 @@ static struct btrfs_dir_item *btrfs_lookup_match_dir(
 	if (ret > 0)
 		return ERR_PTR(-ENOENT);
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return btrfs_match_dir_item_name(path, name, name_len);
 }
 
 /*
@@ -341,8 +340,7 @@ btrfs_search_dir_index_item(struct btrfs_root *root, struct btrfs_path *path,
 		if (key.objectid != dirid || key.type != BTRFS_DIR_INDEX_KEY)
 			break;
 
-		di = btrfs_match_dir_item_name(root->fs_info, path,
-					       name->name, name->len);
+		di = btrfs_match_dir_item_name(path, name->name, name->len);
 		if (di)
 			return di;
 	}
@@ -378,8 +376,7 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
  * this walks through all the entries in a dir item and finds one
  * for a specific name.
  */
-struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 const struct btrfs_path *path,
+struct btrfs_dir_item *btrfs_match_dir_item_name(const struct btrfs_path *path,
 						 const char *name, int name_len)
 {
 	struct btrfs_dir_item *dir_item;
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 5f6dfafc91f1..28d69970bc70 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -44,8 +44,7 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  struct btrfs_path *path, u64 dir,
 					  const char *name, u16 name_len,
 					  int mod);
-struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
-						 const struct btrfs_path *path,
+struct btrfs_dir_item *btrfs_match_dir_item_name(const struct btrfs_path *path,
 						 const char *name,
 						 int name_len);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 75bcfbda8d47..e3a0293a86b1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3760,7 +3760,6 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 				  struct recorded_ref *parent_ref,
 				  const bool is_orphan)
 {
-	struct btrfs_fs_info *fs_info = sctx->parent_root->fs_info;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_key di_key;
@@ -3789,7 +3788,7 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 		goto out;
 	}
 
-	di = btrfs_match_dir_item_name(fs_info, path, parent_ref->name,
+	di = btrfs_match_dir_item_name(path, parent_ref->name,
 				       parent_ref->name_len);
 	if (!di) {
 		ret = 0;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index ce464cd8e0ac..bc18710d1dcf 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -85,7 +85,6 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 {
 	struct btrfs_dir_item *di = NULL;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	size_t name_len = strlen(name);
 	int ret = 0;
@@ -143,14 +142,14 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 		 */
 		ret = 0;
 		btrfs_assert_tree_write_locked(path->nodes[0]);
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(path, name, name_len);
 		if (!di && !(flags & XATTR_REPLACE)) {
 			ret = -ENOSPC;
 			goto out;
 		}
 	} else if (ret == -EEXIST) {
 		ret = 0;
-		di = btrfs_match_dir_item_name(fs_info, path, name, name_len);
+		di = btrfs_match_dir_item_name(path, name, name_len);
 		ASSERT(di); /* logic error */
 	} else if (ret) {
 		goto out;
-- 
2.45.0


