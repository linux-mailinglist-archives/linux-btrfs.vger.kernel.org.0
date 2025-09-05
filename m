Return-Path: <linux-btrfs+bounces-16669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D22B45D9E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D24E0EF5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46DF31328D;
	Fri,  5 Sep 2025 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/Cud05/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C1302172
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088663; cv=none; b=qIAM37n/IVprn1L5x2u/9beVipN8zyumbQ+T/AUEktpRvh7nBuXeFb3s9B+aeQ/rkliQLzq/v6ohX1jUnLTSZ9S7WbXAmS0qcGl+hjM8tlmC7BwEEQh4/rnguwRy96wcKymo8qrPGsYSAKK+j/lR91GXNUO46FLHgWW5EqJfcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088663; c=relaxed/simple;
	bh=HT3X/DitzgDCdtjzQErmHJjrkNJGn/qUHuNGLS7EJN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUPZyPOfgfSQ8ufmDeLW0j4K/bmL+cZPhe0nZ3oH2alFfce9t5Y+pRaL0WyQnMutAM9c5m5Jy4UViOa4i6Pt0ohI8oYtFUlk67Q+0C+ZrdcFrcV0Ud5Q/EBfcBrqNaAl8Xu17O014+naARONsgpnBXZo4jFnPe5fl6hJnlzEd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/Cud05/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F9EC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088662;
	bh=HT3X/DitzgDCdtjzQErmHJjrkNJGn/qUHuNGLS7EJN8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r/Cud05/ElxQi0aYq575emHBCTGW1SyWQlMFJ2nHg1Q+XWrv2a9dEIQTtfh46z/S9
	 WgHboySMgT2ee52oOQtRxL1a5KMJeB6H9O2Gt2UBRzPGJ6py0/lLTFko94A657Tv+Y
	 bKnN9UixfYYwJ0PrqX1QyMUJBY+upOCWp4wd5HCwzHyRWuRETj9ROKg+S8iWHIHId2
	 HvHfOaTKKdzCjRS2MfS1IbMw/quRQwgMZ2T4Bef5fKmZ9Qhw10J4Y8MbS/oYmGT+gh
	 icmWho6umP1x3lluQu00q1h0245F0ew/Tt5CIKJNNBW8Y20MZlPn+7lhqlcK25jWr7
	 +6E1fYQ3e8d2g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 25/33] btrfs: avoid unnecessary path allocation when replaying a dir item
Date: Fri,  5 Sep 2025 17:10:13 +0100
Message-ID: <09711880a84c71e3d034b135ebc31a86adaa3000.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to allocate 'fixup_path' at replay_one_dir_item(), as the
path passed as an argument is unused by the time link_to_fixup_dir() is
called (replay_one_name() releases the path before it returns).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a912ccdf1485..de1f1c024dc0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2147,18 +2147,10 @@ static noinline int replay_one_dir_item(struct walk_control *wc,
 	 * dentries that can never be deleted.
 	 */
 	if (ret == 1 && btrfs_dir_ftype(wc->log_leaf, di) != BTRFS_FT_DIR) {
-		struct btrfs_path *fixup_path;
 		struct btrfs_key di_key;
 
-		fixup_path = btrfs_alloc_path();
-		if (!fixup_path) {
-			btrfs_abort_transaction(wc->trans, -ENOMEM);
-			return -ENOMEM;
-		}
-
 		btrfs_dir_item_key_to_cpu(wc->log_leaf, di, &di_key);
-		ret = link_to_fixup_dir(wc, fixup_path, di_key.objectid);
-		btrfs_free_path(fixup_path);
+		ret = link_to_fixup_dir(wc, path, di_key.objectid);
 	}
 
 	return ret;
-- 
2.47.2


