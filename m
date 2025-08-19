Return-Path: <linux-btrfs+bounces-16157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E48B2C28C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 14:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A26A7A99C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1374832BF3B;
	Tue, 19 Aug 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCEPU2mE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13F1C8603;
	Tue, 19 Aug 2025 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604937; cv=none; b=EgWKJ03rNTfME2omrdZVHWfmdyYvihTaoOQ4bYU6/Ug0slJMpRA3yCXY3nRHSfJaf9mvnKTR1NgY6SFdZ+wGssb5zcPKnVfGCs5djqAMoBHRNLrO9tkudSA3XvJQQdF+6NRaTrW99f68dMsQWl9zMv/Q5MbMngdTVER0HT/tnUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604937; c=relaxed/simple;
	bh=+CTixfK1oDtff6j9WqB85R1UONXK4Zsqrt1GcB4Luo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYK4+KpdwksawnVpoXAOrWOOSSTZ4gMrZClg+XC9RdbBenTiue1GXlhHFP+5LihMdXgXvObWC6oFbEnd95nxAG57LxO0oG6KS/FQlyHCWIgmbUXLf0rTWiQURUAqMSRFrF6sizuSehe6fHtuX+6HXBip0NBhlTEzqzMfDbZM3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCEPU2mE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e6cbb9956so1499100b3a.0;
        Tue, 19 Aug 2025 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604935; x=1756209735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaEe6rnAsb51fI+Ss8wi0smT8V6m5hQEzxjpc6JWrtw=;
        b=PCEPU2mEJnF/bZtpz1XxHUhS7p6+YOglBlj4EoCblsxPCYLIeIfMXB+nSpXu0Cw5P8
         9kOwBIM2k9tsS/dIXVPzGY3/mCNiwL+tM4NNL75ejhg5JLAieZFxauMO/T10GfJUkwr5
         3C3iyIA7TgaYkcmd0cNFxxQwW5WtuWs0gYdlWhOezDrphqMPEIRUygRowWWoiHRKsAn4
         94s5s9NPjVzsHq+CANb5ETBrINVdBmsZxzoVh+9TFtX4KoW6Y1CR5TWqEqDqs+2zt0Yp
         4TBYZFczbBQPgh/3BeZPVt5YSNlhaCSEWunjgEuv5TcMggAcyjovlxeKn50n7vTEmaMq
         VwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604935; x=1756209735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zaEe6rnAsb51fI+Ss8wi0smT8V6m5hQEzxjpc6JWrtw=;
        b=fsjfwrR9q524FUw/Nnm225ZkSf78hVn5AOONb0K3G5tZWjD8ww/YdT7pO6nor7vcrC
         gBjsIBKL5HjAjBMTdxV2rKwHEGv8zGUQ9dENV9hR5XJKZVbEDs4wuQrFWwmhNv8jxxOQ
         xoL0fI9hDxJ/KZJGSq7QHAtiwixr8PkD8Y4nj0EPQ9ZdJj0d7q0X+enIpakl7SHeZGl1
         zury8iL2YJeUZhD7boRVtRdz8pNFEdHPaud1fpCHE/xkjvJANLiWxgohE1dxEgCaWl+z
         rPUYiprRGMqDpur31ItaQwbrRH/1sLLJYTr8c6pY0lDAJVtrfSaZq/JzE+aeEPuWGGDx
         v4eA==
X-Gm-Message-State: AOJu0YyxF8YThbtWFTq+ataWuHS/7f9i28dKCaj6W0YhhUoYK/LKl7rh
	4YAnitHFjd2v/aF1YCOTqH2UEWV8l101IEC+CVel53ovNRU1QdUSTw9DGkuUVQxK
X-Gm-Gg: ASbGncs7BjuI+GxZyDXslW37HdjBkMyDg26UlXGEnSInoGKik1ZsWpvTTz6wWtBVejo
	KG3urrIxGqnOc/skbX5j1G1qfJBD0kw5Adg3fxkrDaCj3y1+zN3PFrrskFnmfCCyNWiIjIZRck5
	AQ2Qujh0ZoCWxFhlOlvYUuoVSceqcky9jDzdug361P2fpuMYoG1Ap4Ndvs3YDDYUqxEN3u/r54p
	R49k62PhKg4twYevJSIQ3KzKzPQaTGiRAyHvVrrsmlKKdLO9ty8rRNuveJlgpl7BdUozM998U6n
	xMyee0iuWlV9F/gGZga5KK8pUynTVtvmZVUjNffKwjKKDYcP+IB4tFI4Yx8X/yPOISO6slONfmb
	/G85RVBoZtDTQlLnlJWSMJ9GH9A==
X-Google-Smtp-Source: AGHT+IHKoOSsK5JBBiTADIIp6HAFz7gsQNwYIqQpCN+/Qw0bgZHIgPL8agczDlGTPmA3608UbnfSFg==
X-Received: by 2002:a05:6a20:6a08:b0:23f:f88a:c17d with SMTP id adf61e73a8af0-2430d49d18dmr3291997637.42.1755604934566;
        Tue, 19 Aug 2025 05:02:14 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm2331999b3a.36.2025.08.19.05.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:02:14 -0700 (PDT)
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
Subject: [PATCH v2 3/4] btrfs/137: Make this test compatible with all supported block sizes
Date: Tue, 19 Aug 2025 12:00:35 +0000
Message-Id: <2d3037bcbb0e5cd51b81bdb8f4fa61397f74dfa6.1755604735.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
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


