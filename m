Return-Path: <linux-btrfs+bounces-20842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PQGKiYOcWlEcgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20842-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:34:30 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C765A9A6
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DEE04ED143
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592C40FDAE;
	Wed, 21 Jan 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdhWVZFp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19F48A2D2
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013052; cv=none; b=qiJsSxBllwdDEb7x/FukFjbHB/vfoA9cP1Tadde6OSuAzEoEeCmGGY+IfT1D8mg526/K1MK/BRtaVbeLXSPW117DB6Wtm3Bhg+DHuisFbagRxrcflE/0OyZAqVrkHOhzhWKEPZMWmcrfiDJwKX4zwuEL++w0KMXTqp7Ps6eBQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013052; c=relaxed/simple;
	bh=Tk8fDjQp2qQEyrBiwVHQzTMtPc1ZNT3NOhgmxHRyRTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5K+Uu6qZas1vxTeVejEIccUETubyeJ7yQQNwQGEbvNb+uMyJalMLtCzYdvSfVWJwyhzUfypf83gPQ/Fh1FryEAHirqygXPy9vXqO5PL6yK5FwANIjfYYV7Htuj4+T2axKdMkI2NL+B60jkzWTX+vwia84mrfF1K1FtbOU/e624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdhWVZFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4864BC4CEF1
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013051;
	bh=Tk8fDjQp2qQEyrBiwVHQzTMtPc1ZNT3NOhgmxHRyRTM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JdhWVZFpIsRWgJ5Te8Bffnam4B6C8ybMqRZX6Uyf7OYnOXX+qEsagQwNmTQ2ZuLTu
	 Tpfg9zFdubvP6BUUKrcA192nRB9Ixsx8Yvmm4/OeUotxfj1t9/+48NA6v7PJXDFH8G
	 UBrC7JS4eRNdESmRvxskR70e4gqrU/oCCZhP0TbuwULTyrN6PGhQ3MMXtrd/ZBjrGB
	 i+bg4VDKf5bwyLa71Jtb/y9CA3cLxO6L6YfA+PK0PgKQRZe5D2DEsiGDXzOQMvxvc3
	 AfUVjyn8ltwx4De3gkMx9N1ct9Lov6eNFsT6KrZf3H/TJcPCVGvOmrPMgfdgA3G7/5
	 c95xaho7eBI6A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/19] btrfs: remove pointless out labels from send.c
Date: Wed, 21 Jan 2026 16:30:29 +0000
Message-ID: <e389041b1fee8dcbad5aef03c6da877cfecb093f.1769012877.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1769012876.git.fdmanana@suse.com>
References: <cover.1769012876.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20842-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 50C765A9A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (process_extent(), process_recorded_refs_if_needed(),
changed_inode(), compare_refs() and changed_cb()) have an 'out' label that
does nothing but return, making it pointless. Simplify this by removing
the label and returning instead of gotos plus setting the 'ret' variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 76 +++++++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8127a7120c2..3dcfdba018b5 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6449,11 +6449,9 @@ static int process_extent(struct send_ctx *sctx,
 	if (sctx->parent_root && !sctx->cur_inode_new) {
 		ret = is_extent_unchanged(sctx, path, key);
 		if (ret < 0)
-			goto out;
-		if (ret) {
-			ret = 0;
+			return ret;
+		if (ret)
 			goto out_hole;
-		}
 	} else {
 		struct btrfs_file_extent_item *ei;
 		u8 type;
@@ -6469,31 +6467,25 @@ static int process_extent(struct send_ctx *sctx,
 			 * we have enough commands queued up to justify rev'ing
 			 * the send spec.
 			 */
-			if (type == BTRFS_FILE_EXTENT_PREALLOC) {
-				ret = 0;
-				goto out;
-			}
+			if (type == BTRFS_FILE_EXTENT_PREALLOC)
+				return 0;
 
 			/* Have a hole, just skip it. */
-			if (btrfs_file_extent_disk_bytenr(path->nodes[0], ei) == 0) {
-				ret = 0;
-				goto out;
-			}
+			if (btrfs_file_extent_disk_bytenr(path->nodes[0], ei) == 0)
+				return 0;
 		}
 	}
 
 	ret = find_extent_clone(sctx, path, key->objectid, key->offset,
 			sctx->cur_inode_size, &found_clone);
 	if (ret != -ENOENT && ret < 0)
-		goto out;
+		return ret;
 
 	ret = send_write_or_clone(sctx, path, key, found_clone);
 	if (ret)
-		goto out;
+		return ret;
 out_hole:
-	ret = maybe_send_hole(sctx, path, key);
-out:
-	return ret;
+	return maybe_send_hole(sctx, path, key);
 }
 
 static int process_all_extents(struct send_ctx *sctx)
@@ -6535,23 +6527,24 @@ static int process_recorded_refs_if_needed(struct send_ctx *sctx, bool at_end,
 					   int *pending_move,
 					   int *refs_processed)
 {
-	int ret = 0;
+	int ret;
 
 	if (sctx->cur_ino == 0)
-		goto out;
+		return 0;
+
 	if (!at_end && sctx->cur_ino == sctx->cmp_key->objectid &&
 	    sctx->cmp_key->type <= BTRFS_INODE_EXTREF_KEY)
-		goto out;
+		return 0;
+
 	if (list_empty(&sctx->new_refs) && list_empty(&sctx->deleted_refs))
-		goto out;
+		return 0;
 
 	ret = process_recorded_refs(sctx, pending_move);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	*refs_processed = 1;
-out:
-	return ret;
+	return 0;
 }
 
 static int finish_inode_if_needed(struct send_ctx *sctx, bool at_end)
@@ -6768,7 +6761,7 @@ static void close_current_inode(struct send_ctx *sctx)
 static int changed_inode(struct send_ctx *sctx,
 			 enum btrfs_compare_tree_result result)
 {
-	int ret = 0;
+	int ret;
 	struct btrfs_key *key = sctx->cmp_key;
 	struct btrfs_inode_item *left_ii = NULL;
 	struct btrfs_inode_item *right_ii = NULL;
@@ -6860,7 +6853,7 @@ static int changed_inode(struct send_ctx *sctx,
 	if (result == BTRFS_COMPARE_TREE_NEW) {
 		if (btrfs_inode_nlink(sctx->left_path->nodes[0], left_ii) == 0) {
 			sctx->ignore_cur_inode = true;
-			goto out;
+			return 0;
 		}
 		sctx->cur_inode_gen = left_gen;
 		sctx->cur_inode_new = true;
@@ -6888,7 +6881,7 @@ static int changed_inode(struct send_ctx *sctx,
 		old_nlinks = btrfs_inode_nlink(sctx->right_path->nodes[0], right_ii);
 		if (new_nlinks == 0 && old_nlinks == 0) {
 			sctx->ignore_cur_inode = true;
-			goto out;
+			return 0;
 		} else if (new_nlinks == 0 || old_nlinks == 0) {
 			sctx->cur_inode_new_gen = 1;
 		}
@@ -6914,7 +6907,7 @@ static int changed_inode(struct send_ctx *sctx,
 				ret = process_all_refs(sctx,
 						BTRFS_COMPARE_TREE_DELETED);
 				if (ret < 0)
-					goto out;
+					return ret;
 			}
 
 			/*
@@ -6935,11 +6928,11 @@ static int changed_inode(struct send_ctx *sctx,
 						left_ii);
 				ret = send_create_inode_if_needed(sctx);
 				if (ret < 0)
-					goto out;
+					return ret;
 
 				ret = process_all_refs(sctx, BTRFS_COMPARE_TREE_NEW);
 				if (ret < 0)
-					goto out;
+					return ret;
 				/*
 				 * Advance send_progress now as we did not get
 				 * into process_recorded_refs_if_needed in the
@@ -6953,10 +6946,10 @@ static int changed_inode(struct send_ctx *sctx,
 				 */
 				ret = process_all_extents(sctx);
 				if (ret < 0)
-					goto out;
+					return ret;
 				ret = process_all_new_xattrs(sctx);
 				if (ret < 0)
-					goto out;
+					return ret;
 			}
 		} else {
 			sctx->cur_inode_gen = left_gen;
@@ -6970,8 +6963,7 @@ static int changed_inode(struct send_ctx *sctx,
 		}
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -7104,20 +7096,20 @@ static int compare_refs(struct send_ctx *sctx, struct btrfs_path *path,
 	u32 item_size;
 	u32 cur_offset = 0;
 	int ref_name_len;
-	int ret = 0;
 
 	/* Easy case, just check this one dirid */
 	if (key->type == BTRFS_INODE_REF_KEY) {
 		dirid = key->offset;
 
-		ret = dir_changed(sctx, dirid);
-		goto out;
+		return dir_changed(sctx, dirid);
 	}
 
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	while (cur_offset < item_size) {
+		int ret;
+
 		extref = (struct btrfs_inode_extref *)(ptr +
 						       cur_offset);
 		dirid = btrfs_inode_extref_parent(leaf, extref);
@@ -7127,11 +7119,10 @@ static int compare_refs(struct send_ctx *sctx, struct btrfs_path *path,
 			continue;
 		ret = dir_changed(sctx, dirid);
 		if (ret)
-			break;
+			return ret;
 		last_dirid = dirid;
 	}
-out:
-	return ret;
+	return 0;
 }
 
 /*
@@ -7212,12 +7203,12 @@ static int changed_cb(struct btrfs_path *left_path,
 
 	ret = finish_inode_if_needed(sctx, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	/* Ignore non-FS objects */
 	if (key->objectid == BTRFS_FREE_INO_OBJECTID ||
 	    key->objectid == BTRFS_FREE_SPACE_OBJECTID)
-		goto out;
+		return 0;
 
 	if (key->type == BTRFS_INODE_ITEM_KEY) {
 		ret = changed_inode(sctx, result);
@@ -7234,7 +7225,6 @@ static int changed_cb(struct btrfs_path *left_path,
 			ret = changed_verity(sctx, result);
 	}
 
-out:
 	return ret;
 }
 
-- 
2.47.2


