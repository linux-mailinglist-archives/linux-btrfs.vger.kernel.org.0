Return-Path: <linux-btrfs+bounces-5323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E556D8D2232
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542F51F23DF6
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFA1173345;
	Tue, 28 May 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="YxD8kwxP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0082C16EBE2
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916408; cv=none; b=SblBJtbnzy1vlN3lJ5fgnZ8vxUqnZ8OhrSMFe1lfr9OVeVv+2TdLgdJSCCKxrj2LlowcrcuRUCtYd9mk2pTTqXtTbHetH6LPjmHlXxTUYY12Cxadvzidj3omnPjMX7vs4YGs25p2MI+jXeyWezwaqihl11zPIM52ToZHd/bV1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916408; c=relaxed/simple;
	bh=XgOWqi4lbUgTFyctQnZSVsnY6zmcJ4oV+Rov5Z+FoWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pH/aOFpIR/hUboIzZ2emeH0xSv8QPD4zvFWBFHlIZsUQmz7pOoAW3K/FNrKohRiuSdWxzY2/PwyGMcalGK8QtCA3Y8Cr37BVskVoRJntVPgJTaIYq85VAtXQSySvGx7nMti+U0jODRzI8LbEa4gwlJZtoReFfCu6onJCR2raV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=YxD8kwxP; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7007324a568so823346b3a.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 10:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1716916406; x=1717521206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Te/gHzQGzfhwCIf4xz4UAwEbLfpB9s5D1T3jB12WoJ4=;
        b=YxD8kwxPPDE3MZBKCjO9UIIrF+e+becnbsGjVX8g0nW20Xkzx6IgdXs8QLTZ9tffgw
         w60/Sq8puVXh1FcD66n3DZB8rKKnqqaeKX5hULDs9UcmDJ55VAKUZseDIrnp6d9QUnUO
         UTpW9F2aa8ndUkwcrw/N5Z/BNAtBAmMcf4+MCwvqExv1xVYxXqooYWkAZrGWxeqfKIsu
         UhFb+j/nnr2IQeIoRC21cM43Sxz6oVIV1V13F/eNmUe3rJdkOM83xseKiV8G58dTSgnA
         qF1j82qpSfV38JmdyCp029fl3EcEiBV30wK0becVIrYa7jpgoaMHFX9OESXWzEvkc6FS
         3aEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716916406; x=1717521206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te/gHzQGzfhwCIf4xz4UAwEbLfpB9s5D1T3jB12WoJ4=;
        b=FAI5g/MQypRBv0Swg5craHRKxYnidkm5t63GAgBbhY7ybgGlNdKHOvwQeTY48plhvN
         cURKp2/WbQfsqE34oLZ1bNxDy7x1guRPAFa2/BOB+ziivTuBuJapolrqrvK3O+Z7Xdai
         EgvoCR3cl9qiyQf6n4Z4PCf3LLhKMRFtMkUGGUF5lcBbYdVdKG4QuJ0LSOjOUzGEsvX+
         P1yfD2ghCuiOePTqz+8HYpmJZz0IzepFfcsSdqAaLNkbK7m+G3nx45bndA/0O/dqf1DB
         UVYJPpXxYlM34q6gXkv2TFhIUABSAzRK9E3iRQiocOeZhnDKO923AQ/TgihOtbn1PF1Q
         xOJA==
X-Forwarded-Encrypted: i=1; AJvYcCWxYIwi/qzrndrolYDxW+3f4wf3U8+s88jDB/UBEOfgbldQRjlT0ZKxvsCI+t+Y0RtQGNU0u8l73SA/IjyJTeJlWUjC+gtJjOsL4XA=
X-Gm-Message-State: AOJu0Yz+VH2v+BKcBl55s60C8MXFREjLkC98mpd/4hiOUxK7ds7UgRkF
	BDRxD3rNMAJDuB7BlA0KHG8411H5fTPePFpOlZSkwZL6UOciGCnhzx+0HTIb7xQ=
X-Google-Smtp-Source: AGHT+IHCBJL4Icu4zdbimF8xzYGigz2Nig5SBNJZHPOqVLTANPtaM+bR4ZBqe3QTnopONPomRGT2Ww==
X-Received: by 2002:a17:902:dace:b0:1f4:b2ce:8dbe with SMTP id d9443c01a7336-1f4b2ce93b3mr43697995ad.9.1716916406284;
        Tue, 28 May 2024 10:13:26 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:4121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9cd6a0sm82447675ad.276.2024.05.28.10.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 10:13:25 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH fstests v3] generic: test Btrfs fsync vs. size-extending prealloc write crash
Date: Tue, 28 May 2024 10:13:14 -0700
Message-ID: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

This is a regression test for a Btrfs bug, but there's nothing
Btrfs-specific about it. Since it's a race, we just try to make the race
happen in a loop and pass if it doesn't crash after all of our attempts.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Changes from v2 [1]:

- Rebased on for-next.
- Added _require_odirect.
- Added FSTYP check to _fixed_by_kernel_commit.
- Added Filipe's Reviewed-by.

Changes from v1 [2]:

- Added missing groups and requires.
- Simplified $XFS_IO_PROG calls.
- Removed -i flag from $XFS_IO_PROG to make race reproduce more
  reliably.
- Removed all of the file creation and dump-tree parsing since the only
  file on a fresh filesystem is guaranteed to be at the end of a leaf
  anyways.
- Rewrote to be a generic test.

1: https://lore.kernel.org/linux-btrfs/d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com/
2: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/

 tests/generic/748     | 45 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/748.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/generic/748
 create mode 100644 tests/generic/748.out

diff --git a/tests/generic/748 b/tests/generic/748
new file mode 100755
index 00000000..2ec33694
--- /dev/null
+++ b/tests/generic/748
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# FS QA Test 748
+#
+# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
+# prealloc while extending i_size, then fdatasync. This is a regression test
+# for a Btrfs crash.
+#
+. ./common/preamble
+. ./common/attr
+_begin_fstest auto quick log preallocrw dangerous
+
+_supported_fs generic
+_require_scratch
+_require_attrs
+_require_odirect
+_require_xfs_io_command falloc -k
+[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix crash on racing fsync and size-extending write into prealloc"
+
+# -i slows down xfs_io startup and makes the race much less reliable.
+export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+blksz=$(_get_block_size "$SCRATCH_MNT")
+
+# On Btrfs, since this is the only file on the filesystem, its metadata is at
+# the end of a B-tree leaf. We want an ordered extent completion to add an
+# extent item at the end of the leaf while we're logging prealloc extents
+# beyond i_size after an xattr was set.
+for ((i = 0; i < 5000; i++)); do
+	$XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
+	$SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
+	$XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
+done
+
+# If it didn't crash, we're good.
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/748.out b/tests/generic/748.out
new file mode 100644
index 00000000..dc050a96
--- /dev/null
+++ b/tests/generic/748.out
@@ -0,0 +1,2 @@
+QA output created by 748
+Silence is golden
-- 
2.45.1


