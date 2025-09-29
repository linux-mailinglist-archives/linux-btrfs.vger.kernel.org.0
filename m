Return-Path: <linux-btrfs+bounces-17243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACDBA8353
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F72E3B8646
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 06:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050782C0260;
	Mon, 29 Sep 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIi98i5n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29DA2BEFF2
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 06:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129120; cv=none; b=a5Zw88VEY6/GsV9SRSR2tGtSvxoWEzyCLYBhRiraIm1xKC6ddv+VFSHXpWk53fEFkEqzfkxAS6eMNa5YoFDpoOJjmoV9Oh1WWWJCfUnrc+zol8aHO/iCBcs0G7ah+hDRwHHacqaS4/eSKuxp4+HUZRj4ShSvwDzwlcOGQpN19WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129120; c=relaxed/simple;
	bh=1YyPvFlM7cxtemjgV2sg8RYAqZGHgbxgshvxt1HliTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm/H+j2cw6JC9q89iSi++AnHKi1AQe93rXq6LkdHPNQ6uWHQSfOjywanmcK3Lj1AopHmqgJoVLBAnr9UTFd+gyCwZDdKEBp53nW4rsHO5OeEEnJe0m+GdzdVlhvL1AZU32DdgdoxdkrhamcQeEqdjdEDfaZy+6x6y6GgAwHyjmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIi98i5n; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-26987b80720so6488995ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Sep 2025 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129118; x=1759733918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0LZz1AOFT7lK43T/6l4pD1Cuyq1iTgtBDGLj84UZW4=;
        b=UIi98i5nSrFCO+Or1y8EVGJl/RUs7ifRYSO7Wt9mwEdyFFAMh0AW56BkLdD7vk8oBI
         tFvIfSHy8jZmZyprh3R34Lxm2Anu561xrSGmMkb5yDEp1SP16czAJNZFuPl1PEcZIW82
         NXlX9BXBEkwIZV6KYf1ShU3yWNItKN6UpmHPb21uy6PcaD+U8X9/0lQxgx+Fh2zIsU8o
         4bbxv+Dv27EeeJmTofZZz/iPFH1TTczAd+ZhZn7Fk+M/ULY+F6E68l0ziXnjMhMWPzLF
         Td1yHz2hTugJa+w7kJe3WCIVhIqxy3eW3lQsDwA5VnhX6TZpQtkXJTqFk2CIVWwG+1p0
         gpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129118; x=1759733918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0LZz1AOFT7lK43T/6l4pD1Cuyq1iTgtBDGLj84UZW4=;
        b=dCbc9OiDrrUuLaD8UtjzZvnPpGssL+8XTwHKrsOY44GPsJGwkgC1q73ImxAtYc+d47
         gla8QYOOWdOGPOwPkTVt4FJoTx4aslbdnT8UxVJJcrxS2IDNaopaqjKoDcwFsthn6fBi
         ePlkXJ9AZDtuKxyV0m4HvNwCdi21qtW66iIw87xyWkC2ZPDNUSkS8CDx3NFeQ1goa7r1
         LuaPEwhLUfQPSXZgKb34bA9rWaMHCajPLVwMLo9dZLbVFFujljAI92o8vY//Z3H2ti42
         eW46eP43t1ytORnXVeh56RaXtXZt9IHi2kKH7rOwh5a9ZoJWULs9KBzHDUO0UZCMDKzf
         V0IA==
X-Gm-Message-State: AOJu0YyIN7cdhceK4O7HfOrVGMVEV3aLXgXsS/6j87PmfPI/eGt8qU/a
	fUMiUVaK3/E5453lFvTmyhYilnga9CbrtYm3qhgmfyhr7eihX5fh4L9nXwNjJnUNBlBPDw==
X-Gm-Gg: ASbGnctWdGChxp0u0Gs8M9DEfojRXYeAJgg+XxNX2P9BKs5GxwaWpEOmmSElmwgvBKi
	oO44j05pxoZDlog7mvQSq2+lHGKRFMtu4U8FnPPa9Ij2mCK2GCOGNS/x7byyaMN+jNodD4VSY2g
	t9Qs3+uwjt7WZt/RGwvkw2nBVK/UULiT2KHDRRfXUnTOD2/OGnXTxCVrPEkzDtjTzwTBl0TILWw
	TmWMWY937hIztQlBzkRGuDqdH4SwXg+SFHQPpZVsZTsnxuxjksoLmVgBDR4mfOssZ/j1AzDfq0i
	JwuJzo/NABKk8FrmdE3UL7zDppC8XL9GnmIxQm1/Yq/ICVFYj7SxIS83iav6miSc50y+KQd9vWV
	aMTQfi5JJkmLxQwKsK1Pg/nJlQLdwhBwv
X-Google-Smtp-Source: AGHT+IGq9pQ5kfyBVNJ+Zv/QXinzkwyXa9cwmtio1BSHuxU2MjQLRmhqRJVQhdVzXi/ZQItRo0oe6A==
X-Received: by 2002:a17:902:f551:b0:267:bd8d:1b6 with SMTP id d9443c01a7336-27ed4a2e4b5mr102767045ad.6.1759129118007;
        Sun, 28 Sep 2025 23:58:38 -0700 (PDT)
Received: from SaltyKitkat ([152.69.226.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821d3sm121440955ad.83.2025.09.28.23.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 23:58:37 -0700 (PDT)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
Date: Mon, 29 Sep 2025 14:56:29 +0800
Message-ID: <20250929065802.2748-1-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure the error handling flow in btrfs_tree_mod_log_insert_key
to address memory allocation failures more cleanly.

No functional changes are made - this is purely a code readability
improvement.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/tree-mod-log.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
index 9e8cb3b7c064..4fd7859ad7dc 100644
--- a/fs/btrfs/tree-mod-log.c
+++ b/fs/btrfs/tree-mod-log.c
@@ -267,9 +267,8 @@ int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 	if (!tree_mod_need_log(eb->fs_info, eb))
 		return 0;
 
+	/* Allocation error is handled later. */
 	tm = alloc_tree_mod_elem(eb, slot, op);
-	if (!tm)
-		ret = -ENOMEM;
 
 	if (tree_mod_dont_log(eb->fs_info, eb)) {
 		kfree(tm);
@@ -278,16 +277,14 @@ int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
 		 * need to log.
 		 */
 		return 0;
-	} else if (ret != 0) {
-		/*
-		 * We previously failed to allocate memory and we need to log,
-		 * so we have to fail.
-		 */
-		goto out_unlock;
 	}
 
-	ret = tree_mod_log_insert(eb->fs_info, tm);
-out_unlock:
+	/* Deal with allocation error. */
+	if (tm)
+		ret = tree_mod_log_insert(eb->fs_info, tm);
+	else
+		ret = -ENOMEM;
+
 	write_unlock(&eb->fs_info->tree_mod_log_lock);
 	if (ret)
 		kfree(tm);
-- 
2.51.0


