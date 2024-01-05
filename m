Return-Path: <linux-btrfs+bounces-1258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF1824D00
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 03:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5C3286DC5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jan 2024 02:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1425D46B3;
	Fri,  5 Jan 2024 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFyd/d6R";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TFyd/d6R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D29BA4D;
	Fri,  5 Jan 2024 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D57D1F84F;
	Fri,  5 Jan 2024 02:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704422142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd1gkUlq007Qvvl4NBGWrbn8cI9dfuRzMuguKSM8RiU=;
	b=TFyd/d6RkZu94z0xl4ph3u3NTZ4NiwwPB31dzIO33+szjEiJg5ByP8WPQBvAddYzdQbRz9
	FfRYA3M9DfuZhO61E1pUoodrLCPjHepwROyUSw7Kq0eZ3E3xJqTwO+3Uuhfr6skrJGaIgY
	r6940+V84i51Y34MAPL0LYsHAtkUpug=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704422142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd1gkUlq007Qvvl4NBGWrbn8cI9dfuRzMuguKSM8RiU=;
	b=TFyd/d6RkZu94z0xl4ph3u3NTZ4NiwwPB31dzIO33+szjEiJg5ByP8WPQBvAddYzdQbRz9
	FfRYA3M9DfuZhO61E1pUoodrLCPjHepwROyUSw7Kq0eZ3E3xJqTwO+3Uuhfr6skrJGaIgY
	r6940+V84i51Y34MAPL0LYsHAtkUpug=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9599C137E8;
	Fri,  5 Jan 2024 02:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ECoCCvhql2XhbAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 05 Jan 2024 02:35:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	andriy.shevchenko@linux.intel.com,
	David.Laight@ACULAB.COM,
	ddiss@suse.de,
	geert@linux-m68k.org,
	rdunlap@infradead.org
Subject: [PATCH v4 2/4] kstrtox: introduce a safer version of memparse()
Date: Fri,  5 Jan 2024 13:05:00 +1030
Message-ID: <f972b96cad42e49235d90b863038a080acc0059e.1704422015.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704422015.git.wqu@suse.com>
References: <cover.1704422015.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.990];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FREEMAIL_TO(0.00)[vger.kernel.org,linux-foundation.org,wanadoo.fr,linux.intel.com,ACULAB.COM,suse.de,linux-m68k.org,infradead.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email,suse.de:email];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

[BUGS]
Function memparse() lacks error handling:

- If no valid number string at all
  In that case @retptr would just be updated and return value would be
  zero.

- No overflown detection
  This applies to both the number string part, and the suffixes part.
  And since we have no way to indicate errors, we can get weird results
  like:

  	"25E" -> 10376293541461622784 (9E)

  This is due to the fact that for "E" suffix, there is only 4 bits
  left, and 25 with 60 bits left shift would lead to overflow.

[CAUSE]
The root cause is already mentioned in the comments of the function, the
usage of simple_strtoull() is the source of evil.
Furthermore the function prototype is no good either, just returning an
unsigned long long gives us no way to indicate an error.

[FIX]
Due to the prototype limits, we can not have a drop-in replacement for
memparse().

This patch can only help by introduce a new helper, memparse_safe(), and
mark the old memparse() deprecated.

The new memparse_safe() has the following improvement:

- Invalid string detection
  If no number string can be detected at all, -EINVAL would be returned.

- Better overflow detection
  Both the string part and the extra left shift would have overflow
  detection.
  Any overflow would result -ERANGE.

- Safer default suffix selection
  The helper allows the caller to choose the suffixes that they want to
  use.
  But only "KMGTP" are recommended by default since the "E" leaves only
  4 bits before overflow.
  For those callers really know what they are doing, they can still
  manually to include all suffixes.

Due to the prototype change, callers should migrate to the new one and
change their code and add extra error handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
 include/linux/kernel.h  |  8 +++-
 include/linux/kstrtox.h | 15 +++++++
 lib/cmdline.c           |  4 +-
 lib/kstrtox.c           | 99 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d9ad21058eed..b1b6da60ea43 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -201,7 +201,13 @@ void do_exit(long error_code) __noreturn;
 
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
-extern unsigned long long memparse(const char *ptr, char **retptr);
+
+/*
+ * DEPRECATED, lack of any kind of error handling.
+ *
+ * Use memparse_safe() from lib/kstrtox.c instead.
+ */
+extern __deprecated unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
 extern char *next_arg(char *args, char **param, char **val);
 
diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de..53a1e059dd31 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -9,6 +9,21 @@
 int __must_check _kstrtoul(const char *s, unsigned int base, unsigned long *res);
 int __must_check _kstrtol(const char *s, unsigned int base, long *res);
 
+enum memparse_suffix {
+	MEMPARSE_SUFFIX_K = 1 << 0,
+	MEMPARSE_SUFFIX_M = 1 << 1,
+	MEMPARSE_SUFFIX_G = 1 << 2,
+	MEMPARSE_SUFFIX_T = 1 << 3,
+	MEMPARSE_SUFFIX_P = 1 << 4,
+	MEMPARSE_SUFFIX_E = 1 << 5,
+};
+
+#define MEMPARSE_SUFFIXES_DEFAULT (MEMPARSE_SUFFIX_K | MEMPARSE_SUFFIX_M |\
+				   MEMPARSE_SUFFIX_G | MEMPARSE_SUFFIX_T |\
+				   MEMPARSE_SUFFIX_P)
+
+int __must_check memparse_safe(const char *s, enum memparse_suffix suffixes,
+			       unsigned long long *res, char **retptr);
 int __must_check kstrtoull(const char *s, unsigned int base, unsigned long long *res);
 int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
 
diff --git a/lib/cmdline.c b/lib/cmdline.c
index 90ed997d9570..35dbb03b5592 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -139,10 +139,12 @@ char *get_options(const char *str, int nints, int *ints)
 EXPORT_SYMBOL(get_options);
 
 /**
- *	memparse - parse a string with mem suffixes into a number
+ *	memparse - DEPRECATED, parse a string with mem suffixes into a number
  *	@ptr: Where parse begins
  *	@retptr: (output) Optional pointer to next char after parse completes
  *
+ *	There is no way to handle errors, and no overflown detection and string
+ *	sanity checks.
  *	Parses a string into a number.  The number stored at @ptr is
  *	potentially suffixed with K, M, G, T, P, E.
  */
diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 41c9a499bbf3..375c7f0842e3 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -113,6 +113,105 @@ static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 	return 0;
 }
 
+/**
+ * memparse_safe - convert a string to an unsigned long long, safer version of
+ * memparse()
+ *
+ * @s:		The start of the string. Must be null-terminated.
+ *		The base is determined automatically, if it starts with "0x"
+ *		the base is 16, if it starts with "0" the base is 8, otherwise
+ *		the base is 10.
+ *		After a valid number string, there can be at most one
+ *		case-insensitive suffix character, specified by the @suffixes
+ *		parameter.
+ *
+ * @suffixes:	The suffixes which should be handled. Use logical ORed
+ *		memparse_suffix enum to indicate the supported suffixes.
+ *		The suffixes are case-insensitive, all 2 ^ 10 based.
+ *		Supported ones are "KMGPTE".
+ *		If one suffix (one of "KMGPTE") is hit but that suffix is
+ *		not specified in the @suffxies parameter, it ends the parse
+ *		normally, with @retptr pointed to the (unsupported) suffix.
+ *		E.g. "68k" with suffxies "M" returns 68 decimal, @retptr
+ *		updated to 'k'.
+ *
+ * @res:	Where to write the result.
+ *
+ * @retptr:	(output) Optional pointer to the next char after parse completes.
+ *
+ * Returns:
+ * * %0 if any valid numeric string can be parsed, and @retptr is updated.
+ * * %-EINVAL if no valid number string can be found.
+ * * %-ERANGE if the number overflows.
+ * * For negative return values, @retptr is not updated.
+ */
+noinline int memparse_safe(const char *s, enum memparse_suffix suffixes,
+			   unsigned long long *res, char **retptr)
+{
+	unsigned long long value;
+	unsigned int rv;
+	int shift = 0;
+	int base = 0;
+
+	s = _parse_integer_fixup_radix(s, &base);
+	rv = _parse_integer(s, base, &value);
+	if (rv & KSTRTOX_OVERFLOW)
+		return -ERANGE;
+	if (rv == 0)
+		return -EINVAL;
+
+	s += rv;
+	switch (*s) {
+	case 'K':
+	case 'k':
+		if (!(suffixes & MEMPARSE_SUFFIX_K))
+			break;
+		shift = 10;
+		break;
+	case 'M':
+	case 'm':
+		if (!(suffixes & MEMPARSE_SUFFIX_M))
+			break;
+		shift = 20;
+		break;
+	case 'G':
+	case 'g':
+		if (!(suffixes & MEMPARSE_SUFFIX_G))
+			break;
+		shift = 30;
+		break;
+	case 'T':
+	case 't':
+		if (!(suffixes & MEMPARSE_SUFFIX_T))
+			break;
+		shift = 40;
+		break;
+	case 'P':
+	case 'p':
+		if (!(suffixes & MEMPARSE_SUFFIX_P))
+			break;
+		shift = 50;
+		break;
+	case 'E':
+	case 'e':
+		if (!(suffixes & MEMPARSE_SUFFIX_E))
+			break;
+		shift = 60;
+		break;
+	}
+	if (shift) {
+		s++;
+		if (value >> (64 - shift))
+			return -ERANGE;
+		value <<= shift;
+	}
+	*res = value;
+	if (retptr)
+		*retptr = (char *)s;
+	return 0;
+}
+EXPORT_SYMBOL(memparse_safe);
+
 /**
  * kstrtoull - convert a string to an unsigned long long
  * @s: The start of the string. The string must be null-terminated, and may also
-- 
2.43.0


