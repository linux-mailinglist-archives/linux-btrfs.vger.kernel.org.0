Return-Path: <linux-btrfs+bounces-21386-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEypKSyDhGl/3AMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21386-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 12:46:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68352F207D
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 12:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91CD2301F17A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1562B3B8D41;
	Thu,  5 Feb 2026 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6ArHZwr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s6ArHZwr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315D735D5E5
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291951; cv=none; b=sagIVEVfo+/SkEzVx3RF+tswwB0TyStGPSpsrHuA/Xv9L4Fav+1hF2qfdue8nB+gJKApge32JJ5FlmaMurNEngeY5sRiFpaiNN+krIuZzwY2vD9Z1unqA1F0D+lrlCZCkVWtp0rn0wxYSy5hHVamN17kpz9+GOQclkackU1QK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291951; c=relaxed/simple;
	bh=QVlnjWoqLzuzpLHNA93cGmp4LqFjHlOgpEffLSEPiTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBMNBIPdBXVN2LCk08eO6rjMG1bSesAg/q86/WzdxzEQ4ek24D3CnpTa4QSAL8a0izrQRo196hdpjUEEpaLQzrGP5nLIoHNAZ+PcgvmA2AenZdoXr6Ll+dYAbTaA2Omr8iEsgWAofy7hcf+e6KqjDpXk9crHHHDB9J1RQckUdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6ArHZwr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s6ArHZwr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69E0E3E7BC;
	Thu,  5 Feb 2026 11:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770291949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/ngeFNHi45jT+Jhqi64qRhVkmje7cSphvh6HqZXSCh0=;
	b=s6ArHZwrnaCJ3yA4X9xVh2qxeHoCvDFtZVZlcJNq1N8UbpKvVAxuRFYBQJz/nvRuZ7ot61
	WfIB3z2qO6zIvGGLDk+wtBLL9zOyfqZWAwk1a4JyJbZlSqeMpq1X6vriPqeOk0ShdyVE5U
	6Zu2bqJ7MmaiAPzm22E+e7pA+9LZ4/0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770291949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/ngeFNHi45jT+Jhqi64qRhVkmje7cSphvh6HqZXSCh0=;
	b=s6ArHZwrnaCJ3yA4X9xVh2qxeHoCvDFtZVZlcJNq1N8UbpKvVAxuRFYBQJz/nvRuZ7ot61
	WfIB3z2qO6zIvGGLDk+wtBLL9zOyfqZWAwk1a4JyJbZlSqeMpq1X6vriPqeOk0ShdyVE5U
	6Zu2bqJ7MmaiAPzm22E+e7pA+9LZ4/0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5827E3EA63;
	Thu,  5 Feb 2026 11:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sdJ+Fe2ChGm9EQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 05 Feb 2026 11:45:49 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sink RCU protection to _btrfs_printk()
Date: Thu,  5 Feb 2026 12:45:46 +0100
Message-ID: <20260205114546.210418-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21386-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 68352F207D
X-Rspamd-Action: no action

Since commit 0e26727a731adf ("btrfs: switch all message helpers to be
RCU safe") the RCU protection is applied to all printk helpers,
explicitly in the wrapping macros. This inlines the code around each
message call but this is in no way a hot path so the RCU protection can
be sunk further to _btrfs_printk().

This change saves about 10K of btrfs.ko size on x86_64 release config:

   text	   data	    bss	    dec	    hex	filename
1722927	 148328	  15560	1886815	 1cca5f	pre/btrfs.ko
1712221	 148760	  15560	1876541	 1ca23d	post/btrfs.ko

DELTA: -10706

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 4 ++++
 fs/btrfs/messages.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 6190777924bff5..49774980bab6c9 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -219,6 +219,8 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, cons
 	const char *type = logtypes[level];
 	struct ratelimit_state *ratelimit = &printk_limits[level];
 
+	rcu_read_lock();
+
 #ifdef CONFIG_PRINTK_INDEX
 	printk_index_subsys_emit("%sBTRFS %s (device %s): ", NULL, fmt);
 #endif
@@ -241,6 +243,8 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, cons
 	}
 
 	va_end(args);
+
+	rcu_read_unlock();
 }
 #endif
 
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 943e53980945ea..73a44f464664c5 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -85,9 +85,7 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, unsigned int level, cons
 
 #define btrfs_printk_in_rcu(fs_info, level, fmt, args...)	\
 do {								\
-	rcu_read_lock();					\
 	_btrfs_printk(fs_info, level, fmt, ##args);		\
-	rcu_read_unlock();					\
 } while (0)
 
 #define btrfs_printk_rl_in_rcu(fs_info, level, fmt, args...)	\
@@ -96,10 +94,8 @@ do {								\
 		DEFAULT_RATELIMIT_INTERVAL,			\
 		DEFAULT_RATELIMIT_BURST);			\
 								\
-	rcu_read_lock();					\
 	if (__ratelimit(&_rs))					\
 		_btrfs_printk(fs_info, level, fmt, ##args);	\
-	rcu_read_unlock();					\
 } while (0)
 
 #endif
-- 
2.51.1


