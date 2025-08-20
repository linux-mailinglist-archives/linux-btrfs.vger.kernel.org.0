Return-Path: <linux-btrfs+bounces-16174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA109B2D5EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F20A0259F
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B92D8762;
	Wed, 20 Aug 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lItI5sDA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E02D6E56;
	Wed, 20 Aug 2025 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677741; cv=none; b=n0Anz/g5Qgagp7I/gtFE3VH4AZVnmBPnSdjVRpkMIXvnped9Gy99Aich1hFaKQ1hokp1RzLVcxBYz7tLu2f8fSvWXSirWMXgX15eWI9H9D+/dZHpo1EVu6btFQiAkp+C2AElneyy3eZ7I4lo5/oYobTRQ8Swil570HoVDf6foA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677741; c=relaxed/simple;
	bh=TfvpQGPgjpvUiflLkUWa+NACrDQlyYyGq3+JabvkssM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o98yEyJkOZd+uVc6tcOyc/XvK4Tb//GI9Kf6hhn+22EoME2zhdaDvzOhUyh5gz1RFCHdKklvnKRXkkxV15kcAjEu1ACr6jXSddo8JmW1+gB1aLNrbOWNoHGgNsVfEpuDDbqd3wOyQaOX8eO3fjr73kPc/UodZ0n4Wlxw6OACapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lItI5sDA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4761f281a7so755423a12.1;
        Wed, 20 Aug 2025 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755677738; x=1756282538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNOnC3XRipxEzRokR5XERnvHc+6b2R72yeP/TsnqwTE=;
        b=lItI5sDATBw2xmRr+P1O6sQPCy6tSKUa4rz4XJxLifRrkeTA9Ugs2GLUS81IXV2dkm
         4eMtZpDMxD5IdiZYMM0IP1SokohYNfYLygoAb4F0+P9I6Aj0cv4dQohWzzCjRr3bN1P2
         Q7C7tbDov3/bIKwyQTsy5IzAWbrECGtz542bxT9Wk9o6o6szqNqGKaTXDMM3iZUO5OEk
         uXmjNB05Kq0A1XCjfxt8WSF3cpSGFI8bL67sKpVjTo5czANMxAF396Jin4MnMf5+8I09
         efeGroi4+pIJubdOobqAhwaA6ZbmYMjRWpQuniyGJ/mG8sDFgF6qPvu7lpKeuF2zC+CH
         2grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677738; x=1756282538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vNOnC3XRipxEzRokR5XERnvHc+6b2R72yeP/TsnqwTE=;
        b=P//Bn/5P5sMKl9nEtPnM0XC0PFEoMILMj2jqRMfg2TxiWNXUZ4Boupm0sRs6riBwzH
         LJ/uRIdH92fKYnTiCOd6r/1NTQsPFKvHES5nrF4Z4WDRtaRPo3kwRvRM3cPcn0YZoqE1
         A8HXxzIVkbEpnefs9xFl/MMsNru7Ex3Ib05lZvi5Vq999/sOS4lg0WdZuYxizz5Y/klh
         urvQwHMRAbwDCzkvG4rttKHalCaxrUKFO/e1gAG65oGKLwu2Ka6LhjnU1Hw+QJA+tMTC
         zifm2avdJtdqMHl1qTlc4we2jZCvCWxdvM+/3FXES1qFHno5wSAuMMlKuj80QHxL+Jap
         RqcA==
X-Gm-Message-State: AOJu0Yz3UBeYd3kIHz6MVacIuQHPZo5Ch2XPbQM007bBbMvxFuMGQoK4
	fjntnjzWFuqAA5yZBVPu51tk3GqhkljVpvyJsgsYd1VHkzAV6NnICU/IYq9E7Q==
X-Gm-Gg: ASbGncseK2NJ0Rd6aOmSzPDUtooVvFga8JOTQR0H3kUKJpLlEfvZh5XI7ZPxm1iT7zq
	0fExBF7RMIxj1Oj8DNj0fSWVh8JyyNcw2EkwV77E6lnRxVZMaSeiEJAxc9wfsRC3Da1+03cIJNK
	8bYDWTgH0AxKM5IepY3TFTptpWzLRhVo5YNwiO6MaEVp6k0Ai7aP6axkNzP2KrtXU21XfnpV0gU
	cnwzboyE4q6ptfwxi8ALRMaTSH85IrXJCoGuq7kjoTVOQJIGq4xAngZr75xAJtg4MWQBHKCsJ2q
	lor/N5ZgHDzFmtaIiRDrkyccqzmOcWzYdt3cK9ZEakn7CfzwVynAoOs3TdzKmGOV5wDn7wxZeK+
	HoEA9uvmxv9IzwwVVpLtnuxRJQQ==
X-Google-Smtp-Source: AGHT+IEHg0CajAcHJpKfea4w3Q9ZglHEOzx1o+ARffZTVOdxLWYbCGw9VKs40RpQGSZgzhi8bLJUxg==
X-Received: by 2002:a17:903:1aac:b0:235:2ac3:51f2 with SMTP id d9443c01a7336-245ef27b007mr24293385ad.45.1755677738360;
        Wed, 20 Aug 2025 01:15:38 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed517beesm18848935ad.134.2025.08.20.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:15:37 -0700 (PDT)
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
Subject: [PATCH v3 3/4] btrfs/137: Make this test compatible with all supported block sizes
Date: Wed, 20 Aug 2025 08:15:06 +0000
Message-Id: <88dcfb6cea422cebc5bbdcd4a0ba912f9c8666fa.1755677274.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755677274.git.nirjhar.roy.lists@gmail.com>
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


