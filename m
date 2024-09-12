Return-Path: <linux-btrfs+bounces-7970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F12E9767E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1A91F249F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 11:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832F51A7ADD;
	Thu, 12 Sep 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D27rPBiU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF671A0BE0;
	Thu, 12 Sep 2024 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140409; cv=none; b=OQzC2PSE8Y/QdO4+HP+5bfHqtL5kmqPNY/fZMbgFFUI2HAlnXlmCwKEgYL8QebaTyKK28Vo6iDJ2JTBHeYC1vsfb0pdd8Df1kcCORwFL9VG9hiqaUb/Fau7h2mwbo//2BmU7Gi5rMj4MAlbqBxBP4N4P8z0ea99l7JwUuyXhwiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140409; c=relaxed/simple;
	bh=vDNybxdkeiIvQV0P0e3juPCj6kT6sRbxPouZsoeenhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eagyDBBTFCz1hH5k1JrS6rG6sJNbrShjLGD1kZV/TIaL78uFBxL9msFvCnVxdinmZn+WlkhrGVfalW6OvdBA5Nytf4KQKwe5GzCcR2KcPTfEEceV/7CmVSn6HW3BwcSCg9RtxagInl6hJdqHCcP+IzYe8+m6u6jlrzeWFzw4K9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D27rPBiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600EFC4CEC4;
	Thu, 12 Sep 2024 11:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726140409;
	bh=vDNybxdkeiIvQV0P0e3juPCj6kT6sRbxPouZsoeenhw=;
	h=From:To:Cc:Subject:Date:From;
	b=D27rPBiUyDKT32pFpClp3qJVwwsiBGaxymwrwzGA4QX2FrNqyOTwTzHBux2iSeuNg
	 QxTDytSfpemxXp76sO/wuFoDQVzPKM9RDbHF3qxX03QTcukMRZKdbkYH0GSqXqmZTQ
	 XcOkPvS69da2Z6Ea8N/vUEDxMk+ludsgi2utSj414p9KD+BxDEs818PGxp5en3yYZD
	 iQPMsCl4k3+sVsVL2nvAJU+tmNzD338YzOfOLuW4o5DzAeN1ym0tLpiEmFwBaziK3z
	 Dr2vZe8N8oRa3vrUXODDWJAwDDMIpkwC/4ElS4oOJk6TKSysK/gXMoCeXOu/CA9NOU
	 1jHRUS0/Qutbw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add missing kernel git commit IDs to some tests
Date: Thu, 12 Sep 2024 12:26:38 +0100
Message-ID: <1fe1768c5148fc857ddbba244e607f965a17937b.1726140369.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Three tests (btrfs/321, generic/364 and xfs/608) refer to kernel patches
that are now in Linus' git kernel tree, so update the tests to include
the commit IDs.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/321   | 2 +-
 tests/generic/364 | 2 +-
 tests/xfs/608     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/321 b/tests/btrfs/321
index e30199da..93935530 100755
--- a/tests/btrfs/321
+++ b/tests/btrfs/321
@@ -22,7 +22,7 @@ _require_btrfs_raid_type raid0
 _require_btrfs_support_sectorsize 4096
 _require_btrfs_command inspect-internal dump-tree
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit 10d9d8c3512f \
 	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
 
 # The bug itself has a race window, run this many times to ensure triggering.
diff --git a/tests/generic/364 b/tests/generic/364
index 34029597..968b4754 100755
--- a/tests/generic/364
+++ b/tests/generic/364
@@ -18,7 +18,7 @@ _require_command "$TIMEOUT_PROG" timeout
 
 # Triggers very frequently with kernel config CONFIG_BTRFS_ASSERT=y.
 [ $FSTYP == "btrfs" ] && \
-	_fixed_by_kernel_commit xxxxxxxxxxxx \
+	_fixed_by_kernel_commit cd9253c23aed \
 	"btrfs: fix race between direct IO write and fsync when using same fd"
 
 # On error the test program writes messages to stderr, causing a golden output
diff --git a/tests/xfs/608 b/tests/xfs/608
index a74c7bf3..7ac40137 100755
--- a/tests/xfs/608
+++ b/tests/xfs/608
@@ -9,7 +9,7 @@
 . ./common/preamble
 _begin_fstest auto
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit e21fea4ac3cf \
 	"xfs: fix di_onlink checking for V1/V2 inodes",
 
 _require_scratch_nocheck	# we'll do our own checking
-- 
2.43.0


