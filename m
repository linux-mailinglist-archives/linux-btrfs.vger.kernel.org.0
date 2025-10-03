Return-Path: <linux-btrfs+bounces-17424-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8EBB86D0
	for <lists+linux-btrfs@lfdr.de>; Sat, 04 Oct 2025 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5A7F34865D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Oct 2025 23:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB062727FA;
	Fri,  3 Oct 2025 23:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOKBRnhY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09E279DAF
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Oct 2025 23:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534940; cv=none; b=Y3+P6uUHjQClF6D1KqF3gPenXKg+mMQ1Ub9PLi1/ZP5h4LPL1h8KbgAazZho7UP/W82v66eydkuRxF+kG3ZikH19eS1btNwtibrVSx/8iaw2jTtOy1GQuwNnLd4N97fWU1AYxnkruVbwZNSh2N6YQrvdKuQ5oLPC7ODxOCzx9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534940; c=relaxed/simple;
	bh=fA/iItnoCi+GkBd1MHPqmKC4Ilu5imymQ0NjVAyxgFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTajDn0HiHwGfdPBRp4V3H/xyz5vLNbJPRpyhF22NvtIBVDi9tglYBSKCARBpG3dww3wzUVNI43ZpkmO/RmtLSrp+2JDL3bjfea9wGdartr98sCwQQ6XIlgbs6XRtkZoFXZvyas87wkKrLZy9wB/EqK7nl0Gky3qnEPGHJz3qK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOKBRnhY; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-72ce9790ab3so33133037b3.1
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Oct 2025 16:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534937; x=1760139737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoONqeITOu1OJUM88cumPNXT1Sugp6nUBehkV0YhSJ0=;
        b=lOKBRnhYejpUJ2PYZpiv4Qd0UOZ4SgRqLNKsjXXRhpP3V0Rz7iyikAbBrA25MelUwi
         tnJMd/JQ1GtOxPxMUVKFh09cxSNiVEp8k9hIWkcQj6mH9KJjrrXKbQe1xSwSyfFzKXCf
         dF7AHqvvcPCZKG4PMjxBw2NDlURCzmE1R4S064xAlIJV62vB3aeZpVt87eAeaZEIoiSv
         E9J57ypK+3sjEOmR/kloKSFFEZqm5Q+WQa3Qr5R8nI/ZfN7XWrC8dBLVgJPrUEWyIYz1
         bUf8xVEZt0Jy7vTl6cnA5tzA/qL/KBmaLNLwp2yrx4lOrGIpEA6uwCPEsY6Y1mPKXUDd
         OxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534937; x=1760139737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoONqeITOu1OJUM88cumPNXT1Sugp6nUBehkV0YhSJ0=;
        b=egUTAG18OAMrWrbwcV6SH0syl4FRMMuQIeKP8clCoYL7HE4pXNdksvtuA22B59b/md
         JbwtfhDBH5CEltM8oAtRWZXHhltPXP7HOaE0E6JxUk+NqI7Kl4PH9L2dc8q8BklkYdKF
         1I/OMagmD/JivQ/KWYWtXhY8YSADouNaS4YUy2cr3dXcM/Y95TjMCO03yN4PZG+6EV+w
         G3Oz5nxO4esI+JldAZpb4OPWAXp/0l0nPJOi0UFRmNIzMsjPN1RL7PZQ3bab3vkmM+NL
         6xxAzk5KVu5GDV1cQxRgLN205KrUIAahL5RkCtI6nRyKxNGQkCaN10a0qGD7GOzLzJMw
         G86A==
X-Gm-Message-State: AOJu0YywOqTykbxBeCfaQNdAkfns2tuXvS5PxNr92aT1AsB/nplkUuRK
	zhzX21D5jfvo1JYeJUuM9tpLmHdlA/OnbyNwGM1iu1d6M8RGPhfYbCzXshAc+qBz
X-Gm-Gg: ASbGncuXuvtNy/KSJ7CHnhne4YeQulmaxIYcA0VzL59HZqFtqAxcvNx1nutWSSl5JGl
	W8clnbVbsx0vzZC6YSBk/eZEzZaLjZikYA2gn1MPwIObqrA0p6Noz1+CBeXD8fZ+j0t/p9TkQJc
	ddxgS+yrxOIhlTMv/aac77pbibwmrt7BDrLcGasq8pJ3xN9u1ZNTxYlTXrJNKeCV3gBAwsF8kG1
	tTpS86jfsPG4zUWMOzwdUGnEJdqXjhzSEBWogE52T9lXJ4XIU/IKL4OsxE03/5iXpFOysRMkOli
	Hkani+/59kUOTapHbXC+dj5un0sNINYle3V3pXcXttaIwcjLpHoh/E1LZrihcbhyYzrPVfiQyu4
	IiS+vfBCJZfPtoKmxzru5VS7X2hp7moVbqpOXPfIkO3hfHWjb6f33V70iQcWbnK5E
X-Google-Smtp-Source: AGHT+IGxWIdATjQKfsBLLoZDjWvk4Oh/wgBbreIU54NjJL8oYV5b+5WgAmBNgPMh8S/bVGQzaibJKA==
X-Received: by 2002:a05:690c:3802:b0:772:5ad9:3bf8 with SMTP id 00721157ae682-77f9476c561mr57878107b3.51.1759534936982;
        Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:48::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77faaa9938csm850127b3.33.2025.10.03.16.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:42:16 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 3/3] fstests: btrfs: test RAID conversions under stress
Date: Fri,  3 Oct 2025 16:41:59 -0700
Message-ID: <455b9a2b102631febc1b05802006d3d304d4baeb.1759534540.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1759532729.git.loemra.dev@gmail.com>
References: <cover.1759532729.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to test btrfs conversion while being stressed. This is
important since btrfs no longer allows allocating from different RAID
block_groups during conversions meaning there may be added enospc
pressure.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
 tests/btrfs/337     | 95 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/337.out |  2 +
 2 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/337
 create mode 100644 tests/btrfs/337.out

diff --git a/tests/btrfs/337 b/tests/btrfs/337
new file mode 100755
index 00000000..fa335ed7
--- /dev/null
+++ b/tests/btrfs/337
@@ -0,0 +1,95 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Meta Platforms, Inc. All Rights Reserved.
+#
+# FS QA Test btrfs/337
+#
+# Test RAID profile conversion with concurrent allocations.
+# This combines profile conversion (like btrfs/195) with concurrent
+# fsstress allocations (like btrfs/060-064).
+
+. ./common/preamble
+_begin_fstest auto volume balance scrub raid
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_kill_fsstress
+}
+
+. ./common/filter
+# we check scratch dev after each loop
+_require_scratch_nocheck
+_require_scratch_dev_pool 4
+# Zoned btrfs only supports SINGLE profile
+_require_non_zoned_device "${SCRATCH_DEV}"
+
+# Load up the available configs
+_btrfs_get_profile_configs
+declare -a TEST_VECTORS=(
+# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
+"4:single:raid1"
+"4:single:raid0"
+"4:single:raid10"
+"4:single:dup"
+"4:single:raid5"
+"4:single:raid6"
+"2:raid1:single"
+)
+
+run_testcase() {
+	IFS=':' read -ra args <<< $1
+	num_disks=${args[0]}
+	src_type=${args[1]}
+	dst_type=${args[2]}
+
+	if [[ ! "${_btrfs_profile_configs[@]}" =~ "$dst_type" ]]; then
+		echo "=== Skipping test: $1 ===" >> $seqres.full
+		return
+	fi
+
+	_scratch_dev_pool_get $num_disks
+
+	echo "=== Running test: $1 (converting $src_type -> $dst_type) ===" >> $seqres.full
+
+	_scratch_pool_mkfs -d$src_type -m$src_type >> $seqres.full 2>&1
+	_scratch_mount
+
+	echo "Creating initial data..." >> $seqres.full
+	_run_fsstress -d $SCRATCH_MNT -w -n 10000 >> $seqres.full 2>&1
+
+	args=`_scale_fsstress_args -p 20 -n 1000 -d $SCRATCH_MNT/stressdir`
+	echo "Starting fsstress: $args" >> $seqres.full
+	_run_fsstress_bg $args
+
+	echo "Starting conversion: $src_type -> $dst_type" >> $seqres.full
+	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
+	[ $? -eq 0 ] || echo "$1: Failed convert"
+
+	echo "Waiting for fsstress to complete..." >> $seqres.full
+	_wait_for_fsstress
+
+	# Verify the conversion was successful
+	echo "Checking filesystem profile after conversion..." >> $seqres.full
+	$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
+
+	# Scrub to verify data integrity
+	echo "Scrubbing filesystem..." >> $seqres.full
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		echo "$1: Scrub found errors"
+	fi
+
+	_scratch_unmount
+	_check_scratch_fs
+	_scratch_dev_pool_put
+}
+
+echo "Silence is golden"
+for i in "${TEST_VECTORS[@]}"; do
+	run_testcase $i
+done
+
+status=0
+exit
diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
new file mode 100644
index 00000000..d80a9830
--- /dev/null
+++ b/tests/btrfs/337.out
@@ -0,0 +1,2 @@
+QA output created by 337
+Silence is golden
-- 
2.47.3


