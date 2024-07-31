Return-Path: <linux-btrfs+bounces-6910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 095DF942ED2
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A90F1C2178F
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 12:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0D1B0105;
	Wed, 31 Jul 2024 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZvX79CZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AE1AE868;
	Wed, 31 Jul 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429692; cv=none; b=QdGdT/j5p1CvEhsnWIUkaMP+k2JyhtF0GDhHmGxN9gP+GU7Ncf/eHT0hv69eljPpuGgY81csnP/jfbuEC5gtz3akx+AtNX60OLSnu5BO8OmM5qAfrI5WZIuuqGVF3j6zKx2ODIHTXegbi3Vpuwc4pflVQ7KrhviGTJGlGwZTpx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429692; c=relaxed/simple;
	bh=h8k2a4KrEyosUEat/3+2v8VMyUQwQ7YAiFfJitUd7Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKYyenjGGwZJVyRpJHQloeB3JuyZiAmDFkyC2woU1cMPzL35vAYYlY9x7Bk5dKSZPrL0weivST4x8YvFae7w5mCykTUW+OtyPqqRMQhl+3Egwjtre5gJ9KjM7hvskYv21SQr/19Yjes7PV651n5WT8ckC9iBsnyyE12OcGEtF1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZvX79CZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA915C116B1;
	Wed, 31 Jul 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722429691;
	bh=h8k2a4KrEyosUEat/3+2v8VMyUQwQ7YAiFfJitUd7Is=;
	h=From:To:Cc:Subject:Date:From;
	b=jZvX79CZ/XbCpcYb/phYZG2Sz1DFWWpCbBvfwJbW0J00frhcGkf2UTI++BZH0GiUK
	 yNT6/LIqvgWf64p3uFsFGbcj3wShmcsXibnUMRQBsVhoP01IC4JtgfZYvjFOnH6PG6
	 slL997IF62nhEXVuox2M/VNHLlGhY868XH+uIHJlDAM8eAzKIbNYjPsg177eJWsRjp
	 vg+s0hgdNCnn2D4/10DQn+ckeD8dx/RC3327W/kio90YuSDant1L20JE7TepHOIJjJ
	 0mO3RflqMsesbEYhAEnMUPfuEygl2nCtUKire9GzS27R4LY0jz14Oe2Zy6ac08xgDy
	 cMmo1iGH1CC/g==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/287: wait for subvolume deletion to complete
Date: Wed, 31 Jul 2024 13:41:24 +0100
Message-ID: <40c169580bd42e96faf11c7ce8805399dd0a180c.1722429630.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test deletes the subvolume and then immediately calls the logical
resolve ioctl to confirm the extent is not referenced by the subvolume
anymore. This however may often fail because the subvolume delete only
makes the subvolume not accessible to user space anymore, but the actual
deletion of the subvolume tree, and all its data references, happens in
the background in the cleaner kthread running in kernel space.

So if by the time we do the query the cleaner kthread has not yet deleted
the subvolume tree, the test fails like this:

  $ ./check btrfs/287
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 5.14.0-btrfs-next-22 #1 SMP Tue Jul 30 16:31:55 WEST 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/287 0s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
      --- tests/btrfs/287.out	2024-07-30 17:40:49.037599612 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	2024-07-31 13:06:28.275728352 +0100
      @@ -82,12 +82,18 @@
       inode 257 offset 20971520 snap2
       inode 257 offset 12582912 snap2
       inode 257 offset 4194304 snap2
      +inode 257 offset 20971520 snap1
      +inode 257 offset 12582912 snap1
      +inode 257 offset 4194304 snap1
       inode 257 offset 20971520 root 5
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        0cad8f14d70c btrfs: fix backref walking not returning all inode refs

Fix this by using the "subvolume sync" command to wait for the subvolume
to be deleted by the cleaner kthread before doing logical resolve queries.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/287 | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/btrfs/287 b/tests/btrfs/287
index d6c04ea8..e88f4e0a 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -147,6 +147,27 @@ query_logical_ino -o $second_extent_bytenr | filter_snapshot_ids
 # Now delete the first snapshot and repeat the last 2 queries.
 $BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_btrfs_subvol_delete
 
+# Remount with a commit interval of 1s so that we wake up the cleaner kthread
+# (which does the actual subvolume tree deletion) and the transaction used by
+# the cleaner kthread to delete the tree gets committed sooner and we wait less
+# in the subvolume sync command below.
+_scratch_remount commit=1
+
+# The subvolume delete only made the subvolume not accessible anymore, but its
+# tree and references to data extents are only deleted when the cleaner kthread
+# runs, so wait for the cleaner to finish. It isn't enough to pass -C/-c (commit
+# transaction) because the cleaner may run only after the transaction commit.
+# Most of the time we don't need this because the transaction kthread wakes up
+# the cleaner kthread, which deletes the subvolume before we query the extents
+# below, as this is a very small filesystem and therefore very fast.
+# Nevertheless it's racy and on slower machines it may fail often as well as on
+# kernels without the reworked async transaction commit (kernel commit
+# fdfbf020664b ("btrfs: rework async transaction committing"), which landed in
+# kernel 5.17) which changes timing and substantially increases the chances that
+# the cleaner already ran and deleted the subvolume tree by the time we do the
+# queries below.
+$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >> $seqres.full
+
 # Query the second extent with an offset of 0, should return file offsets 12M
 # and 20M for the default subvolume (root 5) and file offsets 4M, 12M and 20M
 # for the second snapshot root.
-- 
2.43.0


