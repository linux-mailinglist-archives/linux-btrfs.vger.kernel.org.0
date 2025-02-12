Return-Path: <linux-btrfs+bounces-11397-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A07A31F79
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 07:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1600C1888EC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06711FDE29;
	Wed, 12 Feb 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="PAblcik0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C41F2367
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343106; cv=none; b=Yh7urdJOen2P0cKvVcPLlVFQyaQYjjGurgX+40uPnX63P11aD/R+Ny79cPO7U9CH5245cBXe/aXebyDm02rvBy6fM2Z1FfnDqtpXb+5WkqdWs9LKCk0CKRMjqXZQlG502yopjOOZE4ljODBFpZkt+Pl2RKTRwl9AlObYQZxWIhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343106; c=relaxed/simple;
	bh=oguoqJJD6S8BnvHEH31AXCBJoW0gRUT1dptTZez5O6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pP5Se2FozhTpe/xSHa7i6xJltsi8KO9dS57STqDBt9BA/Ql6mZMTF5MZge5+JaSEVQwgkaPcUUZlEVMmFtiB3Cb2DE2sRdygvUbjEr46GmDKGvSzoaezj+dL5yEw5zAL0vJhPR9+pCvs/rRI/lZMVvqdf5BpgsdPIKnZ5L4bNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=PAblcik0; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from 10511-DT-003.. (unknown [10.17.46.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.synology.com (Postfix) with ESMTPSA id 4Yt83Z4Tkvz9KmPJN;
	Wed, 12 Feb 2025 14:46:18 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1739342778; bh=oguoqJJD6S8BnvHEH31AXCBJoW0gRUT1dptTZez5O6Y=;
	h=From:To:Cc:Subject:Date;
	b=PAblcik0OW/pgWJdgXOnBqhu0ZLLp2nfDu/+OIJilwSD26fTjH3PtpiyJ7wfMYfWp
	 3+sw+K4bhPpXbx0qBT+D5BchgA7sNuvjKV4rg/ybFW4ldy9V/m12QdECiDAUWoOzL3
	 MjsuNLtS4c07Sa3O00V/Ib/QZmOe8FtFNx3LmRog=
From: tchou <tchou@synology.com>
To: linux-btrfs@vger.kernel.org
Cc: tchou <tchou@synology.com>
Subject: [PATCH] btrfs-progs: Preserve first error in loop of check_extent_refs()
Date: Wed, 12 Feb 2025 14:45:01 +0800
Message-Id: <20250212064501.314097-1-tchou@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0

Previously, the `err` variable inside the loop was updated with
`cur_err` on every iteration, regardless of whether `cur_err` indicated
an error. This caused a bug where an earlier error could be overwritten
by a later successful iteration, losing the original failure.

This fix ensures that `err` retains the first encountered error and is
not reset by subsequent successful iterations.
---
 check/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 6290c6d4..974ff685 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8322,7 +8322,8 @@ static int check_extent_refs(struct btrfs_root *root,
 			cur_err = 1;
 		}
 next:
-		err = cur_err;
+		if (cur_err)
+			err = cur_err;
 		remove_cache_extent(extent_cache, cache);
 		free_all_extent_backrefs(rec);
 		if (!init_extent_tree && opt_check_repair && (!cur_err || fix))
-- 
2.34.1


