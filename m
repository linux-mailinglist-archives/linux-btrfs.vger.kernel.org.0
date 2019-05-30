Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48EA13002F
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 18:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE3QaM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 12:30:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:60682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbfE3QaL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 12:30:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3AACAFDB
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 16:30:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 12C3BDA85E; Thu, 30 May 2019 18:31:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: switch extent_buffer write_locks from atomic to int
Date:   Thu, 30 May 2019 18:31:04 +0200
Message-Id: <6665a7f5b02d97bde4a1cadb2478bb6ba1a01cd0.1559233731.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559233731.git.dsterba@suse.com>
References: <cover.1559233731.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The write_locks is either 0 or 1 and always updated under the lock,
so we don't need the atomic_t semantics.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c  | 2 +-
 fs/btrfs/extent_io.h  | 2 +-
 fs/btrfs/locking.c    | 6 +++---
 fs/btrfs/print-tree.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 71ee9e976307..6d75d4dcf473 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4845,7 +4845,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->spinning_writers = 0;
 	atomic_set(&eb->spinning_readers, 0);
 	atomic_set(&eb->read_locks, 0);
-	atomic_set(&eb->write_locks, 0);
+	eb->write_locks = 0;
 #endif
 
 	return eb;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 5616b96c365d..844e595cde5b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -190,7 +190,7 @@ struct extent_buffer {
 	int spinning_writers;
 	atomic_t spinning_readers;
 	atomic_t read_locks;
-	atomic_t write_locks;
+	int write_locks;
 	struct list_head leak_list;
 #endif
 };
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 270667627977..98fccce4208c 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -58,17 +58,17 @@ static void btrfs_assert_tree_read_locked(struct extent_buffer *eb)
 
 static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb)
 {
-	atomic_inc(&eb->write_locks);
+	eb->write_locks++;
 }
 
 static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb)
 {
-	atomic_dec(&eb->write_locks);
+	eb->write_locks--;
 }
 
 void btrfs_assert_tree_locked(struct extent_buffer *eb)
 {
-	BUG_ON(!atomic_read(&eb->write_locks));
+	BUG_ON(!eb->write_locks);
 }
 
 #else
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index c5cc435ed39a..9cb50577d982 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -153,7 +153,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
 #ifdef CONFIG_BTRFS_DEBUG
 	btrfs_info(eb->fs_info,
 "refs %u lock (w:%d r:%d bw:%d br:%d sw:%d sr:%d) lock_owner %u current %u",
-		   atomic_read(&eb->refs), atomic_read(&eb->write_locks),
+		   atomic_read(&eb->refs), eb->write_locks,
 		   atomic_read(&eb->read_locks),
 		   eb->blocking_writers,
 		   atomic_read(&eb->blocking_readers),
-- 
2.21.0

