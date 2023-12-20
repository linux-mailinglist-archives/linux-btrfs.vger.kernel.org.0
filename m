Return-Path: <linux-btrfs+bounces-1069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435198194FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 01:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2D3287B07
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 00:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C259D8F71;
	Wed, 20 Dec 2023 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N4ihaMQ/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UGg+gZxx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E58C02;
	Wed, 20 Dec 2023 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E257E220F0;
	Wed, 20 Dec 2023 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1D35onfoLZl8LYbV+xcOSw5zCvDE1hOe1a28u26F0k=;
	b=N4ihaMQ/yFNUhX2QdWnq1zk+575vdfJt/MGA9/2QqaZ4TIEpP7/KKSgZj4eniZgXrkSz6s
	NWJ+KTSw9HLUqJf2TMrgW7KxVAGSYICtXOlKMIw09PGM8nsOo9bYJLXQ80CTr4I3XcQ6Al
	bAqBYpr0+SiWxAnzSC+rcEHdImfq9gI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1D35onfoLZl8LYbV+xcOSw5zCvDE1hOe1a28u26F0k=;
	b=UGg+gZxxprZlR4kPxXFBNRfqxuWGSZ1GytFvtvZ2Jg8PiPOi1zirlVb6WxAf1m+1h9yuId
	gTjJhF094oFQpR9+aZ8pCOJjBUYzNxxyV9mW3TWPmsW7JfC76BrbYdNM22aJqRGXx1V5AF
	+/z4XSHNPChZ1dStUR1Tulb4hBWEKpQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 98221139F9;
	Wed, 20 Dec 2023 00:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gKfTDvIwgmU5dQAAn2gu4w
	(envelope-from <wqu@suse.com>); Wed, 20 Dec 2023 00:10:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Laight <David.Laight@ACULAB.COM>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] lib/strtox: introduce kstrtoull_suffix() helper
Date: Wed, 20 Dec 2023 10:40:00 +1030
Message-ID: <e042f40ea5cf7fa8251713d5bb7a485f42c5615b.1703030510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703030510.git.wqu@suse.com>
References: <cover.1703030510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

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
    The recommended suffix list is "KMGTP" (using the new unit_suffix
    enum as a bitmap), excluding the overflow prone "E".
    Undermost cases there is really no need to use "E" suffix anyway.
    And for those who really need that exabytes suffix, they can enable
    that suffix pretty easily.

  * Add overflow checks for the suffixes
    If the original number string is fine, but with the extra left
    shift overflow happens, then -EOVERFLOW is returned.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>

----
Changelog:
v2:
- Use enum bitmap to describe the suffixes
  This gets rid of the upper/lower case problem, and enum makes it
  a little more readable.

- Fix the suffix overflow detection

- Move the left shift out of the switch block

- Remove the "done" tag
  Since no tailing character can already be handled properly.
---
 include/linux/kstrtox.h |  20 ++++++++
 lib/kstrtox.c           | 108 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..edac52d18a8e 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -9,6 +9,26 @@
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
 
+/*
+ * The default suffix list would not include "E" since it's too easy to overflow
+ * and not much real world usage.
+ */
+enum unit_suffix {
+	SUFFIX_K = (1 << 0),
+	SUFFIX_M = (1 << 1),
+	SUFFIX_G = (1 << 2),
+	SUFFIX_T = (1 << 3),
+	SUFFIX_P = (1 << 4),
+	SUFFIX_E = (1 << 5),
+};
+
+/*
+ * The default suffix list would not include "E" since it's too easy to overflow
+ * and not much real world usage.
+ */
+#define KSTRTOULL_SUFFIX_DEFAULT (SUFFIX_K | SUFFIX_M | SUFFIX_G | SUFFIX_T | SUFFIX_P)
+int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
+		     enum unit_suffix suffixes);
 int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
 
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index d586e6af5e5a..8a2fdd1e3376 100644
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
 
@@ -133,10 +142,99 @@ int kstrtoull(const char *s, unsigned int base, unsigned long long *res)
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
+ * @suffixes: bitmap of acceptable suffixes, unknown bits would be ignored.
+ *
+ * Return 0 on success.
+ *
+ * Return -ERANGE on overflow or -EINVAL if invalid chars found.
+ * Return value must be checked.
+ */
+int kstrtoull_suffix(const char *s, unsigned int base, unsigned long long *res,
+		     enum unit_suffix suffixes)
+{
+	unsigned long long value;
+	int shift = 0;
+	char *endptr;
+	int ret;
+
+	ret = _kstrtoull(s, base, &value, &endptr);
+	/* Either already overflow or no number string at all. */
+	if (ret < 0)
+		return ret;
+
+	switch (*endptr) {
+	case 'K':
+	case 'k':
+		if (!(suffixes & SUFFIX_K))
+			return -EINVAL;
+		shift = 10;
+		break;
+	case 'M':
+	case 'm':
+		if (!(suffixes & SUFFIX_M))
+			return -EINVAL;
+		shift = 20;
+		break;
+	case 'G':
+	case 'g':
+		if (!(suffixes & SUFFIX_G))
+			return -EINVAL;
+		shift = 30;
+		break;
+	case 'T':
+	case 't':
+		if (!(suffixes & SUFFIX_T))
+			return -EINVAL;
+		shift = 40;
+		break;
+	case 'P':
+	case 'p':
+		if (!(suffixes & SUFFIX_P))
+			return -EINVAL;
+		shift = 50;
+		break;
+	case 'E':
+	case 'e':
+		if (!(suffixes & SUFFIX_E))
+			return -EINVAL;
+		shift = 60;
+		break;
+	}
+	if (shift)
+		endptr++;
+	if (*endptr == '\n')
+		endptr++;
+	if (*endptr)
+		return -EINVAL;
+
+	/*
+	 * Overflow check.
+	 *
+	 * Check @shift before doing right shift, as if right shift bit is
+	 * greater than or equal to the number of bits, the result is undefined.
+	 */
+	if (shift && value >> (64 - shift))
+		return -EOVERFLOW;
+	value <<= shift;
+	*res = value;
+	return 0;
+}
+EXPORT_SYMBOL(kstrtoull_suffix);
+
 /**
  * kstrtoll - convert a string to a long long
  * @s: The start of the string. The string must be null-terminated, and may also
@@ -159,7 +257,7 @@ int kstrtoll(const char *s, unsigned int base, long long *res)
 	int rv;
 
 	if (s[0] == '-') {
-		rv = _kstrtoull(s + 1, base, &tmp);
+		rv = _kstrtoull(s + 1, base, &tmp, NULL);
 		if (rv < 0)
 			return rv;
 		if ((long long)-tmp > 0)
-- 
2.43.0


