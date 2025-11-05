Return-Path: <linux-btrfs+bounces-18708-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDB4C33E3F
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 04:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE134B067
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1490261B64;
	Wed,  5 Nov 2025 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Z7eIMiTl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53625207A0B;
	Wed,  5 Nov 2025 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762315124; cv=none; b=vEvNH9RAbyPosfiydSFXDvbfpraunrJ7KFFxaFKWg0OWuryI51S4hFhUk2L499qsVb88KJoySbT/uOtCc4J2ze/+xT5vysPSedZRmYiafQ8B//VG33H8F1OkmSwdkuQ6OeXtUTXqxYlnPt4RAClGG3FLhiACFLneMXss5Uf32fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762315124; c=relaxed/simple;
	bh=HA34rT9MbOn6v+cCHPIG6gebFGnfBZSXK78zPX3McMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESj9eMbfxn9r26U/oE5H9yXmsTHro6KFVULgRqhq9uM5YOw7ia9JSf6LleyqqbpbjjA0FScGMcUlYqSc/ItqZm6g4NNOa03JPRBSJGXcHPzK4U6xsuLr+rRRqnlfipqtUbvKKHaIhAPrKn9d1eSrY7uJj2euOBW19ZFBxTguzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Z7eIMiTl; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 286d74537;
	Wed, 5 Nov 2025 11:53:28 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: clm@fb.com
Cc: dsterba@suse.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] btrfs: scrub: fix memory leak in scrub_raid56_parity_stripe()
Date: Wed,  5 Nov 2025 03:53:21 +0000
Message-Id: <20251105035321.1897952-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5225ead503a1kunmf844b9e66dba2c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTh8YVhkZSEoZQhlJQk1OSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJQkNDTFVKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=Z7eIMiTl1ncyFYsvF4gbkHWil0ig1x5vlXEqz5l47QmWx7clsSP6mCiNiiugbu5RYGK3jf77nXiTjlemuO3mYzJ4f+HQF7eDzMB0uYTb41PC/zuBQKi4npzq/2YAGvymXYuhFkZaJGjFKwH3cUvdGY6+EQvQ/ET+Yu3l3s3mZ08=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ntexdCEkYYHSEBIlmY4trtOnJFYrjtO9ngytPeHvIUA=;
	h=date:mime-version:subject:message-id:from;

scrub_raid56_parity_stripe() allocates a bio with bio_alloc(), but
fails to release it on some error paths, leading to a potential
memory leak.

Add the missing bio_put() calls to properly drop the bio reference
in those error cases.

Fixes: 1009254bf22a3 ("btrfs: scrub: use scrub_stripe to implement RAID56 P/Q scrub")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/btrfs/scrub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 651b11884f82..ba20d9286a34 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2203,6 +2203,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, full_stripe_start,
 			      &length, &bioc, NULL, NULL);
 	if (ret < 0) {
+		bio_put(bio);
 		btrfs_put_bioc(bioc);
 		btrfs_bio_counter_dec(fs_info);
 		goto out;
@@ -2212,6 +2213,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 	btrfs_put_bioc(bioc);
 	if (!rbio) {
 		ret = -ENOMEM;
+		bio_put(bio);
 		btrfs_bio_counter_dec(fs_info);
 		goto out;
 	}
-- 
2.34.1


