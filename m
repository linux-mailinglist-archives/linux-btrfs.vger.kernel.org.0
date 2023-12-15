Return-Path: <linux-btrfs+bounces-971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E34D68143CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 09:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9687C2848C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 08:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632D168B9;
	Fri, 15 Dec 2023 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lgn9kY2L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lgn9kY2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB314F6D;
	Fri, 15 Dec 2023 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 14DD31F821;
	Fri, 15 Dec 2023 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa6s0EtHuv6zTIbOPJXyR9juo2eumL5AFKs/cusr4M4=;
	b=lgn9kY2LLAbob+5LzOF0WxzXb4bPVQO/28ib46KTGSAkNuSJsXEfLrqLOMrMZNRwVeReoE
	zqYgKVAGGssuipGyHrvXh+BacjqO7EEXcLNIQR1kQnAPcGdeAD0KFKvwnkmmu34D5x7vBk
	whvBbV5m1MMQPl24xeXf420DekZRiVs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702629588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa6s0EtHuv6zTIbOPJXyR9juo2eumL5AFKs/cusr4M4=;
	b=lgn9kY2LLAbob+5LzOF0WxzXb4bPVQO/28ib46KTGSAkNuSJsXEfLrqLOMrMZNRwVeReoE
	zqYgKVAGGssuipGyHrvXh+BacjqO7EEXcLNIQR1kQnAPcGdeAD0KFKvwnkmmu34D5x7vBk
	whvBbV5m1MMQPl24xeXf420DekZRiVs=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A58113A08;
	Fri, 15 Dec 2023 08:39:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sKG7C9EQfGVJBgAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 15 Dec 2023 08:39:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Date: Fri, 15 Dec 2023 19:09:23 +1030
Message-ID: <11da10b4d07bf472cd47410db65dc0e222d61e83.1702628925.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702628925.git.wqu@suse.com>
References: <cover.1702628925.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,wanadoo.fr,linux.intel.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
Authentication-Results: smtp-out2.suse.de;
	none

Just as mentioned in the comment of memparse(), the simple_stroull()
usage can lead to overflow all by itself.

Furthermore, the suffix calculation is also super overflow prone because
that some suffix like "E" itself would eat 60bits, leaving only 4 bits
available.

And that suffix "E" can also lead to confusion since it's using the same
char of hex Ox'E'.

One simple example to expose all the problem is to use memparse() on
"25E".
The correct value should be 28823037615171174400, but the suffix E makes
it super simple to overflow, resulting the incorrect value
10376293541461622784 (9E).

So here we introduce a new helper to address the problem,
kstrtoull_suffix():

- Enhance _kstrtoull()
  This allow _kstrtoull() to return even if it hits an invalid char, as
  long as the optional parameter @retptr is provided.

  If @retptr is provided, _kstrtoull() would try its best to parse the
  valid part, and leave the remaining to be handled by the caller.

  If @retptr is not provided, the behavior is not altered.

- New kstrtoull_suffix() helper
  This new helper utilize the new @retptr capability of _kstrtoull(),
  and provides 2 new ability:

  * Allow certain suffixes to be chosen
    The recommended suffix list is "KkMmGgTtPp", excluding the overflow
    prone "Ee". Undermost cases there is really no need to use "E" suffix
    anyway.
    And for those who really need that exabytes suffix, they can enable
    that suffix pretty easily.

  * Add overflow checks for the suffixes
    If the original number string is fine, but with the extra left
    shift overflow happens, then -EOVERFLOW is returned.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/kstrtox.h |   7 +++
 lib/kstrtox.c           | 113 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 115 insertions(+), 5 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..12c754152c15 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -9,6 +9,13 @@
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
 
+/*
+ * The default suffix list would not include "E" since it's too easy to overflow
+ * and not much real world usage.
+ */
+#define KSTRTOULL_SUFFIX_DEFAULT		("KkMmGgTtPp")
+int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
+		     const char *suffixes);
 int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
 
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a..63831207dfdd 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -93,7 +93,8 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 	return _parse_integer_limit(s, base, p, INT_MAX);
 }
 
-static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
+static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res,
+		      char **retptr)
 {
 	unsigned long long _res;
 	unsigned int rv;
@@ -105,11 +106,19 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 	if (rv == 0)
 		return -EINVAL;
 	s += rv;
-	if (*s == '\n')
+
+	/*
+	 * If @retptr is provided, caller is responsible to detect
+	 * the extra chars, otherwise we can skip one newline.
+	 */
+	if (!retptr && *s == '\n')
 		s++;
-	if (*s)
+	if (!retptr && *s)
 		return -EINVAL;
+
 	*res = _res;
+	if (retptr)
+		*retptr = (char *)s;
 	return 0;
 }
 
@@ -133,10 +142,104 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	if (s[0] == '+')
 		s++;
-	return _kstrtoull(s, base, res);
+	return _kstrtoull(s, base, res, NULL);
 }
 EXPORT_SYMBOL(kstrtoull);
 
+/**
+ * kstrtoull_suffix - convert a string to ull with suffixes support
+ * @s: The start of the string. The string must be null-terminated, and may also
+ *  include a single newline before its terminating null.
+ * @base: The number base to use. The maximum supported base is 16. If base is
+ *  given as 0, then the base of the string is automatically detected with the
+ *  conventional semantics - If it begins with 0x the number will be parsed as a
+ *  hexadecimal (case insensitive), if it otherwise begins with 0, it will be
+ *  parsed as an octal number. Otherwise it will be parsed as a decimal.
+ * @res: Where to write the result of the conversion on success.
+ * @suffixes: A string of acceptable suffixes, must be provided. Or caller
+ *  should use kstrtoull() directly.
+ *
+ *
+ * Return 0 on success.
+ *
+ * Return -ERANGE on overflow or -EINVAL if invalid chars found.
+ * Return value must be checked.
+ */
+int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
+		     const char *suffixes)
+{
+	unsigned long long init_value;
+	unsigned long long final_value;
+	char *endptr;
+	int ret;
+
+	ret = _kstrtoull(s, base, &init_value, &endptr);
+	/* Either already overflow or no number string at all. */
+	if (ret < 0)
+		return ret;
+	final_value = init_value;
+	/* No suffixes. */
+	if (!*endptr)
+		goto done;
+
+	switch (*endptr) {
+	case 'K':
+	case 'k':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 10;
+		endptr++;
+		break;
+	case 'M':
+	case 'm':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 20;
+		endptr++;
+		break;
+	case 'G':
+	case 'g':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 30;
+		endptr++;
+		break;
+	case 'T':
+	case 't':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 40;
+		endptr++;
+		break;
+	case 'P':
+	case 'p':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 50;
+		endptr++;
+		break;
+	case 'E':
+	case 'e':
+		if (!strchr(suffixes, *endptr))
+			return -EINVAL;
+		final_value <<= 60;
+		endptr++;
+		break;
+	}
+	if (*endptr == '\n')
+		endptr++;
+	if (*endptr)
+		return -EINVAL;
+
+	/* Overflow check. */
+	if (final_value < init_value)
+		return -EOVERFLOW;
+done:
+	*res = final_value;
+	return 0;
+}
+EXPORT_SYMBOL(kstrtoull_suffix);
+
 /**
  * kstrtoll - convert a string to a long long
  * @s: The start of the string. The string must be null-terminated, and may also
@@ -159,7 +262,7 @@ int kstrtoll(const char *s, unsigned int base, long long *res)
 	int rv;
 
 	if (s[0] == '-') {
-		rv = _kstrtoull(s + 1, base, &tmp);
+		rv = _kstrtoull(s + 1, base, &tmp, NULL);
 		if (rv < 0)
 			return rv;
 		if ((long long)-tmp > 0)
-- 
2.43.0


