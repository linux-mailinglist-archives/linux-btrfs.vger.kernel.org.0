Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5268F117629
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfLITqa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43022 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfLITq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id h14so7738375pfe.10
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1MJhVjCf0RGoJql+i++4FHAKFZgL/axx97sGOT9oJM4=;
        b=lkee0hry5Di/Bh5/Tn05OfBTJBPRIposC9b5sfJ0SZm9O4VkE0yJwQe+k3z7VBCsaj
         d+pVxD+0JFSU5TZbFlqiYQZYCxKuBOZNwXzuk7AEmaukhA2OEQTbn0diLi35ZUp1bf1H
         z2xDrEG1tmPpwqxJ3F/qWh7sgTdlpHSjqKqy2bTQzR1vmWktJikLQ07YMFwSDxKxBClw
         8MW4kexepphmbD9+aKotSb8tKgUNH3ujb0gVRGgYLjYG5b5/YWDz5f4geP3lkfIF2ddQ
         IYBNaRRnzDY8p5AGe9KRjBqXOfZs1RyQzYAApiz1oRTb325CCi0RLvYNEOM5VwGXelBw
         KEew==
X-Gm-Message-State: APjAAAVdrtvEI7K6hAxQPRhjkKQZ4iRQ0ZAhBfSQd2aDfQwrbVcAfnSt
        2CFwY1nnDXWJzKeXikv9REM=
X-Google-Smtp-Source: APXvYqyS6oYvXZEUNLUo2vLkyKJBan/6swkJWDt5GuGpHPu8ri5v6m6aOhQ2f/VKBGK7MjP9kYtedA==
X-Received: by 2002:a62:1a97:: with SMTP id a145mr32271051pfa.244.1575920788175;
        Mon, 09 Dec 2019 11:46:28 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:27 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 16/22] btrfs: make max async discard size tunable
Date:   Mon,  9 Dec 2019 11:46:01 -0800
Message-Id: <3d4bae458b7c629ceab70870ba663ef6f5bbc317.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Expose max_discard_size as a tunable via sysfs.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  1 +
 fs/btrfs/discard.c          |  1 +
 fs/btrfs/free-space-cache.c | 19 ++++++++++++-------
 fs/btrfs/sysfs.c            | 31 +++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2d7354b5e312..2f7bead5ae25 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -470,6 +470,7 @@ struct btrfs_discard_ctl {
 	u64 prev_discard;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	u64 max_discard_size;
 	u32 delay;
 	u32 iops_limit;
 	u64 bps_limit;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 085f36808e7f..dd5143f0283f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -536,6 +536,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_MAX_SIZE;
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0dbcea6c59f9..e5bb37627807 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3431,6 +3431,8 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
 			  bool async)
 {
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -3439,6 +3441,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	u64 extent_bytes;
 	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
+	u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 
 	while (start < end) {
 		struct btrfs_trim_range trim_entry;
@@ -3476,11 +3479,10 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 				goto next;
 			}
 			unlink_free_space(ctl, entry);
-			if (bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE) {
-				bytes = extent_bytes =
-					BTRFS_ASYNC_DISCARD_MAX_SIZE;
-				entry->offset += BTRFS_ASYNC_DISCARD_MAX_SIZE;
-				entry->bytes -= BTRFS_ASYNC_DISCARD_MAX_SIZE;
+			if (max_discard_size && bytes > max_discard_size) {
+				bytes = extent_bytes = max_discard_size;
+				entry->offset += max_discard_size;
+				entry->bytes -= max_discard_size;
 				link_free_space(ctl, entry);
 			} else {
 				kmem_cache_free(btrfs_free_space_cachep, entry);
@@ -3589,12 +3591,15 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			u64 *total_trimmed, u64 start, u64 end, u64 minlen,
 			bool async)
 {
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
 	int ret = 0;
 	int ret2;
 	u64 bytes;
 	u64 offset = offset_to_bitmap(ctl, start);
+	u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 
 	while (offset < end) {
 		bool next_bitmap = false;
@@ -3664,8 +3669,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			goto next;
 		}
 
-		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
-			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+		if (async && max_discard_size && bytes > max_discard_size)
+			bytes = max_discard_size;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 12f7a906a36f..e71e8bbc57d0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -404,6 +404,36 @@ static ssize_t btrfs_discard_bps_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, bps_limit, btrfs_discard_bps_limit_show,
 	      btrfs_discard_bps_limit_store);
 
+static ssize_t btrfs_discard_max_discard_size_show(struct kobject *kobj,
+						   struct kobj_attribute *a,
+						   char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			READ_ONCE(fs_info->discard_ctl.max_discard_size));
+}
+
+static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
+						    struct kobj_attribute *a,
+						    const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	u64 max_discard_size;
+	int ret;
+
+	ret = kstrtou64(buf, 10, &max_discard_size);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(discard_ctl->max_discard_size, max_discard_size);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
+	      btrfs_discard_max_discard_size_store);
+
 static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 					      struct kobj_attribute *a,
 					      char *buf)
@@ -429,6 +459,7 @@ BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, bps_limit),
+	BTRFS_ATTR_PTR(discard, max_discard_size),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
-- 
2.17.1

