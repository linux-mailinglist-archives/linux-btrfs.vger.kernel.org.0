Return-Path: <linux-btrfs+bounces-5572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1A5900FAC
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 07:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2059D28369F
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7146D17625E;
	Sat,  8 Jun 2024 05:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HyJJO/WV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HyJJO/WV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41D610C
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 05:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717824131; cv=none; b=dHFuXIcesomfn0C6e0UaTA7yTdCu59SrHH/1wYR1HAbyMSWXWa+fwSNu0iPVXMkPPS9ZRRJOQ0U5xx33iS3ip1kKgucu0mXBXgBAMvZoetaHQf1ZRa1+LLKv7stw9jaaX7lviubRe4639rN/f8fk6+zE0eRclreuZbOIp2pVRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717824131; c=relaxed/simple;
	bh=ER3sFVQNI3yX97yd5smaT45UsaR2YkHSrDWWi6Og2xk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XIC/AK11UMUoBz8tePg/YMcCACd1YvKGRKpZmpFs8FuDv80/etOomvOZGQwJkB+Q7tStSHpzOvkCoPTcqU9FAicJZKQe1d77HLFecyHrYrqpN+5um6Yd6HGCFWXsAq6gMwrMaQZAYdCgjRQ/Yw7cXdw7pE1Xw/CZ2Woap9CrfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HyJJO/WV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HyJJO/WV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 216B01FC9E
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717824127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WDpZ7cIIZ3WWs7hW4UZ7upwG3KserHMJh5+kLczrqak=;
	b=HyJJO/WVq8GMoGdn/FCC7XVCD1M0Ion6+EPzFysfiBkscJRzMg0V0W2IicSdfA4Y9Sm9uQ
	gjcs5M1wDD4wuv0cnaZh729XBIT4aLWSn/Mr2f7lGKY7HzGndinP2zG6o+8Lv+7q+1aojT
	m22rCV/804XSzqzvmgmTRCxs1ceIB5s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717824127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=WDpZ7cIIZ3WWs7hW4UZ7upwG3KserHMJh5+kLczrqak=;
	b=HyJJO/WVq8GMoGdn/FCC7XVCD1M0Ion6+EPzFysfiBkscJRzMg0V0W2IicSdfA4Y9Sm9uQ
	gjcs5M1wDD4wuv0cnaZh729XBIT4aLWSn/Mr2f7lGKY7HzGndinP2zG6o+8Lv+7q+1aojT
	m22rCV/804XSzqzvmgmTRCxs1ceIB5s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31E071398F
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 05:22:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s2d3NH3qY2b3AQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 08 Jun 2024 05:22:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tune: introduce progress support for csum change
Date: Sat,  8 Jun 2024 14:51:47 +0930
Message-ID: <472afce90c729d1935df5c164a0147ceb355b4e9.1717824105.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[]

Considering how slow the csum conversion is, it's much better to output
the progress of the conversion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 111 +++++++++++++++++++++++++++++++++++++++++++--
 tune/main.c        |  10 +++-
 tune/tune.h        |   3 +-
 3 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index f5fc3c7f32cb..2f9415a66a3d 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -33,10 +33,74 @@
 #include "kernel-shared/tree-checker.h"
 #include "common/messages.h"
 #include "common/utils.h"
+#include "common/task-utils.h"
 #include "common/inject-error.h"
 #include "common/extent-tree-utils.h"
 #include "tune/tune.h"
 
+struct csum_task {
+	struct task_info *info;
+	time_t start_time;
+	char *stage;
+	u64 cur;
+	u64 last;
+	bool enabled;
+};
+
+struct csum_task g_task = { 0 };
+
+static void print_one_line(struct csum_task *task)
+{
+	time_t elapsed;
+	int hours;
+	int minutes;
+	int seconds;
+	bool print_last = (task->last != 0);
+
+	if (!task->stage)
+		return;
+
+	elapsed = time(NULL) - task->start_time;
+	hours   = elapsed  / 3600;
+	elapsed -= hours   * 3600;
+	minutes = elapsed  / 60;
+	elapsed -= minutes * 60;
+	seconds = elapsed;
+
+	if (print_last)
+		printf("%s %llu/%llu (%d:%02d:%02d elapsed)\r",
+		       task->stage, task->cur, task->last, hours, minutes,
+		       seconds);
+	else
+		printf("%s %llu (%d:%02d:%02d elapsed)\r",
+		       task->stage, task->cur, hours, minutes, seconds);
+
+	fflush(stdout);
+}
+
+static void *print_convert_progress(void *p)
+{
+	struct csum_task *task = p;
+
+	/* 1 second. */
+	task_period_start(task->info, 1000);
+	while (true) {
+		print_one_line(task);
+		task_period_wait(task->info);
+	}
+	return NULL;
+}
+
+static int print_convert_finish(void *p)
+{
+	struct csum_task *task = p;
+
+	print_one_line(task);
+	printf("\n");
+	fflush(stdout);
+	return 0;
+}
+
 static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
@@ -248,6 +312,10 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 	if (!csum_buffer)
 		return -ENOMEM;
 
+	g_task.stage = "generating new data csum";
+	g_task.cur = start;
+	g_task.last = last_csum;
+
 	trans = btrfs_start_transaction(csum_root,
 			CSUM_CHANGE_BYTES_THRESHOLD / fs_info->sectorsize *
 			new_csum_size);
@@ -258,6 +326,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 		return ret;
 	}
 
+	task_start(g_task.info, &g_task.start_time, NULL);
 	while (cur < last_csum) {
 		u64 csum_start;
 		u64 len;
@@ -266,6 +335,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 		key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 		key.type = BTRFS_EXTENT_CSUM_KEY;
 		key.offset = cur;
+		g_task.cur = start;
 
 		ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
 		if (ret < 0)
@@ -288,6 +358,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 		item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
 
 		csum_start = key.offset;
+		g_task.cur = key.offset;
 		len = item_size / fs_info->csum_size * fs_info->sectorsize;
 		read_extent_buffer(path.nodes[0], csum_buffer,
 				btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
@@ -318,8 +389,9 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 	}
 	ret = btrfs_commit_transaction(trans, csum_root);
 	if (inject_error(0x4de02239))
-		return -EUCLEAN;
+		ret = -EUCLEAN;
 out:
+	task_stop(g_task.info);
 	free(csum_buffer);
 	return ret;
 }
@@ -376,6 +448,10 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 	last_key.type = BTRFS_EXTENT_CSUM_KEY;
 	last_key.offset = (u64)-1;
 
+	g_task.stage = "deleting old data csum";
+	g_task.cur = 0;
+	g_task.last = 0;
+
 	trans = btrfs_start_transaction(csum_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -383,6 +459,7 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 		error("failed to start transaction to delete old data csums: %m");
 		return ret;
 	}
+	task_start(g_task.info, &g_task.start_time, NULL);
 	while (true) {
 		int start_slot;
 		int nr;
@@ -400,6 +477,7 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 			/* Break from the for loop, we found the first old csum. */
 			if (found_key.objectid == BTRFS_EXTENT_CSUM_OBJECTID)
 				break;
+			g_task.cur = found_key.offset;
 		}
 		/* No more old csum item detected, exit. */
 		if (start_slot == nr)
@@ -415,6 +493,7 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 		}
 		btrfs_release_path(&path);
 	}
+	task_stop(g_task.info);
 	btrfs_release_path(&path);
 	if (ret < 0)
 		btrfs_abort_transaction(trans, ret);
@@ -441,6 +520,10 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 	last_key.type = BTRFS_EXTENT_CSUM_KEY;
 	last_key.offset = (u64)-1;
 
+	g_task.stage = "renaming data csum objectids";
+	g_task.cur = 0;
+	g_task.last = 0;
+
 	trans = btrfs_start_transaction(csum_root, 1);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
@@ -448,6 +531,7 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 		error("failed to start transaction to change csum objectids: %m");
 		return ret;
 	}
+	task_start(g_task.info, &g_task.start_time, NULL);
 	while (true) {
 		struct btrfs_key found_key;
 		int nr;
@@ -468,6 +552,7 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 		/* All csum items should be new csums. */
 		btrfs_item_key_to_cpu(path.nodes[0], &found_key, 0);
 		assert(found_key.objectid == BTRFS_CSUM_CHANGE_OBJECTID);
+		g_task.cur = found_key.offset;
 
 		/*
 		 * Start changing the objectids, since EXTENT_CSUM (-10) is
@@ -482,6 +567,7 @@ static int change_csum_objectids(struct btrfs_fs_info *fs_info)
 		btrfs_release_path(&path);
 	}
 out:
+	task_stop(g_task.info);
 	btrfs_release_path(&path);
 	if (ret < 0) {
 		btrfs_abort_transaction(trans, ret);
@@ -578,6 +664,10 @@ static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		error("failed to update super flags: %m");
 	}
 
+	g_task.stage = "rewriting metadata csum";
+	g_task.cur = 0;
+	g_task.last = 0;
+
 	/*
 	 * Disable metadata csum checks first, as we may hit tree blocks with
 	 * either old or new csums.
@@ -596,6 +686,7 @@ static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		return ret;
 	}
 	assert(ret > 0);
+	task_start(g_task.info, &g_task.start_time, NULL);
 	while (true) {
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
@@ -610,6 +701,8 @@ static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 			    BTRFS_EXTENT_FLAG_DATA)
 				goto next;
 		}
+		g_task.cur = key.objectid;
+
 		ret = rewrite_tree_block_csum(fs_info, key.objectid, new_csum_type);
 		if (ret < 0) {
 			errno = -ret;
@@ -629,6 +722,7 @@ next:
 		}
 	}
 out:
+	task_stop(g_task.info);
 	btrfs_release_path(&path);
 
 	/*
@@ -1028,7 +1122,8 @@ static int resume_csum_change(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	return ret;
 }
 
-int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
+int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type,
+			   bool show_progress)
 {
 	u16 old_csum_type = fs_info->csum_type;
 	int ret;
@@ -1038,6 +1133,11 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	if (ret < 0)
 		return ret;
 
+	g_task.enabled = show_progress;
+	if (show_progress)
+		g_task.info = task_init(print_convert_progress,
+					print_convert_finish, &g_task);
+
 	if (btrfs_super_flags(fs_info->super_copy) &
 	    (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
 	     BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) {
@@ -1045,12 +1145,12 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		if (ret < 0) {
 			errno = -ret;
 			error("failed to resume unfinished csum change: %m");
-			return ret;
+			goto out;
 		}
 		printf("converted csum type from %s (%u) to %s (%u)\n",
 		       btrfs_super_csum_name(old_csum_type), old_csum_type,
 		       btrfs_super_csum_name(new_csum_type), new_csum_type);
-		return ret;
+		goto out;
 	}
 	/*
 	 * Phase 1, generate new data csums.
@@ -1088,5 +1188,8 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		printf("converted csum type from %s (%u) to %s (%u)\n",
 		       btrfs_super_csum_name(old_csum_type), old_csum_type,
 		       btrfs_super_csum_name(new_csum_type), new_csum_type);
+out:
+	if (show_progress)
+		task_deinit(g_task.info);
 	return ret;
 }
diff --git a/tune/main.c b/tune/main.c
index bec896907119..6fe8baf749f3 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -127,6 +127,7 @@ static const char * const tune_usage[] = {
 	"",
 	"EXPERIMENTAL FEATURES:",
 	OPTLINE("--csum CSUM", "switch checksum for data and metadata to CSUM"),
+	OPTLINE("--progress", "show progress for csum conversion" ),
 #endif
 	NULL
 };
@@ -193,6 +194,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_extent_tree = false;
 	bool to_bg_tree = false;
 	bool to_fst = false;
+	bool show_progress = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
 	int ret;
@@ -209,7 +211,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
 		       GETOPT_VAL_ENABLE_SIMPLE_QUOTA,
-
+		       GETOPT_VAL_PROGRESS,
 		};
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
@@ -223,6 +225,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 				GETOPT_VAL_ENABLE_SIMPLE_QUOTA },
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
+			{ "progress", no_argument, NULL, GETOPT_VAL_PROGRESS},
 #endif
 			{ NULL, 0, NULL, 0 }
 		};
@@ -296,6 +299,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 			csum_type = parse_csum_type(optarg);
 			btrfstune_cmd_groups[CSUM_CHANGE] = true;
 			break;
+		case GETOPT_VAL_PROGRESS:
+			show_progress = true;
+			break;
 #endif
 		case GETOPT_VAL_HELP:
 		default:
@@ -484,7 +490,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 
 	if (csum_type != -1) {
 		pr_verbose(LOG_DEFAULT, "Proceed to switch checksums\n");
-		ret = btrfs_change_csum_type(fs_info, csum_type);
+		ret = btrfs_change_csum_type(fs_info, csum_type, show_progress);
 		goto out;
 	}
 
diff --git a/tune/tune.h b/tune/tune.h
index 397cfe4f344b..4f384983882e 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -30,7 +30,8 @@ int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string);
 int convert_to_bg_tree(struct btrfs_fs_info *fs_info);
 int convert_to_extent_tree(struct btrfs_fs_info *fs_info);
 
-int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type);
+int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type,
+			   bool show_progress);
 
 int enable_quota(struct btrfs_fs_info *fs_info, bool simple);
 
-- 
2.45.2


