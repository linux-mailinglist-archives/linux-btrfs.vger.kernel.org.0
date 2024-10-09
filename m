Return-Path: <linux-btrfs+bounces-8697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D28F996DD1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4599B1F222CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41F15381A;
	Wed,  9 Oct 2024 14:31:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BB2AD1C
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484261; cv=none; b=tOTvvgcK4VUAtT3OeqV43MrXxZ1Wja+97I1TgoedKlNVWO8l/blmdbCezRtaI1O09MU9iud2VmlzDdqddAMONrOES8OQ+SiAY+/lQmmk2wrpr0xbtmQEYqRpP5JDLyfPi2IxGVg5KFzb9uDDF/KkklVdjNIrXmMLBETHcO6g8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484261; c=relaxed/simple;
	bh=usgGjqw5BNMC5y8KbdYdYXkdwQxmg4/VE1Hid99qsgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYwTLqgqlSO3kknuViXpXIoWHH1va0L8R8HM7fx17bGCY/lzQFzp4kr8sxcaoyi0dnyMVg70crs7Vv9dO0aCy92f5Aj9CTfzUQKKLYiYMlhDDdRTW2SSjrbmePCqKvaBnB24jVSnHFeug5I7m0x3q59w37Z140oMyUVTjAVStc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DACB1F7C8;
	Wed,  9 Oct 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6717F136BA;
	Wed,  9 Oct 2024 14:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oh8qGaGTBmf5RAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:30:57 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/25] btrfs: drop unused parameter path from btrfs_tree_mod_log_rewind()
Date: Wed,  9 Oct 2024 16:30:53 +0200
Message-ID: <5e8646018c042ed6fd7d8609689c15d20aa83a00.1728484021.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 6DACB1F7C8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The path parameter was used for our own locking, that got converted to
rwsem eventually. Last usage in ac5887c8e013d6 ("btrfs: locking: remove
all the blocking helpers").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c        | 2 +-
 fs/btrfs/tree-mod-log.c | 1 -
 fs/btrfs/tree-mod-log.h | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..b11ec86102e3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2334,7 +2334,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 
 		level = btrfs_header_level(b);
 		btrfs_tree_read_lock(b);
-		b = btrfs_tree_mod_log_rewind(fs_info, p, b, time_seq);
+		b = btrfs_tree_mod_log_rewind(fs_info, b, time_seq);
 		if (!b) {
 			ret = -ENOMEM;
 			goto done;
diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index b382a4c443d4..1ac2678fc4ca 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -909,7 +909,6 @@ static void tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
  * is freed (its refcount is decremented).
  */
 struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
-						struct btrfs_path *path,
 						struct extent_buffer *eb,
 						u64 time_seq)
 {
diff --git a/fs/btrfs/tree-mod-log.h b/fs/btrfs/tree-mod-log.h
index 6308c577a4a4..1c12566040db 100644
--- a/fs/btrfs/tree-mod-log.h
+++ b/fs/btrfs/tree-mod-log.h
@@ -41,7 +41,6 @@ int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 				  enum btrfs_mod_log_op op);
 int btrfs_tree_mod_log_free_eb(struct extent_buffer *eb);
 struct extent_buffer *btrfs_tree_mod_log_rewind(struct btrfs_fs_info *fs_info,
-						struct btrfs_path *path,
 						struct extent_buffer *eb,
 						u64 time_seq);
 struct extent_buffer *btrfs_get_old_root(struct btrfs_root *root, u64 time_seq);
-- 
2.45.0


