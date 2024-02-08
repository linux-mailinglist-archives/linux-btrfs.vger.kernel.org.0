Return-Path: <linux-btrfs+bounces-2256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D541684E9B6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 21:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AC6B2551C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Feb 2024 20:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CF145977;
	Thu,  8 Feb 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b="eoh1ZJBS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.tiscali.it (santino.mail.tiscali.it [213.205.33.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F63F9F6
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Feb 2024 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.205.33.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424253; cv=none; b=oBtaeVIjspE+vTP/upCfuGKvTkD195MHwOiVhuvc9nkkGUQyXaQoGrqEBa3YCOKishe3xPct5Tr5aT5i/SOTwMGaR/Ta2lvz37HAu/gqHs7FmSdTm+j6upQvNolYwRXNCV/+yvhDWM8R6WOnqQlpgWinzk9lfmzF5j3tDU+PK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424253; c=relaxed/simple;
	bh=aZgkjjCYJB33WIL9BWo06gnUwNXqvi5yh0pljfgzXc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK6oDwRCF0kfAwdsTTgNEW3FnOeX9OZWSHsNvw0gNwerzexwOF/Qg1OsvJfkEagnCioEIkbUBZL2MMovn6CFnldaPxRbtodxtHiflQajJWa5ksxkJGU/47XmVNFSAk1AqRBeWetNM89sp5mTzj50gSDYR3dNFeURBtkkpEV4Ecg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it; spf=pass smtp.mailfrom=tiscali.it; dkim=pass (1024-bit key) header.d=tiscali.it header.i=@tiscali.it header.b=eoh1ZJBS; arc=none smtp.client-ip=213.205.33.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiscali.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiscali.it
Received: from venice.bhome ([84.220.171.3])
	by santino.mail.tiscali.it with 
	id kkVe2B00g04l9eU01kVeo0; Thu, 08 Feb 2024 20:29:39 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: 0
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From: Goffredo Baroncelli <kreijack@tiscali.it>
To: linux-btrfs@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 1/9] Killing dirstream: add helpers
Date: Thu,  8 Feb 2024 21:19:19 +0100
Message-ID: <44e4fdd5c74646a72794a91ba9e4078d0d7379ec.1707423567.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707423567.git.kreijack@inwind.it>
References: <cover.1707423567.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
	t=1707424179; bh=DZFU/m2tMbjdj1qsBV7DLjEjcvkszvIudGvvAmra66o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=eoh1ZJBS2RMeI6iqUiSlcgWZP2sQWHZHRfVZAOfLNZgaH/8g/BOuun8BxoM3hXjT4
	 Ic3aegyxXi80labtnWLu8nhFvg1frFdzS9oWq2Zv2xja7mrv4JRvO6Bpr0RVkuuohM
	 cPCkEZlTmsv6jWwEnfJpc5I4tTh8I1fpbWVc4oIA=

From: Goffredo Baroncelli <kreijack@inwind.it>

For historical reason the helpers [btrfs_]open_dir... return also
the 'DIR *dirstream' value when a dir is opened.

However this is never used. So avoid calling diropen() and return
only the fd.

This is a preparatory patch that adds some helpers.

Signed-off-by: Goffredo Baroncelli <kreijack@libero.it>
---
 common/open-utils.c | 81 +++++++++++++++++++++++++++++++++++++++++++++
 common/open-utils.h |  5 +++
 2 files changed, 86 insertions(+)

diff --git a/common/open-utils.c b/common/open-utils.c
index 111a51d9..87f71196 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -318,3 +318,84 @@ void close_file_or_dir(int fd, DIR *dirstream)
 }
 
 
+/*
+ * Do the following checks before calling open:
+ * 1: path is in a btrfs filesystem
+ */
+int btrfs_open_fd2(const char *path, bool verbose, bool read_write, bool dir_only)
+{
+	struct statfs stfs;
+	struct stat st;
+	int ret;
+
+	if (stat(path, &st) != 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+		return -1;
+	}
+
+	if (dir_only && !S_ISDIR(st.st_mode)) {
+		error_on(verbose, "not a directory: %s", path);
+		return -3;
+	}
+
+	if (statfs(path, &stfs) != 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+		return -1;
+	}
+
+	if (stfs.f_type != BTRFS_SUPER_MAGIC) {
+		error_on(verbose, "not a btrfs filesystem: %s", path);
+		return -2;
+	}
+
+	if (S_ISDIR(st.st_mode) || !read_write)
+		ret = open(path, O_RDONLY);
+	else
+		ret = open(path, O_RDWR);
+
+	if (ret < 0) {
+		error_on(verbose, "cannot access '%s': %m", path);
+	}
+
+	return ret;
+}
+
+int btrfs_open_file_or_dir_fd(const char *path)
+{
+	return btrfs_open_fd2(path, true, true, false);
+}
+
+int btrfs_open_dir_fd(const char *path)
+{
+	return btrfs_open_fd2(path, true, true, true);
+}
+
+
+/*
+ * Given a pathname, return a filehandle to:
+ * 	the original pathname or,
+ * 	if the pathname is a mounted btrfs device, to its mountpoint.
+ *
+ * On error, return -1, errno should be set.
+ */
+int btrfs_open_mnt_fd(const char *path, bool verbose)
+{
+	char mp[PATH_MAX];
+	int ret;
+
+	if (path_is_block_device(path)) {
+		ret = get_btrfs_mount(path, mp, sizeof(mp));
+		if (ret < 0) {
+			/* not a mounted btrfs dev */
+			error_on(verbose, "'%s' is not a mounted btrfs device",
+				 path);
+			errno = EINVAL;
+			return -1;
+		}
+		ret = btrfs_open_fd2(mp, verbose, true, true);
+	} else {
+		ret = btrfs_open_dir_fd(path);
+	}
+
+	return ret;
+}
diff --git a/common/open-utils.h b/common/open-utils.h
index 3f8c004e..96d99f5d 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -39,4 +39,9 @@ int btrfs_open_file_or_dir(const char *path, DIR **dirstream, int verbose);
 
 void close_file_or_dir(int fd, DIR *dirstream);
 
+int btrfs_open_fd2(const char *path, bool verbose, bool read_write, bool dir_only);
+int btrfs_open_file_or_dir_fd(const char *path);
+int btrfs_open_dir_fd(const char *path);
+int btrfs_open_mnt_fd(const char *path, bool verbose);
+
 #endif
-- 
2.43.0


