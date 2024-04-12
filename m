Return-Path: <linux-btrfs+bounces-4192-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 970F88A31C4
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FA1B26063
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A01482F3;
	Fri, 12 Apr 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/dLZZdh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF7148301
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934207; cv=none; b=UVr8omWQtOMAFi8+cT/3LiUrxzHnscHsCybEjT2JxmK5V94IUwNtrzX+mhOcfknZdnjxZy3XrmsXTheH9fEXiwNq15DNSuikqZ7MyA2Yo+D4r0J95X3D3i8phrePIy2fN2JtVbrSPXIzdJASZx6Cacl4DfchnTK6YivxyDR685M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934207; c=relaxed/simple;
	bh=L1t3oV64TAPzIEmjZCLUcCiGTWRRY93I3arHq2o4Co4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwqJkZMpiHe20sWO2yLuH1fFm9A7wAyUda8uCFJCoHpVeoYmCqDXGgbL4fUGXxrFkwhpe125YpLldoFOSKDO+l7BRgYVEEBMd2q4X2Vf4WSaJkO8qw/3tG6mc5hoDA67HGAmz4YOSs+4RxYaJ2ZiniVN+daiTfxeE0eh8TVI1mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/dLZZdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4EDC3277B
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934207;
	bh=L1t3oV64TAPzIEmjZCLUcCiGTWRRY93I3arHq2o4Co4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e/dLZZdhzYtFh36BUgwEirD3bjKQo016+Pf5Rp5cTsNndIoREtq5y38PjxfahLUmg
	 9ixAWX+FnV+cdrO+zu4p1HJg0BM48O3tUwRNgJSQQZLLs6lORMQgKcTGamu8rQAHaJ
	 58ytyLwMVMn5ARG1/DGeM09nDMuTaTpRYHW5RRHvNZCVWRlk035w957p2DagSvtyln
	 nRVMg1WhZWLpeM0VvaPophqu7dJEkr/rO/3udlK/LeBpd1b72GmfK2IBZKZDKeIydJ
	 tDqPOks+wptapaWYygsUkJOBC+T3P5nguyT86KUt+wjBe83ZwTo2N6xjLLqtn3ElWy
	 COWZgQbj/aMZg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: remove search_commit parameter from btrfs_lookup_csums_list()
Date: Fri, 12 Apr 2024 16:03:16 +0100
Message-Id: <8f31c8dcf6d09d42079b9bb4164a87450d2f0adf.1712933005.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All the callers of btrfs_lookup_csums_list() pass a value of 0 as the
"search_commit" parameter. So remove it and make the function behave as
to always search from the regular root.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c  | 10 +---------
 fs/btrfs/file-item.h  |  3 +--
 fs/btrfs/inode.c      |  2 +-
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/tree-log.c   |  6 +++---
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 909438540119..0712a0aa2dd0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -457,15 +457,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
  * @start:		Logical address of target checksum range.
  * @end:		End offset (inclusive) of the target checksum range.
  * @list:		List for adding each checksum that was found.
- * @search_commit:	Indicate if the commit root of the @root should be used
- *			for the search.
  * @nowait:		Indicate if the search must be non-blocking or not.
  *
  * Return < 0 on error and 0 on success.
  */
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
-			    struct list_head *list, int search_commit,
-			    bool nowait)
+			    struct list_head *list, bool nowait)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_key key;
@@ -484,11 +481,6 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 		return -ENOMEM;
 
 	path->nowait = nowait;
-	if (search_commit) {
-		path->skip_locking = 1;
-		path->reada = READA_FORWARD;
-		path->search_commit_root = 1;
-	}
 
 	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
 	key.offset = start;
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 15c05cc0fce6..557dc43d7142 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -68,8 +68,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
 			     bool nowait);
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
-			    struct list_head *list, int search_commit,
-			    bool nowait);
+			    struct list_head *list, bool nowait);
 int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
 			      u64 start, u64 end, u8 *csum_buf,
 			      unsigned long *csum_bitmap);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2dae4e975e80..4e67470d847a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1746,7 +1746,7 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 	LIST_HEAD(list);
 
 	ret = btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes - 1,
-				      &list, 0, nowait);
+				      &list, nowait);
 	if (ret == 0 && list_empty(&list))
 		return 0;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5b19b41f64a2..4e60364b5289 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4391,7 +4391,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 
 	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 				      disk_bytenr + ordered->num_bytes - 1,
-				      &list, 0, false);
+				      &list, false);
 	if (ret)
 		return ret;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4a4fca841510..e9ad2971fc7c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -797,7 +797,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 
 			ret = btrfs_lookup_csums_list(root->log_root,
 						csum_start, csum_end - 1,
-						&ordered_sums, 0, false);
+						&ordered_sums, false);
 			if (ret)
 				goto out;
 			/*
@@ -4460,7 +4460,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		disk_bytenr += extent_offset;
 		ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 					      disk_bytenr + extent_num_bytes - 1,
-					      &ordered_sums, 0, false);
+					      &ordered_sums, false);
 		if (ret)
 			goto out;
 
@@ -4655,7 +4655,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	csum_root = btrfs_csum_root(trans->fs_info, em->block_start);
 	ret = btrfs_lookup_csums_list(csum_root, em->block_start + csum_offset,
 				      em->block_start + csum_offset +
-				      csum_len - 1, &ordered_sums, 0, false);
+				      csum_len - 1, &ordered_sums, false);
 	if (ret)
 		return ret;
 
-- 
2.43.0


