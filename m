Return-Path: <linux-btrfs+bounces-11584-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE70A3BD4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A43173EBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8881EB1BD;
	Wed, 19 Feb 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhKxwEML"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E71EB1B9
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965429; cv=none; b=bmDliS2EjEBfzQvnuxnYk/JDpMb/nm5lWNOSsOyaNg9TsNIuHPNRTq6wOsvS0AMgUDYlY3GKqPUzvaNDGFqKFG5+lcIgkgeNNjpi0+I7pLkEAJFboj5bhZo3dTs48rzfdFz0dQ5IlHGPlHsIx/9j/eEK+A+fA5WFDj4XBc1ztc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965429; c=relaxed/simple;
	bh=bo65LBflfD+3mpw0tdqCeliFgx2TqnU6QVvpvc7mI6U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSo9WLZLuRw26TQWFdrmEolmEVtfzxo1u4YFnnrUwCLvu0kLLaotlhYki45O1i/NFEHeJ6dj+8WF6cfaEMVwPfkfN9SDRWM+4WfNxoEUht+7gVI5ClIxSYse08xOg7BMKkyOCLwd0NV61UHua9eHSmZChSTSS7/dk0t6Glp53zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhKxwEML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3665AC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965429;
	bh=bo65LBflfD+3mpw0tdqCeliFgx2TqnU6QVvpvc7mI6U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=PhKxwEMLyhukAW2kXno4cuiXMMgT47L/e8ocPJDA2t0/3nFukTPytMOJK36eCYOrW
	 q8cXTvD3e6rcW58x0y0ikdUucPNp1gAE+fRn5PBHvy0Wm01b/3O6xAdr7wGg6sC648
	 1y4HEICgeReG827WcI8T1Zrbhaqa5KVokKe3HV69wS5LDIvecvfRaj/gkl5KPyyo6x
	 2bDeFkVbDCsLEKtnPS8JcKW/uDbV88vJJugE4dJXd6M+Mdox4pgYqDjTdZ/EoNVCyf
	 YoRuSuvSKRdJ8VxkWHR2X0l6kT7KLoYIo08P35rumiTmdfu8rir7arcXYBK2DQbHXH
	 +5RAa8Mpt8CcQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 19/26] btrfs: send: simplify return logic from record_deleted_ref()
Date: Wed, 19 Feb 2025 11:43:19 +0000
Message-Id: <1cc622c733eb7cc5dc54e640cc685a2998c596a9.1739965104.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739965104.git.fdmanana@suse.com>
References: <cover.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 181a234e3a5e..6e171b504415 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4759,11 +4759,9 @@ static int record_deleted_ref(struct send_ctx *sctx)
 				sctx->cmp_key, 0, record_deleted_ref_if_needed,
 				sctx);
 	if (ret < 0)
-		goto out;
-	ret = 0;
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 static int record_changed_ref(struct send_ctx *sctx)
-- 
2.45.2


