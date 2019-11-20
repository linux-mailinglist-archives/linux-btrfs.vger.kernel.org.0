Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E9104620
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfKTVvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:46 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32939 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKTVvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id x14so585457qvu.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8o9w5FY2rpOx4+fkRz4LarXp/DKKm1eBt4JLpMZhFPk=;
        b=Sz7BGdw+5j/lQ2EFayWKJ//iycW4q9KHBcDFxpWJuxnKMuVBwtvWONPxGVsVvPZhUB
         YkJ0+pP8iiW/2xl9utc8TlQ8oBRCJMk3brT8AF+HU97Bns8h67LC3D3Hw5f7JhxmxmZf
         /l4vhu3/kn2icNqBB5LKketMPYmqI1mUePzc+WzEqhu7WEv3w/tlOmgOaQ1Fzvdbr/bB
         QYA+RffGkBC9nc9hncYrHzl4mA8SJKPaQO4Q0A0WkYd6ADkqj/IuKU13lwhc001jPsth
         r2iK8Qi/+1dFAhG/4abQUJR8XvYEmS22mgZJc/Q446PSGqykiobCXnPUtyAUpiAkV4LQ
         PXXg==
X-Gm-Message-State: APjAAAVbNhdfEoYSxVHBKrnohV4++PJD49d/9mQMA8ZVMvzvZX1yrIPw
        XQKtutt+GsV+lgo5YsHlWSM=
X-Google-Smtp-Source: APXvYqy7dALdtlSemRo97jh31MrzpWHDCQhw0b+q2QSFGkDD2VtlpLUABX+pyoPIshBp/gcgPJVfBw==
X-Received: by 2002:a0c:804c:: with SMTP id 70mr5005697qva.81.1574286704157;
        Wed, 20 Nov 2019 13:51:44 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:43 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/22] btrfs: add bps discard rate limit
Date:   Wed, 20 Nov 2019 16:51:13 -0500
Message-Id: <96d1c5f7065e4486c33c6e74ae8659ceb91eab7c.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provide an ability to rate limit based on mbps in addition to the iops
delay calculated from number of discardable extents.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/discard.c | 17 +++++++++++++++++
 fs/btrfs/sysfs.c   | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 78b970cfd108..303f000fe30a 100644
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
index f40bff5621d9..47fbe95f7aea 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -237,6 +237,19 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
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
+			u64 bps_delay = (MSEC_PER_SEC *
+					 discard_ctl->prev_discard / bps_limit);
+
+			delay = max_t(u64, delay, msecs_to_jiffies(bps_delay));
+		}
 
 		/*
 		 * This timeout is to hopefully prevent immediate discarding
@@ -315,6 +328,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 				       btrfs_block_group_end(block_group),
 				       0, true);
 
+	discard_ctl->prev_discard = trimmed;
+
 	/* Determine next steps for a block_group. */
 	if (block_group->discard_cursor >= btrfs_block_group_end(block_group)) {
 		if (discard_state == BTRFS_DISCARD_BITMAPS) {
@@ -511,10 +526,12 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
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
index 043430ae3818..028081bdde6c 100644
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

