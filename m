Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC6AD9B52A
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfHWRJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732817AbfHWRIW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1D5AAC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1F0A9DA796; Fri, 23 Aug 2019 19:08:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/7] btrfs: move struct io_ctl to free-space-cache.h
Date:   Fri, 23 Aug 2019 19:08:46 +0200
Message-Id: <3cb910fc494f8ee7037e93174f7e40b012eef967.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The io_ctl structure is used for free space management, and used only by
the v1 space cache code, but unfortunatlly the full definition is
required by block-group.h so it can't be moved to free-space-cache.c
without additional changes.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.h      |  2 ++
 fs/btrfs/ctree.h            | 14 --------------
 fs/btrfs/free-space-cache.h | 14 +++++++++++++-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5c6e2fb23e35..c391800388dd 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_BLOCK_GROUP_H
 #define BTRFS_BLOCK_GROUP_H
 
+#include "free-space-cache.h"
+
 enum btrfs_disk_cache_state {
 	BTRFS_DC_WRITTEN,
 	BTRFS_DC_ERROR,
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1fd5931a9489..5977995b1b69 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -433,20 +433,6 @@ enum btrfs_caching_type {
 	BTRFS_CACHE_ERROR,
 };
 
-struct btrfs_io_ctl {
-	void *cur, *orig;
-	struct page *page;
-	struct page **pages;
-	struct btrfs_fs_info *fs_info;
-	struct inode *inode;
-	unsigned long size;
-	int index;
-	int num_pages;
-	int entries;
-	int bitmaps;
-	unsigned check_crcs:1;
-};
-
 /*
  * Tree to record all locked full stripes of a RAID5/6 block group
  */
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 2205a4113ef3..39c32c8fc24f 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -36,7 +36,19 @@ struct btrfs_free_space_op {
 			   struct btrfs_free_space *info);
 };
 
-struct btrfs_io_ctl;
+struct btrfs_io_ctl {
+	void *cur, *orig;
+	struct page *page;
+	struct page **pages;
+	struct btrfs_fs_info *fs_info;
+	struct inode *inode;
+	unsigned long size;
+	int index;
+	int num_pages;
+	int entries;
+	int bitmaps;
+	unsigned check_crcs:1;
+};
 
 struct inode *lookup_free_space_inode(
 		struct btrfs_block_group_cache *block_group,
-- 
2.22.0

