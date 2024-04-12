Return-Path: <linux-btrfs+bounces-4195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD338A31C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D729B2615A
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2381487F1;
	Fri, 12 Apr 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGWn89+W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A7B1487E1
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934210; cv=none; b=iHBLg8DpezLm5PahuVdB4n6T0msYf16FEKH7H2lFGqWO1/P62MJIfttXd3jmtOJY8IzKQZNuIM71u4Rxn3erM2IBG+bY+F9yTs4cYDF4YHk8pO1Ue66OuX21eHa3s9Xv2/PcFy5O0xilFQf+PTyA10xQlOY3ZKltwlO3yxB/ovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934210; c=relaxed/simple;
	bh=zVzzwZ3NRXLcsttMmnWWYjJtOd2PcijnYFsnwjwy5nc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dymM3woRg/o81Jo7es604eGNKqtfVPVcJtb2aE93hXA9JLosvpOY+6yElsjI7AFUOLnD26O3nBwMa5LZqrZgX6LGZf3GY0ic2jtTVJamkrL6QUSnLD3anwEiyX0Ydl7VKOkNjqZg7i3BwIcAnSVySRzcQr90ghUmjJBJS3QWFgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGWn89+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E47C2BBFC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934210;
	bh=zVzzwZ3NRXLcsttMmnWWYjJtOd2PcijnYFsnwjwy5nc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MGWn89+WEuDtNG4H9E7dr4qHVpC0VXIb/S8HhnVVtJmkarf2uAR2t7coHuhP0BU16
	 0eyJ1QYYZ40/Zvq4WFhFXJiEGpEG64P/ZEo0JqB7kk3sE8lAN2TwGZATWA0CgfigdB
	 8Yre5ISdvlK4N7ff0f3UR6HMuGdwyHcmQFXkL1bKED5gpvfT6OcPvkcWEgR/K8Sm9g
	 wcnDjMM4dy7r14HbnZsylO8zKtiu+2L3za4B31Gx43Cn+8SwnsIcnX8Mn+QMxQIvAo
	 +wCVVypu+Znk59XMni25Pbdz4ePyJ0JF7o5/y1A4zKiuhhKXaDgnjTTNYYf/YjN9bv
	 fyG0887Tbbx2A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: make NOCOW checks for existence of checksums in a range more efficient
Date: Fri, 12 Apr 2024 16:03:19 +0100
Message-Id: <72cd9b16a1c670d4139bb10f6f13eb76f92c3fed.1712933006.git.fdmanana@suse.com>
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

Before deciding if we can do a NOCOW write into a range, one of the things
we have to do is check if there are checksum items for that range. We do
that through the btrfs_lookup_csums_list() function, which searches for
checksums and adds them to a list supplied by the caller.

But all we need is to check if there is any checksum, we don't need to
look for all of them and collect them into a list, which requires more
search time in the checksums tree, allocating memory for checksums items
to add to the list, copy checksums from a leaf into those list items,
then free that memory, etc. This is all unnecessary overhead, wasting
mostly CPU time, and perhaps some occasional IO if we need to read from
disk any extent buffers.

So change btrfs_lookup_csums_list() to allow to return immediately in
case it finds any checksum, without the need to add it to a list and read
it from a leaf. This is accomplised by allowing a NULL list parameter and
making the function return 1 if it found any checksum, 0 if it didn't
found any, and a negative value in case of an error.

The following test with fio was used to measure performance:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0

  cat <<EOF > /tmp/fio-job.ini
  [global]
  name=fio-rand-write
  filename=$MNT/fio-rand-write
  rw=randwrite
  bssplit=4k/20:8k/20:16k/20:32k/20:64k/20
  direct=1
  numjobs=16
  fallocate=posix
  time_based
  runtime=300

  [file1]
  size=8G
  ioengine=io_uring
  iodepth=16
  EOF

  umount $MNT &> /dev/null
  mkfs.btrfs -f $DEV
  mount -o ssd $DEV $MNT

  fio /tmp/fio-job.ini
  umount $MNT

The test was run on a release kernel (Debian's default kernel config).

The results before this patch:

  WRITE: bw=139MiB/s (146MB/s), 8204KiB/s-9504KiB/s (8401kB/s-9732kB/s), io=17.0GiB (18.3GB), run=125317-125344msec

The results after this patch:

  WRITE: bw=153MiB/s (160MB/s), 9241KiB/s-10.0MiB/s (9463kB/s-10.5MB/s), io=17.0GiB (18.3GB), run=114054-114071msec

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file-item.c  | 25 ++++++++++++++++++-------
 fs/btrfs/inode.c      | 18 ++----------------
 fs/btrfs/relocation.c |  2 +-
 fs/btrfs/tree-log.c   |  9 ++++++---
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 231abcc87f63..1ea1ed44fe42 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -457,9 +457,12 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
  * @start:		Logical address of target checksum range.
  * @end:		End offset (inclusive) of the target checksum range.
  * @list:		List for adding each checksum that was found.
+ *			Can be NULL in case the caller only wants to check if
+ *			there any checksums for the range.
  * @nowait:		Indicate if the search must be non-blocking or not.
  *
- * Return < 0 on error and 0 on success.
+ * Return < 0 on error, 0 if no checksums were found, or 1 if checksums were
+ * found.
  */
 int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			    struct list_head *list, bool nowait)
@@ -471,6 +474,7 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_csum_item *item;
 	int ret;
+	bool found_csums = false;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(end + 1, fs_info->sectorsize));
@@ -544,6 +548,10 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 			continue;
 		}
 
+		found_csums = true;
+		if (!list)
+			goto out;
+
 		csum_end = min(csum_end, end + 1);
 		item = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				      struct btrfs_csum_item);
@@ -575,17 +583,20 @@ int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 end,
 		}
 		path->slots[0]++;
 	}
-	ret = 0;
 out:
+	btrfs_free_path(path);
 	if (ret < 0) {
-		struct btrfs_ordered_sum *tmp_sums;
+		if (list) {
+			struct btrfs_ordered_sum *tmp_sums;
 
-		list_for_each_entry_safe(sums, tmp_sums, list, list)
-			kfree(sums);
+			list_for_each_entry_safe(sums, tmp_sums, list, list)
+				kfree(sums);
+		}
+
+		return ret;
 	}
 
-	btrfs_free_path(path);
-	return ret;
+	return found_csums ? 1 : 0;
 }
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4e67470d847a..1d78e07d082b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1741,23 +1741,9 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes, bool nowait)
 {
 	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bytenr);
-	struct btrfs_ordered_sum *sums;
-	int ret;
-	LIST_HEAD(list);
-
-	ret = btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes - 1,
-				      &list, nowait);
-	if (ret == 0 && list_empty(&list))
-		return 0;
 
-	while (!list_empty(&list)) {
-		sums = list_entry(list.next, struct btrfs_ordered_sum, list);
-		list_del(&sums->list);
-		kfree(sums);
-	}
-	if (ret < 0)
-		return ret;
-	return 1;
+	return btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes - 1,
+				       NULL, nowait);
 }
 
 static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4e60364b5289..5a01aaa164de 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4392,7 +4392,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 	ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 				      disk_bytenr + ordered->num_bytes - 1,
 				      &list, false);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	while (!list_empty(&list)) {
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e9ad2971fc7c..3c86fcebafc6 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -798,8 +798,9 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			ret = btrfs_lookup_csums_list(root->log_root,
 						csum_start, csum_end - 1,
 						&ordered_sums, false);
-			if (ret)
+			if (ret < 0)
 				goto out;
+			ret = 0;
 			/*
 			 * Now delete all existing cums in the csum root that
 			 * cover our range. We do this because we can have an
@@ -4461,8 +4462,9 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 		ret = btrfs_lookup_csums_list(csum_root, disk_bytenr,
 					      disk_bytenr + extent_num_bytes - 1,
 					      &ordered_sums, false);
-		if (ret)
+		if (ret < 0)
 			goto out;
+		ret = 0;
 
 		list_for_each_entry_safe(sums, sums_next, &ordered_sums, list) {
 			if (!ret)
@@ -4656,8 +4658,9 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	ret = btrfs_lookup_csums_list(csum_root, em->block_start + csum_offset,
 				      em->block_start + csum_offset +
 				      csum_len - 1, &ordered_sums, false);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	ret = 0;
 
 	while (!list_empty(&ordered_sums)) {
 		struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
-- 
2.43.0


