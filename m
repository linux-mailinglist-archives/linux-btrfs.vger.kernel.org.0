Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A5104625
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKTVvv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:51 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:46266 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKTVvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:51 -0500
Received: by mail-qv1-f68.google.com with SMTP id w11so544516qvu.13
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vqHvMMOe+ApvNNJ8QLH036WjhNlE78RF93zaN6ygIkY=;
        b=rvbGVs+pfOp1XPk01z+mEnLi+RH8O7Zkxc9kuL6SqQeOXPKfUDUtTqz8xoEcN7O1Cx
         kVpTCkchZQD1gxP1os84i6hzsReldxh2wFiV3mGn9XxPQAqShEs6Hl64SkX5G6T4D2Cd
         blsFmFhsJOTVSpN+gFNXj1XTmsKDuW2VrIgPdkA0pjUm1gFz1pU5TBr5IsGzmdfGtgNP
         yPCAM3QgusM1MnIKrIyIZTQNkdPwxv0Z2pkHuXY6DCeYI6trxCRNd8oBmK8x0nSJ73eO
         P+VS3X8kKoPDDCxOqrHlyZnVF3LJanlMXYDn24ijCMZA31l+tzcf0FM94DNnHmlqBbD1
         fhIw==
X-Gm-Message-State: APjAAAUSxLxkHTrEXfZvICgHsSPvtSWiUXU43TEXKvodHLeY/W/d+6RY
        DOUD3l7P2/71iwjzmdLJrAU=
X-Google-Smtp-Source: APXvYqxza1b7CDrbU6NtYhEuIEIf9Tx2j+7XkVvxQUeq6Pic+aet0Y4GtltKPaZi/s29Qt75VTCc/A==
X-Received: by 2002:a0c:eed3:: with SMTP id h19mr4777609qvs.153.1574286709919;
        Wed, 20 Nov 2019 13:51:49 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:49 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 19/22] btrfs: keep track of discard reuse stats
Date:   Wed, 20 Nov 2019 16:51:18 -0500
Message-Id: <8c5c0c03a4c5884404cc289d57bd846ad0548174.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep track of how much we are discarding and how often we are reusing
with async discard.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            |  3 +++
 fs/btrfs/discard.c          |  7 +++++++
 fs/btrfs/free-space-cache.c | 14 ++++++++++++++
 fs/btrfs/sysfs.c            | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 52f69aaaa19c..dc0007368791 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -474,6 +474,9 @@ struct btrfs_discard_ctl {
 	u32 delay;
 	u32 iops_limit;
 	u64 bps_limit;
+	u64 discard_extent_bytes;
+	u64 discard_bitmap_bytes;
+	atomic64_t discard_bytes_saved;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 2529cf88b02c..83618dd1a5b0 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -413,11 +413,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
 				       minlen, maxlen, true);
+		WRITE_ONCE(discard_ctl->discard_bitmap_bytes,
+			   discard_ctl->discard_bitmap_bytes + trimmed);
 	} else {
 		btrfs_trim_block_group_extents(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
 				       minlen, true);
+		WRITE_ONCE(discard_ctl->discard_extent_bytes,
+			   discard_ctl->discard_extent_bytes + trimmed);
 	}
 
 	discard_ctl->prev_discard = trimmed;
@@ -626,6 +630,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
+	discard_ctl->discard_extent_bytes = 0;
+	discard_ctl->discard_bitmap_bytes = 0;
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index b1b07af63efd..b35394118d87 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2820,6 +2820,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	u64 bytes_search = bytes + empty_size;
 	u64 ret = 0;
@@ -2836,6 +2838,10 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	ret = offset;
 	if (entry->bitmap) {
 		bitmap_clear_bits(ctl, entry, offset, bytes);
+
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		if (!entry->bytes)
 			free_bitmap(ctl, entry);
 	} else {
@@ -2844,6 +2850,9 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
 
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
@@ -2948,6 +2957,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 			     u64 min_start, u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	struct rb_node *node;
 	u64 ret = 0;
@@ -3012,6 +3023,9 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 
 	spin_lock(&ctl->tree_lock);
 
+	if (!btrfs_free_space_trimmed(entry))
+		atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 	ctl->free_space -= bytes;
 	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 65417a66866d..a962984004ba 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -456,12 +456,48 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
+static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+			READ_ONCE(fs_info->discard_ctl.discard_extent_bytes));
+}
+BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
+
+static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+			READ_ONCE(fs_info->discard_ctl.discard_bitmap_bytes));
+}
+BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
+
+static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
+}
+BTRFS_ATTR(discard, discard_bytes_saved, btrfs_discard_bytes_saved_show);
+
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, bps_limit),
 	BTRFS_ATTR_PTR(discard, max_discard_size),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
+	BTRFS_ATTR_PTR(discard, discard_extent_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bitmap_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bytes_saved),
 	NULL,
 };
 
-- 
2.17.1

