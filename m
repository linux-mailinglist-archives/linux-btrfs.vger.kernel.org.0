Return-Path: <linux-btrfs+bounces-721-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E38078E8
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 20:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258E71C20AE9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E549F98;
	Wed,  6 Dec 2023 19:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="v6sgIjui"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A39FF1A5
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 11:52:27 -0800 (PST)
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id K7rM2B00T04l9eU017rNXc; Wed, 06 Dec 2023 19:51:22 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.cz>,
	Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/4] btrfs-progs: 'btrfs fi label' using a dev instead of a path
Date: Wed,  6 Dec 2023 20:32:45 +0100
Message-ID: <d8029a3418079187b092a0542deb1003e24a9355.1701891165.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701891165.git.kreijack@inwind.it>
References: <cover.1701891165.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1701892282; bh=82GUdcLPhIz1ZumbSN3IupfLpctMESRlxsmHK5zKNC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=v6sgIjuiW6FD1cILFzGVpoRYTDBCUMXliTkS3filhXIb0bnMWE5xFmFbAGYEaiWvb
	 7AD+dho0XKFQAjCHpxF3HSg4ycEeGmoP4yPdKXd0bkMIfA7M9QZQS/4Ond/FxB89bw
	 gG5Kq+6RKhq74ANhYiSm92i3Bo5hU9qTKBuPG/dg=

From: Goffredo Baroncelli <kreijack@inwind.it>

'btrfs fi label' has a strange behaviour: when the filesystem
is unmounted, it has to be invoked against a device.
When the filesystem is mounted, it has to be invoked against
a filesystem path.

Even tough it has a technical explanation, this may confuses
the users.

This patch allow to pass a device even in the latter cases.
Alternatevely, it is possible to pass a UUID=xxx or a
LABEL=zzz identification.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 common/filesystem-utils.c | 51 ++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 12 deletions(-)

diff --git a/common/filesystem-utils.c b/common/filesystem-utils.c
index 8c159365..655f4c72 100644
--- a/common/filesystem-utils.c
+++ b/common/filesystem-utils.c
@@ -29,6 +29,7 @@
 #include "common/messages.h"
 #include "common/open-utils.h"
 #include "common/path-utils.h"
+#include "common/btrfs-info.h"
 
 /*
  * For a given:
@@ -189,31 +190,57 @@ int get_label_mounted(const char *mount_path, char *labelp)
 	return 0;
 }
 
-int get_label(const char *btrfs_dev, char *label)
+int get_label(const char *path, char *label)
 {
 	int ret;
+	const struct btrfs_info *bi;
 
-	ret = path_is_reg_or_block_device(btrfs_dev);
-	if (!ret)
-		ret = get_label_mounted(btrfs_dev, label);
-	else if (ret > 0)
-		ret = get_label_unmounted(btrfs_dev, label);
+	ret = btrfs_info_find(path, &bi);
+	if (ret == -ENOENT) {
+		error("'%s' is not a btrfs filesystem", path);
+		return -ENOENT;
+	}
+	if (ret < 0) {
+		error("unable to access btrfs filesystem info");
+		return -EINVAL;
+	}
+
+	if (btrfs_info_is_mounted(bi)) {
+		path = btrfs_info_find_valid_path(bi);
+		ret = get_label_mounted(path, label);
+	} else {
+		path = btrfs_info_find_valid_dev(bi);
+		ret = get_label_unmounted(path, label);
+	}
 
 	return ret;
 }
 
-int set_label(const char *btrfs_dev, const char *label)
+int set_label(const char *path, const char *label)
 {
 	int ret;
+	const struct btrfs_info *bi;
 
 	if (check_label(label))
 		return -1;
 
-	ret = path_is_reg_or_block_device(btrfs_dev);
-	if (!ret)
-		ret = set_label_mounted(btrfs_dev, label);
-	else if (ret > 0)
-		ret = set_label_unmounted(btrfs_dev, label);
+	ret = btrfs_info_find(path, &bi);
+	if (ret == -ENOENT) {
+		error("'%s' is not a btrfs filesystem", path);
+		return -ENOENT;
+	}
+	if (ret < 0) {
+		error("unable to access btrfs filesystem info");
+		return -EINVAL;
+	}
+
+	if (btrfs_info_is_mounted(bi)) {
+		path = btrfs_info_find_valid_path(bi);
+		ret = set_label_mounted(path, label);
+	} else {
+		path = btrfs_info_find_valid_dev(bi);
+		ret = set_label_unmounted(path, label);
+	}
 
 	return ret;
 }
-- 
2.43.0


