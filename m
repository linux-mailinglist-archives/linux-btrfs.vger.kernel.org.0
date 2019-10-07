Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818A8CED52
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbfJGUSO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35571 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfJGUSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id m15so21165297qtq.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3+Si9zlq8+mMMhUVKnM1J2vvhlL7j7jQ55qCTivrpw4=;
        b=Pj9tg/5RNJQXrCTRv53xT+J5ugAocB52K7+fIg7nqVE658QxrSMyreB7XZcx7ijEf/
         0R48s6kt313SwylcH3e9PFJuyElkMyF9w1Y6VY7I5u/3prERKsAacYoSQLtl4nZiOCEe
         LP1h5l9Ngdl0jmiqyVD5jAtoou5Joqamn5cHgtree+dlCnF8pDh1Wn3iDaoiTw7wl6zV
         OCU0SPY+mRNZIZQ14RCau74UGuAlAz/DQc3LuBgbmSnkUZolQJHcsolRnuxYo0DR0CZD
         as58JbA+AevQEZfoQt0L3Fq2G6ZrsRpDjxUeHaskCI+rxQoUM+1d7h62rtSOYmcwQ0jm
         j9uw==
X-Gm-Message-State: APjAAAWNfWUlRVhPPB9UYiQneJjyvSDt7HtFy470AymS1nXTlmC7H1C+
        29+vsnGdyxn0o7dD/KXvMZ8=
X-Google-Smtp-Source: APXvYqyQJakr8uKmWnFtXKJ2jFWsJWw2BYgrDcGclo0qyag1gTNdnDpPp001gzqDQJHIO2PAG4GFKg==
X-Received: by 2002:ac8:340d:: with SMTP id u13mr31292984qtb.103.1570479491439;
        Mon, 07 Oct 2019 13:18:11 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:10 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 16/19] btrfs: keep track of discard reuse stats
Date:   Mon,  7 Oct 2019 16:17:47 -0400
Message-Id: <60e557d71cb58574edbc2c429534fbfefd55df48.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Keep track of how much we are discarding and how often we are reusing
with async discard.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  3 +++
 fs/btrfs/discard.c          |  5 +++++
 fs/btrfs/free-space-cache.c | 10 ++++++++++
 fs/btrfs/sysfs.c            | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b5608f8dc41a..2f52b29ff74c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -453,6 +453,9 @@ struct btrfs_discard_ctl {
 	atomic_t delay;
 	atomic_t iops_limit;
 	atomic64_t bps_limit;
+	atomic64_t discard_extent_bytes;
+	atomic64_t discard_bitmap_bytes;
+	atomic64_t discard_bytes_saved;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index d99ba31e6f3b..f0088ca19d28 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -280,10 +280,12 @@ static void btrfs_discard_workfn(struct work_struct *work)
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
 					       minlen, maxlen, true);
+		atomic64_add(trimmed, &discard_ctl->discard_bitmap_bytes);
 	} else {
 		btrfs_trim_block_group(cache, &trimmed, cache->discard_cursor,
 				       btrfs_block_group_end(cache),
 				       minlen, true);
+		atomic64_add(trimmed, &discard_ctl->discard_extent_bytes);
 	}
 
 	discard_ctl->prev_discard = trimmed;
@@ -408,6 +410,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	atomic_set(&discard_ctl->delay, BTRFS_DISCARD_MAX_DELAY);
 	atomic_set(&discard_ctl->iops_limit, BTRFS_DISCARD_MAX_IOPS);
 	atomic64_set(&discard_ctl->bps_limit, 0);
+	atomic64_set(&discard_ctl->discard_extent_bytes, 0);
+	atomic64_set(&discard_ctl->discard_bitmap_bytes, 0);
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ed35dc090df6..480119016c0d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2773,6 +2773,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	u64 bytes_search = bytes + empty_size;
 	u64 ret = 0;
@@ -2797,6 +2799,9 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 		align_gap = entry->offset;
 		align_gap_flags = entry->flags;
 
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
@@ -2901,6 +2906,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 			     u64 min_start, u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	struct rb_node *node;
 	u64 ret = 0;
@@ -2965,6 +2972,9 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 
 	spin_lock(&ctl->tree_lock);
 
+	if (!btrfs_free_space_trimmed(entry))
+		atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 	ctl->free_space -= bytes;
 	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
 		ctl->discardable_bytes[0] -= bytes;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6fc4d644401b..29a290d75492 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -551,11 +551,47 @@ static ssize_t btrfs_discard_bps_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, bps_limit, btrfs_discard_bps_limit_show,
 	      btrfs_discard_bps_limit_store);
 
+static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
+					struct kobj_attribute *a,
+					char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+		atomic64_read(&fs_info->discard_ctl.discard_extent_bytes));
+}
+BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
+
+static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
+					struct kobj_attribute *a,
+					char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+		atomic64_read(&fs_info->discard_ctl.discard_bitmap_bytes));
+}
+BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
+
+static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
+}
+BTRFS_ATTR(discard, discard_bytes_saved, btrfs_discard_bytes_saved_show);
+
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discard_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, bps_limit),
+	BTRFS_ATTR_PTR(discard, discard_extent_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bitmap_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bytes_saved),
 	NULL,
 };
 
-- 
2.17.1

