Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C1A117627
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLITq2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37205 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfLITq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id q127so7623008pga.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=k8JlalT2c0iaqwONMJwpR5TxKr4YE3M7tpXYANzG8qg=;
        b=eIWdnfjT0XLzrhBzIpEy957o3KwYAqrD6gbG8B/424UJoYnui9XbCHGmsEMZCVPYLi
         I4U6BP3kgh8NCPWR0HR3rEioVVyAJTWiu37Dt0BIM8/6cTrXSYhpUermkAk8F7jYPVaG
         AC4LAr0LdsbR4ESsCIwbJmnpJvHWWg5Reo9czpv6Low9HCGQ4Ne6vVy79U1tfNR0GZhr
         q3ecg+4ocLT4TcxIic2V0exHNmHtrJ/oKueRQSUCwpgqWzYC1cuAbJu9IfMKCSADHDG5
         h1K/9+6WEK90rdJ7jokCKprhnegYDRjW4YzyXti48Cl8jyQFI9O/nVjXZQ7pzwL7zlZF
         TZBg==
X-Gm-Message-State: APjAAAXHaF3ch+wF6m/7YS8J/iFbe9a8UkFcfiZuDVmj+itD1izovyQE
        JcilRi64+hDSLbsQqNVp5eI=
X-Google-Smtp-Source: APXvYqwxpSD1HLBdtDOfGtdGEkEEaSYXsa+y23ykjvSoNERC/P9JEBoYsC5S0F1/WjP8bBfUCssRUg==
X-Received: by 2002:a63:4e47:: with SMTP id o7mr20641484pgl.332.1575920785974;
        Mon, 09 Dec 2019 11:46:25 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:25 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/22] btrfs: add bps discard rate limit
Date:   Mon,  9 Dec 2019 11:45:59 -0800
Message-Id: <76b6ccab8ddad509fffe0366f4e75b405756bc3c.1575919746.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provide an ability to rate limit based on mbps in addition to the iops
delay calculated from number of discardable extents.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/discard.c | 18 ++++++++++++++++++
 fs/btrfs/sysfs.c   | 31 +++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ae21e5659dd8..2d7354b5e312 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -467,10 +467,12 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group *block_group;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	u64 prev_discard;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
 	u32 delay;
 	u32 iops_limit;
+	u64 bps_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 160713e04d0c..085f36808e7f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/workqueue.h>
 #include "ctree.h"
@@ -245,6 +246,19 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
 		u32 delay = discard_ctl->delay;
+		u64 bps_limit = READ_ONCE(discard_ctl->bps_limit);
+
+		/*
+		 * A single delayed workqueue item is responsible for
+		 * discarding, so we can manage the bytes rate limit by keeping
+		 * track of the previous discard.
+		 */
+		if (bps_limit && discard_ctl->prev_discard) {
+			u64 bps_delay = div64_u64(discard_ctl->prev_discard *
+						  MSEC_PER_SEC, bps_limit);
+
+			delay = max_t(u64, delay, msecs_to_jiffies(bps_delay));
+		}
 
 		/*
 		 * This timeout is to hopefully prevent immediate discarding
@@ -322,6 +336,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       btrfs_block_group_end(block_group),
 				       0, true);
 
+	discard_ctl->prev_discard = trimmed;
+
 	/* Determine next steps for a block_group. */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
 		if (discard_state == BTRFS_DISCARD_BITMAPS) {
@@ -517,10 +533,12 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
 		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
+	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
+	discard_ctl->bps_limit = 0;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 79139b4b4f0a..12f7a906a36f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -374,6 +374,36 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
 	      btrfs_discard_iops_limit_store);
 
+static ssize_t btrfs_discard_bps_limit_show(struct kobject *kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			READ_ONCE(fs_info->discard_ctl.bps_limit));
+}
+
+static ssize_t btrfs_discard_bps_limit_store(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	u64 bps_limit;
+	int ret;
+
+	ret = kstrtou64(buf, 10, &bps_limit);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(discard_ctl->bps_limit, bps_limit);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, bps_limit, btrfs_discard_bps_limit_show,
+	      btrfs_discard_bps_limit_store);
+
 static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 					      struct kobj_attribute *a,
 					      char *buf)
@@ -398,6 +428,7 @@ BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, iops_limit),
+	BTRFS_ATTR_PTR(discard, bps_limit),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
-- 
2.17.1

