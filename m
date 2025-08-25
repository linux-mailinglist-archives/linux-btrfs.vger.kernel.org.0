Return-Path: <linux-btrfs+bounces-16323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C269AB33623
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2897A4C64
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF6827A917;
	Mon, 25 Aug 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUQ+FzCi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A423CEF9;
	Mon, 25 Aug 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101881; cv=none; b=fjbaQ/5vE2WuM6FACiUV692ReXv9ipKTk4dkyUHo7I3e1D84VLzRac+fNWosHyi8jUdNQM6G5V5jfkLvqm24M0riybR5eqEbWqsC4CWI3VYSw3g6T30lfI7yVktfPDfIU0dajQk3QHx4oHfwGGr436tRAvOfoPlV7zlIfc0BXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101881; c=relaxed/simple;
	bh=Rn5LyvhfQZqKU7TLc+za7y8sUgrEpHGgroTeryxskxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GeAWbqN1WWgYUqUK4kbFHXVOY0x0FKY5uqDwWvGWJfWOMgwyh/aF65aIL7lGZiKhBzBXXs1zP3QSjvff/KxrKrUMCGBZ6r3XFIJ9KzLn12taYcJe89IkFiDVV6K0r4jqb9sRd13vJ3vH4J55MyGtceRVtJIzpsatfucnPIPSPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUQ+FzCi; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c1d79bd64so438397a12.0;
        Sun, 24 Aug 2025 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101878; x=1756706678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQZrerlouH3jGEaq4qx+O/Pej8Xxtn2iedptXY+EXRs=;
        b=VUQ+FzCiiBZ8s+kbkV2hAaU8augsh/SwqSzqKBO8O+1ArpdwZr0JnT/nPI5jXBviEn
         Y1I6PconAQnkq3oCiKiBpmNAoKSYZ+atAKYg3m3xq3bM1WAXt+wx3MjS2Xmep7cqrYzf
         G/F3nrMt4XGOfUHH9Ec/Ih5fEhiy2FsK7GfUfCsY3FdX8iTgiGWfuioQCsGV8wIqeO/e
         BDWCctOqSIdvYLJ9qlN55NTi5tokGO9PKdbwS2METMFMShPKWcGsKCW6X/LoWl4Grn/X
         N6F/Y77NxSF8LvCmc+OXj0By2x2v47EjdQESn2noRLS2ywmuplEBHk6VkwzkZ0hA0E5Q
         MDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101878; x=1756706678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQZrerlouH3jGEaq4qx+O/Pej8Xxtn2iedptXY+EXRs=;
        b=DzqCQrpUGqyRhRVsN/N+PmkTLGWYIQ82B6Do2Nehj6LDFHYjdqK31/E0vlZIZXVyDS
         /YeRZsN4hn+c7eeNiq4vUUj6UO8no2zuCjgen6zt5Uzk3TgTAqk6w8RRe+3WkYuqx8wd
         MylS6tv4R0S+K8SIC0mFUyRbR052WUu4mPo5W5/+MFFnaL29zboKTCf6Red8lW0cV5bk
         bZ5YJSp0kYOBBuZVOKhKTq/lCI1GSXbDKHJR7EomNZxiP/Nb05ZZLJyF3TanMNLk02TG
         q+xX4O15WzwYNeHeAbSoqIQCEEY6V2jDRIrBDHiMf/QF1J4LUyyU2emS4zvyyBpG+8Zo
         itRg==
X-Gm-Message-State: AOJu0YyO3Koy9KSCwWKyVbHqsAsd/W3ANzWT5Km1cKB4PcxWcaWz10bn
	S6nQkdbJQJNfruVT+mGeP9uT++cfYis/86U61utkFMvQDbu3vtuF3tyvbmuuSg==
X-Gm-Gg: ASbGnctUfAA9tOb1Z9lF2mfeb4pWLcjQru+Q7TuOTYwsZTyZ7bff/YRwxWMCGMGv0H1
	iCm/eI/a5cEOuYTb+ePkuZ7vxz56cLS9saSqLOgAnnn3fk48pvFJ7fPYJatzZqJzIBYEs3VTyH2
	gpaRRnLktGZHKFHIZ3vcHQdvug8R3Dl4LhXC9yjIR8gvTvNnJ4dWH2+8t+NOwYLrMoTOYXlovvY
	1cvOnKkIUVQB4lG0sPbkIDslVp+Ba8a4DrFOxAA5Y+ppZJCqF5HYmEiQ7bSffbPxYLbLCoxG/H7
	c2Q7gA2PEj/i063faL0Hn0qofLoyOsrxtbJp5J78t81d/DzojiJHlld2yU6eWLCY4SIvvyFsrQK
	PoBzPjE2ubjGcH4NJHjAo6aV1GSvwPDpoNqqU
X-Google-Smtp-Source: AGHT+IHxkFuPlUDgdznTqrEG6Nfu7Uev66OBjryQWSq7hsv/3Yon/Vd+N6ZXUpdmwpE9lnmVwX8VGw==
X-Received: by 2002:a17:903:b0d:b0:246:d70e:ea82 with SMTP id d9443c01a7336-246d70eee46mr33237055ad.5.1756101877494;
        Sun, 24 Aug 2025 23:04:37 -0700 (PDT)
Received: from citest-1.. ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm58202485ad.42.2025.08.24.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:04:37 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	fdmanana@kernel.org,
	nirjhar.roy.lists@gmail.com,
	quwenruo.btrfs@gmx.com
Subject: [PATCH v4 3/4] btrfs/137: Make this test compatible with all supported block sizes
Date: Mon, 25 Aug 2025 06:04:10 +0000
Message-Id: <00ea9793911bd951bb2e7bd94ecc0e92ef943540.1756101620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1756101620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For large block sizes like 64k it failed simply because this
test was written with 4k block size in mind.
The first few lines of the error logs are as follows:

     d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar

     File snap1/foo fiemap results in the original filesystem:
    -0: [0..7]: data
    +0: [0..127]: data

     File snap1/bar fiemap results in the original filesystem:
    ...

Fix this by making the test choose offsets and block size as 64k
which is aligned with all the underlying supported fs block sizes.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/137     | 11 ++++----
 tests/btrfs/137.out | 66 ++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/tests/btrfs/137 b/tests/btrfs/137
index 7710dc18..c1d498bd 100755
--- a/tests/btrfs/137
+++ b/tests/btrfs/137
@@ -23,6 +23,7 @@ _cleanup()
 _require_test
 _require_scratch
 _require_xfs_io_command "fiemap"
+_require_btrfs_no_compress
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
@@ -33,12 +34,12 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
 # Create the first test file.
-$XFS_IO_PROG -f -c "pwrite -S 0xaa 0 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xaa -b 64k 0 64K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Create a second test file with a 1Mb hole.
 $XFS_IO_PROG -f \
-     -c "pwrite -S 0xaa 0 4K" \
-     -c "pwrite -S 0xbb 1028K 4K" \
+     -c "pwrite -S 0xaa -b 64k 0 64K" \
+     -c "pwrite -S 0xbb -b 64k 1088K 64K" \
      $SCRATCH_MNT/bar | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
@@ -46,10 +47,10 @@ $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 
 # Now add one new extent to our first test file, increasing its size and leaving
 # a 1Mb hole between the first extent and this new extent.
-$XFS_IO_PROG -c "pwrite -S 0xbb 1028K 4K" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xbb -b 64k 1088K 64K" $SCRATCH_MNT/foo | _filter_xfs_io
 
 # Now overwrite the last extent of our second test file.
-$XFS_IO_PROG -c "pwrite -S 0xcc 1028K 4K" $SCRATCH_MNT/bar | _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xcc -b 64k 1088K 64K" $SCRATCH_MNT/bar | _filter_xfs_io
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
 		 $SCRATCH_MNT/snap2 >/dev/null
diff --git a/tests/btrfs/137.out b/tests/btrfs/137.out
index 8554399f..e863dd51 100644
--- a/tests/btrfs/137.out
+++ b/tests/btrfs/137.out
@@ -1,63 +1,63 @@
 QA output created by 137
-wrote 4096/4096 bytes at offset 0
+wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 0
+wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote 65536/65536 bytes at offset 1114112
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote 65536/65536 bytes at offset 1114112
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 1052672
+wrote 65536/65536 bytes at offset 1114112
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 File digests in the original filesystem:
-3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
-d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
+9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
+fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
+fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
+8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
 
 File snap1/foo fiemap results in the original filesystem:
-0: [0..7]: data
+0: [0..127]: data
 
 File snap1/bar fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
 
 File snap2/foo fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
 
 File snap2/bar fiemap results in the original filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
 
 At subvol SCRATCH_MNT/snap1
 At subvol SCRATCH_MNT/snap2
 At subvol snap1
 
 File digests in the new filesystem:
-3e4309c7cc81f23d45e260a8f13ca860  SCRATCH_MNT/snap1/foo
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap1/bar
-f3934f0cf164e2efa1bab71f2f164990  SCRATCH_MNT/snap2/foo
-d3dc847171f9081bd75d7a2d3b53d322  SCRATCH_MNT/snap2/bar
+9802287a6faa01a1fd0e01732b732fca  SCRATCH_MNT/snap1/foo
+fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap1/bar
+fe93f68ad1d8d5e47feba666ee6d3c47  SCRATCH_MNT/snap2/foo
+8d06f9b5841190b586a7526d0dd356f3  SCRATCH_MNT/snap2/bar
 
 File snap1/foo fiemap results in the new filesystem:
-0: [0..7]: data
+0: [0..127]: data
 
 File snap1/bar fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
 
 File snap2/foo fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
 
 File snap2/bar fiemap results in the new filesystem:
-0: [0..7]: data
-1: [8..2055]: hole
-2: [2056..2063]: data
+0: [0..127]: data
+1: [128..2175]: hole
+2: [2176..2303]: data
-- 
2.34.1


