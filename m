Return-Path: <linux-btrfs+bounces-18868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2987C4ED5B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 16:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424BB18C110F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EEA369987;
	Tue, 11 Nov 2025 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8e7EXSt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23214286
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875896; cv=none; b=LtNDZxHE7EmPxtqqzJXKVEC4fmHv4jf2FEaGqX8x/II3hPPsjmAAP8boK6AjRekEAWFb532u0c4hg8EX5bX67au8X4wwK5fCqpz41FF3azMtdwYhiNSs8xulbcDMzz9zp7ewBQJWvGPfm4JJUdiwsCQgNtgxhxcsklcfSSlFHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875896; c=relaxed/simple;
	bh=5O5big79qW/5kPekW+Lx/FMMY0WZV1NQNktqv9lFdXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cz3A6yC8JTJN7JzMc9jX4wjNhHim4Durko1pB5faPhRCshxcZ4bZ978R1JF8Y1YQ4Lpxlyii80E7hNIw56oVO9CCKD2efae9EgN8BTsCju4niarj18bziO/AeOniNZsRw+xzJNnGOk6UozwuxT8aOOp73kX1g1EYhSAnuO1taiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8e7EXSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E95DC116D0
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762875896;
	bh=5O5big79qW/5kPekW+Lx/FMMY0WZV1NQNktqv9lFdXM=;
	h=From:To:Subject:Date:From;
	b=I8e7EXStr0YNctQUZ9q3753L31q3yS6wpW98RBdj3n5pVLDHTZVgx7WkGTEo2LeZS
	 Bn6qciWWmZk0NvFfgOEaAch++IjNFggGujDhDL3FB7Xj59XIksJDfZ7i/05tNZGIHr
	 C5MCokEm1K5GjmIe7U+fR2Mnm6lIfDRV1DbHrRJWLIIO3DzOFBr0mswuf9MC0fVjow
	 6rnUH9VJEQ1Ku32V+H7jS7W3eldBVWcQ9gyNAEqoPDnMtxCfaWN7FUuMXoGJ6Ka18d
	 e/Tzx7CIJuP8lRgOlkB3kb2slnyNeeSQLDua+FZc3i6duib8/i0YtDjWdm+O3WdTqw
	 cTDJeiPBXsQog==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move struct reserve_ticket definition to space-info.c
Date: Tue, 11 Nov 2025 15:44:50 +0000
Message-ID: <47a12c6a3f5ef227726e6d450326a8e6007dba5a.1762875866.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's not used anywhere outside space-info.c so move it from space-info.h
into space-info.c.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 9 +++++++++
 fs/btrfs/space-info.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4ae6928fdca4..61fd76c3da0d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -173,6 +173,15 @@
  *   thing with or without extra unallocated space.
  */
 
+struct reserve_ticket {
+	u64 bytes;
+	int error;
+	bool steal;
+	struct list_head list;
+	wait_queue_head_t wait;
+	spinlock_t lock;
+};
+
 /*
  * after adding space to the filesystem, we need to clear the full flags
  * on all the space infos.
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a4c2a3c8b388..446c0614ad4a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -224,15 +224,6 @@ struct btrfs_space_info {
 	s64 reclaimable_bytes;
 };
 
-struct reserve_ticket {
-	u64 bytes;
-	int error;
-	bool steal;
-	struct list_head list;
-	wait_queue_head_t wait;
-	spinlock_t lock;
-};
-
 static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
-- 
2.47.2


