Return-Path: <linux-btrfs+bounces-3247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1D87A897
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 14:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EFA91F2486A
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9875A43AB2;
	Wed, 13 Mar 2024 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqsfTS96"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024340BE1;
	Wed, 13 Mar 2024 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337187; cv=none; b=TeOXELNCwyjpp2L5qe3pdxHOcf/byBvbCE55vq1LKLhVV6TMoLFrdGzQX8wMvmsOdkOdFnXbuDps6gwXJnXc82zqHyhH4VgEuqatvUeuI/oFwz0iRHNE/+TZ7+TGKm2PuVGAJIGGYhLlfOKQeSyICGkdjevnJWm/8i4lMVp1Azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337187; c=relaxed/simple;
	bh=Inj0078X2a6s/TBXSMB2LiAPr7+cFZC/zP8TfODVyUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkuQDFJIu/swmSpoc5Fk0dTKt2/qvjL6O4GB+6QitkXwzmuP6sb/pjPg0wMi/C+zXl2C2O5jXwYPeO20tOEkCfHLhagmUWfgPeGKKGvglU0IhnwTlLyjPVc+25FPy8CxnepqnBZUhWPU3cKAX6sBn9sTazU/MmR4kMrIZOHVRa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqsfTS96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E815C433C7;
	Wed, 13 Mar 2024 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710337187;
	bh=Inj0078X2a6s/TBXSMB2LiAPr7+cFZC/zP8TfODVyUk=;
	h=From:To:Cc:Subject:Date:From;
	b=qqsfTS96o4huqsU0BV4254EzJOGo/vNV0MfiJSUTX6Sep2NP7v1QHTz5wxsUSFmr3
	 4b1QdMcIjEiiKgtsUuPWKsErzKvO6P+9FKu67ykgCC9QSC4+JLSQ9VfxiZA4IpoQou
	 EzfG6ZlA7Kp/NzS9rqPG1UBhFil6J0N3i6O5krT+c+jrGgPtYHR17J7TuufEgypa/P
	 MldThIk8n4vqtllccY+9qtKQ7ph3csAq6vyVVRlbrr7TzOOcXQ2DCmUnABUkhtyXYv
	 z/2XaJ1MbwXwVg/rIp2ENb7JVoFz+TW2ceanIzT/RfEsQyuUHgt9x+3jx6Ucx3+zF3
	 +5BlzYNiFgEqw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add missing kernel commit IDs to _fixed_by_kernel_commit() calls
Date: Wed, 13 Mar 2024 13:39:28 +0000
Message-ID: <d0c99b30b1f0b777375fa3512ff21b35d1d3a805.1710337140.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some tests are still using a 'xxx...' commit ID but the respective patches
were already merged to Linus' tree, so update them with the correct commit
IDs and in one case update the subject as well, because it was modified
after the test case was added and before being sent to Linus (btrfs/317).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/303 | 2 +-
 tests/btrfs/309 | 2 +-
 tests/btrfs/316 | 2 +-
 tests/btrfs/317 | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/303 b/tests/btrfs/303
index 26bcfe41..ed3abcc1 100755
--- a/tests/btrfs/303
+++ b/tests/btrfs/303
@@ -25,7 +25,7 @@ _require_test
 _require_scratch
 _require_xfs_io_command "fiemap"
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 5897710b28ca \
 	"btrfs: send: don't issue unnecessary zero writes for trailing hole"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/309 b/tests/btrfs/309
index 5cbcd223..d1eb953f 100755
--- a/tests/btrfs/309
+++ b/tests/btrfs/309
@@ -12,7 +12,7 @@ _begin_fstest auto quick snapshot subvol
 _supported_fs btrfs
 _require_scratch
 _require_test_program t_snapshot_deleted_subvolume
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 7081929ab257 \
 	"btrfs: don't abort filesystem when attempting to snapshot deleted subvolume"
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/btrfs/316 b/tests/btrfs/316
index 07a94334..f78a0235 100755
--- a/tests/btrfs/316
+++ b/tests/btrfs/316
@@ -17,7 +17,7 @@ _begin_fstest auto quick qgroup
 _supported_fs btrfs
 _require_scratch
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit d139ded8b9cd \
 	"btrfs: qgroup: always free reserved space for extent records"
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/btrfs/317 b/tests/btrfs/317
index 59686b72..b17ba584 100755
--- a/tests/btrfs/317
+++ b/tests/btrfs/317
@@ -10,8 +10,8 @@
 . ./common/preamble
 _begin_fstest auto volume raid convert
 
-_fixed_by_kernel_commit XXXXXXXXXX \
-	"btrfs: zoned: don't skip block group profile checks on conv zones"
+_fixed_by_kernel_commit 5906333cc4af \
+	"btrfs: zoned: don't skip block group profile checks on conventional zones"
 
 . common/filter.btrfs
 
-- 
2.43.0


