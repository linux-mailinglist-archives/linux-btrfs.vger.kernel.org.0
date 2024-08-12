Return-Path: <linux-btrfs+bounces-7124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B2494EEBC
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256C8283433
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB78917D36A;
	Mon, 12 Aug 2024 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9N+zNLJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7617C9E3
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470638; cv=none; b=W7Vpwsm9b4D1RI6e8eV73Y4HTOnKAqp94RLfcDy/zlxglF8Jd0GwIcNemg29u8pzAk/zZo+T1fAJc7gLaGpDcSCfxUTpX30eQQsQQCnSbb81j7ax0al+vABG/VpR8pHmPcCkZPt3LpiMPtK2Fhc1PKc3ynDjyCiIaj4DmnQ5K34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470638; c=relaxed/simple;
	bh=m1TWr28pwN28J/9e7yTdFU9+9kofJSi0XpL6iy28XBM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZHGxSgAt2jMCSnT0d38p3b73Zj9MC/oyGetrfLcuuJYDxRO1uiY4vdOQZD4ZaeCW3cSQa44KlNKG94p8nzPVv9B/x4/S1ZG9MdgLrD5ORrX21tB6PkW151U1PBBUOupsnALlJsZvfOnPRSwC+cu6W2dANPJOjR2lld/vRtjqDpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9N+zNLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C658DC32782
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2024 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470638;
	bh=m1TWr28pwN28J/9e7yTdFU9+9kofJSi0XpL6iy28XBM=;
	h=From:To:Subject:Date:From;
	b=P9N+zNLJcvRF7F1KQDNR2bIhqrUcqbJf6+3tRR7EIDrRpPW5UGZ22Zfoob1nHtwre
	 cAdOQlxBaORUFmtVv4Aa2/mGZB/hoEKFwrb4u22kYHl/yqwftsfK/ct8A+fgHgx74X
	 EINAJpEyIdTcyMsJAjUFt/T8vKZDKiJ11kIygVpzTL04X7TLtOc4QqIBIEkqwJiz1g
	 X1LUCYusmQcYsaoegDHB6O2h6l5tsCywypaYRySUq0SKNZ4JN81/I0tkUuWfwRNQid
	 SLzEWLPjttoQpilyRz4dbR2Fwvq23KXCTfYRhM0PFsL3+oet6u6WZJtl15DezDcUb5
	 iq/EJ38QJ5Hmw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: allow cloning non-aligned extent if it ends at i_size
Date: Mon, 12 Aug 2024 14:50:34 +0100
Message-Id: <e764923c5a0bca3cdf90199da34747b38094a390.1723469840.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we a find that an extent is shared but its end offset is not sector
size aligned, then we don't clone it and issue write operations instead.
This is because the reflink (remap_file_range) operation does not allow
to clone unaligned ranges, except if the end offset of the range matches
the i_size of the source and destination files (and the start offset is
sector size aligned).

While this is not incorrect because send can only guarantee that a file
has the same data in the source and destination snapshots, it's not
optimal and generates confusion and surprising behaviour for users.

For example, running this test:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  # Use a file size not aligned to any possible sector size.
  file_size=$((1 * 1024 * 1024 + 5)) # 1MB + 5 bytes
  dd if=/dev/random of=$MNT/foo bs=$file_size count=1
  cp --reflink=always $MNT/foo $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap
  rm -f /tmp/send-test
  btrfs send -f /tmp/send-test $MNT/snap

  umount $MNT
  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  btrfs receive -vv -f /tmp/send-test $MNT

  xfs_io -r -c "fiemap -v" $MNT/snap/bar

  umount $MNT

Gives the following result:

  (...)
  mkfile o258-7-0
  rename o258-7-0 -> bar
  write bar - offset=0 length=49152
  write bar - offset=49152 length=49152
  write bar - offset=98304 length=49152
  write bar - offset=147456 length=49152
  write bar - offset=196608 length=49152
  write bar - offset=245760 length=49152
  write bar - offset=294912 length=49152
  write bar - offset=344064 length=49152
  write bar - offset=393216 length=49152
  write bar - offset=442368 length=49152
  write bar - offset=491520 length=49152
  write bar - offset=540672 length=49152
  write bar - offset=589824 length=49152
  write bar - offset=638976 length=49152
  write bar - offset=688128 length=49152
  write bar - offset=737280 length=49152
  write bar - offset=786432 length=49152
  write bar - offset=835584 length=49152
  write bar - offset=884736 length=49152
  write bar - offset=933888 length=49152
  write bar - offset=983040 length=49152
  write bar - offset=1032192 length=16389
  chown bar - uid=0, gid=0
  chmod bar - mode=0644
  utimes bar
  utimes
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=06d640da-9ca1-604c-b87c-3375175a8eb3, stransid=7
  /mnt/sdi/snap/bar:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..2055]:       26624..28679      2056   0x1

There's no clone operation to clone extents from the file foo into file
bar and fiemap confirms there's no shared flag (0x2000).

So update send_write_or_clone() so that it proceeds with cloning if the
source and destination ranges end at the i_size of the respective files.

After this changes the result of the test is:

  (...)
  mkfile o258-7-0
  rename o258-7-0 -> bar
  clone bar - source=foo source offset=0 offset=0 length=1048581
  chown bar - uid=0, gid=0
  chmod bar - mode=0644
  utimes bar
  utimes
  BTRFS_IOC_SET_RECEIVED_SUBVOL uuid=582420f3-ea7d-564e-bbe5-ce440d622190, stransid=7
  /mnt/sdi/snap/bar:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..2055]:       26624..28679      2056 0x2001

A test case for fstests will also follow up soon.

Link: https://github.com/kdave/btrfs-progs/issues/572#issuecomment-2282841416
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 52 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 4ca711a773ef..7fc692fc76e1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6157,25 +6157,51 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	u64 offset = key->offset;
 	u64 end;
 	u64 bs = sctx->send_root->fs_info->sectorsize;
+	struct btrfs_file_extent_item *ei;
+	u64 disk_byte;
+	u64 data_offset;
+	u64 num_bytes;
+	struct btrfs_inode_info info = { 0 };
 
 	end = min_t(u64, btrfs_file_extent_end(path), sctx->cur_inode_size);
 	if (offset >= end)
 		return 0;
 
-	if (clone_root && IS_ALIGNED(end, bs)) {
-		struct btrfs_file_extent_item *ei;
-		u64 disk_byte;
-		u64 data_offset;
+	num_bytes = end - offset;
 
-		ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
-				    struct btrfs_file_extent_item);
-		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
-		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
-		ret = clone_range(sctx, path, clone_root, disk_byte,
-				  data_offset, offset, end - offset);
-	} else {
-		ret = send_extent_data(sctx, path, offset, end - offset);
-	}
+	if (!clone_root)
+		goto write_data;
+
+	if (IS_ALIGNED(end, bs))
+		goto clone_data;
+
+	/*
+	 * If the extent end is not aligned, we can clone if the extent ends at
+	 * the i_size of the inode and the clone range ends at the i_size of the
+	 * source inode, otherwise the clone operation fails with -EINVAL.
+	 */
+	if (end != sctx->cur_inode_size)
+		goto write_data;
+
+	ret = get_inode_info(clone_root->root, clone_root->ino, &info);
+	if (ret < 0)
+		return ret;
+
+	if (clone_root->offset + num_bytes == info.size)
+		goto clone_data;
+
+write_data:
+	ret = send_extent_data(sctx, path, offset, num_bytes);
+	sctx->cur_inode_next_write_offset = end;
+	return ret;
+
+clone_data:
+	ei = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
+	data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
+	ret = clone_range(sctx, path, clone_root, disk_byte, data_offset, offset,
+			  num_bytes);
 	sctx->cur_inode_next_write_offset = end;
 	return ret;
 }
-- 
2.43.0


