Return-Path: <linux-btrfs+bounces-4935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190288C45B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B98E1C20A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 May 2024 17:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D61CD26;
	Mon, 13 May 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODj1sSWB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4911CAAE
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620180; cv=none; b=SykrUh5ogJ50bexKCvUVOFJLU9Yza3Jul42kHo6OslRHWuEnC2GjgN90p3A+/LbpyAx9moDHrM0cjzQUL4/wfmOq0Coam92cnRLsv0uAd7r1iMefJuYYcMRFxEmss/DpQOnvzWtKoByyut6v7N2w90S9bC/7UGOItR5c8WN/oRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620180; c=relaxed/simple;
	bh=2yyzoZ4kQn1Ypmys/saiB4n2i2R8prujUWXRPluRApI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=D6iuxQPNyOIVClCKRAL/kd8p8pvHhdKdIUl1D2sbpe6roocDN+5k+OQVt8jjoy+WQC2JWiK0I2w/2gU0idAgByrQggOPjHGVwN0/QJSu4yjv8+z8Sph+qe6/gfU9Kcfw8baKFB7eSYnEpGtuHDRaxphUxRFmJJUzfYiWrecTKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODj1sSWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37537C113CC
	for <linux-btrfs@vger.kernel.org>; Mon, 13 May 2024 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715620179;
	bh=2yyzoZ4kQn1Ypmys/saiB4n2i2R8prujUWXRPluRApI=;
	h=From:To:Subject:Date:From;
	b=ODj1sSWBdRu9p3YLXOnO9bwxZZmRTQJg17S8I1yPH069ntB/jUjyZOVAlXBLpzgaU
	 aRdTE0Gh/+RGtNW2rpy52LKEaNnK5XOby+zAcCXT3rAGBiqgZLC9sC0rISXgI1x2YF
	 qkx0WeO/mSH/aCZsRftLam0fhh1MI1WBnWDkBge35N+DrFXVnWyhCgzTtOqm8c/AKv
	 VZhm1OcXEDdaPoAEFASModbB+LOj8tEMWa0LSc8EqQ/nen3YV/IZhusC8E3NXaVBZS
	 W/TjyvmyLzwtx9436LcKZsf1EH44dBtSucC2nKBK2Kb4ikH3PRtMTvy3GHynlGHeI3
	 jspOnzpLRy94g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove no longer used btrfs_migrate_to_delayed_refs_rsv()
Date: Mon, 13 May 2024 18:09:36 +0100
Message-Id: <7a6704f8877c76f07ea3fc2e995b0bceea9ef602.1715620125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_migrate_to_delayed_refs_rsv() is no longer used.
Its last use was removed in commit 2f6397e448e6 ("btrfs: don't refill
whole delayed refs block reserve when starting transaction").
So remove the function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 42 ------------------------------------------
 fs/btrfs/delayed-ref.h |  2 --
 2 files changed, 44 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6cc80fb10da2..6b4296ab651f 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -194,48 +194,6 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info)
 					      0, released, 0);
 }
 
-/*
- * Transfer bytes to our delayed refs rsv.
- *
- * @fs_info:   the filesystem
- * @num_bytes: number of bytes to transfer
- *
- * This transfers up to the num_bytes amount, previously reserved, to the
- * delayed_refs_rsv.  Any extra bytes are returned to the space info.
- */
-void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       u64 num_bytes)
-{
-	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
-	u64 to_free = 0;
-
-	spin_lock(&delayed_refs_rsv->lock);
-	if (delayed_refs_rsv->size > delayed_refs_rsv->reserved) {
-		u64 delta = delayed_refs_rsv->size -
-			delayed_refs_rsv->reserved;
-		if (num_bytes > delta) {
-			to_free = num_bytes - delta;
-			num_bytes = delta;
-		}
-	} else {
-		to_free = num_bytes;
-		num_bytes = 0;
-	}
-
-	if (num_bytes)
-		delayed_refs_rsv->reserved += num_bytes;
-	if (delayed_refs_rsv->reserved >= delayed_refs_rsv->size)
-		delayed_refs_rsv->full = true;
-	spin_unlock(&delayed_refs_rsv->lock);
-
-	if (num_bytes)
-		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
-					      0, num_bytes, 1);
-	if (to_free)
-		btrfs_space_info_free_bytes_may_use(fs_info,
-				delayed_refs_rsv->space_info, to_free);
-}
-
 /*
  * Refill based on our delayed refs usage.
  *
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 04b180ebe1fe..405be46c420f 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -386,8 +386,6 @@ void btrfs_inc_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
-void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
-				       u64 num_bytes);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
 
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
-- 
2.43.0


