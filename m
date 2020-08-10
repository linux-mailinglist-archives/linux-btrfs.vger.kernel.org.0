Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB199240AA6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgHJPnJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 11:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728564AbgHJPnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 11:43:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64B6C061756
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id h7so8728813qkk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Aug 2020 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xk92ItRF8CuXhSyMwIRkegoeBR8o76JZGSa8LDiuiPA=;
        b=CSGk0/5EdMbnymdjihju2NbtMU90tgR1rGZtEuL11CAqWXqePaToeqS0VBvcydGLie
         jr3d61dDJuIQC0NlagRbD8TPcw9rIa6VW+uoCvU6EQiux3O3juuPefShQ61rP74mn3sy
         MR9kr9FG2T+GXvqT6QyYstDZyr59BCQBjee3OgOlp26mE40X2pCZbNjQZPLpgxlH+Mck
         8nhTIpzSL+zJbA7JT4fPqRTov1kceN6imh2q09IhmID7xJfSv48WdfuIVkxWLPTZDV3g
         y5/LErITwdkRv7BIaipVtvvwP5Q7x+9FSSYJLXILnSFytGji6uLtteMUtkg9NvPfPI2j
         DlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xk92ItRF8CuXhSyMwIRkegoeBR8o76JZGSa8LDiuiPA=;
        b=YQ3sGSJRNeKLWEwm5kQaB2sUZZ1pHoIJnAYC8WlDNMkdadjzlO2D7hbnPGejHgjHLw
         Myzf7XIem7kLRsXJk/e2u8QwZRwbJxeU3xAAmL/mJ4C5065YB/S3xyrBYFJFyGH0R9DE
         zKkN6gEDwL4cF5RhAXmuVNJUGZ6u2alOTEGZyu29NLSXbT6uVOgWUsXIevlN4xTHhQEH
         NgLPhIe1UAmt0Qz0vDtfZ9Hxb+NGyoQ/tpjH7V1BwUIu2ti1+WzuXd9NKkFi1wWnQY3U
         e+IP1mE43xzCE67tYBeqsf6WbKp4CJS1Ks9KfiRvKKuYQjNth4XiSjmw9eeSci2YOlcw
         0OfQ==
X-Gm-Message-State: AOAM533uyuQ/gJQ7cPWSltY+eboA7AwTcLDS3DuRx4alLhaztkXvJfiv
        qctOZW6LTeCKvEMtuk64NcG4yhrocFoclw==
X-Google-Smtp-Source: ABdhPJwwYHcmim7MZinxQr0m0YnYfgsR8v2543VJNnprirCi7iURmQDAlHCs4HY9fFaZ7C1oLPxd8w==
X-Received: by 2002:a05:620a:21c1:: with SMTP id h1mr26314266qka.178.1597074183433;
        Mon, 10 Aug 2020 08:43:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w12sm13435781qkj.116.2020.08.10.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 08:43:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/17] btrfs: add nesting tags to the locking helpers
Date:   Mon, 10 Aug 2020 11:42:34 -0400
Message-Id: <20200810154242.782802-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200810154242.782802-1-josef@toxicpanda.com>
References: <20200810154242.782802-1-josef@toxicpanda.com>
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
 fs/btrfs/locking.h |  8 +++++++-
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 34d40b19bb71..fefc61402118 100644
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
index 587f144adafe..476b5552e8b2 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -16,12 +16,18 @@
 #define BTRFS_WRITE_LOCK_BLOCKING 3
 #define BTRFS_READ_LOCK_BLOCKING 4
 
+enum btrfs_lock_nesting {
+	BTRFS_NESTING_NORMAL = 0,
+};
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

