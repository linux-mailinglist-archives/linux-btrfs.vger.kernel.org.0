Return-Path: <linux-btrfs+bounces-2043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C09998461FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 21:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7C001C22A11
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 20:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC25E3BB2A;
	Thu,  1 Feb 2024 20:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PnKlcKL0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E726AD5
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819808; cv=none; b=Fo1qYGrGmjejdTLPAIcJBGJeKVij407MijoEySadkBm3e7TckpMf0FgqbZJVGlP0dIDZKs+/uk2D0401U0xvdrT3LLE5hgTKVB8L66ygTfXerLgTJ13R8qD2IXBS8D71w3MF+w7I25BliQ73sLO8XtopnzmOXDmxOIQhw2fhD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819808; c=relaxed/simple;
	bh=hOA+OqTHVoRrZpUdFgVMuDqxWyxUquXib6M3GSPf09A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=himMbCLoXX+1FMe7pm+ycijNNRWfZtqtrnR1924pN94STFyt3Vz/+eAhleJqc22fAnA8DJs/Udke+bEZwiUVOTmYuZkfuxPgKAwAh82XYRYYyOG30LIQhfmTZ5tI3C8xYn+ncftWULMxFUTsu3CDEHLBVu2KOGCo7Td/G9VzF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PnKlcKL0; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60412a23225so14045657b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Feb 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706819805; x=1707424605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yM7gCeTxtrHaCpqgRrs/cEvnVMk67WLvsx3JX08QAg=;
        b=PnKlcKL0ZZbGK0qDYz6NMvBKfo+0Co8ytUdTDI8q77vz/qoeIvG5WzErBHGK4VYOyq
         7W84RnH2ZQcgO98xWRtXWphkZpvi/x6Of/KPrMplXXcGf0/vKUVgLm7RzC9VdOYBN7dj
         KCM1sQTH8jaL48GUMA1SPFkKoYeC5Y5AZLr9U3EVC01ayzMoVm9PguztGCVG5smtxoEd
         sHzV7O5IRzk+8n+edcTu+klZVGKEKyIY4iG1KjCY0sP2UUbGlCjepZYUVqaCCius5az7
         IDrRcLZsqKQZUEA0F86weVNohYKiPDtazpj80tuk+ver15wJQG+RxKUZIlKy5AybbWzF
         CGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706819805; x=1707424605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yM7gCeTxtrHaCpqgRrs/cEvnVMk67WLvsx3JX08QAg=;
        b=hKodARj7HFNOJKKTgw4CQ53Bls4Ywgu4C0kia0Dd+jVx0pI70CMoyCpRkcY7WzwS6e
         mnczqmU4TbhWleXIsr5W8AEfiwWwiONT8QYj2jhOw/rGOnLiFV4SeOVo3okwfBJQZTVw
         QWzv3YyN9PEjwBuHk4M81CgUNj2Xm2sRqHpC5xq4+O2mwjHNu53ByWRAt2f8psF/yB1N
         CNia9nVX3skX9M5mCrm7wlVxgDigiRobYx7xreolYdhBNZZWPTP1nadFFwY+b29/UNQm
         BgWeJYU5u24t8ePr2wFjELaRFNi0fRALXR+hRuxG/Q4kA/CJEAAUPRNw+JHHtmv+qbus
         OBnA==
X-Gm-Message-State: AOJu0YxWAfazXARETCxyy/2K6RsNnAJE8e0G+s5/Wtq5LqQ4voNjprOI
	o1Xut95uJR5rzOnLRCzxCoLl9OvMFzyYkzoYcFtl5VulcSIWLSLf1qwZLm8RmJvRz1GL5TqLY+r
	Z
X-Google-Smtp-Source: AGHT+IEDqvOw6Ns/a0TXI2U+6KlGKwX9dBb1buV1RIGKKHILLx2GXXAhGD4YZgstHVt+LYA1tGfTlA==
X-Received: by 2002:a0d:d957:0:b0:603:cbe0:465e with SMTP id b84-20020a0dd957000000b00603cbe0465emr340893ywe.20.1706819804773;
        Thu, 01 Feb 2024 12:36:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXwzWU6S2dwKu2cdEnlvsBsuCxjHbNLNnFOj0r0u1xeRqVQzVjUzrWrYZCL2r24JKxgQK0+r3/SNhU6SBZFaFSsIiQr/4ItqW8t5HlcWRG0b9MKL21b4KOF7uH2
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mb3-20020a056214550300b0068c6d732303sm104721qvb.117.2024.02.01.12.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:36:44 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] fstests: add a regression test for fiemap into an mmap range
Date: Thu,  1 Feb 2024 15:36:38 -0500
Message-ID: <795fcb629a2bbfeaf39023d971b7cb3a468aa87f.1706819794.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs had a deadlock that you could trigger by mmap'ing a large file and
using that as the buffer for fiemap.  This test adds a c program to do
this, and the fstest creates a large enough file and then runs the
reproducer on the file.  Without the fix btrfs deadlocks, with the fix
we pass fine.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 src/Makefile          |  2 +-
 tests/generic/740     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/740.out |  2 ++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tests/generic/740
 create mode 100644 tests/generic/740.out

diff --git a/src/Makefile b/src/Makefile
index d79015ce..916f6755 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
 	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
 	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
-	uuid_ioctl
+	uuid_ioctl fiemap-fault
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
 	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
diff --git a/tests/generic/740 b/tests/generic/740
new file mode 100644
index 00000000..46ec5820
--- /dev/null
+++ b/tests/generic/740
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 708
+#
+# Test fiemap into an mmaped buffer of the same file
+#
+# Create a reasonably large file, then run a program which mmaps it and uses
+# that as a buffer for an fiemap call.  This is a regression test for btrfs
+# where we used to hold a lock for the duration of the fiemap call which would
+# result in a deadlock if we page faulted.
+#
+. ./common/preamble
+_begin_fstest quick auto
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+		"btrfs: fix deadlock with fiemap and extent locking"
+
+# real QA test starts here
+_supported_fs generic
+_require_test
+_require_odirect
+_require_test_program fiemap-fault
+dst=$TEST_DIR/fiemap-fault-$seq
+
+echo "Silence is golden"
+
+for i in $(seq 0 2 1000)
+do
+	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
+done
+
+$here/src/fiemap-fault $dst > /dev/null || _fail "failed doing fiemap"
+
+rm -f $dst
+
+# success, all done
+status=$?
+exit
+
diff --git a/tests/generic/740.out b/tests/generic/740.out
new file mode 100644
index 00000000..3f841e60
--- /dev/null
+++ b/tests/generic/740.out
@@ -0,0 +1,2 @@
+QA output created by 740
+Silence is golden
-- 
2.43.0


