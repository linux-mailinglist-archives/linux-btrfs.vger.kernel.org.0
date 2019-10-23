Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0E8E26B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436945AbfJWWxn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:43 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36047 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436935AbfJWWxm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id y189so21522711qkc.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iarM5FdmIrUiYwUIUpdHLdZn+sCFvSu54d/lyzNxKXs=;
        b=arSzJx5dM3OYFNJdn3fVzPY877suAy6CJ6nj9UtYdwxcrhTCS9k5QfkOe9TjTsK8Ui
         94c7ng8MjZ8GBtKBcyvtCYMTSIN4vmneLtnnpS/m0C+LdS2HdIKOlBtCLU22798WXd7B
         rooCq4B3y5u0fiiEtXc0KTJbUqL7ITN8EvwgxdFb/j5Uc1zkinLgYZvFRBzQ4mG4irQx
         xcW8XZ6Ly5AFGpsEHyt0KDEhozXP2WifF5RL0MspPcjlnCmc9THoT06e5CnkhDOO/dq6
         7qrFICaSQAw5/MQJPipW3TDMa1zo3NJiJe2Q6gX0c4sMsr4ogpKgRuXTX9t/0Jmql6sj
         SQ6g==
X-Gm-Message-State: APjAAAXK5/e25hyQKZn+Qf6iX0PHB644ZfXxj95rkr7U6qExBRRiERwj
        cRXCCqT2NY18b7B+0f1YjpC1jBmd
X-Google-Smtp-Source: APXvYqzP42mEoRk8/Jv/Ki92cgJ7X5+atwbOkhRKD1063mrgJjDkk3fCmzFgUyAluznq1erwNbzRgA==
X-Received: by 2002:a37:4ed5:: with SMTP id c204mr10878007qkb.41.1571871221295;
        Wed, 23 Oct 2019 15:53:41 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:40 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 19/22] btrfs: keep track of discard reuse stats
Date:   Wed, 23 Oct 2019 18:53:13 -0400
Message-Id: <ae43bf66f7747044182068524114c6680ae68854.1571865775.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
index 57cfc0e11c53..1bf016f8a3d8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -472,6 +472,9 @@ struct btrfs_discard_ctl {
 	u32 delay;
 	u32 iops_limit;
 	u64 bps_limit;
+	u64 discard_extent_bytes;
+	u64 discard_bitmap_bytes;
+	atomic64_t discard_bytes_saved;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index be5a4439ceb0..f95e437d7629 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -406,11 +406,15 @@ static void btrfs_discard_workfn(struct work_struct *work)
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
 					       minlen, maxlen, true);
+		WRITE_ONCE(discard_ctl->discard_bitmap_bytes,
+			   discard_ctl->discard_bitmap_bytes + trimmed);
 	} else {
 		btrfs_trim_block_group_extents(cache, &trimmed,
 					       cache->discard_cursor,
 					       btrfs_block_group_end(cache),
 					       minlen, true);
+		WRITE_ONCE(discard_ctl->discard_extent_bytes,
+			   discard_ctl->discard_extent_bytes + trimmed);
 	}
 
 	discard_ctl->prev_discard = trimmed;
@@ -614,6 +618,9 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
+	discard_ctl->discard_extent_bytes = 0;
+	discard_ctl->discard_bitmap_bytes = 0;
+	atomic64_set(&discard_ctl->discard_bytes_saved, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dc632afe5f61..29d3e21ba7fd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2817,6 +2817,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	u64 bytes_search = bytes + empty_size;
 	u64 ret = 0;
@@ -2833,6 +2835,10 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
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
@@ -2841,6 +2847,9 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 		align_gap = entry->offset;
 		align_gap_trim_state = entry->trim_state;
 
+		if (!btrfs_free_space_trimmed(entry))
+			atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
 
@@ -2945,6 +2954,8 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 			     u64 min_start, u64 *max_extent_size)
 {
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space *entry = NULL;
 	struct rb_node *node;
 	u64 ret = 0;
@@ -3009,6 +3020,9 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_group,
 
 	spin_lock(&ctl->tree_lock);
 
+	if (!btrfs_free_space_trimmed(entry))
+		atomic64_add(bytes, &discard_ctl->discard_bytes_saved);
+
 	ctl->free_space -= bytes;
 	if (!entry->bitmap && !btrfs_free_space_trimmed(entry))
 		ctl->discardable_bytes[BTRFS_STAT_CURR] -= bytes;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c441603b7da1..a00e260ead53 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -431,12 +431,48 @@ static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
 	      btrfs_discard_max_discard_size_store);
 
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
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, bps_limit),
 	BTRFS_ATTR_PTR(discard, max_discard_size),
+	BTRFS_ATTR_PTR(discard, discard_extent_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bitmap_bytes),
+	BTRFS_ATTR_PTR(discard, discard_bytes_saved),
 	NULL,
 };
 
-- 
2.17.1

