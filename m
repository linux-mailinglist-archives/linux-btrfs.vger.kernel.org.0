Return-Path: <linux-btrfs+bounces-20764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPY1I0tecGkVXwAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20764-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 06:04:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0805514AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 06:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EB75886A90
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 12:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A174279F5;
	Tue, 20 Jan 2026 12:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkiNH4jQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3C94279FA
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911961; cv=none; b=NRY0uM2hdqD5ySIQUcYKA3559uZiqvANKoAIVkfO22pnagt8FOyjtshq2WhvLhrt8uafM7W37eFMvCdd9lJifE4oqSwfSANujiUs/TWGD6/oMMx1GYWPCgbKoMEXWye+TmL3EoS3xszORrA2YnqQdIFMUOCIKNplI01sWBfm7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911961; c=relaxed/simple;
	bh=I4zKywnGRCs4OgLyQwjqtLxGh0ykqILrQT806QyOuI0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtGokxXnOfhx20/sUJxDOfWr4kH8Gv4Sa0vx8IbkrY6r+aJGOjPALD1Diud/6pum7PP1/MGY5VJvRKZGGUhLaTKC4oHKpk+HYZCPLyh8IZLYxw3VNyz/Uw5GwmRwx3pqEXdjTpVxuKCOWOWvCodBf2dKZPGb7/qkXxLrJchSur0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkiNH4jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE56C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768911960;
	bh=I4zKywnGRCs4OgLyQwjqtLxGh0ykqILrQT806QyOuI0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SkiNH4jQLyeD26KV7qo5ndppPEGGt/WKD5kjvqUFXrSDpAUwmzSDiUQRBwqCsrhD6
	 xyc8wqSqoXcNzYxFWzA3Bmo68HG4nJAYGJ5WuaOh7HyeHbF0dQm+dGkiLIJeActJKC
	 5osywdjwNiqu5pRnK7k/oYhC0exqGrjwx8BTYlpJSLHELH6oVQ+2aqOQIPtFIg7gr1
	 oXb+xVYSXDbDCY7AS/3DCnRE4sV5qu9MyQRqV1iVi12YC+dNed4lRtWZ/f9FyoqA/E
	 oysnEmrEox+O4YHtySnokl267c7NVCyv8MC3jK1BuXs0pg7TU77dEULA+IAA9zZ2mh
	 ciCWr4/jzXFQw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: don't pass block group argument to load_block_group_size_class()
Date: Tue, 20 Jan 2026 12:25:53 +0000
Message-ID: <4f30c518bb73ab7adcc9524465c3038c55f0360e.1768911827.git.fdmanana@suse.com>
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
	TAGGED_FROM(0.00)[bounces-20764-lists,linux-btrfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F0805514AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass the block group since we can extract it from
the given caching control structure. Same goes for its helper function
sample_block_group_extent_item().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a7828673be39..82c488a4b54c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -575,7 +575,7 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
 /*
  * Get an arbitrary extent item index / max_index through the block group
  *
- * @block_group   the block group to sample from
+ * @caching_ctl   the caching control containing the block group to sample from
  * @index:        the integral step through the block group to grab from
  * @max_index:    the granularity of the sampling
  * @key:          return value parameter for the item we find
@@ -588,11 +588,11 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
  * Returns: 0 on success, 1 if the search didn't yield a useful item.
  */
 static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
-					  struct btrfs_block_group *block_group,
 					  int index, int max_index,
 					  struct btrfs_key *found_key,
 					  struct btrfs_path *path)
 {
+	struct btrfs_block_group *block_group = caching_ctl->block_group;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *extent_root;
 	u64 search_offset;
@@ -668,10 +668,10 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
  * No errors are returned since failing to determine the size class is not a
  * critical error, size classes are just an optimization.
  */
-static void load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
-					struct btrfs_block_group *block_group)
+static void load_block_group_size_class(struct btrfs_caching_control *caching_ctl)
 {
 	BTRFS_PATH_AUTO_FREE(path);
+	struct btrfs_block_group *block_group = caching_ctl->block_group;
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_key key;
 	int i;
@@ -694,8 +694,7 @@ static void load_block_group_size_class(struct btrfs_caching_control *caching_ct
 	for (i = 0; i < 5; ++i) {
 		int ret;
 
-		ret = sample_block_group_extent_item(caching_ctl, block_group,
-						     i, 5, &key, path);
+		ret = sample_block_group_extent_item(caching_ctl, i, 5, &key, path);
 		btrfs_release_path(path);
 		ASSERT(ret >= 0);
 		if (ret > 0)
@@ -864,7 +863,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 	mutex_lock(&caching_ctl->mutex);
 	down_read(&fs_info->commit_root_sem);
 
-	load_block_group_size_class(caching_ctl, block_group);
+	load_block_group_size_class(caching_ctl);
 	if (btrfs_test_opt(fs_info, SPACE_CACHE)) {
 		ret = load_free_space_cache(block_group);
 		if (ret == 1) {
-- 
2.47.2


