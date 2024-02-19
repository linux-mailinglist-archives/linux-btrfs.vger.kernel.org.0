Return-Path: <linux-btrfs+bounces-2492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2699A85A1AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ACA1C213F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D332C197;
	Mon, 19 Feb 2024 11:13:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10342C1A7
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341210; cv=none; b=TIppMQkh99rIDw/FQWNc+5H1Ou0F0RDJEp/XZPJBtBy3We0JzOXc6xMnTW/4Wakg8HAYR2RPHYCwUuBA8QFGg616Xwd6DKXgM3NOX9PDBdvC5wOXlkK+MPbpTon//PJ1aKdgsckF7nxDHYl3m7Uyw1kfdkHjpO+h7SIfC3EhfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341210; c=relaxed/simple;
	bh=E3J5EdY+VsU+foO/gXvJFFxshUZfre5kqdmy0Q/jN68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCe2U4Q0t/gMxN83HGmm4gilBkmoSgobWkZPbvnQQNWqFHNB7SoRCWXJrCSIWmcKruMtC7iNfeC9NdKZdtN0H7udtZQ+OxeEhjw5/5wuOeL3zo15MinViAr8uL4MZ/0PaoAdj6hiVFVIqB7F+a6o9lpQ28h1j94kL6/1TQA0jBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75EC01FD0F;
	Mon, 19 Feb 2024 11:13:27 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7011E139C6;
	Mon, 19 Feb 2024 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4VRaG9c302WHZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/10] btrfs: open code btrfs_backref_get_eb()
Date: Mon, 19 Feb 2024 12:12:52 +0100
Message-ID: <069e65b3bddad3e52705fae6157135d682be0919.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 75EC01FD0F
X-Spam-Flag: NO

The helper is trivial, we can inline it. It's safe to remove the 'if' as
the iterator is always valid when used, the potential NULL was never
checked anyway.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 4 ++--
 fs/btrfs/backref.h | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index fe05e2f55bf7..1b57c8289de6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2960,7 +2960,7 @@ int btrfs_backref_iter_start(struct btrfs_backref_iter *iter, u64 bytenr)
  */
 int btrfs_backref_iter_next(struct btrfs_backref_iter *iter)
 {
-	struct extent_buffer *eb = btrfs_backref_get_eb(iter);
+	struct extent_buffer *eb = iter->path->nodes[0];
 	struct btrfs_root *extent_root;
 	struct btrfs_path *path = iter->path;
 	struct btrfs_extent_inline_ref *iref;
@@ -3438,7 +3438,7 @@ int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
 		int type;
 
 		cond_resched();
-		eb = btrfs_backref_get_eb(iter);
+		eb = iter->path->nodes[0];
 
 		key.objectid = iter->bytenr;
 		if (btrfs_backref_iter_is_inline_ref(iter)) {
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 493ea47db426..04b82c512bf1 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -283,14 +283,6 @@ struct btrfs_backref_iter {
 
 struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_info *fs_info);
 
-static inline struct extent_buffer *btrfs_backref_get_eb(
-		struct btrfs_backref_iter *iter)
-{
-	if (!iter)
-		return NULL;
-	return iter->path->nodes[0];
-}
-
 /*
  * For metadata with EXTENT_ITEM key (non-skinny) case, the first inline data
  * is btrfs_tree_block_info, without a btrfs_extent_inline_ref header.
-- 
2.42.1


