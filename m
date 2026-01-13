Return-Path: <linux-btrfs+bounces-20452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0467D1A6A4
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECFA1305BD4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899934EEF1;
	Tue, 13 Jan 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4Sn448F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5034EEE1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323063; cv=none; b=L8ATtx8GYiPSW1TzUwBx+LNL48nHvggftHOfoPzhCfBjByKq6EOUBgSr8ahcTh6q0kuJODLGA6vr9+2Th7+E5E6mRQwvDUCPhu6PkrK54h2mIH+n18mAldL79xWdutOyd8JU6QtzkBMjCN5M/uzvEijvdZYGYYkXFIV6xUbKN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323063; c=relaxed/simple;
	bh=19Ru1oWQl+Ul5vmu2CRtUW4JffXtvDyB5RaNTfRStc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv1QrQkprglIDwmawUEpqNwl6NLDP9Ac6LQlIHdmtWB/KdI25KcS8SVUveWgn6AKoSzqK+DTVU4yDbMJJj1MrA1g2tN89Lb1+kG4q7WQFOW5wtAwDhoRrAjqsrdF0ckZQo4GQeRg0s+M4twFEMsK6Hu+4ASR4bGx4pmVIUw0BVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4Sn448F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E8AC19422
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323063;
	bh=19Ru1oWQl+Ul5vmu2CRtUW4JffXtvDyB5RaNTfRStc0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H4Sn448FAw5PmnjZZec0rm/6M6+tlmPIwxx2U3bhi+K7WPRDU8sKPOOVA+qK7s6K6
	 qa8nDvcU1Tii+gAeyUqSU0h+/PTD2vBRWDPCVgm3omrWesSgtHh3wa7ukAmRs0Mbqs
	 2poUO+hEDI20WhaZd/J53K2QoPLIPtwCn3f4vNA4A0J/HjBRApgD9Jl0/D6auksADZ
	 HkiI5XR8HiZDGyzTq+IORbdwrD4y7Fo0cJ58gmW2F9xmL8ZCWwRPK1rQmNDhGzj3a1
	 Cl5XcO2J8+QZJtZCX6cpnLLdjKpwPDDomxz64GDCV/TuQCnai3+wJfZmNS1J1skyFZ
	 RRdAkekaYlaGg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: don't BUG() on unexpected delayed ref type in run_one_delayed_ref()
Date: Tue, 13 Jan 2026 16:50:57 +0000
Message-ID: <67cfcd32edcf65bbd73a5778c7a691b0b75749a6.1768322747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1768322747.git.fdmanana@suse.com>
References: <cover.1768322747.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to BUG(), we can just return an error and log an error
message.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1dcd69fe97ed..5ca65df8d04e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1761,32 +1761,36 @@ static int run_one_delayed_ref(struct btrfs_trans_handle *trans,
 			       struct btrfs_delayed_extent_op *extent_op,
 			       bool insert_reserved)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = 0;
 
 	if (TRANS_ABORTED(trans)) {
 		if (insert_reserved) {
 			btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
-			free_head_ref_squota_rsv(trans->fs_info, href);
+			free_head_ref_squota_rsv(fs_info, href);
 		}
 		return 0;
 	}
 
 	if (node->type == BTRFS_TREE_BLOCK_REF_KEY ||
-	    node->type == BTRFS_SHARED_BLOCK_REF_KEY)
+	    node->type == BTRFS_SHARED_BLOCK_REF_KEY) {
 		ret = run_delayed_tree_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
-		 node->type == BTRFS_SHARED_DATA_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_DATA_REF_KEY ||
+		 node->type == BTRFS_SHARED_DATA_REF_KEY) {
 		ret = run_delayed_data_ref(trans, href, node, extent_op,
 					   insert_reserved);
-	else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY)
+	} else if (node->type == BTRFS_EXTENT_OWNER_REF_KEY) {
 		ret = 0;
-	else
-		BUG();
+	} else {
+		ret = -EUCLEAN;
+		btrfs_err(fs_info, "unexpected delayed ref node type: %u", node->type);
+	}
+
 	if (ret && insert_reserved)
 		btrfs_pin_extent(trans, node->bytenr, node->num_bytes);
 	if (ret < 0)
-		btrfs_err(trans->fs_info,
+		btrfs_err(fs_info,
 "failed to run delayed ref for logical %llu num_bytes %llu type %u action %u ref_mod %d: %d",
 			  node->bytenr, node->num_bytes, node->type,
 			  node->action, node->ref_mod, ret);
-- 
2.47.2


