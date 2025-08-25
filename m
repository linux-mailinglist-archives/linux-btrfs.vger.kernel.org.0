Return-Path: <linux-btrfs+bounces-16322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E099DB33622
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 08:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5205200C4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147B26C3BF;
	Mon, 25 Aug 2025 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJROUp2C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E027A928;
	Mon, 25 Aug 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101876; cv=none; b=og834jrzivK4jc/wgeN5qGtUqqlj839n62Fc/uiTbBISr25463KXHqX31Xo+d64d6iAkg3w8XrI6aaMwm75xDHKGA4RCUhFVRXQj/40teSUSF2nJSf4ctc7kcdT68hbGap7Ug40F4UXVcm4xRHI65L2yBUWw3VbWWP4cK+ZtWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101876; c=relaxed/simple;
	bh=z8J7ILG0r5zGqfuKlrGRpl7wPIdnVG8ntPH2dmMlIrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmCwU/iQTlCiBkrnPqx3JPTX1LVMUH3x06YjsbSWPyNCAhF2Wncglng8ABw/if7w0tsBRu3I5nCYne0cS83b09T8R3yxrAsuAB9GcekqKIrOQW5Lyx2ZULxY+GjynfMMW/cE070gRu49eR4WBI2hOLvR4KHpm2yXUprVDMPX5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJROUp2C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445806e03cso46660495ad.1;
        Sun, 24 Aug 2025 23:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756101874; x=1756706674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siPXvUwYRe/27PCr0WVoD8ePw7rd1N22GbG58uUVQTo=;
        b=QJROUp2CCDCBX+f9Ty/LZtjB1vdMMxbUEok7b0xqgYiONKymUTOTHTm2VtjjlFfjR0
         y2XqAshkKH6O8dEx1nI/W2ssjhfLsbwy4fiqR9fiMUEd+t0WOmP7/1zgbliiNrb+8jnk
         YQiZef/csZkw0Z3V93da7KtxLbzvIUHZK4nvdx4L/fTmZ19IhcfdTQdWwNAUyHSkE6dy
         Ot/QQHOtLrvdiOW2Qpo2OlVkGEv8Wu86U9szt4KMd/JrcnEAj8h/0Q+lKkbes7JhQkNg
         0dbXiQHvhOliRBKd1oiDi824f+g8xSc7epN1D8/SBfi5WfhDWzxQmfFAeOgvFfDoQkFg
         A0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756101874; x=1756706674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siPXvUwYRe/27PCr0WVoD8ePw7rd1N22GbG58uUVQTo=;
        b=G3MC1eX+vWjfGeGtIeSvd0KToH4jUy34IJxuKOX6yY/KGUw3A7c5wipxVnfFyOslve
         LO9FXno0G/tF0Ci19VB4Ztll92F1F8jvHzEi9AVaHJlK2q0wGzq2BkM24K69N+xZrXhA
         qgDiiXAO5HvjfcGrK9/aEEG2w7Rs60/PgIEXrrXMK+gTeaIOFbLOPiMF3XSX4L99Pmww
         RJ9bNAdGooVxGuWQSreg650dqA0kx6tLXh4HeqhyeyFy6YvZqtDHnfxGOJbPoQZqkh/f
         b47JqHl7lnoagm7yJxV9gh+pofpz02V7Br9xJvZBiaEwn+LDNKHW/J+F447a5qcS3a5y
         SvXQ==
X-Gm-Message-State: AOJu0Yz2o2f3zJjVMpYJF7puNlZ/5QzJcg9R9LFG5ck2nf+KrK8m6lbS
	5GNAQaEQ9g0b+aXw6qMm7Klgjzxq9DHH0qB286yJIswgLyGgxI8C0ZNnGo+GWw==
X-Gm-Gg: ASbGncsiRGlLO2xaTb52DwwXRkD2AeSvD1Ws2KPWXMfZ8QYeboJLwkqv9FMgq/fYK1+
	eC5aqQrYQzhqaQ4ODOi5Rfx3zintLX3E1Aa0mou6R7fLaemfIBAGwNpmwzjG6cBTs7bHTpeni9w
	JJWA+jCJ/R30l8g3VHCB3NSgqFt0cB64KiEGzY3rL90XFL3J8s9tM1+RpLlxcXwaIv6uyvb0NP/
	9+X0LbQcI4MW4QuwLuM8cRsTcLszn2mrCcaeWsAvTbAxQg6fnkGJqtmn18tvn8NdkzvY5+v647D
	55Rw/ExCbDqLVxrzx2/OW5ympXTMZwBkgXWq00rc8zb0sPA1M0iQIx/d21+NEu0h5ADP+6euJvi
	NK5DOE6mhctNiDICn8YWWvVOAK4AG2QrbuQ3o
X-Google-Smtp-Source: AGHT+IHEbodyq9YFAlEUUzVT0j7kaZqyHoTxDZge6z9dz7kHDNWextqFM2doZ2ommwn0PokXsJw8Vw==
X-Received: by 2002:a17:902:f64f:b0:246:8bdd:17d7 with SMTP id d9443c01a7336-2468bdd1bfcmr60873845ad.13.1756101874167;
        Sun, 24 Aug 2025 23:04:34 -0700 (PDT)
Received: from citest-1.. ([49.207.214.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a59b1sm58202485ad.42.2025.08.24.23.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:04:33 -0700 (PDT)
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
Subject: [PATCH v4 2/4] generic/274: Make the pwrite block sizes and offsets to 64k
Date: Mon, 25 Aug 2025 06:04:09 +0000
Message-Id: <e66985821e26cce80321d31ab2527f14bd2bfe26.1756101620.git.nirjhar.roy.lists@gmail.com>
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

This test was written with 4k block size in mind and it fails with
64k block size when tested with btrfs.
The test first does pre-allocation, then fills up the
filesystem. After that it tries to fragment and fill holes at offsets
of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
64k block size, the test tries to fragment and fill holes within
1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
and the write fails. The reason for this failure is that during
overwrite, there is no more space available for COW.
Fix this by changing the pwrite block size and offsets to 64k
so that the test never tries to punch holes or overwrite within 1 fsblock
and the test becomes compatible with all block sizes.

For non-COW filesystems/files, this test should work even if the
underlying filesytem block size > 64k.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/274 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/generic/274 b/tests/generic/274
index 916c7173..f6c7884e 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -40,8 +40,8 @@ _scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
-# Create a 4k file and Allocate 4M past EOF on that file
-$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
+# Create a 64k file and Allocate 64M past EOF on that file
+$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" $SCRATCH_MNT/test \
 	>>$seqres.full 2>&1 || _fail "failed to create test file"
 
 # Fill the rest of the fs completely
@@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
 echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
 for i in `seq 1 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to write to test file"
 done
 _scratch_sync
@@ -71,7 +71,7 @@ echo >> $seqres.full
 echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
 for i in `seq 2 2 1023`; do
 	echo -n "$i " >> $seqres.full
-	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 conv=notrunc \
+	dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 conv=notrunc \
 		>>$seqres.full 2>/dev/null || _fail "failed to fill test file"
 done
 _scratch_sync
-- 
2.34.1


