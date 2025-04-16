Return-Path: <linux-btrfs+bounces-13063-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0F1A8B4D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13D97A2679
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 09:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69192236A98;
	Wed, 16 Apr 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QvCwDGxB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QvCwDGxB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6052233D87
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794504; cv=none; b=H/nQi88YIDQwwxtgRIOx/6OPC/CxgtACoeWDK8n5wfy7edLDu5X+fF/ynrAm0tKo5lryxkMTO4LCIEmRxF11Cx92qtGYkscxDO3yHG0Kwy19Smk+w9WJtFzjLsi6vBC1i3vaU0m9KIwiIAh6QBZsAq2svbhTcg0OgBM6pxlYMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794504; c=relaxed/simple;
	bh=+gurvpR3aaPA9uUHEgkmBbz5gU1p+UmfYjwJLKQxtDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfevETaJpwaIFgN/94GhK/pMX47iKtKEa3GAV8aE5ha6VZMyEqlhEU/6iycncPG2eLgt3oDGxX8vFv4Cmd95YlymLweWlzdS4BK79ImzaeURBy4I7u3aJ2OljB62VeQHTM5X+TKBRzwnJg9TWnubDh2G1r2uaAGKVvexVgzPZYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QvCwDGxB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QvCwDGxB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A959821197;
	Wed, 16 Apr 2025 09:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrwYIkDa4c/ncLeAAgx3hh/FpVQ6aZ5y/Z8CKvcU4wM=;
	b=QvCwDGxB/C98k7OJaFrjcQs/NYKy4yWCWqRMF6deHcU9rlC0dBKBv9n10OC1fcnM3Ym3Ce
	kX+DUVzl8qghJm5s/3yzbzdfiMHmBBVb3yZcdCwdYTBGopgQ7LRz4OkFB4KYygIp1Ob8YG
	9lSIfl1tTAKUxLmORNFJKL5O4QMrY94=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QvCwDGxB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrwYIkDa4c/ncLeAAgx3hh/FpVQ6aZ5y/Z8CKvcU4wM=;
	b=QvCwDGxB/C98k7OJaFrjcQs/NYKy4yWCWqRMF6deHcU9rlC0dBKBv9n10OC1fcnM3Ym3Ce
	kX+DUVzl8qghJm5s/3yzbzdfiMHmBBVb3yZcdCwdYTBGopgQ7LRz4OkFB4KYygIp1Ob8YG
	9lSIfl1tTAKUxLmORNFJKL5O4QMrY94=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0BB013976;
	Wed, 16 Apr 2025 09:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sTs6J4Rz/2dNbAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Apr 2025 09:08:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: add verbose version of ASSERT
Date: Wed, 16 Apr 2025 11:08:08 +0200
Message-ID: <093bba8a2b23f5bb678aaa9e6824e2bed3b4d2a5.1744794336.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744794336.git.dsterba@suse.com>
References: <cover.1744794336.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A959821197
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently ASSERT prints the stringified condition and without macro
expansions so simple constants like BTRFS_MAX_METADATA_BLOCKSIZE remain
readable in the output.

There are expressions where we'd like to see the exact values but all we
get is someting like:

  assertion failed: em->start <= start && start < extent_map_end(em), in fs/btrfs/extent_map.c:613

It would be nice to be able to print any additional information to help
understand the problem. For that there's now VASSERT and can be used
like:

  VASSERT(value > limit, "value=%llu limit=%llu", value, limit);

with free-form printk arguments that will be part of the assertion
message.

Pros:
- helps debugging and understanding reported problems

Cons:
- increases the .ko size
- writing the message is repetitive (condition, format, values)
- format and variable type must match (extra lookup)

Recommended use is for non-trivial expressions, so basic ASSERT(value) can be
used for pointers or sometimes integers.

The helper btrfs_assertfail_verbose() is inlined because it generates a
bit better assembly (avoids a function call).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 08a9272399d26f..8cca9d834b274d 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -175,10 +175,33 @@ do {								\
 	BUG();								\
 })
 
+__printf(4, 5)
+__cold
+static inline void btrfs_assertfail_verbose(const char *str_expr,
+					    const char *file, int line,
+					    const char *fmt, ...) {
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	pr_err("assertion failed: %s, in %s:%d (%pV)\n", str_expr, file, line, &vaf);
+	va_end(args);
+	BUG();
+}
+
 #define ASSERT(expr)						\
 	(likely(expr) ? (void)0 : btrfs_assertfail(#expr, __FILE__, __LINE__))
+
+/* Verbose assert, use to print any relevant values of the condition. */
+#define VASSERT(expr, fmt, ...)					\
+	(likely(expr) ? (void)0 : btrfs_assertfail_verbose(#expr, __FILE__, __LINE__, \
+							   fmt, __VA_ARGS__))
 #else
 #define ASSERT(expr)	(void)(expr)
+#define VASSERT(expr, fmt, ...)		(void)(expr)
 #endif
 
 __printf(5, 6)
-- 
2.49.0


