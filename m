Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC48109470
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfKYTrb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:31 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45711 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfKYTra (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:30 -0500
Received: by mail-qv1-f67.google.com with SMTP id d12so4313849qvv.12
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/w5gi9Ojv3f48EAJd3h9wUgHtN/iQ/oTYHpxzGtFLXQ=;
        b=q2lT2c1wLQ3AS7+DmXMYq6Np1bm3B9lbUiS57jNRCTCWlSjMGi8Td5CythulMZcmqz
         P0etf4pBcULByFqgoOm5OBUWuDOLV0+8wB9fqIdsoxtGIsDzy4nagHpaaAT3GFDltlCm
         kV5sRP8RMQ6CCWnm2B/t/HI0FRbJZqFFnNAO5GTomKKtIPPHtX3DN+SAqqgbktDMcgat
         8UlFjPsftH5CZEuppPiY8/+ECxK259/2JCDuVKN1FnHRwpefNiNn2buoWC+lSdH5JEGY
         4Iz55GOkG91pKIZXNc14Zg5fL76zQmA0Z8IVMCDaDsT9DP8nRd2JQbREwf+AwAxTTeBA
         zGJA==
X-Gm-Message-State: APjAAAV/YXe5xKvNN6QgQKYq8INsWsBkFE788wjAsTcnVyO2CmeBs4HF
        Oh7zzjqdeprxnnrheGlTjOg=
X-Google-Smtp-Source: APXvYqwZL+ZCQ/xOpEG49rvtXBloZYI8Y8vLPzewtlsB6ZeA67Y40n/zZRG63qe0uapSTrkEZGIu+A==
X-Received: by 2002:a0c:facf:: with SMTP id p15mr29246718qvo.212.1574711248551;
        Mon, 25 Nov 2019 11:47:28 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:28 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 19/22] btrfs: keep track of discard reuse stats
Date:   Mon, 25 Nov 2019 14:46:59 -0500
Message-Id: <766786dd2f5c1d898621b7609e7d358b6e730219.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index c8e923b3f2b9..7ab4a93fc3b7 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -414,11 +414,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
@@ -627,6 +631,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
+	discard_ctl->discard_extent_bytes = 0;
+	discard_ctl->discard_bitmap_bytes = 0;
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 83398c42213f..1b887c0d7508 100644
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

