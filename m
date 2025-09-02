Return-Path: <linux-btrfs+bounces-16591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3916B406AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FEB4E63AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BA130C36D;
	Tue,  2 Sep 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e14SekGf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7792F068A;
	Tue,  2 Sep 2025 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823268; cv=none; b=Jx6f79eVA+LjVwGIriltFE5inI3ZhD1QLyhgdEv8qnLdZIEOGqiC2HPG1B8/YbYijbpmXqu/+4JbIIgyUONApl/VRSsuV2iNjfHgkCuHu++k/2ykgeoIHR4rE1pRSP9yJYkrSAF39tI6ZXtggrXK721wPFcYAaZLc5GeB9+mmnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823268; c=relaxed/simple;
	bh=yopcKXJCdwydChpyUJV35M3C2nGCqm5bTkvZW1OllxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2RApGURViVFoUoYxVx3/smktuziFCmaf5g8ntYFuqpbtLZD3+8mEfSCQ5Pqzmao5xQgdf88UG57RLeMRBkDSkSa9P3VMhZGnnNYB7NXICH1rQn8YsDtuEkXs6RlTiC2LxrXpDDr0MCCVGix79x1b7GpMnrZK0UIZIqVWDAOAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e14SekGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F423C4CEED;
	Tue,  2 Sep 2025 14:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823266;
	bh=yopcKXJCdwydChpyUJV35M3C2nGCqm5bTkvZW1OllxU=;
	h=From:To:Cc:Subject:Date:From;
	b=e14SekGfWe30Ng57J74JA8KQuG7+myrg1cCSNF+sYuJRGuXktwIY6YYU2CE2ZkHUf
	 Xq8xjc6Z3+nwYbyfg09ut1A3JmXFH+34Ak3QZzLy0rqwe26iAlDcLYU+xrQJiLD7xJ
	 UzuvVpfGT+1SkaaHBjx6JPhUK5JDTRF0KRqW3EkrAtNSxZlzbF3wcUtwU4EfROglNy
	 1zuaMc2KjXxdq41J5PJKljIyrKV51myqLuJjNuxHItlUMltvB4pEPSLEsGCnb8xZkC
	 8SelJPC2X21WIpiPqxFIRqt3oJeRc19YpHg/o2S4Dh1wuab4do11HWIXno5kguZmLv
	 B51twkDyDKyyA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/363: mention btrfs kernel fix for block size < page size scenario
Date: Tue,  2 Sep 2025 15:27:40 +0100
Message-ID: <1d3740e7564f94ed51d18c4d53103624fb51e735.1756813886.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's another btrfs kernel commit that landed in v6.16-rc1 and fixes
another EOF truncation bug exposed by this test case, so add the commit
in a _fixed_by_kernel_commit call.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/363 | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/363 b/tests/generic/363
index 79b1ff89..f361878a 100755
--- a/tests/generic/363
+++ b/tests/generic/363
@@ -13,8 +13,12 @@ _begin_fstest rw auto
 
 _require_test
 
-[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit da2dccd7451d \
-	"btrfs: fix hole expansion when writing at an offset beyond EOF"
+if [ $FSTYP == "btrfs" ]; then
+	_fixed_by_kernel_commit da2dccd7451d \
+		"btrfs: fix hole expansion when writing at an offset beyond EOF"
+	_fixed_by_kernel_commit 8e4f21f2b13d \
+		"btrfs: handle unaligned EOF truncation correctly for subpage cases"
+fi
 
 # on failure, replace -q with -d to see post-eof writes in the dump output
 run_fsx "-q -S 0 -e 1 -N 100000"
-- 
2.47.2


