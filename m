Return-Path: <linux-btrfs+bounces-17781-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01953BDAF0F
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 20:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A0A53531DB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 18:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1FA299931;
	Tue, 14 Oct 2025 18:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCnDdbqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E92296BBF
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466435; cv=none; b=PnkyjIJ8k8hYqQP1RLJCCWxNkiqDkwqS9+DwAw03KNY7KTA99rRbEaMDkxR9wzcVLY+kbyxiPwnkNZC29yNaRuAKQqNmlPcvMSxcEmQrBMfPla6uoaNnncnftS22VsTpmxOqGGs46xF22XggI6InbhJ7Fkz8Xy2BIk0FOhtfvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466435; c=relaxed/simple;
	bh=UmbDsHYUVMIsoP0VtKsYyB4Y9K+vU/geJgDosqX5cJc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gqS+M6lrCNyGjNx2hlplAHkzyxNrP+sA4R+PMOFDS69/vitFtpiGMPRs27Y6ryelr3pgUxRhrjfh70owKGY3XJ0ekHKzyX3T8fw9VHMMBNBqnzrpqTHEarJMjZKqpCcGBMnTN629xzqWKX5AnOQfCRqOwT+BUvSmNorE+UOiHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCnDdbqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB08CC4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Oct 2025 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466434;
	bh=UmbDsHYUVMIsoP0VtKsYyB4Y9K+vU/geJgDosqX5cJc=;
	h=From:To:Subject:Date:From;
	b=pCnDdbqeqmE2jrUYW38rELdCq+ZiOgM3Peiovijq47ShB2u0SG0ZM73KjCcaUI+6b
	 aK0oBIQRH+SqqhYqCvrRA68mMR4aVv+t5h71JwWnI9XP8sjxEMpUMiMnTirthY/8LQ
	 ayxxwvBJj5DUHZlsD7REkZFoqq+6H0rBF2HJDBoppcqOrsRhiwrUbWBkFU4dp+v0jp
	 M6bYhvS5FWR6KfygJhmDckOBZ1FanNgM+j8MU8YIm8qwwhqdPhMkK0Y1UeLRnagFsl
	 Fk9Rejw5nlcBRpGHD0z/R9XeFcs8eXhCdL9PvybC3lYTe/sPxNCfre2L4dotuMZ/W+
	 jxudoZbwvPJRQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()
Date: Tue, 14 Oct 2025 19:27:09 +0100
Message-ID: <fad79c0ae3452237308c7de09c6d96a524ca4857.1760466409.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/zoned.c       | 4 ++--
 fs/btrfs/zoned.h       | 6 ++----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d7451400cc22..ec1e4fc0cd51 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3071,7 +3071,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+	ret = btrfs_zoned_activate_one_bg(space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -4339,7 +4339,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(fs_info, info, true);
+			ret = btrfs_zoned_activate_one_bg(info, true);
 			if (ret < 0)
 				return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0ea0df18a8e4..31cfac5cfe78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2754,10 +2754,10 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return ret < 0 ? ret : 1;
 }
 
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info,
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info,
 				bool do_finish)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_block_group *bg;
 	int index;
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 17c5656580dd..d64f7c9255fa 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -94,8 +94,7 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info, bool do_finish);
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num_bytes);
 #else /* CONFIG_BLK_DEV_ZONED */
@@ -262,8 +261,7 @@ static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return 1;
 }
 
-static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-					      struct btrfs_space_info *space_info,
+static inline int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info,
 					      bool do_finish)
 {
 	/* Consider all the block groups are active */
-- 
2.47.2


