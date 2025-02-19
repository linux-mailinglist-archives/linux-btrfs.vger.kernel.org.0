Return-Path: <linux-btrfs+bounces-11585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515DA3BD44
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E307A0202
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DAB1EB5D7;
	Wed, 19 Feb 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCrdRj+x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460631E0E01
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965431; cv=none; b=aqWlU8goGmlf1yOhuLVzzwYbioR5HiRR/ggW/XxKbrk+O9TXWngYbiBSdEcrPTtwTwAP8njCuJcW4R4+HCzWw2gdxUL7v16xjQFlVrJZ0z2d2qcVB9b2DnLP832QnK9TCJwrIabeIWRuZFb1flXY9LPa6WxMS4o6z9rPVlBtbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965431; c=relaxed/simple;
	bh=wXsAxsgamsNQG+m9lr5ppecgeBVTHoTlfPbVpx8Orsc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9Yl2KxtJMuvwp5yo5XSi5LtBKqpGcIu1sYxsW7l89DwqOxNfH7Evj1VAAQAAWhpttCM7ALBpkOF2qS0AAg+uSnQt5PurABRL6Wm6rH6RdOPHw6EAA5FdZfctvRE1CkuywWwehkoTwgt7q0lSwbGxB2g6jvWOpio3R2hVsEqUdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCrdRj+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B041C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965430;
	bh=wXsAxsgamsNQG+m9lr5ppecgeBVTHoTlfPbVpx8Orsc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TCrdRj+xBa9F5QXpJHgcJie+J7r4D/5aio8qCY4j+UPY1KEZVc559/lC3gBjfL2uU
	 nteWf+rHadbfdIahjL1nh5T8qBPvhLGLeYcaAme0nqYr1siwPo2I/hfHRTKqQooLjc
	 all5thIZTG+6wVEifx52be/pupWlFWQ0qks8KQB/8jUDFZJqYZumW/yOtxJnaig5vq
	 Nf4f/5GeHq9L30e74J0eAadT04gIZhWOSVMxRBMO+XR6OeXpl3h0JMWOVME3JJTWmS
	 ivKWQ//UlVV52TefmLbtYI936B1rL1MMGkOfO2nD5Si5DapblRO9XDoWiGrqdeFZaI
	 dW2x6mpWsTudg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 20/26] btrfs: send: simplify return logic from record_changed_ref()
Date: Wed, 19 Feb 2025 11:43:20 +0000
Message-Id: <d2dde977de890942ca392cb047d28c23fee34b80.1739965104.git.fdmanana@suse.com>
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
 fs/btrfs/send.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6e171b504415..01b8b570d6ed 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4766,20 +4766,18 @@ static int record_deleted_ref(struct send_ctx *sctx)
 
 static int record_changed_ref(struct send_ctx *sctx)
 {
-	int ret = 0;
+	int ret;
 
 	ret = iterate_inode_ref(sctx->send_root, sctx->left_path,
 			sctx->cmp_key, 0, record_new_ref_if_needed, sctx);
 	if (ret < 0)
-		goto out;
+		return ret;
 	ret = iterate_inode_ref(sctx->parent_root, sctx->right_path,
 			sctx->cmp_key, 0, record_deleted_ref_if_needed, sctx);
 	if (ret < 0)
-		goto out;
-	ret = 0;
+		return ret;
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.45.2


