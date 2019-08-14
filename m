Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBED8C567
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Aug 2019 03:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHNBES (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 21:04:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41230 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfHNBEQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 21:04:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78C4CB0B6
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Aug 2019 01:04:14 +0000 (UTC)
Received: from starscream.home.jeffm.io (starscream-1.home.jeffm.io [IPv6:2001:559:c0d4::1fe])
        by mail.home.jeffm.io (Postfix) with ESMTPS id 0B7FB83DC466;
        Tue, 13 Aug 2019 22:05:08 -0400 (EDT)
Received: by starscream.home.jeffm.io (Postfix, from userid 1000)
        id 9D8036093CD; Tue, 13 Aug 2019 21:04:11 -0400 (EDT)
From:   Jeff Mahoney <jeffm@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH 4/5] btrfs-progs: resize: more sensible error messages for bad sizes
Date:   Tue, 13 Aug 2019 21:04:01 -0400
Message-Id: <20190814010402.22546-4-jeffm@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190814010402.22546-1-jeffm@suse.com>
References: <20190814010402.22546-1-jeffm@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If a user attempts to resize a file system to a size under 256MiB,
it will be rejected with EINVAL and get then unhelpful error message
"ERROR: unable to resize '/path': Invalid argument."

This commit performs that check before issuing the ioctl to report
a more sensible error message.   We also do overflow/underflow
checking when -/+ size is used and report those errors as well.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 cmds/filesystem.c | 41 +++++++++++++++++++++++++++++++++++++++++
 common/utils.c    |  2 +-
 common/utils.h    |  2 +-
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 4f22089a..e3415126 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -34,10 +34,12 @@
 #include "kerncompat.h"
 #include "ctree.h"
 #include "common/utils.h"
+#include "common/device-utils.h"
 #include "volumes.h"
 #include "cmds/commands.h"
 #include "cmds/filesystem-usage.h"
 #include "kernel-lib/list_sort.h"
+#include "kernel-lib/overflow.h"
 #include "disk-io.h"
 #include "common/help.h"
 #include "common/fsfeatures.h"
@@ -1062,6 +1064,41 @@ next:
 }
 static DEFINE_SIMPLE_COMMAND(filesystem_defrag, "defragment");
 
+static int check_resize_size(const char *path, const char *amount)
+{
+	int mod = 0;
+	u64 oldsize = 0, size, newsize;
+
+	if (*amount == '-')
+		mod = -1;
+	else if (*amount == '+')
+		mod = 1;
+
+	if (mod) {
+		amount++;
+		oldsize = disk_size(path);
+		if (oldsize == 0)
+			return -1;
+	}
+
+	size = parse_size(amount);
+
+	if (mod == -1 && check_sub_overflow(oldsize, size, &newsize)) {
+		error("can't resize to negative size");
+		return -1;
+	} else if (mod == 1 && check_add_overflow(oldsize, size, &newsize)) {
+		error("can't resize to larger than 16EiB");
+		return -1;
+	} else
+		newsize = size;
+
+	if (newsize < SZ_256M) {
+		error("can't resize to size smaller than 256MiB");
+		return -1;
+	}
+	return 0;
+}
+
 static const char * const cmd_filesystem_resize_usage[] = {
 	"btrfs filesystem resize [devid:][+/-]<newsize>[kKmMgGtTpPeE]|[devid:]max <path>",
 	"Resize a filesystem",
@@ -1110,6 +1147,10 @@ static int cmd_filesystem_resize(const struct cmd_struct *cmd,
 	if (fd < 0)
 		return 1;
 
+	res = check_resize_size(path, amount);
+	if (res < 0)
+		return 1;
+
 	printf("Resize '%s' of '%s'\n", path, amount);
 	memset(&args, 0, sizeof(args));
 	strncpy_null(args.name, amount);
diff --git a/common/utils.c b/common/utils.c
index ad938409..f2a10ccc 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -638,7 +638,7 @@ static int fls64(u64 x)
 	return 64 - i;
 }
 
-u64 parse_size(char *s)
+u64 parse_size(const char *s)
 {
 	char c;
 	char *endptr;
diff --git a/common/utils.h b/common/utils.h
index 7867fb0a..0ef1d6e8 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -65,7 +65,7 @@ int pretty_size_snprintf(u64 size, char *str, size_t str_bytes, unsigned unit_mo
 #define pretty_size(size) 	pretty_size_mode(size, UNITS_DEFAULT)
 const char *pretty_size_mode(u64 size, unsigned mode);
 
-u64 parse_size(char *s);
+u64 parse_size(const char *s);
 u64 parse_qgroupid(const char *p);
 u64 arg_strtou64(const char *str);
 int open_file_or_dir(const char *fname, DIR **dirstream);
-- 
2.16.4

