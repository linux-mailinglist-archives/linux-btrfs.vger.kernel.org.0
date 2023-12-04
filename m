Return-Path: <linux-btrfs+bounces-577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B33803A07
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48251F21263
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8E2E626;
	Mon,  4 Dec 2023 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcQfiGR9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2F42E401
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EA6C433C7
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706840;
	bh=Xzmi5Tjq4gK2hjSqVOBCnJdz7NcuJx/7Gh5SaGq3T9A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hcQfiGR9WuCitBYiIHukaikNCVnmWKNG3Uc3VMV8b8b2oGfUYH/HwHWIgTp5y8+eF
	 ZNozLz9jeMbQ35B55epFmSfCL9rFmKrVeBw7D3LCUwtvyZM3qR5sLnIXcEoyYVhUe1
	 ucvxaGaMj94rgUItC5bvFQhGfVTZHkFWLz1NmWQlqg3f/KBltLl0T9ilRcZE9iNRWy
	 dXvsibgWqh206Zd/kdeE+1fC0GMHC1+IObz//gQ6Cr9mCd5n+7VmZlL0mmNB9iPnAn
	 3vunWfsEb0ZOuZg8LzP4BSb4/lkhuB/s1JeRWwvBbO8cqhJeEuiDInOGVLGrBlERSv
	 lpxABol/SsoUw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: tests: do not ignore NULL extent maps for extent maps tests
Date: Mon,  4 Dec 2023 16:20:25 +0000
Message-Id: <aa1ff844c27872e8cc1d3c91a6728a7894c465dd.1701706418.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701706418.git.fdmanana@suse.com>
References: <cover.1701706418.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several of the extent map tests call btrfs_add_extent_mapping() which is
supposed to succeed and return an extent map through the pointer to
pointer argument. However the tests are deliberately ignoring a NULL
extent map, which is not expected to happen. So change the tests to error
out if a NULL extent map is found.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 40 +++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ac64eafad703..024588d02551 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -121,9 +121,14 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 		test_err("case1 [%llu %llu]: ret %d", start, start + len, ret);
 		goto out;
 	}
-	if (em &&
-	    (em->start != 0 || extent_map_end(em) != SZ_16K ||
-	     em->block_start != 0 || em->block_len != SZ_16K)) {
+	if (!em) {
+		test_err("case1 [%llu %llu]: no extent map returned",
+			 start, start + len);
+		ret = -ENOENT;
+		goto out;
+	}
+	if (em->start != 0 || extent_map_end(em) != SZ_16K ||
+	    em->block_start != 0 || em->block_len != SZ_16K) {
 		test_err(
 "case1 [%llu %llu]: ret %d return a wrong em (start %llu len %llu block_start %llu block_len %llu",
 			 start, start + len, ret, em->start, em->len,
@@ -209,9 +214,13 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 		test_err("case2 [0 1K]: ret %d", ret);
 		goto out;
 	}
-	if (em &&
-	    (em->start != 0 || extent_map_end(em) != SZ_1K ||
-	     em->block_start != EXTENT_MAP_INLINE || em->block_len != (u64)-1)) {
+	if (!em) {
+		test_err("case2 [0 1K]: no extent map returned");
+		ret = -ENOENT;
+		goto out;
+	}
+	if (em->start != 0 || extent_map_end(em) != SZ_1K ||
+	    em->block_start != EXTENT_MAP_INLINE || em->block_len != (u64)-1) {
 		test_err(
 "case2 [0 1K]: ret %d return a wrong em (start %llu len %llu block_start %llu block_len %llu",
 			 ret, em->start, em->len, em->block_start,
@@ -272,13 +281,18 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 			 start, start + len, ret);
 		goto out;
 	}
+	if (!em) {
+		test_err("case3 [0x%llx 0x%llx): no extent map returned",
+			 start, start + len);
+		ret = -ENOENT;
+		goto out;
+	}
 	/*
 	 * Since bytes within em are contiguous, em->block_start is identical to
 	 * em->start.
 	 */
-	if (em &&
-	    (start < em->start || start + len > extent_map_end(em) ||
-	     em->start != em->block_start || em->len != em->block_len)) {
+	if (start < em->start || start + len > extent_map_end(em) ||
+	    em->start != em->block_start || em->len != em->block_len) {
 		test_err(
 "case3 [0x%llx 0x%llx): ret %d em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx)",
 			 start, start + len, ret, em->start, em->len,
@@ -391,7 +405,13 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 			 start, start + len, ret);
 		goto out;
 	}
-	if (em && (start < em->start || start + len > extent_map_end(em))) {
+	if (!em) {
+		test_err("case4 [0x%llx 0x%llx): no extent map returned",
+			 start, start + len);
+		ret = -ENOENT;
+		goto out;
+	}
+	if (start < em->start || start + len > extent_map_end(em)) {
 		test_err(
 "case4 [0x%llx 0x%llx): ret %d, added wrong em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx)",
 			 start, start + len, ret, em->start, em->len, em->block_start,
-- 
2.40.1


