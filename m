Return-Path: <linux-btrfs+bounces-18957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F90C595C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 19:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E51C540942
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342235F8BA;
	Thu, 13 Nov 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miZ4DcWF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91F361DBF
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053010; cv=none; b=fZx3tesrDsXr9HTaISCCxGO7A1Gvot7TNXLS4VgeDK8/YwTt66xZmur8wEIVQL9tR8fY5Uw5zCfEB4dFTzF7cO0MfRCvUM2iGD39l0hbyJf7/aRBnUNPIKwusWs4EK1Rf8Vpvkl+NjtUyVFvLujV13hhjdCaBaGe1u2V0Egkqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053010; c=relaxed/simple;
	bh=4IgITXoNyEvMX3yZ+aWWHD5AFwhpSogCcau0wGHfULc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndDDl0roT15QAF++UotLnB2Ehhl+RGJm/8Bk1HgYHWvQcxkylb6NSj3YzrUyM5wXDV+ck1amBYZrODFO/p4kR8H81+4ZtLJvNQLw3stuHu6pSa4XqrxzYozfHVxmYNCHl9VcH/d1BZJ+FqUrWBImK9sOBy5T9a6u8NjoMVtZm5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miZ4DcWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D409EC19423
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053010;
	bh=4IgITXoNyEvMX3yZ+aWWHD5AFwhpSogCcau0wGHfULc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=miZ4DcWF3VTn03OqDzw10mm01DrFt8t++4PQR7ko4qGReQSci+ouoxcrEq5ebjnKs
	 K987KxhP0QvFnnqTxLvU9BX3AgYSfKoYKmsPF3PClxsdQ7wU99/D1jT5tExdbOx/YN
	 Jn7OjXo56z0CGS1sg6+Vk3bcFGTqmn3K0//BbBxkU4jBG5L2pWJ/GBip2A76duboFq
	 aW/LFuFz17Iirw6VLWvGW7AdYblWoDEscjO/0VScpH1GdDrT732ZdeShsQr5U04sRh
	 vG6D5Y5hikH3ySgboUD6dTC3/IP8zYMo0MKfYCvEiKDTnnwZzh72VzrPv+JQGyE5yz
	 HMrSGz7vObEXQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: abort transaction on item count overflow in __push_leaf_left()
Date: Thu, 13 Nov 2025 16:56:38 +0000
Message-ID: <f747c8600c59c507ba6955057c7c201f1b4f0466.1763052647.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1763052647.git.fdmanana@suse.com>
References: <cover.1763052647.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If we try to push an item count from the right leaf that is greater than
the number of items in the leaf, we just emit a warning. This should
never happen but if it does we get an underflow in the new number of
items in the right leaf and chaos follows from it. So replace the warning
with proper error handling, by aborting the transaction and returning
-EUCLEAN, and proper logging by using btrfs_crit() instead of WARN(),
which gives us proper formatting and information about the filesystem.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 57b7d09d85cc..8b54daf3d0e7 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3393,9 +3393,13 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
 
 	/* fixup right node */
-	if (push_items > right_nritems)
-		WARN(1, KERN_CRIT "push items %d nr %u\n", push_items,
-		       right_nritems);
+	if (unlikely(push_items > right_nritems)) {
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		btrfs_crit(fs_info, "push items (%d) > right leaf items (%u)",
+			   push_items, right_nritems);
+		goto out;
+	}
 
 	if (push_items < right_nritems) {
 		push_space = btrfs_item_offset(right, push_items - 1) -
-- 
2.47.2


