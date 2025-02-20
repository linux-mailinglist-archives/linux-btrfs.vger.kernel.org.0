Return-Path: <linux-btrfs+bounces-11656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19969A3D7BB
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 12:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6609C189C494
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F801F4720;
	Thu, 20 Feb 2025 11:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mViNmrGQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43B1F4639
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049509; cv=none; b=la5qxfd8EjsKXx05L3AGHdPOXctlnj4YLNMxWgcfaUaTdDiDo4kurZ6S7jFjoV93IqV+y5ksZK1CeDUPeJcEr9i1Q2f8gkeT8847ek4KOKhA/4Cir7Xqu5oPH7waVEG8nudNprVKCW7kWNUyE2bxWTatzvadl2nBn730F8HdSiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049509; c=relaxed/simple;
	bh=RzCBeOeEYPp3KthUnzogTIy1HdaiyHqUReO3IYXsSj4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hib4pDOBto/P+mdaJEKxriEN984tLt1IV6Ndx4f72XmG4mkniOqxPeKLb9LhEUC0aN2gwlYdvHOOd+32ekXrCjRB35yu8fese3Y6jjLs9DKlI2YPKATpWABMQomK4FwuJDdEyHf9CGt7/7c0SYRmInKU3e0CN4xVHE5uzDODXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mViNmrGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB00C4CEDD
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 11:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049509;
	bh=RzCBeOeEYPp3KthUnzogTIy1HdaiyHqUReO3IYXsSj4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mViNmrGQfUlkvtFvx1ZWO5J0gyJjTTKidt1aG1Zv8LCPaQ4vaq1+7syIy1Ud1yghU
	 BrPwzCQYyO2nfpjSimgv3njFTT6w94a5Jdl81qF0i20f+juTJ1dFZuNJYbxhRTsM4z
	 pMjZ6j3UOjUrkqXXLxjFf9vLFKdBfaOtI7w67wmcbIQQwt9dvQ8WF6iy5LT/+im3O5
	 OCmkQ24rXhhrEziy6SdiYsq9bgVb5XV5EJuoyP1F+b+5+VWRCaKGZnaoTSl0/n8BJB
	 IkD3/mVh+J9c65x+8A/A7g4LbhllEPsxnVy/IkKYj99EqnmU4dyGbHu8hLYYU3rj3E
	 f0LgJxJ6A7UoA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 21/30] btrfs: send: remove unnecessary return variable from process_new_xattr()
Date: Thu, 20 Feb 2025 11:04:34 +0000
Message-Id: <a2e5779fe9251a6dca651eef190c76e4024c7a01.1740049233.git.fdmanana@suse.com>
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

There's no need for the 'ret' variable, we can just return directly the
result of the call to iterate_dir_item().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 01b8b570d6ed..e29b5a5ccdd6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4950,12 +4950,8 @@ static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
 
 static int process_new_xattr(struct send_ctx *sctx)
 {
-	int ret = 0;
-
-	ret = iterate_dir_item(sctx->send_root, sctx->left_path,
-			       __process_new_xattr, sctx);
-
-	return ret;
+	return iterate_dir_item(sctx->send_root, sctx->left_path,
+				__process_new_xattr, sctx);
 }
 
 static int process_deleted_xattr(struct send_ctx *sctx)
-- 
2.45.2


