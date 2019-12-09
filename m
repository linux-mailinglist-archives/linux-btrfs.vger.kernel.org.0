Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1B511762C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfLITqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37100 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLITqb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id s18so7748944pfm.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FhljaIycBJS2p3ve23YaDj720Xq04EkRnCH70JFN1Pk=;
        b=uDpeN2LCXnMq0hxYDsbhU8Az1q2fiTNLoD6uSkBM4WB/70bMzB/OsUC5N3SA9F90QH
         Yk9o55mAuj4a5EXHvodXRK0jl6dqH5zr5Xk/BdVUXV4WauF4n95BYVaUZj/XRE1Ophz4
         GEFF883tP+WFKwGQhchNRt/P3ZeTTeOXwk5rergS8DnAKfevAgcQ+ceIOD8qy//QoH8R
         zJiMb9bWe6yOjaUlEIUJDF3Fpjl81ucaY2xqI8SU8gLsY2FLsbudI+qrq/hwip+PBYzS
         kuxG/kDLSExClRwA4wcENVZuhMpDw+o8+20Om48JDyf22GO4yYjhfm7DLhYALDtriQQF
         sSnw==
X-Gm-Message-State: APjAAAVY+fVPjrS/jGOtBGNZ4W+OLx1ziAJ1MrYVBEl9aSvhkDo2Hnk4
        MHs/Q7c8LeOppATAvLt80Nc=
X-Google-Smtp-Source: APXvYqwSainiO/OTIxuAlBvUkcameYfBllcJ3zL1dxx33pSewNDwyiOia2oT8lMn4i5+Wu5iRqGr+Q==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr1747328pfc.233.1575920790903;
        Mon, 09 Dec 2019 11:46:30 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:30 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 19/22] btrfs: keep track of discard reuse stats
Date:   Mon,  9 Dec 2019 11:46:04 -0800
Message-Id: <d4509658410b8215e52b3fd6f8713fe723b9f738.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
index 2cc9ee4d2cb2..6a5ff5ea96f7 100644
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
index 55ad357e65f3..fe73814526ef 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -419,11 +419,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
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
@@ -631,6 +635,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
+	discard_ctl->discard_extent_bytes = 0;
+	discard_ctl->discard_bitmap_bytes = 0;
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c9bf0207960d..612726a91e98 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2844,6 +2844,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	u64 bytes_search = bytes + empty_size;
 	u64 ret = 0;
@@ -2860,6 +2862,10 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
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
@@ -2868,6 +2874,9 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
 
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
@@ -2972,6 +2981,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 			     u64 min_start, u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	struct rb_node *node;
 	u64 ret = 0;
@@ -3036,6 +3047,9 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
 
 	spin_lock(&ctl->tree_lock);
 
+	if (!btrfs_free_space_trimmed(entry))
+		atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 	ctl->free_space -= bytes;
 	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e71e8bbc57d0..613606389072 100644
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

