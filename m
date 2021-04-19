Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFCB363BCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Apr 2021 08:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhDSGps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Apr 2021 02:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhDSGpr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Apr 2021 02:45:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618814716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PE5Ia8po+WZTvE/x+ZRwGEsEsg4sfS33YzgBQOTYKU4=;
        b=AK4tLXqJhcDTnJE9jieRML68/WJcz+m5UoyQZmPcIQcJ2lKaBeca/Z086Vcr3th/qiQYCP
        SXbtxzyA54ZaGSzktBEVjzQDZgWEasRCTidpu/VF/prOHCBdgfq/P0XSmUKHq8+LK+A5T9
        tR/XZdzVQZXKk5q0tf/2esO97yUdU3c=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7932ACF9
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Apr 2021 06:45:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: mkfs: only output the warning if the sectorsize is not supported
Date:   Mon, 19 Apr 2021 14:45:12 +0800
Message-Id: <20210419064512.92213-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently mkfs.btrfs will output a warning message if the sectorsize is
not the same as page size:
  WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536

But since btrfs subpage support for 64K page size is comming, this
output is populating the golden output of fstests, causing tons of false
alerts.

This patch will make teach mkfs.btrfs to check
/sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
size is supported.

Then only output above warning message if the sector size is not
supported.

This patch will also introduce a new helper,
sysfs_open_global_feature_file() to make it more obvious which global
feature file we're opening.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
- Introduce new helper to open global feature file
- Extra the supported sectorsize check into its own function
- Do proper token check other than strstr()
- Fix the bug that we're passing @page_size to check
---
 common/fsfeatures.c | 49 ++++++++++++++++++++++++++++++++++++++++++++-
 common/utils.c      | 15 ++++++++++++++
 common/utils.h      |  1 +
 3 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 569208a9e5b1..6641c44dfa45 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -327,8 +327,50 @@ u32 get_running_kernel_version(void)
 
 	return version;
 }
+
+/*
+ * The buffer size should be strlen("4096 8192 16384 32768 65536"),
+ * which is 28, then we just round it up to 32.
+ */
+#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
+
+/*
+ * Check if the current kernel supports given sectorsize.
+ *
+ * Return true if the sectorsize is supported.
+ * Return false otherwise.
+ */
+static bool check_supported_sectorsize(u32 sectorsize)
+{
+	char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
+	char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
+	char *this_char;
+	char *save_ptr = NULL;
+	int fd;
+	int ret;
+
+	fd = sysfs_open_global_feature_file("supported_sectorsizes");
+	if (fd < 0)
+		return false;
+	ret = sysfs_read_file(fd, supported_buf, SUPPORTED_SECTORSIZE_BUF_SIZE);
+	close(fd);
+	if (ret < 0)
+		return false;
+	snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
+		 "%u", sectorsize);
+
+	for (this_char = strtok_r(supported_buf, " ", &save_ptr);
+	     this_char != NULL;
+	     this_char = strtok_r(NULL, ",", &save_ptr)) {
+		if (!strncmp(this_char, sectorsize_buf, strlen(sectorsize_buf)))
+			return true;
+	}
+	return false;
+}
+
 int btrfs_check_sectorsize(u32 sectorsize)
 {
+	bool sectorsize_checked = false;
 	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
 
 	if (!is_power_of_2(sectorsize)) {
@@ -340,7 +382,12 @@ int btrfs_check_sectorsize(u32 sectorsize)
 		      sectorsize);
 		return -EINVAL;
 	}
-	if (page_size != sectorsize)
+	if (page_size == sectorsize)
+		sectorsize_checked = true;
+	else
+		sectorsize_checked = check_supported_sectorsize(sectorsize);
+
+	if (!sectorsize_checked)
 		warning(
 "the filesystem may not be mountable, sectorsize %u doesn't match page size %u",
 			sectorsize, page_size);
diff --git a/common/utils.c b/common/utils.c
index 57e41432c8fb..e8b35879f19f 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -2205,6 +2205,21 @@ int sysfs_open_fsid_file(int fd, const char *filename)
 	return open(sysfs_file, O_RDONLY);
 }
 
+/*
+ * Open a file in global btrfs features directory and return the file
+ * descriptor or error.
+ */
+int sysfs_open_global_feature_file(const char *feature_name)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = path_cat_out(path, "/sys/fs/btrfs/features", feature_name);
+	if (ret < 0)
+		return ret;
+	return open(path, O_RDONLY);
+}
+
 /*
  * Read up to @size bytes to @buf from @fd
  */
diff --git a/common/utils.h b/common/utils.h
index c38bdb08077c..d2f6416a9b5a 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -169,6 +169,7 @@ char *btrfs_test_for_multiple_profiles(int fd);
 int btrfs_warn_multiple_profiles(int fd);
 
 int sysfs_open_fsid_file(int fd, const char *filename);
+int sysfs_open_global_feature_file(const char *feature_name);
 int sysfs_read_file(int fd, char *buf, size_t size);
 
 #endif
-- 
2.31.1

