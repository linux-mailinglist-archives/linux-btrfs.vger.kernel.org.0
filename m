Return-Path: <linux-btrfs+bounces-18193-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F85C02481
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41E194FB4D2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Oct 2025 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5BA274650;
	Thu, 23 Oct 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToOfagsz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72968265609
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235211; cv=none; b=jIodszPFO6y2d/piRzaOTtPz4HBFlWDbmtfGQfQLZoPkU3x2ALfwvHUdeCPfBJ6vDwu1/9K8eU5tbnVyo+ZfxyeZM2sEFoaFKtpqnm1gDQWTQhudfj6fXmgSUfCNeoIAuYg55Ze0/3nULQjZWjX9wvcOfgtpIOkCWiGgoJBRglI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235211; c=relaxed/simple;
	bh=bo/YyX9scsV7nvjeaexTbYjJ+3OCp+9vKQ49ckspayE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAlVx9dX6L/vx6eTMNZVjckuTWfHoBVuzfD+em0RgtadWwwLAfXJri6Mq1dkkL4FUwrGaxHR+6ZgKqykQLm/4zbKoRufNi964RRhaevvkIRebblr/QSQ5gTlch57Hw/WxQR5Ffzd2vPptmTy8eNmBzIoHbdjGFQr09qlQc1NcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToOfagsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF429C4CEFF
	for <linux-btrfs@vger.kernel.org>; Thu, 23 Oct 2025 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761235211;
	bh=bo/YyX9scsV7nvjeaexTbYjJ+3OCp+9vKQ49ckspayE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ToOfagsz0WE+tq9IPyfKPe7moBWnd+bHeI+eMK2fH4BntVsCE4joEnUGCg99eVn6g
	 7p/bvDMR7ojvV5d58HB+zNlIN4p+nvT3b/r0mWo6CHvQY4st5PVsaJDxGnlrtgI72t
	 RCDBS1ID9VBTYlBeHSgs+0FyvaxKgeuYUq7ac9K605TuOLtPkduX3t8M1fvmMXxvNb
	 1uJvj1drHZnFfxuNIBGQOt+AKJ23ryvqEChUmy60kzke9ykriPvpMIuW4CwDRcBfCa
	 CPFm8hOPeHYp4s+/nS7jnOS+2ASfQwik3VUOlRUnt5RKk/Bf/aKbc3s0wlYwqU88Uh
	 isRhfhVWPA8vA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 06/28] btrfs: inline btrfs_space_info_used()
Date: Thu, 23 Oct 2025 16:59:39 +0100
Message-ID: <c7387d9ae30b7bf261932c8965cac5737699b228.1761234581.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1761234580.git.fdmanana@suse.com>
References: <cover.1761234580.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function is simple enough to be inlined and in fact doing it even
reduces the object code. In x86_64 with 14.2.0-19 from Debian the results
were the following:

  Before this change

    $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
    1919410	 161703	  15592	2096705	 1ffe41	fs/btrfs/btrfs.ko

  After this change

    $ size fs/btrfs/btrfs.ko
      text	   data	    bss	    dec	    hex	filename
    1918991	 161675	  15592	2096258	 1ffc82	fs/btrfs/btrfs.ko

Also remove the ASSERT() that checks the space_info argument is not NULL,
as it's odd to be there since it can never be NULL and in case that ever
happens during development, a stack trace from a NULL pointer dereference
will be obvious. It was originally added when btrfs_space_info_used() was
introduced in commit 4136135b080f ("Btrfs: use helper to get used bytes
of space_info").

Also add a lockdep assertion to check the space_info's lock is being held
by the calling task.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 10 ----------
 fs/btrfs/space-info.h | 13 +++++++++++--
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6c2769044b55..53677ecb8c15 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -172,16 +172,6 @@
  *   thing with or without extra unallocated space.
  */
 
-u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
-			  bool may_use_included)
-{
-	ASSERT(s_info);
-	return s_info->bytes_used + s_info->bytes_reserved +
-		s_info->bytes_pinned + s_info->bytes_readonly +
-		s_info->bytes_zone_unusable +
-		(may_use_included ? s_info->bytes_may_use : 0);
-}
-
 /*
  * after adding space to the filesystem, we need to clear the full flags
  * on all the space infos.
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index d97b0799649f..7e16d4c116c8 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -266,6 +266,17 @@ DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 DECLARE_SPACE_INFO_UPDATE(bytes_zone_unusable, "zone_unusable");
 
+static inline u64 btrfs_space_info_used(const struct btrfs_space_info *s_info,
+					bool may_use_included)
+{
+	lockdep_assert_held(&s_info->lock);
+
+	return s_info->bytes_used + s_info->bytes_reserved +
+		s_info->bytes_pinned + s_info->bytes_readonly +
+		s_info->bytes_zone_unusable +
+		(may_use_included ? s_info->bytes_may_use : 0);
+}
+
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 				struct btrfs_block_group *block_group);
@@ -273,8 +284,6 @@ void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 					       u64 flags);
-u64 __pure btrfs_space_info_used(const struct btrfs_space_info *s_info,
-			  bool may_use_included);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 void btrfs_dump_space_info(struct btrfs_space_info *info, u64 bytes,
 			   bool dump_block_groups);
-- 
2.47.2


