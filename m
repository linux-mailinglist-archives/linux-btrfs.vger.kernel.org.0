Return-Path: <linux-btrfs+bounces-11575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA91A3BD4C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA44B3AEB20
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45251EA7C2;
	Wed, 19 Feb 2025 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPc6s+SO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DB81E98ED
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965421; cv=none; b=evYB8wMjqsqFpldOYoZpSXGZ8qAt7nhXJWtH1tUAy+GiwwflKi2/wOQwjkCsnNrk9YZZvXequFGLuT6dLwiQJ6TVlTu352EQW4wX558F1F1kIQ9S3YZYt9RMOhDrmV4gNhTIF1lwPBJTtoalcwe0qcjvKODsew9yhdshZ4BooT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965421; c=relaxed/simple;
	bh=wU+8lAGav3ycWmUOUtxDG0zPsFe5lhgvAzLDXJIHe+M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k02QSaN43PxjTOW3SFA/yoA+r6q6JtSn6tFxfSkLDPFhjvRgjsW3enjyx6VqmxnDNPQnhwVIL6Y1TQ1Y1PufxTzr8veAn979DS78hWn9OifoVqMVvT8L9BHbQ7tuZXZvLnn8vu28F+Tpz4QKUxPJrdWtfJOUGB2maquV7kWEF2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPc6s+SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0762DC4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965420;
	bh=wU+8lAGav3ycWmUOUtxDG0zPsFe5lhgvAzLDXJIHe+M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QPc6s+SO16sZDrnB/Br79f+Q9kWBIwDnTYObbTVcaSJW5nl2HxwUf+feVEodrArA/
	 /0VtULesTqIWPsR8zF37psPqb9tyN0bNU3/pEUKeXdC6Ip+elkBhY02BQBT1EbkM+G
	 eTRTPh+9Ze36ysnfLBePr4N97+K9DsGBG1Zy64fGp1Y/6hjyqLkB/U2TJpdYFoQkJ9
	 S+lPgNW2K8pU6OB4H7hpKmUIsH7tjnv8X+qZAtT8OY1qwI1oYKEdfE7XxahyaLwP8V
	 Fva6JwmlO5Opjqd8dTIdisCjv8OrsVImfCPHJRI2RowqBIRCPSPmIF2vsll1/GgDOB
	 AGYQtOWg5uNTg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/26] btrfs: send: simplify return logic from is_inode_existent()
Date: Wed, 19 Feb 2025 11:43:10 +0000
Message-Id: <1dcd7cdbe1e547af8ae5e673346ded6cbf79e213.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 393c9ca5de90..0a908e1066a6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1950,17 +1950,14 @@ static int is_inode_existent(struct send_ctx *sctx, u64 ino, u64 gen,
 
 	ret = get_cur_inode_state(sctx, ino, gen, send_gen, parent_gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	if (ret == inode_state_no_change ||
 	    ret == inode_state_did_create ||
 	    ret == inode_state_will_delete)
-		ret = 1;
-	else
-		ret = 0;
+		return 1;
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.45.2


