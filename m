Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6670F9B52B
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732617AbfHWRJT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 13:09:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:54374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732819AbfHWRIY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 13:08:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE3A8AC0C
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 17:08:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A50CFDA796; Fri, 23 Aug 2019 19:08:48 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/7] btrfs: move dev_stats helpers to volumes.c
Date:   Fri, 23 Aug 2019 19:08:48 +0200
Message-Id: <70943b43bb89d5c68067d40bf8fc8b8944a21a0b.1566579823.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566579823.git.dsterba@suse.com>
References: <cover.1566579823.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The other dev stats functions are already there and the helpers are not
used by anything else.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h   | 24 ------------------------
 fs/btrfs/volumes.c | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5977995b1b69..35a94a43758d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2257,30 +2257,6 @@ static inline u32 btrfs_file_extent_inline_item_len(
 	return btrfs_item_size(eb, e) - BTRFS_FILE_EXTENT_INLINE_DATA_START;
 }
 
-/* btrfs_dev_stats_item */
-static inline u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
-					const struct btrfs_dev_stats_item *ptr,
-					int index)
-{
-	u64 val;
-
-	read_extent_buffer(eb, &val,
-			   offsetof(struct btrfs_dev_stats_item, values) +
-			    ((unsigned long)ptr) + (index * sizeof(u64)),
-			   sizeof(val));
-	return val;
-}
-
-static inline void btrfs_set_dev_stats_value(struct extent_buffer *eb,
-					     struct btrfs_dev_stats_item *ptr,
-					     int index, u64 val)
-{
-	write_extent_buffer(eb, &val,
-			    offsetof(struct btrfs_dev_stats_item, values) +
-			     ((unsigned long)ptr) + (index * sizeof(u64)),
-			    sizeof(val));
-}
-
 /* btrfs_qgroup_status_item */
 BTRFS_SETGET_FUNCS(qgroup_status_generation, struct btrfs_qgroup_status_item,
 		   generation, 64);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dc1f6985c2c4..104fa1c2afb0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7276,6 +7276,29 @@ void btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	}
 }
 
+static u64 btrfs_dev_stats_value(const struct extent_buffer *eb,
+				 const struct btrfs_dev_stats_item *ptr,
+				 int index)
+{
+	u64 val;
+
+	read_extent_buffer(eb, &val,
+			   offsetof(struct btrfs_dev_stats_item, values) +
+			    ((unsigned long)ptr) + (index * sizeof(u64)),
+			   sizeof(val));
+	return val;
+}
+
+static void btrfs_set_dev_stats_value(struct extent_buffer *eb,
+				      struct btrfs_dev_stats_item *ptr,
+				      int index, u64 val)
+{
+	write_extent_buffer(eb, &val,
+			    offsetof(struct btrfs_dev_stats_item, values) +
+			     ((unsigned long)ptr) + (index * sizeof(u64)),
+			    sizeof(val));
+}
+
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_key key;
-- 
2.22.0

