Return-Path: <linux-btrfs+bounces-9165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76329B0155
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F03B24131
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185A1DE2BC;
	Fri, 25 Oct 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7x1fd2k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A771FDF87;
	Fri, 25 Oct 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855632; cv=none; b=k8H2X9VXzNyj/W8F3R7P05LupsvBDq2H7ulb/AYjwr4s1u6WN/oIQIlOY/an8WI32RhLyxz4qae362wuXK2Jrmmx86BuER573GYR4tX5PQ/HMxo6M9PeYj4cXIjFPxzByQOtukoYBeDplNMZb/ywctuzowEpsXUTmafl8XU9WLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855632; c=relaxed/simple;
	bh=02l5Pnw516StDjFny3oJQX01ltkoJVDuJI7FsqXtYkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaGUtcBWhx1GSH3HnPBwog+aJK5VW18TuKpxwxo0e9wPKY1dxx3paqQDYm4cBLQltxuJ16PT7MGLGpc0Zu9sPiI3B/p7xTgPDvA1Zk3+I2q6oWVHEM17WNFfDnuCIkzBYJvmNPBsHarLnJ0QrxgmcauFUm59/3Vrb99iWJ6Qeog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7x1fd2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3ACC4CECD;
	Fri, 25 Oct 2024 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729855631;
	bh=02l5Pnw516StDjFny3oJQX01ltkoJVDuJI7FsqXtYkU=;
	h=From:To:Cc:Subject:Date:From;
	b=q7x1fd2kUHoLTBjGcuNdk2uL+Go8GnunLHpOxHUorvXVcb3B5NPeIOxxfKZlgp1Cj
	 xfYmABR0YZtCHyiuhqIV9ki2XRq2BREAwczvDqee2uHde1b2QDP9sXiDtA5DKSyh4X
	 ExzL6gOL71XC9Sxfk4RzNDDP1otY4lTmoFEY0TNLN7+Oa8JS7/1fNTll/zvCbS+sPa
	 aSf4nHd3O8d+S1SxqCH0ttWy88kQDxq0GSM0C7t3l7PAh9Y+rOI+2vhBFPJbKuXunI
	 sNACUkTWIeqD1tWXTLZoHlW2Y51D6L0/SrHhNKJ3XnSnkAXILb6Q96PwI8IZlXTnTO
	 oiXj0o4zIoy3A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test remount with "compress" clears "compress-force"
Date: Fri, 25 Oct 2024 12:27:01 +0100
Message-ID: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that remounting with the "compress" mount option clears the
"compress-force" mount option previously specified.

This tests a regression introduced with kernel 6.8 and recently fixed by
the following kernel commit:

  3510e684b8f6 ("btrfs: clear force-compress on remount when compress mount option is given")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
 tests/btrfs/323.out |  2 ++
 2 files changed, 41 insertions(+)
 create mode 100755 tests/btrfs/323
 create mode 100644 tests/btrfs/323.out

diff --git a/tests/btrfs/323 b/tests/btrfs/323
new file mode 100755
index 00000000..fd2e2250
--- /dev/null
+++ b/tests/btrfs/323
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# Test that remounting with the "compress" mount option clears the
+# "compress-force" mount option previously specified.
+#
+. ./common/preamble
+_begin_fstest auto quick mount remount compress
+
+_require_scratch
+
+_fixed_by_kernel_commit 3510e684b8f6 \
+	"btrfs: clear force-compress on remount when compress mount option is given"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount -o compress-force=zlib:9
+
+# Confirm we have compress-force with zlib:9
+_mount | grep $SCRATCH_DEV | grep -q 'compress-force=zlib:9'
+if [ $? -ne 0 ]; then
+	echo "compress-force not set to zlib:9 after initial mount:"
+	_mount | grep $SCRATCH_DEV
+fi
+
+# Remount with compress=zlib:4, which should clear compress-force and set the
+# algorithm to zlib:4.
+_scratch_remount compress=zlib:4
+
+_mount | grep $SCRATCH_DEV | grep -q 'compress=zlib:4'
+if [ $? -ne 0 ]; then
+	echo "compress not set to zlib:4 after remount:"
+	_mount | grep $SCRATCH_DEV
+fi
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
new file mode 100644
index 00000000..5dba9b5f
--- /dev/null
+++ b/tests/btrfs/323.out
@@ -0,0 +1,2 @@
+QA output created by 323
+Silence is golden
-- 
2.43.0


