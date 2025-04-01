Return-Path: <linux-btrfs+bounces-12739-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0EA7852C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Apr 2025 01:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CF4188FED4
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 23:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2029C21A45D;
	Tue,  1 Apr 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ljfbVoKA";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QpRqbbhv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF81E9B30
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549517; cv=none; b=JKd/o/7pX+CMrAMlE3srhYiTCfiKmxQLls9x9aTBf6C3ADA54e4DWStEgC8T08SD2tbp3SvsbPSxCXT4pa4T4fG3bsGpUa3cpAZ5X8PLX3dYjomTie1W0c0ZmbEP/5jeiMYH+IFBdH9gNmiwNKYjWKEgRrjWJsaISIRkyKzLfEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549517; c=relaxed/simple;
	bh=glHknq+4C44CNKCMyvTwaN3gvlcDXCZLM9f+Um7iDRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/u4w0EWkSMT2LEDuB5WW+pS31LH54ubaFdoNT7PNZ4q0R0tP5bEiXJqaxo8k3Yw7iYj+R/cQz7WkQizFrTfoC+PnXMXdfK2EaRBhABJ9byr3agrDi3gSDNKBb/YOw++05pdiwtQ6Kq0VW/tril9O5mgLzyuZ6I1YEaoFNgya6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ljfbVoKA; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QpRqbbhv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD0B81F38E;
	Tue,  1 Apr 2025 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743549509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+8QqUdvmVOduA+teUGbgZsIxQQfAIxtNen0IDa/b8E=;
	b=ljfbVoKAfWJJFNKr2AFs9m9+mdixwixFhcOite0ytoT3PlbTtsoCM4Bq6Vm3rY0ZXVhZ+J
	hDmNyfnA5sGFGaPgvrwD5rCZyHJd7PmLk8qFAT1aUGLCHO38U7n+3Djg1EmpqsuBJuC9/G
	oHHCtTd3o7b7OEnn6gVfE2oxR6C01cs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743549508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+8QqUdvmVOduA+teUGbgZsIxQQfAIxtNen0IDa/b8E=;
	b=QpRqbbhvZwggcjQOW4L7AdzEqF0NhTxOG4VlcR5mp8G107YJjTXRdjuFKOWXDq2CaCeZXu
	Ey+EbFuFlRjVIqALBefpmm68E4yM4hxap2Gh7/f+OVD0qfJvZv6GDgHAwyoiwURoCMWjz1
	Mwu2t4kyVzY7FH+jPzQA/IQtDPREnSE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4D0513691;
	Tue,  1 Apr 2025 23:18:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2sU5KER07Ge0ewAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Apr 2025 23:18:28 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/7] btrfs: use BTRFS_PATH_AUTO_FREE in can_nocow_extent()
Date: Wed,  2 Apr 2025 01:18:09 +0200
Message-ID: <af59cc885dde26b21b772174464c692e12ad7a7d.1743549291.git.dsterba@suse.com>
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
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end with simple goto -> return conversions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f862fc8ee52a3..3d0f1aedfa7e23 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7088,7 +7088,7 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct can_nocow_file_extent_args nocow_args = { 0 };
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	int ret;
 	struct extent_buffer *leaf;
 	struct extent_io_tree *io_tree = &inode->io_tree;
@@ -7104,13 +7104,12 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 	ret = btrfs_lookup_file_extent(NULL, root, path, btrfs_ino(inode),
 				       offset, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret == 1) {
 		if (path->slots[0] == 0) {
-			/* can't find the item, must cow */
-			ret = 0;
-			goto out;
+			/* Can't find the item, must COW. */
+			return 0;
 		}
 		path->slots[0]--;
 	}
@@ -7119,17 +7118,17 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	if (key.objectid != btrfs_ino(inode) ||
 	    key.type != BTRFS_EXTENT_DATA_KEY) {
-		/* not our file or wrong item type, must cow */
-		goto out;
+		/* Not our file or wrong item type, must COW. */
+		return 0;
 	}
 
 	if (key.offset > offset) {
-		/* Wrong offset, must cow */
-		goto out;
+		/* Wrong offset, must COW. */
+		return 0;
 	}
 
 	if (btrfs_file_extent_end(path) <= offset)
-		goto out;
+		return 0;
 
 	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	found_type = btrfs_file_extent_type(leaf, fi);
@@ -7144,15 +7143,13 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 
 	if (ret != 1) {
 		/* Treat errors as not being able to NOCOW. */
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
-	ret = 0;
 	if (btrfs_extent_readonly(fs_info,
 				  nocow_args.file_extent.disk_bytenr +
 				  nocow_args.file_extent.offset))
-		goto out;
+		return 0;
 
 	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
@@ -7161,20 +7158,16 @@ noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 		range_end = round_up(offset + nocow_args.file_extent.num_bytes,
 				     root->fs_info->sectorsize) - 1;
 		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
-		if (ret) {
-			ret = -EAGAIN;
-			goto out;
-		}
+		if (ret)
+			return -EAGAIN;
 	}
 
 	if (file_extent)
 		memcpy(file_extent, &nocow_args.file_extent, sizeof(*file_extent));
 
 	*len = nocow_args.file_extent.num_bytes;
-	ret = 1;
-out:
-	btrfs_free_path(path);
-	return ret;
+
+	return 1;
 }
 
 /* The callers of this must take lock_extent() */
-- 
2.48.1


