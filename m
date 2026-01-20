Return-Path: <linux-btrfs+bounces-20763-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIFgFK6LcWkLJAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20763-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 03:30:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD260EDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jan 2026 03:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8D886835
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D179F426EC8;
	Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km0pvekR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237D44279F2
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911960; cv=none; b=ClRbr6TEdsFr302AElqZS2xuEutJTLluZA/QaE1mGD55tQZM80a+MhkCpcIDkmd0yIpzHgTFGI1HXbpwQsdSsJf4GjyWVSLRp/Q2ODWz0BUh2KVHmHx4FNogsTX3xylGoeLU2fBXlYsbk4Zvt0VwOOK5VnLGr4SMzDCY0qmdNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911960; c=relaxed/simple;
	bh=VgXzL0IXNT0h0SBv7/HNCQRCs+qZByKqv8BFlgjclbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAp7T2FdPwi7sxvtniueDv1qBBCN1S62SMJhrtNbmi5/jO42w3rhhj4SzSwxMYDM86e9OVl6MZsmKA2xJBzxrleiPM9pi1EaCWbdVYjsnuy4dmEN1bLVM/8dorinT+UOul9qbxrmFPqtll9uOBY7kmIChIvz7XjFE8veBHPHznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km0pvekR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E791C19423
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911959;
	bh=VgXzL0IXNT0h0SBv7/HNCQRCs+qZByKqv8BFlgjclbk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=km0pvekRzlIyzc3icJgkqZaf1BAed5at6agJLPGDEjA5jonaGshz8ZAUpX8BUVAss
	 Eg36dp9A9Ptd9gK/m0IKNZhu/WNBT3JLt/Bf5sW6fOw3hnWrq5cX2Vly4OlqL5Zj17
	 62redOM4WEEHYgqiJEC55eKTlYNa6B59uhquCMyKvoRJoFKHCVCfCzOOiUpYpGZaRe
	 +scAMSKZ8bcXV1Y6mHhG0SJvWcDyqt+xrPcdnybio2anvBfaZN0lHVoBn/XVudVkvo
	 JbSdz8aiAAkS9F6TL20m1TreDsEjxFIRy1w5P2So/Vne09sPTI1WndNpGZQxoWx7ge
	 RFm+qYjCc54XQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: allocate path in load_block_group_size_class()
Date: Tue, 20 Jan 2026 12:25:52 +0000
Message-ID: <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768911827.git.fdmanana@suse.com>
References: <cover.1768911827.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DATE_IN_PAST(1.00)[38];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20763-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BAD260EDC
X-Rspamd-Action: no action

From: Filipe Manana <fdmanana@suse.com>

Instead of allocating and freeing a path in every iteration of
load_block_group_size_class(), through its helper function
sample_block_group_extent_item(), allocate the path in the former and
pass it to the later.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 343c29344484..a7828673be39 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -579,24 +579,24 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
  * @index:        the integral step through the block group to grab from
  * @max_index:    the granularity of the sampling
  * @key:          return value parameter for the item we find
+ * @path:         path to use for searching in the extent tree
  *
  * Pre-conditions on indices:
  * 0 <= index <= max_index
  * 0 < max_index
  *
- * Returns: 0 on success, 1 if the search didn't yield a useful item, negative
- * error code on error.
+ * Returns: 0 on success, 1 if the search didn't yield a useful item.
  */
 static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
 					  struct btrfs_block_group *block_group,
 					  int index, int max_index,
-					  struct btrfs_key *found_key)
+					  struct btrfs_key *found_key,
+					  struct btrfs_path *path)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
 	u64 search_offset;
 	const u64 search_end = btrfs_block_group_end(block_group);
-	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key search_key;
 	int ret = 0;
 
@@ -606,17 +606,9 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
 						       BTRFS_SUPER_INFO_OFFSET));
 
-	path->skip_locking = true;
-	path->search_commit_root = true;
-	path->reada = READA_FORWARD;
-
 	search_offset = index * div_u64(block_group->length, max_index);
 	search_key.objectid = block_group->start + search_offset;
 	search_key.type = BTRFS_EXTENT_ITEM_KEY;
@@ -679,6 +671,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
 static void load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
 					struct btrfs_block_group *block_group)
 {
+	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_key key;
 	int i;
@@ -688,14 +681,23 @@ static void load_block_group_size_class(struct btrfs_caching_control *caching_ct
 	if (!btrfs_block_group_should_use_size_class(block_group))
 		return;
 
+	path = btrfs_alloc_path();
+	if (!path)
+		return;
+
+	path->skip_locking = true;
+	path->search_commit_root = true;
+	path->reada = READA_FORWARD;
+
 	lockdep_assert_held(&caching_ctl->mutex);
 	lockdep_assert_held_read(&fs_info->commit_root_sem);
 	for (i = 0; i < 5; ++i) {
 		int ret;
 
-		ret = sample_block_group_extent_item(caching_ctl, block_group, i, 5, &key);
-		if (ret < 0)
-			return;
+		ret = sample_block_group_extent_item(caching_ctl, block_group,
+						     i, 5, &key, path);
+		btrfs_release_path(path);
+		ASSERT(ret >= 0);
 		if (ret > 0)
 			continue;
 		min_size = min_t(u64, min_size, key.offset);
-- 
2.47.2


