Return-Path: <linux-btrfs+bounces-9365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 816CA9BEE25
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 14:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E471C24589
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE571F4FC3;
	Wed,  6 Nov 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu7rro2c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0CB1F4710
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898837; cv=none; b=h/IQzmuYzcFlsE6S8h2iBNxLml0CiIJCiaVb68G07VXSVnCGmadiac7HcCjdLgtNr0RMWhBPdfAxOZ4lEKx1M9eDKrafa1hjywdCKg7Si3UKJUznS/+Q3jq7+kTapidqWvzCivd+plcVjt6w1u+NbL55zx6P5StT4Jw5+IJj3NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898837; c=relaxed/simple;
	bh=IrStZK8Kn9I29+0ZowiBLsy8nCluZHuwsdkodKyQzxE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=REy8cWPgufz3kmNTrsSYhfpjQ0cu0ti1tSQgKIqyLytuQ13emozy6BnQ5eeNrRpndWbZkNNlgbfUGrNW9e3jDEoA/913rSIxlm/M9AmkoCIXweatZjAWAo/bS34Ta1FmX3NdBF/sQ4P+nvO9Q1Sux3XX8MLcBKmmXCnwxmd/A9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu7rro2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83669C4CED3
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 13:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730898837;
	bh=IrStZK8Kn9I29+0ZowiBLsy8nCluZHuwsdkodKyQzxE=;
	h=From:To:Subject:Date:From;
	b=eu7rro2c0G2wQfpH+jH0DQapZpIQczFgJXReg3DefDtEGuovPDhv0tJoYJAiXgPJu
	 uWvTJuD/zibLBLkaiflguHbfrtPs5oxXJSjjn9aaaaov41HCMm0JY9VDH/7YKQ6Y1r
	 +1n1ZIl0LvMgvgrhCTw20GUb8/+NYmeGqY9Bl18jocZVgE9o7rOleia60vhfGVndEQ
	 lqeq9O9jC5WQ+JsGFrvkl/3TOWb3ESSLUB6zzdFG+0KzyY43KVfF1smxp0pJF4A74L
	 jw2q9eWZOfRHKPA3apVKR9O73BS2fvNK0bYPfjKfuXgH3tNQDiwcEEWTjzcd+WwwNu
	 jHzmalmSqmr8g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove check for NULL fs_info at btrfs_folio_end_lock_bitmap()
Date: Wed,  6 Nov 2024 13:13:53 +0000
Message-Id: <9e430348860c37c68f7db326df933c0d3ae8bcc0.1730898720.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Smatch complains about possibly dereferecing a NULL fs_info at
btrfs_folio_end_lock_bitmap():

  fs/btrfs/subpage.c:332 btrfs_folio_end_lock_bitmap() warn: variable dereferenced before check 'fs_info' (see line 326)

because we access fs_info to set the 'start_bit' variable before doing the
check for a NULL fs_info.

However fs_info is never NULL, since in the only caller of
btrfs_folio_end_lock_bitmap() is extent_writepage(), where we have an
inode which always as a non-NULL fs_info.

So remove the check for a NULL fs_info at btrfs_folio_end_lock_bitmap().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/subpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d4cab3c55742..8c68059ac1b0 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -329,7 +329,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	int cleared = 0;
 	int bit;
 
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
 		folio_unlock(folio);
 		return;
 	}
-- 
2.45.2


