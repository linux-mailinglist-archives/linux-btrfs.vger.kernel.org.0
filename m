Return-Path: <linux-btrfs+bounces-8245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E510987055
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06132B274C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD61AD3F4;
	Thu, 26 Sep 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhhJlhqd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13C1ACDF9
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343211; cv=none; b=qCir9qQMcxI3OmJIqj9i3SUT7+7DflQMD8Cfx0hnASBYAD7NLgWcbHbQ/+2OuuC02gVDKY9BZAmB6bOkFfGrAiuaVu6yrTUE/AD42AkxLvhjUdg5T/6/fV0mRlgJvqbMTPXQ3Mnr7wjvNbIgnQ/CvXTkdGPcw8mZ9cIG+MCmBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343211; c=relaxed/simple;
	bh=SUn/vvrncCE0nhQgNheq+rKNJo1IJc30uF6+NgEanTs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGOHu546DLVgrSgZ2H35Mi9/4eXdjMj1J4NpCPqQ8Vh4umsi/oC9lKyCkttRKzZu3u1Jb6egqdoeucc+dUhB31Skq7RioggErTLCMdfwxP5PL8o/I7R3kjlegUwVSW5W0kg4e8Fi4Zca0rC2ZwEdMkM8Ue/RYlLyNORE1x91ydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhhJlhqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50A1C4CEC5
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343210;
	bh=SUn/vvrncCE0nhQgNheq+rKNJo1IJc30uF6+NgEanTs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OhhJlhqdgF/cMHxeRgdRFtSQL5vrIK85xsGTwwL4vxauvDwG1c/Vk4a/7cI3kH/aD
	 CIxGJByOZ3rLeZUe6Y8/sJbruRTuuse8AIjR6oweL+/dpv+tRciQ5IY3lWDEqCvHBW
	 3jEFO/HDt4XS9ewfiCMJO3v71IcqxcUOv2O5Q3aWPIQcQF04DeuOX4BhlygeRf4px5
	 vrZFJJvETA+0tfKfELvkkXZWLzxl5KOZROVVoHnSc2SH/pmVI3ac+pVHo4KJFJDBzI
	 XnKCEyADLSrVptJDi2P+nA1LW/hf3bM65Mka8DlRnk+QgrOY8GTMwvJ7HHNpwyB5ca
	 j+bjZrayjyi2g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/8] btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent_post()
Date: Thu, 26 Sep 2024 10:33:19 +0100
Message-Id: <864cd8ab499ea61d43b5bef36bb3b2210a60c224.1727342969.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727342969.git.fdmanana@suse.com>
References: <cover.1727342969.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of extracting fs_info from the transaction multiples times, store
it in a local variable and use it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 722edb04b78f..8d000a9d35af 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2070,10 +2070,14 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 				   struct btrfs_qgroup_extent_record *qrecord,
 				   u64 bytenr)
 {
-	struct btrfs_backref_walk_ctx ctx = { 0 };
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_backref_walk_ctx ctx = {
+		.bytenr = bytenr,
+		.fs_info = fs_info,
+	};
 	int ret;
 
-	if (!btrfs_qgroup_full_accounting(trans->fs_info))
+	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 0;
 	/*
 	 * We are always called in a context where we are already holding a
@@ -2096,16 +2100,13 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
 	 */
 	ASSERT(trans != NULL);
 
-	if (trans->fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
+	if (fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING)
 		return 0;
 
-	ctx.bytenr = bytenr;
-	ctx.fs_info = trans->fs_info;
-
 	ret = btrfs_find_all_roots(&ctx, true);
 	if (ret < 0) {
-		qgroup_mark_inconsistent(trans->fs_info);
-		btrfs_warn(trans->fs_info,
+		qgroup_mark_inconsistent(fs_info);
+		btrfs_warn(fs_info,
 "error accounting new delayed refs extent (err code: %d), quota inconsistent",
 			ret);
 		return 0;
-- 
2.43.0


