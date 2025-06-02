Return-Path: <linux-btrfs+bounces-14372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C461ACAC89
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A553717EB92
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507421FDE02;
	Mon,  2 Jun 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWl5Hyka"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810120B7EE
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860404; cv=none; b=EA1TeJ7V0Drlq9wGObN/IBJjpCJ3iC03cxr9dy6D2ihDUtVmV9CvjuCAVQxJMkY3xWmgPMpRe03rsRkMWzmd1vN80R2DAYBVoR1rvXGM1GbZ8TTuiHbsbYX/NEQV1UwuTdIKS/TkZDtY5NvzlQG/o0DDBqw0XSkx+b4tD55btNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860404; c=relaxed/simple;
	bh=IPjL5N2N6WCypSE9KZC/bbvqhZkSe4TGDTbyEfTchs0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fABhBeUz+izFhEyJr/egDa/tSM0LsEVrnpTWbaFhUza7aca5OHcpR5/BkTp+691pCntJFibjHpNdh/EyVZSs8BpnAmrqrlzImBU1/gyH2r0LHubrYMYx1lmNkQkEkL1iUHpucOanw4Aws5MUPYS30aOLSve8l5/TFV6uXz96M5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWl5Hyka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FBDC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860404;
	bh=IPjL5N2N6WCypSE9KZC/bbvqhZkSe4TGDTbyEfTchs0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SWl5HykaSZcsc2wQoWoFhUF6ia0NL9g8iX+Iq499qAMpB4CypuP42YP2Ml9dRTh1A
	 tTNv2SgBinvTiGyftiOzoposz18zaf/XbbZC4I2LAYoS/kL0KKk4FVoc0ViXrYrJCt
	 79rIV/UJXYJ0LfjCyvuRbcSrrrUqW2mlafV0DunD942l/YV2ntU9eolmBuM6i2qsvh
	 LR+NMMu2I2GUndGubgOa/mFpW7v69lsjS6l3k+KDHDARrvigA+chH1/DtTo12b/GtM
	 3H3FaNNA6+lUfMs3alpPF37KZUz5e7VwsaubqsY5bd9vD8QvrVpEsOzX92GF2umjRi
	 5XhaoYM2iNe6g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/14] btrfs: switch del_all argument of replay_dir_deletes() from int to bool
Date: Mon,  2 Jun 2025 11:33:03 +0100
Message-ID: <b1094bf8659e697a774e9969f51e50816db90924.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The argument has boolean semantics, so change its type from int to bool,
making it more clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c639fe492a25..4e6a054682e3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -112,7 +112,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *root,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
-				       u64 dirid, int del_all);
+				       u64 dirid, bool del_all);
 static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
@@ -1632,8 +1632,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (inode->vfs_inode.i_nlink == 0) {
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
-			ret = replay_dir_deletes(trans, root, NULL, path,
-						 ino, 1);
+			ret = replay_dir_deletes(trans, root, NULL, path, ino, true);
 			if (ret)
 				goto out;
 		}
@@ -2284,7 +2283,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *root,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
-				       u64 dirid, int del_all)
+				       u64 dirid, bool del_all)
 {
 	u64 range_start;
 	u64 range_end;
@@ -2443,8 +2442,8 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(wc->trans,
-					 root, log, path, key.objectid, 0);
+				ret = replay_dir_deletes(wc->trans, root, log, path,
+							 key.objectid, false);
 				if (ret)
 					break;
 			}
-- 
2.47.2


