Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9260E8B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Oct 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiJZTLq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Oct 2022 15:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiJZTL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Oct 2022 15:11:26 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67D13C1C3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:52 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ml12so11374110qvb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Oct 2022 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gOM9+GM+/6W05CQRWo3dpyYMifpxOjFcoRuJWla3JBg=;
        b=71Ola6y79UPEz/FRSVE8bNyWUHsSVk/rHxSs1dKdmOye7t708he0Vbq+D4OhVfjzEG
         zVPHCMwpLmi+uHjpUCP57hukiAJavfoo5AqciE7qn9njh2jFVxcmK5J/tEH06a0rs6qX
         9Sv7nWLZ/Yr4A/gconp86DQRkB07SfrgMkVkjLTNeY2F6OIbvJ/YRdXi1rsGJAIv5NiM
         FO9w4Jjrd9lXoYEJnuoIYJlg6GOnjvZ3HPwCQpDDSeE0/+X65YUAVrnjVFjS7lh4u8pP
         PdMtyuowcEsqb9gu8p53h3IqQXxfXfx8u7Vf1dfVf/XGhRuP3xcnjynfNGpl6X+iQIO9
         a8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOM9+GM+/6W05CQRWo3dpyYMifpxOjFcoRuJWla3JBg=;
        b=jQG7iAeqQO9Ogt1O/ekZWCPX/OqGeL5oYSuocVVLpLQbYOLDar+WRaITwLUEabmbIk
         PMioxIDLPZiFxxQvSdIJkz2wdxelvRq8rM+QRbJyeQEt4JKfUT42wD1jgnNvt4CfO6KN
         K+30BUBDTD9pPvsqmVFbhnsHARlY9h/Nb6mjua/X0+hJFHdLkcGGCfJpBO1m11RhDkCd
         kM1KE7ccKRn2eiqT+dyPZ8xijV9pBbZ4fjsds81HHCi0JOJ1e7vXuOlUh5yGwD1Rhxws
         K7Lx0OfVniIFupaW8Q0uL4pusLH2mIjde+vx0ZdXoI2uPz2PQbbf0OXB27LyIdACEb3p
         /pDQ==
X-Gm-Message-State: ACrzQf2fEyr3+ceuEvpTJAeiQo0ZjoERz6XVLbxGwAjHcOk9LgQtVqgp
        3Bv43S6ym2eJeq2HAh4BRYrVGBkWble/Vg==
X-Google-Smtp-Source: AMsMyM4kp4jIZ+2vj8hCThW/bl2XAKkH3qAlNPZnS9TVfY7440w9AN1shQu02ShrZJRFd+z0jHtTVg==
X-Received: by 2002:a05:6214:768:b0:4b3:91e1:a43c with SMTP id f8-20020a056214076800b004b391e1a43cmr38394408qvz.19.1666811330475;
        Wed, 26 Oct 2022 12:08:50 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bq32-20020a05620a46a000b006f7ee901674sm3159964qkb.2.2022.10.26.12.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:08:50 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/26] btrfs: move the printk and assert helpers to messages.c
Date:   Wed, 26 Oct 2022 15:08:20 -0400
Message-Id: <051b9887171d14d8d5eb30d3274a946427ed3c69.1666811038.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666811038.git.josef@toxicpanda.com>
References: <cover.1666811038.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These helpers are core to btrfs, and in order to more easily sync
various parts of the btrfs kernel code into btrfs-progs we need to be
able to carry these helpers with us.  However we want to have our own
implementation for the helpers themselves, currently they're implemented
in different files that we want to sync inside of btrfs-progs itself.
Move these into their own C file, this will allow us to contain our
overrides in btrfs-progs in it's own file without messing with the rest
of the codebase.

In copying things over I fixed up a few whitespace errors that already
existed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile   |   2 +-
 fs/btrfs/messages.c | 352 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/super.c    | 346 -------------------------------------------
 3 files changed, 353 insertions(+), 347 deletions(-)
 create mode 100644 fs/btrfs/messages.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 76f90dcfb14d..bb170c9d030d 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o extent-io-tree.o fs.o
+	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
new file mode 100644
index 000000000000..a94a213da02e
--- /dev/null
+++ b/fs/btrfs/messages.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "fs.h"
+#include "messages.h"
+#include "discard.h"
+#include "transaction.h"
+#include "space-info.h"
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
+const char * __attribute_const__ btrfs_decode_error(int errno)
+{
+	char *errstr = "unknown";
+
+	switch (errno) {
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
+		       unsigned int line, int errno, const char *fmt, ...)
+{
+	struct super_block *sb = fs_info->sb;
+#ifdef CONFIG_PRINTK
+	char statestr[STATE_STRING_BUF_LEN];
+	const char *errstr;
+#endif
+
+#ifdef CONFIG_PRINTK_INDEX
+	printk_index_subsys_emit(
+		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",
+		KERN_CRIT, fmt);
+#endif
+
+	/*
+	 * Special case: if the error is EROFS, and we're already
+	 * under SB_RDONLY, then it is safe here.
+	 */
+	if (errno == -EROFS && sb_rdonly(sb))
+		return;
+
+#ifdef CONFIG_PRINTK
+	errstr = btrfs_decode_error(errno);
+	btrfs_state_to_string(fs_info, statestr);
+	if (fmt) {
+		struct va_format vaf;
+		va_list args;
+
+		va_start(args, fmt);
+		vaf.fmt = fmt;
+		vaf.va = &args;
+
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
+			sb->s_id, statestr, function, line, errno, errstr, &vaf);
+		va_end(args);
+	} else {
+		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
+			sb->s_id, statestr, function, line, errno, errstr);
+	}
+#endif
+
+	/*
+	 * Today we only save the error info to memory.  Long term we'll
+	 * also send it down to the disk
+	 */
+	set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+
+	/* Don't go through full error handling during mount */
+	if (!(sb->s_flags & SB_BORN))
+		return;
+
+	if (sb_rdonly(sb))
+		return;
+
+	btrfs_discard_stop(fs_info);
+
+	/* btrfs handle error by forcing the filesystem readonly */
+	btrfs_set_sb_rdonly(sb);
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
+ * We only mark the transaction aborted and then set the file system read-only.
+ * This will prevent new transactions from starting or trying to join this
+ * one.
+ *
+ * This means that error recovery at the call site is limited to freeing
+ * any local memory allocations and passing the error code up without
+ * further cleanup. The transaction should complete as it normally would
+ * in the call path but will return -EIO.
+ *
+ * We'll complete the cleanup in btrfs_end_transaction and
+ * btrfs_commit_transaction.
+ */
+__cold
+void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
+			       const char *function,
+			       unsigned int line, int errno, bool first_hit)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+
+	WRITE_ONCE(trans->aborted, errno);
+	WRITE_ONCE(trans->transaction->aborted, errno);
+	if (first_hit && errno == -ENOSPC)
+		btrfs_dump_space_info_for_trans_abort(fs_info);
+	/* Wake up anybody who may be waiting on this transaction */
+	wake_up(&fs_info->transaction_wait);
+	wake_up(&fs_info->transaction_blocked_wait);
+	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
+}
+/*
+ * __btrfs_panic decodes unexpected, fatal errors from the caller,
+ * issues an alert, and either panics or BUGs, depending on mount options.
+ */
+__cold
+void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
+		   unsigned int line, int errno, const char *fmt, ...)
+{
+	char *s_id = "<unknown>";
+	const char *errstr;
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+
+	if (fs_info)
+		s_id = fs_info->sb->s_id;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+
+	errstr = btrfs_decode_error(errno);
+	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
+		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (errno=%d %s)\n",
+			s_id, function, line, &vaf, errno, errstr);
+
+	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=%d %s)",
+		   function, line, &vaf, errno, errstr);
+	va_end(args);
+	/* Caller calls BUG() */
+}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 33bf211699f8..a4030dfeb2f2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -70,352 +70,6 @@ static struct file_system_type btrfs_root_fs_type;
 
 static int btrfs_remount(struct super_block *sb, int *flags, char *data);
 
-#ifdef CONFIG_PRINTK
-
-#define STATE_STRING_PREFACE	": state "
-#define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT)
-
-/*
- * Characters to print to indicate error conditions or uncommon filesystem state.
- * RO is not an error.
- */
-static const char fs_state_chars[] = {
-	[BTRFS_FS_STATE_ERROR]			= 'E',
-	[BTRFS_FS_STATE_REMOUNTING]		= 'M',
-	[BTRFS_FS_STATE_RO]			= 0,
-	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
-	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
-	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
-	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
-	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
-};
-
-static void btrfs_state_to_string(const struct btrfs_fs_info *info, char *buf)
-{
-	unsigned int bit;
-	bool states_printed = false;
-	unsigned long fs_state = READ_ONCE(info->fs_state);
-	char *curr = buf;
-
-	memcpy(curr, STATE_STRING_PREFACE, sizeof(STATE_STRING_PREFACE));
-	curr += sizeof(STATE_STRING_PREFACE) - 1;
-
-	for_each_set_bit(bit, &fs_state, sizeof(fs_state)) {
-		WARN_ON_ONCE(bit >= BTRFS_FS_STATE_COUNT);
-		if ((bit < BTRFS_FS_STATE_COUNT) && fs_state_chars[bit]) {
-			*curr++ = fs_state_chars[bit];
-			states_printed = true;
-		}
-	}
-
-	/* If no states were printed, reset the buffer */
-	if (!states_printed)
-		curr = buf;
-
-	*curr++ = 0;
-}
-#endif
-
-/*
- * Generally the error codes correspond to their respective errors, but there
- * are a few special cases.
- *
- * EUCLEAN: Any sort of corruption that we encounter.  The tree-checker for
- *          instance will return EUCLEAN if any of the blocks are corrupted in
- *          a way that is problematic.  We want to reserve EUCLEAN for these
- *          sort of corruptions.
- *
- * EROFS: If we check BTRFS_FS_STATE_ERROR and fail out with a return error, we
- *        need to use EROFS for this case.  We will have no idea of the
- *        original failure, that will have been reported at the time we tripped
- *        over the error.  Each subsequent error that doesn't have any context
- *        of the original error should use EROFS when handling BTRFS_FS_STATE_ERROR.
- */
-const char * __attribute_const__ btrfs_decode_error(int errno)
-{
-	char *errstr = "unknown";
-
-	switch (errno) {
-	case -ENOENT:		/* -2 */
-		errstr = "No such entry";
-		break;
-	case -EIO:		/* -5 */
-		errstr = "IO failure";
-		break;
-	case -ENOMEM:		/* -12*/
-		errstr = "Out of memory";
-		break;
-	case -EEXIST:		/* -17 */
-		errstr = "Object already exists";
-		break;
-	case -ENOSPC:		/* -28 */
-		errstr = "No space left";
-		break;
-	case -EROFS:		/* -30 */
-		errstr = "Readonly filesystem";
-		break;
-	case -EOPNOTSUPP:	/* -95 */
-		errstr = "Operation not supported";
-		break;
-	case -EUCLEAN:		/* -117 */
-		errstr = "Filesystem corrupted";
-		break;
-	case -EDQUOT:		/* -122 */
-		errstr = "Quota exceeded";
-		break;
-	}
-
-	return errstr;
-}
-
-/*
- * __btrfs_handle_fs_error decodes expected errors from the caller and
- * invokes the appropriate error response.
- */
-__cold
-void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-		       unsigned int line, int errno, const char *fmt, ...)
-{
-	struct super_block *sb = fs_info->sb;
-#ifdef CONFIG_PRINTK
-	char statestr[STATE_STRING_BUF_LEN];
-	const char *errstr;
-#endif
-
-#ifdef CONFIG_PRINTK_INDEX
-	printk_index_subsys_emit(
-		"BTRFS: error (device %s%s) in %s:%d: errno=%d %s",
-		KERN_CRIT, fmt);
-#endif
-
-	/*
-	 * Special case: if the error is EROFS, and we're already
-	 * under SB_RDONLY, then it is safe here.
-	 */
-	if (errno == -EROFS && sb_rdonly(sb))
-  		return;
-
-#ifdef CONFIG_PRINTK
-	errstr = btrfs_decode_error(errno);
-	btrfs_state_to_string(fs_info, statestr);
-	if (fmt) {
-		struct va_format vaf;
-		va_list args;
-
-		va_start(args, fmt);
-		vaf.fmt = fmt;
-		vaf.va = &args;
-
-		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s (%pV)\n",
-			sb->s_id, statestr, function, line, errno, errstr, &vaf);
-		va_end(args);
-	} else {
-		pr_crit("BTRFS: error (device %s%s) in %s:%d: errno=%d %s\n",
-			sb->s_id, statestr, function, line, errno, errstr);
-	}
-#endif
-
-	/*
-	 * Today we only save the error info to memory.  Long term we'll
-	 * also send it down to the disk
-	 */
-	set_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
-
-	/* Don't go through full error handling during mount */
-	if (!(sb->s_flags & SB_BORN))
-		return;
-
-	if (sb_rdonly(sb))
-		return;
-
-	btrfs_discard_stop(fs_info);
-
-	/* btrfs handle error by forcing the filesystem readonly */
-	btrfs_set_sb_rdonly(sb);
-	btrfs_info(fs_info, "forced readonly");
-	/*
-	 * Note that a running device replace operation is not canceled here
-	 * although there is no way to update the progress. It would add the
-	 * risk of a deadlock, therefore the canceling is omitted. The only
-	 * penalty is that some I/O remains active until the procedure
-	 * completes. The next time when the filesystem is mounted writable
-	 * again, the device replace operation continues.
-	 */
-}
-
-#ifdef CONFIG_PRINTK
-static const char * const logtypes[] = {
-	"emergency",
-	"alert",
-	"critical",
-	"error",
-	"warning",
-	"notice",
-	"info",
-	"debug",
-};
-
-
-/*
- * Use one ratelimit state per log level so that a flood of less important
- * messages doesn't cause more important ones to be dropped.
- */
-static struct ratelimit_state printk_limits[] = {
-	RATELIMIT_STATE_INIT(printk_limits[0], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[1], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[2], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[3], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[4], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[5], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[6], DEFAULT_RATELIMIT_INTERVAL, 100),
-	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
-};
-
-void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
-{
-	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
-	struct va_format vaf;
-	va_list args;
-	int kern_level;
-	const char *type = logtypes[4];
-	struct ratelimit_state *ratelimit = &printk_limits[4];
-
-#ifdef CONFIG_PRINTK_INDEX
-	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
-#endif
-
-	va_start(args, fmt);
-
-	while ((kern_level = printk_get_level(fmt)) != 0) {
-		size_t size = printk_skip_level(fmt) - fmt;
-
-		if (kern_level >= '0' && kern_level <= '7') {
-			memcpy(lvl, fmt,  size);
-			lvl[size] = '\0';
-			type = logtypes[kern_level - '0'];
-			ratelimit = &printk_limits[kern_level - '0'];
-		}
-		fmt += size;
-	}
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	if (__ratelimit(ratelimit)) {
-		if (fs_info) {
-			char statestr[STATE_STRING_BUF_LEN];
-
-			btrfs_state_to_string(fs_info, statestr);
-			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
-				fs_info->sb->s_id, statestr, &vaf);
-		} else {
-			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
-		}
-	}
-
-	va_end(args);
-}
-#endif
-
-#ifdef CONFIG_BTRFS_ASSERT
-void __cold btrfs_assertfail(const char *expr, const char *file, int line)
-{
-	pr_err("assertion failed: %s, in %s:%d\n", expr, file, line);
-	BUG();
-}
-#endif
-
-void __cold btrfs_print_v0_err(struct btrfs_fs_info *fs_info)
-{
-	btrfs_err(fs_info,
-"Unsupported V0 extent filesystem detected. Aborting. Please re-create your filesystem with a newer kernel");
-}
-
-#if BITS_PER_LONG == 32
-void __cold btrfs_warn_32bit_limit(struct btrfs_fs_info *fs_info)
-{
-	if (!test_and_set_bit(BTRFS_FS_32BIT_WARN, &fs_info->flags)) {
-		btrfs_warn(fs_info, "reaching 32bit limit for logical addresses");
-		btrfs_warn(fs_info,
-"due to page cache limit on 32bit systems, btrfs can't access metadata at or beyond %lluT",
-			   BTRFS_32BIT_MAX_FILE_SIZE >> 40);
-		btrfs_warn(fs_info,
-			   "please consider upgrading to 64bit kernel/hardware");
-	}
-}
-
-void __cold btrfs_err_32bit_limit(struct btrfs_fs_info *fs_info)
-{
-	if (!test_and_set_bit(BTRFS_FS_32BIT_ERROR, &fs_info->flags)) {
-		btrfs_err(fs_info, "reached 32bit limit for logical addresses");
-		btrfs_err(fs_info,
-"due to page cache limit on 32bit systems, metadata beyond %lluT can't be accessed",
-			  BTRFS_32BIT_MAX_FILE_SIZE >> 40);
-		btrfs_err(fs_info,
-			   "please consider upgrading to 64bit kernel/hardware");
-	}
-}
-#endif
-
-/*
- * We only mark the transaction aborted and then set the file system read-only.
- * This will prevent new transactions from starting or trying to join this
- * one.
- *
- * This means that error recovery at the call site is limited to freeing
- * any local memory allocations and passing the error code up without
- * further cleanup. The transaction should complete as it normally would
- * in the call path but will return -EIO.
- *
- * We'll complete the cleanup in btrfs_end_transaction and
- * btrfs_commit_transaction.
- */
-__cold
-void __btrfs_abort_transaction(struct btrfs_trans_handle *trans,
-			       const char *function,
-			       unsigned int line, int errno, bool first_hit)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-
-	WRITE_ONCE(trans->aborted, errno);
-	WRITE_ONCE(trans->transaction->aborted, errno);
-	if (first_hit && errno == -ENOSPC)
-		btrfs_dump_space_info_for_trans_abort(fs_info);
-	/* Wake up anybody who may be waiting on this transaction */
-	wake_up(&fs_info->transaction_wait);
-	wake_up(&fs_info->transaction_blocked_wait);
-	__btrfs_handle_fs_error(fs_info, function, line, errno, NULL);
-}
-/*
- * __btrfs_panic decodes unexpected, fatal errors from the caller,
- * issues an alert, and either panics or BUGs, depending on mount options.
- */
-__cold
-void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
-		   unsigned int line, int errno, const char *fmt, ...)
-{
-	char *s_id = "<unknown>";
-	const char *errstr;
-	struct va_format vaf = { .fmt = fmt };
-	va_list args;
-
-	if (fs_info)
-		s_id = fs_info->sb->s_id;
-
-	va_start(args, fmt);
-	vaf.va = &args;
-
-	errstr = btrfs_decode_error(errno);
-	if (fs_info && (btrfs_test_opt(fs_info, PANIC_ON_FATAL_ERROR)))
-		panic(KERN_CRIT "BTRFS panic (device %s) in %s:%d: %pV (errno=%d %s)\n",
-			s_id, function, line, &vaf, errno, errstr);
-
-	btrfs_crit(fs_info, "panic in %s:%d: %pV (errno=%d %s)",
-		   function, line, &vaf, errno, errstr);
-	va_end(args);
-	/* Caller calls BUG() */
-}
-
 static void btrfs_put_super(struct super_block *sb)
 {
 	close_ctree(btrfs_sb(sb));
-- 
2.26.3

