Return-Path: <linux-btrfs+bounces-19607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF4CB0AE0
	for <lists+linux-btrfs@lfdr.de>; Tue, 09 Dec 2025 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77E00301D873
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Dec 2025 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC032A3C0;
	Tue,  9 Dec 2025 17:11:54 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AC328614
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Dec 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300314; cv=none; b=CSpD9q6AJB2ZOsWy1xnNzMFm6E7dE8x/KWvplsNxvSLlZoUljer2yNSsTVn0TB+sKzZHWZfVlJG3Y6v/6ArIXEp/vH5MKlp+ihv4z1/ZhdIs5745pQHrpCp3YctsWcf5r0Np0sM9wH1ggq7SKNDHl2CAc4Lf2cXDN1aePWty12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300314; c=relaxed/simple;
	bh=ODmyhvmSqjJRiHjjp+h95PFG/RFYikhvJBI8lpn7HxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1+1zaDcUMbT3LHBKYUbMnXsmzdwpIsYzn/oXLclSAZq6g41fBUYV3SbdAwbhs1iQE0Yabg97DO/mIU/P2NefooRJKI1O0ZU52Jv8OwUQIO+EycwNPoV9dbyiejxPd4zJzb4BqMwAMz1UHpQf2REQTQepRXW92m1iGaLb5/b44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E34A4337AC;
	Tue,  9 Dec 2025 17:11:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC9E3EA63;
	Tue,  9 Dec 2025 17:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yB/lNUZYOGm4aQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 09 Dec 2025 17:11:34 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: pass level to _btrfs_printk() to avoid parsing level from string
Date: Tue,  9 Dec 2025 18:10:31 +0100
Message-ID: <f884e72071839aeb0f8b77e79a6ae2d0bc8adf78.1765299883.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: E34A4337AC
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

There's code in _btrfs_printk() to parse the message level from the
input string so we can augment the message with the level description
for better visibility in the logs.

The parsing code has evolved over time, see commits:

- 40f7828b36e3b9 ("btrfs: better handle btrfs_printk() defaults")

- 262c5e86fec7cf ("printk/btrfs: handle more message headers")

- 533574c6bc30cf ("btrfs: use printk_get_level and printk_skip_level, add __printf, fix fallout")

- 4da35113426d16 ("btrfs: add varargs to btrfs_error")

As we are using the specific level helpers everywhere we can simply pass
the message level so we don't have to parse it. The proper printk()
message header is created as KERN_SOH + "level".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 26 ++++++------------------
 fs/btrfs/messages.h | 49 ++++++++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 2f853de4447398..6190777924bff5 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -211,33 +211,19 @@ static struct ratelimit_state printk_limits[] = {
 	RATELIMIT_STATE_INIT(printk_limits[7], DEFAULT_RATELIMIT_INTERVAL, 100),
 };
 
-void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
+__printf(3, 4) __cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, const char *fmt, ...)
 {
-	char lvl[PRINTK_MAX_SINGLE_HEADER_LEN + 1] = "\0";
 	struct va_format vaf;
 	va_list args;
-	int kern_level;
-	const char *type = logtypes[4];
-	struct ratelimit_state *ratelimit = &printk_limits[4];
+	const char *type = logtypes[level];
+	struct ratelimit_state *ratelimit = &printk_limits[level];
 
 #ifdef CONFIG_PRINTK_INDEX
 	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
 #endif
 
 	va_start(args, fmt);
-
-	while ((kern_level = printk_get_level(fmt)) != 0) {
-		size_t size = printk_skip_level(fmt) - fmt;
-
-		if (kern_level >= '0' && kern_level <= '7') {
-			memcpy(lvl, fmt,  size);
-			lvl[size] = '\0';
-			type = logtypes[kern_level - '0'];
-			ratelimit = &printk_limits[kern_level - '0'];
-		}
-		fmt += size;
-	}
-
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
@@ -247,10 +233,10 @@ void __cold _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt,
 			char statestr[STATE_STRING_BUF_LEN];
 
 			btrfs_state_to_string(fs_info, statestr);
-			_printk("%sBTRFS %s (device %s%s): %pV\n", lvl, type,
+			_printk(KERN_SOH "%dBTRFS %s (device %s%s): %pV\n", level, type,
 				fs_info->sb->s_id, statestr, &vaf);
 		} else {
-			_printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);
+			_printk(KERN_SOH "%dBTRFS %s: %pV\n", level, type, &vaf);
 		}
 	}
 
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 7049976342a57a..d4e4cad0609255 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -23,19 +23,18 @@ void btrfs_no_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...)
 
 #ifdef CONFIG_PRINTK
 
-__printf(2, 3)
-__cold
-void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
+__printf(3, 4) __cold
+void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, const char *fmt, ...);
 
 #else
 
-#define btrfs_printk(fs_info, fmt, args...) \
+#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
 	btrfs_no_printk(fs_info, fmt, ##args)
 
-#define btrfs_printk_in_rcu(fs_info, fmt, args...)			\
+#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)		\
 	btrfs_no_printk(fs_info, fmt, ##args)
 
-#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)			\
+#define btrfs_printk_rl_in_rcu(fs_info, level, fmt, args...)		\
 	btrfs_no_printk(fs_info, fmt, ##args)
 
 #endif
@@ -44,38 +43,38 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  * Print a message with filesystem info, enclosed in RCU protection.
  */
 #define btrfs_crit(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, LOGLEVEL_CRIT, fmt, ##args)
 #define btrfs_err(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, LOGLEVEL_ERR, fmt, ##args)
 #define btrfs_warn(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, LOGLEVEL_WARNING, fmt, ##args)
 #define btrfs_info(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, LOGLEVEL_INFO, fmt, ##args)
 
 /*
  * Wrappers that use a ratelimited printk
  */
 #define btrfs_crit_rl(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEL_CRIT, fmt, ##args)
 #define btrfs_err_rl(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEL_ERR, fmt, ##args)
 #define btrfs_warn_rl(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEL_WARNING, fmt, ##args)
 #define btrfs_info_rl(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEL_INFO, fmt, ##args)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define btrfs_debug(fs_info, fmt, args...)				\
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
+				   fs_info, LOGLEVEL_DEBUG, fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...)				\
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
-				   fs_info, KERN_DEBUG fmt, ##args)
+				   fs_info, LOGLEVEL_DEBUG, fmt, ##args)
 #elif defined(DEBUG)
 #define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, LOGLEVEL_DEBUG, fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, LOGLEVEl_DEBUG, fmt, ##args)
 #else
 /* When printk() is no_printk(), expand to no-op. */
 #define btrfs_debug(fs_info, fmt, args...)	do { (void)(fs_info); } while(0)
@@ -84,14 +83,14 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 
 #ifdef CONFIG_PRINTK
 
-#define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
-do {							\
-	rcu_read_lock();				\
-	_btrfs_printk(fs_info, fmt, ##args);		\
-	rcu_read_unlock();				\
+#define btrfs_printk_in_rcu(fs_info, level, fmt, args...)	\
+do {								\
+	rcu_read_lock();					\
+	_btrfs_printk(fs_info, level, fmt, ##args);		\
+	rcu_read_unlock();					\
 } while (0)
 
-#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
+#define btrfs_printk_rl_in_rcu(fs_info, level, fmt, args...)	\
 do {								\
 	static DEFINE_RATELIMIT_STATE(_rs,			\
 		DEFAULT_RATELIMIT_INTERVAL,			\
@@ -99,7 +98,7 @@ do {								\
 								\
 	rcu_read_lock();					\
 	if (__ratelimit(&_rs))					\
-		_btrfs_printk(fs_info, fmt, ##args);		\
+		_btrfs_printk(fs_info, level, fmt, ##args);	\
 	rcu_read_unlock();					\
 } while (0)
 
-- 
2.51.1


