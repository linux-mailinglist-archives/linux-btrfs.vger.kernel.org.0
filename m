Return-Path: <linux-btrfs+bounces-7860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C539996DE84
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 17:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5804E282AE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732D19EEB0;
	Thu,  5 Sep 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYt/rdMf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14C19E80F;
	Thu,  5 Sep 2024 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550710; cv=none; b=gbyh24Awgto2N+NAcVXAEXJccQsAct+F7Be3gkUEljPFaDJhw8Pz3seMWFy0nqpSYpBETT9N6zR2m7Y39d7u4OZUDT9P+UypaE7Cl14kQKG2ak1mVQwn7295/fwxQIlm8CbI7Of8wzvD/L3dra6dtH8KWr03jZBvTtzKrhnLCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550710; c=relaxed/simple;
	bh=Rz7vzsbRSeV7VTRmWGL/EWwLXcph6Ev9lVepTrwrXVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gI1HCOyhNGGeekjvWDzrXrI71Wog3XZPBpbgzcTloOS98Q3dH+uusiS/7GHMk+umTImxzMvZ6Yw+YvFq0wRnJnzXcl/ZxIr8xyvK1E1BoH61Hc+kEESUp/CGpLhu6QMJvBBx62pBw7LBx98zbF6/a7yDA+QnfGHoOFM+t9bw4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYt/rdMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A6AC4CEDA;
	Thu,  5 Sep 2024 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725550710;
	bh=Rz7vzsbRSeV7VTRmWGL/EWwLXcph6Ev9lVepTrwrXVg=;
	h=From:To:Cc:Subject:Date:From;
	b=nYt/rdMf/W2KeXUrsCgCkq4WYuyUcUHDXnPgn+DSNtHrJbjZpu0eWTYPNgKx4qbWO
	 MzunFGvzMXHBbZSc70CsmrmRZMI+H+8U5pCmJTtDpfucgO3hBFSccPgN1tX4Gztldb
	 8V8a7L3Ev+Pmn22etDzqAa2SeAEV9mU8JonV0YEv8rxDOWg23FPhY5EIhKxnrc0VAn
	 zx3d+2CLtNhUXq8d8OYfOCx3P+57IPClTgTdcWo6QOxGvxMnWsZD0dp+TtywDlw+0u
	 44AUOoKVkNhIA3aNjlpywgmZ8W8HOEgtcJQAKZ8P5k77QB+jt8utfziOKxgKOg7hFu
	 EbHQUIh5DZyFg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/319: make the test work when compression is used
Date: Thu,  5 Sep 2024 16:38:18 +0100
Message-ID: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs/319 assumes there is no compression and that the files
get a single extent (1 fiemap line) with a size of 1048581 bytes. However
when testing with compression, for example by passing "-o compress" to
MOUNT_OPTIONS environment variable, we get several extents and two lines
of fiemap output, which makes the test fail since it hardcodes the fiemap
output:

  $ MOUNT_OPTIONS="-o compress" ./check btrfs/319
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc6-btrfs-next-173+ #1 SMP PREEMPT_DYNAMIC Tue Sep  3 17:40:24 WEST 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/319 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad)
      --- tests/btrfs/319.out	2024-08-12 14:16:55.653383284 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad	2024-09-05 15:24:53.323076548 +0100
      @@ -6,11 +6,13 @@
       e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
       e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
       File bar fiemap in the original filesystem:
      -0: [0..2055]: shared|last
      +0: [0..2047]: shared
      +1: [2048..2055]: shared|last
       Creating a new filesystem to receive the send stream...
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/319.out /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        46a6e10a1ab1 btrfs: send: allow cloning non-aligned extent if it ends at i_size

  Ran: btrfs/319
  Failures: btrfs/319
  Failed 1 of 1 tests

So change the test to not rely on the fiemap output in its golden output
and instead just check if all the extents reported by fiemap have the
shared flag set (failing if there are any without the shared flag).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/319     | 19 +++++++++++++++----
 tests/btrfs/319.out |  4 ----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/319 b/tests/btrfs/319
index 975c1497..7cfd3d00 100755
--- a/tests/btrfs/319
+++ b/tests/btrfs/319
@@ -32,6 +32,19 @@ _require_odirect
 _fixed_by_kernel_commit 46a6e10a1ab1 \
 	"btrfs: send: allow cloning non-aligned extent if it ends at i_size"
 
+check_all_extents_shared()
+{
+	local file=$1
+	local fiemap_output
+
+	fiemap_output=$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_fiemap_flags)
+	echo "$fiemap_output" | grep -qv 'shared'
+	if [ $? -eq 0 ]; then
+		echo -e "Found non-shared extents for file $file:\n"
+		echo "$fiemap_output"
+	fi
+}
+
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 send_stream=$send_files_dir/snap.stream
 
@@ -58,8 +71,7 @@ echo "File digests in the original filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-echo "File bar fiemap in the original filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags
+check_all_extents_shared "$SCRATCH_MNT/snap/bar"
 
 echo "Creating a new filesystem to receive the send stream..."
 _scratch_unmount
@@ -72,8 +84,7 @@ echo "File digests in the new filesystem:"
 md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
 md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
 
-echo "File bar fiemap in the new filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags
+check_all_extents_shared "$SCRATCH_MNT/snap/bar"
 
 # success, all done
 status=0
diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
index 14079dbe..18a50ff8 100644
--- a/tests/btrfs/319.out
+++ b/tests/btrfs/319.out
@@ -5,12 +5,8 @@ Creating snapshot and a send stream for it...
 File digests in the original filesystem:
 e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
 e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
-File bar fiemap in the original filesystem:
-0: [0..2055]: shared|last
 Creating a new filesystem to receive the send stream...
 At subvol snap
 File digests in the new filesystem:
 e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
 e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
-File bar fiemap in the new filesystem:
-0: [0..2055]: shared|last
-- 
2.43.0


