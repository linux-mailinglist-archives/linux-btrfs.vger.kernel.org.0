Return-Path: <linux-btrfs+bounces-12740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C7A78531
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621773B03A1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C7219306;
	Tue,  1 Apr 2025 23:18:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C771E9B30
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549522; cv=none; b=Lp+IQWhWhhm4yB8ZjQ5IIa+AyawoaF/ks4dWfNpBLCFwZoFPUUZhpmfaU36UQUA8dRLsiwg2LBFW5/Yil8NaQI9Rr4IC1PHC6XJ20oAafWaeQc0L/C/74oG/F9kGvEng0SVkC3FRHUP/hGa44hKuHU/p42s66JHhBLuSLk724UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549522; c=relaxed/simple;
	bh=epaKoU6ZBVLYwO+zBXok813FqRYMF6bVAaGbLNA0uV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5fgshmnacffT8HLStCKrwNWcaJ/XbrCjcDahtoG8DBzDe5LypndFV4VstiDPEKOT5Q3EtUjil17lEHgzJ7E5HIyiZ4leLDPaBgPmC5DTxuos9bI4vPWOYVuhprpT9NGPwDdfWolfZth/u9c4BISC9mdRCikafPpEb0OSV8rBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 256D021193;
	Tue,  1 Apr 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E46B13691;
	Tue,  1 Apr 2025 23:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TV1iB0l07Ge6ewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:33 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 6/7] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_del_inode_extref()
Date: Wed,  2 Apr 2025 01:18:11 +0200
Message-ID: <d605f08d39a7824ca94763f47b0825cf25b58e38.1743549291.git.dsterba@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1743549291.git.dsterba@suse.com>
References: <cover.1743549291.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 256D021193
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode-item.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 3530de0618c8be..b920250e9e8ff7 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -109,7 +109,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 				  u64 inode_objectid, u64 ref_objectid,
 				  u64 *index)
 {
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_inode_extref *extref;
 	struct extent_buffer *leaf;
@@ -129,9 +129,9 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
 	if (ret > 0)
-		ret = -ENOENT;
+		return -ENOENT;
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/*
 	 * Sanity check - did we find the right item for this name?
@@ -142,8 +142,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 						ref_objectid, name);
 	if (!extref) {
 		btrfs_abort_transaction(trans, -ENOENT);
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	leaf = path->nodes[0];
@@ -152,12 +151,8 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 		*index = btrfs_inode_extref_index(leaf, extref);
 
 	if (del_len == item_size) {
-		/*
-		 * Common case only one ref in the item, remove the
-		 * whole item.
-		 */
-		ret = btrfs_del_item(trans, root, path);
-		goto out;
+		/* Common case only one ref in the item, remove the whole item. */
+		return btrfs_del_item(trans, root, path);
 	}
 
 	ptr = (unsigned long)extref;
@@ -168,9 +163,6 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 
 	btrfs_truncate_item(trans, path, item_size - del_len, 1);
 
-out:
-	btrfs_free_path(path);
-
 	return ret;
 }
 
-- 
2.48.1


