Return-Path: <linux-btrfs+bounces-5287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C598CEB96
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 22:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA91F218B8
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AF83A14;
	Fri, 24 May 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="BvHdfz9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5717322334
	for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584321; cv=none; b=Wscbfdj5cV/NQXHGbDuWutrEDIVll5UvugVdr+pCkFQMaWpUw/+ziY131Huz5EQyYgbOBP4rACrGsgrjTsq0SjZUNm5tC1D/Qi2jHgEVBS/d7TP6XqqOZkKWfIhmbISiQyXNqGaKoGTdKKvgyiw4NkHbYSQttNvaG8N0biW/nC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584321; c=relaxed/simple;
	bh=ECQm2GVEkuxakTj0yWho2TKp1LuuyzIjDK0PEt/XSds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1kxJsCn0OJyDOt2QANztHhey2ge03nulDh8ggvcbFEY2e7bdUsCNMeIB9eWZu8tYHs3VSajxNxN4HqdzCas9FE3ZVG0VGEf4Rqh433HbNhg09HngSvt/QuR/cUQuBJ7/kQDUNzJWyuIJN/V5d45f0dhzkHVbrwX9KWuXNotMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=BvHdfz9F; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f44b45d6abso11655595ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 May 2024 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1716584319; x=1717189119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euAfIUewsrHV6jYyHDKNLiq1F5HukPN8Ycx3flKpibM=;
        b=BvHdfz9F70ff14zu10opS+lZ4JH22yPCci/NI8u5Oo+z0SP4/HBJx174GiFcp4eEwO
         YkJ+J1/DDZV7c4WjzCpLaxuogvP0fV9M2I++X/3/KlyaNUW4teWMTizpBTyAkSBPMAt+
         KG04wqy78SLPIUJGvRGYpxozIXt118Fd4a5TDu308s1szBoT0N8OptVGXTo5rGV3B/Gc
         1kvFI0e9RyXYux24g1CNOlnZF/xvayHFdhu5bmoGtW6anw4YVk7lH+ocS9+AaQLpc7l6
         pIJ1tpujTHmO4jmW1z92sVaJ1jiY06ePjERlcS8idKU794oKU6nqtQgp34TjmTR55RkY
         8BqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716584319; x=1717189119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euAfIUewsrHV6jYyHDKNLiq1F5HukPN8Ycx3flKpibM=;
        b=k/TkCYK17+5Hy4MozuNtI/hiII7gZ+oaYvCoZxCbJS2PbWf+EvrPt0doNhTBaLkXtG
         hxDwIj3THU73hFbbAhp6v22/umlW8Iv4/P97W0HBbG7q11hUGzV77gLaQaYyRZPdk5ou
         VI2LLsbtWZjl8T91bzJIq9G7ONG/KBUiHV6E19RRZ26+rt444SMRsKqs29E2dZ+vue0W
         Zx7/iTDz4RkeD5YNPtwR9IHI0+YS4jXVoEWXUUC16ucgfrnjezKZEQmcXqgBDHLRXu3D
         GByx4PNMIyt/1Z/LonjyYjonvQp7kD6E9i8GPlnW96VvX6o7ZTz3ciOLoxVMKZb2+c1V
         hU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUziIpU6sXr7wsjODMbgTtQQMimjHX7VyMiFouGCtOlHymtBYFJmLm+MqbstJWqwUvrZCosVLbca1TFzbc8HylGebGZu44mnTGp5ZY=
X-Gm-Message-State: AOJu0YzREAWRstD8qowOeqsr+b8J6SC5kxJ+85k4T322t80MfdNKew5x
	WBHjwMncOxPhnlLAQaONK16Fl1UjDtnan0NXfFwpVENFaVw9TJPREwkvMCZoXDESFkd1tet/vA7
	x2AQ=
X-Google-Smtp-Source: AGHT+IHHNK7YpmI5ZCGM+7NDB82gP/JWDoTp6hIJnNyvgbbLFl5k7ZAnRcj+NHfB2W3SiiJ3BQOWIw==
X-Received: by 2002:a17:902:e84f:b0:1f3:11ec:cbbd with SMTP id d9443c01a7336-1f4486bd9b4mr36831695ad.5.1716584319381;
        Fri, 24 May 2024 13:58:39 -0700 (PDT)
Received: from telecaster.thefacebook.com ([2620:10d:c090:500::7:763e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9a9dabsm18166175ad.236.2024.05.24.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:58:38 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending prealloc write crash
Date: Fri, 24 May 2024 13:58:33 -0700
Message-ID: <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
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
Changes from v1 [1]:

- Added missing groups and requires.
- Simplified $XFS_IO_PROG calls.
- Removed -i flag from $XFS_IO_PROG to make race reproduce more
  reliably.
- Removed all of the file creation and dump-tree parsing since the only
  file on a fresh filesystem is guaranteed to be at the end of a leaf
  anyways.
- Rewrote to be a generic test.

1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/

 tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/745.out |  2 ++
 2 files changed, 46 insertions(+)
 create mode 100755 tests/generic/745
 create mode 100644 tests/generic/745.out

diff --git a/tests/generic/745 b/tests/generic/745
new file mode 100755
index 00000000..925adba9
--- /dev/null
+++ b/tests/generic/745
@@ -0,0 +1,44 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# FS QA Test 745
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
+_require_xfs_io_command falloc -k
+_fixed_by_kernel_commit XXXXXXXXXXXX \
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
diff --git a/tests/generic/745.out b/tests/generic/745.out
new file mode 100644
index 00000000..fce6b7f5
--- /dev/null
+++ b/tests/generic/745.out
@@ -0,0 +1,2 @@
+QA output created by 745
+Silence is golden
-- 
2.45.1


