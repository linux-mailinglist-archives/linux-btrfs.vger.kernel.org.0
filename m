Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF114B389
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 10:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbfFSIDY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 04:03:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:45622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730418AbfFSIDY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 04:03:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A296AF61;
        Wed, 19 Jun 2019 08:03:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     dm-devel@redhat.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] dm log writes: Allow dm-log-writes to filter bios based on types to reduce log device space usage
Date:   Wed, 19 Jun 2019 16:03:11 +0800
Message-Id: <20190619080312.11549-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190619080312.11549-1-wqu@suse.com>
References: <20190619080312.11549-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since dm-log-writes will record all writes, include data and metadata
writes, it can consume a lot of space.
However for a lot of filesystems, the data bio (without METADATA flag)
can be skipped for certain use case, thus we can skip them in
dm-log-writes to hugely reduce space usage.

This patch will introduce a new optional constructor parameter,
"dump_type=%s", for dm-log-writes.

The '%s' can be ALL, METADATA, FUA, FLUSH, DISCARD, MARK or the ORed
result of them.
The default dump_type will be 'ALL', so the behavior is not changed at
all.

But user can specify dump_type=METADATA|FUA|FLUSH|DISCARD|MARK to skip
data writes to save space on log device.

Currently the dump_type can only be speicified at contruction time.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 drivers/md/dm-log-writes.c | 146 +++++++++++++++++++++++++++++++++++--
 1 file changed, 141 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index af94bbe77ce2..9edf0bdcae39 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -115,6 +115,7 @@ struct log_writes_c {
 	struct list_head logging_blocks;
 	wait_queue_head_t wait;
 	struct task_struct *log_kthread;
+	u32 dump_type;
 };
 
 struct pending_block {
@@ -503,15 +504,99 @@ static int log_writes_kthread(void *arg)
 	return 0;
 }
 
+#define string_type_to_bit(string)			\
+({							\
+	if (!strcasecmp(p, #string)) {			\
+		dump_type |= LOG_##string##_FLAG;	\
+		continue;				\
+	}						\
+})
+static int parse_dump_types(struct log_writes_c *lc, const char *string)
+{
+	char *orig;
+	char *opts;
+	char *p;
+	u32 dump_type = LOG_MARK_FLAG;
+	int ret = 0;
+
+	opts = kstrdup(string, GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+	orig = opts;
+
+	while ((p = strsep(&opts, "|")) != NULL) {
+		if (!*p)
+			continue;
+		if (!strcasecmp(p, "ALL")) {
+			dump_type = (u32)-1;
+			/* No need to check other flags */
+			break;
+		}
+		string_type_to_bit(METADATA);
+		string_type_to_bit(FUA);
+		string_type_to_bit(FLUSH);
+		string_type_to_bit(DISCARD);
+		string_type_to_bit(MARK);
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	kfree(orig);
+	if (!ret)
+		lc->dump_type = dump_type;
+	return ret;
+}
+#undef string_type_to_bit
+
+/* Must be large enough to contain "METADATA|FUA|FLUSH|DISCARD|MARK" */
+#define DUMP_TYPES_BUF_SIZE	256
+#define dump_type_to_string(name)				\
+({								\
+	if (lc->dump_type & LOG_##name##_FLAG) {		\
+		if (!first_word)				\
+			strcat(buf, "|");			\
+		strcat(buf, #name);				\
+		first_word = false;				\
+	}							\
+ })
+static void status_dump_types(struct log_writes_c *lc, char *buf)
+{
+	bool first_word = true;
+
+	buf[0] = '\0';
+
+	if (lc->dump_type == (u32)-1) {
+		strcat(buf, "ALL");
+		return;
+	}
+	dump_type_to_string(METADATA);
+	dump_type_to_string(FUA);
+	dump_type_to_string(FLUSH);
+	dump_type_to_string(DISCARD);
+	dump_type_to_string(MARK);
+	return;
+}
+#undef dump_type_to_string
+
 /*
  * Construct a log-writes mapping:
- * log-writes <dev_path> <log_dev_path>
+ * log-writes <dev_path> <log_dev_path> [<option feature> ...]
+ * option feature can be:
+ * - dump_type=<flags>
+ *   flags can be ALL, METADATA, FUA, FLUSH, DISCARD or any of them combined
+ *   with '|'.
+ *   Default value is ALL.
+ *
+ *   This will make log-writes only to record writes with certain type.
+ *   E.g dump_type=METADATA|FUA|FLUSH|DISCARD will only record metadata writes
+ *       and save log device space.
  */
 static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 {
 	struct log_writes_c *lc;
 	struct dm_arg_set as;
 	const char *devname, *logdevname;
+	const char *arg_name;
 	int ret;
 
 	as.argc = argc;
@@ -533,8 +618,10 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	init_waitqueue_head(&lc->wait);
 	atomic_set(&lc->io_blocks, 0);
 	atomic_set(&lc->pending_blocks, 0);
+	lc->dump_type = (u32)-1;
 
 	devname = dm_shift_arg(&as);
+	argc--;
 	ret = dm_get_device(ti, devname, dm_table_get_mode(ti->table), &lc->dev);
 	if (ret) {
 		ti->error = "Device lookup failed";
@@ -542,6 +629,7 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 
 	logdevname = dm_shift_arg(&as);
+	argc--;
 	ret = dm_get_device(ti, logdevname, dm_table_get_mode(ti->table),
 			    &lc->logdev);
 	if (ret) {
@@ -550,15 +638,35 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		goto bad;
 	}
 
+	while (argc) {
+		arg_name = dm_shift_arg(&as);
+		argc--;
+
+		if (!arg_name) {
+			ti->error = "Insufficient feature arguments";
+			goto free_all;
+		}
+		/* dump_type= */
+		if (!strncasecmp(arg_name, "dump_type=", strlen("dump_type="))) {
+			ret = parse_dump_types(lc,
+					arg_name + strlen("dump_type="));
+			if (ret < 0) {
+				ti->error = "Bad dump type";
+				goto free_all;
+			}
+			continue;
+		}
+		ti->error = "Unrecognised log-writes feature requested";
+		goto free_all;
+	}
+
 	lc->sectorsize = bdev_logical_block_size(lc->dev->bdev);
 	lc->sectorshift = ilog2(lc->sectorsize);
 	lc->log_kthread = kthread_run(log_writes_kthread, lc, "log-write");
 	if (IS_ERR(lc->log_kthread)) {
 		ret = PTR_ERR(lc->log_kthread);
 		ti->error = "Couldn't alloc kthread";
-		dm_put_device(ti, lc->dev);
-		dm_put_device(ti, lc->logdev);
-		goto bad;
+		goto free_all;
 	}
 
 	/*
@@ -579,6 +687,9 @@ static int log_writes_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->private = lc;
 	return 0;
 
+free_all:
+	dm_put_device(ti, lc->dev);
+	dm_put_device(ti, lc->logdev);
 bad:
 	kfree(lc);
 	return ret;
@@ -589,6 +700,8 @@ static int log_mark(struct log_writes_c *lc, char *data)
 	struct pending_block *block;
 	size_t maxsize = lc->sectorsize - sizeof(struct log_write_entry);
 
+	if (!(lc->dump_type & LOG_MARK_FLAG))
+		goto wake_up;
 	block = kzalloc(sizeof(struct pending_block), GFP_KERNEL);
 	if (!block) {
 		DMERR("Error allocating pending block");
@@ -607,6 +720,7 @@ static int log_mark(struct log_writes_c *lc, char *data)
 	spin_lock_irq(&lc->blocks_lock);
 	list_add_tail(&block->list, &lc->logging_blocks);
 	spin_unlock_irq(&lc->blocks_lock);
+wake_up:
 	wake_up_process(lc->log_kthread);
 	return 0;
 }
@@ -643,6 +757,22 @@ static void normal_map_bio(struct dm_target *ti, struct bio *bio)
 	bio_set_dev(bio, lc->dev->bdev);
 }
 
+static bool need_record(struct log_writes_c *lc, struct bio *bio)
+{
+	if (lc->dump_type == (u32)-1)
+		return true;
+
+	if (lc->dump_type & LOG_METADATA_FLAG && (bio->bi_opf & REQ_META))
+		return true;
+	if (lc->dump_type & LOG_FUA_FLAG && (bio->bi_opf & REQ_FUA))
+		return true;
+	if (lc->dump_type & LOG_FLUSH_FLAG && (bio->bi_opf & REQ_PREFLUSH))
+		return true;
+	if (lc->dump_type & LOG_DISCARD_FLAG && (bio_op(bio) == REQ_PREFLUSH))
+		return true;
+	return false;
+}
+
 static int log_writes_map(struct dm_target *ti, struct bio *bio)
 {
 	struct log_writes_c *lc = ti->private;
@@ -673,6 +803,9 @@ static int log_writes_map(struct dm_target *ti, struct bio *bio)
 	if (!bio_sectors(bio) && !flush_bio)
 		goto map_bio;
 
+	/* Check against lc->dump_type */
+	if (!need_record(lc, bio))
+		goto map_bio;
 	/*
 	 * Discards will have bi_size set but there's no actual data, so just
 	 * allocate the size of the pending block.
@@ -803,6 +936,7 @@ static void log_writes_status(struct dm_target *ti, status_type_t type,
 {
 	unsigned sz = 0;
 	struct log_writes_c *lc = ti->private;
+	char dump_type_buf[DUMP_TYPES_BUF_SIZE];
 
 	switch (type) {
 	case STATUSTYPE_INFO:
@@ -813,7 +947,9 @@ static void log_writes_status(struct dm_target *ti, status_type_t type,
 		break;
 
 	case STATUSTYPE_TABLE:
-		DMEMIT("%s %s", lc->dev->name, lc->logdev->name);
+		status_dump_types(lc, dump_type_buf);
+		DMEMIT("%s %s dump_type=%s", lc->dev->name, lc->logdev->name,
+			dump_type_buf);
 		break;
 	}
 }
-- 
2.22.0

