Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD712EB53
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgABV1A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:27:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41868 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgABV1A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:27:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so32369710qke.8
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q7zpdabC3bKhMvoBo6/2VMh+UvqnEssKkzjNOLMKk08=;
        b=qIBB2vTYksZmWoF/ky1pxqcEsO1bP9RRAHg+z+10weoUbQkCd79a3DRqZI6AEyXnMj
         BsMLZj5Gp2QeEzZkrVH7QpL2ywuQ4mbvA+37PgXUTNQX1B0DGZkrKQ1NULQrvdSXVT4n
         2QDzyi60dimQMkB7igh6IgejZGcE1lUpkaHolFZSEKJ8db6hzd+gAqZbOnaB4kylSRkQ
         IoxUYqfNtKLCrgM6ea6OnIAmDoY+F4dNFPbzNmS9JHzXXnNOHocftU8Wyzw4NU3Ne0QD
         txTvgK+d7h2nOJk1KdvSrAcaV+srsje0hdlTCaTxhQryNVDcDyVIvTbBgKkillwD8GVX
         swXw==
X-Gm-Message-State: APjAAAWnpAf3riaZeOYvIzqoedqRpRUiXPdq8nlGDVUL3/hc7CKuwRjt
        Nji5JxpJZrlABxYTcWwmvFY=
X-Google-Smtp-Source: APXvYqz226gShX1EuAi/z8v7gubK8QlJ32iRxCwTJJny2gcp57qMf82JxJyAQjNEyl3Q6WMvupLTmg==
X-Received: by 2002:a05:620a:10a7:: with SMTP id h7mr67183219qkk.423.1578000418892;
        Thu, 02 Jan 2020 13:26:58 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:58 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 07/12] btrfs: keep track of discard reuse stats
Date:   Thu,  2 Jan 2020 16:26:41 -0500
Message-Id: <717a3e42ac3fb94b502d4dc258fbaafc60f1d6a2.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep track of how much we are discarding and how often we are reusing
with async discard. The discard_*_bytes doesn't need any special
protection because the work item provides the single threaded access.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h            |  3 +++
 fs/btrfs/discard.c          |  5 +++++
 fs/btrfs/free-space-cache.c | 14 ++++++++++++++
 fs/btrfs/sysfs.c            | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09371e8b55a7..fad310d46c78 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -473,6 +473,9 @@ struct btrfs_discard_ctl {
 	unsigned long delay;
 	unsigned iops_limit;
 	u32 kbps_limit;
+	u64 discard_extent_bytes;
+	u64 discard_bitmap_bytes;
+	atomic64_t discard_bytes_saved;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 7dbbf762ee8d..bc6d4344397d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -419,11 +419,13 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
 				       minlen, maxlen, true);
+		discard_ctl->discard_bitmap_bytes += trimmed;
 	} else {
 		btrfs_trim_block_group_extents(block_group, &trimmed,
 				       block_group->discard_cursor,
 				       btrfs_block_group_end(block_group),
 				       minlen, true);
+		discard_ctl->discard_extent_bytes += trimmed;
 	}
 
 	discard_ctl->prev_discard = trimmed;
@@ -627,6 +629,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->kbps_limit = 0;
+	discard_ctl->discard_extent_bytes = 0;
+	discard_ctl->discard_bitmap_bytes = 0;
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 6f0d60e86b6f..8a4a3b9cd544 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2842,6 +2842,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	u64 bytes_search = bytes + empty_size;
 	u64 ret = 0;
@@ -2858,6 +2860,10 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
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
@@ -2866,6 +2872,9 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
 
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
@@ -2969,6 +2978,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 			     u64 min_start, u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	struct rb_node *node;
 	u64 ret = 0;
@@ -3033,6 +3044,9 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 
 	spin_lock(&ctl->tree_lock);
 
+	if (!btrfs_free_space_trimmed(entry))
+		atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 	ctl->free_space -= bytes;
 	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8b0fd8557438..2e973af8353f 100644
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
+			fs_info->discard_ctl.discard_extent_bytes);
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
+			fs_info->discard_ctl.discard_bitmap_bytes);
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
 	BTRFS_ATTR_PTR(discard, kbps_limit),
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

