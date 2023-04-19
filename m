Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAF6E8345
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDSVRf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjDSVRc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:32 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5344BE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id qf26so1033113qvb.6
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939048; x=1684531048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sbBrf8utOVP80ngJU4efviDe0xd8fiX32mWCaQHoVM=;
        b=uvb/vRv9iQA6Q3kxWKPaZ803cThKW0HCap9srSWOns/c+2TZeY6bjiXFAwqCvZ1e2f
         gcpFxjPnFTzQL2fvSCFHGdfrD7pzbNS4NaZcLvAjFo7HpZ1hJaLdu4oOMTdTTFJAToK6
         F+bebQ88AhM70SE8EnD6b81h+ML0WrPGW69iYJuFwOqcsTtK4EH7GaAR0k9FS9h9CH/G
         IklEM4mOg6SzcDYS+JEpGFyKsjjMCT+Y/5TMzH77I2eUV1PxQVasthge/9O0R79pgf8x
         4sbCDD74xcVhYQjyL3m4M5YwNhdNpLiCJWJmj55DC59G6Cr1j2wJS/n3tJN2WJUTgBf5
         pcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939048; x=1684531048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbBrf8utOVP80ngJU4efviDe0xd8fiX32mWCaQHoVM=;
        b=XGUcOUyn2H4/8JzJpNgaq3lWbExl/k28cVfGS+0xAgxHZEHtnuXdXt0hR/nJTMMCZe
         C+0Sh5hC6r9emrA2dmBeYAfp63j1zMd8/c5peswoTnV2GrdeUdkVnm9IxJn/xZsJi6YR
         XvpyuqFGCVl+zrVa70sraqcOp73EN4EQwfxOOFSwVQu8URZDL+BR1JX4P+qRQuYSVjzM
         S2F3oXaHlbdJ0droyD8Ic3Zem+jExIucsJz4QVwYbtfe73sUgBkVZpiIy0zg13j8wXjQ
         rKJ10CIBLisODbsrEQvXTJ8coXxgsuM9sPfH9p/T9Hn3j/nByF9xsZhQaViBOsLc7721
         Ekjw==
X-Gm-Message-State: AAQBX9c4WqiL6oDRXc8CZDjaPKhJxukRo1QiyHS/uZRND9ZjPcuJmSgD
        g9c8Sc3eU+EWCUIrRFD8LVEDhBSxyrpMU+9hO6j/5Q==
X-Google-Smtp-Source: AKy350YgmUFggwrFs9ArvBA5Ec6fdZ0i2gQikZpsSf8Tt7mF8w5eZ+ynO85+TGvsvH3u7/cicEcyfg==
X-Received: by 2002:a05:6214:20ed:b0:5c5:c835:c8f1 with SMTP id 13-20020a05621420ed00b005c5c835c8f1mr33234874qvk.22.1681939047878;
        Wed, 19 Apr 2023 14:17:27 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z9-20020a0ce609000000b005dd8b9345c7sm4643543qvm.95.2023.04.19.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs-progs: sync messages.* from the kernel
Date:   Wed, 19 Apr 2023 17:17:14 -0400
Message-Id: <0a0542fd7abb9fed5f87148ac849cfb7e9577100.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are the printk helpers from the kernel.  There were a few
modifications, the hi-lights are

 - We do not have fs_info::fs_state, so that needed to be removed.
 - We do not have discard.h sync'ed yet, so that dependency was dropped.
 - Anything related to struct super_block was commented out.
 - The transaction abort had to be modified to fit with the current
   btrfs-progs code.
 - Added a btrfs_no_printk() helper to common/messages.* so that the
   print statements still worked.

Additionally there were kerncompat.h changes that needed to be made to
handle the dependencies properly.  Those are easier to spot.

Any function that needed to be modified has a MODIFIED tag in the
comment section with a list of things that were changed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                        |   1 +
 common/messages.c               |  11 ++
 common/messages.h               |  18 ++
 include/kerncompat.h            |  44 +++--
 kernel-shared/backref.c         |   1 +
 kernel-shared/ctree.h           |   2 +
 kernel-shared/delayed-ref.c     |   1 +
 kernel-shared/extent_io.c       |   1 +
 kernel-shared/free-space-tree.c |   1 +
 kernel-shared/messages.c        | 336 ++++++++++++++++++++++++++++++++
 kernel-shared/messages.h        | 216 ++++++++++++++++++++
 kernel-shared/ulist.c           |   1 +
 kernel-shared/zoned.h           |   1 +
 libbtrfs/kerncompat.h           |  20 --
 14 files changed, 614 insertions(+), 40 deletions(-)
 create mode 100644 kernel-shared/messages.c
 create mode 100644 kernel-shared/messages.h

diff --git a/Makefile b/Makefile
index 4b0a869b..45e2e1e6 100644
--- a/Makefile
+++ b/Makefile
@@ -179,6 +179,7 @@ objects = \
 	kernel-shared/free-space-tree.o	\
 	kernel-shared/inode-item.o	\
 	kernel-shared/inode.o	\
+	kernel-shared/messages.o	\
 	kernel-shared/print-tree.o	\
 	kernel-shared/root-tree.o	\
 	kernel-shared/transaction.o	\
diff --git a/common/messages.c b/common/messages.c
index d6dc219b..8bcfcc6a 100644
--- a/common/messages.c
+++ b/common/messages.c
@@ -35,6 +35,17 @@ void __btrfs_printf(const char *fmt, ...)
 	va_end(args);
 }
 
+__attribute__ ((format (printf, 2, 3)))
+void btrfs_no_printk(const void *fs_info, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf(stderr, fmt, args);
+	va_end(args);
+	fputc('\n', stderr);
+}
+
 static bool should_print(int level)
 {
 	if (bconf.verbose == BTRFS_BCONF_QUIET || level == BTRFS_BCONF_QUIET)
diff --git a/common/messages.h b/common/messages.h
index 4bb9866e..d21f6250 100644
--- a/common/messages.h
+++ b/common/messages.h
@@ -111,6 +111,9 @@
 __attribute__ ((format (printf, 1, 2)))
 void __btrfs_printf(const char *fmt, ...);
 
+__attribute__ ((format (printf, 2, 3)))
+void btrfs_no_printk(const void *fs_info, const char *fmt, ...);
+
 /*
  * Level of messages that must be printed by default (in case the verbosity
  * options haven't been set by the user) due to backward compatibility reasons
@@ -154,6 +157,21 @@ __attribute__ ((format (printf, 2, 3)))
 void error_msg(enum common_error error, const char *msg, ...);
 
 #ifndef BTRFS_DISABLE_BACKTRACE
+static inline void assert_trace(const char *assertion, const char *filename,
+			      const char *func, unsigned line, long val)
+{
+	if (val)
+		return;
+	fprintf(stderr,
+		"%s:%d: %s: Assertion `%s` failed, value %ld\n",
+		filename, line, func, assertion, val);
+#ifndef BTRFS_DISABLE_BACKTRACE
+	print_trace();
+#endif
+	abort();
+	exit(1);
+}
+
 #define	UASSERT(c) assert_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 #else
 #define UASSERT(c) assert(c)
diff --git a/include/kerncompat.h b/include/kerncompat.h
index edb00276..d7eba985 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -36,6 +36,8 @@
 #include <linux/const.h>
 #include <stdint.h>
 #include <stdbool.h>
+#include <stdarg.h>
+
 #include <features.h>
 
 /*
@@ -320,6 +322,12 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define printk(fmt, args...) fprintf(stderr, fmt, ##args)
 #define	KERN_CRIT	""
 #define KERN_ERR	""
+#define KERN_EMERG	""
+#define KERN_ALERT	""
+#define KERN_CRIT	""
+#define KERN_NOTICE	""
+#define KERN_INFO	""
+#define KERN_WARNING	""
 
 /*
  * kmalloc/kfree
@@ -335,26 +343,6 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define memalloc_nofs_save() (0)
 #define memalloc_nofs_restore(x)	((void)(x))
 
-#ifndef BTRFS_DISABLE_BACKTRACE
-static inline void assert_trace(const char *assertion, const char *filename,
-			      const char *func, unsigned line, long val)
-{
-	if (val)
-		return;
-	fprintf(stderr,
-		"%s:%d: %s: Assertion `%s` failed, value %ld\n",
-		filename, line, func, assertion, val);
-#ifndef BTRFS_DISABLE_BACKTRACE
-	print_trace();
-#endif
-	abort();
-	exit(1);
-}
-#define	ASSERT(c) assert_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
-#else
-#define ASSERT(c) assert(c)
-#endif
-
 #define BUG_ON(c) bugon_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 #define BUG()				\
 do {					\
@@ -574,8 +562,24 @@ struct work_struct {
 typedef struct wait_queue_head_s {
 } wait_queue_head_t;
 
+struct super_block {
+	char *s_id;
+};
+
+struct va_format {
+	const char *fmt;
+	va_list *va;
+};
+
 #define __init
 #define __cold
 #define __user
 
+#define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
+
+static inline bool sb_rdonly(struct super_block *sb)
+{
+	return false;
+}
+
 #endif
diff --git a/kernel-shared/backref.c b/kernel-shared/backref.c
index 9c5a3895..897cd089 100644
--- a/kernel-shared/backref.c
+++ b/kernel-shared/backref.c
@@ -23,6 +23,7 @@
 #include "kernel-shared/ulist.h"
 #include "kernel-shared/transaction.h"
 #include "common/internal.h"
+#include "messages.h"
 
 #define pr_debug(...) do { } while (0)
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index a5bcc9bc..1ac6ee3f 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -377,6 +377,8 @@ struct btrfs_fs_info {
 		u64 zone_size;
 		u64 zoned;
 	};
+
+	struct super_block *sb;
 };
 
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/delayed-ref.c b/kernel-shared/delayed-ref.c
index 5b041ac6..f148b5f2 100644
--- a/kernel-shared/delayed-ref.c
+++ b/kernel-shared/delayed-ref.c
@@ -20,6 +20,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/delayed-ref.h"
 #include "kernel-shared/transaction.h"
+#include "messages.h"
 
 /*
  * delayed back reference update tracking.  For subvolume trees
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 016aa698..ab80700a 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -34,6 +34,7 @@
 #include "common/utils.h"
 #include "common/device-utils.h"
 #include "common/internal.h"
+#include "messages.h"
 
 static void free_extent_buffer_final(struct extent_buffer *eb);
 
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 656de3fa..4064b7cb 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-lib/bitops.h"
 #include "common/internal.h"
+#include "messages.h"
 
 static struct btrfs_root *btrfs_free_space_root(struct btrfs_fs_info *fs_info,
 						struct btrfs_block_group *block_group)
diff --git a/kernel-shared/messages.c b/kernel-shared/messages.c
new file mode 100644
index 00000000..ce022619
--- /dev/null
+++ b/kernel-shared/messages.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "kerncompat.h"
+#include "kernel-lib/bitops.h"
+#include "ctree.h"
+#include "messages.h"
+#include "transaction.h"
+
+#ifdef CONFIG_PRINTK
+
+#define STATE_STRING_PREFACE	": state "
+#define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
+
+/*
+ * Characters to print to indicate error conditions or uncommon filesystem state.
+ * RO is not an error.
+ */
+static const char fs_state_chars[] = {
+	[BTRFS_FS_STATE_ERROR]			= 'E',
+	[BTRFS_FS_STATE_REMOUNTING]		= 'M',
+	[BTRFS_FS_STATE_RO]			= 0,
+	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
+	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
+	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
+	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
+	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
+};
+
+static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
+{
+	unsigned int bit;
+	bool states_printed = false;
+	unsigned long fs_state = READ_ONCE(info->fs_state);
+	char *curr = buf;
+
+	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
+	curr += sizeof(STATE_STRING_PREFACE) - 1;
+
+	for_each_set_bit(bit, &fs_state, sizeof(fs_state)) {
+		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
+		if ((bit < BTRFS_FS_STATE_COUNT) && fs_state_chars[bit]) {
+			*curr++ = fs_state_chars[bit];
+			states_printed = true;
+		}
+	}
+
+	/* If no states were printed, reset the buffer */
+	if (!states_printed)
+		curr = buf;
+
+	*curr++ = 0;
+}
+#endif
+
+/*
+ * Generally the error codes correspond to their respective errors, but there
+ * are a few special cases.
+ *
+ * EUCLEAN: Any sort of corruption that we encounter.  The tree-checker for
+ *          instance will return EUCLEAN if any of the blocks are corrupted in
+ *          a way that is problematic.  We want to reserve EUCLEAN for these
+ *          sort of corruptions.
+ *
+ * EROFS: If we check BTRFS_FS_STATE_ERROR and fail out with a return error, we
+ *        need to use EROFS for this case.  We will have no idea of the
+ *        original failure, that will have been reported at the time we tripped
+ *        over the error.  Each subsequent error that doesn't have any context
+ *        of the original error should use EROFS when handling BTRFS_FS_STATE_ERROR.
+ */
+const char * __attribute_const__ btrfs_decode_error(int error)
+{
+	char *errstr = "unknown";
+
+	switch (error) {
+	case -ENOENT:		/* -2 */
+		errstr = "No such entry";
+		break;
+	case -EIO:		/* -5 */
+		errstr = "IO failure";
+		break;
+	case -ENOMEM:		/* -12*/
+		errstr = "Out of memory";
+		break;
+	case -EEXIST:		/* -17 */
+		errstr = "Object already exists";
+		break;
+	case -ENOSPC:		/* -28 */
+		errstr = "No space left";
+		break;
+	case -EROFS:		/* -30 */
+		errstr = "Readonly filesystem";
+		break;
+	case -EOPNOTSUPP:	/* -95 */
+		errstr = "Operation not supported";
+		break;
+	case -EUCLEAN:		/* -117 */
+		errstr = "Filesystem corrupted";
+		break;
+	case -EDQUOT:		/* -122 */
+		errstr = "Quota exceeded";
+		break;
+	}
+
+	return errstr;
+}
+
+/*
+ * __btrfs_handle_fs_error decodes expected errors from the caller and
+ * invokes the appropriate error response.
+ */
+__cold
+void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
+		       unsigned int line, int error, const char *fmt, ...)
+{
+	struct super_block *sb = fs_info->sb;
+#ifdef CONFIG_PRINTK
+	char statestr[STATE_STRING_BUF_LEN];
+	const char *errstr;
+#endif
+
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit(
+		"BTRFS: error (device %s%s) in %s:%d: error=%d %s", KERN_CRIT, fmt);
+#endif
+
+	/*
+	 * Special case: if the error is EROFS, and we're already under
+	 * SB_RDONLY, then it is safe here.
+	 */
+	if (error == -EROFS && sb_rdonly(sb))
+		return;
+
+#ifdef CONFIG_PRINTK
+	errstr = btrfs_decode_error(error);
+	btrfs_state_to_string(fs_info, statestr);
+	if (fmt) {
+		struct va_format vaf;
+		va_list args;
+
+		va_start(args, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: error=%d %s (%pV)\n",
+			sb->s_id, statestr, function, line, error, errstr, &vaf);
+		va_end(args);
+	} else {
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: error=%d %s\n",
+			sb->s_id, statestr, function, line, error, errstr);
+	}
+#endif
+
+	/*
+	 * We don't have fs_info::fs_state yet, and the rest of this is more
+	 * kernel related cleanup, so for now comment it out.
+	 */
+#if 0
+	/*
+	 * Today we only save the error info to memory.  Long term we'll also
+	 * send it down to the disk.
+	 */
+	set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+
+	/* Don't go through full error handling during mount. */
+	if (!(sb->s_flags & SB_BORN))
+		return;
+
+	if (sb_rdonly(sb))
+		return;
+
+	btrfs_discard_stop(fs_info);
+
+	/* Handle error by forcing the filesystem readonly. */
+	btrfs_set_sb_rdonly(sb);
+#endif
+
+	btrfs_info(fs_info, "forced readonly");
+	/*
+	 * Note that a running device replace operation is not canceled here
+	 * although there is no way to update the progress. It would add the
+	 * risk of a deadlock, therefore the canceling is omitted. The only
+	 * penalty is that some I/O remains active until the procedure
+	 * completes. The next time when the filesystem is mounted writable
+	 * again, the device replace operation continues.
+	 */
+}
+
+#ifdef CONFIG_PRINTK
+static const char * const logtypes[] = {
+	"emergency",
+	"alert",
+	"critical",
+	"error",
+	"warning",
+	"notice",
+	"info",
+	"debug",
+};
+
+/*
+ * Use one ratelimit state per log level so that a flood of less important
+ * messages doesn't cause more important ones to be dropped.
+ */
+static struct ratelimit_state printk_limits[] = {
+	RATELIMIT_STATE_INIT(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL, 100),
+	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
+};
+
+void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
+	struct va_format vaf;
+	va_list args;
+	int kern_level;
+	const char *type = logtypes[4];
+	struct ratelimit_state *ratelimit = &printk_limits[4];
+
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
+#endif
+
+	va_start(args, fmt);
+
+	while ((kern_level = printk_get_level(fmt)) != 0) {
+		size_t size = printk_skip_level(fmt) - fmt;
+
+		if (kern_level >= '0' && kern_level <= '7') {
+			memcpy(lvl, fmt,  size);
+			lvl[size] = '\0';
+			type = logtypes[kern_level - '0'];
+			ratelimit = &printk_limits[kern_level - '0'];
+		}
+		fmt += size;
+	}
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	if (__ratelimit(ratelimit)) {
+		if (fs_info) {
+			char statestr[STATE_STRING_BUF_LEN];
+
+			btrfs_state_to_string(fs_info, statestr);
+			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
+				fs_info->sb->s_id, statestr, &vaf);
+		} else {
+			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+		}
+	}
+
+	va_end(args);
+}
+#endif
+
+#ifdef CONFIG_BTRFS_ASSERT
+void __cold btrfs_assertfail(const char *expr, const char *file, int line)
+{
+	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
+	BUG();
+}
+#endif
+
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
+{
+	btrfs_err(fs_info,
+"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
+}
+
+#if BITS_PER_LONG == 32
+void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
+		btrfs_warn(fs_info, "reaching 32bit limit for logical addresses");
+		btrfs_warn(fs_info,
+"due to page cache limit on 32bit systems, btrfs can't access metadata at or beyond %lluT",
+			   BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_warn(fs_info,
+			   "please consider upgrading to 64bit kernel/hardware");
+	}
+}
+
+void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
+{
+	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
+		btrfs_err(fs_info, "reached 32bit limit for logical addresses");
+		btrfs_err(fs_info,
+"due to page cache limit on 32bit systems, metadata beyond %lluT can't be accessed",
+			  BTRFS_32BIT_MAX_FILE_SIZE >> 40);
+		btrfs_err(fs_info,
+			   "please consider upgrading to 64bit kernel/hardware");
+	}
+}
+#endif
+
+/*
+ * __btrfs_panic decodes unexpected, fatal errors from the caller, issues an
+ * alert, and either panics or BUGs, depending on mount options.
+ *
+ * MODIFIED:
+ *  - We don't have btrfs_test_opt() yet, kill that and s_id.
+ */
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int error, const char *fmt, ...)
+{
+	const char *errstr;
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+#if 0
+	char *s_id = "<unknown>";
+
+	if (fs_info)
+		s_id = fs_info->sb->s_id;
+#endif
+
+	va_start(args, fmt);
+	vaf.va = &args;
+
+	errstr = btrfs_decode_error(error);
+#if 0
+	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
+		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (error=%d %s)\n",
+			s_id, function, line, &vaf, error, errstr);
+#endif
+
+	btrfs_crit(fs_info, "panic in %s:%d: %pV (error=%d %s)",
+		   function, line, &vaf, error, errstr);
+	va_end(args);
+	/* Caller calls BUG() */
+}
diff --git a/kernel-shared/messages.h b/kernel-shared/messages.h
new file mode 100644
index 00000000..879cbf95
--- /dev/null
+++ b/kernel-shared/messages.h
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_MESSAGES_H
+#define BTRFS_MESSAGES_H
+
+#include "kerncompat.h"
+#include "common/messages.h"
+#include <linux/types.h>
+
+struct btrfs_fs_info;
+struct btrfs_trans_handle;
+
+#ifdef __KERNEL__
+static inline __printf(2, 3) __cold
+void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+{
+}
+#endif
+
+#ifdef CONFIG_PRINTK
+
+#define btrfs_printk(fs_info, fmt, args...)				\
+	_btrfs_printk(fs_info, fmt, ##args)
+
+__printf(2, 3)
+__cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+
+#else
+
+#define btrfs_printk(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, fmt, ##args)
+#endif
+
+#define btrfs_emerg(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use printk_in_rcu
+ */
+#define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk_in_rcu
+ */
+#define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
+
+/*
+ * Wrappers that use a ratelimited printk
+ */
+#define btrfs_emerg_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_EMERG fmt, ##args)
+#define btrfs_alert_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ALERT fmt, ##args)
+#define btrfs_crit_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
+#define btrfs_err_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
+#define btrfs_warn_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
+#define btrfs_notice_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_NOTICE fmt, ##args)
+#define btrfs_info_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#define btrfs_debug(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk,			\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...)			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...)				\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_ratelimited,	\
+				   fs_info, KERN_DEBUG fmt, ##args)
+#elif defined(DEBUG)
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_printk_ratelimited(fs_info, KERN_DEBUG fmt, ##args)
+#else
+#define btrfs_debug(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+#define btrfs_debug_rl(fs_info, fmt, args...) \
+	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+#endif
+
+#define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_no_printk_in_rcu(fs_info, fmt, args...)	\
+do {							\
+	rcu_read_lock();				\
+	btrfs_no_printk(fs_info, fmt, ##args);		\
+	rcu_read_unlock();				\
+} while (0)
+
+#define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
+do {								\
+	static DEFINE_RATELIMIT_STATE(_rs,			\
+		DEFAULT_RATELIMIT_INTERVAL,			\
+		DEFAULT_RATELIMIT_BURST);			\
+	if (__ratelimit(&_rs))					\
+		btrfs_printk(fs_info, fmt, ##args);		\
+} while (0)
+
+#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
+do {								\
+	rcu_read_lock();					\
+	btrfs_printk_ratelimited(fs_info, fmt, ##args);		\
+	rcu_read_unlock();					\
+} while (0)
+
+#ifdef CONFIG_BTRFS_ASSERT
+void __cold btrfs_assertfail(const char *expr, const char *file, int line);
+
+#define ASSERT(expr)						\
+	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
+#else
+#define ASSERT(expr)	(void)(expr)
+#endif
+
+void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info);
+
+__printf(5, 6)
+__cold
+void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
+		     unsigned int line, int error, const char *fmt, ...);
+
+const char * __attribute_const__ btrfs_decode_error(int error);
+
+#define btrfs_handle_fs_error(fs_info, error, fmt, args...)		\
+	__btrfs_handle_fs_error((fs_info), __func__, __LINE__,		\
+				(error), fmt, ##args)
+
+__printf(5, 6)
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int error, const char *fmt, ...);
+/*
+ * If BTRFS_MOUNT_PANIC_ON_FATAL_ERROR is in mount_opt, __btrfs_panic
+ * will panic().  Otherwise we BUG() here.
+ */
+#define btrfs_panic(fs_info, error, fmt, args...)			\
+do {									\
+	__btrfs_panic(fs_info, __func__, __LINE__, error, fmt, ##args);	\
+	BUG();								\
+} while (0)
+
+#if BITS_PER_LONG == 32
+#define BTRFS_32BIT_MAX_FILE_SIZE (((u64)ULONG_MAX + 1) << PAGE_SHIFT)
+/*
+ * The warning threshold is 5/8th of the MAX_LFS_FILESIZE that limits the logical
+ * addresses of extents.
+ *
+ * For 4K page size it's about 10T, for 64K it's 160T.
+ */
+#define BTRFS_32BIT_EARLY_WARN_THRESHOLD (BTRFS_32BIT_MAX_FILE_SIZE * 5 / 8)
+void btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info);
+void btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info);
+#endif
+
+#endif
diff --git a/kernel-shared/ulist.c b/kernel-shared/ulist.c
index e193b02d..0cd4f74f 100644
--- a/kernel-shared/ulist.c
+++ b/kernel-shared/ulist.c
@@ -21,6 +21,7 @@
 #include "kerncompat.h"
 #include "ulist.h"
 #include "kernel-shared/ctree.h"
+#include "messages.h"
 
 /*
  * ulist is a generic data structure to hold a collection of unique u64
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index 770f5889..2fbe1802 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -22,6 +22,7 @@
 #include <stdbool.h>
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/volumes.h"
+#include "messages.h"
 
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
diff --git a/libbtrfs/kerncompat.h b/libbtrfs/kerncompat.h
index f7598627..a8ba07f0 100644
--- a/libbtrfs/kerncompat.h
+++ b/libbtrfs/kerncompat.h
@@ -325,26 +325,6 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define memalloc_nofs_save() (0)
 #define memalloc_nofs_restore(x)	((void)(x))
 
-#ifndef BTRFS_DISABLE_BACKTRACE
-static inline void assert_trace(const char *assertion, const char *filename,
-			      const char *func, unsigned line, long val)
-{
-	if (val)
-		return;
-	fprintf(stderr,
-		"%s:%d: %s: Assertion `%s` failed, value %ld\n",
-		filename, line, func, assertion, val);
-#ifndef BTRFS_DISABLE_BACKTRACE
-	print_trace();
-#endif
-	abort();
-	exit(1);
-}
-#define	ASSERT(c) assert_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
-#else
-#define ASSERT(c) assert(c)
-#endif
-
 #define BUG_ON(c) bugon_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 #define BUG()				\
 do {					\
-- 
2.40.0

