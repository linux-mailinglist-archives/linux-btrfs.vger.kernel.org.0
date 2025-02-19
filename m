Return-Path: <linux-btrfs+bounces-11586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D15A3BD5B
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 12:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9178C3B88DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 11:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA551EB5FD;
	Wed, 19 Feb 2025 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VykFhWZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B781EB5D5
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965432; cv=none; b=UHcEcS2F9p2Av8IpqV/77rauuZR0juFthguiAFZRojlqRgZrNE+1bqV3qZ99pBOprxmijX7AMuBmcF8TfxfzsG7K+RlaOzI8rlk4DZXULp00x52SNp9bQSkmLpJltB1b0I22CsEVnMg6nODcAoAgdAv3JP5F4GVjW81xo8naXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965432; c=relaxed/simple;
	bh=RzCBeOeEYPp3KthUnzogTIy1HdaiyHqUReO3IYXsSj4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nqGjyn05I0xJe/wRgofTmJvLvPwh2g5C3SSIo6pbZDBIa6vz8p+mY+mud0VqQO6AWz9CuUaT8I5tGU+dq6YUz58148h3drrLX1pV+f4bcse7MzbspKmhfTZqDI1mIMPJFHtGOu9fQlMYwzP+PYQmnKTzC+qDAbQj6gcM5HmKuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VykFhWZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4098EC4CEE6
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965431;
	bh=RzCBeOeEYPp3KthUnzogTIy1HdaiyHqUReO3IYXsSj4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VykFhWZAWMdAUJ/hhh0Rx4TaLSpYVOV8rGdkbrUWR8ajfdZ4uin4CdVRBeVxwpEkW
	 Oh065aP75Rs3S3GTtq2wLetcROapmilFan8BlbPP660QUFxMUsocb84+Rw7oCaJqDh
	 Co5Sj9KltL684KdE/g7rRwu+vhetAQOkqtF95jzU4c1EAL3+mjXvj3/5NSxQAYO5X/
	 ld+f1DWUgwQy0iygWADuNSYxzyIrzN3+K4bxi5shiI0zqP8WQka9OLNmo4tWhNenAc
	 2wE6JlrmXjIPID6vNU3O4aqxfllhtzO0a3ho0tHoWOHsCxfee5rUPjkrrU47rPkX++
	 zel0mlEBou08g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 21/26] btrfs: send: remove unnecessary return variable from process_new_xattr()
Date: Wed, 19 Feb 2025 11:43:21 +0000
Message-Id: <509d20faf13eaa4b44ec44c9402c56cbc54c3338.1739965104.git.fdmanana@suse.com>
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


