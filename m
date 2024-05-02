Return-Path: <linux-btrfs+bounces-4667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0E8B972D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 11:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD22AB22DB0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B436535B7;
	Thu,  2 May 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EaBFbc6x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EaBFbc6x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD76B52F61
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640901; cv=none; b=Sv7q/6t3nqDVEMnALqNvADfJy60T2l6EUJNTBb9q5lgu5WnbZuLiBF9g55SzibyTWP531JCTok7w3Fdd+ZSmMGom0V6wgDpDRsPysw2h1epJRBCetA0HOVFfD1b5JTaegJg+2cjc7k78ucOhiLX0ScKLEf/6GJtdxWujnE/I2gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640901; c=relaxed/simple;
	bh=aXcxRuVh8qc7ojMDnBWTXZxiq82OWEuzeRoURwPvLp0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqxiYrcuNZ68qStQeofdLm4G1L+pSiNM0g8ZF2RFZz3tsX6T2ekXDuJl1MoeQ4M+oL+kLfIY1a+0S9LHr1FCgkKzTUgzJ4DVBqAYYJj1Sh0BI+kUfyCyGdbunBbKOSs099vVcuGRLO2sF6RSQ+rmBV4ta9DofgeGndgGfmsKicI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EaBFbc6x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EaBFbc6x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BB851FBDD
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfDX6d1qf7GRGl/E9RhfxyC6+CtW9MO/FDMqvXwxmv8=;
	b=EaBFbc6xpr2Kt6yVb9ktCQ3RthIkUl9IjvNBYYj0BZvijxPPNR5vqHY/OsLsIQmf8G5a7x
	jGNElBEaw9eAZO6tN5Jdo1dIhyZVfxhdH4bOaTDZI8bY8xTIBxRMSZo9W276aHDzjbk8NF
	IVIZeFI15c5wRx754zaRdZQFJ5VMCRU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hfDX6d1qf7GRGl/E9RhfxyC6+CtW9MO/FDMqvXwxmv8=;
	b=EaBFbc6xpr2Kt6yVb9ktCQ3RthIkUl9IjvNBYYj0BZvijxPPNR5vqHY/OsLsIQmf8G5a7x
	jGNElBEaw9eAZO6tN5Jdo1dIhyZVfxhdH4bOaTDZI8bY8xTIBxRMSZo9W276aHDzjbk8NF
	IVIZeFI15c5wRx754zaRdZQFJ5VMCRU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29E341386E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WF6iMwBYM2ZZcAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 09:08:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/original: detect and repair ram_bytes mismatch
Date: Thu,  2 May 2024 18:37:54 +0930
Message-ID: <71ec5089099c57cddb6e004b8f79a476dd2874b4.1714640642.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714640642.git.wqu@suse.com>
References: <cover.1714640642.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

For non-compressed non-hole file extent items, the ram_bytes should
match disk_num_bytes.

But due to kernel bugs, we have several cases where ram_bytes is not
correctly updated.

Thankfully this is really a very minor mismatch and can never cause data
corruption since the kernel does not utilize ram_bytes for
non-compressed extents at all.

So here we just detect and repair it for original mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 126 ++++++++++++++++++++++++++++++++++++++++--
 check/mode-original.h |   8 +++
 2 files changed, 130 insertions(+), 4 deletions(-)

diff --git a/check/main.c b/check/main.c
index 93af325f2525..6c5f61fe1bb1 100644
--- a/check/main.c
+++ b/check/main.c
@@ -493,6 +493,33 @@ static int device_record_compare(const struct rb_node *node1, const struct rb_no
 		return 0;
 }
 
+static int add_mismatch_ram_bytes_record(struct inode_record *inode_rec,
+					 struct btrfs_key *key)
+{
+	struct mismatch_ram_bytes_record *record;
+
+	record = malloc(sizeof(*record));
+	if (!record) {
+		error_msg(ERROR_MSG_MEMORY, "mismatch ram bytes record");
+		return -ENOMEM;
+	}
+	memcpy(&record->key, key, sizeof(*key));
+	list_add_tail(&record->list, &inode_rec->mismatch_ram_bytes);
+	return 0;
+}
+
+static void free_mismatch_ram_bytes_records(struct inode_record *inode_rec)
+{
+	if (!list_empty(&inode_rec->mismatch_ram_bytes)) {
+		struct mismatch_ram_bytes_record *ram;
+
+		ram = list_entry(inode_rec->mismatch_ram_bytes.next,
+				 struct mismatch_ram_bytes_record, list);
+		list_del(&ram->list);
+		free(ram);
+	}
+}
+
 static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 {
 	struct inode_record *rec;
@@ -501,6 +528,7 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 	struct inode_backref *tmp;
 	struct mismatch_dir_hash_record *hash_record;
 	struct mismatch_dir_hash_record *new_record;
+	struct mismatch_ram_bytes_record *ram_record;
 	struct unaligned_extent_rec_t *src;
 	struct unaligned_extent_rec_t *dst;
 	struct rb_node *rb;
@@ -514,6 +542,7 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 	rec->refs = 1;
 	INIT_LIST_HEAD(&rec->backrefs);
 	INIT_LIST_HEAD(&rec->mismatch_dir_hash);
+	INIT_LIST_HEAD(&rec->mismatch_ram_bytes);
 	INIT_LIST_HEAD(&rec->unaligned_extent_recs);
 	rec->holes = RB_ROOT;
 
@@ -537,6 +566,11 @@ static struct inode_record *clone_inode_rec(struct inode_record *orig_rec)
 		memcpy(&new_record, hash_record, size);
 		list_add_tail(&new_record->list, &rec->mismatch_dir_hash);
 	}
+	list_for_each_entry(ram_record, &orig_rec->mismatch_ram_bytes, list) {
+		ret = add_mismatch_ram_bytes_record(rec, &ram_record->key);
+		if (ret < 0)
+			goto cleanup;
+	}
 	list_for_each_entry(src, &orig_rec->unaligned_extent_recs, list) {
 		size = sizeof(*src);
 		dst = malloc(size);
@@ -578,6 +612,7 @@ cleanup:
 			free(hash_record);
 		}
 	}
+	free_mismatch_ram_bytes_records(rec);
 	if (!list_empty(&rec->unaligned_extent_recs))
 		list_for_each_entry_safe(src, dst, &rec->unaligned_extent_recs,
 				list) {
@@ -619,6 +654,8 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", odd file extent");
 	if (errors & I_ERR_BAD_FILE_EXTENT)
 		fprintf(stderr, ", bad file extent");
+	if (errors & I_ERR_RAM_BYTES_MISMATCH)
+		fprintf(stderr, ", bad ram bytes for non-compressed extents");
 	if (errors & I_ERR_FILE_EXTENT_OVERLAP)
 		fprintf(stderr, ", file extent overlap");
 	if (errors & I_ERR_FILE_EXTENT_TOO_LARGE)
@@ -637,8 +674,6 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", link count wrong");
 	if (errors & I_ERR_ODD_INODE_FLAGS)
 		fprintf(stderr, ", odd inode flags");
-	if (errors & I_ERR_INLINE_RAM_BYTES_WRONG)
-		fprintf(stderr, ", invalid inline ram bytes");
 	if (errors & I_ERR_INVALID_IMODE)
 		fprintf(stderr, ", invalid inode mode bit 0%o",
 			rec->imode & ~07777);
@@ -699,6 +734,17 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 				hash_record->key.offset);
 		}
 	}
+	if (errors & I_ERR_RAM_BYTES_MISMATCH) {
+		struct mismatch_ram_bytes_record *ram_record;
+
+		fprintf(stderr,
+		"Non-compressed file extents with invalid ram_bytes (minor errors):\n");
+		list_for_each_entry(ram_record, &rec->mismatch_ram_bytes, list) {
+			fprintf(stderr, "\tino=%llu offset=%llu\n",
+				ram_record->key.objectid,
+				ram_record->key.offset);
+		}
+	}
 }
 
 static void print_ref_error(int errors)
@@ -760,6 +806,7 @@ static struct inode_record *get_inode_rec(struct cache_tree *inode_cache,
 		rec->refs = 1;
 		INIT_LIST_HEAD(&rec->backrefs);
 		INIT_LIST_HEAD(&rec->mismatch_dir_hash);
+		INIT_LIST_HEAD(&rec->mismatch_ram_bytes);
 		INIT_LIST_HEAD(&rec->unaligned_extent_recs);
 		rec->holes = RB_ROOT;
 
@@ -811,6 +858,14 @@ static void free_inode_rec(struct inode_record *rec)
 		list_del(&backref->list);
 		free(backref);
 	}
+	while (!list_empty(&rec->mismatch_ram_bytes)) {
+		struct mismatch_ram_bytes_record *ram;
+
+		ram = list_entry(rec->mismatch_ram_bytes.next,
+				 struct mismatch_ram_bytes_record, list);
+		list_del(&ram->list);
+		free(ram);
+	}
 	list_for_each_entry_safe(hash, next, &rec->mismatch_dir_hash, list)
 		free(hash);
 	free_unaligned_extent_recs(&rec->unaligned_extent_recs);
@@ -821,7 +876,8 @@ static void free_inode_rec(struct inode_record *rec)
 static bool can_free_inode_rec(struct inode_record *rec)
 {
 	if (!rec->errors && rec->checked && rec->found_inode_item &&
-	    rec->nlink == rec->found_link && list_empty(&rec->backrefs))
+	    rec->nlink == rec->found_link && list_empty(&rec->backrefs) &&
+	    list_empty(&rec->mismatch_ram_bytes))
 		return true;
 	return false;
 }
@@ -1742,6 +1798,14 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (compression && rec->nodatasum)
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
+		if (disk_bytenr && !compression &&
+		    btrfs_file_extent_ram_bytes(eb, fi) !=
+		    btrfs_file_extent_disk_num_bytes(eb, fi)) {
+			rec->errors |= I_ERR_RAM_BYTES_MISMATCH;
+			ret = add_mismatch_ram_bytes_record(rec, key);
+			if (ret < 0)
+				return ret;
+		}
 		if (disk_bytenr > 0)
 			rec->found_size += num_bytes;
 	} else {
@@ -3044,6 +3108,57 @@ static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
+static int repair_ram_bytes(struct btrfs_trans_handle *trans,
+			    struct btrfs_root *root,
+			    struct btrfs_path *path,
+			    struct inode_record *rec)
+{
+	struct mismatch_ram_bytes_record *record;
+	struct mismatch_ram_bytes_record *tmp;
+	int ret = 0;
+
+	btrfs_release_path(path);
+	list_for_each_entry_safe(record, tmp, &rec->mismatch_ram_bytes, list) {
+		struct btrfs_file_extent_item *fi;
+		struct extent_buffer *leaf;
+		int type;
+		int slot;
+		int search_ret;
+
+		search_ret = btrfs_search_slot(trans, root, &record->key, path, 0, 1);
+		if (search_ret > 0)
+			search_ret = -ENOENT;
+		if (search_ret < 0) {
+			ret = search_ret;
+			btrfs_release_path(path);
+			continue;
+		}
+		leaf = path->nodes[0];
+		slot = path->slots[0];
+		fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
+		type = btrfs_file_extent_type(leaf, fi);
+		if (type != BTRFS_FILE_EXTENT_REG &&
+		    type != BTRFS_FILE_EXTENT_PREALLOC) {
+			ret = -EUCLEAN;
+			btrfs_release_path(path);
+			continue;
+		}
+		if (btrfs_file_extent_disk_bytenr(path->nodes[0], fi) == 0 ||
+		    btrfs_file_extent_compression(path->nodes[0], fi)) {
+			ret = -EUCLEAN;
+			btrfs_release_path(path);
+			continue;
+		}
+		btrfs_set_file_extent_ram_bytes(leaf, fi,
+				btrfs_file_extent_disk_num_bytes(leaf, fi));
+		btrfs_mark_buffer_dirty(leaf);
+		btrfs_release_path(path);
+	}
+	if (!ret)
+		rec->errors &= ~I_ERR_RAM_BYTES_MISMATCH;
+	return ret;
+}
+
 static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 {
 	struct btrfs_trans_handle *trans;
@@ -3066,7 +3181,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 			     I_ERR_MISMATCH_DIR_HASH |
 			     I_ERR_UNALIGNED_EXTENT_REC |
 			     I_ERR_INVALID_IMODE |
-			     I_ERR_INVALID_GEN)))
+			     I_ERR_INVALID_GEN |
+			     I_ERR_RAM_BYTES_MISMATCH)))
 		return rec->errors;
 
 	/*
@@ -3106,6 +3222,8 @@ static int try_repair_inode(struct btrfs_root *root, struct inode_record *rec)
 		ret = repair_unaligned_extent_recs(trans, root, &path, rec);
 	if (!ret && rec->errors & I_ERR_INVALID_GEN)
 		ret = repair_inode_gen_original(trans, root, &path, rec);
+	if (!ret && rec->errors & I_ERR_RAM_BYTES_MISMATCH)
+		ret = repair_ram_bytes(trans, root, &path, rec);
 	btrfs_release_path(&path);
 	ret = btrfs_commit_transaction(trans, root);
 	if (ret < 0) {
diff --git a/check/mode-original.h b/check/mode-original.h
index ac8de57cc5d4..fbc6c2e5bd0f 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -189,6 +189,8 @@ struct unaligned_extent_rec_t {
 #define I_ERR_INVALID_GEN		(1U << 20)
 #define I_ERR_INVALID_NLINK		(1U << 21)
 #define I_ERR_INVALID_XATTR		(1U << 22)
+/* Ram_bytes mismatch for non-compressed data extents. */
+#define I_ERR_RAM_BYTES_MISMATCH	(1U << 23)
 
 struct inode_record {
 	struct list_head backrefs;
@@ -216,6 +218,7 @@ struct inode_record {
 	u64 extent_end;
 	struct rb_root holes;
 	struct list_head mismatch_dir_hash;
+	struct list_head mismatch_ram_bytes;
 
 	u32 refs;
 };
@@ -232,6 +235,11 @@ struct mismatch_dir_hash_record {
 	/* namebuf follows here */
 };
 
+struct mismatch_ram_bytes_record {
+	struct list_head list;
+	struct btrfs_key key;
+};
+
 struct root_backref {
 	struct list_head list;
 	unsigned int found_dir_item:1;
-- 
2.45.0


