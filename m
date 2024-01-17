Return-Path: <linux-btrfs+bounces-1541-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92216831011
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 00:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B728C692
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 23:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98687288D8;
	Wed, 17 Jan 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OaIWEEt6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OaIWEEt6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA072563F
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533451; cv=none; b=N/tj3WeWcMwLVYuU6S0lCShsnia9C2Chpu08XBAQahmE/vfpyhjbGeWUIxKIxbIlpgXklTJB4CT/9pgppZCs4mxKjC2cBSVscmrKkWlI0j9ftQa41Jl1fj81CXfc3TTiQm2rZsXjFGv8KrcsWNSF8YjTtiUwZfvKTNyU9P0hQ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533451; c=relaxed/simple;
	bh=YGsyv+Dwbd0nQKwBzMMGqvmJ679ty9t/niCkXGsAXqQ=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Flag:X-Spamd-Bar; b=VeYGC67SQKk5brWz2zNWWpR6i7nEh56lvWJIdMNCTuCFXhqXfn334FRNp6sxuiZcJm8J+5QkMPoCBrwSWAg/6HyYlED+olS4vg0166rh2cAN8MIjGuYlqUwNUYQ5J1Tzy0YrqlEXl9Dk1JQSd30rlkaxSomeWzEvPFmuHptwYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OaIWEEt6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OaIWEEt6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C5C701F445;
	Wed, 17 Jan 2024 23:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAQ8RBgvv6PPbtJms7ueZJ5JEuGwhJIxa4Z9LHU7NfY=;
	b=OaIWEEt6Pxgywulw58XxD2NPfyIi65DUSKzVSm+Fp4u/Gn1vOAX7Zij9VHVBS5W+WY1++v
	xcZwWn3NM9FkhuSG0i/DTWTH9qzMg+Pca4epWonqcLPwD9d7XNstFQA2Qvp0x+1g2i7AzV
	nbhq5IFUgprgg3ArdOOsg1flELXdVTY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bAQ8RBgvv6PPbtJms7ueZJ5JEuGwhJIxa4Z9LHU7NfY=;
	b=OaIWEEt6Pxgywulw58XxD2NPfyIi65DUSKzVSm+Fp4u/Gn1vOAX7Zij9VHVBS5W+WY1++v
	xcZwWn3NM9FkhuSG0i/DTWTH9qzMg+Pca4epWonqcLPwD9d7XNstFQA2Qvp0x+1g2i7AzV
	nbhq5IFUgprgg3ArdOOsg1flELXdVTY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6EB113800;
	Wed, 17 Jan 2024 23:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GKMtIQZgqGVxIQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Jan 2024 23:17:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 2/2] btrfs-progs: implement arg_strtou64_with_suffix() with a new helper
Date: Thu, 18 Jan 2024 09:47:02 +1030
Message-ID: <cbc24cb5d6f4d2e7632ca43ceed2386de2d82670.1705533399.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705533399.git.wqu@suse.com>
References: <cover.1705533399.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OaIWEEt6
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: C5C701F445
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

This patch introduces a new parser helper, parse_u64_with_suffix(),
which has a better error handling, following all the parse_*()
helpers to return non-zero value for errors.

This new helper is going to replace parse_size_from_string(), which
would directly call exit(1) to stop the whole program.

Furthermore most callers of parse_size_from_string() are expecting
exit(1) for error, so that they can skip the error handling.

For those call sites, introduce a wrapper, arg_strtou64_with_suffix(),
to do that.  The only disadvantage is a little less detailed error
report for why the parse failed, but for most cases the generic error
string should be enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/filesystem.c     | 15 ++++-----
 cmds/qgroup.c         |  3 +-
 cmds/reflink.c        |  7 +++--
 cmds/scrub.c          |  2 +-
 common/parse-utils.c  | 71 ++++++++++++++++++++++++-------------------
 common/parse-utils.h  |  2 +-
 common/string-utils.c | 19 ++++++++++++
 common/string-utils.h |  7 +++++
 convert/main.c        |  3 +-
 kernel-shared/zoned.c |  4 +--
 mkfs/main.c           |  6 ++--
 11 files changed, 88 insertions(+), 51 deletions(-)

diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 1b444b8f6c07..e0e74fbe6d6e 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -53,6 +53,7 @@
 #include "common/device-utils.h"
 #include "common/open-utils.h"
 #include "common/parse-utils.h"
+#include "common/string-utils.h"
 #include "common/filesystem-utils.h"
 #include "common/format-output.h"
 #include "cmds/commands.h"
@@ -1065,13 +1066,13 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 				bconf_be_verbose();
 			break;
 		case 's':
-			start = parse_size_from_string(optarg);
+			start = arg_strtou64_with_suffix(optarg);
 			break;
 		case 'l':
-			len = parse_size_from_string(optarg);
+			len = arg_strtou64_with_suffix(optarg);
 			break;
 		case 't':
-			thresh = parse_size_from_string(optarg);
+			thresh = arg_strtou64_with_suffix(optarg);
 			if (thresh > (u32)-1) {
 				warning(
 			    "target extent size %llu too big, trimmed to %u",
@@ -1083,7 +1084,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			recursive = true;
 			break;
 		case GETOPT_VAL_STEP:
-			defrag_global_step = parse_size_from_string(optarg);
+			defrag_global_step = arg_strtou64_with_suffix(optarg);
 			if (defrag_global_step < SZ_256K) {
 				warning("step %llu too small, adjusting to 256KiB\n",
 					   defrag_global_step);
@@ -1312,8 +1313,8 @@ static int check_resize_args(const char *amount, const char *path, u64 *devid_re
 			mod = 1;
 			sizestr++;
 		}
-		diff = parse_size_from_string(sizestr);
-		if (!diff) {
+		ret = parse_u64_with_suffix(sizestr, &diff);
+		if (ret < 0) {
 			error("failed to parse size %s", sizestr);
 			ret = 1;
 			goto out;
@@ -1605,7 +1606,7 @@ static int cmd_filesystem_mkswapfile(const struct cmd_struct *cmd, int argc, cha
 
 		switch (c) {
 		case 's':
-			size = parse_size_from_string(optarg);
+			size = arg_strtou64_with_suffix(optarg);
 			/* Minimum limit reported by mkswap */
 			if (size < 40 * SZ_1K) {
 				error("swapfile needs to be at least 40 KiB");
diff --git a/cmds/qgroup.c b/cmds/qgroup.c
index 2f1893cbe6e5..68791428b25f 100644
--- a/cmds/qgroup.c
+++ b/cmds/qgroup.c
@@ -40,6 +40,7 @@
 #include "common/help.h"
 #include "common/units.h"
 #include "common/parse-utils.h"
+#include "common/string-utils.h"
 #include "common/format-output.h"
 #include "common/messages.h"
 #include "cmds/commands.h"
@@ -2114,7 +2115,7 @@ static int cmd_qgroup_limit(const struct cmd_struct *cmd, int argc, char **argv)
 	if (!strcasecmp(argv[optind], "none"))
 		size = -1ULL;
 	else
-		size = parse_size_from_string(argv[optind]);
+		size = arg_strtou64_with_suffix(argv[optind]);
 
 	memset(&args, 0, sizeof(args));
 	if (compressed)
diff --git a/cmds/reflink.c b/cmds/reflink.c
index 867a5bd2ac0a..2884ba9159e6 100644
--- a/cmds/reflink.c
+++ b/cmds/reflink.c
@@ -25,6 +25,7 @@
 #include "common/messages.h"
 #include "common/open-utils.h"
 #include "common/parse-utils.h"
+#include "common/string-utils.h"
 #include "common/help.h"
 #include "cmds/commands.h"
 
@@ -76,7 +77,7 @@ static void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to
 		error("wrong range spec near %s", str);
 		exit(1);
 	}
-	*from = parse_size_from_string(tmp);
+	*from = arg_strtou64_with_suffix(tmp);
 	str++;
 
 	/* Parse length */
@@ -91,11 +92,11 @@ static void parse_reflink_range(const char *str, u64 *from, u64 *length, u64 *to
 		error("wrong range spec near %s", str);
 		exit(1);
 	}
-	*length = parse_size_from_string(tmp);
+	*length = arg_strtou64_with_suffix(tmp);
 	str++;
 
 	/* Parse to, until end of string */
-	*to = parse_size_from_string(str);
+	*to = arg_strtou64_with_suffix(str);
 }
 
 static int reflink_apply_range(int fd_in, int fd_out, const struct reflink_range *range)
diff --git a/cmds/scrub.c b/cmds/scrub.c
index f4c963d705bd..e105ecb2fa5d 100644
--- a/cmds/scrub.c
+++ b/cmds/scrub.c
@@ -2035,7 +2035,7 @@ static int cmd_scrub_limit(const struct cmd_struct *cmd, int argc, char **argv)
 			devid_set = true;
 			break;
 		case 'l':
-			opt_limit = parse_size_from_string(optarg);
+			opt_limit = arg_strtou64_with_suffix(optarg);
 			limit_set = true;
 			break;
 		default:
diff --git a/common/parse-utils.c b/common/parse-utils.c
index 9b34f95d64df..2dcb0818e1af 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -160,40 +160,45 @@ int parse_range_strict(const char *range, u64 *start, u64 *end)
 	return 1;
 }
 
-u64 parse_size_from_string(const char *s)
+/*
+ * Parse a string to u64, with support for size suffixes.
+ *
+ * The suffixes are all 1024 based, and is case-insensitive.
+ * The supported ones are "KMGPTE", with one extra suffix "B" supported.
+ * "B" just means byte, thus it won't change the value.
+ *
+ * After one or less suffix, there should be no extra character other than
+ * a tailing NUL.
+ *
+ * Return 0 if there is a valid numeric string and result would be stored in
+ * @result.
+ * Return -EINVAL if the string is not valid (no numeric string at all, has any
+ * tailing characters, or a negative value).
+ * Return -ERANGE if the value is too large for u64.
+ */
+int parse_u64_with_suffix(const char *s, u64 *value_ret)
 {
 	char c;
 	char *endptr;
 	u64 mult = 1;
-	u64 ret;
+	u64 value;
+
+	if (!s)
+		return -EINVAL;
+	if (s[0] == '-')
+		return -EINVAL;
 
-	if (!s) {
-		error("size value is empty");
-		exit(1);
-	}
-	if (s[0] == '-') {
-		error("size value '%s' is less equal than 0", s);
-		exit(1);
-	}
 	errno = 0;
-	ret = strtoull(s, &endptr, 10);
-	if (endptr == s) {
-		error("size value '%s' is invalid", s);
-		exit(1);
-	}
-	if (endptr[0] && endptr[1]) {
-		error("illegal suffix contains character '%c' in wrong position",
-			endptr[1]);
-		exit(1);
-	}
+	value = strtoull(s, &endptr, 10);
+	if (endptr == s)
+		return -EINVAL;
+
 	/*
 	 * strtoll returns LLONG_MAX when overflow, if this happens,
 	 * need to call strtoull to get the real size
 	 */
-	if (errno == ERANGE && ret == ULLONG_MAX) {
-		error("size value '%s' is too large for u64", s);
-		exit(1);
-	}
+	if (errno == ERANGE && value == ULLONG_MAX)
+		return -ERANGE;
 	if (endptr[0]) {
 		c = tolower(endptr[0]);
 		switch (c) {
@@ -218,17 +223,19 @@ u64 parse_size_from_string(const char *s)
 		case 'b':
 			break;
 		default:
-			error("unknown size descriptor '%c'", c);
-			exit(1);
+			return -EINVAL;
 		}
+		endptr++;
 	}
+	/* Tailing character check. */
+	if (endptr[0] != '\0')
+		return -EINVAL;
 	/* Check whether ret * mult overflow */
-	if (fls64(ret) + fls64(mult) - 1 > 64) {
-		error("size value '%s' is too large for u64", s);
-		exit(1);
-	}
-	ret *= mult;
-	return ret;
+	if (fls64(value) + fls64(mult) - 1 > 64)
+		return -ERANGE;
+	value *= mult;
+	*value_ret = value;
+	return 0;
 }
 
 enum btrfs_csum_type parse_csum_type(const char *s)
diff --git a/common/parse-utils.h b/common/parse-utils.h
index 47f202c64f03..33ff9ca14346 100644
--- a/common/parse-utils.h
+++ b/common/parse-utils.h
@@ -19,10 +19,10 @@
 
 #include "kerncompat.h"
 
-u64 parse_size_from_string(const char *s);
 enum btrfs_csum_type parse_csum_type(const char *s);
 
 int parse_u64(const char *str, u64 *result);
+int parse_u64_with_suffix(const char *s, u64 *value_ret);
 int parse_range_u32(const char *range, u32 *start, u32 *end);
 int parse_range(const char *range, u64 *start, u64 *end);
 int parse_range_strict(const char *range, u64 *start, u64 *end);
diff --git a/common/string-utils.c b/common/string-utils.c
index ba5cc55a6daa..c6e16ddcc48c 100644
--- a/common/string-utils.c
+++ b/common/string-utils.c
@@ -67,3 +67,22 @@ u64 arg_strtou64(const char *str)
 	return value;
 }
 
+u64 arg_strtou64_with_suffix(const char *str)
+{
+	u64 value;
+	int ret;
+
+	ret = parse_u64_with_suffix(str, &value);
+	if (ret == -ERANGE) {
+		error("%s is too large", str);
+		exit(1);
+	} else if (ret == -EINVAL) {
+		error("%s is not a valid numeric value with supported size suffixes", str);
+		exit(1);
+	} else if (ret < 0) {
+		errno = -ret;
+		error("failed to parse string '%s': %m", str);
+		exit(1);
+	}
+	return value;
+}
diff --git a/common/string-utils.h b/common/string-utils.h
index a7ac8f5c7efa..1a46315cad41 100644
--- a/common/string-utils.h
+++ b/common/string-utils.h
@@ -21,6 +21,13 @@
 
 int string_is_numerical(const char *str);
 int string_has_prefix(const char *str, const char *prefix);
+
+/*
+ * Helpers prefixed by arg_* can exit if the argument is invalid and are supposed
+ * to be used when parsing command line options where the immediate exit is valid
+ * error handling.
+ */
 u64 arg_strtou64(const char *str);
+u64 arg_strtou64_with_suffix(const char *str);
 
 #endif
diff --git a/convert/main.c b/convert/main.c
index 77b7c0516ae5..f18fab4a236c 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -114,6 +114,7 @@
 #include "common/path-utils.h"
 #include "common/help.h"
 #include "common/parse-utils.h"
+#include "common/string-utils.h"
 #include "common/fsfeatures.h"
 #include "common/device-scan.h"
 #include "common/box.h"
@@ -1925,7 +1926,7 @@ int BOX_MAIN(convert)(int argc, char *argv[])
 				packing = 0;
 				break;
 			case 'N':
-				nodesize = parse_size_from_string(optarg);
+				nodesize = arg_strtou64_with_suffix(optarg);
 				break;
 			case 'r':
 				rollback = 1;
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index 9c40e4ef6c17..fb1e1388804e 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -34,7 +34,7 @@
 #include "common/device-utils.h"
 #include "common/extent-cache.h"
 #include "common/internal.h"
-#include "common/parse-utils.h"
+#include "common/string-utils.h"
 #include "common/messages.h"
 #include "mkfs/common.h"
 
@@ -102,7 +102,7 @@ u64 zone_size(const char *file)
 
 		tmp = bconf_param_value("zone-size");
 		if (tmp) {
-			size = parse_size_from_string(tmp);
+			size = arg_strtou64_with_suffix(tmp);
 			if (!is_power_of_2(size) || size < BTRFS_MIN_ZONE_SIZE ||
 			    size > BTRFS_MAX_ZONE_SIZE) {
 				error("invalid emulated zone size %llu", size);
diff --git a/mkfs/main.c b/mkfs/main.c
index d984c9955859..b9882208dbd5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1264,7 +1264,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				ret = 1;
 				goto error;
 			case 'n':
-				nodesize = parse_size_from_string(optarg);
+				nodesize = arg_strtou64_with_suffix(optarg);
 				nodesize_forced = true;
 				break;
 			case 'L':
@@ -1329,10 +1329,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				break;
 				}
 			case 's':
-				sectorsize = parse_size_from_string(optarg);
+				sectorsize = arg_strtou64_with_suffix(optarg);
 				break;
 			case 'b':
-				block_count = parse_size_from_string(optarg);
+				block_count = arg_strtou64_with_suffix(optarg);
 				opt_zero_end = false;
 				break;
 			case 'v':
-- 
2.43.0


