Return-Path: <linux-btrfs+bounces-10474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDDE9F4AC9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955F41892417
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 12:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F861F1900;
	Tue, 17 Dec 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imBPzRQu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2081F12FA
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734437668; cv=none; b=ACWZDWucXYn1d5qHBzISOzVevu9Up5qeLf2mxtp+VHQb4DBLsg2YQ+jLF6E8JrW3SU88P6+2c6rfWkm51kmi8lJvmQtX8KGGfXNnkGh8S756LXwQ6sgJ7seBZQOa/0rrNGKm31rY7th0KYQbKajNOeGiUXK0Ri2xFlA5JGTd9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734437668; c=relaxed/simple;
	bh=lUuw/Qf1IGXLIonoV/2xLfWdoecOAiXIif6OLrdQB8Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FFh96Utk1Hakhj1Mljy7a0bMnFn0YzObEBk60SW71g2qEtAQl5YJCkMNfZrQkxjJES7MhM7IQ6y+GU3j27LIZOTZxGdIRgMoVDbMPgZDcpWRH7sHT+CHJOZRG91Sd70+IET8cgzdE8xBqNbqijy/NgsYgIZJmPv+l++osIxBXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imBPzRQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD6C4CED3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 12:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734437665;
	bh=lUuw/Qf1IGXLIonoV/2xLfWdoecOAiXIif6OLrdQB8Q=;
	h=From:To:Subject:Date:From;
	b=imBPzRQuA1g/pFgI26EdbqchfU618fZ3+CCtexJg1kSWHfYa82RnlJMXsjZQVIWHJ
	 9hDF/0z+Qil/jhZVnQIR1jVx5D1fZhYmMcbfqZWVdopkGOj6wYW2RAd7N7qnHo7+8f
	 9MoYmmeqHCDH1xMAbXvef3apH+iGrwR4lQ1fAkaAsmhD9tA3ligVD9V32P4Vtv4ALA
	 gLb90UImN/dp7EUNQoRjAwTuURTBzhenpA+5iXH8LfzlKybgxZuO0sCN9sI5LDonJT
	 pTIoS6sQOoxZZIwSbaVfxtoOIT+6ucNssAoGhNA2rzlUVW6lZdkyysDtpQMySE0yte
	 pomppn7tCT+KA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use uuid_is_null() to verify if an uuid is empty
Date: Tue, 17 Dec 2024 12:14:22 +0000
Message-Id: <60c0e07d871249ed86b53087c75a1013233da355.1734437595.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_is_empty_uuid() we have our custom code to check if an uuid is
empty, however there a kernel uuid library that has a function named
uuid_is_null() which does the same and probably more efficient.

So change btrfs_is_empty_uuid() to use uuid_is_null(), which is almost
a directy replacement, it just wraps the necessary casting since our
uuid types are u8 arrays while the uuid kernel library uses the uuid_t
type, which is just a typedef of an u8 array of 16 elements as well.

Also since the function is now to trivial, make it a static inline
function in fs.h.

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/fs.c | 9 ---------
 fs/btrfs/fs.h | 5 ++++-
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 06a863252a85..09cfb43580cb 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -55,15 +55,6 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 	return ARRAY_SIZE(btrfs_csums);
 }
 
-bool __pure btrfs_is_empty_uuid(const u8 *uuid)
-{
-	for (int i = 0; i < BTRFS_UUID_SIZE; i++) {
-		if (uuid[i] != 0)
-			return false;
-	}
-	return true;
-}
-
 /*
  * Start exclusive operation @type, return true on success.
  */
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 1113646374f3..58e6b4b953f1 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -996,7 +996,10 @@ const char *btrfs_super_csum_name(u16 csum_type);
 const char *btrfs_super_csum_driver(u16 csum_type);
 size_t __attribute_const__ btrfs_get_num_csums(void);
 
-bool __pure btrfs_is_empty_uuid(const u8 *uuid);
+static inline bool btrfs_is_empty_uuid(const u8 *uuid)
+{
+	return uuid_is_null((const uuid_t *)uuid);
+}
 
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
-- 
2.45.2


