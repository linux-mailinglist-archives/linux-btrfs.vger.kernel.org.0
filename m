Return-Path: <linux-btrfs+bounces-20172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354B7CF9590
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31651303899F
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C16329378;
	Tue,  6 Jan 2026 16:21:31 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15427B50F
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716490; cv=none; b=Cdp+FS+737ZSa70pWpOvLhKJpJpucu/NRzt0Xr7oS9Xp/Vv/+zI6Io0c91uKQxTng3ThAkT6wH11BM+bDV1/6ZRNFNe/OHjRo7o/T8mQMecI6WVoYhaCy/+mZaHr/X8ZUS+QxL+RYCO4lgKCy/DAjW9zsLiTpG4H7997CcHbYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716490; c=relaxed/simple;
	bh=+kisj/5mRdbp9GMWK5wFdKpjoN1S/Tu+opD71R4v1gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwWo8+XpbO8k7E3mzoty+g8qUsw5KtfJ3awmTqeYrltDA7y8G+vJnROcV1imswdJVVKVyMLb997fEUk7rmFOmu+2AJLhDfZpMjZClT6I+NqgWsVAV64Hcoi+e494gyPX1R8Vw+s5KqPc/NDEq3KXlB7knWy77eIPT1XUItlKMA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BBE5336A2;
	Tue,  6 Jan 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15D723EA63;
	Tue,  6 Jan 2026 16:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPBSBXE2XWm9WQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:05 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/12] btrfs: zlib: don't cache sectorsize in a local variable
Date: Tue,  6 Jan 2026 17:20:31 +0100
Message-ID: <81eb1c802d917f865de33a456c438d62e1859bc5.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 1BBE5336A2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The sectorsize is used once or at most twice in the callbacks, no need
to cache it on stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zlib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index d1a680da26ba53..bb4a9f70714682 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -71,7 +71,6 @@ static bool need_special_buffer(struct btrfs_fs_info *fs_info)
 
 struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned int level)
 {
-	const u32 blocksize = fs_info->sectorsize;
 	struct workspace *workspace;
 	int workspacesize;
 
@@ -91,8 +90,8 @@ struct list_head *zlib_alloc_workspace(struct btrfs_fs_info *fs_info, unsigned i
 		workspace->buf_size = ZLIB_DFLTCC_BUF_SIZE;
 	}
 	if (!workspace->buf) {
-		workspace->buf = kmalloc(blocksize, GFP_KERNEL);
-		workspace->buf_size = blocksize;
+		workspace->buf = kmalloc(fs_info->sectorsize, GFP_KERNEL);
+		workspace->buf_size = fs_info->sectorsize;
 	}
 	if (!workspace->strm.workspace || !workspace->buf)
 		goto fail;
@@ -161,7 +160,6 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios << min_folio_shift;
-	const u32 blocksize = fs_info->sectorsize;
 	const u64 orig_end = start + len;
 
 	*out_folios = 0;
@@ -248,7 +246,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		}
 
 		/* we're making it bigger, give up */
-		if (workspace->strm.total_in > blocksize * 2 &&
+		if (workspace->strm.total_in > fs_info->sectorsize * 2 &&
 		    workspace->strm.total_in <
 		    workspace->strm.total_out) {
 			ret = -E2BIG;
-- 
2.51.1


