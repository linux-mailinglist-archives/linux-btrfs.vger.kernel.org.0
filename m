Return-Path: <linux-btrfs+bounces-17125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3395B96AC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E1718918D2
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCED26D4C7;
	Tue, 23 Sep 2025 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b="vG4CPnYT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.burntcomma.com (mail2.burntcomma.com [217.169.27.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80761269AFB
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.169.27.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642936; cv=none; b=AsVyxgjnA5pHY5AzCNuvXA54s0uOfUlJ5+qsVtQ57tRmBdensCKXw+sdBJK2AQp2VcyzK9up8j0bFb+c4iwJ0k5NFRsxvgzlg+x1x8zxCU1mRitU/lw3mSTF24Cuaxmo0/7dLtkO+BvPv642I+qgETBELJO/k1ecytbbVdEIcXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642936; c=relaxed/simple;
	bh=bz2GTL1EpNJegWFZ3lEetfGyCbUxqQiwQZT4uHwbR2A=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version; b=Y35lhK30rJRqUxVuZ6BPGjdn4F4ie9ZF58RxuX+W1v40/4xphiZEfRdhuHcJWvGHJpxYeqPdjzQ9pWRNA9O+JPvUnSYOGhOiIonOZjjjJkWeZ074mh9kV7ImJ2eqP9YhStKAx7cwAtgPtHgwB4LENn3s+Mp2MNLFRaqmLY9wnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com; spf=pass smtp.mailfrom=harmstone.com; dkim=pass (1024-bit key) header.d=harmstone.com header.i=@harmstone.com header.b=vG4CPnYT; arc=none smtp.client-ip=217.169.27.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=harmstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harmstone.com
Received: from localhost.localdomain (beren.burntcomma.com [IPv6:2a02:8012:8cf0:0:ce28:aaff:fe0d:6db2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.burntcomma.com (Postfix) with ESMTPSA id B4F0D2BB9FF;
	Tue, 23 Sep 2025 16:55:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harmstone.com;
	s=mail; t=1758642924;
	bh=aPB7hOCWv0lv2il+ad6umtGZ6ye3uZ1huK1ulTjSwWk=;
	h=From:To:Cc:Subject:Date;
	b=vG4CPnYTL6q3LmG+UWjqgxWO6MP/qBXtj/xE0VCDtNXpLLM4gmP83JgrkCqcNl4Ey
	 hCX6fxRR/QrPQ4eSu1XQLJhcEui4gUfvP7GoC858WqOXrT0nvn8UmWq5k/OacCDd8D
	 EQVMLGiqdl139sPutzNf9xYy83qsokGiZTIbBOJE=
From: Mark Harmstone <mark@harmstone.com>
To: linux-btrfs@vger.kernel.org,
	fdmanana@kernel.org
Cc: Mark Harmstone <mark@harmstone.com>
Subject: [PATCH 1/2] btrfs: add compat flag functions
Date: Tue, 23 Sep 2025 16:54:55 +0100
Message-ID: <20250923155523.31617-1-mark@harmstone.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

struct btrfs_super_block contains a field compat_flags that has never
been used, intended for informational flags that don't prevent a
filesystem from being mounted read-write if the kernel doesn't
understand them.

Add the support functions needed for these, following the pattern of
compat_ro_flags and incompat_flags.

Signed-off-by: Mark Harmstone <mark@harmstone.com>
---
 fs/btrfs/fs.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h | 13 +++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index feb0a2faa837..1d7293a575cf 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -273,3 +273,49 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
+
+void __btrfs_set_fs_compat(struct btrfs_fs_info *fs_info, u64 flag,
+			   const char *name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_compat_flags(disk_super);
+	if (!(features & flag)) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_compat_flags(disk_super);
+		if (!(features & flag)) {
+			features |= flag;
+			btrfs_set_super_compat_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"setting compat feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
+	}
+}
+
+void __btrfs_clear_fs_compat(struct btrfs_fs_info *fs_info, u64 flag,
+			     const char *name)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+
+	disk_super = fs_info->super_copy;
+	features = btrfs_super_compat_flags(disk_super);
+	if (features & flag) {
+		spin_lock(&fs_info->super_lock);
+		features = btrfs_super_compat_flags(disk_super);
+		if (features & flag) {
+			features &= ~flag;
+			btrfs_set_super_compat_flags(disk_super, features);
+			btrfs_info(fs_info,
+				"clearing compat feature flag for %s (0x%llx)",
+				name, flag);
+		}
+		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
+	}
+}
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 814bbc9417d2..3a8b4aba12d2 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1053,6 +1053,10 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 			      const char *name);
 void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				const char *name);
+void __btrfs_set_fs_compat(struct btrfs_fs_info *fs_info, u64 flag,
+			   const char *name);
+void __btrfs_clear_fs_compat(struct btrfs_fs_info *fs_info, u64 flag,
+			     const char *name);
 
 #define __btrfs_fs_incompat(fs_info, flags)				\
 	(!!(btrfs_super_incompat_flags((fs_info)->super_copy) & (flags)))
@@ -1060,6 +1064,9 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define __btrfs_fs_compat_ro(fs_info, flags)				\
 	(!!(btrfs_super_compat_ro_flags((fs_info)->super_copy) & (flags)))
 
+#define __btrfs_fs_compat(fs_info, flags)				\
+	(!!(btrfs_super_compat_flags((fs_info)->super_copy) & (flags)))
+
 #define btrfs_set_fs_incompat(__fs_info, opt)				\
 	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, #opt)
 
@@ -1078,6 +1085,12 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 #define btrfs_fs_compat_ro(fs_info, opt)				\
 	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
 
+#define btrfs_fs_compat(fs_info, opt)				\
+	__btrfs_fs_compat((fs_info), BTRFS_FEATURE_COMPAT_##opt)
+
+#define btrfs_set_fs_compat(__fs_info, opt)				\
+	__btrfs_set_fs_compat((__fs_info), BTRFS_FEATURE_COMPAT_##opt, #opt)
+
 #define btrfs_clear_opt(o, opt)		((o) &= ~BTRFS_MOUNT_##opt)
 #define btrfs_set_opt(o, opt)		((o) |= BTRFS_MOUNT_##opt)
 #define btrfs_raw_test_opt(o, opt)	((o) & BTRFS_MOUNT_##opt)
-- 
2.49.1


