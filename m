Return-Path: <linux-btrfs+bounces-11948-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757AA49EC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 17:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB811898F31
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0027291F;
	Fri, 28 Feb 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR2205aj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759D26A0DB;
	Fri, 28 Feb 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760084; cv=none; b=mAYXT381M6GKyGdtJucmvHcAytW+I23GRdg0RVYKjsLZBjW9aZIwVPidkTYKxZsu/4g18tO/ytwwzCZLuFQpgBKNK9Mzn9LQB1SfjASFBngFWsC3OGcZ3Uhq/HxGu3ZTcwwqoP2H5l9rvtj/R2c4RRqKoZ21O+alT8v6d61e5RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760084; c=relaxed/simple;
	bh=vb+8B1B33mARj/OQc1AFoSwj4mPJXOHuGLQvA5qeByA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjQ7oAZ0ZqdBPMjXY2XSLoY7MJMA8V+4bE/mozzeKYng7wDCRZI86GTmsE64CF87nxh6/dNDQWO1R5IMLWFLWeYDOUg+RHRmazW5ULd5syGRyDtQHHsSFeKCnG56gNUueAday0dPtRT/V7YhXrykvHMkesCJevZ68UYcB9ecqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR2205aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC9EC4CED6;
	Fri, 28 Feb 2025 16:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740760083;
	bh=vb+8B1B33mARj/OQc1AFoSwj4mPJXOHuGLQvA5qeByA=;
	h=From:To:Cc:Subject:Date:From;
	b=sR2205ajhr2GvHTMH4LVmejs6OzvKxTRsnbtc+FWyH8W2edAm+E8H+0vV1LgQZgBg
	 +43anvf22MO9AqOLXdGmsDQLOQOr8+pjGHy5WQ6jVtEHQ66FefaasdE6ssSAdJOUFE
	 409U/X6xpxzsbkKHHQ7OVBjnJW/A/diQyGjFIDe+IE227poRrS1CwaPvjQaAjNXbpo
	 5K5q1kAQKXj5DX3IPdD82eAzyFDZWrPafzDMoGdJz7O7b5Oul6lSHmp9o/eFixKoNg
	 ry1bVqbLOkrK9ipsALXvfFZA94un6c9tM8ZpnTS+ACxRX1vYnijELcuEL0tdKTOuP0
	 erbIk8UheFJDQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Glass Su <glass.su@suse.com>
Subject: [PATCH] btrfs/080: fix sporadic failures starting with kernel 6.13
Date: Fri, 28 Feb 2025 16:27:55 +0000
Message-ID: <d48dd538e99048e73973c6b32a75a6ff340e8c47.1740759907.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Since kernel 6.13, namely since commit c87c299776e4 ("btrfs: make buffered
write to copy one page a time"), the test can sporadically fail with an
unexpected digests for files in snapshots. This is because after that
commit the pages for a buffered write are prepared and dirtied one by one,
and no longer in batches up to 512 pages (on x86_64), so a snapshot that
is created in the middle of a buffered write can result in a version of
the file where only a part of a buffered write got caught, for example if
a snapshot is created while doing the 32K write for file range [0, 32K),
we can end up a file in the snapshot where only the first 8K (2 pages) of
the write are visible, since the remaining 24K were not yet processed by
the write task. Before that kernel commit, this didn't happen since we
processed all the pages in a single batch and while holding the whole
range locked in the inode's io tree.

This is easy to observe by adding an "od -A d -t x1" call to the test
before the _fail statement when we get an unexpected file digest:

  $ ./check btrfs/080
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/080 32s ... [failed, exit status 1]- output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad)
      --- tests/btrfs/080.out	2020-06-10 19:29:03.814519074 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad	2025-02-27 17:12:08.410696958 +0000
      @@ -1,2 +1,6 @@
       QA output created by 080
      -Silence is golden
      +0000000 aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
      +*
      +0008192
      +Unexpected digest for file /home/fdmanana/btrfs-tests/scratch_1/17_11_56_146646257_snap/foobar_50
      +(see /home/fdmanana/git/hub/xfstests/results//btrfs/080.full for details)
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/080.out /home/fdmanana/git/hub/xfstests/results//btrfs/080.out.bad'  to see the entire diff)
  Ran: btrfs/080
  Failures: btrfs/080
  Failed 1 of 1 tests

The files are created like this while snapshots are created in parallel:

    run_check $XFS_IO_PROG -f \
        -c "pwrite -S 0xaa -b 32K 0 32K" \
        -c "fsync" \
        -c "pwrite -S 0xbb -b 32770 16K 32770" \
        -c "truncate 90123" \
        $SCRATCH_MNT/$name

So with the kernel behaviour before 6.13 we expected the snapshot to
contain any of the following versions of the file:

1) Empty file;

2) 32K file reflecting only the first buffered write;

3) A file with a size of 49154 bytes reflecting both buffered writes;

4) A file with a size of 90123 bytes, reflecting the truncate operation
   and both buffered writes.

So now the test can fail since kernel 6.13 due to snapshots catching
partial writes.

However the goal of the test when I wrote it was to verify that if the
snapshot version of a file gets the truncated size, then the buffered
writes are visible in the file, since they happened before the truncate
operation - that is, we can't get a file with a size of 90123 bytes that
doesn't have the range [0, 16K) full of bytes with a value of 0xaa and
the range [16K, 49154) full of bytes with the 0xbb value.

So update the test to the new kernel behaviour by verifying only that if
the file has the size we truncated to, then it has all the data we wrote
previously with the buffered writes.

Reported-by: Glass Su <glass.su@suse.com>
Link: https://lore.kernel.org/linux-btrfs/30FD234D-58FC-4F3C-A947-47A5B6972C01@suse.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/080 | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tests/btrfs/080 b/tests/btrfs/080
index ea9d09b0..aa97d3f6 100755
--- a/tests/btrfs/080
+++ b/tests/btrfs/080
@@ -32,6 +32,8 @@ _cleanup()
 
 _require_scratch_nocheck
 
+truncate_offset=90123
+
 create_snapshot()
 {
 	local ts=`date +'%H_%M_%S_%N'`
@@ -48,7 +50,7 @@ create_file()
 		-c "pwrite -S 0xaa -b 32K 0 32K" \
 		-c "fsync" \
 		-c "pwrite -S 0xbb -b 32770 16K 32770" \
-		-c "truncate 90123" \
+		-c "truncate $truncate_offset" \
 		$SCRATCH_MNT/$name
 }
 
@@ -81,6 +83,12 @@ _scratch_mkfs "$mkfs_options" >>$seqres.full 2>&1
 
 _scratch_mount
 
+# Create a file while no snapshotting is in progress so that we get the expected
+# digest for every file in a snapshot that caught the truncate operation (which
+# sets the file's size to $truncate_offset).
+create_file "gold_file"
+expected_digest=`_md5_checksum "$SCRATCH_MNT/gold_file"`
+
 # Run some background load in order to make the issue easier to trigger.
 # Specially needed when testing with non-debug kernels and there isn't
 # any other significant load on the test machine other than this test.
@@ -103,24 +111,20 @@ for ((i = 0; i < $num_procs; i++)); do
 done
 
 for f in $(find $SCRATCH_MNT -type f -name 'foobar_*'); do
-	digest=`md5sum $f | cut -d ' ' -f 1`
-	case $digest in
-	"d41d8cd98f00b204e9800998ecf8427e")
-		# ok, empty file
-		;;
-	"c28418534a020122aca59fd3ff9581b5")
-		# ok, only first write captured
-		;;
-	"cd0032da89254cdc498fda396e6a9b54")
-		# ok, only 2 first writes captured
-		;;
-	"a1963f914baf4d2579d643425f4e54bc")
-		# ok, the 2 writes and the truncate were captured
-		;;
-	*)
-		# not ok, truncate captured but not one or both writes
-		_fail "Unexpected digest for file $f"
-	esac
+	file_size=$(stat -c%s "$f")
+	# We want to verify that if the file has the size set by the truncate
+	# operation, then both delalloc writes were flushed, and every version
+	# of the file in each snapshot has its range [0, 16K) full of bytes with
+	# a value of 0xaa and the range [16K, 49154) is full of bytes with a
+	# value of 0xbb.
+	if [ "$file_size" -eq "$truncate_offset" ]; then
+		digest=`_md5_checksum "$f"`
+		if [ "$digest" != "$expected_digest" ]; then
+			echo -e "Unexpected content for file $f:\n"
+			_hexdump "$f"
+			_fail "Bad file content"
+		fi
+	fi
 done
 
 # Check the filesystem for inconsistencies.
-- 
2.45.2


