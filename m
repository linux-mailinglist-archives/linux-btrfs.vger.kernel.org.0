Return-Path: <linux-btrfs+bounces-16881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CCB7E197
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D76346161C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CE03054F3;
	Wed, 17 Sep 2025 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUv0Ynlj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375973054DC
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758095568; cv=none; b=mBKT+npjgD+yaAIdNWH7wd/MGqs9iHPKRluOCjXagCCYxW0/tW3K8uLoLsmd9tQu6vDy90bQ6oVJty/96swlzRv77JaOwevVVvJKU6xCg1a9pphfhWtefB1GJOPAogc02foZxlpxV7XV/Vz4453uTDINhLbJ9J5X7uJm51cU/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758095568; c=relaxed/simple;
	bh=zEckqmnMU6n3axFyEobL+xNcjd2E9O4Q+c+Fw6rfb8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0erAwrMakQEMZ5RkeR4CKGQBB5uBLlpgtZtQHDZ/OGJPVG3qQAMqpzFg1Ibsx+82GI2mXc3TUy1IUDH4GvL55AO68xa65pqG0qOU9EXtoa6Ba70Kzf1A6aVxDABZK8phDDGUpyKLFchAamuM7BiD58s1C8JBG2eikJtKv/1OW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUv0Ynlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D91CC4CEF9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758095567;
	bh=zEckqmnMU6n3axFyEobL+xNcjd2E9O4Q+c+Fw6rfb8I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dUv0YnljsUA7uxugvUyZ4Vn+At3JcCgN4x5iWB8LT0Gdmh9Kw90ESfLwb2gDWvYWk
	 Xv64xFcwL7k9qTIwD8+oiaugURyRwnGrl/LH8rRfTt5L2l/45LTfYpUE/eMvQtO4Nk
	 5KDg/blvhAXnKqNGgjd8TuWLVayOyqVw17AIdLP29fIrr4FhmgmzPLbspLKIb5AjkF
	 exxyqFHJL+bgXkVk7Q1X7EqISx95efrgz/gO8NpWWaocmAA+12f+jB0KgyM7blFOWs
	 nQGipJS6C602uHzSGQq/7JiI0iapQurdYHQ9OvaO1wFo74eMwkbQcS1vnWDckcSoXA
	 qQAlPL56sXrRA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: mark extent buffer alignment checks as unlikely
Date: Wed, 17 Sep 2025 08:52:39 +0100
Message-ID: <42029f4a001476e61a8168702a5f08dea8a2f1b6.1758095164.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1758095164.git.fdmanana@suse.com>
References: <cover.1758095164.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We are not expecting to ever fail the extent buffer alignment checks, so
mark them as unlikely to allow the compiler to potentially generate more
optimized code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 681f4f2e4419..5f0cce1bb7c6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3228,25 +3228,25 @@ static bool check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
 {
 	const u32 nodesize = fs_info->nodesize;
 
-	if (!IS_ALIGNED(start, fs_info->sectorsize)) {
+	if (unlikely(!IS_ALIGNED(start, fs_info->sectorsize))) {
 		btrfs_err(fs_info, "bad tree block start %llu", start);
 		return true;
 	}
 
-	if (nodesize < PAGE_SIZE && !IS_ALIGNED(start, nodesize)) {
+	if (unlikely(nodesize < PAGE_SIZE && !IS_ALIGNED(start, nodesize))) {
 		btrfs_err(fs_info,
 		"tree block is not nodesize aligned, start %llu nodesize %u",
 			  start, nodesize);
 		return true;
 	}
-	if (nodesize >= PAGE_SIZE && !PAGE_ALIGNED(start)) {
+	if (unlikely(nodesize >= PAGE_SIZE && !PAGE_ALIGNED(start))) {
 		btrfs_err(fs_info,
 		"tree block is not page aligned, start %llu nodesize %u",
 			  start, nodesize);
 		return true;
 	}
-	if (!IS_ALIGNED(start, nodesize) &&
-	    !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK, &fs_info->flags)) {
+	if (unlikely(!IS_ALIGNED(start, nodesize) &&
+		     !test_and_set_bit(BTRFS_FS_UNALIGNED_TREE_BLOCK, &fs_info->flags))) {
 		btrfs_warn(fs_info,
 "tree block not nodesize aligned, start %llu nodesize %u, can be resolved by a full metadata balance",
 			      start, nodesize);
-- 
2.47.2


