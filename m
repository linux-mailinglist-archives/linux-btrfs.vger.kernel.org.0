Return-Path: <linux-btrfs+bounces-19158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7281C70941
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 19:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id EE37628E31
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BC2E8B81;
	Wed, 19 Nov 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As958opz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59402317712
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575768; cv=none; b=lPoJtkIZKJpPVJjuOyRLWUtlq1R7hnHryGAqVIgDQdbjRL4PP9Gt9Sb7ShKJoW5sLQQuDrHBH6RchZ1IAqLxXHT2DTCenYFH3k8NPHs9L/OnpEw4bj53Q9tmXtyOFsStqjcJSA52juAjVN1Mn3zlUyXEpEXed76tVeZIxh9jZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575768; c=relaxed/simple;
	bh=UyVaOPI0J8nGPpXXsD3qPuLHIDtX6zdzXaZ3tarswMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TFMxdNy7wvG/eN5AhK2oVsJAdK+IVQjDw2wh5z8HxKpds5yxqVN0T2N8FOh+QlZ9E85/xjcPFV38YWsYYgYQGqBTreTZnYBIWYKutlAbSMJ9501ZgplOGqAFpotbsK60XVCpQkgKleTHu2BiQqqzyY6HjQpgIG05Ia5tQIACg40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As958opz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228EDC4CEF5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763575766;
	bh=UyVaOPI0J8nGPpXXsD3qPuLHIDtX6zdzXaZ3tarswMY=;
	h=From:To:Subject:Date:From;
	b=As958opz7iaRHJkikqxPXGMuhAGPYrCugwA4/dQhIMyhJhT//vyrrkCU/Xj/pYfAt
	 CWHMoJMHzzhaeKuFergmZW8wW+9HDRLgZ/qbr8DoGtFw5cm6TioW/hn30u/83WEWSa
	 6fcKEtiWnN38J0jyxi1msL1VD3QMayW3SuLb6/4sYXABgfoIZ+cy+3ebmiBHU0YGax
	 RvvsOkCf08LyolyZXtVZp/Ve0GZ4dhJWJLT5llybT12/xnBkPtY3cMBV/NCDlK1hhD
	 GkyvVqkTtoCv/U0Y+y/xrravk9o/PchnBubfjNfsiATaNkF5wsdp8Y8m6VKTFEzoyH
	 B8BIe/vOCfEQQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: do not allocate memory for xattr data when checking it exists
Date: Wed, 19 Nov 2025 18:09:23 +0000
Message-ID: <d95e088ffbc10bc6b5db30846e31970e347b0a3a.1763575479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When checking if xattrs were deleted we don't care about their data, but
we are allocating memory for the data and copying it, which only wastes
time and can result in an unncessary error in case the allocation fails.
So stop allocating memory and copying data by making find_xattr() and
__find_xattr() skip those steps if the given data buffer is NULL.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ebb5a74500f4..806cc4ba9dc4 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4943,6 +4943,7 @@ struct find_xattr_ctx {
 	int found_idx;
 	char *found_data;
 	int found_data_len;
+	bool copy_data;
 };
 
 static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
@@ -4954,9 +4955,11 @@ static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
 	    strncmp(name, ctx->name, name_len) == 0) {
 		ctx->found_idx = num;
 		ctx->found_data_len = data_len;
-		ctx->found_data = kmemdup(data, data_len, GFP_KERNEL);
-		if (!ctx->found_data)
-			return -ENOMEM;
+		if (ctx->copy_data) {
+			ctx->found_data = kmemdup(data, data_len, GFP_KERNEL);
+			if (!ctx->found_data)
+				return -ENOMEM;
+		}
 		return 1;
 	}
 	return 0;
@@ -4976,6 +4979,7 @@ static int find_xattr(struct btrfs_root *root,
 	ctx.found_idx = -1;
 	ctx.found_data = NULL;
 	ctx.found_data_len = 0;
+	ctx.copy_data = (data != NULL);
 
 	ret = iterate_dir_item(root, path, __find_xattr, &ctx);
 	if (ret < 0)
@@ -4987,7 +4991,7 @@ static int find_xattr(struct btrfs_root *root,
 		*data = ctx.found_data;
 		*data_len = ctx.found_data_len;
 	} else {
-		kfree(ctx.found_data);
+		ASSERT(ctx.found_data == NULL);
 	}
 	return ctx.found_idx;
 }
-- 
2.47.2


