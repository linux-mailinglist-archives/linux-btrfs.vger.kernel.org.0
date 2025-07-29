Return-Path: <linux-btrfs+bounces-15728-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B882B14824
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 08:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A9716BFF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jul 2025 06:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E524A043;
	Tue, 29 Jul 2025 06:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLUg7ILz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CE2AD2C;
	Tue, 29 Jul 2025 06:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770254; cv=none; b=PDUS/lhWGgHppyuWUqN/29c5F4cUT5yydFsawks89LJKX5eAAA+IqIX4iXL4ww5psxf+jompNG+KePhn7XfGBU3mIiDjMJvP2XnW3d7bdEN9rDJ1cVC6dz7h5u0wvD2j1r6xmf1UYfO9E1wcFKIy4QA9USZKRzZ6Ic7SX5OeVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770254; c=relaxed/simple;
	bh=KiAbhfOjSD4KBj8/xTObSH35YcOjwriX+GKbDeQOUvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IikoneBfsxbv3ZGQxjl5S1UZgB2MLrgrA9bKNrSJ/Ror9BnsImJzVdxKDdNu2nu5xRoupuyHqzOlDtPRm8Rue4aHpXz+pN/o9+DzUT0BlL9J6WmYebr6m5j1TE6kHR3/sgcjXN+12T06kHUQAbXR2yBXys5yRdBqVihmSJ6Thmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLUg7ILz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23ffa7b3b30so22216655ad.1;
        Mon, 28 Jul 2025 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753770252; x=1754375052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJjpaWg9wgoVc8ZgZIJt26xPcbfqrXfE/q8hBTKbVmY=;
        b=mLUg7ILz9mh9vTTJ2HrMqVsdO7RnS6f7+AE5XgUpDLUDWzf5VHcjXkGCYpvnRc5RfS
         xM4aFLooTIs9bADd3rrytY6akD4JyMgC6vFfKBUTCB7OjLB5DAx6V5qaJjRm4prh2GIY
         BIRtQ6V3bz2TQlMhPZPssWktbsW+ACg3hVqpDv0mgY1hQxGcQN9ghHogg8ZdkZEi82YU
         De7HLcpMS25ap8NU7YxIM1fKx8Bg8IMCN4iJVvTuSGULIizWDHEvTZLDRrPXfffkw/YT
         UGZDa/4uEIphUFsMMk9X/05+/ANGgmGhwPtEnVU+A2dH2tgGP9xmfWS0ynKoW/uD62V6
         IzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770252; x=1754375052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJjpaWg9wgoVc8ZgZIJt26xPcbfqrXfE/q8hBTKbVmY=;
        b=frHxbB6f8vj3AQtf2qC/fjcLyTt2KeVtRWu21CjU2Tuwe5TkIHF/OwQKYQgIJ4YyDg
         IiwdZlMhJQzSe7R55wW3/K16nJbJ2PQ7+g3sUfrOgkzc0ibmDsxiG0SWDSiIo3+OA7um
         xtb0NZ3w7cK2BaaN2e23hUpKWXVAT/cCdZGTDKf+ew/Ppkhdxrx9+GXe+kDL7aI+LwBj
         l+JoUDUfLZiL5vD9ccSm5qDP4VuFKjKamyPnRq6UvL3daqMSm26m9wpFR1BgFQ+F8tqD
         u/YRfpWXjrvTjnGjAwFxWjA8UkjsCV6zxMUhkUR9UlWhF6k4ONlEZ4YQ1egcO12UA2Oe
         5ULA==
X-Gm-Message-State: AOJu0Yxk5RMgGINEiiRX0ce545+40LtLHyaYuWBuUpcaJq9VtnE9QHxI
	1d4RYjWa4osl6OuJW1iR9hTsWevyBHoIafSZVO1uakf5YeoXMFA3kfhJ60Am7Q==
X-Gm-Gg: ASbGnct1yGZ+zgNB+TM7UTWGoT1iEKdgi1W1qGIpqhJXBRvuxmp8GnoKl/eFczQyfvC
	B/DS5ZoEJtLobyuSlcneolQSZgO3JCiRmk+Iz6xfvZJ0/qIcNkXpOjQKTLrtF0oUO+7x0/AI84G
	twFbei7nM/i7mP0G+Ye2p7TLhKTP3XWx7fO4td/LzZhPGcE4RMT8pDcn5pCS/HDcwe0QA/9nv/W
	jKkyr0xc4G1LliZ87aB+I1w9TZg50DG6L5i7snX3rSHI+4OPRclmvSqbhP61M2HmtJX++/6mIxL
	stAmFh6HeIjE5DROvwsJQ849L7ZYhOQzyHLRM4g5vXLCsJhViYkFrVMjM94VmkOettMjUYO23MG
	55Gapvl+MsTRaQbwIzDFSRaA=
X-Google-Smtp-Source: AGHT+IFVDjFwbPV+WKdhpDFg1QDCwRPWUODawyWPdD0DxfClWKh/4oSpd9aG1NIsHPvzFiLiM/mTEg==
X-Received: by 2002:a17:902:e547:b0:240:3c0e:e8c3 with SMTP id d9443c01a7336-2403c0eec24mr79167305ad.51.1753770252242;
        Mon, 28 Jul 2025 23:24:12 -0700 (PDT)
Received: from citest-1.. ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc1adcd24sm65941195ad.167.2025.07.28.23.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 23:24:11 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH 4/7] btrfs/200: Make this test scale with the block size
Date: Tue, 29 Jul 2025 06:21:47 +0000
Message-Id: <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
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

For large block sizes like 64k on powerpc with 64k
pagesize it failed because this test was hardcoded
to work with 4k blocksize.
With blocksize 4k and the existing file lengths,
we are getting 2 extents but with 64k page size
number of extents is not exceeding 1(due to lower
file size).
The first few lines of the error message is as follows:
     At snapshot incr
     OK
     OK
    +File foo does not have 2 shared extents in the base snapshot
    +/mnt/scratch/base/foo:
    +   0: [0..255]: 26624..26879
    +File foo does not have 2 shared extents in the incr snapshot
    ...

Fix this by scaling the size and offsets to scale with the block
size by a factor of (blocksize/4k).

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/200     | 24 ++++++++++++++++--------
 tests/btrfs/200.out |  8 ++++----
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tests/btrfs/200 b/tests/btrfs/200
index e62937a4..fd2c2026 100755
--- a/tests/btrfs/200
+++ b/tests/btrfs/200
@@ -35,18 +35,26 @@ mkdir $send_files_dir
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
+blksz=`_get_block_size $SCRATCH_MNT`
+echo "block size = $blksz" >> $seqres.full
+
+# Scale the test with any block size starting from 1k
+scale=$(( blksz / 1024 ))
+offset=$(( 16 * 1024 * scale ))
+size=$(( 16 * 1024 * scale ))
+
 # Create our first test file, which has an extent that is shared only with
 # itself and no other files. We want to verify a full send operation will
 # clone the extent.
-$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
-	| _filter_xfs_io
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
-	| _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b $size 0 $size" $SCRATCH_MNT/foo \
+	| _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $offset $size" $SCRATCH_MNT/foo \
+	| _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
 
 # Create out second test file which initially, for the first send operation,
 # only has a single extent that is not shared.
-$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
-	| _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $size 0 $size" $SCRATCH_MNT/bar \
+	| _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
 
@@ -56,8 +64,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 # Now clone the existing extent in file bar to itself at a different offset.
 # We want to verify the incremental send operation below will issue a clone
 # operation instead of a write operation.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
-	| _filter_xfs_io
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 $offset $size" $SCRATCH_MNT/bar \
+	| _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
 
 _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
 
diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
index 306d9b24..4a10e506 100644
--- a/tests/btrfs/200.out
+++ b/tests/btrfs/200.out
@@ -1,12 +1,12 @@
 QA output created by 200
-wrote 65536/65536 bytes at offset 0
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 65536/65536 bytes at offset 65536
+linked SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 0
+wrote SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/base
-linked 65536/65536 bytes at offset 65536
+linked SIZE/SIZE bytes at offset OFFSET
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 At subvol SCRATCH_MNT/incr
 At subvol base
-- 
2.34.1


