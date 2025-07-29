Return-Path: <linux-btrfs+bounces-15727-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69113B14823
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6F17D07D
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC2224A043;
	Tue, 29 Jul 2025 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYuEU8b5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A892AD2C;
	Tue, 29 Jul 2025 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770233; cv=none; b=sZyHS+YaIiRIr4cN5hGmiGBxFP0bCBdtGDVel1SCMmC4E0kxTOzNYK4B2RQXdwqvXZa7JIjw8Jrw35JaRHs0zPPaQ1HNmiZPT5VAxO87T5JmuYR9hACy84zjwpsQDGMFIQ0vCapQVEuEJvjU+tFeknwDdSooy+9+UBy4AmRrCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770233; c=relaxed/simple;
	bh=P+zeyk0bPDBL+sVr99P4aLe0VwhMDkEv4uptorMhdus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQPQEKvbvhpb72+Lka8nssbD+rUfm7fK8Qg0y44mHZYj0TbqGIJVAN3d5IN6W3NhmikgDl9pHB7Jda7KLePjDOOZyENxJLFOBsKzanNnxm3H/a8Zz5SJV0hvnmJoKx287ifJfA41OaUnJohiLzfaB1U3h7TOrnGjSBY03WYUWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYuEU8b5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2405c0c431cso9417505ad.1;
        Mon, 28 Jul 2025 23:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770231; x=1754375031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csZne8ty6kG9OG7UpMHq7rhZFpjrWvXM+J1EH2b9WN0=;
        b=TYuEU8b5vdoFTBuWKs9eqY+1vxFPmy5crFRjwKeqP0u+Bn35VP9w4ly4gcJv6SBgpG
         cKM5Kbpov1rnacYxxI9LyjsfjZ42+uP9Oro3M2nLi4moPkLWe7xxN1YQSD/NLE3qReLY
         PLz4L66jP4pD3RZAbHwfx15m24J3c6j6b4/rL2bOPLE1Txh9LXqAaB6YphbZn2yHc0Ec
         rJUEerXeaIprcdqq4xsnhvoJqpiLbQIHluBArE9GyQh3KVlTdmR0g8CcbnKeffNNDyVe
         Tn18XBpwMipYAPgvivUiprZr4pWU5LBYWCG/8YYCdreQrrQkzgSJwM1qkDFqhP2Qaf4j
         DwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770231; x=1754375031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csZne8ty6kG9OG7UpMHq7rhZFpjrWvXM+J1EH2b9WN0=;
        b=laWaZ3FblLdmjwpb4/X6f1nWVG6p0nfvAgpSxLQ2PueUTHmxExrasdXpytNzYDr/Th
         Y/o5q2Pki07SrKSHc6PGPSAKAOwgecJXWAkLa8DI82jS+EWTGth4j5OmUsCnPbQ8zNrP
         YLYdwOmAI7ZNWTwBv/2wXnyMIF8kjrijxkry4jD682GmunWNzm3efKV4H8oqsw8zMKCK
         ziCI895wucy3cASaT9q7Z+5jNESTCSh2HA0aaoZyz9Jt69iGXhoe9StvBskAae2sOUVG
         CW3y6N70S59IxKA8yD1fCM5tycuV1JAy9i4Z79cPbM0+zW/bdLuzB04ZTPguXDMPRX27
         Wgew==
X-Gm-Message-State: AOJu0YxXt7gvtBapkJvRQ/MIhuRZii0AUfPyogzFJDuAmK9671m2LcO5
	Q7OriBne4quYK/f3jTi/DXihbIcJ+BvJ+Tm1ys4z3KY8padxs0ITWkel+2ByAw==
X-Gm-Gg: ASbGncsQ9wCmsFUVCncOSKCOQur31xleG4h/nKbRLdbXUP9A9L/LhHl7E2laQVPqP5U
	1bd71N97DsAIWXCrBe4zSulUxB7eklMypd3GElBfnhDYdSuy4gLv4ntW1NhdsMgLam6J1QYfWH9
	aAXJox6zIwnHtbagEkTYgxyYl05V/tr7QqQSuDWgUFOhr9NfQZPkQWw0WhdiaZPLJNIFj8z0XbI
	ZaloxUO59m0Sman5Vw+ODRLBAQhU+8RaxIHnPtsfmWGDjeTrpZ4JLNT3zZ4/9gL49xp7xEFSiZm
	HbrjufK7oHKXVX9VAULFt2yGQnWC+zse1fk/3X+4yn6nrD5jpb56JZEMvhaf8XDssPRy+ZVlss8
	JOtV7EqFpTC2OkOAiV5f4otE=
X-Google-Smtp-Source: AGHT+IHN4Q7/NuJieURTfQ/WYPxuGepHlVQ4dk2BH2oQDxf/qyfm3yqme1N3hiGCdZjqwjl1gjs5EA==
X-Received: by 2002:a17:902:db03:b0:240:a05:5b79 with SMTP id d9443c01a7336-2400a055d69mr104861725ad.44.1753770230724;
        Mon, 28 Jul 2025 23:23:50 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:23:50 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 3/7] btrfs/137: Make this compatible with all block sizes
Date: Tue, 29 Jul 2025 06:21:46 +0000
Message-Id: <991278fd7cf9ea0d5eed18843e3fb96b5c4a3cac.1753769382.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For large blocksizes like 64k on powerpc with 64k pagesize
it failed simply because this test was written with 4k
block size in mind.
The first few lines of the error logs are as follows:

     d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar

     File snap1/foo fiemap results in the original filesystem:
    -0: [0..7]: data
    +0: [0..127]: data

     File snap1/bar fiemap results in the original filesystem:
    ...

Fix this by making the test choose offsets based on
the blocksize. Also, now that the file hashes and
the extent/block numbers will change depending on the
blocksize, calculate the hashes and the block mappings,
store them in temporary files and then calculate their diff
between the new and the original filesystem.
This allows us to remove all the block mapping and hashes
from the .out file.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/137     | 135 +++++++++++++++++++++++++++++---------------
 tests/btrfs/137.out |  59 ++-----------------
 2 files changed, 94 insertions(+), 100 deletions(-)

diff --git a/tests/btrfs/137 b/tests/btrfs/137
index 7710dc18..61e983cb 100755
--- a/tests/btrfs/137
+++ b/tests/btrfs/137
@@ -27,53 +27,74 @@ _require_xfs_io_command "fiemap"
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
 rm -fr $send_files_dir
-mkdir $send_files_dir
+mkdir $send_files_dir $tmp
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
+blksz=`_get_block_size $SCRATCH_MNT`
+echo "block size = $blksz" >> $seqres.full
+
 # Create the first test file.
-$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xaa -b $blksz 0 $blksz" $SCRATCH_MNT/foo | _filter_xfs_io | \
+	_filter_xfs_io_size_offset 0 $blksz
 
 # Create a second test file with a 1Mb hole.
 $XFS_IO_PROG -f \
-     -c "pwrite -S 0xaa 0 4K" \
-     -c "pwrite -S 0xbb 1028K 4K" \
-     $SCRATCH_MNT/bar | _filter_xfs_io
+ 	-c "pwrite -S 0xaa -b $blksz 0 $blksz" \
+ 	-c "pwrite -S 0xbb -b $blksz $(( 1024 * 1024 + blksz )) $blksz" \
+ 	$SCRATCH_MNT/bar | _filter_xfs_io | \
+	_filter_xfs_io_size_offset "$(( 1024 * 1024 + blksz ))" $blksz | \
+ 	_filter_xfs_io_size_offset 0 $blksz
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 	$SCRATCH_MNT/snap1 >/dev/null
 
 # Now add one new extent to our first test file, increasing its size and leaving
 # a 1Mb hole between the first extent and this new extent.
-$XFS_IO_PROG -c "pwrite -S 0xbb 1028K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xbb -b $blksz $(( 1024 * 1024 + blksz )) $blksz" $SCRATCH_MNT/foo \
+	| _filter_xfs_io | _filter_xfs_io_size_offset "$(( 1024 * 1024 + blksz ))" $blksz
 
 # Now overwrite the last extent of our second test file.
-$XFS_IO_PROG -c "pwrite -S 0xcc 1028K 4K" $SCRATCH_MNT/bar | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xcc -b $blksz $(( 1024 * 1024 + blksz )) $blksz" $SCRATCH_MNT/bar \
+	| _filter_xfs_io | _filter_xfs_io_size_offset "$(( 1024 * 1024 + blksz ))" $blksz
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 		 $SCRATCH_MNT/snap2 >/dev/null
 
-echo
-echo "File digests in the original filesystem:"
-md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
-md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
-md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
-md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
-
-echo
-echo "File snap1/foo fiemap results in the original filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap
-echo
-echo "File snap1/bar fiemap results in the original filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap
-echo
-echo "File snap2/foo fiemap results in the original filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap
-echo
-echo "File snap2/bar fiemap results in the original filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap
-echo
+echo >> $seqres.full
+
+echo "File digests in the original filesystem:" >> $seqres.full
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch >> $tmp/snap1_foo.original.hash
+cat $tmp/snap1_foo.original.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch > $tmp/snap1_bar.original.hash
+cat $tmp/snap1_bar.original.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch >> $tmp/snap2_foo.original.hash
+cat $tmp/snap2_foo.original.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch > $tmp/snap2_bar.original.hash
+cat $tmp/snap2_bar.original.hash >> $seqres.full
+
+echo >> $seqres.full
+
+echo "File snap1/foo fiemap results in the original filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap > $tmp/snap1_foo.original.map
+cat $tmp/snap1_foo.original.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap1/bar fiemap results in the original filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap > $tmp/snap1_bar.original.map
+cat $tmp/snap1_bar.original.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap2/foo fiemap results in the original filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap > $tmp/snap2_foo.original.map
+cat $tmp/snap2_foo.original.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap2/bar fiemap results in the original filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap > $tmp/snap2_bar.original.map
+cat $tmp/snap2_bar.original.map >> $seqres.full
+echo >> $seqres.full
 
 # Create the send streams to apply later on a new filesystem.
 $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1 2>&1 \
@@ -90,25 +111,47 @@ _scratch_mount
 $BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT >/dev/null
 $BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT >/dev/null
 
-echo
-echo "File digests in the new filesystem:"
-md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
-md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
-md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
-md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
-
-echo
-echo "File snap1/foo fiemap results in the new filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap
-echo
-echo "File snap1/bar fiemap results in the new filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap
-echo
-echo "File snap2/foo fiemap results in the new filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap
-echo
-echo "File snap2/bar fiemap results in the new filesystem:"
-$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap
+echo >> $seqres.full
+echo "File digests in the new filesystem:" >> $seqres.full
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch > $tmp/snap1_foo.new.hash
+cat $tmp/snap1_foo.new.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch > $tmp/snap1_bar.new.hash
+cat $tmp/snap1_bar.new.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch > $tmp/snap2_foo.new.hash
+cat $tmp/snap2_foo.new.hash >> $seqres.full
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch > $tmp/snap2_bar.new.hash
+cat $tmp/snap2_bar.new.hash >> $seqres.full
+
+diff $tmp/snap1_foo.new.hash $tmp/snap1_foo.original.hash
+diff $tmp/snap1_bar.new.hash $tmp/snap1_bar.original.hash
+diff $tmp/snap2_foo.new.hash $tmp/snap2_foo.original.hash
+diff $tmp/snap2_bar.new.hash $tmp/snap2_bar.original.hash
+
+echo >> $seqres.full
+
+echo "File snap1/foo fiemap results in the new filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/foo | _filter_fiemap > $tmp/snap1_foo.new.map
+cat $tmp/snap1_foo.new.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap1/bar fiemap results in the new filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap1/bar | _filter_fiemap > $tmp/snap1_bar.new.map
+cat $tmp/snap1_bar.new.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap2/foo fiemap results in the new filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/foo | _filter_fiemap > $tmp/snap2_foo.new.map
+cat $tmp/snap2_foo.new.map >> $seqres.full
+echo >> $seqres.full
+
+echo "File snap2/bar fiemap results in the new filesystem:" >> $seqres.full
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap2/bar | _filter_fiemap > $tmp/snap2_bar.new.map
+cat $tmp/snap2_bar.new.map >> $seqres.full
+
+diff $tmp/snap1_foo.new.map $tmp/snap1_foo.original.map
+diff $tmp/snap1_bar.new.map $tmp/snap1_bar.original.map
+diff $tmp/snap2_foo.new.map $tmp/snap2_foo.original.map
+diff $tmp/snap2_bar.new.map $tmp/snap2_bar.original.map
 
 status=0
 exit
diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
index 8554399f..ea9f426c 100644
--- a/tests/btrfs/137.out
+++ b/tests/btrfs/137.out
@@ -1,63 +1,14 @@
 QA output created by 137
-wrote 4096/4096 bytes at offset 0
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 0
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-File digests in the original filesystem:
-3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
-d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
-
-File snap1/foo fiemap results in the original filesystem:
-0: [0..7]: data
-
-File snap1/bar fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-
-File snap2/foo fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-
-File snap2/bar fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-
 At subvol SCRATCH_MNT/snap1
 At subvol SCRATCH_MNT/snap2
 At subvol snap1
-
-File digests in the new filesystem:
-3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
-d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
-
-File snap1/foo fiemap results in the new filesystem:
-0: [0..7]: data
-
-File snap1/bar fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-
-File snap2/foo fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-
-File snap2/bar fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
-- 
2.34.1


