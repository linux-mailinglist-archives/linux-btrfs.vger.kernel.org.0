Return-Path: <linux-btrfs+bounces-12422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A59A68C8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5F2717FE85
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BE7255E38;
	Wed, 19 Mar 2025 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdYYXYvw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF41255229;
	Wed, 19 Mar 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386416; cv=none; b=ZFEddpPy+6313pgHvtukzWfzKdykZFumI4JmL1e2zQDxmsz9sMpZXjpme72bPS0N1oZorFHEYVxe16dAs4SPW6jtWQsk21MIrk/4bZmp7oS676TcZnPpNrnyGNSDr9vnq0LyagjHsE9CxIfjgSMI0nwmJo4Wy7GbKbZM2dyBFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386416; c=relaxed/simple;
	bh=tKvjDXay4kDdnP2nTDaxUlvCdTkuZ24dO+VQ4nktrsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NdiPqVRSetauET8yDK6tRT3U9JrHwoGV+AsEjZzoGUmjBaK+GRC6DFFYXO5RZpqQ4Ti0pxpW/sd5uMcBfeE4Fw1+g5dswa5EmTmmtxy6idLejAyi72Me96RvG0uxRkeRLcr8u1+xINazVrx8VHFNRcyrEkfccnHNObvLfXro0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdYYXYvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E91C4CEE9;
	Wed, 19 Mar 2025 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742386416;
	bh=tKvjDXay4kDdnP2nTDaxUlvCdTkuZ24dO+VQ4nktrsE=;
	h=From:To:Cc:Subject:Date:From;
	b=qdYYXYvwzAHv8uAXcUC0H3kv5NlxYAlgAhUYqIH4v2TksuidHP1BKDhFtDMmNEk/l
	 gRy4ek5r3IoNga0pmenuAWF4eusjk1g3bc+ZdmHWAO0eHyLuaT6gZvXkJFtSma98Nu
	 jh+SWvX65NWk9s4UxKdiahCJQVhHtVanaDxPJV+M3YDa1MUlVlBgbAc1hMzKt2V5wz
	 +zFMb3z1Da6bKqG6EW+FYtHFDQ2K3zuPqv43/V9TSUtCiTf2ZSjfFqdacMa6MzqUhT
	 vQKLZ3+p6KA8QTDb2p6+mUvo8tqMuoUq5zUe585mEu5k1Ud+jo5guNo6+vd6ei0FGN
	 rHlnSt47yqu7w==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/058: fix test to actually have an open tmpfile during the send operation
Date: Wed, 19 Mar 2025 12:13:28 +0000
Message-ID: <f2f3902ab7603f82751a9729cc8f1b406c5cbf98.1742386250.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test's goal is to exercise a send operation while there's a tmpfile in
the snapshot, but that doesn't happen since the background xfs_io process
that created the tmpfile ends up exiting before we create the snapshot, so
the snapshot nevers gets a tmpfile.

Fix this by using a different approach, with a fifo and tailing it to the
stdin of a background xfs_io process and then writing to the fifo to
create the tmpfile. This keeps the xfs_io process running with the tmpfile
open while we snapshot and run the send operation.

While at it also add code to verify we have the tmpfile (an orphan inode
item) in the snapshot's tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/058 | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/058 b/tests/btrfs/058
index 7bc4af5b..3bb0ed21 100755
--- a/tests/btrfs/058
+++ b/tests/btrfs/058
@@ -21,6 +21,7 @@ _cleanup()
 {
 	if [ ! -z $XFS_IO_PID ]; then
 		kill $XFS_IO_PID > /dev/null 2>&1
+		wait
 	fi
 	rm -fr $tmp
 }
@@ -29,18 +30,22 @@ _cleanup()
 
 _require_scratch
 _require_xfs_io_command "-T"
+_require_mknod
+_require_btrfs_command inspect-internal dump-tree
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
+mkfifo $SCRATCH_MNT/fifo
+
 # Create a tmpfile file, write some data to it and leave it open, so that our
 # main subvolume has an orphan inode item.
-$XFS_IO_PROG -T $SCRATCH_MNT >>$seqres.full 2>&1 < <(
-	echo "pwrite 0 65536"
-	read
-) &
+tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG >>$seqres.full &
 XFS_IO_PID=$!
 
+echo "open -T $SCRATCH_MNT" > $SCRATCH_MNT/fifo
+echo "pwrite 0 64K" > $SCRATCH_MNT/fifo
+
 # Give it some time to the xfs_io process to create the tmpfile.
 sleep 3
 
@@ -48,6 +53,21 @@ sleep 3
 # The send operation used to fail with -ESTALE due to the presence of the
 # orphan inode.
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap
+
+snap_id=$(_btrfs_get_subvolid $SCRATCH_MNT mysnap)
+# Inode numbers are sequential, so our tmpfile's inode number is the number of
+# the fifo's inode plus 1.
+ino=$(( $(stat -c %i $SCRATCH_MNT/fifo) + 1 ))
+
+# Verify that we indeed have the tmpfile in the snapshot tree.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t $snap_id $SCRATCH_DEV | \
+	grep -q "(ORPHAN ORPHAN_ITEM $ino)"
+if [ $? -ne 0 ]; then
+	echo "orphan item for tmpfile not found in the snapshot tree!"
+	echo -e "snapshot tree dump is:\n"
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t $snap_id $SCRATCH_DEV
+fi
+
 _btrfs send -f /dev/null $SCRATCH_MNT/mysnap
 
 status=0
-- 
2.45.2


