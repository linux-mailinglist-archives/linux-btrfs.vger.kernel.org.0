Return-Path: <linux-btrfs+bounces-11580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B09A3BD4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6181759E7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B81EB199;
	Wed, 19 Feb 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzN+JUwn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79031E0DDC
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965425; cv=none; b=nvBChfOv1hRjg0fbRb5hH2WKK2WDLNnn4wXmzl+6FdHDPi4Rs1PnU+L3AlV0+w+Qf9NtGqHmLkeuOCI9p6iau31uZBrm2dyQ8X3sqvxGZqFJK+fk1jZ8tIH2qoFdtq4e5+w4yZkI0j+yeoBZE9dp0HQPr76c2zivzELNQUogJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965425; c=relaxed/simple;
	bh=8ihYbfEmW/bqLw/MsLra7UmB8oJ2hM1pKiPbv9n1Dqo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HeTz1P8YeBgXA8DJqJMyrmPwto0yqujc+JP3S9usA1lfoMnu7IQiw37ct6FhjUIVeFBUDdZWvapA9Sow2dXU7worPCBAhl1JKvMQAPkzMeG5wKGSrLWNYK3zMao20wVrAUPW+4bAFCTcJwUtDpElTGqJucTG9fW100ENnVjz1YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzN+JUwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D3C4CED1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965425;
	bh=8ihYbfEmW/bqLw/MsLra7UmB8oJ2hM1pKiPbv9n1Dqo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nzN+JUwnjcjIUTBr8PkOmzdJEPkAjdowkUsCPvNe5D4DdSGoQ8YLG+Z4wfnecL1cE
	 C1eTDfB2evurK88gCH6JOpgmebkIv5wI2CKVmWaWbbjOPuiBsGNrz8hL1fZ3IqyTz0
	 qvJnvIrKH7v4eBA7zB70CRPi/FxDMcofYnFh+a+uTwmB7G6XrU9pza1efVB5cINIQA
	 /udGIsk85VikguOdo6si8dJMkme9xoe+8JiUSiKxCS1Z3J/6N5gRe77d+sdEs2xtOj
	 pK9GY5EkhVkJkNfp0IS0jaA3hspBTtFxiwg+XNaeD9UnjTSZJ2eozd9r9jWDMYVHya
	 feAWUMCh/ePYA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 15/26] btrfs: send: simplify return logic from send_remove_xattr()
Date: Wed, 19 Feb 2025 11:43:15 +0000
Message-Id: <89a2e7cee7204f953742097d60dbf1fa61fdc038.1739965104.git.fdmanana@suse.com>
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

There's no need for the 'out' label as there are no resources to cleanup
in case of an error and we can directly return if begin_cmd() fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 653e0b9a94ca..5fd3deaf14d6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4886,11 +4886,11 @@ static int send_remove_xattr(struct send_ctx *sctx,
 			  struct fs_path *path,
 			  const char *name, int name_len)
 {
-	int ret = 0;
+	int ret;
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_REMOVE_XATTR);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
 	TLV_PUT_STRING(sctx, BTRFS_SEND_A_XATTR_NAME, name, name_len);
@@ -4898,7 +4898,6 @@ static int send_remove_xattr(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
 	return ret;
 }
 
-- 
2.45.2


