Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57667CED4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfJGUSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35699 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfJGUSG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so13945230qkf.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=D69HcfbLaSqbc4D/lcdl3qkYuH7POSGAARB4xBOl5Rw=;
        b=IsN/ITdF0QX1bNntnsz2aGkeAmknZhbtdgEP5lVJji5cPW7X565ZFHPCcNPuHgJ718
         QYDrORVZxHzRRR4bt53PQ7nq6/9QZMt14ZKG77dqLmTo0oY98a1rUXYnWEk34aOCCWSH
         4iq2OmVgRudfMC7/o1aPDiY9r1WTYQ8C9IcVuTUjEdtdUK0SUpChVj9Ly2uI+I4XxyaO
         lfR4EeqWvYHf0q4EZX2e675ctxQmNh8J/iCA7BhtWDnTA5gJHaBGQB3LnDazNm4rm2VZ
         o5JV80qcoMU/WW8FjS6b0Gds7rblrN0CXOoDoFXWSfXmoB63iNk51iu1DdNJ/Ed4Kmds
         5C+w==
X-Gm-Message-State: APjAAAWRq8+yBc7DtoC2jvIaicnJ5mPxP9ocv/iAh68PDGq+VJPLPtEi
        lOiXMFQm03BswlEWz+UKSyQ=
X-Google-Smtp-Source: APXvYqxCFuD4JEDI7jlIDOud2CKVs841A1prKKAVpL/PSod8rjpj4Y2B8/2huArkWdrGQV/mxmGeWw==
X-Received: by 2002:a37:2e42:: with SMTP id u63mr25014950qkh.157.1570479486024;
        Mon, 07 Oct 2019 13:18:06 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:18:05 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 11/19] btrfs: add bps discard rate limit
Date:   Mon,  7 Oct 2019 16:17:42 -0400
Message-Id: <17152a4b1f9a0719623af4ef98e5e8670dd70799.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provide an ability to rate limit based on mbps in addition to the iops
delay calculated from number of discardable extents.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/ctree.h   |  2 ++
 fs/btrfs/discard.c | 11 +++++++++++
 fs/btrfs/sysfs.c   | 30 ++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b0823961d049..e81f699347e0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -447,10 +447,12 @@ struct btrfs_discard_ctl {
 	spinlock_t lock;
 	struct btrfs_block_group_cache *cache;
 	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
+	u64 prev_discard;
 	atomic_t discard_extents;
 	atomic64_t discardable_bytes;
 	atomic_t delay;
 	atomic_t iops_limit;
+	atomic64_t bps_limit;
 };
 
 /* delayed seq elem */
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index c7afb5f8240d..072c73f48297 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -176,6 +176,13 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	cache = find_next_cache(discard_ctl, now);
 	if (cache) {
 		u64 delay = atomic_read(&discard_ctl->delay);
+		s64 bps_limit = atomic64_read(&discard_ctl->bps_limit);
+
+		if (bps_limit)
+			delay = max_t(u64, delay,
+				      msecs_to_jiffies(MSEC_PER_SEC *
+						discard_ctl->prev_discard /
+						bps_limit));
 
 		if (now < cache->discard_delay)
 			delay = max_t(u64, delay,
@@ -213,6 +220,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 		btrfs_trim_block_group(cache, &trimmed, cache->discard_cursor,
 				       btrfs_block_group_end(cache), 0, true);
 
+	discard_ctl->prev_discard = trimmed;
+
 	if (cache->discard_cursor >= btrfs_block_group_end(cache)) {
 		if (btrfs_discard_bitmaps(cache)) {
 			remove_from_discard_list(discard_ctl, cache);
@@ -324,10 +333,12 @@ void btrfs_discard_init(struct btrfs_fs_info *fs_info)
 	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++)
 		 INIT_LIST_HEAD(&discard_ctl->discard_list[i]);
 
+	discard_ctl->prev_discard = 0;
 	atomic_set(&discard_ctl->discard_extents, 0);
 	atomic64_set(&discard_ctl->discardable_bytes, 0);
 	atomic_set(&discard_ctl->delay, BTRFS_DISCARD_MAX_DELAY);
 	atomic_set(&discard_ctl->iops_limit, BTRFS_DISCARD_MAX_IOPS);
+	atomic64_set(&discard_ctl->bps_limit, 0);
 }
 
 void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index b9a62e470316..6fc4d644401b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -522,10 +522,40 @@ static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
 BTRFS_ATTR_RW(discard, iops_limit, btrfs_discard_iops_limit_show,
 	      btrfs_discard_iops_limit_store);
 
+static ssize_t btrfs_discard_bps_limit_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n",
+			atomic64_read(&fs_info->discard_ctl.bps_limit));
+}
+
+static ssize_t btrfs_discard_bps_limit_store(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
+	s64 bps_limit;
+	int ret;
+
+	ret = kstrtos64(buf, 10, &bps_limit);
+	if (ret || bps_limit < 0)
+		return -EINVAL;
+
+	atomic64_set(&fs_info->discard_ctl.bps_limit, bps_limit);
+
+	return len;
+}
+BTRFS_ATTR_RW(discard, bps_limit, btrfs_discard_bps_limit_show,
+	      btrfs_discard_bps_limit_store);
+
 static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discard_extents),
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, iops_limit),
+	BTRFS_ATTR_PTR(discard, bps_limit),
 	NULL,
 };
 
-- 
2.17.1

