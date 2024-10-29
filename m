Return-Path: <linux-btrfs+bounces-9204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE899B5048
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 18:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABFCCB23899
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 17:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07871DA305;
	Tue, 29 Oct 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APVPAV/e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B352107;
	Tue, 29 Oct 2024 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222500; cv=none; b=GP9OUB/8j/HN+CNFbTLBM7nmbWa9QbaO3wLrOq5kifZCSQWCcOs3sIAG1MnJU24II4rImfRmvv2tB92c2B/XfBbCYFJ6r8cVzuszqJbfDR3wdiglHMOA/5DJ8XFiOqbCJ5rK0XW/Gkso7IkKUeIDBiuyr2l61tubJaOTyQp5Afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222500; c=relaxed/simple;
	bh=XTsCuCplk8PIiGawEiuyFeCluFtEuir9Fx9kgnKvV2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVn3XuYs2iUdL9xhsmDMK/LlA9tm4m5YFQT/ov84SYKSbBi4hC7efVTlE/vJddHxecQgNqUAeTdLbjuvLvuOW2pXVGD8rMBskGpEJJUk8ZW9WLsDIYjPBPz6m+7ctdqU4G8uXE5Oe3BmCANUL4xwHOlNpL3u8D/I6R8i7PRGrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APVPAV/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896F2C4CEE4;
	Tue, 29 Oct 2024 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222499;
	bh=XTsCuCplk8PIiGawEiuyFeCluFtEuir9Fx9kgnKvV2w=;
	h=From:To:Cc:Subject:Date:From;
	b=APVPAV/e3k797qj8d2etCxQbBUK393zA4FwMXXjDNb8n0Qa4zOu6RqAy02TSZ5ZMD
	 moC6Jjw5NPsOFuQUHQ3q9XO8TzzkGZwVLnA8nhlq38SQknRj3Zf3tCF0TbQZRYn0wc
	 JtC7XvEsl2Ou6Ts2oZp7Pn+xvNjx9OmFKr9ra9Wv//T38PRyjEnNzmdwdX0bLRdjZO
	 S19KkIoPp39A5tOVXjlfyMvzzfuu3XOcmKmYd7C9YMuR1ZerdI+lOuMBHFH1RZTK7K
	 m/wLXl5FqQL3i5WD5+4xCEHrCE3riBIC469DhdAxilf8mBAkVr98jQZVICtL+/H156
	 SCv+QUmwlEKKA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/287: make the test work when compression is enabled
Date: Tue, 29 Oct 2024 17:21:28 +0000
Message-ID: <9991dab5ca241c17f531f49dab5dbaa6e9146c45.1730220754.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When running btrfs/287 with compression enabled (mount options), the test
fails because it expects to find 4M extents, however compression limits
the maximum size of extents to 128K, breaking the tests' expectations.

Example:

  $ MOUNT_OPTIONS="-o compress" ./check btrfs/287
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.12.0-rc4-btrfs-next-177+ #1 SMP PREEMPT_DYNAMIC Thu Oct 24 17:14:37 WEST 2024
  MKFS_OPTIONS  -- /dev/sdc
  MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

  btrfs/287 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad)
      --- tests/btrfs/287.out	2024-10-19 18:21:30.451644840 +0100
      +++ /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad	2024-10-29 16:31:20.926612583 +0000
      @@ -25,22 +25,14 @@
       resolve first extent with ignore offset option:
       inode 257 offset 16777216 root 5
       inode 257 offset 8388608 root 5
      -inode 257 offset 2097152 root 5
       resolve first extent +1M offset:
      -inode 257 offset 17825792 root 5
      -inode 257 offset 9437184 root 5
      ...
      (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/287.out /home/fdmanana/git/hub/xfstests/results//btrfs/287.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        0cad8f14d70c btrfs: fix backref walking not returning all inode refs

  Ran: btrfs/287
  Failures: btrfs/287
  Failed 1 of 1 tests

Fix this by creating the two 4M extents with fallocate, so that the test
works regardless of compression being enabled or not.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/287     | 10 +++++-----
 tests/btrfs/287.out |  4 ----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tests/btrfs/287 b/tests/btrfs/287
index e88f4e0a..a51b31ed 100755
--- a/tests/btrfs/287
+++ b/tests/btrfs/287
@@ -7,13 +7,14 @@
 # Test btrfs' logical to inode ioctls (v1 and v2).
 #
 . ./common/preamble
-_begin_fstest auto quick snapshot clone punch logical_resolve
+_begin_fstest auto quick snapshot clone prealloc punch logical_resolve
 
 . ./common/filter.btrfs
 . ./common/reflink
 
 _require_btrfs_scratch_logical_resolve_v2
 _require_scratch_reflink
+_require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 
 # This is a test case to test the logical to ino ioctl in general but it also
@@ -42,10 +43,9 @@ _scratch_mount
 #
 # 1) One 4M extent covering the file range [0, 4M)
 # 2) Another 4M extent covering the file range [4M, 8M)
-$XFS_IO_PROG -f -c "pwrite -S 0xab -b 4M 0 4M" \
-	     -c "fsync" \
-	     -c "pwrite -S 0xcd -b 4M 4M 8M" \
-	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -f -c "falloc 0 4M" \
+                -c "falloc 4M 4M" \
+                $SCRATCH_MNT/foo
 
 echo "resolve first extent:"
 first_extent_bytenr=$(_btrfs_get_file_extent_item_bytenr "$SCRATCH_MNT/foo" 0)
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
index 4814594f..48541f7e 100644
--- a/tests/btrfs/287.out
+++ b/tests/btrfs/287.out
@@ -1,8 +1,4 @@
 QA output created by 287
-wrote 4194304/4194304 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 8388608/8388608 bytes at offset 4194304
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 resolve first extent:
 inode 257 offset 0 root 5
 resolve second extent:
-- 
2.45.2


