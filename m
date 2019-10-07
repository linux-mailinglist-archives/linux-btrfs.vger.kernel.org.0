Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 779EACED4B
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbfJGUSF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33843 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfJGUSF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so13951920qke.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5d4bzRvGzIjCUR9aMJmJfxJ30nvzwsQ76WLURJDIoOg=;
        b=pOxI8LaUDAP3VVMex1c51nueWviGwvEN83wmW/TTxS8sZCWsgSnKk3u77qYXjczFn0
         KQ0kTG8ws94vtTe7JLMv3ljlzBR+oDYebIcH3OcZc0UC7UCZgBZcFNMpdsSWJJb19gpr
         mIRe2qWEEYpl2/w4646R4MD5QyU5tiS8DNMcRZGa4lozAETJvHw0bORp1Sw07apwhgjZ
         XDTS9y8TRmjhFkzX7hEa8REL9afSz0w9ALu7HuWaj/4QrvpRC30RgwFKlwivUtEJ9llY
         O6i3yZKAYIHFoEeUMV5sIzTWTZngQhZx76YOuw9P2z8Mq2H4K/CNYn+SENyZJub2jP2m
         ja3g==
X-Gm-Message-State: APjAAAXR7EEOGOWlN6YvbgkDsG54G4mqzM0DITaC8v8NYc+6tPJk67im
        jikwbEjIzvioyKfdqJ7LFdI=
X-Google-Smtp-Source: APXvYqw1YusE9tk/IdkWMSnGhM0FSNoftUf84zL7dm2tWoDJ3h+0ao765zuADcceggWlFf9yyKYGmA==
X-Received: by 2002:a37:44e:: with SMTP id 75mr23457700qke.99.1570479483951;
        Mon, 07 Oct 2019 13:18:03 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:03 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 09/19] btrfs: keep track of discardable_bytes
Date:   Mon,  7 Oct 2019 16:17:40 -0400
Message-Id: <c098d2c774c93e30f782ca04f9e34461bdbb145c.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep track of this metric so that we can understand how ahead or behind
we are in discarding rate.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  1 +
 fs/btrfs/discard.c          |  1 +
 fs/btrfs/discard.h          |  7 +++++++
 fs/btrfs/free-space-cache.c | 32 +++++++++++++++++++++++++-------
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/sysfs.c            | 12 ++++++++++++
 6 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 43e515939b9c..8479ab037812 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -448,6 +448,7 @@ struct btrfs_discard_ctl {
 	struct btrfs_block_group_cache *cache;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discard_extents;
+	atomic64_t discardable_bytes;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 0544eb6717d4..75a2ff14b3c0 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -300,6 +300,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
 	atomic_set(&discard_ctl->discard_extents, 0);
+	atomic64_set(&discard_ctl->discardable_bytes, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 85939d62521e..d55a9a9f8ad8 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -77,6 +77,7 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	s32 extents_delta;
+	s64 bytes_delta;
 
 	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
 		return;
@@ -88,6 +89,12 @@ void btrfs_discard_update_discardable(struct btrfs_block_group_cache *cache,
 		atomic_add(extents_delta, &discard_ctl->discard_extents);
 		ctl->discard_extents[1] = ctl->discard_extents[0];
 	}
+
+	bytes_delta = ctl->discardable_bytes[0] - ctl->discardable_bytes[1];
+	if (bytes_delta) {
+		atomic64_add(bytes_delta, &discard_ctl->discardable_bytes);
+		ctl->discardable_bytes[1] = ctl->discardable_bytes[0];
+	}
 }
 
 #endif
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6c2bebfd206f..54f3c8325858 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -814,6 +814,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			goto free_cache;
 		e->bitmap_extents = count_bitmap_extents(ctl, e);
 		ctl->discard_extents[0] += e->bitmap_extents;
+		ctl->discardable_bytes[0] += e->bytes;
 	}
 
 	io_ctl_drop_pages(&io_ctl);
@@ -1636,8 +1637,10 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discard_extents[0]--;
+		ctl->discardable_bytes[0] -= info->bytes;
+	}
 }
 
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1658,8 +1661,10 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discard_extents[0]++;
+		ctl->discardable_bytes[0] += info->bytes;
+	}
 
 	ctl->free_space += info->bytes;
 	ctl->free_extents++;
@@ -1738,8 +1743,10 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta++;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discard_extents[0] += extent_delta;
+		ctl->discardable_bytes[0] -= bytes;
+	}
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
@@ -1774,8 +1781,10 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta--;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discard_extents[0] += extent_delta;
+		ctl->discardable_bytes[0] += bytes;
+	}
 }
 
 /*
@@ -2042,8 +2051,10 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 	u64 end;
 
 	if (!(flags & BTRFS_FSC_TRIMMED)) {
-		if (btrfs_free_space_trimmed(info))
+		if (btrfs_free_space_trimmed(info)) {
 			ctl->discard_extents[0] += info->bitmap_extents;
+			ctl->discardable_bytes[0] += info->bytes;
+		}
 		info->flags &= ~(BTRFS_FSC_TRIMMED | BTRFS_FSC_TRIMMING_BITMAP);
 	}
 
@@ -2657,15 +2668,19 @@ __btrfs_return_cluster_to_free_space(
 		bitmap = (entry->bitmap != NULL);
 		if (!bitmap) {
 			/* merging treats extents as if they were new */
-			if (!btrfs_free_space_trimmed(entry))
+			if (!btrfs_free_space_trimmed(entry)) {
 				ctl->discard_extents[0]--;
+				ctl->discardable_bytes[0] -= entry->bytes;
+			}
 
 			try_merge_free_space(ctl, entry, false);
 			steal_from_bitmap(ctl, entry, false);
 
 			/* as we insert directly, update these statistics */
-			if (!btrfs_free_space_trimmed(entry))
+			if (!btrfs_free_space_trimmed(entry)) {
 				ctl->discard_extents[0]++;
+				ctl->discardable_bytes[0] += entry->bytes;
+			}
 		}
 		tree_insert_offset(&ctl->free_space_offset,
 				   entry->offset, &entry->offset_index, bitmap);
@@ -2950,6 +2965,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 	spin_lock(&ctl->tree_lock);
 
 	ctl->free_space -= bytes;
+	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
+		ctl->discardable_bytes[0] -= bytes;
 	if (entry->bytes == 0) {
 		ctl->free_extents--;
 		if (entry->bitmap) {
@@ -3467,6 +3484,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
 		entry->flags |= BTRFS_FSC_TRIMMED;
 		entry->flags &= ~BTRFS_FSC_TRIMMING_BITMAP;
 		ctl->discard_extents[0] -= entry->bitmap_extents;
+		ctl->discardable_bytes[0] -= entry->bytes;
 	}
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 855f42dc15cd..c5cce44b03af 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -41,6 +41,7 @@ struct btrfs_free_space_ctl {
 	int unit;
 	u64 start;
 	s32 discard_extents[2];
+	s64 discardable_bytes[2];
 	const struct btrfs_free_space_op *op;
 	void *private;
 	struct mutex cache_writeout_mutex;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 14c6910128f1..a2852706ec6c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -482,8 +482,20 @@ static ssize_t btrfs_discard_extents_show(struct kobject *kobj,
 }
 BTRFS_ATTR(discard, discard_extents, btrfs_discard_extents_show);
 
+static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
+					struct kobj_attribute *a,
+					char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
+}
+BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
+
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discard_extents),
+	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
 };
 
-- 
2.17.1

