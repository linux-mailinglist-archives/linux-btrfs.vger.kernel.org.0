Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35197E26AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436930AbfJWWxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:35 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34144 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436924AbfJWWxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id e14so14970184qto.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ETavxVld8bxTgckmKB7O6ig8J4PhMI6W7gXFOef2gMo=;
        b=nS20qdXKWop9wuPo6dxKkdpVLgJVE7JkZk4cw1+DdzqrjiuWrNTIdqPt6qe2jTfF/v
         lNCj/re/QISVHsK+JzikgGAR6lfUHhrLXOsNyad0Lsee2jxAUoQ278F1jqQgdHNYlflL
         nsx++x2GwxvZ41+lE8g/Ou+SovBLPltieiFwf5Ov/BQ3EL2BwOC2AATGGEwE/voEBHgW
         C/qvELwroQyi9IE2z47y9JJh3168PkZBbZjIP7RUbpvBsID0BSPaQ2ndP8NcgKbJOE2z
         4wHmJ+6BxScwN1B3Ad9RfQGvWtOfVDDLkZu+Efc4htSbhLGqmueDUx+23qKMq7AO5cD3
         VNxQ==
X-Gm-Message-State: APjAAAWSeVCewJNg9Ho1as0PNetUDNyXi34LWr+3XCMiMbEUDn2LgyxH
        9q1oR8fRg7Yh2A+hbNGC2TE=
X-Google-Smtp-Source: APXvYqyQMDB+UG4wNi3rAXzKRmOqzeSyLnR0FINJDbKnyyAeoNIxXmwSTfntHgkNTxKzRX3mIBzmWg==
X-Received: by 2002:aed:222b:: with SMTP id n40mr1118794qtc.109.1571871213052;
        Wed, 23 Oct 2019 15:53:33 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:32 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/22] btrfs: keep track of discardable_bytes
Date:   Wed, 23 Oct 2019 18:53:06 -0400
Message-Id: <3801afee5fe1a6a81e04e27692e2ded4c5df64ec.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep track of this metric so that we can understand how ahead or behind
we are in discarding rate.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  1 +
 fs/btrfs/discard.c          | 10 +++++++++
 fs/btrfs/free-space-cache.c | 41 +++++++++++++++++++++++++++++--------
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/sysfs.c            | 12 +++++++++++
 5 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2cf1dae512aa..43aa355f5c37 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -466,6 +466,7 @@ struct btrfs_discard_ctl {
 	struct btrfs_block_group_cache *cache;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discardable_extents;
+	atomic64_t discardable_bytes;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 128ba18f2e5e..9c561a561578 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -351,6 +351,7 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	s32 extents_delta;
+	s64 bytes_delta;
 
 	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
 		return;
@@ -364,6 +365,14 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 		ctl->discardable_extents[BTRFS_STAT_PREV] =
 			ctl->discardable_extents[BTRFS_STAT_CURR];
 	}
+
+	bytes_delta = (ctl->discardable_bytes[BTRFS_STAT_CURR] -
+		       ctl->discardable_bytes[BTRFS_STAT_PREV]);
+	if (bytes_delta) {
+		atomic64_add(bytes_delta, &discard_ctl->discardable_bytes);
+		ctl->discardable_bytes[BTRFS_STAT_PREV] =
+			ctl->discardable_bytes[BTRFS_STAT_CURR];
+	}
 }
 
 /**
@@ -453,6 +462,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
+	atomic64_set(&discard_ctl->discardable_bytes, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3a965876aae3..8d4ffd50aee6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -815,9 +815,11 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 		if (ret)
 			goto free_cache;
 		e->bitmap_extents = count_bitmap_extents(ctl, e);
-		if (!btrfs_free_space_trimmed(e))
+		if (!btrfs_free_space_trimmed(e)) {
 			ctl->discardable_extents[BTRFS_STAT_CURR] +=
 				e->bitmap_extents;
+			ctl->discardable_bytes[BTRFS_STAT_CURR] += e->bytes;
+		}
 	}
 
 	io_ctl_drop_pages(&io_ctl);
@@ -1640,8 +1642,10 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]--;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= info->bytes;
+	}
 }
 
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1662,8 +1666,10 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
+	}
 
 	ctl->free_space += info->bytes;
 	ctl->free_extents++;
@@ -1742,8 +1748,10 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta++;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
+	}
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
@@ -1778,8 +1786,10 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta--;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] += bytes;
+	}
 }
 
 /*
@@ -2050,9 +2060,11 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	 * whole bitmap untrimmed if at any point we add untrimmed regions.
 	 */
 	if (trim_state == BTRFS_TRIM_STATE_UNTRIMMED) {
-		if (btrfs_free_space_trimmed(info))
+		if (btrfs_free_space_trimmed(info)) {
 			ctl->discardable_extents[BTRFS_STAT_CURR] +=
 				info->bitmap_extents;
+			ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
+		}
 		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	}
 
@@ -2688,15 +2700,21 @@ __btrfs_return_cluster_to_free_space(
 		bitmap = (entry->bitmap != NULL);
 		if (!bitmap) {
 			/* merging treats extents as if they were new */
-			if (!btrfs_free_space_trimmed(entry))
+			if (!btrfs_free_space_trimmed(entry)) {
 				ctl->discardable_extents[BTRFS_STAT_CURR]--;
+				ctl->discardable_bytes[BTRFS_STAT_CURR] -=
+					entry->bytes;
+			}
 
 			try_merge_free_space(ctl, entry, false);
 			steal_from_bitmap(ctl, entry, false);
 
 			/* as we insert directly, update these statistics */
-			if (!btrfs_free_space_trimmed(entry))
+			if (!btrfs_free_space_trimmed(entry)) {
 				ctl->discardable_extents[BTRFS_STAT_CURR]++;
+				ctl->discardable_bytes[BTRFS_STAT_CURR] +=
+					entry->bytes;
+			}
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
@@ -2987,6 +3005,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 	spin_lock(&ctl->tree_lock);
 
 	ctl->free_space -= bytes;
+	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
 	if (entry->bytes == 0) {
 		ctl->free_extents--;
 		if (entry->bitmap) {
@@ -3493,9 +3513,11 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 
 	entry = tree_search_offset(ctl, offset, 1, 0);
 	if (entry) {
-		if (btrfs_free_space_trimmed(entry))
+		if (btrfs_free_space_trimmed(entry)) {
 			ctl->discardable_extents[BTRFS_STAT_CURR] +=
 				entry->bitmap_extents;
+			ctl->discardable_bytes[BTRFS_STAT_CURR] += entry->bytes;
+		}
 		entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	}
 
@@ -3509,6 +3531,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
 		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 		ctl->discardable_extents[BTRFS_STAT_CURR] -=
 			entry->bitmap_extents;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= entry->bytes;
 	}
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 5e65899a2afa..1c0ec98da529 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -52,6 +52,7 @@ struct btrfs_free_space_ctl {
 	int unit;
 	u64 start;
 	s32 discardable_extents[BTRFS_STAT_NR_ENTRIES];
+	s64 discardable_bytes[BTRFS_STAT_NR_ENTRIES];
 	const struct btrfs_free_space_op *op;
 	void *private;
 	struct mutex cache_writeout_mutex;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25f3d9062b78..9ebb1f1b1de6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -330,8 +330,20 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 }
 BTRFS_ATTR(discard, discardable_extents, btrfs_discardable_extents_show);
 
+static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
+}
+BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
+
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
+	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
 };
 
-- 
2.17.1

