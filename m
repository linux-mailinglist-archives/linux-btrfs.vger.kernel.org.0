Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117AD12EB50
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgABV04 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43221 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABV04 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id t129so32359194qke.10
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=nYpxLbpm9KSucsYDPYdd9HUhINGTrnEqQK70rkWv3Tg=;
        b=S8Ve+eWITc1/qMz7/CDIkPfITm4Tzfp+71R+vlcF7OQnSEjgoodiHL9sCX5s4nf6fH
         AsGVmJOEmauNdX7INxBnygdhO46s7uy1FvG/tP5NgdFTQR+HOnnGoewRLRCCDKtZgoOa
         Eceo4kh7koccPRW0N1gab/LPvrAFkrifjWO20sDJSi6/6svSJ6u6nbpDw6Kwn+vzaRR4
         ND+ad4bP763RdNbIJPQT+Zgr4GiHBL+RRjlxjuKFsf5d3h9i5wauiHn1cnoDqnmghk8j
         MNaQDmtJKjRTwSnwNAHeef7dixeLVUshkXKvLMxnQ1O751O7Zh9TApmi4CzTTyjaSgWm
         +UIA==
X-Gm-Message-State: APjAAAVI1nPtrKNfXOPb2iATt9TQRRszabUclld9AMyl+riuhqgcO3YD
        V6Kw5t+whrjEHW2OaIP+VHg=
X-Google-Smtp-Source: APXvYqyqnwbUx2jpueYGsuaM++bbFXNcXpmPwBcPO5BXhAJn06IzUCoF8TifLA03SiC8sOgfX0kjew==
X-Received: by 2002:ae9:c317:: with SMTP id n23mr59838043qkg.356.1578000415262;
        Thu, 02 Jan 2020 13:26:55 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:54 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 04/12] btrfs: make max async discard size tunable
Date:   Thu,  2 Jan 2020 16:26:38 -0500
Message-Id: <786ac88afbfaa7993449811b282ea8790ba02338.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Expose max_discard_size as a tunable via sysfs.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h            |  1 +
 fs/btrfs/discard.c          |  1 +
 fs/btrfs/discard.h          |  2 +-
 fs/btrfs/free-space-cache.c | 19 ++++++++++++-------
 fs/btrfs/sysfs.c            | 31 +++++++++++++++++++++++++++++++
 5 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2485cf94b628..9328a0398678 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -469,6 +469,7 @@ struct btrfs_discard_ctl {
 	u64 prev_discard;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	u64 max_discard_size;
 	unsigned long delay;
 	unsigned iops_limit;
 	u32 kbps_limit;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index eb148ca9a508..822b888d90e3 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -527,6 +527,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_DFL_MAX_SIZE;
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->kbps_limit = 0;
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 562c60fab77a..72816e479416 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -10,7 +10,7 @@ struct btrfs_discard_ctl;
 struct btrfs_block_group;
 
 /* Discard size limits */
-#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
+#define BTRFS_ASYNC_DISCARD_DFL_MAX_SIZE	(SZ_64M)
 
 /* Work operations */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 34291c777998..fb1a53f9b39c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3428,6 +3428,8 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
 			  bool async)
 {
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -3436,6 +3438,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 	u64 extent_bytes;
 	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
+	u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 
 	while (start < end) {
 		struct btrfs_trim_range trim_entry;
@@ -3475,11 +3478,10 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
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
@@ -3584,12 +3586,15 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
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
@@ -3659,8 +3664,8 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 			goto next;
 		}
 
-		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
-			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+		if (async && max_discard_size && bytes > max_discard_size)
+			bytes = max_discard_size;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 39b59f368f06..8b0fd8557438 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -404,6 +404,36 @@ static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, kbps_limit, btrfs_discard_kbps_limit_show,
 	      btrfs_discard_kbps_limit_store);
 
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
 	BTRFS_ATTR_PTR(discard, kbps_limit),
+	BTRFS_ATTR_PTR(discard, max_discard_size),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
-- 
2.17.1

