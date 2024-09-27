Return-Path: <linux-btrfs+bounces-8292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A160A988268
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545FA1C22AD7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3408A1BC06E;
	Fri, 27 Sep 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9TlJBhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC119FA66
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432760; cv=none; b=MEcZBcupSAdJszLAQDcPpGEAsauEdEuxin8bjBhMneTix60c7HYpur5I3mn9v3Fg8UxBROwP43nj+DyYyobrcHMb56j4KMVZy3N/XIXHjalRHDTNXTs41vqZzMBgk08st5LJuFZBW/ndH3yn4c05E1SNng1rvdL4HHQ1dwAJDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432760; c=relaxed/simple;
	bh=dYFD/UNQWv/9kR1D3Wpfuy66ik+DB/LrjxDHepQUwFk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=HesnWXDWgY0OG+jh926oceT2wk/gpHZtSD8pVckRqkDiBMncGjdrRb0D/HgMG9lyfW0CIcuMPUTW7yRT7JL6QMXGdkerfQr4afI3Ba3I84mIytdD2GkKc+Bh81qp/nzVw9X8kW8CthOvCqxRAalA/opbGeMNcRgwsxlCWcZW7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9TlJBhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A1C4CEC4
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727432759;
	bh=dYFD/UNQWv/9kR1D3Wpfuy66ik+DB/LrjxDHepQUwFk=;
	h=From:To:Subject:Date:From;
	b=u9TlJBhnEr49AnNQ5xgm/0lHO+SOE4MDIlSCjjQfA9PeBF9nxm3YoAsKtuH4jzUg4
	 NpS/717A24CzCOSXyT/c8im6b4JdQLUHg0aFd+YfVKp1AyhoL/q+woKIiBIz7zxE/f
	 huBl2iHq0rxArkJ6GG31cfQhCvE210SL5w3uFvnEeVJOn7ERKmpFvr6sZrdGS+9q0+
	 wCOENiPyXMtuDfFzAdCURXefnE8RkkpDiSo4lcRWVjD3oLcIDPTaLMaVMH3gZV/EPy
	 P2q5K4Kis5Dz4n/szcKoFB0Lieb72iuHI37NOjZLKVgRJDVBvsjXs0r+nbesjRt21y
	 IKglMJBqZk13Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix invalid clone operation for file that got its size decreased
Date: Fri, 27 Sep 2024 11:25:56 +0100
Message-Id: <5a406a607fcccec01684056ab011ff0742f06439.1727432566.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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
this by ensuring the file has the correct size before we send a clone
operation for an unaligned extent that ends at the final i_size of the file.

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
 fs/btrfs/send.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5871ca845b0e..3ee27840a95a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -6189,8 +6189,25 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		return ret;
 
-	if (clone_root->offset + num_bytes == info.size)
+	if (clone_root->offset + num_bytes == info.size) {
+		/*
+		 * The final size of our file matches the end offset, but it may
+		 * be that its current size is larger, so we have to truncate it
+		 * to that size (or to the start offset of the extent) otherwise
+		 * the clone operation is invalid because it's unaligned and it
+		 * ends before the current EOF.
+		 * We do this truncate when we finish processing the inode, but
+		 * it's too late by then, so we must do it now.
+		 */
+		if (sctx->parent_root != NULL) {
+			ret = send_truncate(sctx, sctx->cur_ino,
+					    sctx->cur_inode_gen,
+					    sctx->cur_inode_size);
+			if (ret < 0)
+				return ret;
+		}
 		goto clone_data;
+	}
 
 write_data:
 	ret = send_extent_data(sctx, path, offset, num_bytes);
-- 
2.43.0


