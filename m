Return-Path: <linux-btrfs+bounces-16156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EA9B2C28E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 14:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EEC1887DE1
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 12:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264C32BF5F;
	Tue, 19 Aug 2025 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHNH33YR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF227A451;
	Tue, 19 Aug 2025 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604922; cv=none; b=Zl4scpSTF4tiN1igaBQ4MbrmpRbWTdiqvneztiU3KzqjmYpHRxFihDexd+FjetWYEWIjode92fkCPUI9vrGo64HShcsnkbXbgbbRV8QeR8OIqF/dlwHUxoMKXIllM67SLNn5MHLF/sVu9JrfuOIeJTHvdMYMBmI1hj2HqAz8tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604922; c=relaxed/simple;
	bh=JIQeKxhP9pvFMeQD9pBClRoArWq2IgsMeBvZ4LZRqEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmNSPpd9UiZAeFAMyH4XW/uwiUnHlZXqReIRMKUbiOhR1D2YcnYVNfz7TPJpqwRLMaO1Fz7NRALssr2Pf2rydfCM83cxSJqSWZ77IDva7Fhz4oGeIucrRLENUod97btRN8nj6pb5AY+A+duxF730ErFtAPrUNGh9e1BSoXghyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHNH33YR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2eb09041so4341047b3a.3;
        Tue, 19 Aug 2025 05:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755604920; x=1756209720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txaBURBQKzA72vliYPF4sAs+Z/dPMsSDMBjrIxZ6v6U=;
        b=eHNH33YReXePkZNjWGDO+XlZEp7X7y1fYZveh0DVRUMR/HKtcW3ErRTZv1kBO8O+o7
         CrlBqnCj9uk9qir1kvWAZ1d97a5I/voD4H9fshlYor5dcp0MJhElKU/1C8dtJs2nyAyJ
         /BUjVRmPZhX0Fgw/IAiEx2oDXk38wjbE+5+K29tSulYS7oCmP6cjKoiMAcdT+ksd6GUK
         YuJpZx/ph3jIanLFEd/hNa5MA+IUcub8CQNGYExi4PSlhxeO84AU0wHsvPmjY/c5b7Xq
         FcXjkjNAQtruRqz1niGnnce5GxgpCXFQVq+lruP2FqwoL3eEqjzKqTspsK0Ml1W9eC0s
         0aJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755604920; x=1756209720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txaBURBQKzA72vliYPF4sAs+Z/dPMsSDMBjrIxZ6v6U=;
        b=fCsyJAWAxQfXcxAbJMkZW/YD/PidiwHAih0Br/WMhth6/fkw66Qg9e3oWUm5daK6L7
         N04KrBN3KgV3Bfoo2WBjBA8fhW3CV5WRSFYEHehRmWvvZignRkPVHVTpkS10cTlHy6qq
         ONtbZpok9JS8wJKY1mD5e8l6XM6XR2ztANMHbVr1m82uRT/n3pnqLPs2pKkM1LQX9Jzt
         UK5PLUkca97Guprwe3WtdFEqU98PGq3bkYPk8BtrNG/hQ2FM9tqZoL1t245sGE2ni8F7
         BH1IAQ2eXF1sNcqvNosw69WcoDBhTv2AZfIogq6mPMtF8LAAIG1EfUJt+yfJRHIzB7Pw
         JI5Q==
X-Gm-Message-State: AOJu0YzN9X49HifKeq+hV9Vc0qDkqBdSwb4Ba4N7F47yqs2rMP0kAT4U
	0sYsSZldGC18D09VunEW4TwX2srjM6qFWMJjPlEaH09wy9RvBf5FamgmPmocuMSO
X-Gm-Gg: ASbGncvSaQDKulJuBl8BzJDh4qCb6dyC69xRWr47SVvvNUd1k+k5M01DhF/jMiortWF
	JumR+Zgco01q2Q8N1HVxRShO3fx2NCbYF/cBnSxv1S8rXNBnuvSljgxwewa5ew1Q1uGk/TiVlkW
	OC8vugrWIiqucBi5JC0o4pvZ99iPpxoGe6m0yuUZLCy0l/NTynNt1loP7YV3F7w8dNV6PAhby2+
	/cpIPnSCmfxY2WGQ4vMET5uvFIaBl6E+thcU6csV4CANi9c2UVYogaK37yqaRje6b38Tln7xnKH
	6MXMzfsEQzjCc+tEaMYgq/NPAPVwZdiWrGYattUacyjQqk8T4DU/gS1/Gn/tncs4XAP0BbdH6+D
	ENtVHh7oIOH4jJwRd7XHlWY7nvQ==
X-Google-Smtp-Source: AGHT+IFOIq3ZK9Ot8ua7KI2ZzZy1pgnqRbVv9xzX+NwBJiZy8Y3oxXttCxEgEudI4J0Qyfk9tbKs9w==
X-Received: by 2002:a05:6a00:2e1d:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-76e8117ecb4mr3165131b3a.18.1755604919446;
        Tue, 19 Aug 2025 05:01:59 -0700 (PDT)
Received: from citest-1.. ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d122ad7sm2331999b3a.36.2025.08.19.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:01:58 -0700 (PDT)
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
Subject: [PATCH v2 2/4] generic/274: Make the pwrite block sizes and offsets to 64k
Date: Tue, 19 Aug 2025 12:00:34 +0000
Message-Id: <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
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

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/generic/274 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/generic/274 b/tests/generic/274
index 916c7173..47c5ef5b 100755
--- a/tests/generic/274
+++ b/tests/generic/274
@@ -40,20 +40,20 @@ _scratch_unmount 2>/dev/null
 _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
 _scratch_mount
 
-# Create a 4k file and Allocate 4M past EOF on that file
-$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" $SCRATCH_MNT/test \
+# Create a 64k file and Allocate 64M past EOF on that file
+$XFS_IO_PROG -f -c "pwrite 0 64k" -c "falloc -k 64k 64m" $SCRATCH_MNT/test \
 	>>$seqres.full 2>&1 || _fail "failed to create test file"
 
 # Fill the rest of the fs completely
 # Note, this will show ENOSPC errors in $seqres.full, that's ok.
 echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
 dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
-echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
-dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
+echo "Fill fs with 64K IOs; ENOSPC expected" >> $seqres.full
+dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=64K >>$seqres.full 2>&1
 _scratch_sync
 # Last effort, use O_SYNC
-echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
-dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 2>&1
+echo "Fill fs with 64K DIOs; ENOSPC expected" >> $seqres.full
+dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=64K oflag=sync >>$seqres.full 2>&1
 # Save space usage info
 echo "Post-fill space:" >> $seqres.full
 df $SCRATCH_MNT >>$seqres.full 2>&1
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


