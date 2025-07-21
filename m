Return-Path: <linux-btrfs+bounces-15606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10521B0C971
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379BC1C221A0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D12E11D5;
	Mon, 21 Jul 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK3rd3c2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B292E11C0
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118214; cv=none; b=sARdgCtPEZJidZMzLm65ValNdPpLO0rOUtTguzJ4dvGW24CrB+xGN5xzbFVjPVIdFaKp0L9qO+X9NDMLC1SEolNObROoZYeZ4+3CA7O4bLF564zOII7iayNx1KPfMUvg/MRJEMNPaPM+uwGLq4ytImuMxcBzqPPlZCx6pc5WB+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118214; c=relaxed/simple;
	bh=B4ONTBwL3I0ONTWwvBRD3svFapC5OcSGPyk6tfaxYJI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMV5Xw7qaUEfYc2C3Y+mDW5RLOwRWVoA799cgmLCipzoyJrFde3dxrBdWh9OcSGi7ZAdm5nNODQa95wd3ZV7Q5UIWH+nsTzaVwn9gMJaK0zHNVatiPf4II022VP/+TmVQyIFYCw+M4M1D9UyBihBCJ26AOD/gIbWMhr+6q2NU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK3rd3c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F88C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118213;
	bh=B4ONTBwL3I0ONTWwvBRD3svFapC5OcSGPyk6tfaxYJI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lK3rd3c2DiA697dLQRw0Vi6S4DPxSoeTHJrQhXDIqF5BdsP/swNAdu4u66y7PkVAj
	 0s3aDJ4O2BSb4A2DVyTx8gM4JSlzy8maxz+XKA0uelBDeb8zWwAblaTT5eYOuapVF0
	 z3segORRZChj/owHJVfjsWs6skj0s5LofrtYL2B0rpBRAobntJVgDEtr30zpwRfXUN
	 7ujWXJFqq212j+3e6aBJyvq+DkLGkgWDUy1+cuULAoXuqcIPVMEHO9xFFYBYgNxtZx
	 im3yHqWo+5KLG6ellVHPg61RQUWfbx6Le/Jqo2yJZ7i1flSybBAQpbyh9zwfqKqT1r
	 xs3kKHu/L+wew==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs: collapse unaccount_log_buffer() into clean_log_buffer()
Date: Mon, 21 Jul 2025 18:16:37 +0100
Message-ID: <4be7a39e4f37e5c68683d01a994bf0a22292b4f2.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's one only one caller of unaccount_log_buffer() and both this
function and the caller are short, so move its code into the caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 51 +++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 85b623850a57..43a96fb27bce 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2724,35 +2724,11 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	return ret;
 }
 
-/*
- * Correctly adjust the reserved bytes occupied by a log tree extent buffer
- */
-static int unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
-{
-	struct btrfs_block_group *cache;
-
-	cache = btrfs_lookup_block_group(fs_info, start);
-	if (!cache) {
-		btrfs_err(fs_info, "unable to find block group for %llu", start);
-		return -ENOENT;
-	}
-
-	spin_lock(&cache->space_info->lock);
-	spin_lock(&cache->lock);
-	cache->reserved -= fs_info->nodesize;
-	cache->space_info->bytes_reserved -= fs_info->nodesize;
-	spin_unlock(&cache->lock);
-	spin_unlock(&cache->space_info->lock);
-
-	btrfs_put_block_group(cache);
-
-	return 0;
-}
-
 static int clean_log_buffer(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *eb)
 {
-	int ret;
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct btrfs_block_group *bg;
 
 	btrfs_tree_lock(eb);
 	btrfs_clear_buffer_dirty(trans, eb);
@@ -2760,16 +2736,31 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 	btrfs_tree_unlock(eb);
 
 	if (trans) {
+		int ret;
+
 		ret = btrfs_pin_reserved_extent(trans, eb);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-	ret = unaccount_log_buffer(eb->fs_info, eb->start);
-	if (ret)
-		btrfs_handle_fs_error(eb->fs_info, ret, NULL);
-	return ret;
+	bg = btrfs_lookup_block_group(fs_info, eb->start);
+	if (!bg) {
+		btrfs_err(fs_info, "unable to find block group for %llu", eb->start);
+		btrfs_handle_fs_error(fs_info, -ENOENT, NULL);
+		return -ENOENT;
+	}
+
+	spin_lock(&bg->space_info->lock);
+	spin_lock(&bg->lock);
+	bg->reserved -= fs_info->nodesize;
+	bg->space_info->bytes_reserved -= fs_info->nodesize;
+	spin_unlock(&bg->lock);
+	spin_unlock(&bg->space_info->lock);
+
+	btrfs_put_block_group(bg);
+
+	return 0;
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
-- 
2.47.2


