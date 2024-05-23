Return-Path: <linux-btrfs+bounces-5266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320238CDAF3
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 21:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE4C2814DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173084A41;
	Thu, 23 May 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="lw08Nw5v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286A84A21
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492890; cv=none; b=nHJ1nDZOtgI/b479Gt+g0CRVXfVKySQa7nz2MEnvSIgYm51Zm0f4F3PffUKklyASalOKRokomEr4DBk8LpWyWkcG5N8SZRRvWwSytsvkCMwtOXQkHfsWSuhoOeJXaDExxMf8tIp8pu2a3osZNy7N4NIjtMBUmPUL7x598TiiSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492890; c=relaxed/simple;
	bh=uxE6MLu1DJPqCuemxmZjXKYql3CwdMm6zgP3s28Y4lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rj4deR0XyEni8ZiFM1KLCWwbbh51+5y1bfC8ZHHO0hq9fPj86uFdmY61Pp4qWOWHtf8S2N5mgLfgjTnwabuhFrBoxs1VwR7g66zuvOwFwDFZIFYb5k3zqHcGroaq2qLMoZ4hyFLoeOEgEbO9wiFWSTyZcgJ1lD9KLkp/m7K35cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=lw08Nw5v; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f3469382f2so7064295ad.0
        for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 12:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1716492887; x=1717097687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCTAW1mMpTuj2P7ThG+xoStLOMeeM6082Vk/5B19BCM=;
        b=lw08Nw5vtgutIZcuubu2Q3+cfJyFdSjxsNlEHxpdKem66BNgg8RxH60Dw6WoK9OUqp
         7Z5OfkHUI3YRbpFjZ6LnyeGzaDOWgQZP4w6hpglgNLaP13siSJSZeUiIpdboKp4q2rzP
         CF+GEnRJFLa51FfaLFhnYzul5QLWb+H2I+zrpqOfIdVXzn3VX5ckMGO94gaB8JJQicyi
         msk90Lr/0NcFi8v2JiAq7W53eAImc8MtMHZSrF8h0M3X7fqoU1m8BPUBP0rmA05emeTv
         IgTmXS11T0aU3BRC/roeNtPArzvXAUAnzCBN4qUk19eO/1GXKNC0gN1n+b3UtPwNKuM+
         s3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492887; x=1717097687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCTAW1mMpTuj2P7ThG+xoStLOMeeM6082Vk/5B19BCM=;
        b=SwfKFCAuOJUBuiL6v9FoT/kepzt/8uDt2f9aH1bZymT/mlxSnc+0zMZ9B95nlE40Xu
         vuIKSZs5qI/O/UuW+ZECF8vk8IB6JyjB8AWXoKnDidauA0xYqxd0+Z8DfzVen885dVYi
         snS9vHla0ZSu+N0hZD1NelGjCYPerLtnl1XrTbQmLtaQ1anxIAkhLiHbYB/04BRKPJPm
         tEzDSIHGOs1BUrryPx1G+Fh+L+wjkJMnRd+ywiYV5i8Mn6DiZEvJjSYBwy5HMj9+88Zu
         Xr/Ql8oIAXCu53gjbxYga8eO5sdfA/ifnnqp0RaeAJQKRz93rtUWCE8RIu55+BOfkpVK
         IJKA==
X-Gm-Message-State: AOJu0YxL4W9Km1apVGd0e6Z5+PmxcPB+sZFIdocM+WtLN4iQ/ub9KEWu
	EJUOzAjvW9wjEpMbcgy+Bgr7iJCd+gH+oANH6Rz0Y+hlpQtQDHiV9FKfnRLrFBIzyXy7qkAFg1G
	yo/A=
X-Google-Smtp-Source: AGHT+IHX3yAMngCiMi8ES43+V1TSJeCPwitWtCZTq8W1g51jiYWrayE3gQ8dliS7ftk2L+7Ya7gT9Q==
X-Received: by 2002:a17:902:d2c2:b0:1f3:2654:d7e5 with SMTP id d9443c01a7336-1f4486ebacbmr4355535ad.16.1716492887473;
        Thu, 23 May 2024 12:34:47 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:f769])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f3465fdcf4sm13852635ad.60.2024.05.23.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 12:34:46 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-btrfs@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH fstests] btrfs: add regression test for fsync vs. size-extending direct I/O into prealloc crash
Date: Thu, 23 May 2024 12:34:25 -0700
Message-ID: <297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <101430650a35b55b7a32d895fd292226d13346eb.1716486455.git.osandov@fb.com>
References: <101430650a35b55b7a32d895fd292226d13346eb.1716486455.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Omar Sandoval <osandov@fb.com>

Since this is a race, we just try to make the race happen in a loop and
pass if it doesn't crash after all of our attempts.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 tests/btrfs/312     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out |  2 ++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 00000000..aaca0e3e
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+#
+# FS QA Test 312
+#
+# Repeatedly fsync after size-extending direct I/O into a preallocated extent.
+#
+. ./common/preamble
+_begin_fstest dangerous log prealloc
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_command inspect-internal inode-resolve
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix crash on racing fsync and size-extending direct I/O into prealloc"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+sectorsize=$(_scratch_btrfs_sectorsize)
+
+# Create a bunch of files so that we hopefully get one whose items are at the
+# end of a leaf.
+for ((i = 0; i < 1000; i++)); do
+	$XFS_IO_PROG -c "open -f -d $SCRATCH_MNT/$i" -c "falloc -k 0 $((sectorsize * 3))" -c "pwrite -q 0 $sectorsize"
+	$SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/$i"
+done
+touch "$SCRATCH_MNT/$i"
+
+_scratch_unmount
+
+ino=$($BTRFS_UTIL_PROG inspect-internal dump-tree "$SCRATCH_DEV" -t 5 |
+      $AWK_PROG -v sectorsize="$sectorsize" '
+match($0, /^leaf [0-9]+ items ([0-9]+)/, arr) {
+	nritems = arr[1]
+}
+match($0, /item ([0-9]+) key \(([0-9]+) EXTENT_DATA ([0-9]+)\)/, arr) {
+	if (arr[1] == nritems - 1 && arr[3] == sectorsize) {
+		print arr[2]
+		exit
+	}
+}
+')
+
+if [ -z "$ino" ]; then
+	_fail "Extent at end of leaf not found"
+fi
+
+_scratch_mount
+path=$($BTRFS_UTIL_PROG inspect-internal inode-resolve "$ino" "$SCRATCH_MNT")
+
+# Try repeatedly to reproduce the race of an ordered extent finishing while
+# we're logging prealloc extents beyond i_size.
+for ((i = 0; i < 1000; i++)); do
+	$XFS_IO_PROG -c "open -t -d $path" -c "falloc -k 0 $((sectorsize * 3))" -c "pwrite -q -w 0 $sectorsize"
+	$SETFATTR_PROG -n user.a -v a "$path"
+	$XFS_IO_PROG -c "open -d $path" -c "pwrite -q -w $sectorsize $sectorsize" || exit 1
+done
+
+# If it didn't crash, we're good.
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 00000000..6e72aa94
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,2 @@
+QA output created by 312
+Silence is golden
-- 
2.45.1


