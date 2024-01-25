Return-Path: <linux-btrfs+bounces-1801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AB283C8E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718891C21831
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 16:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9AF130E55;
	Thu, 25 Jan 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eo47xW18";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eo47xW18"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B8145B17
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201164; cv=none; b=TEw8l0Z6+xTFq8KayoZLu/4vDWPTyQ0wWdqbb5+PHCT8ndwrGoUfAEJ4Vy+r7K9NxXClTX6TMSkjxOhr8ujsrBk6uorH4RM9OhCuGNX2mIdXP/i/sKSjo9Dz8FyHxBfrzVIJHtK7xZHOg2x1WrrwswBwqkxgqhfJvniVYyMfrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201164; c=relaxed/simple;
	bh=5FbnX2eb+sh0fUWfYCNK4GrQhSla9FVNNEldouptL9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPJcXXn4MoGQSELyyTvtjF0YTz3kX4oLKL7MqEexf3Qb+Gw90i2hYLOGzI1OVHbfmW97DGIigNSH4IRKhg+XP52PMoCQanQS/f6nfPEpje/O6sFaAKWlbjNeIL7C9u7TF+pk4ChQReODcE4DdGMxO9Ty9N5Ki1QrUE3KNuAPxVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eo47xW18; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eo47xW18; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9A18220AF;
	Thu, 25 Jan 2024 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706201159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lRbUsd93K/cr+xolxn4WC2m4kLcqJpp8lbfF9FhJDmw=;
	b=eo47xW18tYr5spq41K0wjWL2oazqp5w2j08HrABFAr1pZp8KYpyvlHM0x+LVIn5bbS1Sd6
	JVPKaRXPeEosmiDx4MqKU8aLhh5C+KLOmEKu9hx3MnHjTtFXlH3+Ppae08t68KP1Gvb31V
	0q50/zzSRQfsG5yvUZ3PY+dv9EwA1hM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706201159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lRbUsd93K/cr+xolxn4WC2m4kLcqJpp8lbfF9FhJDmw=;
	b=eo47xW18tYr5spq41K0wjWL2oazqp5w2j08HrABFAr1pZp8KYpyvlHM0x+LVIn5bbS1Sd6
	JVPKaRXPeEosmiDx4MqKU8aLhh5C+KLOmEKu9hx3MnHjTtFXlH3+Ppae08t68KP1Gvb31V
	0q50/zzSRQfsG5yvUZ3PY+dv9EwA1hM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2C6C134C3;
	Thu, 25 Jan 2024 16:45:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CTmDL0eQsmU/AQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 25 Jan 2024 16:45:59 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove unused included headers
Date: Thu, 25 Jan 2024 17:44:47 +0100
Message-ID: <20240125164448.18552-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=eo47xW18
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: C9A18220AF
X-Spam-Flag: NO

With help of neovim, LSP and clangd we can identify header files that
are not actually needed to be included in the .c files. This is focused
only on removal (with minor fixups), further cleanups are possible but
will require doing the header files properly with forward declarations,
minimized includes and include-what-you-use care.

Signed-off-by: David Sterba <dsterba@suse.com>
---

I did extensive build checks with various config options turned on/off,
this will become part of our CI eventually.

 fs/btrfs/accessors.c        | 3 ++-
 fs/btrfs/acl.c              | 1 -
 fs/btrfs/async-thread.c     | 1 -
 fs/btrfs/bio.c              | 1 -
 fs/btrfs/block-rsv.c        | 1 -
 fs/btrfs/compression.c      | 5 +----
 fs/btrfs/defrag.c           | 1 -
 fs/btrfs/delalloc-space.c   | 2 --
 fs/btrfs/dev-replace.c      | 2 --
 fs/btrfs/disk-io.c          | 1 -
 fs/btrfs/export.c           | 1 -
 fs/btrfs/extent-io-tree.c   | 1 -
 fs/btrfs/extent-tree.c      | 5 +----
 fs/btrfs/extent_io.c        | 2 --
 fs/btrfs/extent_map.c       | 1 -
 fs/btrfs/file-item.c        | 3 ---
 fs/btrfs/file-item.h        | 2 ++
 fs/btrfs/file.c             | 2 --
 fs/btrfs/free-space-cache.c | 2 --
 fs/btrfs/fs.h               | 1 -
 fs/btrfs/inode-item.c       | 1 -
 fs/btrfs/inode.c            | 2 --
 fs/btrfs/ioctl.c            | 4 ----
 fs/btrfs/locking.c          | 1 -
 fs/btrfs/messages.c         | 2 --
 fs/btrfs/ordered-data.c     | 1 -
 fs/btrfs/orphan.c           | 1 -
 fs/btrfs/raid-stripe-tree.c | 1 -
 fs/btrfs/raid56.c           | 1 -
 fs/btrfs/root-tree.c        | 1 -
 fs/btrfs/send.c             | 1 -
 fs/btrfs/space-info.c       | 1 -
 fs/btrfs/super.c            | 2 --
 fs/btrfs/transaction.c      | 2 --
 fs/btrfs/tree-checker.c     | 2 --
 fs/btrfs/tree-log.c         | 2 --
 fs/btrfs/ulist.c            | 1 -
 fs/btrfs/uuid-tree.c        | 1 -
 fs/btrfs/verity.c           | 1 -
 fs/btrfs/volumes.c          | 2 --
 fs/btrfs/zoned.c            | 2 --
 fs/btrfs/zstd.c             | 1 -
 42 files changed, 6 insertions(+), 65 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 6eb850ad37d2..79026917db19 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -5,7 +5,8 @@
 
 #include <asm/unaligned.h>
 #include "messages.h"
-#include "ctree.h"
+#include "extent_io.h"
+#include "fs.h"
 #include "accessors.h"
 
 static bool check_setget_bounds(const struct extent_buffer *eb,
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index 7427449a04a3..e0ba00d64ea0 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -12,7 +12,6 @@
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include "ctree.h"
-#include "btrfs_inode.h"
 #include "xattr.h"
 #include "acl.h"
 
diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 9e261aac671e..361a866c1995 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -11,7 +11,6 @@
 #include <linux/freezer.h>
 #include <trace/events/btrfs.h>
 #include "async-thread.h"
-#include "ctree.h"
 
 enum {
 	WORK_DONE_BIT,
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2d20215548db..960b81718e29 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -11,7 +11,6 @@
 #include "raid56.h"
 #include "async-thread.h"
 #include "dev-replace.h"
-#include "rcu-string.h"
 #include "zoned.h"
 #include "file-item.h"
 #include "raid-stripe-tree.h"
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ceb5f586a2d5..27207dad27c2 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -6,7 +6,6 @@
 #include "space-info.h"
 #include "transaction.h"
 #include "block-group.h"
-#include "disk-io.h"
 #include "fs.h"
 #include "accessors.h"
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 68345f73d429..488089acd49f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -25,8 +25,6 @@
 #include "misc.h"
 #include "ctree.h"
 #include "fs.h"
-#include "disk-io.h"
-#include "transaction.h"
 #include "btrfs_inode.h"
 #include "bio.h"
 #include "ordered-data.h"
@@ -34,8 +32,7 @@
 #include "extent_io.h"
 #include "extent_map.h"
 #include "subpage.h"
-#include "zoned.h"
-#include "file-item.h"
+#include "messages.h"
 #include "super.h"
 
 static struct bio_set btrfs_compressed_bioset;
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index dd1b5a060366..8fc8118c3225 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -6,7 +6,6 @@
 #include <linux/sched.h>
 #include "ctree.h"
 #include "disk-io.h"
-#include "print-tree.h"
 #include "transaction.h"
 #include "locking.h"
 #include "accessors.h"
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 2833e8ef4c09..4a60a679d7b4 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -6,9 +6,7 @@
 #include "block-rsv.h"
 #include "btrfs_inode.h"
 #include "space-info.h"
-#include "transaction.h"
 #include "qgroup.h"
-#include "block-group.h"
 #include "fs.h"
 
 /*
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 1502d664c892..a13e1a91870e 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -11,10 +11,8 @@
 #include <linux/math64.h>
 #include "misc.h"
 #include "ctree.h"
-#include "extent_map.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "print-tree.h"
 #include "volumes.h"
 #include "async-thread.h"
 #include "dev-replace.h"
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 51c6127508af..db71b3eb12a2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -29,7 +29,6 @@
 #include "tree-log.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
-#include "rcu-string.h"
 #include "dev-replace.h"
 #include "raid56.h"
 #include "sysfs.h"
diff --git a/fs/btrfs/export.c b/fs/btrfs/export.c
index 744a02b7fd67..3f2e8fb9e3e9 100644
--- a/fs/btrfs/export.c
+++ b/fs/btrfs/export.c
@@ -5,7 +5,6 @@
 #include "ctree.h"
 #include "disk-io.h"
 #include "btrfs_inode.h"
-#include "print-tree.h"
 #include "export.h"
 #include "accessors.h"
 #include "super.h"
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 1544e7b1eaed..6b923c0ef4ea 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -6,7 +6,6 @@
 #include "ctree.h"
 #include "extent-io-tree.h"
 #include "btrfs_inode.h"
-#include "misc.h"
 
 static struct kmem_cache *extent_state_cache;
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8e8cc1111277..f4ab437d4160 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -18,7 +18,7 @@
 #include <linux/crc32c.h>
 #include "ctree.h"
 #include "extent-tree.h"
-#include "tree-log.h"
+#include "transaction.h"
 #include "disk-io.h"
 #include "print-tree.h"
 #include "volumes.h"
@@ -26,14 +26,11 @@
 #include "locking.h"
 #include "free-space-cache.h"
 #include "free-space-tree.h"
-#include "sysfs.h"
 #include "qgroup.h"
 #include "ref-verify.h"
 #include "space-info.h"
 #include "block-rsv.h"
-#include "delalloc-space.h"
 #include "discard.h"
-#include "rcu-string.h"
 #include "zoned.h"
 #include "dev-replace.h"
 #include "fs.h"
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c1b15a8efef5..8648ea9b5fb5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -14,7 +14,6 @@
 #include <linux/pagevec.h>
 #include <linux/prefetch.h>
 #include <linux/fsverity.h>
-#include "misc.h"
 #include "extent_io.h"
 #include "extent-io-tree.h"
 #include "extent_map.h"
@@ -22,7 +21,6 @@
 #include "btrfs_inode.h"
 #include "bio.h"
 #include "locking.h"
-#include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
 #include "subpage.h"
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b61099bf97a8..e9b20fbbdfca 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -5,7 +5,6 @@
 #include <linux/spinlock.h>
 #include "messages.h"
 #include "ctree.h"
-#include "volumes.h"
 #include "extent_map.h"
 #include "compression.h"
 #include "btrfs_inode.h"
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 81ac1d474bf1..f7ef9fa469b9 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -10,17 +10,14 @@
 #include <linux/sched/mm.h>
 #include <crypto/hash.h>
 #include "messages.h"
-#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
 #include "bio.h"
-#include "print-tree.h"
 #include "compression.h"
 #include "fs.h"
 #include "accessors.h"
 #include "file-item.h"
-#include "super.h"
 
 #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
 				   sizeof(struct btrfs_item) * 2) / \
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 04bd2d34efb1..606731bef247 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -5,6 +5,8 @@
 
 #include "accessors.h"
 
+struct extent_map;
+
 #define BTRFS_FILE_EXTENT_INLINE_DATA_START		\
 		(offsetof(struct btrfs_file_extent_item, disk_bytenr))
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bd8d13740f41..4bca37fd6833 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -22,10 +22,8 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "print-tree.h"
 #include "tree-log.h"
 #include "locking.h"
-#include "volumes.h"
 #include "qgroup.h"
 #include "compression.h"
 #include "delalloc-space.h"
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d372c7ce0e6b..f74b13f9b193 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -19,9 +19,7 @@
 #include "transaction.h"
 #include "disk-io.h"
 #include "extent_io.h"
-#include "volumes.h"
 #include "space-info.h"
-#include "delalloc-space.h"
 #include "block-group.h"
 #include "discard.h"
 #include "subpage.h"
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index f8bb73d6ab68..b747134fac77 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -8,7 +8,6 @@
 #include <linux/btrfs_tree.h>
 #include <linux/sizes.h>
 #include "extent-io-tree.h"
-#include "extent_map.h"
 #include "async-thread.h"
 #include "block-rsv.h"
 
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 7d734830e514..9c1394c0a6d7 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -9,7 +9,6 @@
 #include "inode-item.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "print-tree.h"
 #include "space-info.h"
 #include "accessors.h"
 #include "extent-tree.h"
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bedd8703bfa6..6734717350e3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -39,14 +39,12 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "print-tree.h"
 #include "ordered-data.h"
 #include "xattr.h"
 #include "tree-log.h"
 #include "bio.h"
 #include "compression.h"
 #include "locking.h"
-#include "free-space-cache.h"
 #include "props.h"
 #include "qgroup.h"
 #include "delalloc-space.h"
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3d476decde52..46f9a6645bf6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -34,11 +34,9 @@
 #include "export.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "print-tree.h"
 #include "volumes.h"
 #include "locking.h"
 #include "backref.h"
-#include "rcu-string.h"
 #include "send.h"
 #include "dev-replace.h"
 #include "props.h"
@@ -47,9 +45,7 @@
 #include "tree-log.h"
 #include "compression.h"
 #include "space-info.h"
-#include "delalloc-space.h"
 #include "block-group.h"
-#include "subpage.h"
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 74d8e2003f58..286e6aa721c7 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -13,7 +13,6 @@
 #include "ctree.h"
 #include "extent_io.h"
 #include "locking.h"
-#include "accessors.h"
 
 /*
  * Lockdep class keys for extent_buffer->lock's in this root.  For a given
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index cdada4865837..c96dd66fd0f7 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -3,8 +3,6 @@
 #include "fs.h"
 #include "messages.h"
 #include "discard.h"
-#include "transaction.h"
-#include "space-info.h"
 #include "super.h"
 
 #ifdef CONFIG_PRINTK
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 59850dc17b22..de12c282e69b 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -19,7 +19,6 @@
 #include "qgroup.h"
 #include "subpage.h"
 #include "file.h"
-#include "super.h"
 
 static struct kmem_cache *btrfs_ordered_extent_cache;
 
diff --git a/fs/btrfs/orphan.c b/fs/btrfs/orphan.c
index 7a1b021b5669..6195a2215b8f 100644
--- a/fs/btrfs/orphan.c
+++ b/fs/btrfs/orphan.c
@@ -4,7 +4,6 @@
  */
 
 #include "ctree.h"
-#include "disk-io.h"
 #include "orphan.h"
 
 int btrfs_insert_orphan_item(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 9589362acfbf..6af6b4b9a32e 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -11,7 +11,6 @@
 #include "disk-io.h"
 #include "raid-stripe-tree.h"
 #include "volumes.h"
-#include "misc.h"
 #include "print-tree.h"
 
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 792c8e17c31d..5c4bf3f907c1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -14,7 +14,6 @@
 #include <linux/raid/xor.h>
 #include <linux/mm.h>
 #include "messages.h"
-#include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
 #include "volumes.h"
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 603ad1459368..3f6d10eb1aaf 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -10,7 +10,6 @@
 #include "messages.h"
 #include "transaction.h"
 #include "disk-io.h"
-#include "print-tree.h"
 #include "qgroup.h"
 #include "space-info.h"
 #include "accessors.h"
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 141ab89fb63e..14ea30850739 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -25,7 +25,6 @@
 #include "btrfs_inode.h"
 #include "transaction.h"
 #include "compression.h"
-#include "xattr.h"
 #include "print-tree.h"
 #include "accessors.h"
 #include "dir-item.h"
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 571bb13587d5..a5b652c1650a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -9,7 +9,6 @@
 #include "ordered-data.h"
 #include "transaction.h"
 #include "block-group.h"
-#include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c45fdaf24cd1..40ae264fd3ed 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -34,13 +34,11 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
-#include "print-tree.h"
 #include "props.h"
 #include "xattr.h"
 #include "bio.h"
 #include "export.h"
 #include "compression.h"
-#include "rcu-string.h"
 #include "dev-replace.h"
 #include "free-space-cache.h"
 #include "backref.h"
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5b3333ceef04..70d7abd1f772 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -23,12 +23,10 @@
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
-#include "zoned.h"
 #include "fs.h"
 #include "accessors.h"
 #include "extent-tree.h"
 #include "root-tree.h"
-#include "defrag.h"
 #include "dir-item.h"
 #include "uuid-tree.h"
 #include "ioctl.h"
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6eccf8496486..4fa95eca285e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -21,7 +21,6 @@
 #include "messages.h"
 #include "ctree.h"
 #include "tree-checker.h"
-#include "disk-io.h"
 #include "compression.h"
 #include "volumes.h"
 #include "misc.h"
@@ -30,7 +29,6 @@
 #include "file-item.h"
 #include "inode-item.h"
 #include "dir-item.h"
-#include "raid-stripe-tree.h"
 #include "extent-tree.h"
 
 /*
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 331fc7429952..043b8df5665f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -13,13 +13,11 @@
 #include "tree-log.h"
 #include "disk-io.h"
 #include "locking.h"
-#include "print-tree.h"
 #include "backref.h"
 #include "compression.h"
 #include "qgroup.h"
 #include "block-group.h"
 #include "space-info.h"
-#include "zoned.h"
 #include "inode-item.h"
 #include "fs.h"
 #include "accessors.h"
diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
index b4ac2b0cd235..183863f4bfa4 100644
--- a/fs/btrfs/ulist.c
+++ b/fs/btrfs/ulist.c
@@ -7,7 +7,6 @@
 #include <linux/slab.h>
 #include "messages.h"
 #include "ulist.h"
-#include "ctree.h"
 
 /*
  * ulist is a generic data structure to hold a collection of unique u64
diff --git a/fs/btrfs/uuid-tree.c b/fs/btrfs/uuid-tree.c
index 5be74f9e47eb..b8c6e46dd499 100644
--- a/fs/btrfs/uuid-tree.c
+++ b/fs/btrfs/uuid-tree.c
@@ -9,7 +9,6 @@
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
-#include "print-tree.h"
 #include "fs.h"
 #include "accessors.h"
 #include "uuid-tree.h"
diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 66e2270b0dae..4042dd6437ae 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -14,7 +14,6 @@
 #include "ctree.h"
 #include "btrfs_inode.h"
 #include "transaction.h"
-#include "disk-io.h"
 #include "locking.h"
 #include "fs.h"
 #include "accessors.h"
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d67785be2c77..474ab7ed65ea 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,10 +14,8 @@
 #include <linux/namei.h>
 #include "misc.h"
 #include "ctree.h"
-#include "extent_map.h"
 #include "disk-io.h"
 #include "transaction.h"
-#include "print-tree.h"
 #include "volumes.h"
 #include "raid56.h"
 #include "rcu-string.h"
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 168af9d000d1..d9716456bce0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,10 +12,8 @@
 #include "rcu-string.h"
 #include "disk-io.h"
 #include "block-group.h"
-#include "transaction.h"
 #include "dev-replace.h"
 #include "space-info.h"
-#include "super.h"
 #include "fs.h"
 #include "accessors.h"
 #include "bio.h"
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 0d66db8bc1d4..4cba8176b074 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -19,7 +19,6 @@
 #include <linux/zstd.h>
 #include "misc.h"
 #include "compression.h"
-#include "ctree.h"
 
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
 #define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
-- 
2.42.1


