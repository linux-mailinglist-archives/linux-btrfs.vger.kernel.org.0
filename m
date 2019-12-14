Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC61811EF27
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLNAWy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42460 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfLNAWx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2314956pfz.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9loKYuiJxezEd1iTQMdkVF3uLMXnCLeozLeBHtKht4M=;
        b=F4P5hqPDXDggnVND9FkLBYgw5nj1v8SRIsZcABv0OPjpbRQSdnUwLxy90LFIWw8KkS
         u7cdZzNvzqtTYk/wY7igXKRHFHKwfEDwq9DLZt9wuVXyNrKOagzY6e0BuZMRS+Ci56s1
         s/LsrelK8ixnXJF4gPaMl+Pd4SH/GoF3jK0YflnWII0+bWbisBTNwXBCctjjNuFbkjfL
         mIEazit88XwMs1cOccYp0KOjw9Z1DTK1Rr65y1t7s6Y51TIeFDFiHK6ODMRgK9vr+x+k
         fC1BA+eJbDhelkHnXzQpoUnwHbQzhVJOj4zcDV8JEvzZQ2BAWS8G/HynkOwDxIlYc1wA
         XItw==
X-Gm-Message-State: APjAAAXh+byHGbgu8mi53YjOLPxyDWGm4583d+KC04Y2YvS+Eizx7ZVd
        s33ayTsy7+J0pwWw8CnCGA7w/0lU13AYUg==
X-Google-Smtp-Source: APXvYqy6BADROmIN60O98J4qffqiPwt5CUNtXv9nf+ZmmmPyO70YVZvXTz5Y12W62J4FcqwysVgOqA==
X-Received: by 2002:a63:c207:: with SMTP id b7mr2606633pgd.422.1576282972343;
        Fri, 13 Dec 2019 16:22:52 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:51 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 12/22] btrfs: keep track of discardable_bytes
Date:   Fri, 13 Dec 2019 16:22:21 -0800
Message-Id: <f99f47a6ebab87da45ae04a27c2e6c2555ec92c0.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
index 968bc8f5d0f8..18df0e40a282 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -468,6 +468,7 @@ struct btrfs_discard_ctl {
 	struct btrfs_block_group *block_group;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
 	atomic_t discardable_extents;
+	atomic64_t discardable_bytes;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 1f18bbfe8372..e8c2623617fd 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -362,6 +362,7 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
 {
 	struct btrfs_discard_ctl *discard_ctl;
 	s32 extents_delta;
+	s64 bytes_delta;
 
 	if (!block_group ||
 	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
@@ -376,6 +377,14 @@ void btrfs_discard_update_discardable(struct btrfs_block_group *block_group,
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
@@ -466,6 +475,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
 	atomic_set(&discard_ctl->discardable_extents, 0);
+	atomic64_set(&discard_ctl->discardable_bytes, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7a3b07ef4dd5..57df34480b93 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -820,9 +820,11 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
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
@@ -1644,8 +1646,10 @@ __unlink_free_space(struct btrfs_free_space_ctl *ctl,
 	rb_erase(&info->offset_index, &ctl->free_space_offset);
 	ctl->free_extents--;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]--;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= info->bytes;
+	}
 }
 
 static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
@@ -1666,8 +1670,10 @@ static int link_free_space(struct btrfs_free_space_ctl *ctl,
 	if (ret)
 		return ret;
 
-	if (!info->bitmap && !btrfs_free_space_trimmed(info))
+	if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR]++;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] += info->bytes;
+	}
 
 	ctl->free_space += info->bytes;
 	ctl->free_extents++;
@@ -1746,8 +1752,10 @@ static inline void __bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta++;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
+	}
 }
 
 static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
@@ -1782,8 +1790,10 @@ static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
 		extent_delta--;
 
 	info->bitmap_extents += extent_delta;
-	if (!btrfs_free_space_trimmed(info))
+	if (!btrfs_free_space_trimmed(info)) {
 		ctl->discardable_extents[BTRFS_STAT_CURR] += extent_delta;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] += bytes;
+	}
 }
 
 /*
@@ -2054,9 +2064,11 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
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
 
@@ -2715,15 +2727,21 @@ __btrfs_return_cluster_to_free_space(
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
@@ -3014,6 +3032,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 	spin_lock(&ctl->tree_lock);
 
 	ctl->free_space -= bytes;
+	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
 	if (entry->bytes == 0) {
 		ctl->free_extents--;
 		if (entry->bitmap) {
@@ -3519,9 +3539,11 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 
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
 
@@ -3535,6 +3557,7 @@ static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
 		entry->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 		ctl->discardable_extents[BTRFS_STAT_CURR] -=
 			entry->bitmap_extents;
+		ctl->discardable_bytes[BTRFS_STAT_CURR] -= entry->bytes;
 	}
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 822b19310872..600633ed403b 100644
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
index 48bd254133be..e799d4488d72 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -355,8 +355,20 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
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
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
+	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
 };
 
-- 
2.17.1

