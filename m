Return-Path: <linux-btrfs+bounces-10416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C99C9F3753
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189E31620E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C878207A08;
	Mon, 16 Dec 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDyat6Om"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382E207675
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369452; cv=none; b=QQvCf6KcUevGg11RSXEhquDsP+tK9qWXE2xtY0eY48MYp5cfFcdPcQlKL7tDl3HQuNxEuBLl1LAtsQa+qGk44klIjxPk4KdKJ+2SsAota7vOGo2EFFG+jXjCX1S5EiS2De8Y9bR5zmUf7they3dyMLamMUdJjk66kSxiUN/TPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369452; c=relaxed/simple;
	bh=OL1tO4DaYfFI4YjRiNM8vW+MNQ6TNq9bMwLKKx2xOPA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pIWuPkb4JpHzkNGyB2ekcUOOhHYq1W3cDcwDGnfmDRZCYI6I6Q9W5ZqNk42k6JKyCC0vIoV0n4eHLR4b5H9OHWpsFGCvT1Tev5/G9UkLict6hcGcJWvHuQJU4yqSc26LkekWiVUyPDW6U3mq/6cD7doFRMrFVoAiEBkJhJ+NUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDyat6Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14342C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369452;
	bh=OL1tO4DaYfFI4YjRiNM8vW+MNQ6TNq9bMwLKKx2xOPA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NDyat6Omn5jE7rmMhTi2DMzJ73S4Y30V1BQj0iFTY1zkQkro5zDhHFbOudx9bPL33
	 V9RHLt2t9wm7E3OXhC8d6TTConVqHEqOnbk+7lwOIOQs1ILONrpddghkLiD5fX36EV
	 VE3ppdRWRaiVFNSX2VQh2+ylXY1qG1e/NN1gsI6SkLD1Y2GKE1HIYAc9Hu5XJYfjYO
	 iZZIsWVx8dVvCQ2I0H+GpljXAzwBHOV10oee7YtE4TJgvWZplE83LWhBxdeK/13yaV
	 ef7uFtJ+YateX0g8L+1j59idq6DV+5/LtcWH4ZGRpy+Ox7mIaIr8G7H2kNqmg3gTv7
	 3T9xpSGtgRk6A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs: move the folio ordered helpers from ctree.h into fs.h
Date: Mon, 16 Dec 2024 17:17:20 +0000
Message-Id: <730791a450c2fcee923609f85b9d2cb303aebcac.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The folio ordered helper macros are defined at ctree.h but this is not
the best place since ctree.{h,c} is all about the btree data structure
implementation and not a generic module. So move these macros into the
fs.h header.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 8 --------
 fs/btrfs/fs.h    | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a1bab0b3f193..3d9855d30057 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -756,12 +756,4 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
-/*
- * We use folio flag owner_2 to indicate there is an ordered extent with
- * unfinished IO.
- */
-#define folio_test_ordered(folio)	folio_test_owner_2(folio)
-#define folio_set_ordered(folio)	folio_set_owner_2(folio)
-#define folio_clear_ordered(folio)	folio_clear_owner_2(folio)
-
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 15c26c6f4d6e..7a27f5fe9bc2 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1066,6 +1066,14 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 	(unlikely(test_bit(BTRFS_FS_STATE_LOG_CLEANUP_ERROR,		\
 			   &(fs_info)->fs_state)))
 
+/*
+ * We use folio flag owner_2 to indicate there is an ordered extent with
+ * unfinished IO.
+ */
+#define folio_test_ordered(folio)	folio_test_owner_2(folio)
+#define folio_set_ordered(folio)	folio_set_owner_2(folio)
+#define folio_clear_ordered(folio)	folio_clear_owner_2(folio)
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 
 #define EXPORT_FOR_TESTS
-- 
2.45.2


