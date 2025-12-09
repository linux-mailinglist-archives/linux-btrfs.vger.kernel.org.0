Return-Path: <linux-btrfs+bounces-19608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9DCB0B05
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 18:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6C4310BAAC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DF6329E75;
	Tue,  9 Dec 2025 17:12:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B0329E6C
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300321; cv=none; b=Z4O41lcUCt9WXwAkh8htV4o+jayNWWP4BIWjrlL/ikmhJz4Sykrhq9cU3PCvKLmDpUbL/UonkH4uzKaLmIJgy+ZC5eZNb9NtpncP+UrNTAb4ryTXmVIf0r+MGG3GAoLzsb/fkrRrOIAaqiNZxJvl1n+zmvMz5BN81sfgcNW4f80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300321; c=relaxed/simple;
	bh=PJ0bpv6MD2ewG28V6vHzWclG8CkHssoYWZWqYtBNLNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi7yhFaWdipkcO2/j/s2jIlHjb1MJaUJqcGgN0mE+FgZK+6yWtYM0IVotcMcm+JvsKxYLlyajJd4dGo1+HUCTks6c+gzsXhMLMgmP68UcOHlGwHI+9D5jvmUSHTzJ9C2X5PFXVOPZp8KakcGF1jW9kXaRANTGFF0HzF/5AwiHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28693337AD;
	Tue,  9 Dec 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22D903EA63;
	Tue,  9 Dec 2025 17:11:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UImCCElYOGnCaQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 09 Dec 2025 17:11:37 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/3] btrfs: remove ASSERT compatibility for gcc < 8.x
Date: Tue,  9 Dec 2025 18:10:32 +0100
Message-ID: <bd0ed1e6b9b35804fdacb1bd1a6829f5ccc23073.1765299883.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765299883.git.dsterba@suse.com>
References: <cover.1765299883.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 28693337AD
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Rspamd-Action: no action

The minimum gcc version is 8 since 118c40b7b50340 ("kbuild: require
gcc-8 and binutils-2.30"), the workaround for missing __VA_OPT__ support
is not needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index d4e4cad0609255..943e53980945ea 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -120,7 +120,6 @@ static inline void verify_assert_printk_format(const char *fmt, ...) {
  */
 #define __REST_ARGS(_, ... ) __VA_OPT__(,) __VA_ARGS__
 
-#if defined(CONFIG_CC_IS_CLANG) || GCC_VERSION >= 80000
 /*
  * Assertion with optional printk() format.
  *
@@ -158,22 +157,6 @@ do {										\
 	}									\
 } while(0)
 
-#else
-
-/* For GCC < 8.x only the simple output. */
-
-#define ASSERT(cond, args...)							\
-do {										\
-	verify_assert_printk_format("check the format string" args);		\
-	if (!likely(cond)) {							\
-		pr_err("assertion failed: %s :: %ld, in %s:%d\n",		\
-			#cond, (long)(cond), __FILE__, __LINE__);		\
-		BUG();								\
-	}									\
-} while(0)
-
-#endif
-
 #else
 /* Compile check the @cond expression but don't generate any code. */
 #define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
-- 
2.51.1


