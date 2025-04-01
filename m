Return-Path: <linux-btrfs+bounces-12738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCD1A7852F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBDC3AFC9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3321579C;
	Tue,  1 Apr 2025 23:18:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66F31A5BB0
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549515; cv=none; b=Oy7hYsUqQU9STbvsMOvLPlxjeUF2xhynn0BKJjBD30LvzHvvnGeXY1yE2TBiHgD7Hb0wYhqUtsm3xDe+Z6ZSdaBZl6PrBzz1GAIO+grc1vbsCp2j1TuudCdYjYWynQamv1OsEWRrXtsetig90lYfCiKbPgu88QMztt3Po36LSLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549515; c=relaxed/simple;
	bh=NL5Pb9uO9ir9J1oMhH5gLkwj9yPmLSG4NtUsHliaZBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwSxx09Dk6Liho+OBhIlWjlAezT4bRSz0tct0Y9sh9ouNY8mlf28nse6AQZ+N8byBVo/o6F+AJCutxpH7T7qXhuR4KpfSM9FdontXp1VtCl1a0oT//MOKAtoHPQ236dMi6F9dhYB5LNRbb7LUnA2Ynq81P4GysLphjh4TITvnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 735A921196;
	Tue,  1 Apr 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B92013691;
	Tue,  1 Apr 2025 23:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4Y9CGkJ07GewewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:26 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/7] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_set_inode_index_count()
Date: Wed,  2 Apr 2025 01:18:08 +0200
Message-ID: <57535857b748f247752bab4b3adfddeb8b0baa68.1743549291.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 735A921196
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b3c2847ddae274..4f862fc8ee52a3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5836,7 +5836,7 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_key key, found_key;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	int ret;
 
@@ -5850,15 +5850,14 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	/* FIXME: we should be able to handle this */
 	if (ret == 0)
-		goto out;
-	ret = 0;
+		return ret;
 
 	if (path->slots[0] == 0) {
 		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
+		return 0;
 	}
 
 	path->slots[0]--;
@@ -5869,13 +5868,12 @@ static int btrfs_set_inode_index_count(struct btrfs_inode *inode)
 	if (found_key.objectid != btrfs_ino(inode) ||
 	    found_key.type != BTRFS_DIR_INDEX_KEY) {
 		inode->index_cnt = BTRFS_DIR_START_INDEX;
-		goto out;
+		return 0;
 	}
 
 	inode->index_cnt = found_key.offset + 1;
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 0;
 }
 
 static int btrfs_get_dir_last_index(struct btrfs_inode *dir, u64 *index)
-- 
2.48.1


