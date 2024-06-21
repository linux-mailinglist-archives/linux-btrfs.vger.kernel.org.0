Return-Path: <linux-btrfs+bounces-5883-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E098691224E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C41F2834C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jun 2024 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB7E171E6C;
	Fri, 21 Jun 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q9F9NAl9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cnCdhzOV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129A171E66
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965350; cv=none; b=Minf8/LHvfBK45D7Lz7rsXmsLLNtR4xkpVv8MFaOOu7f8aP4dYVkHpztpHL5eRdKQ/Zn8FJdbhDL3RG+gS+9ICd9IMgtyxTiSP7KJzP4ebWIPibnPdXxuPnzTzaOLTYnHn7whSwPvdrRGkIj1bvhDE1xP1wK4vcQIOEwNaXrY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965350; c=relaxed/simple;
	bh=FSNY0u4q/bnVU1zzx6Jgu3dZsKV3g4xIGjZpV2Zq9SM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pZB3/qxaWa67uyEA8R+vv5HrFzx7SbL9pqS0MwbMzrDgtDonP1Uuz0BCkJG9H6kw71RD9lEZacRztAYSQERdJkY23Tnhe97IQ6tVIo7tKx/5/RW+h4Jyk3GM5zEyxLFnGdEE8CPlR+jKGD24/cu6/GTAQkofKkRD4G3nVrf/+aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q9F9NAl9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cnCdhzOV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE6A621AB6
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718965346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EBSyTr5rmkseJsuA5YNmZs+NC3b8RYi+FrsmzRWG7oA=;
	b=q9F9NAl9NQ6m4T//nUF9fMNn05rVNuSc2o11tmeymd2DdSrHulqeZ294Xkj/3bF54koO5J
	c9QsZ/7Li6dycMx7URRSHgJ70/cSdyIoa8VGaWf8e9JmNCQHXRtZ9MzMHx3UQARDyLWucT
	ECSXRyWSjyb3XOlzKEhYDkeZFQ+YFs4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cnCdhzOV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718965345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=EBSyTr5rmkseJsuA5YNmZs+NC3b8RYi+FrsmzRWG7oA=;
	b=cnCdhzOV4GyayGw3vzGGYU8J/sPRHRc31ZKTusk96uUlwgd09/IBqj1VJSi4WtcqtApDic
	lgSr4O18OqdksyUHwQxgnQQkhFNADQoMS9co5I4r78b+fSdIEOB+zf6gSEfSGQrhSQrklx
	Qr/s2SkKsf68cOwzRZJJ+eQ+ZR4J2NY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E4913ABD
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jKCTLmBUdWZJUgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Jun 2024 10:22:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: do not check ram_bytes for non-compressed data extents
Date: Fri, 21 Jun 2024 19:52:06 +0930
Message-ID: <4ba45162892b90a9a7e9603df9705080e5292f47.1718965319.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EE6A621AB6
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

This patch reverts the following 3 commits:
d0cc40d23aa0 ("btrfs-progs: tests: add test case for ram_bytes detection and repair")
7313573c1942 ("btrfs-progs: check: original, detect and repair ram_bytes mismatch")
97bf7a596900 ("btrfs-progs: check: lowmem, detect and repair mismatched ram_bytes")

The problem with the ram_bytes check is, kernel can handle it without
any problem, and the original objective for this is to detect such
problem as I immaturelly believe the problem is fixed.

But it turns out to be incorrect and this check is already causing
problems.

Fix it by doing a full revert for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                                  | 126 +-----------------
 check/mode-lowmem.c                           |  69 ----------
 check/mode-lowmem.h                           |   1 -
 check/mode-original.h                         |   8 --
 .../default.img.xz                            | Bin 2076 -> 0 bytes
 5 files changed, 4 insertions(+), 200 deletions(-)
 delete mode 100644 tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz

diff --git a/check/main.c b/check/main.c
index 83c721d380b0..693f77c3542d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -493,33 +493,6 @@ static int device_record_compare(const struct rb_node *node1, const struct rb_no
 		return 0;
 }
 
-static int add_mismatch_ram_bytes_record(struct inode_record *inode_rec,
-					 struct btrfs_key *key)
-{
-	struct mismatch_ram_bytes_record *record;
-
-	record = malloc(sizeof(*record));
-	if (!record) {
-		error_msg(ERROR_MSG_MEMORY, "mismatch ram bytes record");
-		return -ENOMEM;
-	}
-	memcpy(&record->key, key, sizeof(*key));
-	list_add_tail(&record->list, &inode_rec->mismatch_ram_bytes);
-	return 0;
-}
-
-static void free_mismatch_ram_bytes_records(struct inode_record *inode_rec)
-{
-	if (!list_empty(&inode_rec->mismatch_ram_bytes)) {
-		struct mismatch_ram_bytes_record *ram;
-
-		ram = list_entry(inode_rec->mismatch_ram_bytes.next,
-				 struct mismatch_ram_bytes_record, list);
-		list_del(&ram->list);
-		free(ram);
-	}
-}
-
 static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 {
 	struct inode_record *rec;
@@ -528,7 +501,6 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 	struct inode_backref *tmp;
 	struct mismatch_dir_hash_record *hash_record;
 	struct mismatch_dir_hash_record *new_record;
-	struct mismatch_ram_bytes_record *ram_record;
 	struct unaligned_extent_rec_t *src;
 	struct unaligned_extent_rec_t *dst;
 	struct rb_node *rb;
@@ -542,7 +514,6 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 	rec->refs = 1;
 	INIT_LIST_HEAD(&rec->backrefs);
 	INIT_LIST_HEAD(&rec->mismatch_dir_hash);
-	INIT_LIST_HEAD(&rec->mismatch_ram_bytes);
 	INIT_LIST_HEAD(&rec->unaligned_extent_recs);
 	rec->holes = RB_ROOT;
 
@@ -566,11 +537,6 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 		memcpy(&new_record, hash_record, size);
 		list_add_tail(&new_record->list, &rec->mismatch_dir_hash);
 	}
-	list_for_each_entry(ram_record, &orig_rec->mismatch_ram_bytes, list) {
-		ret = add_mismatch_ram_bytes_record(rec, &ram_record->key);
-		if (ret < 0)
-			goto cleanup;
-	}
 	list_for_each_entry(src, &orig_rec->unaligned_extent_recs, list) {
 		size = sizeof(*src);
 		dst = malloc(size);
@@ -612,7 +578,6 @@ cleanup:
 			free(hash_record);
 		}
 	}
-	free_mismatch_ram_bytes_records(rec);
 	if (!list_empty(&rec->unaligned_extent_recs))
 		list_for_each_entry_safe(src, dst, &rec->unaligned_extent_recs,
 				list) {
@@ -654,8 +619,6 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", odd file extent");
 	if (errors & I_ERR_BAD_FILE_EXTENT)
 		fprintf(stderr, ", bad file extent");
-	if (errors & I_ERR_RAM_BYTES_MISMATCH)
-		fprintf(stderr, ", bad ram bytes for non-compressed extents");
 	if (errors & I_ERR_FILE_EXTENT_OVERLAP)
 		fprintf(stderr, ", file extent overlap");
 	if (errors & I_ERR_FILE_EXTENT_TOO_LARGE)
@@ -674,6 +637,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", link count wrong");
 	if (errors & I_ERR_ODD_INODE_FLAGS)
 		fprintf(stderr, ", odd inode flags");
+	if (errors & I_ERR_INLINE_RAM_BYTES_WRONG)
+		fprintf(stderr, ", invalid inline ram bytes");
 	if (errors & I_ERR_INVALID_IMODE)
 		fprintf(stderr, ", invalid inode mode bit 0%o",
 			rec->imode & ~07777);
@@ -734,17 +699,6 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 				hash_record->key.offset);
 		}
 	}
-	if (errors & I_ERR_RAM_BYTES_MISMATCH) {
-		struct mismatch_ram_bytes_record *ram_record;
-
-		fprintf(stderr,
-		"Non-compressed file extents with invalid ram_bytes (minor errors):\n");
-		list_for_each_entry(ram_record, &rec->mismatch_ram_bytes, list) {
-			fprintf(stderr, "\tino=%llu offset=%llu\n",
-				ram_record->key.objectid,
-				ram_record->key.offset);
-		}
-	}
 }
 
 static void print_ref_error(int errors)
@@ -806,7 +760,6 @@ static struct inode_record *get_inode_rec(struct cache_tree *inode_cache,
 		rec->refs = 1;
 		INIT_LIST_HEAD(&rec->backrefs);
 		INIT_LIST_HEAD(&rec->mismatch_dir_hash);
-		INIT_LIST_HEAD(&rec->mismatch_ram_bytes);
 		INIT_LIST_HEAD(&rec->unaligned_extent_recs);
 		rec->holes = RB_ROOT;
 
@@ -858,14 +811,6 @@ static void free_inode_rec(struct inode_record *rec)
 		list_del(&backref->list);
 		free(backref);
 	}
-	while (!list_empty(&rec->mismatch_ram_bytes)) {
-		struct mismatch_ram_bytes_record *ram;
-
-		ram = list_entry(rec->mismatch_ram_bytes.next,
-				 struct mismatch_ram_bytes_record, list);
-		list_del(&ram->list);
-		free(ram);
-	}
 	list_for_each_entry_safe(hash, next, &rec->mismatch_dir_hash, list)
 		free(hash);
 	free_unaligned_extent_recs(&rec->unaligned_extent_recs);
@@ -876,8 +821,7 @@ static void free_inode_rec(struct inode_record *rec)
 static bool can_free_inode_rec(struct inode_record *rec)
 {
 	if (!rec->errors && rec->checked && rec->found_inode_item &&
-	    rec->nlink == rec->found_link && list_empty(&rec->backrefs) &&
-	    list_empty(&rec->mismatch_ram_bytes))
+	    rec->nlink == rec->found_link && list_empty(&rec->backrefs))
 		return true;
 	return false;
 }
@@ -1798,14 +1742,6 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (compression && rec->nodatasum)
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
-		if (disk_bytenr && !compression &&
-		    btrfs_file_extent_ram_bytes(eb, fi) !=
-		    btrfs_file_extent_disk_num_bytes(eb, fi)) {
-			rec->errors |= I_ERR_RAM_BYTES_MISMATCH;
-			ret = add_mismatch_ram_bytes_record(rec, key);
-			if (ret < 0)
-				return ret;
-		}
 		if (disk_bytenr > 0)
 			rec->found_size += num_bytes;
 	} else {
@@ -3076,57 +3012,6 @@ static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static int repair_ram_bytes(struct btrfs_trans_handle *trans,
-			    struct btrfs_root *root,
-			    struct btrfs_path *path,
-			    struct inode_record *rec)
-{
-	struct mismatch_ram_bytes_record *record;
-	struct mismatch_ram_bytes_record *tmp;
-	int ret = 0;
-
-	btrfs_release_path(path);
-	list_for_each_entry_safe(record, tmp, &rec->mismatch_ram_bytes, list) {
-		struct btrfs_file_extent_item *fi;
-		struct extent_buffer *leaf;
-		int type;
-		int slot;
-		int search_ret;
-
-		search_ret = btrfs_search_slot(trans, root, &record->key, path, 0, 1);
-		if (search_ret > 0)
-			search_ret = -ENOENT;
-		if (search_ret < 0) {
-			ret = search_ret;
-			btrfs_release_path(path);
-			continue;
-		}
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
-		type = btrfs_file_extent_type(leaf, fi);
-		if (type != BTRFS_FILE_EXTENT_REG &&
-		    type != BTRFS_FILE_EXTENT_PREALLOC) {
-			ret = -EUCLEAN;
-			btrfs_release_path(path);
-			continue;
-		}
-		if (btrfs_file_extent_disk_bytenr(path->nodes[0], fi) == 0 ||
-		    btrfs_file_extent_compression(path->nodes[0], fi)) {
-			ret = -EUCLEAN;
-			btrfs_release_path(path);
-			continue;
-		}
-		btrfs_set_file_extent_ram_bytes(leaf, fi,
-				btrfs_file_extent_disk_num_bytes(leaf, fi));
-		btrfs_mark_buffer_dirty(leaf);
-		btrfs_release_path(path);
-	}
-	if (!ret)
-		rec->errors &= ~I_ERR_RAM_BYTES_MISMATCH;
-	return ret;
-}
-
 static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 {
 	struct btrfs_trans_handle *trans;
@@ -3149,8 +3034,7 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 			     I_ERR_MISMATCH_DIR_HASH |
 			     I_ERR_UNALIGNED_EXTENT_REC |
 			     I_ERR_INVALID_IMODE |
-			     I_ERR_INVALID_GEN |
-			     I_ERR_RAM_BYTES_MISMATCH)))
+			     I_ERR_INVALID_GEN)))
 		return rec->errors;
 
 	/*
@@ -3190,8 +3074,6 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 		ret = repair_unaligned_extent_recs(trans, root, &path, rec);
 	if (!ret && rec->errors & I_ERR_INVALID_GEN)
 		ret = repair_inode_gen_original(trans, root, &path, rec);
-	if (!ret && rec->errors & I_ERR_RAM_BYTES_MISMATCH)
-		ret = repair_ram_bytes(trans, root, &path, rec);
 	btrfs_commit_transaction(trans, root);
 	btrfs_release_path(&path);
 	return ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 4e3bc3bd9950..a9908eaf629d 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2018,61 +2018,6 @@ static int check_file_extent_inline(struct btrfs_root *root,
 	return err;
 }
 
-static int repair_ram_bytes_mismatch(struct btrfs_root *root,
-				     struct btrfs_path *path)
-{
-	struct btrfs_trans_handle *trans;
-	struct btrfs_key key;
-	struct btrfs_file_extent_item *fi;
-	u64 disk_num_bytes;
-	int recover_ret;
-	int ret;
-
-	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
-	btrfs_release_path(path);
-	UASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
-
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		return ret;
-	}
-
-	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
-	/* Not really possible. */
-	if (ret > 0) {
-		ret = -ENOENT;
-		btrfs_release_path(path);
-		goto recover;
-	}
-
-	if (ret < 0)
-		goto recover;
-
-	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
-			    struct btrfs_file_extent_item);
-	disk_num_bytes = btrfs_file_extent_disk_num_bytes(path->nodes[0], fi);
-	btrfs_set_file_extent_ram_bytes(path->nodes[0], fi, disk_num_bytes);
-	btrfs_mark_buffer_dirty(path->nodes[0]);
-
-	ret = btrfs_commit_transaction(trans, root);
-	if (ret < 0) {
-		errno = -ret;
-		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
-	} else {
-		printf(
-	"Successfully repaired ram_bytes for non-compressed extent at root %llu ino %llu file_pos %llu\n",
-			root->objectid, key.objectid, key.offset);
-	}
-	return ret;
-recover:
-	recover_ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	UASSERT(recover_ret == 0);
-	return ret;
-}
-
 /*
  * Check file extent datasum/hole, update the size of the file extents,
  * check and update the last offset of the file extent.
@@ -2098,7 +2043,6 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	u64 csum_found;		/* In byte size, sectorsize aligned */
 	u64 search_start;	/* Logical range start we search for csum */
 	u64 search_len;		/* Logical range len we search for csum */
-	u64 ram_bytes;
 	u64 gen;
 	u64 super_gen;
 	unsigned int extent_type;
@@ -2133,7 +2077,6 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	extent_num_bytes = btrfs_file_extent_num_bytes(node, fi);
 	extent_offset = btrfs_file_extent_offset(node, fi);
 	compressed = btrfs_file_extent_compression(node, fi);
-	ram_bytes = btrfs_file_extent_ram_bytes(node, fi);
 	is_hole = (disk_bytenr == 0) && (disk_num_bytes == 0);
 	super_gen = btrfs_super_generation(gfs_info->super_copy);
 
@@ -2144,18 +2087,6 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		err |= INVALID_GENERATION;
 	}
 
-	if (!compressed && disk_bytenr && disk_num_bytes != ram_bytes) {
-		error(
-		"minor ram_bytes mismatch for non-compressed data extents, have %llu expect %llu",
-		      ram_bytes, disk_num_bytes);
-		if (opt_check_repair) {
-			ret = repair_ram_bytes_mismatch(root, path);
-			if (ret < 0)
-				err |= RAM_BYTES_MISMATCH;
-		} else {
-			err |= RAM_BYTES_MISMATCH;
-		}
-	}
 	/*
 	 * Check EXTENT_DATA csum
 	 *
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index b3e212165519..b45e6bc137f3 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -47,7 +47,6 @@
 #define INODE_MODE_ERROR	(1U << 25)	/* Bad inode mode */
 #define INVALID_GENERATION	(1U << 26)	/* Generation is too new */
 #define SUPER_BYTES_USED_ERROR	(1U << 27)	/* Super bytes_used is invalid */
-#define RAM_BYTES_MISMATCH	(1U << 27)	/* Non-compressed extent has wrong ram_bytes */
 
 /*
  * Error bit for low memory mode check.
diff --git a/check/mode-original.h b/check/mode-original.h
index fbc6c2e5bd0f..ac8de57cc5d4 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -189,8 +189,6 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INVALID_GEN		(1U << 20)
 #define I_ERR_INVALID_NLINK		(1U << 21)
 #define I_ERR_INVALID_XATTR		(1U << 22)
-/* Ram_bytes mismatch for non-compressed data extents. */
-#define I_ERR_RAM_BYTES_MISMATCH	(1U << 23)
 
 struct inode_record {
 	struct list_head backrefs;
@@ -218,7 +216,6 @@ struct inode_record {
 	u64 extent_end;
 	struct rb_root holes;
 	struct list_head mismatch_dir_hash;
-	struct list_head mismatch_ram_bytes;
 
 	u32 refs;
 };
@@ -235,11 +232,6 @@ struct mismatch_dir_hash_record {
 	/* namebuf follows here */
 };
 
-struct mismatch_ram_bytes_record {
-	struct list_head list;
-	struct btrfs_key key;
-};
-
 struct root_backref {
 	struct list_head list;
 	unsigned int found_dir_item:1;
diff --git a/tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz b/tests/fsck-tests/062-noncompressed-ram-bytes-mismatch/default.img.xz
deleted file mode 100644
index 94a587a83e64a9d1981d8b74e313b4ff7e497c68..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 2076
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
G1X)@Hrty6M

-- 
2.45.2


