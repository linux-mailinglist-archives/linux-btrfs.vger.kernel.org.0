Return-Path: <linux-btrfs+bounces-12741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9BA7852E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA78E188FFE2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7FE219A90;
	Tue,  1 Apr 2025 23:18:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508C1EE00C
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549526; cv=none; b=Ms9F3UfuweCWjOYiW2ez4SiGbW79kfdRkUCczTaqT11QDPE6wlrxXTel4heaI4rwScO/mmqZ6lZMl66wPimy83TvboOP/RtRdSyoxXvfbE+yQhPWZwrINQVDnOtblxg75wN+5Kft1XLZGfF6NzRAM6nfYVpDcsrZeFxwaQHfqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549526; c=relaxed/simple;
	bh=nNay6KoClJmr5zIvBZz5zEDeL8IKUD1Z07ImiDtf4wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I52igwpkvl66EzRm+h48dh0bWUgR33Dm+xL8B/usPyI+AWtsSflcRIDkvzxFZ8vDg5CmlBEJ/ewgFkW15XH+5sMmxMPH4yrygJqgWOb7ISqXy53C8QOxL6+kgG7UVJ+2n2uHSYUOpRH96MMAk82fUmQpt5P3RaYueuRk1xZx8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4E3E1F445;
	Tue,  1 Apr 2025 23:18:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD00513691;
	Tue,  1 Apr 2025 23:18:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lTPxNUZ07Ge2ewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:30 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_encoded_read_inline()
Date: Wed,  2 Apr 2025 01:18:10 +0200
Message-ID: <0ec23fe7831bc0a0d458687ebb0c551b15ddd821.1743549291.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: E4E3E1F445
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3d0f1aedfa7e23..a4e2193d4f7171 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9080,7 +9080,7 @@ static ssize_t btrfs_encoded_read_inline(
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_io_tree *io_tree = &inode->io_tree;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *item;
 	u64 ram_bytes;
@@ -9090,10 +9090,8 @@ static ssize_t btrfs_encoded_read_inline(
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	path->nowait = nowait;
 
@@ -9102,9 +9100,9 @@ static ssize_t btrfs_encoded_read_inline(
 	if (ret) {
 		if (ret > 0) {
 			/* The extent item disappeared? */
-			ret = -EIO;
+			return -EIO;
 		}
-		goto out;
+		return ret;
 	}
 	leaf = path->nodes[0];
 	item = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
@@ -9117,17 +9115,16 @@ static ssize_t btrfs_encoded_read_inline(
 	ret = btrfs_encoded_io_compression_from_extent(fs_info,
 				 btrfs_file_extent_compression(leaf, item));
 	if (ret < 0)
-		goto out;
+		return ret;
 	encoded->compression = ret;
 	if (encoded->compression) {
 		size_t inline_size;
 
 		inline_size = btrfs_file_extent_inline_item_len(leaf,
 								path->slots[0]);
-		if (inline_size > count) {
-			ret = -ENOBUFS;
-			goto out;
-		}
+		if (inline_size > count)
+			return -ENOBUFS;
+
 		count = inline_size;
 		encoded->unencoded_len = ram_bytes;
 		encoded->unencoded_offset = iocb->ki_pos - extent_start;
@@ -9139,10 +9136,9 @@ static ssize_t btrfs_encoded_read_inline(
 	}
 
 	tmp = kmalloc(count, GFP_NOFS);
-	if (!tmp) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!tmp)
+		return -ENOMEM;
+
 	read_extent_buffer(leaf, tmp, ptr, count);
 	btrfs_release_path(path);
 	unlock_extent(io_tree, start, lockend, cached_state);
@@ -9153,8 +9149,7 @@ static ssize_t btrfs_encoded_read_inline(
 	if (ret != count)
 		ret = -EFAULT;
 	kfree(tmp);
-out:
-	btrfs_free_path(path);
+
 	return ret;
 }
 
-- 
2.48.1


