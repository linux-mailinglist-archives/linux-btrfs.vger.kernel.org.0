Return-Path: <linux-btrfs+bounces-3800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2331892D9F
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 23:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E021C20DA4
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Mar 2024 22:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2264E1D6;
	Sat, 30 Mar 2024 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GVZtnp5E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458F22093
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711837498; cv=none; b=idaN9v4dp05ym2kzOht0zYuLNgvtX5GuhXfhes4g31jhcjRKNu1ugoHahAOADf46Q/N37+Kiy5geyQccVy1PPvrPBIp7Kqt9NwW0Y0LNbgrERsv9/pITHxnFE76WyenvKQKca2IoPYm6lu9R1a9SbPTKJmVj9M5WOEJcyAcjLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711837498; c=relaxed/simple;
	bh=mpLrg59LQLiLuJ+zGaXRxOYj9ofyy7sPVV34iO7tKzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbPMqtFRvg7vgThyAhgoHp7F3ZT5JVhXsZoX8Sdzs2kybapPcFJahhVk78WVf+H5zCuae4z/OhgXM5VgRDerDtcZcR/43zpTPhB6ZQLAwNiGm3hvc2F/sRgBkA0O0mrbbVmI75sdAvT/TfAfNa0t+zOv/jjikWKIbaFbTLZgj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GVZtnp5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B116137FA7
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711837486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r92p7uJ8N1EX1DMvpTHL9XqqkGtpS3jnZQyDyXXXLlE=;
	b=GVZtnp5EIUhewlhHgkfUaBi5EbglndRD7IXnsI3tk7+UP30d1dNM7YXm5voldk7w+jrWDx
	Gv02pjdxq7RLhtKLNZ+Xw6sTv35dTgi1p3ZC1/BmEV8OSQxZf2EA1EC/HzBbD7uXgvkzdc
	l5t29dyH26+qvmcv4UB3FMwmG1aQqLk=
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D39D513A9B
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id CAYjHy2RCGb7QQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Mar 2024 22:24:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: headers cleanup
Date: Sun, 31 Mar 2024 08:54:25 +1030
Message-ID: <406d64357357f67a70fc464302dc36ceac28a793.1711837050.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711837050.git.wqu@suse.com>
References: <cover.1711837050.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B116137FA7
X-Spamd-Result: default: False [-1.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_DKIM_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.81
X-Spam-Level: 
X-Spam-Flag: NO

There are quite some headers included but not utilized, clangd would
report those headers for cleanup.

However clangd (17.0.6 at the time of writing) has a bug that, the file
is only utilizing a C macro in the header, clangd would still report the
header as unused.

This involves the following exceptions:

- pretty_size()
  There is not much need to declare it as a macro.
  Redefine it as a static inline function to workaround the clangd bug.

- kernel-lib/mktables.c
  False alert on inittype.h, as some types are defined as macros.

- libbtrfs/send-utils.c
  False alert on limits.h, as some types are defined as macros.

- tests/array-tests.c
- tests/string-table-test.c
  False alert on common/utils.h for ARRAY_SIZE() macro.

Some parts are not touched yet:

- crypto/*
  This involves quite some optimization code for different instructions,
  making it pretty hard to comprehensively tested.

- tests/library-tests
  As I'll do a more comprehensive cleanup involving BTRFS_FLAT_INCLUDES.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c        |  1 -
 btrfs-sb-mod.c               |  2 --
 btrfs.c                      |  1 -
 cmds/device.c                |  1 -
 cmds/filesystem-du.c         |  1 -
 cmds/filesystem-usage.c      |  1 -
 cmds/inspect.c               |  3 ---
 cmds/quota.c                 |  1 -
 cmds/receive-dump.c          |  1 -
 cmds/receive.c               |  1 -
 cmds/reflink.c               |  2 --
 cmds/restore.c               |  1 -
 cmds/scrub.c                 |  3 ---
 common/device-scan.c         |  1 -
 common/open-utils.c          |  1 -
 common/path-utils.c          |  1 -
 common/send-stream.c         |  1 -
 common/send-utils.c          |  1 -
 common/string-utils.c        |  2 --
 common/units.h               |  7 ++++++-
 common/utils.c               |  1 -
 convert/main.c               |  1 -
 convert/source-ext2.c        |  1 -
 kernel-lib/mktables.c        |  5 +----
 kernel-shared/dir-item.c     |  1 -
 kernel-shared/extent-tree.c  |  1 -
 kernel-shared/file-item.c    |  1 -
 kernel-shared/file.c         |  2 --
 kernel-shared/inode-item.c   |  2 --
 kernel-shared/messages.c     |  1 -
 kernel-shared/root-tree.c    |  1 -
 kernel-shared/tree-checker.c |  1 -
 kernel-shared/uuid-tree.c    |  3 ---
 kernel-shared/zoned.c        |  1 -
 libbtrfs/crc32c.c            |  5 ++---
 mkfs/common.c                |  1 -
 mkfs/rootdir.c               |  1 -
 tests/fsstress.c             | 25 ++++++++++++-------------
 tests/ioctl-test.c           |  1 -
 39 files changed, 21 insertions(+), 67 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index 124597333771..4c9b7abe1ab4 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -20,7 +20,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <getopt.h>
-#include <limits.h>
 #include <errno.h>
 #include <string.h>
 #include <unistd.h>
diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 1f3cbb4c9742..b551dcf637d6 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -20,11 +20,9 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <inttypes.h>
 #include <string.h>
 #include <limits.h>
 #include <byteswap.h>
-#include "crypto/crc32c.h"
 #include "kernel-shared/disk-io.h"
 
 #define BLOCKSIZE (4096)
diff --git a/btrfs.c b/btrfs.c
index 3be875425511..66f85f545f07 100644
--- a/btrfs.c
+++ b/btrfs.c
@@ -28,7 +28,6 @@
 #include "common/utils.h"
 #include "common/string-utils.h"
 #include "common/help.h"
-#include "common/box.h"
 #include "common/messages.h"
 #include "cmds/commands.h"
 
diff --git a/cmds/device.c b/cmds/device.c
index bff2bad917a5..936585da4ef1 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -26,7 +26,6 @@
 #include <dirent.h>
 #include <stdbool.h>
 #include "kernel-shared/zoned.h"
-#include "kernel-shared/volumes.h"
 #include "common/string-table.h"
 #include "common/utils.h"
 #include "common/help.h"
diff --git a/cmds/filesystem-du.c b/cmds/filesystem-du.c
index 87b85a370ed5..9de3ee2d8a38 100644
--- a/cmds/filesystem-du.c
+++ b/cmds/filesystem-du.c
@@ -27,7 +27,6 @@
 #include <fcntl.h>
 #include <dirent.h>
 #include <errno.h>
-#include <limits.h>
 #include <stdbool.h>
 #include <unistd.h>
 #include "kernel-lib/rbtree.h"
diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 497a33bc566f..5f194b40b596 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -26,7 +26,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <dirent.h>
-#include <limits.h>
 #include <uuid/uuid.h>
 #include "kernel-lib/sizes.h"
 #include "kernel-shared/ctree.h"
diff --git a/cmds/inspect.c b/cmds/inspect.c
index 145196d0497a..01469ae82524 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -26,7 +26,6 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <getopt.h>
-#include <limits.h>
 #include <dirent.h>
 #include <string.h>
 #include <unistd.h>
@@ -45,8 +44,6 @@
 #include "common/open-utils.h"
 #include "common/units.h"
 #include "common/string-utils.h"
-#include "common/string-table.h"
-#include "common/sort-utils.h"
 #include "common/tree-search.h"
 #include "cmds/commands.h"
 
diff --git a/cmds/quota.c b/cmds/quota.c
index 8023e9b21a25..70800a088d75 100644
--- a/cmds/quota.c
+++ b/cmds/quota.c
@@ -16,7 +16,6 @@
  * Boston, MA 021110-1307, USA.
  */
 
-#include "kerncompat.h"
 #include <sys/ioctl.h>
 #include <dirent.h>
 #include <errno.h>
diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 83d22a878420..388f34188ecb 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -17,7 +17,6 @@
  */
 
 #include "kerncompat.h"
-#include <limits.h>
 #include <time.h>
 #include <ctype.h>
 #include <errno.h>
diff --git a/cmds/receive.c b/cmds/receive.c
index e4430b077e36..0966abfceceb 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -28,7 +28,6 @@
 #include <stdint.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <limits.h>
 #include <errno.h>
 #include <endian.h>
 #include <stdbool.h>
diff --git a/cmds/reflink.c b/cmds/reflink.c
index 2884ba9159e6..f43b55c4b786 100644
--- a/cmds/reflink.c
+++ b/cmds/reflink.c
@@ -23,8 +23,6 @@
 #include <unistd.h>
 #include "kernel-lib/list.h"
 #include "common/messages.h"
-#include "common/open-utils.h"
-#include "common/parse-utils.h"
 #include "common/string-utils.h"
 #include "common/help.h"
 #include "cmds/commands.h"
diff --git a/cmds/restore.c b/cmds/restore.c
index 4904e87b87f9..72183bd97013 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -28,7 +28,6 @@
 #include <regex.h>
 #include <getopt.h>
 #include <errno.h>
-#include <limits.h>
 #include <stddef.h>
 #include <string.h>
 #if COMPRESSION_LZO
diff --git a/cmds/scrub.c b/cmds/scrub.c
index 9e03d50b36a8..8e567cf24464 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -31,7 +31,6 @@
 #include <ctype.h>
 #include <signal.h>
 #include <stdarg.h>
-#include <limits.h>
 #include <dirent.h>
 #include <getopt.h>
 #include <errno.h>
@@ -50,11 +49,9 @@
 #include "common/open-utils.h"
 #include "common/units.h"
 #include "common/device-utils.h"
-#include "common/parse-utils.h"
 #include "common/sysfs-utils.h"
 #include "common/string-table.h"
 #include "common/string-utils.h"
-#include "common/parse-utils.h"
 #include "common/help.h"
 #include "cmds/commands.h"
 
diff --git a/common/device-scan.c b/common/device-scan.c
index 39669ae14c45..806466d14aa6 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -28,7 +28,6 @@
 #include <unistd.h>
 #include <errno.h>
 #include <dirent.h>
-#include <limits.h>
 #include <stdbool.h>
 #include <blkid/blkid.h>
 #include <uuid/uuid.h>
diff --git a/common/open-utils.c b/common/open-utils.c
index 95294f63e9d1..87ef4402bd8a 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -22,7 +22,6 @@
 #include <fcntl.h>
 #include <mntent.h>
 #include <errno.h>
-#include <limits.h>
 #include <stdio.h>
 #include <string.h>
 #include "kernel-lib/list.h"
diff --git a/common/path-utils.c b/common/path-utils.c
index a47ca422b787..80880332c1d5 100644
--- a/common/path-utils.c
+++ b/common/path-utils.c
@@ -29,7 +29,6 @@
 #include <errno.h>
 #include <ctype.h>
 #include <libgen.h>
-#include <limits.h>
 #include "common/path-utils.h"
 
 /*
diff --git a/common/send-stream.c b/common/send-stream.c
index 2fda54b1de8e..8acb138a5d3c 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -22,7 +22,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "kernel-shared/accessors.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/send.h"
diff --git a/common/send-utils.c b/common/send-utils.c
index cec1653e14c7..45d7c4e36abc 100644
--- a/common/send-utils.c
+++ b/common/send-utils.c
@@ -20,7 +20,6 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <limits.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/common/string-utils.c b/common/string-utils.c
index c6e16ddcc48c..b1c7481bbc24 100644
--- a/common/string-utils.c
+++ b/common/string-utils.c
@@ -16,8 +16,6 @@
 
 #include "kerncompat.h"
 #include <stdlib.h>
-#include <stdio.h>
-#include <limits.h>
 #include "common/string-utils.h"
 #include "common/messages.h"
 #include "common/parse-utils.h"
diff --git a/common/units.h b/common/units.h
index d93977ff2aff..dbd184ab9d75 100644
--- a/common/units.h
+++ b/common/units.h
@@ -43,7 +43,12 @@
 
 const char *pretty_size_mode(u64 size, unsigned mode);
 int pretty_size_snprintf(u64 size, char *str, size_t str_size, unsigned unit_mode);
-#define pretty_size(size) 	pretty_size_mode(size, UNITS_DEFAULT)
+
+static inline const char *pretty_size(u64 size)
+{
+	return pretty_size_mode(size, UNITS_DEFAULT);
+}
+
 void units_set_mode(unsigned *units, unsigned mode);
 void units_set_base(unsigned *units, unsigned base);
 unsigned int get_unit_mode_from_arg(int *argc, char *argv[], int df_mode);
diff --git a/common/utils.c b/common/utils.c
index c303462c4c8d..f17cc7207829 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -32,7 +32,6 @@
 #include <unistd.h>
 #include <mntent.h>
 #include <ctype.h>
-#include <limits.h>
 #include <strings.h>
 #include "kernel-lib/list.h"
 #include "kernel-shared/accessors.h"
diff --git a/convert/main.c b/convert/main.c
index f18fab4a236c..6001fe7a13de 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -91,7 +91,6 @@
 #include <pthread.h>
 #include <stdbool.h>
 #include <errno.h>
-#include <limits.h>
 #include <string.h>
 #include <uuid/uuid.h>
 #include "kernel-lib/sizes.h"
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index 2186b2526e38..790a4a228920 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -21,7 +21,6 @@
 #include <linux/limits.h>
 #include <errno.h>
 #include <pthread.h>
-#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/kernel-lib/mktables.c b/kernel-lib/mktables.c
index 85f621fe9156..17b6493ded31 100644
--- a/kernel-lib/mktables.c
+++ b/kernel-lib/mktables.c
@@ -17,15 +17,12 @@
 
 /*
  * Btrfs-progs port, with following minor fixes:
- * 1) Use "kerncompat.h"
+ * 1) Use "kerncompat.h" header for generated tables.c
  * 2) Get rid of __KERNEL__ related macros
  */
 
 #include <stdio.h>
-#include <string.h>
 #include <inttypes.h>
-#include <stdlib.h>
-#include <time.h>
 
 static uint8_t gfmul(uint8_t a, uint8_t b)
 {
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 2251de408bc0..5995258322d6 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -21,7 +21,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/accessors.h"
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index c2ccb8aa4dec..6d25e9f2fb9d 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -22,7 +22,6 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <string.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-lib/list.h"
 #include "kernel-lib/rbtree.h"
 #include "kernel-lib/rbtree_types.h"
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 34d8059e7efe..4f0efa87092d 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -24,7 +24,6 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/file-item.h"
 #include "kernel-shared/extent_io.h"
-#include "kernel-shared/uapi/btrfs.h"
 #include "common/internal.h"
 
 #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index c51019b24075..73a8fe8e8943 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -19,10 +19,8 @@
 #include "kerncompat.h"
 #include <errno.h>
 #include <string.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent_io.h"
-#include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/compression.h"
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index f3f7286bea8b..5ad27009bbb7 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -19,10 +19,8 @@
 #include "kerncompat.h"
 #include <errno.h>
 #include <stddef.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent_io.h"
-#include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
diff --git a/kernel-shared/messages.c b/kernel-shared/messages.c
index 1853ad711e7a..813667e32096 100644
--- a/kernel-shared/messages.c
+++ b/kernel-shared/messages.c
@@ -3,7 +3,6 @@
 #include "kerncompat.h"
 #include <errno.h>
 #include <stdarg.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/messages.h"
 
diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
index dd2636eca25c..39c3f9027b68 100644
--- a/kernel-shared/root-tree.c
+++ b/kernel-shared/root-tree.c
@@ -19,7 +19,6 @@
 #include "kerncompat.h"
 #include <errno.h>
 #include <string.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/messages.h"
 #include "kernel-shared/extent_io.h"
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 8770392bd0ba..f3ee5628f866 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -19,7 +19,6 @@
 #include <sys/stat.h>
 #include <linux/limits.h>
 #include <errno.h>
-#include <limits.h>
 #include <stdarg.h>
 #include "kernel-lib/overflow.h"
 #include "kernel-lib/bitops.h"
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 7adbc11ee4d1..f575ebe66d29 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -21,7 +21,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <string.h>
-#include "kernel-lib/bitops.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs.h"
@@ -29,8 +28,6 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/messages.h"
 #include "kernel-shared/transaction.h"
-#include "common/messages.h"
-#include "common/utils.h"
 
 void btrfs_uuid_to_key(const u8 *uuid, u8 type, struct btrfs_key *key)
 {
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index fb1e1388804e..bda12aee1010 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -28,7 +28,6 @@
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/extent_io.h"
-#include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/utils.h"
 #include "common/device-utils.h"
diff --git a/libbtrfs/crc32c.c b/libbtrfs/crc32c.c
index 4391e46f16ee..908789251e62 100644
--- a/libbtrfs/crc32c.c
+++ b/libbtrfs/crc32c.c
@@ -8,7 +8,6 @@
  *
  */
 
-#include <inttypes.h>
 #include "libbtrfs/crc32c.h"
 
 uint32_t __crc32c_le(uint32_t crc, unsigned char const *data, uint32_t length);
@@ -53,7 +52,7 @@ static uint32_t crc32c_intel_le_hw_byte(uint32_t crc, unsigned char const *data,
 }
 
 /*
- * Steps through buffer one byte at at time, calculates reflected 
+ * Steps through buffer one byte at at time, calculates reflected
  * crc using table.
  */
 static uint32_t crc32c_intel(uint32_t crc, unsigned char const *data, uint32_t length)
@@ -198,7 +197,7 @@ static const uint32_t crc32c_table[256] = {
 };
 
 /*
- * Steps through buffer one byte at at time, calculates reflected 
+ * Steps through buffer one byte at at time, calculates reflected
  * crc using table.
  */
 
diff --git a/mkfs/common.c b/mkfs/common.c
index 3c48a6c120e7..d2e7dd32a697 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -17,7 +17,6 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <limits.h>
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 4ae9f435a7b7..f9a7ada0dd66 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -24,7 +24,6 @@
 #include <fcntl.h>
 #include <ftw.h>
 #include <errno.h>
-#include <limits.h>
 #include <stdlib.h>
 #include <string.h>
 #include "kernel-lib/sizes.h"
diff --git a/tests/fsstress.c b/tests/fsstress.c
index d0335813859d..56f62f6bd876 100644
--- a/tests/fsstress.c
+++ b/tests/fsstress.c
@@ -32,7 +32,6 @@
 #include <fcntl.h>
 #include <assert.h>
 #include <getopt.h>
-#include "common/internal.h"
 
 #define AIO
 #define URING
@@ -1434,7 +1433,7 @@ fent_to_name(pathname_t *name, fent_t *fep)
 		if (pfep == NULL) {
 			fprintf(stderr, "%d: fent-id = %d: can't find parent id: %d\n",
 				procid, fep->id, fep->parent);
-		} 
+		}
 #endif
 		if (pfep == NULL)
 			return 0;
@@ -1545,7 +1544,7 @@ int generate_xattr_name(int xattr_num, char *buffer, int buflen)
 }
 
 /*
- * Get file 
+ * Get file
  * Input: "which" to choose the file-types eg. non-directory
  * Input: "r" to choose which file
  * Output: file-list, file-entry, name for the chosen file.
@@ -1585,7 +1584,7 @@ get_fname(int which, long r, pathname_t *name, flist_t **flpp, fent_t **fepp,
 	 * Now we have possible matches between 0..totalsum-1.
 	 * And we use r to help us choose which one we want,
 	 * which when bounded by totalsum becomes x.
-	 */ 
+	 */
 	x = (int)(r % totalsum);
 	for (i = 0, flp = flist; i < FT_nft; i++, flp++) {
 		if (which & (1U << i)) {
@@ -1600,7 +1599,7 @@ get_fname(int which, long r, pathname_t *name, flist_t **flpp, fent_t **fepp,
 #ifdef DEBUG
 					if (!e) {
 						fprintf(stderr, "%d: failed to get path for entry:"
-								" id=%d,parent=%d\n", 	
+								" id=%d,parent=%d\n",
 							procid, fep->id, fep->parent);
 					}
 #endif
@@ -2007,7 +2006,7 @@ show_ops(int flag, char *lead_str)
         if (flag<0) {
                 /* print in list form */
                 int             x = WIDTH;
-                
+
 	        for (p = ops; p < ops_end; p++) {
 			if (lead_str != NULL && x+strlen(p->name)>=WIDTH-5)
 				x=printf("%s%s", (p==ops)?"":"\n", lead_str);
@@ -2069,7 +2068,7 @@ symlink_path(const char *name1, pathname_t *name)
 	char		buf[NAME_MAX + 1];
 	pathname_t	newname;
 	int		rval;
-        
+
         if (!strcmp(name1, name->path)) {
             printf("yikes! %s %s\n", name1, name->path);
             return 0;
@@ -2647,7 +2646,7 @@ bulkstat_f(opnum_t opno, long r)
         bsr.icount=nent;
         bsr.ubuffer=t;
         bsr.ocount=&count;
-            
+
 	while (xfsctl(".", fd, XFS_IOC_FSBULKSTAT, &bsr) == 0 && count > 0)
 		total += count;
 	free(t);
@@ -2680,8 +2679,8 @@ bulkstat1_f(opnum_t opno, long r)
 		check_cwd();
 		free_pathname(&f);
 	} else {
-                /* 
-                 * pick a random inode 
+                /*
+                 * pick a random inode
                  *
                  * note this can generate kernel warning messages
                  * since bulkstat_one will read the disk block that
@@ -2698,7 +2697,7 @@ bulkstat1_f(opnum_t opno, long r)
 		v = verbose;
 	}
 	fd = open(".", O_RDONLY);
-        
+
         bsr.lastip=&ino;
         bsr.icount=1;
         bsr.ubuffer=&t;
@@ -3797,7 +3796,7 @@ dread_f(opnum_t opno, long r)
 	len -= (len % align);
 	if (len <= 0)
 		len = align;
-	else if (len > diob.d_maxiosz) 
+	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
 	buf = memalign(diob.d_mem, len);
 	e = read(fd, buf, len) < 0 ? errno : 0;
@@ -3874,7 +3873,7 @@ dwrite_f(opnum_t opno, long r)
 	len -= (len % align);
 	if (len <= 0)
 		len = align;
-	else if (len > diob.d_maxiosz) 
+	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
 	buf = memalign(diob.d_mem, len);
 	off %= maxfsize;
diff --git a/tests/ioctl-test.c b/tests/ioctl-test.c
index dd6284f934c1..c78ca92ce307 100644
--- a/tests/ioctl-test.c
+++ b/tests/ioctl-test.c
@@ -19,7 +19,6 @@
 #include <stdlib.h>
 
 #include "kernel-shared/uapi/btrfs.h"
-#include "kernel-shared/ctree.h"
 
 #define LIST_32_COMPAT				\
 	ONE(BTRFS_IOC_SET_RECEIVED_SUBVOL_32)
-- 
2.44.0


