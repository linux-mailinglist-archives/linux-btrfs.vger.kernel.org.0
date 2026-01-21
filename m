Return-Path: <linux-btrfs+bounces-20817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC7gL/62cGndZAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20817-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AC55EDB
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 12:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9A067686DDC
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563D421A1A;
	Wed, 21 Jan 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUOvE9e4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0201480958
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994043; cv=none; b=juSvGv7lZxwkLTwHBUNdU70nKgro3lk3j7sGKHMZxuEmrTh72/w2kVF8QRtktwO5gjZLRjcF9oYFjZfylGMlb3GRUFjH94FIutzVtbvIsNUe/yIM+bzc088zCwszFjCNR2S5NyMZsLD/4GrlhhQh9NpDr/kk4UZVi96wcjwgY4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994043; c=relaxed/simple;
	bh=aU/Tks+UPlTbDKCLqUcJJ/avRaIn7fLrI/G3/VM+MU8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM+H+5XTfMQPm5qKqkIEaj3mcYV5ARo7XeRc83pbm/d2thL4PUno6dMs6Bb0glApdsTxZd9FGCF9z/sEmgk8EdubCm79oKs7fGLMBcUzAezdkuUJUvfvFhA6rzezZeuflY3BrEP+kjW9jVGZvVemfXE8QCwV7ytvfBVhnb3t9xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUOvE9e4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7548C19424
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 11:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768994043;
	bh=aU/Tks+UPlTbDKCLqUcJJ/avRaIn7fLrI/G3/VM+MU8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mUOvE9e41DA5AKIBU3eDHPcwEuIYbwTN9u52JTCisMK19JBw0u/qoVUpUblljrgH2
	 6EzvJsIFCVL/Q9KyBK6KC5wSmn1trrVTjJnedye9hN6apbVSdCiC7n8U0Cx75B+Nu1
	 Ueeba7ZaVc2oETOsKhGQOx7EN7SbvZw8VhLUlcexhl7g17oOfp4zze5ch533lc3uXh
	 xT3itZozPicZ65m5UUQknt7HSfxCxWT0/nY313eMUQbUMtHWYPSa0oAxVWdKkJXiup
	 iprEr/9G84WXE2zecdcUyXKk9KOzxJkqfkRSucBGqzeJL64G4BtIzPY0GcGHDIgAoz
	 BOQQLmBjZIehw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/19] btrfs: remove pointless out labels from free-space-cache.c
Date: Wed, 21 Jan 2026 11:13:41 +0000
Message-ID: <a1f528f52b67a37c00271db348eab6ce63fa4b29.1768993725.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768993725.git.fdmanana@suse.com>
References: <cover.1768993725.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20817-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.com:mid]
X-Rspamd-Queue-Id: 8A4AC55EDB
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
 fs/btrfs/free-space-cache.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ff4b3a768e1b..2f60ed717927 100644
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
 
@@ -2828,7 +2825,6 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	spin_lock(&ctl->tree_lock);
 
 again:
-	ret = 0;
 	if (!bytes)
 		goto out_lock;
 
@@ -2894,7 +2890,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 						     old_end - (offset + bytes),
 						     info->trim_state);
 			WARN_ON(ret);
-			goto out;
+			return ret;
 		}
 	}
 
@@ -2906,8 +2902,8 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 out_lock:
 	btrfs_discard_update_discardable(block_group);
 	spin_unlock(&ctl->tree_lock);
-out:
-	return ret;
+
+	return 0;
 }
 
 void btrfs_dump_free_space(struct btrfs_block_group *block_group,
@@ -4007,7 +4003,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed) {
 			spin_unlock(&ctl->tree_lock);
 			mutex_unlock(&ctl->cache_writeout_mutex);
-			goto out;
+			return ret;
 		}
 
 		bytes = min(bytes, end - start);
@@ -4068,7 +4064,6 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 	if (offset >= end)
 		block_group->discard_cursor = end;
 
-out:
 	return ret;
 }
 
@@ -4161,20 +4156,20 @@ static int cleanup_free_space_cache_v1(struct btrfs_fs_info *fs_info,
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


