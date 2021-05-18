Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C1387BB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 16:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhEROx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 10:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:42690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235888AbhEROx2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 10:53:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621349529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+slbQBDPglzZz1tknkGivHDuynjAzNNS9LsnLiAed8k=;
        b=q8g7rEb6WqUChi10xeU43CmQLZc4tjVqNf5uptXCy6Q5Qj/eHHLXJab10E01Wq82y9zqZD
        8tcNLfGt4RVTC4bzDoqQiEgRV1CbsJGwG4vcdxUNH6zcQA5OtU+AVsZYHRNfLvgBfBvhdH
        0J2bFogdTjtpJxeoYP0wro6WdZCjsbU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8519B153;
        Tue, 18 May 2021 14:52:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B311BDB228; Tue, 18 May 2021 16:49:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: scrub: per-device bandwidth control
Date:   Tue, 18 May 2021 16:49:35 +0200
Message-Id: <20210518144935.15835-1-dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add sysfs interface to limit io during scrub. We relied on the ionice
interface to do that, eg. the idle class let the system usable while
scrub was running. This has changed when mq-deadline got widespread and
did not implement the scheduling classes. That was a CFQ thing that got
deleted. We've got numerous complaints from users about degraded
performance.

Currently only BFQ supports that but it's not a common scheduler and we
can't ask everybody to switch to it.

Alternatively the cgroup io limiting can be used but that also a
non-trivial setup (v2 required, the controller must be enabled on the
system). This can still be used if desired.

Other ideas that have been explored: piggy-back on ionice (that is set
per-process and is accessible) and interpret the class and classdata as
bandwidth limits, but this does not have enough flexibility as there are
only 8 allowed and we'd have to map fixed limits to each value. Also
adjusting the value would need to lookup the process that currently runs
scrub on the given device, and the value is not sticky so would have to
be adjusted each time scrub runs.

Running out of options, sysfs does not look that bad:

- it's accessible from scripts, or udev rules
- the name is similar to what MD-RAID has
  (/proc/sys/dev/raid/speed_limit_max or /sys/block/mdX/md/sync_speed_max)
- the value is sticky at least for filesystem mount time
- adjusting the value has immediate effect
- sysfs is available in constrained environments (eg. system rescue)
- the limit also applies to device replace

Sysfs:

- raw value is in bytes
- values written to the file accept suffixes like K, M
- file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/scrub_speed_max
- 0 means use default priority of IO

The scheduler is a simple deadline one and the accuracy is up to nearest
128K.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/sysfs.c   | 28 +++++++++++++++++++++
 fs/btrfs/volumes.h |  3 +++
 3 files changed, 92 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 485cda3eb8d7..83f3149253ea 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -165,6 +165,10 @@ struct scrub_ctx {
 	int			readonly;
 	int			pages_per_rd_bio;
 
+	/* State of IO submission throttling affecting the associated device */
+	ktime_t			throttle_deadline;
+	u64			throttle_sent;
+
 	int			is_dev_replace;
 	u64			write_pointer;
 
@@ -605,6 +609,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);
 	init_waitqueue_head(&sctx->list_wait);
+	sctx->throttle_deadline = 0;
 
 	WARN_ON(sctx->wr_curr_bio != NULL);
 	mutex_init(&sctx->wr_lock);
@@ -1988,6 +1993,60 @@ static void scrub_page_put(struct scrub_page *spage)
 	}
 }
 
+/*
+ * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
+ * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
+ */
+static void scrub_throttle(struct scrub_ctx *sctx)
+{
+	const int time_slice = 1000;
+	struct scrub_bio *sbio;
+	struct btrfs_device *device;
+	s64 delta;
+	ktime_t now;
+	u32 div;
+	u64 bwlimit;
+
+	sbio = sctx->bios[sctx->curr];
+	device = sbio->dev;
+	bwlimit = READ_ONCE(device->scrub_speed_max);
+	if (bwlimit == 0)
+		return;
+
+	/*
+	 * Slice is divided into intervals when the IO is submitted, adjust by
+	 * bwlimit and maximum of 64 intervals.
+	 */
+	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
+	div = min_t(u32, 64, div);
+
+	/* Start new epoch, set deadline */
+	now = ktime_get();
+	if (sctx->throttle_deadline == 0) {
+		sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
+		sctx->throttle_sent = 0;
+	}
+
+	/* Still in the time to send? */
+	if (ktime_before(now, sctx->throttle_deadline)) {
+		/* If current bio is within the limit, send it */
+		sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
+		if (sctx->throttle_sent <= bwlimit / div)
+			return;
+
+		/* We're over the limit, sleep until the rest of the slice */
+		delta = ktime_ms_delta(sctx->throttle_deadline, now);
+	} else {
+		/* New request after deadline, start new epoch */
+		delta = 0;
+	}
+
+	if (delta)
+		schedule_timeout_interruptible(delta * HZ / 1000);
+	/* Next call will start the deadline period */
+	sctx->throttle_deadline = 0;
+}
+
 static void scrub_submit(struct scrub_ctx *sctx)
 {
 	struct scrub_bio *sbio;
@@ -1995,6 +2054,8 @@ static void scrub_submit(struct scrub_ctx *sctx)
 	if (sctx->curr == -1)
 		return;
 
+	scrub_throttle(sctx);
+
 	sbio = sctx->bios[sctx->curr];
 	sctx->curr = -1;
 	scrub_pending_bio_inc(sctx);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 436ac7b4b334..c45d9b6dfdb5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1455,6 +1455,33 @@ static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 }
 BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
 
+static ssize_t btrfs_devinfo_scrub_speed_max_show(struct kobject *kobj,
+					     struct kobj_attribute *a,
+					     char *buf)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n",
+			 READ_ONCE(device->scrub_speed_max));
+}
+
+static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
+					      struct kobj_attribute *a,
+					      const char *buf, size_t len)
+{
+	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
+						   devid_kobj);
+	char *endptr;
+	unsigned long long limit;
+
+	limit = memparse(buf, &endptr);
+	WRITE_ONCE(device->scrub_speed_max, limit);
+	return len;
+}
+BTRFS_ATTR_RW(devid, scrub_speed_max, btrfs_devinfo_scrub_speed_max_show,
+	      btrfs_devinfo_scrub_speed_max_store);
+
 static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 					    struct kobj_attribute *a, char *buf)
 {
@@ -1472,6 +1499,7 @@ static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, in_fs_metadata),
 	BTRFS_ATTR_PTR(devid, missing),
 	BTRFS_ATTR_PTR(devid, replace_target),
+	BTRFS_ATTR_PTR(devid, scrub_speed_max),
 	BTRFS_ATTR_PTR(devid, writeable),
 	NULL
 };
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9c0d84e5ec06..063ce999b9d3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -143,6 +143,9 @@ struct btrfs_device {
 	struct completion kobj_unregister;
 	/* For sysfs/FSID/devinfo/devid/ */
 	struct kobject devid_kobj;
+
+	/* Bandwidth limit for scrub, in bytes */
+	u64 scrub_speed_max;
 };
 
 /*
-- 
2.29.2

