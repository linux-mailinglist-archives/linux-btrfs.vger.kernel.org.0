Return-Path: <linux-btrfs+bounces-1540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2E831010
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 00:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AB91C2242E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jan 2024 23:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B2286AC;
	Wed, 17 Jan 2024 23:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RGCLvAFy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RGCLvAFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568721A12
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Jan 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705533450; cv=none; b=tyTjPSIjlRDE8Bb/41eE48dPTpb6HQQOSKiyFdj03v3tU5WH9emSn+wbIhbYZmmSaOsa610PyCYZutdVFlFVHdCxHpcwuBFoKD7Q3RjY10A7+zkTOPmJ8/E2SVvXfO+w3reIUhFiXaJHFGflfKXkUBTBRJW5gvdN0BbczAj2WtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705533450; c=relaxed/simple;
	bh=GOClxjkWqlFDu36ca7SoGghXgIdGID+Zf6imhvDnerw=;
	h=Received:DKIM-Signature:DKIM-Signature:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=b7kczSRS4QrPny4eMj8Omd3biVGFQ7XX3cHZf2VQ6L23C32NkVXfgZcB6AH0ym+W2zgg23c63LzpPPwrQqCSSFOXH9eHUEI1SQH8jjCR/p/KY1bHQSsEp6/Fn0sY6ge5aYCskVK6h+yX6WzBoKksQpjr7sNDMENnvWINI4mcLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RGCLvAFy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RGCLvAFy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C58F2209F;
	Wed, 17 Jan 2024 23:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIRgMtSN0+OgpJFApzJfZHwmcCmSdgzmedu4xOYHGy0=;
	b=RGCLvAFysU8EhO5iRWnpf7sSZeaL5a7d+8R+OrgrvMJ+D8HCPNhqI2lfeH/zIoSQ9hAhdz
	UGepmKkKPIMjjjN6RkWGdp45tg2r5QrFknxR3Z+9wxb8M2JR2yyAlbcJQ1K06A6UeRL9FO
	ulKFqlHFUaPlpe3mJVRS6jpUkv67+SU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705533446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MIRgMtSN0+OgpJFApzJfZHwmcCmSdgzmedu4xOYHGy0=;
	b=RGCLvAFysU8EhO5iRWnpf7sSZeaL5a7d+8R+OrgrvMJ+D8HCPNhqI2lfeH/zIoSQ9hAhdz
	UGepmKkKPIMjjjN6RkWGdp45tg2r5QrFknxR3Z+9wxb8M2JR2yyAlbcJQ1K06A6UeRL9FO
	ulKFqlHFUaPlpe3mJVRS6jpUkv67+SU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 442A613800;
	Wed, 17 Jan 2024 23:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJPxAAVgqGVxIQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Jan 2024 23:17:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/2] btrfs-progs: use parse_u64() to implement arg_strtou64()
Date: Thu, 18 Jan 2024 09:47:01 +1030
Message-ID: <959b9065977f448b478632303f20274baf2b2630.1705533399.git.wqu@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
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


