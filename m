Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9F24C26D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgHTPqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgHTPqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF6C061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p4so1926506qkf.0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PA3vDnu0yKOO7VBsvA6/YqGtFa3WJdIeqDVHudRQVLQ=;
        b=PYszaRju9TCJ8wPUfthUiOygDvPnre8uomywaxT5p+ZvrOYpChZmBRXmsCoBFRIqjf
         RJYeWEvGCvmYhLLKUurmpzwP352/SFFMSkkQ4vTkAE+rL0LWB1Z7oeZIC21om5FotHrX
         JZgCSnSLoYEAu/dkb6qVYMiXAjUnhSQ9vWRkXTnndii0B/OpIh+MAvAuOWaqhrTWzD/K
         qHJ5qzZuWEUy2HTbe3hhGd1fV0bseXA7+i0+vODWRJSZUOl68w80bDbPkJXbWqEswRQS
         BmTMWKMtRAzkIWUYHXhTnOEUauHdKLU+EN469hH+PQhySwVDYdQG1HA7hZ5JvIzuuKej
         LdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PA3vDnu0yKOO7VBsvA6/YqGtFa3WJdIeqDVHudRQVLQ=;
        b=AWJpJWkMzBXKsE24Q1N1D41kVnjk/lZMV4Rtrq8RCUdNGMipQIroDxTpcuObkCtncS
         iOJjR1D8RPxNZwgiObhAt52GS/a3ADI4F5FNS4QoaPvg4deagmSrMKKkCy83ASGZEyu/
         SYTpFkO7tY7Kcef//o+lSewzk4qsXFkJH3abh09zAqQzya0A9k4FeRalnh7qrCz91r5+
         WxCsPb6o1694L982W8+yClr64e2D+V8wCnPPuSbHblfXH+dNKquig7z/JXrPmeysTYlx
         30hQ7ZnBeU2Wa+8wsz4s789Tq6KaBU0+/nBy31xzlXhFoetsjcMcRnlghsndiK1D6onQ
         tVDQ==
X-Gm-Message-State: AOAM532Bd2u5RDKY6VAzOuDvDNWxgcb9E38v9lHzJuMsuy9AxzHIUr08
        SiiorlzIvh0oS1/viNQdzOPOSJyzBTNvs8Ml
X-Google-Smtp-Source: ABdhPJzM3XaGzwW2UlPtkfGbJz5r/xGF0UqtaxAJp0nmf53eX+QrBZ8FRhbl3M10DJ/h1C35wjJgYQ==
X-Received: by 2002:a37:ae03:: with SMTP id x3mr3052787qke.313.1597938380670;
        Thu, 20 Aug 2020 08:46:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x198sm2740222qka.37.2020.08.20.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 03/12] btrfs: add nesting tags to the locking helpers
Date:   Thu, 20 Aug 2020 11:46:02 -0400
Message-Id: <a538e26134d912f4e2e613ce215a4f01bcaf507c.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We will need these when we switch to an rwsem, so plumb in the
infrastructure here to use later on.  I violate the 80 character limit
some here because it'll be cleaned up later.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 11 ++++++++---
 fs/btrfs/locking.c | 14 ++++++++++----
 fs/btrfs/locking.h | 20 +++++++++++++++++++-
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 025a75767d61..41d0685d0e87 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2875,7 +2875,8 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			} else {
 				if (!btrfs_tree_read_lock_atomic(b)) {
 					btrfs_set_path_blocking(p);
-					__btrfs_tree_read_lock(b, p->recurse);
+					__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
+							       p->recurse);
 				}
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
@@ -5379,7 +5380,9 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			}
 			if (!ret) {
 				btrfs_set_path_blocking(path);
-				__btrfs_tree_read_lock(next, path->recurse);
+				__btrfs_tree_read_lock(next,
+						       BTRFS_NESTING_NORMAL,
+						       path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
@@ -5414,7 +5417,9 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			ret = btrfs_try_tree_read_lock(next);
 			if (!ret) {
 				btrfs_set_path_blocking(path);
-				__btrfs_tree_read_lock(next, path->recurse);
+				__btrfs_tree_read_lock(next,
+						       BTRFS_NESTING_NORMAL,
+						       path->recurse);
 			}
 			next_rw_lock = BTRFS_READ_LOCK;
 		}
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index d07818733833..133a6dd5f29b 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -244,7 +244,8 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
  *
  * The rwlock is held upon exit.
  */
-void __btrfs_tree_read_lock(struct extent_buffer *eb, bool recurse)
+void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
+			    bool recurse)
 {
 	u64 start_ns = 0;
 
@@ -282,7 +283,7 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, bool recurse)
 
 void btrfs_tree_read_lock(struct extent_buffer *eb)
 {
-	__btrfs_tree_read_lock(eb, false);
+	__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, false);
 }
 
 /*
@@ -415,7 +416,7 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
  *
  * The rwlock is held for write upon exit.
  */
-void btrfs_tree_lock(struct extent_buffer *eb)
+void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	__acquires(&eb->lock)
 {
 	u64 start_ns = 0;
@@ -440,6 +441,11 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 	trace_btrfs_tree_lock(eb, start_ns);
 }
 
+void btrfs_tree_lock(struct extent_buffer *eb)
+{
+	__btrfs_tree_lock(eb, BTRFS_NESTING_NORMAL);
+}
+
 /*
  * Release the write lock, either blocking or spinning (ie. there's no need
  * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocking).
@@ -565,7 +571,7 @@ struct extent_buffer *__btrfs_read_lock_root_node(struct btrfs_root *root,
 
 	while (1) {
 		eb = btrfs_root_node(root);
-		__btrfs_tree_read_lock(eb, recurse);
+		__btrfs_tree_read_lock(eb, BTRFS_NESTING_NORMAL, recurse);
 		if (eb == root->node)
 			break;
 		btrfs_tree_read_unlock(eb);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 587f144adafe..ffbbd33d8fd7 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -16,12 +16,30 @@
 #define BTRFS_WRITE_LOCK_BLOCKING 3
 #define BTRFS_READ_LOCK_BLOCKING 4
 
+enum btrfs_lock_nesting {
+	BTRFS_NESTING_NORMAL,
+
+	/*
+	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
+	 * add this in here and add a static_assert to keep us from going over
+	 * the limit.  As of this writing we're limited to 8, and we're
+	 * definitely using 8, hence this check to keep us from messing up in
+	 * the future.
+	 */
+	BTRFS_NESTING_MAX,
+};
+
+static_assert(BTRFS_NESTING_MAX <= MAX_LOCKDEP_SUBCLASSES,
+	      "too many lock subclasses defined");
+
 struct btrfs_path;
 
+void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest);
 void btrfs_tree_lock(struct extent_buffer *eb);
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
-void __btrfs_tree_read_lock(struct extent_buffer *eb, bool recurse);
+void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
+			    bool recurse);
 void btrfs_tree_read_lock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock(struct extent_buffer *eb);
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb);
-- 
2.24.1

