Return-Path: <linux-btrfs+bounces-2035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27521845F60
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32B41C22776
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38A127B69;
	Thu,  1 Feb 2024 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXMB6GeO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968F127B52;
	Thu,  1 Feb 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810644; cv=none; b=IdRAbOkLlo/cIAbajE9mYgPeunegHBewsu1ee0Tykwo+kDtDoS81vjBs5QyVoVUJlmoQnqhGXiwQCMdvRrZwepyGUCq9JtkHU1eKv0g5vq3cHLymngJqSlRUhUaZoNl+GasNLMmeb0Qymx7/mtnYIBIfVAmOqYlD2e0qj+ZheIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810644; c=relaxed/simple;
	bh=wH0FTHH2f0Izmm4ituTnkzAKw0K7lbkSPsk6LoI5uM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPOJ5SEq/v7ZgoUGchMHx5VXgTMtqL2tQjNmp9tTTdkJeooVHr346P/ggC96RHWWzSAFE6GhKIBUMvqNEj/TlnZ5wx7T2Fo/SevZtyQl8Jy6ERfFX2gH656xQTx7489NosekYajmfGYeWtUm7q/FoXUa1/cbVlxRXk/qUpgnSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXMB6GeO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF41C433C7;
	Thu,  1 Feb 2024 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810644;
	bh=wH0FTHH2f0Izmm4ituTnkzAKw0K7lbkSPsk6LoI5uM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXMB6GeOCRjKa6tbBpXKbvKI3nFivbOOTRaHj0uwBrw8ciRqeQNSq5mTLFLtPoP5J
	 qESqz00JSuNgPdYS56Map/CxGCrL6g61ogcyxTcmNvsz9M8NnG6xC8QcJT+9pzgNRz
	 azIL2oThlR5fg8fNQnVWsftEqH4YH4SePd00CZc9eFIt4oi3uRfJYYKzSqQoUaR9hr
	 FLxCiVZ2jORoXfwd94vL2jXMNoCUDqayNF7oy9z2vz7QCwetC5fgdiIcFebOBkI0Zk
	 4E2y/8jqO6OlAX3ijJswiNPP7OJeg9d0v60v+P3VrpredtTvT1vZZYpyyEDOWztJCp
	 FYyPt5+Dp15Sg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/4] btrfs: require no nodatacow for tests that exercise compression
Date: Thu,  1 Feb 2024 18:03:47 +0000
Message-Id: <413f5f4f472480a66bcc3b48c45071cdeea12dfb.1706810184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several test cases fail when running with MOUNT_OPTIONS="-o nodatacow"
because they attempt to use compression and compression can not be
enabled on nodatacow files (it fails with -EINVAL). So make sure those
tests are not run if nodatacow is specified in MOUNT_OPTIONS.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/024 | 1 +
 tests/btrfs/048 | 1 +
 tests/btrfs/059 | 1 +
 tests/btrfs/138 | 1 +
 tests/btrfs/234 | 1 +
 tests/btrfs/281 | 1 +
 6 files changed, 6 insertions(+)

diff --git a/tests/btrfs/024 b/tests/btrfs/024
index 95c734ec..a8ca0e1d 100755
--- a/tests/btrfs/024
+++ b/tests/btrfs/024
@@ -17,6 +17,7 @@ _begin_fstest auto quick compress
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
+_require_btrfs_no_nodatacow
 
 __workout()
 {
diff --git a/tests/btrfs/048 b/tests/btrfs/048
index 8a88b8cc..aa2030b1 100755
--- a/tests/btrfs/048
+++ b/tests/btrfs/048
@@ -30,6 +30,7 @@ _require_test
 _require_scratch
 _require_btrfs_command "property"
 _require_btrfs_command inspect-internal dump-super
+_require_btrfs_no_nodatacow
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
 
diff --git a/tests/btrfs/059 b/tests/btrfs/059
index 76a1e76e..8b458b34 100755
--- a/tests/btrfs/059
+++ b/tests/btrfs/059
@@ -28,6 +28,7 @@ _supported_fs btrfs
 _require_test
 _require_scratch
 _require_btrfs_command "property"
+_require_btrfs_no_nodatacow
 
 _scratch_mkfs >> $seqres.full 2>&1
 _scratch_mount
diff --git a/tests/btrfs/138 b/tests/btrfs/138
index f99e58e7..427fdede 100755
--- a/tests/btrfs/138
+++ b/tests/btrfs/138
@@ -18,6 +18,7 @@ _begin_fstest auto compress
 _supported_fs btrfs
 _require_scratch
 _require_btrfs_command property
+_require_btrfs_no_nodatacow
 
 algos=($(_btrfs_compression_algos))
 
diff --git a/tests/btrfs/234 b/tests/btrfs/234
index c045ea6c..542515e8 100755
--- a/tests/btrfs/234
+++ b/tests/btrfs/234
@@ -18,6 +18,7 @@ _begin_fstest auto quick compress rw
 _supported_fs btrfs
 _require_scratch
 _require_odirect
+_require_btrfs_no_nodatacow
 _require_chattr c
 
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/btrfs/281 b/tests/btrfs/281
index 63fb89ea..64075225 100755
--- a/tests/btrfs/281
+++ b/tests/btrfs/281
@@ -25,6 +25,7 @@ _require_scratch_reflink
 _require_btrfs_send_v2
 _require_xfs_io_command "fiemap"
 _require_fssum
+_require_btrfs_no_nodatacow
 
 _fixed_by_kernel_commit a11452a3709e \
 	"btrfs: send: avoid unaligned encoded writes when attempting to clone range"
-- 
2.40.1


