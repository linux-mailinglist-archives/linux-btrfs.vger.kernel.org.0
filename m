Return-Path: <linux-btrfs+bounces-1538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C973883100C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD45AB2710B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF31328699;
	Wed, 17 Jan 2024 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fxtUSZYc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fxtUSZYc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3550D225A1
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533318; cv=none; b=QRLP4L3G4bu6QvEvGVlLcg06kNH+NlHT95/8yLvEBrbGKzLSIxBl9WKxNNyDEmfP+mnXxYwI4na2wVwZ7lV0XNmNL+AAwAim1wp0XpiQoBAef41wbf6kUcW3Bsuj8W4o4ko59YItxe8/mC5m9v1URYP3BWraeQIdv1gPvKKCZvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533318; c=relaxed/simple;
	bh=GOClxjkWqlFDu36ca7SoGghXgIdGID+Zf6imhvDnerw=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=Mz72xHuc37r3SjBAyCvq7tGNSN8iLHxrJB5ipjcmgY4b6GQSdvPXqluVVXcgDWNZ4f88aGXcX1McCpQSefk1zuGCmEeg8pOlcLlpkTsk6vYKfzQMYPNpYpIW7rAETS3hvZRqeFMofm+O80p4pyj8nOvSEVh0Jh33kBjmqfgA6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fxtUSZYc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fxtUSZYc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 569091F445;
	Wed, 17 Jan 2024 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIRgMtSN0+OgpJFApzJfZHwmcCmSdgzmedu4xOYHGy0=;
	b=fxtUSZYcZB9IG+Fwg0+3UzfeVDjWKj7wTrPQPjSqtP0WNflPQOyyjK7IyNIYN4h70SMXMz
	afTG9ou5ZQsir6ia37zpLQoSsvxWR9Wzj13aIiAZ0vl7qjb4/+jr4l8KZjZsks15E5VUdB
	dlElyRcjLVztOSIZtHimp9JhYBIJpNc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIRgMtSN0+OgpJFApzJfZHwmcCmSdgzmedu4xOYHGy0=;
	b=fxtUSZYcZB9IG+Fwg0+3UzfeVDjWKj7wTrPQPjSqtP0WNflPQOyyjK7IyNIYN4h70SMXMz
	afTG9ou5ZQsir6ia37zpLQoSsvxWR9Wzj13aIiAZ0vl7qjb4/+jr4l8KZjZsks15E5VUdB
	dlElyRcjLVztOSIZtHimp9JhYBIJpNc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1939F13800;
	Wed, 17 Jan 2024 23:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aG+UL4FfqGXzIAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Jan 2024 23:15:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/2] btrfs-progs: use parse_u64() to implement arg_strtou64()
Date: Thu, 18 Jan 2024 09:44:53 +1030
Message-ID: <959b9065977f448b478632303f20274baf2b2630.1705532789.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705532789.git.wqu@suse.com>
References: <cover.1705532789.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Both functions are just doing the same thing, the only difference is
only in error handling, as parse_u64() requires callers to handle it,
meanwhile arg_strtou64() would call exit(1).

This patch would convert arg_strtou64() to utilize parse_u64(), and use
the return value to output different error messages.

This also means the return value of parse_u64() would be more than just
0 or 1, but -EINVAL for invalid string (including no numeric string at
all, has any tailing characters, or minus value), and -ERANGE for
overflow.

The existing callers are only checking if the return value is 0, thus
not really affected.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/parse-utils.c  | 19 ++++++++++++++++++-
 common/string-utils.c | 26 ++++++++++----------------
 common/string-utils.h |  2 ++
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/common/parse-utils.c b/common/parse-utils.c
index 3d9a6d637a7f..9b34f95d64df 100644
--- a/common/parse-utils.c
+++ b/common/parse-utils.c
@@ -31,14 +31,31 @@
 #include "common/messages.h"
 #include "common/utils.h"
 
+/*
+ * Parse a string to u64.
+ *
+ * Return 0 if there is a valid numeric string and result would be stored in
+ * @result.
+ * Return -EINVAL if the string is not valid (no numeric string at all, or
+ * has any tailing characters, or a negative value).
+ * Return -ERANGE if the value is too larger for u64.
+ */
 int parse_u64(const char *str, u64 *result)
 {
 	char *endptr;
 	u64 val;
 
+	/*
+	 * Although strtoull accepts a negative number and converts it u64, we
+	 * don't really want to utilize this as the helper is meant for u64 only.
+	 */
+	if (str[0] == '-')
+		return -EINVAL;
 	val = strtoull(str, &endptr, 10);
 	if (*endptr)
-		return 1;
+		return -EINVAL;
+	if (val == ULLONG_MAX && errno == ERANGE)
+		return -ERANGE;
 
 	*result = val;
 	return 0;
diff --git a/common/string-utils.c b/common/string-utils.c
index e338afa75711..ba5cc55a6daa 100644
--- a/common/string-utils.c
+++ b/common/string-utils.c
@@ -20,6 +20,7 @@
 #include <limits.h>
 #include "common/string-utils.h"
 #include "common/messages.h"
+#include "common/parse-utils.h"
 
 int string_is_numerical(const char *str)
 {
@@ -50,25 +51,18 @@ int string_has_prefix(const char *str, const char *prefix)
 u64 arg_strtou64(const char *str)
 {
 	u64 value;
-	char *ptr_parse_end = NULL;
+	int ret;
 
-	value = strtoull(str, &ptr_parse_end, 0);
-	if (ptr_parse_end && *ptr_parse_end != '\0') {
-		error("%s is not a valid numeric value", str);
-		exit(1);
-	}
-
-	/*
-	 * if we pass a negative number to strtoull, it will return an
-	 * unexpected number to us, so let's do the check ourselves.
-	 */
-	if (str[0] == '-') {
-		error("%s: negative value is invalid", str);
-		exit(1);
-	}
-	if (value == ULLONG_MAX) {
+	ret = parse_u64(str, &value);
+	if (ret == -ERANGE) {
 		error("%s is too large", str);
 		exit(1);
+	} else if (ret == -EINVAL) {
+		if (str[0] == '-')
+			error("%s: negative value is invalid", str);
+		else
+			error("%s is not a valid numeric value", str);
+		exit(1);
 	}
 	return value;
 }
diff --git a/common/string-utils.h b/common/string-utils.h
index ade8fcd1f66b..a7ac8f5c7efa 100644
--- a/common/string-utils.h
+++ b/common/string-utils.h
@@ -17,6 +17,8 @@
 #ifndef __BTRFS_STRING_UTILS_H__
 #define __BTRFS_STRING_UTILS_H__
 
+#include "kerncompat.h"
+
 int string_is_numerical(const char *str);
 int string_has_prefix(const char *str, const char *prefix);
 u64 arg_strtou64(const char *str);
-- 
2.43.0


