Return-Path: <linux-btrfs+bounces-14116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DCABBB55
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF44C17858A
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F9F274674;
	Mon, 19 May 2025 10:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DowXAheV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6327464F
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651330; cv=none; b=ijYs6st5+1kEgCHHh55RN9ZcRZMx5EwNuaNUYcDm5F4tqtmrXHgtGz8P6mV+4ovJDG3jRp0H2eK3xIxRK7k8dgcx+fBWrkStSVp/fQ46h3MU8nqnvLtrsuUAiDkUfaFY1s/U/UgpvviF+1WwdDE407Jxqbp1wJGRhJYupDIyZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651330; c=relaxed/simple;
	bh=mAzX7IJE3rxdyFTWTFkvAHyOl0G5hgR5HnXgRWq5ZnA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xj1GAbWVHdBJArltJltoiNgnt378QYWq+2roealkkyYRgQsdxrq7Qn1T2pGxOllBH69mQ8zmwmqkJxIQrM/ng8xsAOIKV1RMvU0cNelORBGVHk3BimCsajA0G7iCRCg2O5a7CvhtXhknj/mvZpHiXigNQPhrZR4tz2zoCrVtet4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DowXAheV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2646CC4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747651329;
	bh=mAzX7IJE3rxdyFTWTFkvAHyOl0G5hgR5HnXgRWq5ZnA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DowXAheVAHgG0hA8wso+u8Sc58RhnrB3+xZHQyJLCrV+LQy7/oG8Cy92jESwNH4bN
	 VLJVdzsyYU/c+US4nEN6/hJbTCtFb3K+mWGPyvD7qXBYf+S2uyyA1S+MqqPnJigb3j
	 StWSM0h4kqudz+nsIBxr1wqOqz50niQwSMmyBUQeI2pk+Kmo4ukJfLBvi8cc1FDsqr
	 5tueeIcIWNmuqiv1mm3KrCXgx6GcQdRwCFyUGI9xxMM5h1a81pJjQSF40YX8hquBIw
	 CXgUUZtrqmpOIzkY6HDPPDycshugNJKliZoiYFYRFyHIFcIEaJDfrZGWw9HQmUmB8L
	 /80Oj3+f1lK3Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: unfold transaction abort at btrfs_copy_root()
Date: Mon, 19 May 2025 11:42:04 +0100
Message-Id: <533b1e0a7f7c9257aa7f8ef36a76c33ae02b599d.1747649462.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747649462.git.fdmanana@suse.com>
References: <cover.1747649462.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of having a common btrfs_abort_transaction() call for when any of
the two btrfs_inc_ref() calls fail, move the btrfs_abort_transaction() to
happen immediately after each one of the calls, so that when analysing a
stack trace with a transaction abort we know which call failed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index a2e7979372cc..ae6cd77282f5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -284,14 +284,18 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
 	WARN_ON(btrfs_header_generation(buf) > trans->transid);
-	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
+	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID) {
 		ret = btrfs_inc_ref(trans, root, cow, 1);
-	else
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	} else {
 		ret = btrfs_inc_ref(trans, root, cow, 0);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 	if (ret) {
 		btrfs_tree_unlock(cow);
 		free_extent_buffer(cow);
-		btrfs_abort_transaction(trans, ret);
 		return ret;
 	}
 
-- 
2.47.2


