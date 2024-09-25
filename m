Return-Path: <linux-btrfs+bounces-8220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D448985760
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C432D284881
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48DB189BB2;
	Wed, 25 Sep 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQwBKJM3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C8189BA0
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727261439; cv=none; b=P4YWOXk/u8B72vFtFPkZa1d54WnydDF3W7e5fUb6NY3gWZ1U32uSc1xTrZ7TQ0uKqVRVcEECMPN9SaZiYP9odeEu3APLmiaSsZnxnTOmxA6pAI1Xv3oI8W7vyxC/+7goK+9SKRFe3hBSBqKrlmm4t0QmPAht5WA3XeO7bMEA5ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727261439; c=relaxed/simple;
	bh=PE5610vDFykwGSsOuVMsKT7kF0OwoCdMroW536x3e9Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixxmw3x5ADqb2K7LiXAWp9DLb7qTQu1s5/BA+9EcJyv2+jrjq4+usuyM3Zbt5rffeRDVd05szzap94b9IyEJyE5SfGEmha87RIy0wc2kVqx+U118fnZM3uLf4rPvkZGXw00uFQjlv6e4v6mvgey0lEjP591sFkgvrln+0l5Jhl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQwBKJM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C6BC4CEC7
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727261438;
	bh=PE5610vDFykwGSsOuVMsKT7kF0OwoCdMroW536x3e9Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IQwBKJM3Hn6E4iQY44ogAYZLKzlZuclLjO0qKeCrXwR0lh9XHBS+cEg9ATVyTyijt
	 gU8KKSP/giV74zDzpHIqlwQpHmGUcUuukiuKWcyGVOkA2r9JV40aMzkMOtw4IC0DJx
	 HiSBtlMe2dcaaHxRk5yeTCIdum/Es/F7zSV/DjJti3vY2nZtqiv/wlvSDxtovW89Wi
	 p6GHz6lN5PO3Nc80K7wgCEZFWAm9lpbSapr+rbPik7BM1hZo8nHka4bx4x21GCl3Is
	 iqAlG9Kn25DGhgTzq9ug3sVkTqGCcJCm7zQZaAXHhRH3VGDaAkqEHKkOBOVRM2qBuh
	 dITaGN9yIXe/A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: store fs_info in a local variable at btrfs_qgroup_trace_extent_post()
Date: Wed, 25 Sep 2024 11:50:27 +0100
Message-Id: <c6bf4b78cf45a1e50ae3118aa020d4013efaf84f.1727261112.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1727261112.git.fdmanana@suse.com>
References: <cover.1727261112.git.fdmanana@suse.com>
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
index 4eaeea5f2241..8f9f2828c46e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2060,10 +2060,14 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
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
@@ -2086,16 +2090,13 @@ int btrfs_qgroup_trace_extent_post(struct btrfs_trans_handle *trans,
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


