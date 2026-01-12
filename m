Return-Path: <linux-btrfs+bounces-20418-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1126D13F40
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C798030BEA6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503A0306B12;
	Mon, 12 Jan 2026 16:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="qfYaG17G";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PoZZAn7j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-1.smtp-out.eu-west-1.amazonses.com (a4-1.smtp-out.eu-west-1.amazonses.com [54.240.4.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB18365A09
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234645; cv=none; b=UB3tmpdEguWD8TiyZonlgUTHxiD9Iy9TSzDFF7F35oLIRoKgKGd+SQw4zg0DrrBswvUnZ/qCKY1LZqtc6YtXMCXgknAlegvQQ1+2X6iiAN0WCZ3aKhj9eo8lTNjupE/7rh3TP4A5LQ0MpMF+GP50CJB3fpDUEbQLqnGc3Ha3ZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234645; c=relaxed/simple;
	bh=PVI4VserlKtKnvomz5mq7uAbl823J7V4syTLbkn+tb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4bVQceLPVs5nMeFOXA0KXL0mAcTy8K5bWNoRSPhekP2Kc53xxSdwUu6KzZZR7PZXeqi6UDDItKuhSCyaz/7yzqWG01Jt4fNEv5fVMzKXvW9YkdqoLnOMLrwZYrKdkXc6s9K0NyR0z2baxH50WHYm1Jnc8kokpc5cy1npO9b9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=qfYaG17G; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PoZZAn7j; arc=none smtp.client-ip=54.240.4.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234639;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PVI4VserlKtKnvomz5mq7uAbl823J7V4syTLbkn+tb4=;
	b=qfYaG17Gw8lq4VgNSKsE+XTfmU8sUGzIM3ad77xhqIKX+anZ38PJBh4aFye3WOPK
	YhQBf8oDwRoKWspq1zI7Glq+sMSsERe8Dn6W3ThXGTVP3jrUFD4SDdzrjioOxOJC7VJ
	37w57QesLPHGckObXPLGBpwc7hNWcfkoaJyCNiz8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234639;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=PVI4VserlKtKnvomz5mq7uAbl823J7V4syTLbkn+tb4=;
	b=PoZZAn7jCYFA8Hd5wwLTJkd0GpEJyArAq6amj4YteU6owBGFfpxdJ4g4TOw4BPZh
	OyPnCsGhYkk1Z0MT3HWgTvJeRh/9Ja3NV8/K3Th8biTbTfRF0rH3pSOixkS0D3e1kjs
	+ej9hXy0mSaRZdc9rM5P9p0o8dnOr4tt/E06X3g8=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 7/7] btrfs: Move block group members frequently accessed together  closer
Date: Mon, 12 Jan 2026 16:17:19 +0000
Message-ID: <0102019bb2ff5ee6-fdf327ec-bb32-45b0-8841-a00b073be425-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112161549.2786827-1-martin@urbackup.org>
References: <20260112161549.2786827-1-martin@urbackup.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.1

The ro, cached and size_class members of btrfs_block_group are
frequently used together by find_free_extent. Move them into the same
cache line at the beginning of the struct.

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 73bdf7091d49..a356b35af61a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -120,6 +120,12 @@ struct btrfs_block_group {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_inode *inode;
 	spinlock_t lock;
+
+	/* Frequently accessed by find_free_extent members */
+	unsigned int ro;
+	int cached;
+	enum btrfs_block_group_size_class size_class;
+
 	u64 start;
 	u64 length;
 	u64 pinned;
@@ -160,12 +166,9 @@ struct btrfs_block_group {
 	unsigned long full_stripe_len;
 	unsigned long runtime_flags;
 
-	unsigned int ro;
-
 	int disk_cache_state;
 
 	/* Cache tracking stuff */
-	int cached;
 	struct btrfs_caching_control *caching_ctl;
 
 	struct btrfs_space_info *space_info;
@@ -270,7 +273,6 @@ struct btrfs_block_group {
 	struct list_head active_bg_list;
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
-	enum btrfs_block_group_size_class size_class;
 	u64 reclaim_mark;
 };
 
-- 
2.39.5


