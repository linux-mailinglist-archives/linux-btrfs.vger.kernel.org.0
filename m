Return-Path: <linux-btrfs+bounces-18376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683BAC12A24
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 03:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7064F566EF0
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Oct 2025 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA855192B7D;
	Tue, 28 Oct 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GRk7z986";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GRk7z986"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6A40855
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617370; cv=none; b=sekiFjT0wkiQlmP03uvTw1p0bnrkRuTZM54J9AueKAro2mk8sX8G0ckGeOPnch/rb7o3zUOFlWY8g+/2tWSVs2BZEM5hwMV6mT+4G3dSHGZezsZC+SIgdiji4zNj3LATtCaTJ6G0+55ao3OLPWgdx1X++6ISYZRlv/HEjQBGuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617370; c=relaxed/simple;
	bh=8w21Xv03EnkXUjJGqUmTa0mI/dY62NlGES+QAxT5OIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uhoVQY8q5w/KyxuSsGPirlxcQe3bJlKJNAPqQDCZgM7Y4RXb34+1ZreApBk18FrjCPhS3xKd3DML9ihUCUmklgZl0/K90i5ZAuVGXdYH3ZhadeWxLlrnMIM7ek0rI+KnVhwH9kXneoS5oWHlioVXbSO2W2xNTdHKRf1DqspahV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GRk7z986; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GRk7z986; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AD951F385
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 02:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761617366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dZSUDsn0snmshB97mQT8kdaPgesbgqa8E2Fecl+MwMA=;
	b=GRk7z986hibTVhItJxuUD/PLTDfvMFZDyBkFhmmLXJgJ4WQLhLLfyGtfjh9uRrZ5WqvfXR
	kptVu5l3iKO8FDz48wRxUwayO0R243iy+qoJ/eTDpADLnIlbab+htTyB6+DlBZ5D3wEavx
	ploxSF/bUvEYPnNE6KUZsXzZfIiC0wg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GRk7z986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761617366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dZSUDsn0snmshB97mQT8kdaPgesbgqa8E2Fecl+MwMA=;
	b=GRk7z986hibTVhItJxuUD/PLTDfvMFZDyBkFhmmLXJgJ4WQLhLLfyGtfjh9uRrZ5WqvfXR
	kptVu5l3iKO8FDz48wRxUwayO0R243iy+qoJ/eTDpADLnIlbab+htTyB6+DlBZ5D3wEavx
	ploxSF/bUvEYPnNE6KUZsXzZfIiC0wg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75A9813A70
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 02:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nMY4DtUlAGmfNgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 28 Oct 2025 02:09:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: headers cleanup to remove unnecessary local includes
Date: Tue, 28 Oct 2025 12:39:07 +1030
Message-ID: <94729544d1f85c108b3b34609f42cd3b09cdc5da.1761617310.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3AD951F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[BUG]
When I tried to remove btrfs_bio::fs_info and use btrfs_bio::inode to
grab the fs_info, the header "btrfs_inode.h" is needed to access the
full btrfs_inode structure.

Then btrfs will fail to compile.

[CAUSE]
There is a recursive including chain:

  "bio.h" -> "btrfs_inode.h" -> "extent_map.h" -> "compression.h" ->
  "bio.h"

That recursive including is causing problems for btrfs.

[ENHANCEMENT]
To reduce the risk of recursive including:

- Remove unnecessary local includes from btrfs headers
  Either the included header is pulled in by other headers, or is
  completely unnecessary.

- Remove btrfs local includes if the header only requires a pointer
  In that case let the implementing C file to pull the required header.

  This is especially important for headers like "btrfs_inode.h" which
  pulls in a lot of other btrfs headers, thus it's a mine field of
  recursive including.

- Remove unnecessary temporary structure definition
  Either if we have included the header defining the structure, or
  completely unused.

Now including "btrfs_inode.h" inside "bio.h" is completely fine,
although "btrfs_inode.h" still includes "extent_map.h", but that header
only includes "fs.h", no more chain back to "bio.h".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h   | 1 +
 fs/btrfs/btrfs_inode.h | 8 ++++----
 fs/btrfs/compression.h | 3 ---
 fs/btrfs/ctree.h       | 2 --
 fs/btrfs/defrag.c      | 1 +
 fs/btrfs/dir-item.c    | 1 +
 fs/btrfs/direct-io.c   | 2 ++
 fs/btrfs/disk-io.c     | 1 +
 fs/btrfs/disk-io.h     | 3 ++-
 fs/btrfs/extent-tree.c | 1 +
 fs/btrfs/extent_io.h   | 1 -
 fs/btrfs/extent_map.h  | 3 +--
 fs/btrfs/file-item.h   | 2 +-
 fs/btrfs/inode.c       | 1 +
 fs/btrfs/space-info.c  | 1 +
 fs/btrfs/subpage.h     | 1 -
 fs/btrfs/transaction.c | 2 ++
 fs/btrfs/transaction.h | 4 ----
 fs/btrfs/tree-log.c    | 1 +
 fs/btrfs/tree-log.h    | 3 +--
 fs/btrfs/zoned.h       | 1 -
 21 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 99b3ced12805..78721412951c 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
 #include "extent_io.h"
 
 struct extent_buffer;
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index af373d50a901..a66ca5531b5c 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -18,20 +18,20 @@
 #include <linux/lockdep.h>
 #include <uapi/linux/btrfs_tree.h>
 #include <trace/events/btrfs.h>
+#include "ctree.h"
 #include "block-rsv.h"
 #include "extent_map.h"
-#include "extent_io.h"
 #include "extent-io-tree.h"
-#include "ordered-data.h"
-#include "delayed-inode.h"
 
-struct extent_state;
 struct posix_acl;
 struct iov_iter;
 struct writeback_control;
 struct btrfs_root;
 struct btrfs_fs_info;
 struct btrfs_trans_handle;
+struct btrfs_bio;
+struct btrfs_file_extent;
+struct btrfs_delayed_node;
 
 /*
  * Since we search a directory based on f_pos (struct dir_context::pos) we have
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index eba188a9e3bb..c6812d5fcab7 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -14,14 +14,11 @@
 #include <linux/pagemap.h>
 #include "bio.h"
 #include "fs.h"
-#include "messages.h"
 
 struct address_space;
-struct page;
 struct inode;
 struct btrfs_inode;
 struct btrfs_ordered_extent;
-struct btrfs_bio;
 
 /*
  * We want to make sure that amount of RAM required to uncompress an extent is
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index fe70b593c7cd..16dd11c48531 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -17,9 +17,7 @@
 #include <linux/refcount.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "locking.h"
-#include "fs.h"
 #include "accessors.h"
-#include "extent-io-tree.h"
 
 struct extent_buffer;
 struct btrfs_block_rsv;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 7b277934f66f..a4cc1bc63562 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -15,6 +15,7 @@
 #include "defrag.h"
 #include "file-item.h"
 #include "super.h"
+#include "compression.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 69863e398e22..77e1bcb2a74b 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -9,6 +9,7 @@
 #include "transaction.h"
 #include "accessors.h"
 #include "dir-item.h"
+#include "delayed-inode.h"
 
 /*
  * insert a name into a directory, doing overflow properly if there is a hash
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..8888ef4ae606 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -10,6 +10,8 @@
 #include "fs.h"
 #include "transaction.h"
 #include "volumes.h"
+#include "bio.h"
+#include "ordered-data.h"
 
 struct btrfs_dio_data {
 	ssize_t submitted;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..46b715f3447b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -50,6 +50,7 @@
 #include "relocation.h"
 #include "scrub.h"
 #include "super.h"
+#include "delayed-inode.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 57920f2c6fe4..5320da83d0cf 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -9,7 +9,8 @@
 #include <linux/sizes.h>
 #include <linux/compiler_types.h>
 #include "ctree.h"
-#include "fs.h"
+#include "bio.h"
+#include "ordered-data.h"
 
 struct block_device;
 struct super_block;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f981ff72fb98..be8cb3bdc166 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -40,6 +40,7 @@
 #include "orphan.h"
 #include "tree-checker.h"
 #include "raid-stripe-tree.h"
+#include "delayed-inode.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5fcbfe44218c..02ebb2f238af 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -12,7 +12,6 @@
 #include <linux/rwsem.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-#include "compression.h"
 #include "messages.h"
 #include "ulist.h"
 #include "misc.h"
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index d4b81ee4d97b..6f685f3c9327 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -8,8 +8,7 @@
 #include <linux/rbtree.h>
 #include <linux/list.h>
 #include <linux/refcount.h>
-#include "misc.h"
-#include "compression.h"
+#include "fs.h"
 
 struct btrfs_inode;
 struct btrfs_fs_info;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 63216c43676d..0d59e830018a 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -7,7 +7,7 @@
 #include <linux/list.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "ctree.h"
-#include "accessors.h"
+#include "ordered-data.h"
 
 struct extent_map;
 struct btrfs_file_extent_item;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03e9c3ac20ed..2ca7a34fc73b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -71,6 +71,7 @@
 #include "backref.h"
 #include "raid-stripe-tree.h"
 #include "fiemap.h"
+#include "delayed-inode.h"
 
 #define COW_FILE_RANGE_KEEP_LOCKED	(1UL << 0)
 #define COW_FILE_RANGE_NO_INLINE	(1UL << 1)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index cc8015c8b1ff..63d14b5dfc6c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -15,6 +15,7 @@
 #include "accessors.h"
 #include "extent-tree.h"
 #include "zoned.h"
+#include "delayed-inode.h"
 
 /*
  * HOW DOES SPACE RESERVATION WORK
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index ad0552db7c7d..d81a0ade559f 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -7,7 +7,6 @@
 #include <linux/atomic.h>
 #include <linux/sizes.h>
 #include "btrfs_inode.h"
-#include "fs.h"
 
 struct address_space;
 struct folio;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 907f2d047b44..03c62fd1a091 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -32,6 +32,8 @@
 #include "ioctl.h"
 #include "relocation.h"
 #include "scrub.h"
+#include "ordered-data.h"
+#include "delayed-inode.h"
 
 static struct kmem_cache *btrfs_trans_handle_cachep;
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 9f7c777af635..18ef069197e5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -14,10 +14,6 @@
 #include <linux/wait.h>
 #include "btrfs_inode.h"
 #include "delayed-ref.h"
-#include "extent-io-tree.h"
-#include "block-rsv.h"
-#include "messages.h"
-#include "misc.h"
 
 struct dentry;
 struct inode;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8dfd504b37ae..afaf96a76e3f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -29,6 +29,7 @@
 #include "orphan.h"
 #include "print-tree.h"
 #include "tree-checker.h"
+#include "delayed-inode.h"
 
 #define MAX_CONFLICT_INODES 10
 
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index dc313e6bb2fa..4f149d7d4fde 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -8,8 +8,7 @@
 
 #include <linux/list.h>
 #include <linux/fs.h>
-#include "messages.h"
-#include "ctree.h"
+#include <linux/fscrypt.h>
 #include "transaction.h"
 
 struct inode;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index d64f7c9255fa..5cefdeb08b7b 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -15,7 +15,6 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "btrfs_inode.h"
-#include "fs.h"
 
 struct block_device;
 struct extent_buffer;
-- 
2.51.0


