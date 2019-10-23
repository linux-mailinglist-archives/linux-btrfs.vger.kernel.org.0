Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14021E26AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436938AbfJWWxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40023 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436922AbfJWWxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so26908569qta.7
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6n7xUP5ll26OKRSxQStboBnDNtcIk7uUWfdrIN1roj4=;
        b=IYL21k3zdxtOvzcBswyb/krjGXNnN3AXcjEwgeo0PeVYnVwneNhLY76cTI1N6E95iP
         m22twmxWFiCfbE7BVxXAnbpji7g5zikhTWkUKxaeUCUUF5n8wlNxVZ9CTi+4+Z0loL5C
         AD2DKYzUs6S/hPktfLkRDwT2NFPRmQ3wdV/VL/phMsCjtYYWvwMjnV2+DdYdSFXVJ6i9
         fUZ7IuczDiEkOXK7xWOOe6bw5m78YUCxia98SHVsWHzix9iNrtM+6V/Zu8x41KX6NoJW
         n20lUJZwTxkhbXP4eRfOCE9tSQLn81kqCUpDemQ6qJPE16NCg6jpAfMp8FPUamZqCYq3
         sZWg==
X-Gm-Message-State: APjAAAUFC7wPfUhDyY0DmLfWHssdT3EwlQ1nlL5p6qYUiqXjHJ6mAyYJ
        +02riaZpJJvvK5iMeSxWE4A=
X-Google-Smtp-Source: APXvYqy1vwAHTy3dZUJvXA3T6i2gRIEzFYSOeU+RZkUhGOP1bUqbQLAl0ZjB5/yF0oXGiC6z3UBYMg==
X-Received: by 2002:aed:34c6:: with SMTP id x64mr1083712qtd.324.1571871215443;
        Wed, 23 Oct 2019 15:53:35 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:34 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 14/22] btrfs: add bps discard rate limit
Date:   Wed, 23 Oct 2019 18:53:08 -0400
Message-Id: <8efa082438eea760533f1cddffa74cebdea6f028.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
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
index 246141e2f825..eccfc27e9b83 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -465,10 +465,12 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group_cache *cache;
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
index c3da4a537b5a..70873cd884bf 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -238,6 +238,19 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	cache = find_next_cache(discard_ctl, now);
 	if (cache) {
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
@@ -312,6 +325,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 					       btrfs_block_group_end(cache),
 					       0, true);
 
+	discard_ctl->prev_discard = trimmed;
+
 	/* Determine next steps for a block_group. */
 	if (cache->discard_cursor >= btrfs_block_group_end(cache)) {
 		if (discard_state == BTRFS_DISCARD_BITMAPS) {
@@ -503,10 +518,12 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
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
index 4955afc225c7..070fa6223911 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -371,10 +371,41 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
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
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, iops_limit),
+	BTRFS_ATTR_PTR(discard, bps_limit),
 	NULL,
 };
 
-- 
2.17.1

