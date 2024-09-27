Return-Path: <linux-btrfs+bounces-8301-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1936A9882FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 13:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF61D285506
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00360188CA8;
	Fri, 27 Sep 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkHrQlRQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFEA39AD6
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435039; cv=none; b=q7R8sgQGtqHr89W7mvENLa+Fw8910f8nl4FvoNoV6LnFgXakZuhDyKvKjlhq829DEbtXLIedlGFGSZLPybY+dfUhb8+HTmfDT2G0qt2zO234ZS3Wbcu77n1aD/IT98kWfrVP/1WrKXdPTC6oJxLsGXxy8m/g3UzSctDsLKj1+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435039; c=relaxed/simple;
	bh=RlRqvZo+jsxPJdk81Msv9eybTQ5a6ogGGg7xo5xnakU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/BltNle4Y+zY4XS7VVbNCH6HqC/8/CoXwb54jZMVxzf9LhP4B+IwAOqxSNJA1sRPcuAuBGGmS058D+urerdHcCiMLzhtYk7H6+pFwO+zJngpHYOnze4yB2VDIHNUgYNRoJoqtRfRYPLM2KMIwUGZZF1SxBrc7h8PGSbK+XOvgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkHrQlRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAD3C4CEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727435038;
	bh=RlRqvZo+jsxPJdk81Msv9eybTQ5a6ogGGg7xo5xnakU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rkHrQlRQnT9NoOE+9F1OuBfWudnZN2Uw26NA7ejYkBOgkNcGPWF6RsCO5acMcvsRC
	 MDKFzEjT4ucQ9S7mF6TeExBT1k2js226IhXv+/y1ZDkmxtbdDSeePL0bS1y6KBcttl
	 6MikfHlDIAmbU7GdtsLQPcJcQl9B6bqI81uDG9CGvySKHdFzlKakRu34Ctj093xWt0
	 QRMLYKChjm4a2BUM3hYJPsoDQnzPWlmCiBxvWZ2HOdXmjg7Yts7tL4LgXzEPoEoqkt
	 Eod880cNJm2C/o0NI7IcX1h69mOEsDFwmCzathzBDw7Kvf4FX8AHTaStC+ZxdDTzcq
	 HeVUKemBa6MEg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: send: fix invalid clone operation for file that got its size decreased
Date: Fri, 27 Sep 2024 12:03:55 +0100
Message-Id: <794af660cbd6c6fc417a683bfc914bbf9fb34ab0.1727434488.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
References: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During an incremental send we may end up sending an invalid clone
operation, for the last extent of a file which ends at an unaligned offset
that matches the final i_size of the file in the send snapshot, in case
the file had its initial size (the size in the parent snapshot) decreased
in the send snapshot. In this case the destination will fail to apply the
clone operation because its end offset is not sector size aligned and it
ends before the current size of the file.

Sending the truncate operation always happens when we finish processing an
inode, after we process all its extents (and xattrs, names, etc). So fix
this by ensuring the file has a valid size before we send a clone
operation for an unaligned extent that ends at the final i_size of the
file. The size we truncate to matches the start offset of the clone range
but it could be any value between that start offset and the final size of
the file since the clone operation will expand the i_size if the current
size is smaller than the end offset. The start offset of the range was
chosen because it's always sector size aligned and avoids a truncation
into the middle of a page, which results in dirtying the page due to
filling part of it with zeroes and then making the clone operation at the
receiver trigger IO.

The following test reproduces the issue:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/sdi
  MNT=/mnt/sdi

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  # Create a file with a size of 256K + 5 bytes, having two extents, one
  # with a size of 128K and another one with a size of 128K + 5 bytes.
  last_ext_size=$((128 * 1024 + 5))
  xfs_io -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
         -c "pwrite -S 0xcd -b $last_ext_size 128K $last_ext_size" \
         $MNT/foo

  # Another file which we will later clone foo into, but initially with
  # a larger size than foo.
  xfs_io -f -c "pwrite -S 0xef 0 1M" $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap1

  # Now resize bar and clone foo into it.
  xfs_io -c "truncate 0" \
         -c "reflink $MNT/foo" $MNT/bar

  btrfs subvolume snapshot -r $MNT/ $MNT/snap2

  rm -f /tmp/send-full /tmp/send-inc
  btrfs send -f /tmp/send-full $MNT/snap1
  btrfs send -p $MNT/snap1 -f /tmp/send-inc $MNT/snap2

  umount $MNT
  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  btrfs receive -f /tmp/send-full $MNT
  btrfs receive -f /tmp/send-inc $MNT

  umount $MNT

Running it before this patch:

  $ ./test.sh
  (...)
  At subvol snap1
  At snapshot snap2
  ERROR: failed to clone extents to bar: Invalid argument

A test case for fstests will be sent soon.

Reported-by: Ben Millwood <thebenmachine@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com/
Fixes: 46a6e10a1ab1 ("btrfs: send: allow cloning non-aligned extent if it ends at i_size")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5871ca845b0e..27306d98ec43 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6189,8 +6189,29 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
-	if (clone_root->offset + num_bytes == info.size)
+	if (clone_root->offset + num_bytes == info.size) {
+		/*
+		 * The final size of our file matches the end offset, but it may
+		 * be that its current size is larger, so we have to truncate it
+		 * to any value between the start offset of the range and the
+		 * final i_size, otherwise the clone operation is invalid
+		 * because it's unaligned and it ends before the current EOF.
+		 * We do this truncate to the final i_size when we finish
+		 * processing the inode, but it's too late by then. And here we
+		 * truncate to the start offset of the range because it's always
+		 * sector size aligned while if it were the final i_size it
+		 * would result in dirtying part of a page, filling part of a
+		 * page with zeroes and then having the clone operation at the
+		 * receiver trigger IO and wait for it due to the dirty page.
+		 */
+		if (sctx->parent_root != NULL) {
+			ret = send_truncate(sctx, sctx->cur_ino,
+					    sctx->cur_inode_gen, offset);
+			if (ret < 0)
+				return ret;
+		}
 		goto clone_data;
+	}
 
 write_data:
 	ret = send_extent_data(sctx, path, offset, num_bytes);
-- 
2.43.0


