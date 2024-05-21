Return-Path: <linux-btrfs+bounces-5153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E180F8CADD3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B536283A72
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CD07581A;
	Tue, 21 May 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVilGFnz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F1524B4;
	Tue, 21 May 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292929; cv=none; b=ZGPOAq8d9nObcrSFGJWiJXWbqES8nPdVRP4jChJG7D6jQ8MXZ/rm101ZczfHpPVsmPesMl5zD0q/WpICTWnkOccdsv3xE1AWsNZxqGmOUlVcK+nYKGYiI0o57nyGHMci2lwCGxGNwIv7meqHruJNXEKr0ZdptLlQPMoVhGNJ2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292929; c=relaxed/simple;
	bh=Y4+NXoNlMonKYys35R5WG6EYcrUxX7y5RjmEuhywyDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsR+zyl8NM++fZz5P5N89WjD85K0KZ5LCWSbracTMCAa7xcSO1XNlLTbu/sxq+NHMcHJN5GgJyCbcagiCow7CR4O0L/V8UyTgF8ItV7BkrJqYZtFkbJR2zrQFWJQZrInOwmLAlumSQ6Uei+QhONxZtOmCPDieCWSSYujbibYDL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVilGFnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C300C2BD11;
	Tue, 21 May 2024 12:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292928;
	bh=Y4+NXoNlMonKYys35R5WG6EYcrUxX7y5RjmEuhywyDM=;
	h=From:To:Cc:Subject:Date:From;
	b=pVilGFnzIZbF03cvfUv6zqjbbdnYYlloMTLAJbIHc5zKtxrL9fqG7OcIxpFxJhQVQ
	 nnbn6QTk6Z3kauzmW+rNWZ1VQ7Im4TYnnxDZjRIG6DDn9NhVkht0wdeV2HheEd547O
	 9MHQN1YD+bETz1iaSgrnlIHUwN8mzta8k6ZVDpDn2wmxOP9DYUSLDazz0AeJ+0YXgm
	 dmaqW0jgG/3RMTpQ4UWTjZ96vdcNaSSIZe3n1l8swuTEvJsUdNr7kgXxfcjLsxo0Vy
	 Cb2BxwtcOYPERfQDRQPU3g6gD62IpOMjgnHHZ2yaxVXHXLfwuxo21gACaRbPQPGq98
	 BYiQNNU22M0cQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/733: add commit ID for btrfs
Date: Tue, 21 May 2024 13:01:29 +0100
Message-ID: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

As of commit 5d6f0e9890ed ("btrfs: stop locking the source extent range
during reflink"), btrfs now does reflink operations without locking the
source file's range, allowing concurrent reads in the whole source file.
So update the test to annotate that commit.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/733 | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/generic/733 b/tests/generic/733
index d88d92a4..f6ee7f71 100755
--- a/tests/generic/733
+++ b/tests/generic/733
@@ -7,7 +7,8 @@
 # Race file reads with a very slow reflink operation to see if the reads
 # actually complete while the reflink is ongoing.  This is a functionality
 # test for XFS commit 14a537983b22 "xfs: allow read IO and FICLONE to run
-# concurrently".
+# concurrently" and for BTRFS commit 5d6f0e9890ed "btrfs: stop locking the
+# source extent range during reflink".
 #
 . ./common/preamble
 _begin_fstest auto clone punch
@@ -26,8 +27,16 @@ _require_test_program "punch-alternating"
 _require_test_program "t_reflink_read_race"
 _require_command "$TIMEOUT_PROG" timeout
 
-[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 14a537983b22 \
-        "xfs: allow read IO and FICLONE to run concurrently"
+case "$FSTYP" in
+"btrfs")
+	_fixed_by_kernel_commit 5d6f0e9890ed \
+		"btrfs: stop locking the source extent range during reflink"
+	;;
+"xfs")
+	_fixed_by_kernel_commit 14a537983b22 \
+		"xfs: allow read IO and FICLONE to run concurrently"
+	;;
+esac
 
 rm -f "$seqres.full"
 
-- 
2.43.0


