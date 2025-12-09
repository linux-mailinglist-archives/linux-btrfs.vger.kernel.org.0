Return-Path: <linux-btrfs+bounces-19606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA4ECB0AFE
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595E9307DC6E
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27FA329E63;
	Tue,  9 Dec 2025 17:11:47 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588B329E6C
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300307; cv=none; b=dGq8htAQXBIR+utxCoqZpBPqPu84UhnPA5ZvmAkvkGGLB4zAQErfY8VC8HKaYh+gBQg9bXBoSy78q1niX7L7z//zU5quGBChLEZaDOLGPNBxi/mrNdlcEEGzvkDsBl6htrXiDioWbDdaFFsr0yba0AbZ/kDReXthGTKBZ++xsQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300307; c=relaxed/simple;
	bh=KwxfKqvHD/4in8Wi75LkTy4y2o/4E/3MxBR3N74e0p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qt16ho5p+C5VEj9vPQnI+yaq9/ayzgWU4LNbDyrwQXDQBUPo05Ym122Uuhi+dluJlhnXmaHbew7ouynXefufzEEL95gaN4sagEJ30LOdZBETKbynk9z+3xvcPmZ3qA5PlQi7lNcVSSKoFSz9UnaK4IDq1TTC8Q1trkt3+VzJJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF8873375E;
	Tue,  9 Dec 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE7543EA63;
	Tue,  9 Dec 2025 17:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id alaVKkRYOGm2aQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 09 Dec 2025 17:11:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: simplify internal btrfs_printk helpers
Date: Tue,  9 Dec 2025 18:10:30 +0100
Message-ID: <4de50956926faa7e474d0b705819dddffadc3121.1765299883.git.dsterba@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: BF8873375E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

The printk() can be compiled out depending on CONFIG_PRINTK, this is
reflected in our helpers. The indirection is provided by btrfs_printk()
used in the ratelimited and RCU wrapper macros.

Drop the btrfs_printk() helper and define the ratelimit and RCU helpers
directly when CONFIG_PRINTK is undefined. This will allow further
changes to the _btrfs_printk() interface (which is internal), any
message in other code should use the level-specific helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index d8c0bd17dcdaf0..7049976342a57a 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -23,9 +23,6 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 
 #ifdef CONFIG_PRINTK
 
-#define btrfs_printk(fs_info, fmt, args...)				\
-	_btrfs_printk(fs_info, fmt, ##args)
-
 __printf(2, 3)
 __cold
 void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
@@ -34,6 +31,13 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 
 #define btrfs_printk(fs_info, fmt, args...) \
 	btrfs_no_printk(fs_info, fmt, ##args)
+
+#define btrfs_printk_in_rcu(fs_info, fmt, args...)			\
+	btrfs_no_printk(fs_info, fmt, ##args)
+
+#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)			\
+	btrfs_no_printk(fs_info, fmt, ##args)
+
 #endif
 
 /*
@@ -78,10 +82,12 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #define btrfs_debug_rl(fs_info, fmt, args...)	do { (void)(fs_info); } while(0)
 #endif
 
+#ifdef CONFIG_PRINTK
+
 #define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
 do {							\
 	rcu_read_lock();				\
-	btrfs_printk(fs_info, fmt, ##args);		\
+	_btrfs_printk(fs_info, fmt, ##args);		\
 	rcu_read_unlock();				\
 } while (0)
 
@@ -93,10 +99,12 @@ do {								\
 								\
 	rcu_read_lock();					\
 	if (__ratelimit(&_rs))					\
-		btrfs_printk(fs_info, fmt, ##args);		\
+		_btrfs_printk(fs_info, fmt, ##args);		\
 	rcu_read_unlock();					\
 } while (0)
 
+#endif
+
 #ifdef CONFIG_BTRFS_ASSERT
 
 __printf(1, 2)
-- 
2.51.1


