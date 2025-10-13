Return-Path: <linux-btrfs+bounces-17732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173FCBD58EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CF9404B51
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14262309EE1;
	Mon, 13 Oct 2025 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxe5Fvpz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7D3090CE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377109; cv=none; b=lB/dFkOi+DAqPonOAU4lXWIZWJZnwanIpIgvcqA3kqG805z87Dih6u06yXw6mvj5IzVdbYEZDIhl1IDNnP2wWgNEXRta+OZnU1vj+ShB4sFPguIiglSBeXkft0k6SzJRunk/qtw30azw43RFzRYAFwJpxM01rEhnIv6N+Qh396k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377109; c=relaxed/simple;
	bh=aKz/MlcVVOtzLpyQSQNufpIknbJqZ/GiR55SFpA6mOA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wglt5Y9/EIaYn6mED8Y+JZjHmNJnn2qswmkxkY/0vK7Ra5elxUCdm+XgfmZVQ/SIW5utnvk7k7CBCX9H04qMQ0j/bZF1lWe46vke5oIQrqzRBHx/EPlKrmx44xpjNUaTtpi2gCppV0hJr3ZTI0vGq9/9oheFtpYwSg9EiR56xUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxe5Fvpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720DEC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377108;
	bh=aKz/MlcVVOtzLpyQSQNufpIknbJqZ/GiR55SFpA6mOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hxe5FvpzDbHbrYvEMBZcWwRUKKedkiOQnGld+9sUawLJLWcYJMr70pH64uiBaX/dS
	 t33bqOhP0JQMELyRukXzmzqjFX6co0y62eC576fFK5iJR80z1i5LAKF0xZksWhIWdc
	 5LawWlwY7Zj54SbgDXL+HaCdgUQdoGTCU209N4oBjmV6Cnm9Uvi8Z/aN5gZfgzZy+7
	 UQv2iTwWzhuoofz3SAHtIl7FoqCC7TOsNm9okJ+KdZJnFJw4arU9DDzhQ0/LP8x1KY
	 JTaCHT0vFvioOok+X33Zey19FLANefJZh3/clDZZcZ9u4rTF3AJbft0fiU0p6vJf91
	 IBjA/RMJIGyRw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: remove fs_info argument from __reserve_bytes()
Date: Mon, 13 Oct 2025 18:38:10 +0100
Message-ID: <4acc4886662013e7e01f0c3efb036b6f5bc213d9.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 39eba78ed422..d65b2e25d4b7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1703,7 +1703,6 @@ static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
 /*
  * Try to reserve bytes from the block_rsv's space.
  *
- * @fs_info:    the filesystem
  * @space_info: space info we want to allocate from
  * @orig_bytes: number of bytes we want
  * @flush:      whether or not we can flush to make our reservation
@@ -1715,10 +1714,10 @@ static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
  * regain reservations will be made and this will fail if there is not enough
  * space already.
  */
-static int __reserve_bytes(struct btrfs_fs_info *fs_info,
-			   struct btrfs_space_info *space_info, u64 orig_bytes,
+static int __reserve_bytes(struct btrfs_space_info *space_info, u64 orig_bytes,
 			   enum btrfs_reserve_flush_enum flush)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct work_struct *async_work;
 	struct reserve_ticket ticket;
 	u64 start_ns = 0;
@@ -1868,7 +1867,7 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 {
 	int ret;
 
-	ret = __reserve_bytes(fs_info, space_info, orig_bytes, flush);
+	ret = __reserve_bytes(space_info, orig_bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, orig_bytes, 1);
@@ -1900,7 +1899,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 	       flush == BTRFS_RESERVE_NO_FLUSH);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	ret = __reserve_bytes(fs_info, space_info, bytes, flush);
+	ret = __reserve_bytes(space_info, bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      space_info->flags, bytes, 1);
-- 
2.47.2


