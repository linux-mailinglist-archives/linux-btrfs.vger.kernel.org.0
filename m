Return-Path: <linux-btrfs+bounces-14084-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6468DABA0D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F881C016CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49618224F6;
	Fri, 16 May 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2ZAQSXr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8268B1B6D06
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413357; cv=none; b=hRG66wpWVja7Z6yTM+x/pST3Ws23/CMpjF0PxLHG2lH2ZXUp3Ue/A8Riu2nCgAUnqfoSbMNgl12900IpvYA0nqG3B228+8E0QelX7n+2cymaBc/QKiRVhm1cK3J1pj/8gqqCJEQr4x7E6tujLtMszPW+AAflc7xFJLEmD01ZWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413357; c=relaxed/simple;
	bh=mdt1psNkrG42wMHPEFGb/MDP4bPr+sV2VPhrwbBaMII=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fXZg4kaAd+1JzWVcMxDUue9uLJLtGVIpvavpo3I9H9sZK6L3uUH6VOeKse8uMCRLJftywH2DyJvVU7ICyqm79cFyM9fwVCZT9OLitl9A1fpggZV5Bd2GYWfX96lFln+gCZJkI0XuAXJJttzzhGjgBMWDEZkr5U2+YQH4EjKevYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2ZAQSXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDA4C4CEE4
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 16:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413356;
	bh=mdt1psNkrG42wMHPEFGb/MDP4bPr+sV2VPhrwbBaMII=;
	h=From:To:Subject:Date:From;
	b=C2ZAQSXrpRSiw9TFEpfIyPEYF/fqxxD6ohNyTq57BhdNzKgAPsWY1wvIsPZTVlpAn
	 1YLRdmO9+f9WSpCr7pZ0FoIEBa25vymkodXiYpEGHrsjScZhC5CKq+/F/vdnCW8CKV
	 QT4hzI8tm3uOkPgkOwKx38RC3BD+Ub9FmGM0hpHi0DyJcUwCKYlcA3Wll4I8HWgO4m
	 PbR+hZgn5fLo5qddwrm5M7aUYRGeEIX3Qo1Qaq4IjDBiSiACRiH8kgTSFaokA2UAX4
	 ivHgCIYtJtKRCTbIHcuwgfCh6p0NQqe+VQ3jkEgpvHS++Bh2esO8sipPU/oHQMSz7m
	 0d7i5ZmhSkj8g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: unfold transaction abort at walk_up_proc()
Date: Fri, 16 May 2025 17:35:53 +0100
Message-Id: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having a common btrfs_transaction_abort() call for when any of
the rwo btrfs_dec_ref() calls fail, move the btrfs_transaction_abort() to
happen immediately after each one of the calls, so that when analysing a
stack trace with a transaction abort we know which call failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 678989a5931d..f1925ea2261f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5874,13 +5874,18 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 
 	if (wc->refs[level] == 1) {
 		if (level == 0) {
-			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF)
+			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
 				ret = btrfs_dec_ref(trans, root, eb, 1);
-			else
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+					return ret;
+				}
+			} else {
 				ret = btrfs_dec_ref(trans, root, eb, 0);
-			if (ret) {
-				btrfs_abort_transaction(trans, ret);
-				return ret;
+				if (ret) {
+					btrfs_abort_transaction(trans, ret);
+					return ret;
+				}
 			}
 			if (is_fstree(btrfs_root_id(root))) {
 				ret = btrfs_qgroup_trace_leaf_items(trans, eb);
-- 
2.47.2


