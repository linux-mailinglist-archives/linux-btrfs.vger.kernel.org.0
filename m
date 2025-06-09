Return-Path: <linux-btrfs+bounces-14563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE7AD24C6
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3767A7C73
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D99221B905;
	Mon,  9 Jun 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EU0FFu8Y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EU0FFu8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DF21C19C
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488982; cv=none; b=uqo/USMwTke2AGvGUYkVk5B+hMdrwd0ZxeLbh/cikr0uq6p/JYHI1olO8gE0V+D4oiyu6srdhzYh/zx6JkiTw0rRxYwuDkgWVNRyg8jqjig7DZQEKYWDwqasJWc0+HOQphQlpeeionuFrN0pd4CmxNlocrcq0n4qlHkU4VzmBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488982; c=relaxed/simple;
	bh=bb/s67p2uHGHhOzhjQySTzoKcsC25viYn8Je2/ni+Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMOdDT3sgk0Lucredha6i83+b8+j+/8pg+4yr82RDgXViD2EzxDilE02+4lcmNTmghden34IUl4+PyGiHXAKJI1xV2IQRRfn+m4BtRcbxrS6kP9v7CUds5f9oGK0+3FRCDFReyatxu8urOT5LPtoAVvc+TLfFaefCb0ZytFqWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EU0FFu8Y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EU0FFu8Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D68C2211D1;
	Mon,  9 Jun 2025 17:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgFCa57OiWKg3iFcHKoZOV0Hs221mNEJxEd3EtM2BK0=;
	b=EU0FFu8Yqg1xo0WmiehAN1tjMx7ioE5+lgggf/83+i8EWlu/1N7UQ/F8i1G1F7eh0diQo6
	vaQnCWesqKFFlDR3eoySwpQgUhdfyTjV11ux0eIriY6mM9/QNxmroFGhipVvPwUXjefIhS
	0xR45ysvhdrwQaFA9OGEc8zRBfc6u54=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgFCa57OiWKg3iFcHKoZOV0Hs221mNEJxEd3EtM2BK0=;
	b=EU0FFu8Yqg1xo0WmiehAN1tjMx7ioE5+lgggf/83+i8EWlu/1N7UQ/F8i1G1F7eh0diQo6
	vaQnCWesqKFFlDR3eoySwpQgUhdfyTjV11ux0eIriY6mM9/QNxmroFGhipVvPwUXjefIhS
	0xR45ysvhdrwQaFA9OGEc8zRBfc6u54=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF65F137FE;
	Mon,  9 Jun 2025 17:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJOgMlIVR2iLHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/11] btrfs: remove unused rcu-string printk helpers
Date: Mon,  9 Jun 2025 19:09:22 +0200
Message-ID: <46c9f725c5399a2d2b48a317111a6eca35165ca5.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The RCU-string API has never taken off and we don't use the printk
helpers provided as we do the protection in our helpers. Remove the "in
RCU" wrappers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h   |  4 ++--
 fs/btrfs/rcu-string.h | 12 ------------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 6abf81bb00c2fe..12d798802a010f 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -53,7 +53,7 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
 
 /*
- * Wrappers that use printk_in_rcu
+ * Wrappers that use printk in RCU
  */
 #define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
@@ -71,7 +71,7 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
- * Wrappers that use a ratelimited printk_in_rcu
+ * Wrappers that use a ratelimited printk in RCU
  */
 #define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
diff --git a/fs/btrfs/rcu-string.h b/fs/btrfs/rcu-string.h
index 7f35cf75b50ff3..70b1e19b50e666 100644
--- a/fs/btrfs/rcu-string.h
+++ b/fs/btrfs/rcu-string.h
@@ -32,18 +32,6 @@ static inline struct rcu_string *rcu_string_strdup(const char *src, gfp_t mask)
 	return ret;
 }
 
-#define printk_in_rcu(fmt, ...) do {	\
-	rcu_read_lock();		\
-	printk(fmt, __VA_ARGS__);	\
-	rcu_read_unlock();		\
-} while (0)
-
-#define printk_ratelimited_in_rcu(fmt, ...) do {	\
-	rcu_read_lock();				\
-	printk_ratelimited(fmt, __VA_ARGS__);		\
-	rcu_read_unlock();				\
-} while (0)
-
 #define rcu_str_deref(rcu_str) ({				\
 	struct rcu_string *__str = rcu_dereference(rcu_str);	\
 	__str->str;						\
-- 
2.49.0


