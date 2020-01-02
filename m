Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9349712EB4F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2020 22:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgABV0z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jan 2020 16:26:55 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42060 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgABV0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jan 2020 16:26:54 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so31115562qkg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jan 2020 13:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=iyfaqzULUE1H7nul54Fg/Doy0YpQWDaHW1wBXlrhRhA=;
        b=hZUlPUoy/lZpupYVDCMmcFBNRVCL29S/AdYn9xrZeqoCcjoucJEYDaBOshx2doU11y
         6SfQ+ZrTk9HzHG0U4gyT5fxM/S2L5/bjVVNvSbL3VuzQ+74Bxg8z72St6RHo2fG4VorZ
         nq3yDpVNa7YO31dHrs1VffhREbQV71zUJdPFl9KI3jQR5qx5K+Nup95noNCkrhjl3K50
         QBliCTejiStGPcztkhVgzmzdUWEyFTT4h4xtm11bsoFPbGotDSPOT6ARU9Q/oPmUMsAz
         QisOTNu0ReG1t9Mg+nvbdgbqr7/f5fklslc7m1VmLTG73NmVXssmuGDT3kPTTHjlpFyD
         QGxg==
X-Gm-Message-State: APjAAAWePpWrWeO5nuV/03gixrcpz5EHRRw4qBYoKuUeMitv1YbWiyq0
        2Yg2qHMiy6Py1hHH0YYGheY=
X-Google-Smtp-Source: APXvYqxaaLhjii8+9gOJMyW91NCLGfNOvaivd70JC87ePxQQepb748jGkNaCjgLIX8ACVDkAR+rb4w==
X-Received: by 2002:a37:ac12:: with SMTP id e18mr69367381qkm.94.1578000413053;
        Thu, 02 Jan 2020 13:26:53 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f42sm17553933qta.0.2020.01.02.13.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jan 2020 13:26:52 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 02/12] btrfs: add bps discard rate limit for async discard
Date:   Thu,  2 Jan 2020 16:26:36 -0500
Message-Id: <8929cde12ad0237ab8a4e2bbdff7b713886eff56.1577999991.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
References: <cover.1577999991.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provide the ability to rate limit based on kbps in addition to iops as
additional guides for the target discard rate. The delay used ends up
being max(kbps_delay, iops_delay).

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/discard.c | 23 +++++++++++++++++++++--
 fs/btrfs/sysfs.c   | 31 +++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c73bbc7e4491..2485cf94b628 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -466,10 +466,12 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group *block_group;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	u64 prev_discard;
 	atomic_t discardable_extents;
 	atomic64_t discardable_bytes;
 	unsigned long delay;
 	unsigned iops_limit;
+	u32 kbps_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index abcc3b2189d1..eb148ca9a508 100644
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
@@ -222,8 +223,8 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
  * @override: override the current timer
  *
  * Discards are issued by a delayed workqueue item.  @override is used to
- * update the current delay as the baseline delay interview is reevaluated
- * on transaction commit.  This is also maxed with any other rate limit.
+ * update the current delay as the baseline delay interval is reevaluated on
+ * transaction commit.  This is also maxed with any other rate limit.
  */
 void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override)
@@ -242,6 +243,20 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	block_group = find_next_block_group(discard_ctl, now);
 	if (block_group) {
 		unsigned long delay = discard_ctl->delay;
+		u32 kbps_limit = READ_ONCE(discard_ctl->kbps_limit);
+
+		/*
+		 * A single delayed workqueue item is responsible for
+		 * discarding, so we can manage the bytes rate limit by keeping
+		 * track of the previous discard.
+		 */
+		if (kbps_limit && discard_ctl->prev_discard) {
+			u64 bps_limit = ((u64)kbps_limit) * SZ_1K;
+			u64 bps_delay = div64_u64(discard_ctl->prev_discard *
+						  MSEC_PER_SEC, bps_limit);
+
+			delay = max(delay, msecs_to_jiffies(bps_delay));
+		}
 
 		/*
 		 * This timeout is to hopefully prevent immediate discarding
@@ -317,6 +332,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       btrfs_block_group_end(block_group),
 				       0, true);
 
+	discard_ctl->prev_discard = trimmed;
+
 	/* Determine next steps for a block_group */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
 		if (discard_state == BTRFS_DISCARD_BITMAPS) {
@@ -507,10 +524,12 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
 		INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
+	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discardable_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
 	discard_ctl->delay = BTRFS_DISCARD_MAX_DELAY_MSEC;
 	discard_ctl->iops_limit = BTRFS_DISCARD_MAX_IOPS;
+	discard_ctl->kbps_limit = 0;
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e175aaf7a1e6..39b59f368f06 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -374,6 +374,36 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
 	      btrfs_discard_iops_limit_store);
 
+static ssize_t btrfs_discard_kbps_limit_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			READ_ONCE(fs_info->discard_ctl.kbps_limit));
+}
+
+static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
+	struct btrfs_discard_ctl *discard_ctl = &fs_info->discard_ctl;
+	u32 kbps_limit;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &kbps_limit);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(discard_ctl->kbps_limit, kbps_limit);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, kbps_limit, btrfs_discard_kbps_limit_show,
+	      btrfs_discard_kbps_limit_store);
+
 static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 					      struct kobj_attribute *a,
 					      char *buf)
@@ -398,6 +428,7 @@ BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
 static const struct attribute *discard_debug_attrs[] = {
 	BTRFS_ATTR_PTR(discard, iops_limit),
+	BTRFS_ATTR_PTR(discard, kbps_limit),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	NULL,
-- 
2.17.1

