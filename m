Return-Path: <linux-btrfs+bounces-578-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A7F803A08
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0827C1C20A63
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Dec 2023 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65542E635;
	Mon,  4 Dec 2023 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPyLfH17"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B910A2E621
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F631C433C9
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Dec 2023 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701706841;
	bh=dYmdtilApunVXzR9FZR7krVWHQ3hjcDJk4pOJYM4Ztc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hPyLfH17SWU+PqNRIb+270DvI7TrzSF+LH4VvFGACD/rdwHYds5O8XqUfXjmI8LIT
	 txZzG/Wn/3kKmYaELm/bksmj1KBER487p6+EyhYlUYyR3qg9bIJWCiIADONGQBNa1J
	 /B0+QjwS8ekIbjuYghc72EWaJA8fxmpETYLlf0vVT9bcHGfiEGiL2jWa5eNsy1zd5f
	 9r5i7hkVY8/x0TOZKE/WcfErLuhIH8unCY6AB04QLIsIB0ghGnwvvISUBUkZs49c2a
	 4EH4/bZFUka1TWVNn+KrWPw866d42+crjRhVd0GofDWa4zqyoqGpPPsZCY9qFFkamO
	 P5F8vQsNRkSmQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: tests: print all values as decimal in messages for extent map tests
Date: Mon,  4 Dec 2023 16:20:26 +0000
Message-Id: <4a628b498353cda9d67306d858d27f49fe82b694.1701706418.git.fdmanana@suse.com>
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

Some error messages of the extent map tests print decimal values of start
offsets and lengths, while other are oddly printing in hexadecimal, which
is far less human friendly, specially taking into consideration that all
the values are small and multiples of 4K, so it's a lot easier to read
them as decimal values. Change the format specifiers to print as decimal
instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 024588d02551..1eb442ea89a5 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -25,7 +25,7 @@ static void free_extent_map_tree(struct extent_map_tree *em_tree)
 #ifdef CONFIG_BTRFS_DEBUG
 		if (refcount_read(&em->refs) != 1) {
 			test_err(
-"em leak: em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx) refs %d",
+"em leak: em (start %llu len %llu block_start %llu block_len %llu) refs %d",
 				 em->start, em->len, em->block_start,
 				 em->block_len, refcount_read(&em->refs));
 
@@ -277,12 +277,12 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
-		test_err("case3 [0x%llx 0x%llx): ret %d",
+		test_err("case3 [%llu %llu): ret %d",
 			 start, start + len, ret);
 		goto out;
 	}
 	if (!em) {
-		test_err("case3 [0x%llx 0x%llx): no extent map returned",
+		test_err("case3 [%llu %llu): no extent map returned",
 			 start, start + len);
 		ret = -ENOENT;
 		goto out;
@@ -294,7 +294,7 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	if (start < em->start || start + len > extent_map_end(em) ||
 	    em->start != em->block_start || em->len != em->block_len) {
 		test_err(
-"case3 [0x%llx 0x%llx): ret %d em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx)",
+"case3 [%llu %llu): ret %d em (start %llu len %llu block_start %llu block_len %llu)",
 			 start, start + len, ret, em->start, em->len,
 			 em->block_start, em->block_len);
 		ret = -EINVAL;
@@ -401,19 +401,19 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
 	write_unlock(&em_tree->lock);
 	if (ret) {
-		test_err("case4 [0x%llx 0x%llx): ret %d",
+		test_err("case4 [%llu %llu): ret %d",
 			 start, start + len, ret);
 		goto out;
 	}
 	if (!em) {
-		test_err("case4 [0x%llx 0x%llx): no extent map returned",
+		test_err("case4 [%llu %llu): no extent map returned",
 			 start, start + len);
 		ret = -ENOENT;
 		goto out;
 	}
 	if (start < em->start || start + len > extent_map_end(em)) {
 		test_err(
-"case4 [0x%llx 0x%llx): ret %d, added wrong em (start 0x%llx len 0x%llx block_start 0x%llx block_len 0x%llx)",
+"case4 [%llu %llu): ret %d, added wrong em (start %llu len %llu block_start %llu block_len %llu)",
 			 start, start + len, ret, em->start, em->len, em->block_start,
 			 em->block_len);
 		ret = -EINVAL;
-- 
2.40.1


