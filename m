Return-Path: <linux-btrfs+bounces-16592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E584BB406B1
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 16:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E30B5E1041
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC3A30DD1C;
	Tue,  2 Sep 2025 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVOc4ycu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E13594B;
	Tue,  2 Sep 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823279; cv=none; b=jTSr+AUWNPE7ciAvV64GypblrQkEpqTo0E22sfYTnYbGAzzahq6b4t9a7YMkktAy1ZPyJ4lG4YmVK4joBCU2PyE5zmITX5rKrSDLsxpnXD+Ehf6iefKPcn3j8pTLczriW2svdU0nWHQiUKBiNF/aGDchIzqL+7hec4gSr1hoeFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823279; c=relaxed/simple;
	bh=0IJTEiYr56m4s4d96SXuG0xl+OizQU1H15BkRY7P9CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZ8Qppq+kGHPOJ04yMr0GGZvN/aKSdzibZSLB/Lu7u0CY+5OdnO/PkS3x3ZoskNlLUAI6k9aR5la+7UfbP5wZ1uSRKOn08N4uEze2rPXnPVBspLBGo5WRhdPaceFd0DOYxFE5VOJVLNsT6lFIqdwC9ljWPKsrFrrsmwnZfrpthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVOc4ycu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9A3C4CEED;
	Tue,  2 Sep 2025 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823278;
	bh=0IJTEiYr56m4s4d96SXuG0xl+OizQU1H15BkRY7P9CA=;
	h=From:To:Cc:Subject:Date:From;
	b=QVOc4ycu77d7R7iDQ2RegfJueNf2spAZJUQym0Gt7z65svqQ2pQlvU2SUNcTNO94i
	 f9QFrrWNQ0K5uJhhdIiw7/FYuMGZvoAT0WUxEQzJvBAysGcw4DqksK/agKkun488Qh
	 6SGz95gQJcBJC4UTZJyur3Oia0d0kQIISSUHKvhWDBOi+ceBuu5GlO520w0iZuwK9O
	 WiD2/rY+JasnFrWR1gNCF2H+9lcnLQuMOIiWM8095p4I4Ks4UVwLiXvXqBzWegqYEd
	 qJ1KiWG8HZRkiJbeLY0kr/rtLpY5EjDr6dlbMJs0avZkI+y1Mc3vHN32PSEAM88DWI
	 MoWhKmhvYrvYQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: add commit IDs for kernel fixes already merged upstream
Date: Tue,  2 Sep 2025 15:27:54 +0100
Message-ID: <c2806ea741c0f0d185930c30dbc334bc1fbbfbd5.1756823100.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Replace the commit ID stubs for btrfs/301, generic/211 and generic/771
with the commit IDs in Linus' tree.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/301   | 2 +-
 tests/generic/211 | 2 +-
 tests/generic/771 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7f676001..f68ea03b 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -19,7 +19,7 @@ _require_xfs_io_command "falloc"
 _require_scratch_enable_simple_quota
 _require_no_compress
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 7b632596188e \
 	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
 
 subv=$SCRATCH_MNT/subv
diff --git a/tests/generic/211 b/tests/generic/211
index 6eda1608..f356d13b 100755
--- a/tests/generic/211
+++ b/tests/generic/211
@@ -15,7 +15,7 @@ _begin_fstest auto quick rw mmap
 
 _require_scratch
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 6599716de2d6 \
 	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
 
 # Use a 512M fs so that it's fast to fill it with data but not too small such
diff --git a/tests/generic/771 b/tests/generic/771
index ad30cc0a..ea3e4ffa 100755
--- a/tests/generic/771
+++ b/tests/generic/771
@@ -25,7 +25,7 @@ _require_scratch
 _require_test_program unlink-fsync
 _require_dm_target flakey
 
-[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 0a32e4f0025a \
 	"btrfs: fix log tree replay failure due to file with 0 links and extents"
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-- 
2.47.2


