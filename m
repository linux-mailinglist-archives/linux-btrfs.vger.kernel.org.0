Return-Path: <linux-btrfs+bounces-20846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLQ3MHoIcWmPcQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20846-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:10:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF35A53E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0AB2EA2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 16:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8137B4963A7;
	Wed, 21 Jan 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+KCv8rE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5763495511
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013055; cv=none; b=gQKRMfpGADI8NzA3DU1enNiCkWjNr3zSxagBcwQzLFfxrFp9dMqHpUETLEtEXI2TnH3xuuHuEihUzoTNZ677cswqq0COdnbKOBmACGQvUs82eyRgnrmgVX8HZtmEJ3zQz3DEh9PeWI797rcfcwJ8y8gTrXFEYdsy7I01TehaBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013055; c=relaxed/simple;
	bh=VfJYz8gvocJ6iOKphP1Iwx8NYEuiBFI1gJjKxZ2CD8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0QP/qub1BaG9n8kROhafpU0Ax9dNC03i1HLc5RHMgOPbasp0VnI76dSiD8E6UERlEFTlbxuGM6wwm+Trmi1Nmh7V+lAFMb2nDiQMNZZG6GQll28QCmeDj9hP/sFsFpD6BReuHVtCJHGiG8/QN/8YrpoOiPhukl4YlKS9quHC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+KCv8rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF227C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769013055;
	bh=VfJYz8gvocJ6iOKphP1Iwx8NYEuiBFI1gJjKxZ2CD8Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=l+KCv8rErDU0VWphQzcSbUXhuRDnGJ89V8tpYqxAapeK1HjYIvmJPPwDEfyLN2m/Y
	 JhZjLF8fjWXC7zISsw44LzA6S5kW33yf9Z3uuhLZp77S85pFLRnAOCKHS98HiybCrM
	 ASv5BQKmv0VzaLnTpPXM0+Nql4YhqmuSLqF88dP0nsylIPKpZgg2jRTxtvhfmb3M/v
	 wOn0jfZY4Ue9sJxMPdKO7lzRpHwCf45hSo4fMvesqXCfp+c0OeBc5dzTcUmhqc2E2F
	 Vkc8i2SutGE1KD/X9P4+NxwYs2KwaaDsBPV+z1vCAuC1ujV6TC5vWcjnugHiXIES4P
	 Dqb330qW66V7g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/19] btrfs: remove pointless out labels from free-space-cache.c
Date: Wed, 21 Jan 2026 16:30:33 +0000
Message-ID: <ee86c3e201b04d75e940a76d84d60d6b43e0bfd5.1769012877.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20846-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 53BF35A53E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

Some functions (update_cache_item(), find_free_space(), trim_bitmaps(),
btrfs_remove_free_space() and cleanup_free_space_cache_v1()) have an 'out'
label that does nothing but return, making it pointless. Simplify this by
removing the label and returning instead of gotos plus setting the 'ret'
variable.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ff4b3a768e1b..bf7f2d6285fe 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1162,7 +1162,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	if (ret < 0) {
 		btrfs_clear_extent_bit(&BTRFS_I(inode)->io_tree, 0, inode->i_size - 1,
 				       EXTENT_DELALLOC, NULL);
-		goto fail;
+		return ret;
 	}
 	leaf = path->nodes[0];
 	if (ret > 0) {
@@ -1176,7 +1176,7 @@ update_cache_item(struct btrfs_trans_handle *trans,
 					       inode->i_size - 1, EXTENT_DELALLOC,
 					       NULL);
 			btrfs_release_path(path);
-			goto fail;
+			return -ENOENT;
 		}
 	}
 
@@ -1189,9 +1189,6 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 
 	return 0;
-
-fail:
-	return -1;
 }
 
 static noinline_for_stack int write_pinned_extent_entries(
@@ -2017,7 +2014,7 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 	int ret;
 
 	if (!ctl->free_space_offset.rb_node)
-		goto out;
+		return NULL;
 again:
 	if (use_bytes_index) {
 		node = rb_first_cached(&ctl->free_space_bytes);
@@ -2025,7 +2022,7 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 		entry = tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),
 					   0, 1);
 		if (!entry)
-			goto out;
+			return NULL;
 		node = &entry->offset_index;
 	}
 
@@ -2109,7 +2106,7 @@ find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *bytes,
 		*bytes = entry->bytes - align_off;
 		return entry;
 	}
-out:
+
 	return NULL;
 }
 
@@ -2894,7 +2891,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 						     old_end - (offset + bytes),
 						     info->trim_state);
 			WARN_ON(ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -2906,7 +2903,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 out_lock:
 	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
-out:
+
 	return ret;
 }
 
@@ -4007,7 +4004,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
-			goto out;
+			return ret;
 		}
 
 		bytes = min(bytes, end - start);
@@ -4068,7 +4065,6 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 	if (offset >= end)
 		block_group->discard_cursor = end;
 
-out:
 	return ret;
 }
 
@@ -4161,20 +4157,20 @@ static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_group *block_group;
 	struct rb_node *node;
-	int ret = 0;
 
 	btrfs_info(fs_info, "cleaning free space cache v1");
 
 	node = rb_first_cached(&fs_info->block_group_cache_tree);
 	while (node) {
+		int ret;
+
 		block_group = rb_entry(node, struct btrfs_block_group, cache_node);
 		ret = btrfs_remove_free_space_inode(trans, NULL, block_group);
 		if (ret)
-			goto out;
+			return ret;
 		node = rb_next(node);
 	}
-out:
-	return ret;
+	return 0;
 }
 
 int btrfs_set_free_space_cache_v1_active(struct btrfs_fs_info *fs_info, bool active)
-- 
2.47.2


