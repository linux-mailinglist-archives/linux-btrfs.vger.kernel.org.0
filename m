Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C987F3002E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfE3QaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 12:30:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3QaJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 12:30:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 94CF9AFDB
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 16:30:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ABC0BDA85E; Thu, 30 May 2019 18:31:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: switch extent_buffer spinning_writers from atomic to int
Date:   Thu, 30 May 2019 18:31:02 +0200
Message-Id: <6dfcb89b254ee5016edfa9816fce3487a23b446c.1559233731.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559233731.git.dsterba@suse.com>
References: <cover.1559233731.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The spinning_writers is either 0 or 1 and always updated under the lock,
so we don't need the atomic_t semantics.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c  |  2 +-
 fs/btrfs/extent_io.h  |  2 +-
 fs/btrfs/locking.c    | 10 +++++-----
 fs/btrfs/print-tree.c |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 57b6de9df7c4..71ee9e976307 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4842,7 +4842,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
 
 #ifdef CONFIG_BTRFS_DEBUG
-	atomic_set(&eb->spinning_writers, 0);
+	eb->spinning_writers = 0;
 	atomic_set(&eb->spinning_readers, 0);
 	atomic_set(&eb->read_locks, 0);
 	atomic_set(&eb->write_locks, 0);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 201da61dfc21..5616b96c365d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -187,7 +187,7 @@ struct extent_buffer {
 	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
-	atomic_t spinning_writers;
+	int spinning_writers;
 	atomic_t spinning_readers;
 	atomic_t read_locks;
 	atomic_t write_locks;
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 5feb01147e19..270667627977 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -15,19 +15,19 @@
 #ifdef CONFIG_BTRFS_DEBUG
 static void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
 {
-	WARN_ON(atomic_read(&eb->spinning_writers));
-	atomic_inc(&eb->spinning_writers);
+	WARN_ON(eb->spinning_writers);
+	eb->spinning_writers++;
 }
 
 static void btrfs_assert_spinning_writers_put(struct extent_buffer *eb)
 {
-	WARN_ON(atomic_read(&eb->spinning_writers) != 1);
-	atomic_dec(&eb->spinning_writers);
+	WARN_ON(eb->spinning_writers != 1);
+	eb->spinning_writers--;
 }
 
 static void btrfs_assert_no_spinning_writers(struct extent_buffer *eb)
 {
-	WARN_ON(atomic_read(&eb->spinning_writers));
+	WARN_ON(eb->spinning_writers);
 }
 
 static void btrfs_assert_spinning_readers_get(struct extent_buffer *eb)
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7cb4f1fbe043..c5cc435ed39a 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -157,7 +157,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
 		   atomic_read(&eb->read_locks),
 		   eb->blocking_writers,
 		   atomic_read(&eb->blocking_readers),
-		   atomic_read(&eb->spinning_writers),
+		   eb->spinning_writers,
 		   atomic_read(&eb->spinning_readers),
 		   eb->lock_owner, current->pid);
 #endif
-- 
2.21.0

