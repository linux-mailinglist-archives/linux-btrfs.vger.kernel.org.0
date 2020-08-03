Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6523AE2A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 22:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgHCUa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 16:30:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgHCUa3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Aug 2020 16:30:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84843AE2C;
        Mon,  3 Aug 2020 20:30:43 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/4] btrfs-progs: add sysfs file reading functions
Date:   Mon,  3 Aug 2020 15:30:13 -0500
Message-Id: <20200803203015.24562-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803203015.24562-1-rgoldwyn@suse.de>
References: <20200803202913.15913-1-rgoldwyn@suse.de>
 <20200803203015.24562-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Functions to read and and open sysfs files.
Given a fd, find the fsid associated with the mount and convert into
the sysfs directory to look. Read the exclusive_operation file to find
the current exclusive operation running.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 Makefile       |  4 ++--
 common/sysfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 common/utils.h |  3 +++
 3 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 common/sysfs.c

diff --git a/Makefile b/Makefile
index ee57d9f8..8a267c45 100644
--- a/Makefile
+++ b/Makefile
@@ -168,8 +168,8 @@ libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-shared/free-space-tree.o repair.o kernel-shared/inode-item.o \
 		   kernel-shared/file-item.o \
 		   kernel-lib/raid56.o kernel-lib/tables.o \
-		   common/device-scan.o common/path-utils.o \
-		   common/utils.o libbtrfsutil/subvolume.o libbtrfsutil/stubs.o \
+		   common/device-scan.o common/path-utils.o common/utils.o \
+		   common/sysfs.o libbtrfsutil/subvolume.o libbtrfsutil/stubs.o \
 		   crypto/hash.o crypto/xxhash.o $(CRYPTO_OBJECTS)
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
diff --git a/common/sysfs.c b/common/sysfs.c
new file mode 100644
index 00000000..9a18c753
--- /dev/null
+++ b/common/sysfs.c
@@ -0,0 +1,60 @@
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <unistd.h>
+#include <sys/select.h>
+#include <uuid/uuid.h>
+
+#include "common/utils.h"
+
+static char fsid_str[BTRFS_UUID_UNPARSED_SIZE] = {'\0'};
+
+int sysfs_open(int fd, const char *filename)
+{
+	u8 fsid[BTRFS_UUID_SIZE];
+	int ret;
+	char sysfs_file[128];
+
+	if (fsid_str[0] == '\0') {
+		ret = get_fsid_fd(fd, fsid);
+		if (ret < 0)
+			return ret;
+		uuid_unparse(fsid, fsid_str);
+	}
+
+	snprintf(sysfs_file, 128, "/sys/fs/btrfs/%s/%s", fsid_str, filename);
+	return open(sysfs_file, O_RDONLY);
+}
+
+int sysfs_get_str_fd(int fd, char *val, int size)
+{
+	lseek(fd, 0, SEEK_SET);
+	memset(val, '\0', size);
+	return read(fd, val, size);
+}
+
+int get_exclusive_operation(int mp_fd, char *val)
+{
+	char *s;
+	int fd;
+	int n;
+
+	fd = sysfs_open(mp_fd, "exclusive_operation");
+	if (fd < 0)
+		return fd;
+
+	n = sysfs_get_str_fd(fd, val, BTRFS_SYSFS_EXOP_SIZE);
+	close(fd);
+
+	if (n < 0)
+		return n;
+
+	s = strchr(val, '\n');
+	if (!s)
+		return n;
+
+	*s = '\0';
+	return strlen(val);
+}
diff --git a/common/utils.h b/common/utils.h
index e34bb5a4..be8aab58 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -153,4 +153,7 @@ void init_rand_seed(u64 seed);
 char *btrfs_test_for_multiple_profiles(int fd);
 int btrfs_warn_multiple_profiles(int fd);
 
+#define BTRFS_SYSFS_EXOP_SIZE		16
+int get_exclusive_operation(int fd, char *val);
+
 #endif
-- 
2.26.2

