Return-Path: <linux-btrfs+bounces-11652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4FA3D7B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33C219C21A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD04F1F428F;
	Thu, 20 Feb 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP3lGC4j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323DA1F419E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049505; cv=none; b=PdZSKuROJakolo5JEl4C3cBuyTJi21Ii2Kmu9p8Gy5pZp501hlEgwOwBfVwQblJjDA6kXN9gLMPRot5i/gNv+KjZmWTHILGgQNS1fV1puFNRhQlUeEjKt9AFM3/MBZ6+GQ5AR7FRtKMDrwAN78HqHDjmGUNCgmnWQgA9CZSTpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049505; c=relaxed/simple;
	bh=1JCUCDDhbrBpj9klUlZfnrC0vS8NJuYV+O9hY/74lBc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZsY89OUWBLPyxsVP2o+TcvR4T/5eHHZp4vOT8LHBiaulbn9wzq2ivL8wm5EsMRWhpstRzzl75+dnA/sADn3TCu9+l1O5b6wUS1bTrWO3+iyDdJYrrH1nfHrQAsdsL4GDvBXuWCkVpChbnv2JQoRrSqQgQVJD4FhR5zI2ynMNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP3lGC4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84107C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049505;
	bh=1JCUCDDhbrBpj9klUlZfnrC0vS8NJuYV+O9hY/74lBc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UP3lGC4jaCwBs1NADhADp0e+bB1PcJH88z+YGGg3Bs+uBziaJ84RPF0rOyq2yJH9q
	 CQZJh4CVKjQ58PQAMS3oVdF0WiXeNNrV0K31nL22W7W02nexM1GZGgCIFAMrSTeVF1
	 d0inUQ8gwz1lWhedY76RLt3LKbGXpxP7k7R4A3VIdTnfuZ9LLDZVGaBS8vcE22ZFDK
	 mI5cddu1/11cxctrI5batMU9gO0uH1iDYxZBf9FTLvDjZmDCGcYc1JQkvfI/09o6if
	 SSyV20OA04sF+m8GGdqe7/lV8BsiD1f1xAglq/6OATrPW3zVPcWiX7xAg93fq/v1dM
	 8ED/nWi5b532w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 17/30] btrfs: send: simplify return logic from record_deleted_ref_if_needed()
Date: Thu, 20 Feb 2025 11:04:30 +0000
Message-Id: <cfca5db87818ffe04a681cfc58196ca80438f8b8.1740049233.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1740049233.git.fdmanana@suse.com>
References: <cover.1740049233.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There is no need to have an 'out' label and jump into it since there are
no resource cleanups to perform (release locks, free memory, etc), so
make this simpler by removing the label and goto and instead return
directly.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 96aa519e791a..b715557ec720 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4712,7 +4712,7 @@ static int record_new_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 
 static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx)
 {
-	int ret = 0;
+	int ret;
 	struct send_ctx *sctx = ctx;
 	struct rb_node *node = NULL;
 	struct recorded_ref data;
@@ -4721,7 +4721,7 @@ static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx
 
 	ret = get_inode_gen(sctx->parent_root, dir, &dir_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	data.dir = dir;
 	data.dir_gen = dir_gen;
@@ -4735,7 +4735,7 @@ static int record_deleted_ref_if_needed(u64 dir, struct fs_path *name, void *ctx
 					 &sctx->deleted_refs, name, dir,
 					 dir_gen, sctx);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.45.2


