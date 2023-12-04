Return-Path: <linux-btrfs+bounces-551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0AE802BC4
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 07:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B80B2090E
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 06:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F7ABA3B;
	Mon,  4 Dec 2023 06:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vFrxPQ9E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C48FA
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Dec 2023 22:56:54 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD90921F75
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701673012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qG/DyZBEgDWEEh5A0AUVMDUw0BtBnTTWSG0/Z0E68Tg=;
	b=vFrxPQ9EmUCrb7CVaNfINjWdZAJW23e3mt7u2mRtgJqlwY4LASEQ34p4Ad+aZWjM9Nc1A3
	vHEU4anKqJGw+8st9yztc8QsM2xvSg9H3q/LARANrFU6CiqVX0v479HNwUg6/KBwH5mKRR
	7rI93b6ra5hPSRXjuN+V1C4eu4UX6pU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B4D413588
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 06:56:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kIYtAjN4bWXABwAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 04 Dec 2023 06:56:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check: export a dedicated btrfs_check() function
Date: Mon,  4 Dec 2023 17:26:28 +1030
Message-ID: <f677c90a20b7a07114e2c0a55880a807a3a26364.1701672971.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701672971.git.wqu@suse.com>
References: <cover.1701672971.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 3.87
X-Spamd-Result: default: False [3.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_SHORT(2.97)[0.992];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

There are use cases (mostly bgt conversion) where we want to verify the
healthy of a filesystem before crossing the rubicon.

For features like block group tree conversion, even if every operation
is protected by transaction and *should* be able to revert to previous
status, if we had some critical corruption in extent tree/free space
tree, the COW mechanism can be broken and no transaction protection at
all.

Thus for those should-be safe operations, they are only safe if the
target filesystem is healthy in the first place.

This patch would export function btrfs_check(), with extra
btrfs_check_options structure to fine-tune the behaviors.

For most external callers, they would only pass with
btrfs_check_default_options, but since "btrfs check" would go through
the same function, all options are exported through btrfs_check_options
structure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c   | 987 +++++++++++++++++++++++++------------------------
 common/utils.c |  18 +
 common/utils.h |  41 ++
 3 files changed, 554 insertions(+), 492 deletions(-)

diff --git a/check/main.c b/check/main.c
index 30967fd426ca..af7156fdae7a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -87,14 +87,7 @@ int init_extent_tree = 0;
 int check_data_csum = 0;
 struct cache_tree *roots_info_cache = NULL;
 
-enum btrfs_check_mode {
-	CHECK_MODE_ORIGINAL,
-	CHECK_MODE_LOWMEM,
-	CHECK_MODE_UNKNOWN,
-	CHECK_MODE_DEFAULT = CHECK_MODE_ORIGINAL
-};
-
-static enum btrfs_check_mode check_mode = CHECK_MODE_DEFAULT;
+static enum btrfs_check_mode check_mode = BTRFS_CHECK_MODE_DEFAULT;
 
 struct device_record {
 	struct rb_node node;
@@ -266,13 +259,13 @@ static int print_status_return(void *p)
 static enum btrfs_check_mode parse_check_mode(const char *str)
 {
 	if (strcmp(str, "lowmem") == 0)
-		return CHECK_MODE_LOWMEM;
+		return BTRFS_CHECK_MODE_LOWMEM;
 	if (strcmp(str, "orig") == 0)
-		return CHECK_MODE_ORIGINAL;
+		return BTRFS_CHECK_MODE_ORIGINAL;
 	if (strcmp(str, "original") == 0)
-		return CHECK_MODE_ORIGINAL;
+		return BTRFS_CHECK_MODE_ORIGINAL;
 
-	return CHECK_MODE_UNKNOWN;
+	return BTRFS_CHECK_MODE_UNKNOWN;
 }
 
 /* Compatible function to allow reuse of old codes */
@@ -3961,7 +3954,7 @@ static int do_check_fs_roots(struct cache_tree *root_cache)
 {
 	int ret;
 
-	if (check_mode == CHECK_MODE_LOWMEM)
+	if (check_mode == BTRFS_CHECK_MODE_LOWMEM)
 		ret = check_fs_roots_lowmem();
 	else
 		ret = check_fs_roots(root_cache);
@@ -9061,7 +9054,7 @@ static int do_check_chunks_and_extents(void)
 {
 	int ret;
 
-	if (check_mode == CHECK_MODE_LOWMEM)
+	if (check_mode == BTRFS_CHECK_MODE_LOWMEM)
 		ret = check_chunks_and_extents_lowmem();
 	else
 		ret = check_chunks_and_extents();
@@ -9978,30 +9971,486 @@ static const char * const cmd_check_usage[] = {
 	NULL
 };
 
-static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
+bool btrfs_check(const char *device, const struct btrfs_check_options *options)
 {
 	struct cache_tree root_cache;
 	struct btrfs_root *root;
 	struct open_ctree_args oca = { 0 };
-	u64 bytenr = 0;
-	u64 subvolid = 0;
-	u64 tree_root_bytenr = 0;
-	u64 chunk_root_bytenr = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
+	u64 super_bytenr = 0;
+	/* If we found non-critical error and need continue checking. */
+	bool found_error = false;
 	int ret = 0;
-	int err = 0;
-	u64 num;
-	int init_csum_tree = 0;
-	int readonly = 0;
-	int clear_space_cache = 0;
-	int qgroup_report = 0;
 	int qgroups_repaired = 0;
-	int qgroup_verify_ret;
 	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE |
 			       OPEN_CTREE_ALLOW_TRANSID_MISMATCH |
 			       OPEN_CTREE_SKIP_LEAF_ITEM_CHECKS;
-	int force = 0;
 
+	if (options->use_backup_roots)
+		ctree_flags |= OPEN_CTREE_BACKUP_ROOT;
+	if (options->use_nth_super) {
+		if (options->use_nth_super >= BTRFS_SUPER_MIRROR_MAX) {
+			error(
+			"super mirror should be less than %d",
+				BTRFS_SUPER_MIRROR_MAX);
+				exit(1);
+		}
+		super_bytenr = btrfs_sb_offset(options->use_nth_super);
+		printf("using SB copy %u, bytenr %llu\n",
+				options->use_nth_super, super_bytenr);
+	}
+	if (options->repair) {
+		printf("enabling repair mode\n");
+		opt_check_repair = 1;
+		ctree_flags |= OPEN_CTREE_WRITES;
+	}
+	if (options->init_csum_tree) {
+		printf("Creating a new CRC tree\n");
+		opt_check_repair = 1;
+		ctree_flags |= OPEN_CTREE_WRITES;
+	}
+	if (options->init_extent_tree) {
+		ctree_flags |= (OPEN_CTREE_WRITES | OPEN_CTREE_NO_BLOCK_GROUPS);
+		opt_check_repair = 1;
+		init_extent_tree = 1;
+	}
+	if (options->clear_space_cache) {
+		if (options->clear_space_cache == 2)
+			ctree_flags |= OPEN_CTREE_INVALIDATE_FST;
+		ctree_flags |= OPEN_CTREE_WRITES;
+	}
+	g_task_ctx.progress_enabled = options->show_progress;
+	check_data_csum = options->check_data_csum;
+	check_mode = options->check_mode;
+
+	if (g_task_ctx.progress_enabled) {
+		g_task_ctx.tp = TASK_NOTHING;
+		g_task_ctx.info = task_init(print_status_check, print_status_return, &g_task_ctx);
+	}
+
+	/*
+	 * Make sure we didn't trigger some write operation with --readonly
+	 * specified.
+	 */
+	if (options->force_readonly && opt_check_repair) {
+		error("repair options are not compatible with --readonly");
+		exit(1);
+	}
+
+	if (opt_check_repair && !options->force) {
+		int delay = 10;
+
+		printf("WARNING:\n\n");
+		printf("\tDo not use --repair unless you are advised to do so by a developer\n");
+		printf("\tor an experienced user, and then only after having accepted that no\n");
+		printf("\tfsck can successfully repair all types of filesystem corruption. E.g.\n");
+		printf("\tsome software or hardware bugs can fatally damage a volume.\n");
+		printf("\tThe operation will start in %d seconds.\n", delay);
+		printf("\tUse Ctrl-C to stop it.\n");
+		while (delay) {
+			printf("%2d", delay--);
+			fflush(stdout);
+			sleep(1);
+		}
+		printf("\nStarting repair.\n");
+	}
+
+	/* Experimental */
+	if (opt_check_repair && check_mode == BTRFS_CHECK_MODE_LOWMEM)
+		warning("low-memory mode repair support is only partial");
+
+	printf("Opening filesystem to check...\n");
+
+	cache_tree_init(&root_cache);
+	qgroup_set_item_count_ptr(&g_task_ctx.item_count);
+
+	ret = check_mounted(device);
+	if (!options->force) {
+		if (ret < 0) {
+			errno = -ret;
+			error("could not check mount status: %m");
+			goto err_out;
+		} else if (ret) {
+			error(
+"%s is currently mounted, use --force if you really intend to check the filesystem",
+				device);
+			ret = -EBUSY;
+			goto err_out;
+		}
+	} else {
+		if (ret < 0) {
+			warning(
+"cannot check mount status of %s, the filesystem could be mounted, continuing because of --force",
+				device);
+		} else if (ret) {
+			warning(
+			"filesystem mounted, continuing because of --force");
+		}
+		/* A block device is mounted in exclusive mode by kernel */
+		ctree_flags &= ~OPEN_CTREE_EXCLUSIVE;
+	}
+
+	/* only allow partial opening under repair mode */
+	if (opt_check_repair)
+		ctree_flags |= OPEN_CTREE_PARTIAL;
+
+	oca.filename = device;
+	oca.sb_bytenr = super_bytenr;
+	oca.root_tree_bytenr = options->tree_root;
+	oca.chunk_tree_bytenr = options->chunk_root;
+	oca.flags = ctree_flags;
+	gfs_info = open_ctree_fs_info(&oca);
+	if (!gfs_info) {
+		error("cannot open file system");
+		ret = -EIO;
+		goto err_out;
+	}
+
+	root = gfs_info->fs_root;
+	uuid_unparse(gfs_info->super_copy->fsid, uuidbuf);
+
+	printf("Checking filesystem on %s\nUUID: %s\n", device, uuidbuf);
+
+	/*
+	 * Check the bare minimum before starting anything else that could rely
+	 * on it, namely the tree roots, any local consistency checks
+	 */
+	if (!extent_buffer_uptodate(gfs_info->tree_root->node) ||
+	    !extent_buffer_uptodate(gfs_info->chunk_root->node)) {
+		error("critical roots corrupted, unable to check the filesystem");
+		ret = -EIO;
+		goto close_out;
+	}
+
+	if (options->clear_space_cache) {
+		warning("--clear-space-cache option is deprecated, please use \"btrfs rescue clear-space-cache\" instead");
+		ret = do_clear_free_space_cache(gfs_info,
+				options->clear_space_cache);
+		goto close_out;
+	}
+
+	/*
+	 * repair mode will force us to commit transaction which
+	 * will make us fail to load log tree when mounting.
+	 */
+	if (opt_check_repair && btrfs_super_log_root(gfs_info->super_copy)) {
+		ret = ask_user("repair mode will force to clear out log tree, are you sure?");
+		if (!ret) {
+			ret = 1;
+			goto close_out;
+		}
+		ret = zero_log_tree(root);
+		if (ret) {
+			error("failed to zero log tree: %d", ret);
+			goto close_out;
+		}
+	}
+
+	if (options->qgroup_report) {
+		printf("Print quota groups for %s\nUUID: %s\n", device,
+		       uuidbuf);
+		ret = qgroup_verify_all(gfs_info);
+		if (ret)
+			found_error = true;
+		if (ret >= 0)
+			report_qgroups(1);
+		goto close_out;
+	}
+	if (options->subvolid) {
+		printf("Print extent state for subvolume %llu on %s\nUUID: %s\n",
+		       options->subvolid, device, uuidbuf);
+		ret = print_extent_state(gfs_info, options->subvolid);
+		goto close_out;
+	}
+
+	if (options->init_extent_tree || options->init_csum_tree) {
+		struct btrfs_trans_handle *trans;
+
+		/*
+		 * If we're rebuilding extent tree, we must keep the flag set
+		 * for the whole duration of btrfs check.  As we rely on later
+		 * extent tree check code to rebuild block group items, thus we
+		 * can no longer trust the free space for metadata.
+		 */
+		if (init_extent_tree)
+			gfs_info->rebuilding_extent_tree = 1;
+		trans = btrfs_start_transaction(gfs_info->tree_root, 0);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			errno = -ret;
+			error_msg(ERROR_MSG_START_TRANS, "%m");
+			goto close_out;
+		}
+
+		trans->reinit_extent_tree = true;
+		if (init_extent_tree) {
+			printf("Creating a new extent tree\n");
+			ret = reinit_extent_tree(trans,
+					 check_mode == BTRFS_CHECK_MODE_ORIGINAL);
+			if (ret)
+				goto close_out;
+		}
+
+		if (options->init_csum_tree) {
+			printf("Reinitialize checksum tree\n");
+			ret = reinit_global_roots(trans,
+						  BTRFS_CSUM_TREE_OBJECTID);
+			if (ret) {
+				error("checksum tree initialization failed: %d",
+						ret);
+				ret = -EIO;
+				goto close_out;
+			}
+
+			ret = fill_csum_tree(trans, init_extent_tree);
+			if (ret) {
+				error("checksum tree refilling failed: %d", ret);
+				goto close_out;
+			}
+		}
+		/*
+		 * Ok now we commit and run the normal fsck, which will add
+		 * extent entries for all of the items it finds.
+		 */
+		ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
+		if (ret)
+			goto close_out;
+	}
+
+	ret = check_global_roots_uptodate();
+	if (ret)
+		goto close_out;
+
+	if (!init_extent_tree) {
+		if (!g_task_ctx.progress_enabled) {
+			fprintf(stderr, "[1/7] checking root items\n");
+		} else {
+			g_task_ctx.tp = TASK_ROOT_ITEMS;
+			task_start(g_task_ctx.info, &g_task_ctx.start_time,
+				   &g_task_ctx.item_count);
+		}
+		ret = repair_root_items();
+		task_stop(g_task_ctx.info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to repair root items: %m");
+			found_error = true;
+			/*
+			 * For repair, if we can't repair root items, it's
+			 * fatal.  But for non-repair, it's pretty rare to hit
+			 * such v3.17 era bug, we want to continue check.
+			 */
+			if (opt_check_repair)
+				goto close_out;
+		} else {
+			if (opt_check_repair) {
+				fprintf(stderr, "Fixed %d roots.\n", ret);
+				ret = 0;
+			} else if (ret > 0) {
+				fprintf(stderr,
+				"Found %d roots with an outdated root item.\n",
+					ret);
+				fprintf(stderr,
+	"Please run a filesystem check with the option --repair to fix them.\n");
+				ret = 1;
+				found_error = true;
+			}
+		}
+	} else {
+		fprintf(stderr, "[1/7] checking root items... skipped\n");
+	}
+
+	if (!g_task_ctx.progress_enabled) {
+		fprintf(stderr, "[2/7] checking extents\n");
+	} else {
+		g_task_ctx.tp = TASK_EXTENTS;
+		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+	}
+	ret = do_check_chunks_and_extents();
+	task_stop(g_task_ctx.info);
+	if (ret) {
+		error(
+		"errors found in extent allocation tree or chunk allocation");
+		found_error = true;
+	}
+
+	/* Only re-check super size after we checked and repaired the fs */
+	if (!is_super_size_valid())
+		found_error = true;
+
+	is_free_space_tree = btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE);
+
+	if (!g_task_ctx.progress_enabled) {
+		if (is_free_space_tree)
+			fprintf(stderr, "[3/7] checking free space tree\n");
+		else
+			fprintf(stderr, "[3/7] checking free space cache\n");
+	} else {
+		g_task_ctx.tp = TASK_FREE_SPACE;
+		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+	}
+
+	ret = validate_free_space_cache(root, &g_task_ctx);
+	if (ret)
+		found_error = true;
+	task_stop(g_task_ctx.info);
+
+	/*
+	 * We used to have to have these hole extents in between our real
+	 * extents so if we don't have this flag set we need to make sure there
+	 * are no gaps in the file extents for inodes, otherwise we can just
+	 * ignore it when this happens.
+	 */
+	no_holes = btrfs_fs_incompat(gfs_info, NO_HOLES);
+	if (!g_task_ctx.progress_enabled) {
+		fprintf(stderr, "[4/7] checking fs roots\n");
+	} else {
+		g_task_ctx.tp = TASK_FS_ROOTS;
+		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+	}
+
+	ret = do_check_fs_roots(&root_cache);
+	task_stop(g_task_ctx.info);
+	if (ret) {
+		error("errors found in fs roots");
+		goto out;
+	}
+
+	if (!g_task_ctx.progress_enabled) {
+		if (check_data_csum)
+			fprintf(stderr, "[5/7] checking csums against data\n");
+		else
+			fprintf(stderr,
+		"[5/7] checking only csums items (without verifying data)\n");
+	} else {
+		g_task_ctx.tp = TASK_CSUMS;
+		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+	}
+
+	ret = check_csums();
+	task_stop(g_task_ctx.info);
+	/*
+	 * Data csum error is not fatal, and it may indicate more serious
+	 * corruption, continue checking.
+	 */
+	if (ret) {
+		error("errors found in csum tree");
+		found_error = true;
+	}
+
+	/* For low memory mode, check_fs_roots_v2 handles root refs */
+        if (check_mode != BTRFS_CHECK_MODE_LOWMEM) {
+		if (!g_task_ctx.progress_enabled) {
+			fprintf(stderr, "[6/7] checking root refs\n");
+		} else {
+			g_task_ctx.tp = TASK_ROOT_REFS;
+			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+		}
+
+		ret = check_root_refs(root, &root_cache);
+		task_stop(g_task_ctx.info);
+		if (ret) {
+			error("errors found in root refs");
+			goto out;
+		}
+	} else {
+		fprintf(stderr,
+	"[6/7] checking root refs done with fs roots in lowmem mode, skipping\n");
+	}
+
+	while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
+		struct extent_buffer *eb;
+
+		eb = list_first_entry(&gfs_info->recow_ebs,
+				      struct extent_buffer, recow);
+		list_del_init(&eb->recow);
+		ret = recow_extent_buffer(root, eb);
+		free_extent_buffer(eb);
+		if (ret) {
+			error("fails to fix transid errors");
+			found_error = true;;
+			break;
+		}
+	}
+
+	while (!list_empty(&delete_items)) {
+		struct bad_item *bad;
+
+		bad = list_first_entry(&delete_items, struct bad_item, list);
+		list_del_init(&bad->list);
+		if (opt_check_repair) {
+			ret = delete_bad_item(root, bad);
+			if (ret)
+				found_error = true;
+		}
+		free(bad);
+	}
+
+	if (gfs_info->quota_enabled) {
+		int qgroup_verify_ret;
+
+		if (!g_task_ctx.progress_enabled) {
+			fprintf(stderr, "[7/7] checking quota groups\n");
+		} else {
+			g_task_ctx.tp = TASK_QGROUPS;
+			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
+		}
+		qgroup_verify_ret = qgroup_verify_all(gfs_info);
+		task_stop(g_task_ctx.info);
+		if (qgroup_verify_ret < 0) {
+			error("failed to check quota groups");
+			goto out;
+		}
+		report_qgroups(0);
+		ret = repair_qgroups(gfs_info, &qgroups_repaired, false);
+		if (ret) {
+			error("failed to repair quota groups");
+			goto out;
+		}
+		if (qgroup_verify_ret && (!qgroups_repaired || ret))
+			found_error = true;
+		ret = 0;
+	} else {
+		fprintf(stderr,
+		"[7/7] checking quota groups skipped (not enabled on this FS)\n");
+	}
+
+	if (!list_empty(&gfs_info->recow_ebs)) {
+		error("transid errors in file system");
+		ret = 1;
+		found_error = true;
+	}
+out:
+	printf("found %llu bytes used, ", bytes_used);
+	if (found_error || ret)
+		printf("error(s) found\n");
+	else
+		printf("no error found\n");
+	printf("total csum bytes: %llu\n", total_csum_bytes);
+	printf("total tree bytes: %llu\n", total_btree_bytes);
+	printf("total fs tree bytes: %llu\n", total_fs_tree_bytes);
+	printf("total extent tree bytes: %llu\n", total_extent_tree_bytes);
+	printf("btree space waste bytes: %llu\n", btree_space_waste);
+	printf("file data blocks allocated: %llu\n referenced %llu\n",
+		data_bytes_allocated, data_bytes_referenced);
+
+	free_qgroup_counts();
+	free_root_recs_tree(&root_cache);
+close_out:
+	close_ctree(root);
+err_out:
+	if (g_task_ctx.progress_enabled)
+		task_deinit(g_task_ctx.info);
+
+	return ret || found_error;
+}
+
+static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
+{
+	struct btrfs_check_options options;
+	int ret = 0;
+
+	memcpy(&options, &btrfs_default_check_options, sizeof(options));
 	while(1) {
 		int c;
 		enum { GETOPT_VAL_REPAIR = GETOPT_VAL_FIRST, GETOPT_VAL_INIT_CSUM,
@@ -10042,86 +10491,68 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		switch(c) {
 			case 'a': /* ignored */ break;
 			case 'b':
-				ctree_flags |= OPEN_CTREE_BACKUP_ROOT;
+				options.use_backup_roots = true;
 				break;
 			case 's':
-				num = arg_strtou64(optarg);
-				if (num >= BTRFS_SUPER_MIRROR_MAX) {
-					error(
-					"super mirror should be less than %d",
-						BTRFS_SUPER_MIRROR_MAX);
-					exit(1);
-				}
-				bytenr = btrfs_sb_offset(((int)num));
-				printf("using SB copy %llu, bytenr %llu\n", num, bytenr);
+				options.use_nth_super = arg_strtou64(optarg);
 				break;
 			case 'Q':
-				qgroup_report = 1;
+				options.qgroup_report = true;
 				break;
 			case 'E':
-				subvolid = arg_strtou64(optarg);
+				options.subvolid = arg_strtou64(optarg);
 				break;
 			case 'r':
-				tree_root_bytenr = arg_strtou64(optarg);
+				options.tree_root = arg_strtou64(optarg);
 				break;
 			case GETOPT_VAL_CHUNK_TREE:
-				chunk_root_bytenr = arg_strtou64(optarg);
+				options.chunk_root = arg_strtou64(optarg);
 				break;
 			case 'p':
-				g_task_ctx.progress_enabled = true;
+				options.show_progress = true;
 				break;
 			case '?':
 			case 'h':
 				usage(cmd, 0);
 			case GETOPT_VAL_REPAIR:
-				printf("enabling repair mode\n");
-				opt_check_repair = 1;
-				ctree_flags |= OPEN_CTREE_WRITES;
+				options.repair = true;
 				break;
 			case GETOPT_VAL_READONLY:
-				readonly = 1;
+				options.force_readonly = true;
 				break;
 			case GETOPT_VAL_INIT_CSUM:
-				printf("Creating a new CRC tree\n");
-				init_csum_tree = 1;
-				opt_check_repair = 1;
-				ctree_flags |= OPEN_CTREE_WRITES;
+				options.init_csum_tree = true;
 				break;
 			case GETOPT_VAL_INIT_EXTENT:
-				init_extent_tree = 1;
-				ctree_flags |= (OPEN_CTREE_WRITES |
-						OPEN_CTREE_NO_BLOCK_GROUPS);
-				opt_check_repair = 1;
+				options.init_extent_tree = 1;
 				break;
 			case GETOPT_VAL_CHECK_CSUM:
-				check_data_csum = 1;
+				options.check_data_csum = 1;
 				break;
 			case GETOPT_VAL_MODE:
-				check_mode = parse_check_mode(optarg);
-				if (check_mode == CHECK_MODE_UNKNOWN) {
+				options.check_mode = parse_check_mode(optarg);
+				if (options.check_mode == BTRFS_CHECK_MODE_UNKNOWN) {
 					error("unknown mode: %s", optarg);
 					exit(1);
 				}
 				break;
 			case GETOPT_VAL_CLEAR_SPACE_CACHE:
 				if (strcmp(optarg, "v1") == 0) {
-					clear_space_cache = 1;
+					options.clear_space_cache = 1;
 				} else if (strcmp(optarg, "v2") == 0) {
-					clear_space_cache = 2;
-					ctree_flags |= OPEN_CTREE_INVALIDATE_FST;
+					options.clear_space_cache = 2;
 				} else {
 					error(
 		"invalid argument to --clear-space-cache, must be v1 or v2");
 					exit(1);
 				}
-				ctree_flags |= OPEN_CTREE_WRITES;
 				break;
 			case GETOPT_VAL_CLEAR_INO_CACHE:
 				error("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead");
 				exit(1);
 				break;
 			case GETOPT_VAL_FORCE:
-				force = 1;
+				options.force = 1;
 				break;
 		}
 	}
@@ -10129,435 +10560,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	if (check_argc_exact(argc - optind, 1))
 		usage(cmd, 1);
 
-	if (g_task_ctx.progress_enabled) {
-		g_task_ctx.tp = TASK_NOTHING;
-		g_task_ctx.info = task_init(print_status_check, print_status_return, &g_task_ctx);
-	}
-
-	/* This check is the only reason for --readonly to exist */
-	if (readonly && opt_check_repair) {
-		error("repair options are not compatible with --readonly");
-		exit(1);
-	}
-
-	if (opt_check_repair && !force) {
-		int delay = 10;
-
-		printf("WARNING:\n\n");
-		printf("\tDo not use --repair unless you are advised to do so by a developer\n");
-		printf("\tor an experienced user, and then only after having accepted that no\n");
-		printf("\tfsck can successfully repair all types of filesystem corruption. E.g.\n");
-		printf("\tsome software or hardware bugs can fatally damage a volume.\n");
-		printf("\tThe operation will start in %d seconds.\n", delay);
-		printf("\tUse Ctrl-C to stop it.\n");
-		while (delay) {
-			printf("%2d", delay--);
-			fflush(stdout);
-			sleep(1);
-		}
-		printf("\nStarting repair.\n");
-	}
-
-	/*
-	 * experimental and dangerous
-	 */
-	if (opt_check_repair && check_mode == CHECK_MODE_LOWMEM)
-		warning("low-memory mode repair support is only partial");
-
-	printf("Opening filesystem to check...\n");
-
-	cache_tree_init(&root_cache);
-	qgroup_set_item_count_ptr(&g_task_ctx.item_count);
-
-	ret = check_mounted(argv[optind]);
-	if (!force) {
-		if (ret < 0) {
-			errno = -ret;
-			error("could not check mount status: %m");
-			err |= !!ret;
-			goto err_out;
-		} else if (ret) {
-			error(
-"%s is currently mounted, use --force if you really intend to check the filesystem",
-				argv[optind]);
-			ret = -EBUSY;
-			err |= !!ret;
-			goto err_out;
-		}
-	} else {
-		if (ret < 0) {
-			warning(
-"cannot check mount status of %s, the filesystem could be mounted, continuing because of --force",
-				argv[optind]);
-		} else if (ret) {
-			warning(
-			"filesystem mounted, continuing because of --force");
-		}
-		/* A block device is mounted in exclusive mode by kernel */
-		ctree_flags &= ~OPEN_CTREE_EXCLUSIVE;
-	}
-
-	/* only allow partial opening under repair mode */
-	if (opt_check_repair)
-		ctree_flags |= OPEN_CTREE_PARTIAL;
-
-	oca.filename = argv[optind];
-	oca.sb_bytenr = bytenr;
-	oca.root_tree_bytenr = tree_root_bytenr;
-	oca.chunk_tree_bytenr = chunk_root_bytenr;
-	oca.flags = ctree_flags;
-	gfs_info = open_ctree_fs_info(&oca);
-	if (!gfs_info) {
-		error("cannot open file system");
-		ret = -EIO;
-		err |= !!ret;
-		goto err_out;
-	}
-
-	root = gfs_info->fs_root;
-	uuid_unparse(gfs_info->super_copy->fsid, uuidbuf);
-
-	printf("Checking filesystem on %s\nUUID: %s\n", argv[optind], uuidbuf);
-
-	/*
-	 * Check the bare minimum before starting anything else that could rely
-	 * on it, namely the tree roots, any local consistency checks
-	 */
-	if (!extent_buffer_uptodate(gfs_info->tree_root->node) ||
-	    !extent_buffer_uptodate(gfs_info->dev_root->node) ||
-	    !extent_buffer_uptodate(gfs_info->chunk_root->node)) {
-		error("critical roots corrupted, unable to check the filesystem");
-		err |= !!ret;
-		ret = -EIO;
-		goto close_out;
-	}
-
-	if (clear_space_cache) {
-		warning("--clear-space-cache option is deprecated, please use \"btrfs rescue clear-space-cache\" instead");
-		ret = do_clear_free_space_cache(gfs_info, clear_space_cache);
-		err |= !!ret;
-		goto close_out;
-	}
-
-	/*
-	 * repair mode will force us to commit transaction which
-	 * will make us fail to load log tree when mounting.
-	 */
-	if (opt_check_repair && btrfs_super_log_root(gfs_info->super_copy)) {
-		ret = ask_user("repair mode will force to clear out log tree, are you sure?");
-		if (!ret) {
-			ret = 1;
-			err |= !!ret;
-			goto close_out;
-		}
-		ret = zero_log_tree(root);
-		err |= !!ret;
-		if (ret) {
-			error("failed to zero log tree: %d", ret);
-			goto close_out;
-		}
-	}
-
-	if (qgroup_report) {
-		printf("Print quota groups for %s\nUUID: %s\n", argv[optind],
-		       uuidbuf);
-		ret = qgroup_verify_all(gfs_info);
-		err |= !!ret;
-		if (ret >= 0)
-			report_qgroups(1);
-		goto close_out;
-	}
-	if (subvolid) {
-		printf("Print extent state for subvolume %llu on %s\nUUID: %s\n",
-		       subvolid, argv[optind], uuidbuf);
-		ret = print_extent_state(gfs_info, subvolid);
-		err |= !!ret;
-		goto close_out;
-	}
-
-	if (init_extent_tree || init_csum_tree) {
-		struct btrfs_trans_handle *trans;
-
-		/*
-		 * If we're rebuilding extent tree, we must keep the flag set
-		 * for the whole duration of btrfs check.  As we rely on later
-		 * extent tree check code to rebuild block group items, thus we
-		 * can no longer trust the free space for metadata.
-		 */
-		if (init_extent_tree)
-			gfs_info->rebuilding_extent_tree = 1;
-		trans = btrfs_start_transaction(gfs_info->tree_root, 0);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			errno = -ret;
-			error_msg(ERROR_MSG_START_TRANS, "%m");
-			err |= !!ret;
-			goto close_out;
-		}
-
-		trans->reinit_extent_tree = true;
-		if (init_extent_tree) {
-			printf("Creating a new extent tree\n");
-			ret = reinit_extent_tree(trans,
-					 check_mode == CHECK_MODE_ORIGINAL);
-			err |= !!ret;
-			if (ret)
-				goto close_out;
-		}
-
-		if (init_csum_tree) {
-			printf("Reinitialize checksum tree\n");
-			ret = reinit_global_roots(trans,
-						  BTRFS_CSUM_TREE_OBJECTID);
-			if (ret) {
-				error("checksum tree initialization failed: %d",
-						ret);
-				ret = -EIO;
-				err |= !!ret;
-				goto close_out;
-			}
-
-			ret = fill_csum_tree(trans, init_extent_tree);
-			err |= !!ret;
-			if (ret) {
-				error("checksum tree refilling failed: %d", ret);
-				return -EIO;
-			}
-		}
-		/*
-		 * Ok now we commit and run the normal fsck, which will add
-		 * extent entries for all of the items it finds.
-		 */
-		ret = btrfs_commit_transaction(trans, gfs_info->tree_root);
-		err |= !!ret;
-		if (ret)
-			goto close_out;
-	}
-
-	ret = check_global_roots_uptodate();
-	if (ret) {
-		err |= !!ret;
-		goto close_out;
-	}
-
-	if (!init_extent_tree) {
-		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[1/7] checking root items\n");
-		} else {
-			g_task_ctx.tp = TASK_ROOT_ITEMS;
-			task_start(g_task_ctx.info, &g_task_ctx.start_time,
-				   &g_task_ctx.item_count);
-		}
-		ret = repair_root_items();
-		task_stop(g_task_ctx.info);
-		if (ret < 0) {
-			err = !!ret;
-			errno = -ret;
-			error("failed to repair root items: %m");
-			/*
-			 * For repair, if we can't repair root items, it's
-			 * fatal.  But for non-repair, it's pretty rare to hit
-			 * such v3.17 era bug, we want to continue check.
-			 */
-			if (opt_check_repair)
-				goto close_out;
-			err |= 1;
-		} else {
-			if (opt_check_repair) {
-				fprintf(stderr, "Fixed %d roots.\n", ret);
-				ret = 0;
-			} else if (ret > 0) {
-				fprintf(stderr,
-				"Found %d roots with an outdated root item.\n",
-					ret);
-				fprintf(stderr,
-	"Please run a filesystem check with the option --repair to fix them.\n");
-				ret = 1;
-				err |= ret;
-			}
-		}
-	} else {
-		fprintf(stderr, "[1/7] checking root items... skipped\n");
-	}
-
-	if (!g_task_ctx.progress_enabled) {
-		fprintf(stderr, "[2/7] checking extents\n");
-	} else {
-		g_task_ctx.tp = TASK_EXTENTS;
-		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-	}
-	ret = do_check_chunks_and_extents();
-	task_stop(g_task_ctx.info);
-	err |= !!ret;
-	if (ret)
-		error(
-		"errors found in extent allocation tree or chunk allocation");
-
-	/* Only re-check super size after we checked and repaired the fs */
-	err |= !is_super_size_valid();
-
-	is_free_space_tree = btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE);
-
-	if (!g_task_ctx.progress_enabled) {
-		if (is_free_space_tree)
-			fprintf(stderr, "[3/7] checking free space tree\n");
-		else
-			fprintf(stderr, "[3/7] checking free space cache\n");
-	} else {
-		g_task_ctx.tp = TASK_FREE_SPACE;
-		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-	}
-
-	ret = validate_free_space_cache(root, &g_task_ctx);
-	task_stop(g_task_ctx.info);
-	err |= !!ret;
-
-	/*
-	 * We used to have to have these hole extents in between our real
-	 * extents so if we don't have this flag set we need to make sure there
-	 * are no gaps in the file extents for inodes, otherwise we can just
-	 * ignore it when this happens.
-	 */
-	no_holes = btrfs_fs_incompat(gfs_info, NO_HOLES);
-	if (!g_task_ctx.progress_enabled) {
-		fprintf(stderr, "[4/7] checking fs roots\n");
-	} else {
-		g_task_ctx.tp = TASK_FS_ROOTS;
-		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-	}
-
-	ret = do_check_fs_roots(&root_cache);
-	task_stop(g_task_ctx.info);
-	err |= !!ret;
-	if (ret) {
-		error("errors found in fs roots");
-		goto out;
-	}
-
-	if (!g_task_ctx.progress_enabled) {
-		if (check_data_csum)
-			fprintf(stderr, "[5/7] checking csums against data\n");
-		else
-			fprintf(stderr,
-		"[5/7] checking only csums items (without verifying data)\n");
-	} else {
-		g_task_ctx.tp = TASK_CSUMS;
-		task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-	}
-
-	ret = check_csums();
-	task_stop(g_task_ctx.info);
-	/*
-	 * Data csum error is not fatal, and it may indicate more serious
-	 * corruption, continue checking.
-	 */
-	if (ret)
-		error("errors found in csum tree");
-	err |= !!ret;
-
-	/* For low memory mode, check_fs_roots_v2 handles root refs */
-        if (check_mode != CHECK_MODE_LOWMEM) {
-		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[6/7] checking root refs\n");
-		} else {
-			g_task_ctx.tp = TASK_ROOT_REFS;
-			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-		}
-
-		ret = check_root_refs(root, &root_cache);
-		task_stop(g_task_ctx.info);
-		err |= !!ret;
-		if (ret) {
-			error("errors found in root refs");
-			goto out;
-		}
-	} else {
-		fprintf(stderr,
-	"[6/7] checking root refs done with fs roots in lowmem mode, skipping\n");
-	}
-
-	while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
-		struct extent_buffer *eb;
-
-		eb = list_first_entry(&gfs_info->recow_ebs,
-				      struct extent_buffer, recow);
-		list_del_init(&eb->recow);
-		ret = recow_extent_buffer(root, eb);
-		free_extent_buffer(eb);
-		err |= !!ret;
-		if (ret) {
-			error("fails to fix transid errors");
-			break;
-		}
-	}
-
-	while (!list_empty(&delete_items)) {
-		struct bad_item *bad;
-
-		bad = list_first_entry(&delete_items, struct bad_item, list);
-		list_del_init(&bad->list);
-		if (opt_check_repair) {
-			ret = delete_bad_item(root, bad);
-			err |= !!ret;
-		}
-		free(bad);
-	}
-
-	if (gfs_info->quota_enabled) {
-		if (!g_task_ctx.progress_enabled) {
-			fprintf(stderr, "[7/7] checking quota groups\n");
-		} else {
-			g_task_ctx.tp = TASK_QGROUPS;
-			task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_task_ctx.item_count);
-		}
-		qgroup_verify_ret = qgroup_verify_all(gfs_info);
-		task_stop(g_task_ctx.info);
-		if (qgroup_verify_ret < 0) {
-			error("failed to check quota groups");
-			err |= !!qgroup_verify_ret;
-			goto out;
-		}
-		report_qgroups(0);
-		ret = repair_qgroups(gfs_info, &qgroups_repaired, false);
-		if (ret) {
-			error("failed to repair quota groups");
-			goto out;
-		}
-		if (qgroup_verify_ret && (!qgroups_repaired || ret))
-			err |= !!qgroup_verify_ret;
-		ret = 0;
-	} else {
-		fprintf(stderr,
-		"[7/7] checking quota groups skipped (not enabled on this FS)\n");
-	}
-
-	if (!list_empty(&gfs_info->recow_ebs)) {
-		error("transid errors in file system");
-		ret = 1;
-		err |= !!ret;
-	}
-out:
-	printf("found %llu bytes used, ", bytes_used);
-	if (err)
-		printf("error(s) found\n");
-	else
-		printf("no error found\n");
-	printf("total csum bytes: %llu\n", total_csum_bytes);
-	printf("total tree bytes: %llu\n", total_btree_bytes);
-	printf("total fs tree bytes: %llu\n", total_fs_tree_bytes);
-	printf("total extent tree bytes: %llu\n", total_extent_tree_bytes);
-	printf("btree space waste bytes: %llu\n", btree_space_waste);
-	printf("file data blocks allocated: %llu\n referenced %llu\n",
-		data_bytes_allocated, data_bytes_referenced);
-
-	free_qgroup_counts();
-	free_root_recs_tree(&root_cache);
-close_out:
-	close_ctree(root);
-err_out:
-	if (g_task_ctx.progress_enabled)
-		task_deinit(g_task_ctx.info);
-
-	return err;
+	ret = btrfs_check(argv[optind], &options);
+	return ret;
 }
 DEFINE_SIMPLE_COMMAND(check, "check");
diff --git a/common/utils.c b/common/utils.c
index 035f27052f24..0a00991af10c 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -58,6 +58,24 @@ struct pending_dir {
 	char name[PATH_MAX];
 };
 
+const struct btrfs_check_options btrfs_default_check_options = {
+	.check_mode = BTRFS_CHECK_MODE_DEFAULT,
+	.force_readonly = false,
+	.use_backup_roots = false,
+	.check_data_csum = false,
+	.show_progress = false,
+	.qgroup_report = false,
+	.chunk_root = 0,
+	.tree_root = 0,
+	.subvolid = 0,
+	.use_nth_super = 0,
+	.clear_space_cache = 0,
+	.repair = false,
+	.init_csum_tree = false,
+	.init_extent_tree = false,
+	.force = false,
+};
+
 void btrfs_format_csum(u16 csum_type, const u8 *data, char *output)
 {
 	int i;
diff --git a/common/utils.h b/common/utils.h
index e267814b08a8..5f93a79a38bc 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -91,8 +91,49 @@ struct btrfs_config {
 	int dry_run;
 	struct list_head params;
 };
+
+enum btrfs_check_mode {
+	BTRFS_CHECK_MODE_ORIGINAL,
+	BTRFS_CHECK_MODE_LOWMEM,
+	BTRFS_CHECK_MODE_UNKNOWN,
+	BTRFS_CHECK_MODE_DEFAULT = BTRFS_CHECK_MODE_ORIGINAL
+};
+
+/* For external tools to call "btrfs check". */
+struct btrfs_check_options {
+	enum btrfs_check_mode check_mode;
+
+	/* Whether we rejects any writes. */
+	bool force_readonly;
+	bool use_backup_roots;
+	bool check_data_csum;
+	bool show_progress;
+	bool qgroup_report;
+	u64 chunk_root;
+	u64 tree_root;
+	u64 subvolid;
+	int use_nth_super;
+
+	/*
+	 * 0 means do no clear space cache. 1 means v1 free space cache
+	 * while 2 means v2.
+	 */
+	int clear_space_cache;
+
+	/* The remaining options are all dangerous. */
+	bool repair;
+	bool init_csum_tree;
+	bool init_extent_tree;
+	bool force;
+};
+
+extern const struct btrfs_check_options btrfs_default_check_options;
+
 extern struct btrfs_config bconf;
 
+extern bool btrfs_check(const char *device,
+			const struct btrfs_check_options *options);
+
 struct config_param {
 	struct list_head list;
 	const char *key;
-- 
2.43.0


