Return-Path: <linux-btrfs+bounces-12022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB96A4FCD2
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF68616BC6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD2215F5E;
	Wed,  5 Mar 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBwy+VQh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8562214806;
	Wed,  5 Mar 2025 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172000; cv=none; b=bEPlL5IS/X65AhRMnwHjXtmH+tXw/ffCgVI8pbW3DsXvubjNJNAbsWqCAEo+c+ApLZzUMtgHCEg8K5mP8OYCqoHlUKBJ66bUmJE9ykdQni/fczjGJy4QOup2rj/XwDrtGqF+T3fvL6f9y4Hir5pCm/hwqwLrUCGJDy5TtgOQ5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172000; c=relaxed/simple;
	bh=ndF43za14JMwSqYVrkpRLCTGBhgvbxhPQ3B7pubVlWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZlcXIwDsuQuCHwWO2gf5Po1sjTh0VpDjE25UR3maYK0o3kMe6k/uDsCvnSemPqgo+3JpQioE6LZvPcxrtQ7M+/Yfzg/4bbpuAi3MyzF6wBMWVvfQ5sRcp2k1EY8I+tPCiGxJSTyQWdSjGqhXryii3txwAIXu0kSzgk5jOAb+KDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBwy+VQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E93C4CEE2;
	Wed,  5 Mar 2025 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741171999;
	bh=ndF43za14JMwSqYVrkpRLCTGBhgvbxhPQ3B7pubVlWk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZBwy+VQhyQC47DY7FoLkNPGIKvwjmrx1bWn2yhOkvqm5S+bf1QGSBh9jqdXsdDhFx
	 e5qbE/rz9y8ilca6/7+YkUUZ6eGc+Xprkrbt0iu0V3nIm1xK7MiWv5DtrYQkOVHnm3
	 mZxDmCWqEhu6xSv9ogE6hrI/PQwM4R1uaGn7JtJacCvo95ld6UcHDsAQwGxrm7BdCK
	 tM4DzTiiftKr497MXr697M+63n4Mn6tWY1HCS6Hek0iAereDfKYgvpqXnieRePfQKn
	 SfHLrnvR5QtSTnAHkMVKSuL2FbcqVCxnHCdi//6CWVTMIyGCz90ohZ5RX6bcqtY8Qj
	 Q1BeWWRDhLBoQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/363: add annotation for btrfs kernel commit
Date: Wed,  5 Mar 2025 10:53:12 +0000
Message-ID: <c0d7592ed3a4f8d39245359b55948c1cd60b87bf.1741171979.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This test exposed a bug in btrfs for which a fix landed in the 6.14-rc3
kernel, so add a _fixed_by_kernel_commit annotation.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/363 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/363 b/tests/generic/363
index 74226a45..79b1ff89 100755
--- a/tests/generic/363
+++ b/tests/generic/363
@@ -13,6 +13,9 @@ _begin_fstest rw auto
 
 _require_test
 
+[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit da2dccd7451d \
+	"btrfs: fix hole expansion when writing at an offset beyond EOF"
+
 # on failure, replace -q with -d to see post-eof writes in the dump output
 run_fsx "-q -S 0 -e 1 -N 100000"
 
-- 
2.45.2


