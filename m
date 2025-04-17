Return-Path: <linux-btrfs+bounces-13118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EABA91779
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743485A3E88
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154C22422F;
	Thu, 17 Apr 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oGlDCg2n";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oGlDCg2n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79C33FD
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881445; cv=none; b=ADgwuq8cQMRlq2jAGtoqfd2bVaVlhouBx7Ha0M40CSZAg13YNgHpx45UJaCEckJxNg3EzdLu+Rr+Nnb9bzLo06M1JjP1HSxMfgezVzFXHS2d/DCkA36/48vrh1oXv4LmEt3YFTDiryNBUXlsG8TDliAca1gkd/ZVRG+b9wxrmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881445; c=relaxed/simple;
	bh=iz4utMiJ5S9GjvV3TLvUz2HYlEhtVZifZSxH1vYCcQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7VNZvDCMpA/DJ3ZDzZE3CDhBqhCNPjCOG3INQv2IRqKDpxQ9UspApmN2weuMIiqsBTceC8LDq/eWjVuKJogprNAlKMioE0LQPam72Oum+yivbBrOHyMB6d2jE+/pMLKflXdD8sImYZbyanQvgKEF8odxG4/9UW/sNWpT9j6qRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oGlDCg2n; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oGlDCg2n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B20691F6E6;
	Thu, 17 Apr 2025 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744881436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHyhbWf8czBiEDUESD2ovpcMDSOoZreIQY1D5WKnezY=;
	b=oGlDCg2nMRq3V0yEUFti0jUsRbw79M1PNnDRiP+rx2oA7MEfO0wBn75PQ4IBJedGEEYbAQ
	EuyvfreBQo+6lkylprcvpe/t+FzIgaSHg5EyjXRCWtEUJYqj9e8RY32vtrJUqfZTiblNWr
	HsEbB9qgxgR6PtZb3f8SEMoH9tY1Us0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744881436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHyhbWf8czBiEDUESD2ovpcMDSOoZreIQY1D5WKnezY=;
	b=oGlDCg2nMRq3V0yEUFti0jUsRbw79M1PNnDRiP+rx2oA7MEfO0wBn75PQ4IBJedGEEYbAQ
	EuyvfreBQo+6lkylprcvpe/t+FzIgaSHg5EyjXRCWtEUJYqj9e8RY32vtrJUqfZTiblNWr
	HsEbB9qgxgR6PtZb3f8SEMoH9tY1Us0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB988137CF;
	Thu, 17 Apr 2025 09:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlriKRzHAGi4cQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:17:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 1/5] btrfs: enhance ASSERT() to take optional format string
Date: Thu, 17 Apr 2025 11:16:59 +0200
Message-ID: <ee835f251bc6e8fa75f340ccc4fc7bfec75303d4.1744881160.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744881159.git.dsterba@suse.com>
References: <cover.1744881159.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Currently ASSERT() prints the stringified condition and without macro
expansions so simple constants like BTRFS_MAX_METADATA_BLOCKSIZE remain
readable in the output.

There are expressions where we'd like to see the exact values but all we
get is something like:

  assertion failed: em->start <= start && start < extent_map_end(em), in fs/btrfs/extent_map.c:613

It would be nice to be able to print any additional information to help
understand the problem. With some preprocessor magic and compile-time
optimizations we can enhance ASSERT to work like that as well:

  ASSERT(value > limit, "value=%llu limit=%llu", value, limit);

with free-form printk arguments that will be part of the assertion
message.

Pros:
- helps debugging and understanding reported problems
- the optional format is verified at compile-time

Cons:
- increases the .ko size
- writing the message is repetitive (condition, format, values)
- format and variable type must match (extra lookup)

Recommended use is for non-trivial expressions, so basic ASSERT(value) can be
used for pointers or sometimes integers.

The format has been slightly updated to also print the result of the
evaluation of the condition, appended to the stringified condition as
"condition :: <value>".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 52 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 08a9272399d26f..c9031fee7169eb 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -170,15 +170,53 @@ do {								\
 
 #ifdef CONFIG_BTRFS_ASSERT
 
-#define btrfs_assertfail(expr, file, line)	({				\
-	pr_err("assertion failed: %s, in %s:%d\n", (expr), (file), (line));	\
-	BUG();								\
-})
+__printf(1, 2)
+static inline void verify_assert_printk_format(const char *fmt, ...) {
+	/* Stub to verify the assertion format string. */
+}
+
+/* Take the first token if any. */
+#define __FIRST_ARG(_, ...) _
+/* Skip the first token and return the rest, if it's empty the comma is dropped. */
+#define __REST_ARGS(_, ...) __VA_OPT__(,) __VA_ARGS__
+
+/*
+ * Assertion with optional printk() format.
+ *
+ * Accepted syntax:
+ * ASSERT(condition);
+ * ASSERT(condition, "string");
+ * ASSERT(condition, "variable=%d", variable);
+ *
+ * How it works:
+ * - if there's no format string, ""[0] evaluates at compile time to 0 and the
+ *   first branch is executed
+ * - any non-empty format string with the "" prefix evaluates to != 0 at
+ *   compile time and the second branch is executed
+ * - stringified condition is printed as %s so we don't accidentally mix format
+ *   strings (the % operator)
+ * - there can be only one printk() call, so the format strings and arguments are
+ *   spliced together:
+ *   DEFAULT_FMT USER_FMT, DEFAULT_ARGS [,] USER_ARGS
+ * - comma between DEFAULT_ARGS and USER_ARGS is handled by preprocessor
+ */
+#define ASSERT(cond, args...)							\
+do {										\
+	verify_assert_printk_format("not empty" args);				\
+	if (!likely(cond)) {							\
+		if (("" __FIRST_ARG(args) [0]) == 0) {				\
+			pr_err("assertion failed: %s :: %ld, in %s:%d\n",	\
+				#cond, (long)(cond), __FILE__, __LINE__);	\
+		} else {							\
+			pr_err("assertion failed: %s :: %ld, in %s:%d (" __FIRST_ARG(args) ")\n", \
+				#cond, (long)(cond), __FILE__, __LINE__ __REST_ARGS(args)); \
+		}								\
+		BUG();								\
+	}									\
+} while(0)
 
-#define ASSERT(expr)						\
-	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
 #else
-#define ASSERT(expr)	(void)(expr)
+#define ASSERT(cond, args...)	(void)(cond)
 #endif
 
 __printf(5, 6)
-- 
2.49.0


