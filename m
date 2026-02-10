Return-Path: <linux-btrfs+bounces-21603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJA2E3wdi2nSPwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21603-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:58:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA311A7CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 12:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EEC483012969
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 11:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC332861D;
	Tue, 10 Feb 2026 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEYWGQqq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E232860B
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724676; cv=none; b=bfmHi5F48IVKoheJKTSG7PbOVjyHtOLgXrvV640sQBkojI6W7S99Xo9r7nlySIs4IN1Wf4SdhLvYALzD/W20mhbqd4o7U/Z/r53tdkodUoa/su5Ga5jFQnyIDqi7p08EGCggXM59bniMbqUrEmqhf+DqiDbxrgBWCCuAjd17Skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724676; c=relaxed/simple;
	bh=Yste1+vWO4Z/3NFDYhMe0C+5ajqO7BkgmsY4coGGraA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABx0wan6GjIcXJILa9/NKr37477hEwWQqynfghLEU2aDc7V13mykS7LHURhN2UjZGA/qRMmWMG4/xYceR9hgoQn0wCrRLnYZ9QqcB0VeVXy/2gPYqDyFJyxIOXJWkWD/fUIPoBZiJ9GDg/lxFXrZ/jUUtwSa9Pccia4x4vEqiXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEYWGQqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1075C116C6
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Feb 2026 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770724676;
	bh=Yste1+vWO4Z/3NFDYhMe0C+5ajqO7BkgmsY4coGGraA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dEYWGQqq0U9APDIXR1RXvDbuXkPld3jK3VX9/BSefOUBL/ezkGfj8jSffsDcBjByl
	 U47881DRGBBiyR4dM3XyuK2x/2TJEPjfZrlgUSYTYk66ge40xZ5anEOWNIDBSUxVq4
	 pWGM/HxaOK8uiF6O9cnEKo+Ld7Tz7RhOGfOJVfnD8HLRM4i0yW+W5N13YOkatjJPng
	 UHVUTc3q0tT6vO+Z5/RICKxytTWSF41vWdG643DmjHlQB5PaY41Ud3EPV+pvhDzsfF
	 Fo/RadfRaUSIswsKp8zz4m+vtsF/x1xBLRgpBVGa/sMTrOxl6oB4D9rcBEyF6jn3Lz
	 TJBZUqhyY5Nrg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: check for NULL root after calls to btrfs_csum_root()
Date: Tue, 10 Feb 2026 11:57:50 +0000
Message-ID: <54f2a569d1dda9eeb17b4839f6055631e13fab22.1770724034.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770724034.git.fdmanana@suse.com>
References: <cover.1770724034.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21603-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:mid,suse.com:email,meta.com:email]
X-Rspamd-Queue-Id: B2FA311A7CE
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

btrfs_csum_root() can return a NULL pointer in case the root we are
looking for is not in the rb tree that tracks roots. So add checks to
every caller that is missing such check to log a message and return
an error.

Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@meta.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c     |  4 ++++
 fs/btrfs/extent-tree.c | 20 ++++++++++++++++++--
 fs/btrfs/file-item.c   |  7 +++++++
 fs/btrfs/inode.c       | 18 ++++++++++++++++--
 fs/btrfs/raid56.c      | 12 ++++++++++--
 fs/btrfs/relocation.c  |  8 ++++++++
 fs/btrfs/tree-log.c    | 21 +++++++++++++++++++++
 7 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4b1e67f176a3..99ce7c1ca53a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1626,6 +1626,10 @@ static int backup_super_roots(struct btrfs_fs_info *info)
 			btrfs_err(info, "missing extent root for extent at bytenr 0");
 			return -EUCLEAN;
 		}
+		if (unlikely(!csum_root)) {
+			btrfs_err(info, "missing csum root for extent at bytenr 0");
+			return -EUCLEAN;
+		}
 
 		btrfs_set_backup_extent_root(root_backup,
 					     extent_root->node->start);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 331263c206af..d1bfbad5adc6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1974,8 +1974,15 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 			struct btrfs_root *csum_root;
 
 			csum_root = btrfs_csum_root(fs_info, head->bytenr);
-			ret = btrfs_del_csums(trans, csum_root, head->bytenr,
-					      head->num_bytes);
+			if (unlikely(!csum_root)) {
+				btrfs_err(fs_info,
+					  "missing csum root for extent at bytenr %llu",
+					  head->bytenr);
+				ret = -EUCLEAN;
+			} else {
+				ret = btrfs_del_csums(trans, csum_root, head->bytenr,
+						      head->num_bytes);
+			}
 		}
 	}
 
@@ -3147,6 +3154,15 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 		struct btrfs_root *csum_root;
 
 		csum_root = btrfs_csum_root(trans->fs_info, bytenr);
+		if (unlikely(!csum_root)) {
+			ret = -EUCLEAN;
+			btrfs_abort_transaction(trans, ret);
+			btrfs_err(trans->fs_info,
+				  "missing csum root for extent at bytenr %llu",
+				  bytenr);
+			return ret;
+		}
+
 		ret = btrfs_del_csums(trans, csum_root, bytenr, num_bytes);
 		if (unlikely(ret)) {
 			btrfs_abort_transaction(trans, ret);
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7bd715442f3e..f585ddfa8440 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -308,6 +308,13 @@ static int search_csum_tree(struct btrfs_fs_info *fs_info,
 	/* Current item doesn't contain the desired range, search again */
 	btrfs_release_path(path);
 	csum_root = btrfs_csum_root(fs_info, disk_bytenr);
+	if (unlikely(!csum_root)) {
+		btrfs_err(fs_info,
+			  "missing csum root for extent at bytenr %llu",
+			  disk_bytenr);
+		return -EUCLEAN;
+	}
+
 	item = btrfs_lookup_csum(NULL, csum_root, path, disk_bytenr, 0);
 	if (IS_ERR(item)) {
 		ret = PTR_ERR(item);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 826809977df5..1cbaaf7a7230 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2013,6 +2013,13 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 */
 
 	csum_root = btrfs_csum_root(root->fs_info, io_start);
+	if (unlikely(!csum_root)) {
+		btrfs_err(root->fs_info,
+			  "missing csum root for extent at bytenr %llu", io_start);
+		ret = -EUCLEAN;
+		goto out;
+	}
+
 	ret = btrfs_lookup_csums_list(csum_root, io_start,
 				      io_start + args->file_extent.num_bytes - 1,
 				      NULL, nowait);
@@ -2750,10 +2757,17 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
 	int ret;
 
 	list_for_each_entry(sum, list, list) {
-		trans->adding_csums = true;
-		if (!csum_root)
+		if (!csum_root) {
 			csum_root = btrfs_csum_root(trans->fs_info,
 						    sum->logical);
+			if (unlikely(!csum_root)) {
+				btrfs_err(trans->fs_info,
+				  "missing csum root for extent at bytenr %llu",
+					  sum->logical);
+				return -EUCLEAN;
+			}
+		}
+		trans->adding_csums = true;
 		ret = btrfs_csum_file_blocks(trans, csum_root, sum);
 		trans->adding_csums = false;
 		if (ret)
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index baadaaa189c0..230dd93dad6e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2295,8 +2295,7 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 static void fill_data_csums(struct btrfs_raid_bio *rbio)
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info,
-						       rbio->bioc->full_stripe_logical);
+	struct btrfs_root *csum_root;
 	const u64 start = rbio->bioc->full_stripe_logical;
 	const u32 len = (rbio->nr_data * rbio->stripe_nsectors) <<
 			fs_info->sectorsize_bits;
@@ -2329,6 +2328,15 @@ static void fill_data_csums(struct btrfs_raid_bio *rbio)
 		goto error;
 	}
 
+	csum_root = btrfs_csum_root(fs_info, rbio->bioc->full_stripe_logical);
+	if (unlikely(!csum_root)) {
+		btrfs_err(fs_info,
+			  "missing csum root for extent at bytenr %llu",
+			  rbio->bioc->full_stripe_logical);
+		ret = -EUCLEAN;
+		goto error;
+	}
+
 	ret = btrfs_lookup_csums_bitmap(csum_root, NULL, start, start + len - 1,
 					rbio->csum_buf, rbio->csum_bitmap);
 	if (ret < 0)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3906e457d2ef..8a8a66112d42 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -5641,6 +5641,14 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 	LIST_HEAD(list);
 	int ret;
 
+	if (unlikely(!csum_root)) {
+		btrfs_mark_ordered_extent_error(ordered);
+		btrfs_err(fs_info,
+			  "missing csum root for extent at bytenr %llu",
+			  disk_bytenr);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 				      disk_bytenr + ordered->num_bytes - 1,
 				      &list, false);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e2806ca410f6..e9655095ba4c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -984,6 +984,13 @@ static noinline int replay_one_extent(struct walk_control *wc)
 
 		sums = list_first_entry(&ordered_sums, struct btrfs_ordered_sum, list);
 		csum_root = btrfs_csum_root(fs_info, sums->logical);
+		if (unlikely(!csum_root)) {
+			btrfs_err(fs_info,
+				  "missing csum root for extent at bytenr %llu",
+				  sums->logical);
+			ret = -EUCLEAN;
+		}
+
 		if (!ret) {
 			ret = btrfs_del_csums(trans, csum_root, sums->logical,
 					      sums->len);
@@ -4890,6 +4897,13 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		}
 
 		csum_root = btrfs_csum_root(trans->fs_info, disk_bytenr);
+		if (unlikely(!csum_root)) {
+			btrfs_err(trans->fs_info,
+				  "missing csum root for extent at bytenr %llu",
+				  disk_bytenr);
+			return -EUCLEAN;
+		}
+
 		disk_bytenr += extent_offset;
 		ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 					      disk_bytenr + extent_num_bytes - 1,
@@ -5086,6 +5100,13 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* block start is already adjusted for the file extent offset. */
 	block_start = btrfs_extent_map_block_start(em);
 	csum_root = btrfs_csum_root(trans->fs_info, block_start);
+	if (unlikely(!csum_root)) {
+		btrfs_err(trans->fs_info,
+			  "missing csum root for extent at bytenr %llu",
+			  block_start);
+		return -EUCLEAN;
+	}
+
 	ret = btrfs_lookup_csums_list(csum_root, block_start + csum_offset,
 				      block_start + csum_offset + csum_len - 1,
 				      &ordered_sums, false);
-- 
2.47.2


