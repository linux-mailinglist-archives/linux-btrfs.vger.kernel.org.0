Return-Path: <linux-btrfs+bounces-3982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F489A549
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 21:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7951C20A5E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05949173341;
	Fri,  5 Apr 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="I9RP21k1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00A17334D
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Apr 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712346990; cv=none; b=ufgIU5PNB3NCSyI1oamISHCG5XCqvPcUzmfFrk/c68if6nTLPJO6xosNXKHZLt+TCgeYMz56L0T2z3UIMC2tonUXgPWplLbacBntgZF0dzqEjGrDArnAAxOOcsNFHkJFKFOiOupF1uDjPEyRazver9hR1aMYUr0LzlEB//ivTug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712346990; c=relaxed/simple;
	bh=aPbMiZOwI+NGFueUpLxHWqQ6gUxj9pl36zsDIuOZjOE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA8AKfA4tnRC/MUN2rJkpuC+0lNS+P9ttMfNLyQ9KZI8S1kukekaDIC4GbT+GWEOnOHlh1ZBWG6SF4J9fD2Z/w93X3lnJj4wVmx8IRWI5j071s4SvjEpYg0m2Ndv/xF+50AKne3WRUiIJ3RFMfWSpwTuW7XOVr4CC06Bzq8Wbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=I9RP21k1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69938e2b71dso9072946d6.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Apr 2024 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712346987; x=1712951787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBF7VbLO1AdTYvcpdTi26pAOfpXqNacAoJuOltaVhbM=;
        b=I9RP21k10SpPo10TiRLq7Bp1TTUrkQ8VFVOuUf5iNrgdExx2ewESSOXPYyacY6dOFR
         xbj4gg+mqUfhcc+boSb25AvixZBfnlx2OeYYYankpcMmNTQq0LGb8dYSLf7faAoTPmpq
         79fFLNwvgI4J4yWUBJq4Wg+m9eJcMbSdJP28Cpg38Ns1Qj9Hky2vOFDgl2kCzudolEyY
         VnWQJAUHR9fQ2/RJxMkLzm7yxLbCDgQSeKn+bdzgqNBzcPPyF1gMMSGKR4+X4YkBO8eN
         uMR1D2Dv6pznHjCNpuko+txPxgr6n0b9VFGMHUcS8W/BcPIZOs+VHNC0+3feJvWx3uk2
         9qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712346987; x=1712951787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBF7VbLO1AdTYvcpdTi26pAOfpXqNacAoJuOltaVhbM=;
        b=WCEOnhy7JfKrnKbAXWZr9VzXV5vWkZRF5VYgVfPj7Be6V4KqC6nD9SWkzF7L/hV7zS
         ArqcJoPpCjR1OoJwUtzqoCRx5VWYu9+3JaZZkoFgsyhtfRh5lOhbiHsGT7+CJlUlJGzX
         FabUhYs97q2j5R5uAu7G6W1pcMWqfdw3gYTma1nncMy4BXKxS25J0ZZ1LYYJMUI4hfVH
         QbYoHWvGvfYHMsmuufVwr20RIr8WW7e0gIuwb0MEQK+7+zPDVfI3usagSTCsleaf5Bmn
         mZngpF2KPW1WHDzRJksqomORsNNHGW/hKyxALccCcNBXoN9lKJJViR3PTZLXISnBn0kR
         m+zg==
X-Forwarded-Encrypted: i=1; AJvYcCWBgBTDESDLm7Dsm+5Bx9NyejFjUawUyJgS3JCJjrAdq1KZ5cMBfzTmaoiFAq1d0lGQYhMH7NjdnRIcHWIg3RTqpM5guXXi6M4Qlko=
X-Gm-Message-State: AOJu0Ywi0R9VcFPwxluj98IJsE2H6GrfJLOq4xgDsjWF9z1esRk7ZdEN
	iYR9O+lLoJsOUpWoAIb0LWcAGYDwK02Q5AB3EVq+4nLNm9A5OAft5ovQLkrE0cA=
X-Google-Smtp-Source: AGHT+IFxrZf584DI1C/A2wc+WeyJwP9UAfKJp/q2R1/IghLX6g5qayzXZseqwvI/TbiooPIjePreRw==
X-Received: by 2002:a05:6214:c6b:b0:699:322a:e54f with SMTP id t11-20020a0562140c6b00b00699322ae54fmr1819839qvj.59.1712346987229;
        Fri, 05 Apr 2024 12:56:27 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id mx9-20020a0562142e0900b00699b99cc0ffsm24774qvb.25.2024.04.05.12.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 12:56:26 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 3/3] fstests: update tests to skip unsupported raid profile types
Date: Fri,  5 Apr 2024 15:56:14 -0400
Message-ID: <7111bf50942e0b72a43ceed010d8bab00c712a75.1712346845.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712346845.git.josef@toxicpanda.com>
References: <cover.1712346845.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests btrfs/197, btrfs/198, and btrfs/297 test multiple raid types in
their workout() function.  We may not support some of the raid types, so
add a check in the workout() function to skip any incompatible raid
profiles.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/197 | 10 ++++++++--
 tests/btrfs/198 | 10 ++++++++--
 tests/btrfs/297 | 10 ++++++++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/197 b/tests/btrfs/197
index 2ce41b32..9ec4e9f0 100755
--- a/tests/btrfs/197
+++ b/tests/btrfs/197
@@ -30,14 +30,20 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_scratch_dev_pool 5
-# Zoned btrfs only supports SINGLE profile
-_require_non_zoned_device ${SCRATCH_DEV}
+# We require at least one raid setup, raid1 is the easiest, use this to gate on
+# wether or not we run this test
+_require_btrfs_raid_type raid1
 
 workout()
 {
 	raid=$1
 	device_nr=$2
 
+	if ! _check_btrfs_raid_type $raid; then
+		echo "$raid isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 	_spare_dev_get
diff --git a/tests/btrfs/198 b/tests/btrfs/198
index a326a8ca..c5a8f392 100755
--- a/tests/btrfs/198
+++ b/tests/btrfs/198
@@ -18,8 +18,9 @@ _supported_fs btrfs
 _require_command "$WIPEFS_PROG" wipefs
 _require_scratch
 _require_scratch_dev_pool 4
-# Zoned btrfs only supports SINGLE profile
-_require_non_zoned_device ${SCRATCH_DEV}
+# We require at least one raid setup, raid1 is the easiest, use this to gate on
+# wether or not we run this test
+_require_btrfs_raid_type raid1
 _fixed_by_kernel_commit 96c2e067ed3e3e \
 	"btrfs: skip devices without magic signature when mounting"
 
@@ -28,6 +29,11 @@ workout()
 	raid=$1
 	device_nr=$2
 
+	if ! _check_btrfs_raid_type $raid; then
+		echo "$raid isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo $raid >> $seqres.full
 	_scratch_dev_pool_get $device_nr
 
diff --git a/tests/btrfs/297 b/tests/btrfs/297
index a0023861..7afe854d 100755
--- a/tests/btrfs/297
+++ b/tests/btrfs/297
@@ -18,11 +18,21 @@ _require_scratch_dev_pool 3
 _fixed_by_kernel_commit 486c737f7fdc \
 	"btrfs: raid56: always verify the P/Q contents for scrub"
 
+# If neither raid5 or raid6 are supported do _notrun
+if ! _check_btrfs_raid_type raid5 && ! _check_btrfs_raid_type raid6; then
+	_notrun "requires either raid5 or raid6 support"
+fi
+
 workload()
 {
 	local profile=$1
 	local nr_devs=$2
 
+	if ! _check_btrfs_raid_type $profile; then
+		echo "$profile isn't supported, skipping" >> $seqres.full
+		return
+	fi
+
 	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
 	_scratch_dev_pool_get $nr_devs
 
-- 
2.43.0


