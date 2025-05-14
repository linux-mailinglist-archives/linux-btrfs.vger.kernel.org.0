Return-Path: <linux-btrfs+bounces-14017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED742AB728C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 19:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC63AC251
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 17:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01126281523;
	Wed, 14 May 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K130Jasj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C61DE3CA;
	Wed, 14 May 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242822; cv=none; b=q7qCuB3XI3LTVFPvs4kA4eckQ+m5hokQNgjx1NQq5q6ymqBX+jXCnH7wM3GRDmzBLr7lXYMVJNLQkyTLVwHZOiAsOr5X3QXWwwSx6NqHiK+C5XDx/CGc+icDRXZ5/cAmu8P+jKXdQxosjmMKaq4uToAHVCLflvfEclbbpZDQwLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242822; c=relaxed/simple;
	bh=y+U02MstntCytd+eRhuGsqkVHFUhyiUpnlZCqg2Ilso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KgwHtFhaWZiYmNlnYwtDvYB5RVKokY+Uu2IMO+nK+pUb2G1X1DrPntW51eLCzIrXCPFXm50I0UEV991ntFn+EMNEDI7JFJRNSXgJaakwo832TiwmQwOwdkuW7duVAi2V8Wbh44su1OG//vVJYE+izly+Lh68la/gxaAYbaokuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K130Jasj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DB3C4CEED;
	Wed, 14 May 2025 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747242821;
	bh=y+U02MstntCytd+eRhuGsqkVHFUhyiUpnlZCqg2Ilso=;
	h=From:To:Cc:Subject:Date:From;
	b=K130Jasjt5GyAehFMaKkESN3C3nOk/p6v1Tm/dKbb9HKA2g+fp9iZ7W5TzltjgLjK
	 ICAi+v3mquB7+e72UUF1vwhU3DXsqPKdqg9f9YU++SDuaEYLMlcM/K6VBMPsRXBJNj
	 I+suE5sswa8hWEubIw0GjQJ6qWz59U0orRYpPBZI0UyDO1DxtBEL6ywJ8Fha00VsU3
	 Ok58YISYrDH6qlwFnQNYFbDX5t0DJH9QRDi2AdR258gHLZHUDbgZ03DZDPf8SDYUkj
	 kaGMZ59aWHR5vlrh6XAX541G3gGmUtg1aDCW6f6grBEmULne896feo3/GiUMc1/pTy
	 LNJ45XL8ExRuA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add a mmap test group
Date: Wed, 14 May 2025 18:13:32 +0100
Message-ID: <617c0ddb1f4cc21442a9db8d7098d5e261d46b2a.1747242435.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Add a mmap group to tag tests that exercise memory mapped reads/writes, so
that it's easy to filter and run tests that exercise map:

   ./check -g mmap

Very useful during development to quickly test changes to a filesystem's
mmap implementation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 doc/group-names.txt | 1 +
 tests/btrfs/209     | 2 +-
 tests/generic/019   | 2 +-
 tests/generic/029   | 2 +-
 tests/generic/030   | 2 +-
 tests/generic/068   | 2 +-
 tests/generic/074   | 2 +-
 tests/generic/080   | 2 +-
 tests/generic/095   | 2 +-
 tests/generic/127   | 2 +-
 tests/generic/140   | 2 +-
 tests/generic/141   | 2 +-
 tests/generic/173   | 2 +-
 tests/generic/215   | 2 +-
 tests/generic/219   | 2 +-
 tests/generic/246   | 2 +-
 tests/generic/247   | 2 +-
 tests/generic/248   | 2 +-
 tests/generic/279   | 2 +-
 tests/generic/281   | 2 +-
 tests/generic/282   | 2 +-
 tests/generic/283   | 2 +-
 tests/generic/325   | 2 +-
 tests/generic/340   | 2 +-
 tests/generic/344   | 2 +-
 tests/generic/345   | 2 +-
 tests/generic/346   | 2 +-
 tests/generic/413   | 2 +-
 tests/generic/428   | 2 +-
 tests/generic/437   | 2 +-
 tests/generic/438   | 2 +-
 tests/generic/446   | 2 +-
 tests/generic/462   | 2 +-
 tests/generic/469   | 2 +-
 tests/generic/470   | 2 +-
 tests/generic/499   | 2 +-
 tests/generic/503   | 2 +-
 tests/generic/511   | 2 +-
 tests/generic/567   | 2 +-
 tests/generic/569   | 2 +-
 tests/generic/570   | 2 +-
 tests/generic/574   | 2 +-
 tests/generic/578   | 2 +-
 tests/generic/605   | 2 +-
 tests/generic/614   | 2 +-
 tests/generic/623   | 2 +-
 tests/generic/630   | 2 +-
 tests/generic/638   | 2 +-
 tests/generic/647   | 2 +-
 tests/generic/651   | 2 +-
 tests/generic/652   | 2 +-
 tests/generic/653   | 2 +-
 tests/generic/654   | 2 +-
 tests/generic/655   | 2 +-
 tests/generic/657   | 2 +-
 tests/generic/658   | 2 +-
 tests/generic/659   | 2 +-
 tests/generic/660   | 2 +-
 tests/generic/661   | 2 +-
 tests/generic/662   | 2 +-
 tests/generic/663   | 2 +-
 tests/generic/664   | 2 +-
 tests/generic/665   | 2 +-
 tests/generic/666   | 2 +-
 tests/generic/669   | 2 +-
 tests/generic/670   | 2 +-
 tests/generic/671   | 2 +-
 tests/generic/672   | 2 +-
 tests/generic/708   | 3 ++-
 tests/generic/729   | 2 +-
 tests/generic/742   | 3 ++-
 tests/generic/743   | 2 +-
 tests/generic/749   | 2 +-
 tests/generic/758   | 2 +-
 tests/overlay/061   | 2 +-
 tests/xfs/090       | 2 +-
 tests/xfs/108       | 2 +-
 tests/xfs/166       | 2 +-
 tests/xfs/194       | 2 +-
 tests/xfs/550       | 2 +-
 tests/xfs/551       | 2 +-
 tests/xfs/552       | 2 +-
 tests/xfs/559       | 2 +-
 83 files changed, 85 insertions(+), 82 deletions(-)

diff --git a/doc/group-names.txt b/doc/group-names.txt
index f510bb82..58502131 100644
--- a/doc/group-names.txt
+++ b/doc/group-names.txt
@@ -77,6 +77,7 @@ metacopy		overlayfs metadata-only copy-up
 metadata		filesystem metadata update exercisers
 metadump		xfs_metadump/xfs_mdrestore functionality
 mkfs			filesystem formatting tools
+mmap			memory mapped reads/writes
 mount			mount option and functionality checks
 nested			nested overlayfs instances
 nfs4_acl		NFSv4 access control lists
diff --git a/tests/btrfs/209 b/tests/btrfs/209
index 5a5964a3..7318f8ae 100755
--- a/tests/btrfs/209
+++ b/tests/btrfs/209
@@ -10,7 +10,7 @@
 # only when not using the NO_HOLES feature.
 #
 . ./common/preamble
-_begin_fstest auto quick log
+_begin_fstest auto quick log mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/019 b/tests/generic/019
index 676ff27d..00badf6d 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -8,7 +8,7 @@
 # check filesystem consistency at the end.
 #
 . ./common/preamble
-_begin_fstest aio dangerous enospc rw stress recoveryloop
+_begin_fstest aio dangerous enospc rw stress recoveryloop mmap
 
 fio_config=$tmp.fio
 
diff --git a/tests/generic/029 b/tests/generic/029
index c6162b0b..1fee35f0 100755
--- a/tests/generic/029
+++ b/tests/generic/029
@@ -9,7 +9,7 @@
 # the block size is smaller than the page size.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/030 b/tests/generic/030
index b1b51469..e1674331 100755
--- a/tests/generic/030
+++ b/tests/generic/030
@@ -9,7 +9,7 @@
 # the block size is smaller than the page size.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/068 b/tests/generic/068
index 26c5ceea..c6319639 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -8,7 +8,7 @@
 # The fail case for this test is a hang on an xfs_freeze.
 #
 . ./common/preamble
-_begin_fstest other auto freeze stress
+_begin_fstest other auto freeze stress mmap
 
 status=0	# success is the default!
 
diff --git a/tests/generic/074 b/tests/generic/074
index 923bf36b..103d666b 100755
--- a/tests/generic/074
+++ b/tests/generic/074
@@ -7,7 +7,7 @@
 # fstest
 #
 . ./common/preamble
-_begin_fstest rw udf auto
+_begin_fstest rw udf auto mmap
 
 fstest_dir=$TEST_DIR/fstest
 status=0	# success is the default!
diff --git a/tests/generic/080 b/tests/generic/080
index 5c38cc20..f7d40543 100755
--- a/tests/generic/080
+++ b/tests/generic/080
@@ -7,7 +7,7 @@
 # Verify that mtime is updated when writing to mmap-ed pages
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick mmap
 
 status=0
 
diff --git a/tests/generic/095 b/tests/generic/095
index 47e3b1e6..828274fd 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -7,7 +7,7 @@
 # Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
 #
 . ./common/preamble
-_begin_fstest auto quick rw stress
+_begin_fstest auto quick rw stress mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/127 b/tests/generic/127
index fcd535b4..431188ef 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -11,7 +11,7 @@
 #   - fsx_15_std_mmap
 #
 . ./common/preamble
-_begin_fstest rw auto
+_begin_fstest rw auto mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/140 b/tests/generic/140
index 8cbc23bb..98c1df24 100755
--- a/tests/generic/140
+++ b/tests/generic/140
@@ -10,7 +10,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/141 b/tests/generic/141
index d6fab33f..8f34f5b1 100755
--- a/tests/generic/141
+++ b/tests/generic/141
@@ -7,7 +7,7 @@
 # Test for xfs_io mmap read problem
 #
 . ./common/preamble
-_begin_fstest rw auto quick
+_begin_fstest rw auto quick mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/173 b/tests/generic/173
index a19ff807..5dc24bec 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -8,7 +8,7 @@
 # while copy-on-writing the file via mmap.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/215 b/tests/generic/215
index 6f51b26a..5948da48 100755
--- a/tests/generic/215
+++ b/tests/generic/215
@@ -9,7 +9,7 @@
 # Based on the testcase in http://bugzilla.kernel.org/show_bug.cgi?id=2645
 #
 . ./common/preamble
-_begin_fstest auto metadata quick
+_begin_fstest auto metadata quick mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/219 b/tests/generic/219
index cc2ec119..64282385 100755
--- a/tests/generic/219
+++ b/tests/generic/219
@@ -8,7 +8,7 @@
 # Simple quota accounting test for direct/buffered/mmap IO.
 #
 . ./common/preamble
-_begin_fstest auto quota quick
+_begin_fstest auto quota quick mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/246 b/tests/generic/246
index ee5afac6..8ef4da99 100755
--- a/tests/generic/246
+++ b/tests/generic/246
@@ -10,7 +10,7 @@
 # Marius Tolzmann <tolzmann@molgen.mpg.de>
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/247 b/tests/generic/247
index a758ae24..7ea52375 100755
--- a/tests/generic/247
+++ b/tests/generic/247
@@ -7,7 +7,7 @@
 # Test for race between direct I/O and mmap
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 _register_cleanup "_cleanup" BUS
 
diff --git a/tests/generic/248 b/tests/generic/248
index 49089534..ca37d649 100755
--- a/tests/generic/248
+++ b/tests/generic/248
@@ -7,7 +7,7 @@
 # Test for pwrite hang problem when writing from mmaped buffer of the same page 
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/279 b/tests/generic/279
index 599b4b6d..60204cdf 100755
--- a/tests/generic/279
+++ b/tests/generic/279
@@ -7,7 +7,7 @@
 # Test mmap CoW behavior when the write temporarily fails.
 #
 . ./common/preamble
-_begin_fstest auto quick clone eio
+_begin_fstest auto quick clone eio mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/281 b/tests/generic/281
index 474b8b73..d88d35f7 100755
--- a/tests/generic/281
+++ b/tests/generic/281
@@ -7,7 +7,7 @@
 # Test mmap CoW behavior when the write permanently fails.
 #
 . ./common/preamble
-_begin_fstest auto quick clone eio
+_begin_fstest auto quick clone eio mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/282 b/tests/generic/282
index 72797813..90b97e6d 100755
--- a/tests/generic/282
+++ b/tests/generic/282
@@ -7,7 +7,7 @@
 # Test mmap CoW behavior when the write temporarily fails and we unmount.
 #
 . ./common/preamble
-_begin_fstest auto quick clone eio
+_begin_fstest auto quick clone eio mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/283 b/tests/generic/283
index cdad47a2..99f3e94b 100755
--- a/tests/generic/283
+++ b/tests/generic/283
@@ -8,7 +8,7 @@
 # program writes again.
 #
 . ./common/preamble
-_begin_fstest auto quick clone eio
+_begin_fstest auto quick clone eio mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/325 b/tests/generic/325
index f8506633..932c18f1 100755
--- a/tests/generic/325
+++ b/tests/generic/325
@@ -16,7 +16,7 @@
 #     Btrfs: fix fsync data loss after a ranged fsync
 #
 . ./common/preamble
-_begin_fstest auto quick data log
+_begin_fstest auto quick data log mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/340 b/tests/generic/340
index 631324f1..96c8884d 100755
--- a/tests/generic/340
+++ b/tests/generic/340
@@ -7,7 +7,7 @@
 # Test mmap writing races from racing threads
 #
 . ./common/preamble
-_begin_fstest auto
+_begin_fstest auto mmap
 
 # get standard environment and checks
 
diff --git a/tests/generic/344 b/tests/generic/344
index e6a3a5fe..884e65ba 100755
--- a/tests/generic/344
+++ b/tests/generic/344
@@ -8,7 +8,7 @@
 # Test races between mmap and buffered writes when pages are prefaulted.
 #
 . ./common/preamble
-_begin_fstest auto
+_begin_fstest auto mmap
 
 # get standard environment and checks
 
diff --git a/tests/generic/345 b/tests/generic/345
index cc1080f3..a73903e2 100755
--- a/tests/generic/345
+++ b/tests/generic/345
@@ -7,7 +7,7 @@
 # Test races between mmap from racing processes with and without prefaulting.
 #
 . ./common/preamble
-_begin_fstest auto
+_begin_fstest auto mmap
 
 # get standard environment and checks
 
diff --git a/tests/generic/346 b/tests/generic/346
index 89652ea5..aaf4c28e 100755
--- a/tests/generic/346
+++ b/tests/generic/346
@@ -7,7 +7,7 @@
 # Test races between mmap and normal writes from racing threads
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # get standard environment and checks
 
diff --git a/tests/generic/413 b/tests/generic/413
index c9274e44..8a81e901 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -7,7 +7,7 @@
 # mmap direct/buffered io between DAX and non-DAX mountpoints.
 #
 . ./common/preamble
-_begin_fstest auto quick dax prealloc
+_begin_fstest auto quick dax prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/428 b/tests/generic/428
index c2c78778..d35dcbe0 100755
--- a/tests/generic/428
+++ b/tests/generic/428
@@ -9,7 +9,7 @@
 # created by Ross Zwisler <ross.zwisler@linux.intel.com>
 #
 . ./common/preamble
-_begin_fstest auto quick dax
+_begin_fstest auto quick dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/437 b/tests/generic/437
index afba4731..ce89d24f 100755
--- a/tests/generic/437
+++ b/tests/generic/437
@@ -10,7 +10,7 @@
 # created by Ross Zwisler <ross.zwisler@linux.intel.com>
 #
 . ./common/preamble
-_begin_fstest auto quick dax
+_begin_fstest auto quick dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/438 b/tests/generic/438
index df9c23d2..2ed1e52e 100755
--- a/tests/generic/438
+++ b/tests/generic/438
@@ -14,7 +14,7 @@
 # Based on test program by Michael Zimmer <michael@swarm64.com>
 #
 . ./common/preamble
-_begin_fstest auto
+_begin_fstest auto mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/446 b/tests/generic/446
index c0d32e4e..cfa28759 100755
--- a/tests/generic/446
+++ b/tests/generic/446
@@ -12,7 +12,7 @@
 # will trigger a BUG_ON().
 #
 . ./common/preamble
-_begin_fstest auto quick rw punch
+_begin_fstest auto quick rw punch mmap
 
 # get standard environment and checks
 . ./common/filter
diff --git a/tests/generic/462 b/tests/generic/462
index 42f18ad2..49b0df40 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -12,7 +12,7 @@
 # which is configured in "memory mode", not in "raw mode".
 #
 . ./common/preamble
-_begin_fstest auto quick dax
+_begin_fstest auto quick dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/469 b/tests/generic/469
index f7718185..c36544b0 100755
--- a/tests/generic/469
+++ b/tests/generic/469
@@ -14,7 +14,7 @@
 # the bug on XFS.
 #
 . ./common/preamble
-_begin_fstest auto quick punch zero prealloc
+_begin_fstest auto quick punch zero prealloc mmap
 
 file=$TEST_DIR/$seq.fsx
 
diff --git a/tests/generic/470 b/tests/generic/470
index aef262c8..96ccbab3 100755
--- a/tests/generic/470
+++ b/tests/generic/470
@@ -8,7 +8,7 @@
 # page faults.
 #
 . ./common/preamble
-_begin_fstest auto quick dax
+_begin_fstest auto quick dax mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/499 b/tests/generic/499
index 868413ba..eca9b3d3 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -8,7 +8,7 @@
 # eof to return nonzero contents.
 #
 . ./common/preamble
-_begin_fstest auto quick rw collapse zero prealloc
+_begin_fstest auto quick rw collapse zero prealloc mmap
 
 # Import common functions.
 . ./common/punch
diff --git a/tests/generic/503 b/tests/generic/503
index f9796e69..eb67c483 100755
--- a/tests/generic/503
+++ b/tests/generic/503
@@ -14,7 +14,7 @@
 # don't require the DAX mount option or a specific filesystem for the test.
 
 . ./common/preamble
-_begin_fstest auto quick dax punch collapse zero prealloc
+_begin_fstest auto quick dax punch collapse zero prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/511 b/tests/generic/511
index 66557ab9..296859c2 100755
--- a/tests/generic/511
+++ b/tests/generic/511
@@ -8,7 +8,7 @@
 # eof to return nonzero contents.
 #
 . ./common/preamble
-_begin_fstest auto quick rw zero prealloc
+_begin_fstest auto quick rw zero prealloc mmap
 
 # Import common functions.
 . ./common/punch
diff --git a/tests/generic/567 b/tests/generic/567
index fc109d0d..ee479e68 100755
--- a/tests/generic/567
+++ b/tests/generic/567
@@ -11,7 +11,7 @@
 # (generic/029 is a similar test but for truncate.)
 #
 . ./common/preamble
-_begin_fstest auto quick rw punch
+_begin_fstest auto quick rw punch mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/569 b/tests/generic/569
index 345e4744..efc3710a 100755
--- a/tests/generic/569
+++ b/tests/generic/569
@@ -7,7 +7,7 @@
 # Check that we can't modify a file that's an active swap file.
 
 . ./common/preamble
-_begin_fstest auto quick rw swap prealloc
+_begin_fstest auto quick rw swap prealloc mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/570 b/tests/generic/570
index 6b50303c..5f33453f 100755
--- a/tests/generic/570
+++ b/tests/generic/570
@@ -7,7 +7,7 @@
 # Check that we can't modify a block device that's an active swap device.
 
 . ./common/preamble
-_begin_fstest auto quick rw swap
+_begin_fstest auto quick rw swap mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/574 b/tests/generic/574
index cf287d2b..ebe081e8 100755
--- a/tests/generic/574
+++ b/tests/generic/574
@@ -10,7 +10,7 @@
 # part of the contents is later read by any means.
 #
 . ./common/preamble
-_begin_fstest auto quick verity
+_begin_fstest auto quick verity mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/578 b/tests/generic/578
index 347f6f97..48e54f31 100755
--- a/tests/generic/578
+++ b/tests/generic/578
@@ -7,7 +7,7 @@
 # Make sure that we can handle multiple mmap writers to the same file.
 
 . ./common/preamble
-_begin_fstest auto quick rw clone fiemap
+_begin_fstest auto quick rw clone fiemap mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/605 b/tests/generic/605
index 2c372db7..017a72e2 100755
--- a/tests/generic/605
+++ b/tests/generic/605
@@ -7,7 +7,7 @@
 # Test per-inode DAX flag by mmap direct/buffered IO.
 #
 . ./common/preamble
-_begin_fstest auto attr quick dax prealloc
+_begin_fstest auto attr quick dax prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/614 b/tests/generic/614
index 2299c133..4ae4fc36 100755
--- a/tests/generic/614
+++ b/tests/generic/614
@@ -8,7 +8,7 @@
 # stat(2) reports a non-zero number of used blocks.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/623 b/tests/generic/623
index 9f41b5cc..b97e2adb 100755
--- a/tests/generic/623
+++ b/tests/generic/623
@@ -7,7 +7,7 @@
 # Test a write fault scenario on a shutdown fs.
 #
 . ./common/preamble
-_begin_fstest auto quick shutdown
+_begin_fstest auto quick shutdown mmap
 
 . ./common/filter
 
diff --git a/tests/generic/630 b/tests/generic/630
index b2cbdcf0..aa6ac965 100755
--- a/tests/generic/630
+++ b/tests/generic/630
@@ -9,7 +9,7 @@
 # are identical and we can therefore go ahead with the remapping.
 
 . ./common/preamble
-_begin_fstest auto quick rw dedupe clone
+_begin_fstest auto quick rw dedupe clone mmap
 
 # Import common functions.
 . ./common/reflink
diff --git a/tests/generic/638 b/tests/generic/638
index 3de9801c..a5616c90 100755
--- a/tests/generic/638
+++ b/tests/generic/638
@@ -20,7 +20,7 @@
 #   4f06dd92b5d0 ("fuse: fix write deadlock")
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/647 b/tests/generic/647
index 99b13b38..f50e0171 100755
--- a/tests/generic/647
+++ b/tests/generic/647
@@ -7,7 +7,7 @@
 # Trigger page faults in the same file during read and write
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/651 b/tests/generic/651
index 0d79f3f2..ff7a933e 100755
--- a/tests/generic/651
+++ b/tests/generic/651
@@ -10,7 +10,7 @@
 # the golden output; we can only compare to a check file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/652 b/tests/generic/652
index e45dbbd2..7e156fc1 100755
--- a/tests/generic/652
+++ b/tests/generic/652
@@ -10,7 +10,7 @@
 # the golden output; we can only compare to a check file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/653 b/tests/generic/653
index bd3896cb..32416dd1 100755
--- a/tests/generic/653
+++ b/tests/generic/653
@@ -10,7 +10,7 @@
 # the golden output; we can only compare to a check file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/654 b/tests/generic/654
index 4b2986ec..05ef9e9c 100755
--- a/tests/generic/654
+++ b/tests/generic/654
@@ -10,7 +10,7 @@
 # the golden output; we can only compare to a check file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone fiemap prealloc
+_begin_fstest auto quick clone fiemap prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/655 b/tests/generic/655
index e2a503b4..75f1c341 100755
--- a/tests/generic/655
+++ b/tests/generic/655
@@ -11,7 +11,7 @@
 # the golden output; we can only compare to a check file.
 #
 . ./common/preamble
-_begin_fstest auto quick clone fiemap prealloc
+_begin_fstest auto quick clone fiemap prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/657 b/tests/generic/657
index df45afcb..8e3d08e7 100755
--- a/tests/generic/657
+++ b/tests/generic/657
@@ -12,7 +12,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/658 b/tests/generic/658
index 03d5a7a1..7d326cb7 100755
--- a/tests/generic/658
+++ b/tests/generic/658
@@ -12,7 +12,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/659 b/tests/generic/659
index cef2b232..29f299bb 100755
--- a/tests/generic/659
+++ b/tests/generic/659
@@ -12,7 +12,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/660 b/tests/generic/660
index 650e5e83..5455b460 100755
--- a/tests/generic/660
+++ b/tests/generic/660
@@ -12,7 +12,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/661 b/tests/generic/661
index 74c080ab..70762cb1 100755
--- a/tests/generic/661
+++ b/tests/generic/661
@@ -13,7 +13,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/662 b/tests/generic/662
index 54405b98..c6d8ce96 100755
--- a/tests/generic/662
+++ b/tests/generic/662
@@ -17,7 +17,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone punch prealloc
+_begin_fstest auto quick clone punch prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/663 b/tests/generic/663
index 2129805c..05d1069c 100755
--- a/tests/generic/663
+++ b/tests/generic/663
@@ -13,7 +13,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/664 b/tests/generic/664
index fdedc486..711af8fa 100755
--- a/tests/generic/664
+++ b/tests/generic/664
@@ -15,7 +15,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/665 b/tests/generic/665
index b0676dc8..a4379099 100755
--- a/tests/generic/665
+++ b/tests/generic/665
@@ -15,7 +15,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/666 b/tests/generic/666
index 8575c06c..9fff8039 100755
--- a/tests/generic/666
+++ b/tests/generic/666
@@ -16,7 +16,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone prealloc
+_begin_fstest auto quick clone prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/669 b/tests/generic/669
index aa7b0d55..6ddd2ad7 100755
--- a/tests/generic/669
+++ b/tests/generic/669
@@ -16,7 +16,7 @@
 #   - Check that the files are now different where we say they're different.
 #
 . ./common/preamble
-_begin_fstest auto quick clone punch prealloc
+_begin_fstest auto quick clone punch prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/670 b/tests/generic/670
index f32199e7..034aa8a7 100755
--- a/tests/generic/670
+++ b/tests/generic/670
@@ -7,7 +7,7 @@
 # target file. (MMAP version of generic/164,165)
 #
 . ./common/preamble
-_begin_fstest auto clone
+_begin_fstest auto clone mmap
 
 _register_cleanup "_cleanup" BUS
 
diff --git a/tests/generic/671 b/tests/generic/671
index 3abe1227..285e810e 100755
--- a/tests/generic/671
+++ b/tests/generic/671
@@ -7,7 +7,7 @@
 # the source of a reflink operation. (MMAP version of generic/167,166)
 #
 . ./common/preamble
-_begin_fstest auto clone
+_begin_fstest auto clone mmap
 
 _register_cleanup "_cleanup" BUS
 
diff --git a/tests/generic/672 b/tests/generic/672
index a5e65042..aa63ec8e 100755
--- a/tests/generic/672
+++ b/tests/generic/672
@@ -7,7 +7,7 @@
 # the target of a reflink operation. (MMAP version of generic/168,170)
 #
 . ./common/preamble
-_begin_fstest auto clone
+_begin_fstest auto clone mmap
 
 _register_cleanup "_cleanup" BUS
 
diff --git a/tests/generic/708 b/tests/generic/708
index 53bb0ee4..ec7e48a9 100755
--- a/tests/generic/708
+++ b/tests/generic/708
@@ -12,7 +12,8 @@
 # thus the iomap direct_io partial write codepath.
 #
 . ./common/preamble
-_begin_fstest quick auto
+_begin_fstest quick auto mmap
+
 [ $FSTYP == "btrfs" ] && \
 	_fixed_by_kernel_commit b73a6fd1b1ef \
 		"btrfs: split partial dio bios before submit"
diff --git a/tests/generic/729 b/tests/generic/729
index e0cd18d8..b206a196 100755
--- a/tests/generic/729
+++ b/tests/generic/729
@@ -14,7 +14,7 @@
 # with page faults disabled will never make any progress.
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/742 b/tests/generic/742
index 68cf20e4..ceecbdf9 100755
--- a/tests/generic/742
+++ b/tests/generic/742
@@ -12,7 +12,8 @@
 # result in a deadlock if we page faulted.
 #
 . ./common/preamble
-_begin_fstest quick auto fiemap
+_begin_fstest quick auto fiemap mmap
+
 [ $FSTYP == "btrfs" ] && \
 	_fixed_by_kernel_commit b0ad381fa769 \
 		"btrfs: fix deadlock with fiemap and extent locking"
diff --git a/tests/generic/743 b/tests/generic/743
index efdeec82..4eebdc06 100755
--- a/tests/generic/743
+++ b/tests/generic/743
@@ -9,7 +9,7 @@
 # MADV_POPULATE_READ on the mapping to fault in the pages.
 #
 . ./common/preamble
-_begin_fstest auto rw eio
+_begin_fstest auto rw eio mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/749 b/tests/generic/749
index 451f283e..7af019dd 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -15,7 +15,7 @@
 # boundary and ensures we get a SIGBUS if we write to data beyond the system
 # page size even if the block size is greater than the system page size.
 . ./common/preamble
-_begin_fstest auto quick prealloc
+_begin_fstest auto quick prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/758 b/tests/generic/758
index ad08b83f..00b3658d 100755
--- a/tests/generic/758
+++ b/tests/generic/758
@@ -11,7 +11,7 @@
 # (generic/567 is a similar test but for punch hole.)
 #
 . ./common/preamble
-_begin_fstest auto quick rw zero
+_begin_fstest auto quick rw zero mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/overlay/061 b/tests/overlay/061
index bf4ad6de..14586865 100755
--- a/tests/overlay/061
+++ b/tests/overlay/061
@@ -15,7 +15,7 @@
 # - process A reads old data from shared mmap
 #
 . ./common/preamble
-_begin_fstest posix copyup
+_begin_fstest posix copyup mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/090 b/tests/xfs/090
index dfc10d88..e2a5086c 100755
--- a/tests/xfs/090
+++ b/tests/xfs/090
@@ -7,7 +7,7 @@
 # Exercise IO on the realtime device (direct, buffered, mmapd)
 #
 . ./common/preamble
-_begin_fstest rw auto realtime
+_begin_fstest rw auto realtime mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/108 b/tests/xfs/108
index 8adc63d4..96621f65 100755
--- a/tests/xfs/108
+++ b/tests/xfs/108
@@ -7,7 +7,7 @@
 # Simple quota accounting test for direct/buffered/mmap IO.
 #
 . ./common/preamble
-_begin_fstest quota auto quick
+_begin_fstest quota auto quick mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/166 b/tests/xfs/166
index beb05031..57461d89 100755
--- a/tests/xfs/166
+++ b/tests/xfs/166
@@ -7,7 +7,7 @@
 # ->page-mkwrite test - unwritten extents and mmap
 #
 . ./common/preamble
-_begin_fstest rw metadata auto quick prealloc
+_begin_fstest rw metadata auto quick prealloc mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/194 b/tests/xfs/194
index 1f83d534..737ae482 100755
--- a/tests/xfs/194
+++ b/tests/xfs/194
@@ -7,7 +7,7 @@
 # Test mapping around/over holes for sub-page blocks
 #
 . ./common/preamble
-_begin_fstest rw auto
+_begin_fstest rw auto mmap
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/550 b/tests/xfs/550
index cecc2ea2..b283231f 100755
--- a/tests/xfs/550
+++ b/tests/xfs/550
@@ -7,7 +7,7 @@
 # Test memory failure mechanism when dax enabled
 #
 . ./common/preamble
-_begin_fstest auto quick dax
+_begin_fstest auto quick dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/551 b/tests/xfs/551
index 72f71e25..4ba19633 100755
--- a/tests/xfs/551
+++ b/tests/xfs/551
@@ -7,7 +7,7 @@
 # Test memory failure mechanism when dax and reflink working together
 #
 . ./common/preamble
-_begin_fstest auto quick clone dax
+_begin_fstest auto quick clone dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/552 b/tests/xfs/552
index facee8cd..c0656761 100755
--- a/tests/xfs/552
+++ b/tests/xfs/552
@@ -8,7 +8,7 @@
 #   test for partly reflinked file
 #
 . ./common/preamble
-_begin_fstest auto quick clone dax
+_begin_fstest auto quick clone dax mmap
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/xfs/559 b/tests/xfs/559
index fb29d208..2d617d7e 100755
--- a/tests/xfs/559
+++ b/tests/xfs/559
@@ -8,7 +8,7 @@
 # buffered write routines.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw mmap
 
 # Import common functions.
 . ./common/inject
-- 
2.47.2


