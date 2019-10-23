Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8F4E26AE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436940AbfJWWxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:40 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42601 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436934AbfJWWxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:39 -0400
Received: by mail-qk1-f196.google.com with SMTP id m4so4564897qke.9
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3to4xmsgBoYlKXz82jXg7BfTjxcOMWxo25hbjE7yG4E=;
        b=rpAv9dEtXmMP+7L//5nDG0b0Ig5BbZVtwAv6HT0bMgfz+WIaigk4DM5OZCcHiPfUJ5
         /CxErCNtgPD7JaPHiak5elW2dOnTVOuvWBB23U4Eu3hsOuhCr84ISpyJ+b+XhvVcmJwp
         VytECUseKoAiZsW+u2fcYCQQXrYnIHydhhDrLWfZ5zdjWYIuKPFK90ETnFAN+slS7EAa
         g+5nL/yOHs6gaHQ+6wYG9H163ThaawMamsSWd31sEp1KqETMsSSlUor6BZreYXAacnl6
         IPfcgVGS1iLOQvzli1GpREi/Rq9ELA1YDKDPSwnr6cWougUIkq+sBlS6AElOcGwnTdx8
         l1VA==
X-Gm-Message-State: APjAAAXHiUPK3Xeo7GQoIURJo+k+Jxe0H+nTYiV7dxSD/2dBm1RxPhha
        RuLaZdD/8N+oPwRE3F0xraI=
X-Google-Smtp-Source: APXvYqx/o5r2NfCDuAm4UdnjHlw+C9VxGWAXXyUvZ3beWhRHvkvXks2IQc9w5FVoVZaBQ+0IgeA2Ag==
X-Received: by 2002:ae9:e513:: with SMTP id w19mr3798866qkf.308.1571871217764;
        Wed, 23 Oct 2019 15:53:37 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:37 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 16/22] btrfs: make max async discard size tunable
Date:   Wed, 23 Oct 2019 18:53:10 -0400
Message-Id: <6b33c5e684690d81dfc7161e0742eb24aa0e3bf1.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
index eccfc27e9b83..0a87970c7117 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -468,6 +468,7 @@ struct btrfs_discard_ctl {
 	u64 prev_discard;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
+	u64 max_discard_size;
 	u32 delay;
 	u32 iops_limit;
 	u64 bps_limit;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 70873cd884bf..f7799b659d39 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -521,6 +521,7 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
+	discard_ctl->max_discard_size = BTRFS_ASYNC_DISCARD_MAX_SIZE;
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
 	discard_ctl->bps_limit = 0;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 186a4243fb7f..c62346b23ca0 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3406,6 +3406,8 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 			  u64 *total_trimmed, u64 start, u64 end, u64 minlen,
 			  bool async)
 {
+	struct btrfs_discard_ctl *discard_ctl =
+					&block_group->fs_info->discard_ctl;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *entry;
 	struct rb_node *node;
@@ -3414,6 +3416,7 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
 	u64 extent_bytes;
 	enum btrfs_trim_state extent_trim_state;
 	u64 bytes;
+	u64 max_discard_size = READ_ONCE(discard_ctl->max_discard_size);
 
 	while (start < end) {
 		struct btrfs_trim_range trim_entry;
@@ -3450,11 +3453,10 @@ static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
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
@@ -3563,12 +3565,15 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
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
@@ -3638,8 +3643,8 @@ static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
 			goto next;
 		}
 
-		if (async && bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE)
-			bytes = BTRFS_ASYNC_DISCARD_MAX_SIZE;
+		if (async && max_discard_size && bytes > max_discard_size)
+			bytes = max_discard_size;
 
 		bitmap_clear_bits(ctl, entry, start, bytes);
 		if (entry->bytes == 0)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 070fa6223911..c441603b7da1 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -401,11 +401,42 @@ static ssize_t btrfs_discard_bps_limit_store(struct kobject *kobj,
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
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, iops_limit),
 	BTRFS_ATTR_PTR(discard, bps_limit),
+	BTRFS_ATTR_PTR(discard, max_discard_size),
 	NULL,
 };
 
-- 
2.17.1

