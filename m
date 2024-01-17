Return-Path: <linux-btrfs+bounces-1504-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBAB82FF78
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 05:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D9A3B25369
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 04:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF45CBC;
	Wed, 17 Jan 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9ZvRfJ7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9ZvRfJ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C85247
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705464668; cv=none; b=NiLvUkjyt9QdK0cSaL8/nNqHg/Qei8RcixaJ40tfJ1khrOMYf7GepHLtGD/EVPT0vsmT39Zs/428miXYJhYLGlW/HlRfMiWqYorC7OIm6ZSGBISJN5E4GEJTicBXcG7+e6YwbOuwz65CtlGxKVtGMlTIccVTZV0VKj8ZCrxCS4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705464668; c=relaxed/simple;
	bh=iwBKdElAhEZEGJK1aBM8MVWSbJS9HZ5BOcigbPs5LHE=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Flag:X-Spamd-Bar; b=kiBFheqjPnJvz1+RcMQdZDb7uzSCew8hRHZ2e/nf22268Yw60DiihH/hJWyV8dkuvHt84NuLz8BQOrc7WZleN+pF+en9MhoyjBTjU8q4/eZQk7uBVJsJrDi3n61riQr6wwvm4sVNzr69nZmD0lcn2Z4Mw1LYWUaKZLaFduvwngA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9ZvRfJ7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9ZvRfJ7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0739E1FD5B
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705464663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtIskZsi7JWLxMi0nStDiHGbBMiSYGj1StfZEVaGPU4=;
	b=e9ZvRfJ7R3+Fu5na440PFL/TIL95GKXP7ipDdEpiEjQh4EM6LW3IVoSD8U2RRJswiD9B7v
	ZhAcoqPAkMtTDig4u6hfsGkynzZy2sHmazxngqKFfyIOWqD2lWznAMQr9QWVHEtdimuZyW
	hkiytPfAYFfKnItd3POHrvyWVIvVB/o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705464663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NtIskZsi7JWLxMi0nStDiHGbBMiSYGj1StfZEVaGPU4=;
	b=e9ZvRfJ7R3+Fu5na440PFL/TIL95GKXP7ipDdEpiEjQh4EM6LW3IVoSD8U2RRJswiD9B7v
	ZhAcoqPAkMtTDig4u6hfsGkynzZy2sHmazxngqKFfyIOWqD2lWznAMQr9QWVHEtdimuZyW
	hkiytPfAYFfKnItd3POHrvyWVIvVB/o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08B9B13751
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2E13K1VTp2XrSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 04:11:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: implement arg_strtou64_with_suffix() with a new helper
Date: Wed, 17 Jan 2024 14:40:40 +1030
Message-ID: <5f424c6a1f62f16134e71c1fab327c354e8ff3ea.1705464240.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705464240.git.wqu@suse.com>
References: <cover.1705464240.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=e9ZvRfJ7
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: 0739E1FD5B
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

This patch would introduce a new parser helper, parse_u64_with_suffix(),
which would have better error handling, following all the parse_*()
helpers to return non-zero value for errors.

This new helper is going to replace parse_size_from_string(), which
would directly call exit(1) to stop the whole program.

Furthermore most callers of parse_size_from_string() are expecting
exit(1) for error, so that they can skip the error handling.

For those call sites, introduce a wrapper, arg_strtou64_with_suffix(),
to do that.
The only disadvantage is a little less detailed error report for why the
parse failed, but for most cases the generic error string should be
enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/filesystem.c     | 15 +++++-----
 cmds/qgroup.c         |  3 +-
 cmds/reflink.c        |  7 +++--
 cmds/scrub.c          |  2 +-
 common/parse-utils.c  | 66 ++++++++++++++++++++++++-------------------
 common/parse-utils.h  |  2 +-
 common/string-utils.c | 19 +++++++++++++
 common/string-utils.h |  1 +
 convert/main.c        |  3 +-
 kernel-shared/zoned.c |  4 +--
 mkfs/main.c           |  6 ++--
 11 files changed, 80 insertions(+), 48 deletions(-)

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
index 867a5bd2ac0a..669a5fc10e5d 100644
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
+	*length =arg_strtou64_with_suffix(tmp);
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
index e2b8687d53d7..1b8b950c89aa 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -160,40 +160,45 @@ int parse_range_strict(const char *range, u64 *start, u64 *end)
 	return 1;
 }
 
-u64 parse_size_from_string(const char *s)
+/*
+ * Parse a string to u64, with support for suffixes.
+ *
+ * The suffixes are all 1024 based, and is case-insensitive.
+ * The supported ones are "KMGPTE", with one extra suffix "B" supported.
+ * "B" just means byte, thus won't change the value.
+ *
+ * After one or less suffix, there should be no extra character other than
+ * a tailing NUL.
+ *
+ * Return 0 if there is a valid numeric string and result would be stored in
+ * @result.
+ * Return -EINVAL if the string is not valid (no numeric string at all,
+ * has any tailing characters, or minus value).
+ * Return -ERANGE if the value is too larger for u64.
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
@@ -218,17 +223,20 @@ u64 parse_size_from_string(const char *s)
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
+	if (fls64(value) + fls64(mult) - 1 > 64) {
 		error("size value '%s' is too large for u64", s);
 		exit(1);
 	}
-	ret *= mult;
-	return ret;
+	value *= mult;
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
index ba5cc55a6daa..5bd72fc5249e 100644
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
+		error("%s is not a valid numeric value with supported size suffixes",
+		      str);
+		exit(1);
+	} else if (ret < 0) {
+		errno = -ret;
+		error("failed to parse string '%s': %m", str);
+	}
+	return value;
+}
diff --git a/common/string-utils.h b/common/string-utils.h
index a7ac8f5c7efa..38137d566dbc 100644
--- a/common/string-utils.h
+++ b/common/string-utils.h
@@ -22,5 +22,6 @@
 int string_is_numerical(const char *str);
 int string_has_prefix(const char *str, const char *prefix);
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


