Return-Path: <linux-btrfs+bounces-21503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PonKY/riGkiywQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21503-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:01:19 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30010A111
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4B38301B70E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7706132ED25;
	Sun,  8 Feb 2026 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNr5kM4E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ECA32E73E
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770580845; cv=none; b=Nm4gS3wIiSogUt4UfOdaErkNe9qfv1+z9BrFnrfMUvvu78bmzIdz7hGh6DgZDESwfnEcD2tQhLAVEayB0PY5k4cn9CAVoA/4b6enUIq5KlIgegfhkDNr2EOXuz73tkSPNlLAGeQe/VfETsAZWWLtL1hlgWw1r/8lKbMdp7aXrO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770580845; c=relaxed/simple;
	bh=dlCeddVS+AebkGEPuFQmELNFASLpj2+IxXpUHvOLLiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrOKBKqQWMDvmjXaNCgQbRYRqM9eplWSflNMldKgBb07PbgiaJqAwGnTagqqCOgGbcyHC4G7QzncmyfEvLMFvxTNMUxIzo2IlZYIapyvKISPRA80KB/QIcSu3tHiatZP28HRNRX1lQhR9vX7S30e8Cvb1n7Vsz4Oz7hnLaqev5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNr5kM4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ABBC4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770580845;
	bh=dlCeddVS+AebkGEPuFQmELNFASLpj2+IxXpUHvOLLiE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XNr5kM4E45DFvh9MUdzGmYngrc89Pq0fmnxDeOjKOR2/68GnY4OcH6/WLSvav3L9Z
	 LFc2n0cXBmZdrFU/emP4UOBun6LBBP92lhJySCG5b2nRCKHqIOD7GlIHXd34uc+D1J
	 wCQRuaAz8iyfvZZWWsfxf5mZdEeQyIwpyZBZe8oB/HkYljJtmt506o+UcQI3cwR9a9
	 ZVwyIHQe5O69K7IvkJPXeUp9ASXFe90Moe2gfRoUjRYjc9mSmsSSYs+LyR3vRfJHw/
	 49BwsE/4KcUpgAZJ/GzSFNPwWkBYSciBitSstiMwvakdmIpUFndfDL96wxlcLo5rsk
	 Elw1pQeBCIkyQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: check for NULL root after calls to btrfs_csum_root()
Date: Sun,  8 Feb 2026 20:00:39 +0000
Message-ID: <a233792228ef9f634528a354f47e21b55c4f41ea.1770580436.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1770580436.git.fdmanana@suse.com>
References: <cover.1770580436.git.fdmanana@suse.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21503-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 2B30010A111
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
 fs/btrfs/extent-tree.c | 19 +++++++++++++++++--
 fs/btrfs/file-item.c   |  7 +++++++
 fs/btrfs/inode.c       | 18 ++++++++++++++++--
 fs/btrfs/raid56.c      | 12 ++++++++++--
 fs/btrfs/relocation.c  |  8 ++++++++
 fs/btrfs/tree-log.c    | 21 +++++++++++++++++++++
 7 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1194cb182a91..53237ec14d49 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1627,6 +1627,10 @@ static int backup_super_roots(struct btrfs_fs_info *info)
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
index 331263c206af..aa83436ac2be 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1974,8 +1974,14 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 			struct btrfs_root *csum_root;
 
 			csum_root = btrfs_csum_root(fs_info, head->bytenr);
-			ret = btrfs_del_csums(trans, csum_root, head->bytenr,
-					      head->num_bytes);
+			if (unlikely(!csum_root)) {
+				btrfs_err(fs_info,
+					  "missing csum root for extent at bytenr 0");
+				ret = -EUCLEAN;
+			} else {
+				ret = btrfs_del_csums(trans, csum_root, head->bytenr,
+						      head->num_bytes);
+			}
 		}
 	}
 
@@ -3147,6 +3153,15 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
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
index b6c763a17406..4753bfb7a15a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1997,6 +1997,13 @@ static int can_nocow_file_extent(struct btrfs_path *path,
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
@@ -2734,10 +2741,17 @@ static int add_pending_csums(struct btrfs_trans_handle *trans,
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
index 14de065e79fc..64d140bea1fb 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -5649,6 +5649,14 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
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


