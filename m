Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC98510946E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKYTr1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38201 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfKYTr0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id e2so13940480qkn.5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WgUX1nnyUuZ2SLI+nwXY5rwEtLfw8mEHuGCXouJzMiQ=;
        b=gSR5qn3JxeqxS5jCZtKQIeUWVTa4Wb2E60km16dQGKJHnQC26/lQU/eTSrHoRFyiac
         W/jLxX1IWB8Fufv+fX1HKUDko8NlIhmnxnrr2foX60vA3Z3V93yPlqTOIBQC04NrzSF1
         nmZMgTepQ9Tso9XlYOK+m7vvIAAVDfnVuFcQV3/uabKcYVzXRYDwEZYPuioP5o2MRyLP
         mvD8VvgEhll4lVWT3ukYTbssFi53ZQ24aKbxPQxF+kXu6gzMMdtuZ+bY7q+fkUw2b7NH
         CjMIEhLqM29w4k744juQ69KUE7BkMI30a/6RzoKFHjIEaG92mRWNwROgLaJjoJvOQ+xr
         e2Rg==
X-Gm-Message-State: APjAAAX1zUUj4D7tFT/s+O52Vbds1YFtZS7ZCM4KjG8VnPiyZ50N56+Y
        z40oH5lN7BVOAzCw2sHFYi4=
X-Google-Smtp-Source: APXvYqxukUjLd9g6JXroxdty6K7/2r+2g4jjEuyKoP6et+T6IVxcEfYrJx21B4z0Z8iQ8RFt9fvGCw==
X-Received: by 2002:a37:f905:: with SMTP id l5mr14370745qkj.90.1574711245508;
        Mon, 25 Nov 2019 11:47:25 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:24 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 16/22] btrfs: make max async discard size tunable
Date:   Mon, 25 Nov 2019 14:46:56 -0500
Message-Id: <355a12c95c442c50a0da3370c8d8befb113b6bd7.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
index 303f000fe30a..37ad60913092 100644
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
index 49e148a6a0ea..93e632267247 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -530,6 +530,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_MAX_SIZE;
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 452afd616623..1c195308652d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3407,6 +3407,8 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
 			  bool async)
 {
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -3415,6 +3417,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	u64 extent_bytes;
 	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
+	u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 
 	while (start < end) {
 		struct btrfs_trim_range trim_entry;
@@ -3452,11 +3455,10 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3565,12 +3567,15 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3640,8 +3645,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			goto next;
 		}
 
-		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
-			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+		if (async && max_discard_size && bytes > max_discard_size)
+			bytes = max_discard_size;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 028081bdde6c..65417a66866d 100644
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

