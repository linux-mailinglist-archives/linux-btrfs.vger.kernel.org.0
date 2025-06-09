Return-Path: <linux-btrfs+bounces-14565-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D8AD24C2
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053FA3AE870
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4E21CC55;
	Mon,  9 Jun 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="msFFtvH7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="msFFtvH7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA821B9FD
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488989; cv=none; b=UVXmjK94g+RVTrzlcmMeWF+I5/iOqrfcOh1j8qwx1bJrFQFz0jCGJfTlZLe4RSUc0cafeIoGO6fje3z/GiiYipdn0A8cdpEvtSWy1eyscfhxzT+QZMidYB5W1jiKf/0eey8owiWBkxo4hCbOLjLPNN63XerHnUESlgyA428R+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488989; c=relaxed/simple;
	bh=pAMhIbBtEdI44cAEfiDeZoyXv+wefgeL4Gxnsat0vq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jURyQV57hSo639jkqG3EAaVGgmLevTFIq+oV6Rw/UNY9ptXOyZE01HapwgP8cVx7LLViN6UIk8wpYuPZe234imSiSc11xuDcTHBy6rKVSH0bwIfB1jHUO56lO2lYP4GIKYqJMRKvfKU98a+TYMZJMqqvuRJlcTMzp9TdvbJO8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=msFFtvH7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=msFFtvH7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4E910211AA;
	Mon,  9 Jun 2025 17:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Teuakr7T6wqTQB/vRHoSLQE9IdhVE7i48SPq4e55VM=;
	b=msFFtvH7aJ5SSpHGXaVi5PGwbc1F22/owF/SLWY/GFnEU6uOAHU05mti8+3lqh/7tMX3xQ
	58gdpQ7+oj/silNWd3jXSa6DmZS7F1tJDOS9rWXFMY0AW5Uwz0gWXx5LiJxMUCccynr4Xu
	H2snq4dG2td+9k/vDlkKQx8Lw/RJ9C8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Teuakr7T6wqTQB/vRHoSLQE9IdhVE7i48SPq4e55VM=;
	b=msFFtvH7aJ5SSpHGXaVi5PGwbc1F22/owF/SLWY/GFnEU6uOAHU05mti8+3lqh/7tMX3xQ
	58gdpQ7+oj/silNWd3jXSa6DmZS7F1tJDOS9rWXFMY0AW5Uwz0gWXx5LiJxMUCccynr4Xu
	H2snq4dG2td+9k/vDlkKQx8Lw/RJ9C8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46C53137FE;
	Mon,  9 Jun 2025 17:09:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N81EEVcVR2iQHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/11] btrfs: switch all message helpers to be RCU safe
Date: Mon,  9 Jun 2025 19:09:24 +0200
Message-ID: <077217f58f81b0e1257cf5d8b9f5ceb53ab08853.1749488829.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

We have two versions of message helpers, one that provides RCU
protection around the call in case we need to dereference device name.
As messages are not performance critical we can set up the RCU
protection for all of them and drop the distinction for those where
device name is needed. This will lead to further simplifications.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index f6b3989939b56f..fe9a92da6b1439 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -37,14 +37,17 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 	btrfs_no_printk(fs_info, fmt, ##args)
 #endif
 
+/*
+ * Print a message with filesystem info, enclosed in RCU protection.
+ */
 #define btrfs_crit(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use printk in RCU
@@ -74,17 +77,17 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  * Wrappers that use a ratelimited printk
  */
 #define btrfs_crit_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define btrfs_debug(fs_info, fmt, args...)				\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk,			\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
 				   fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_in_rcu(fs_info, fmt, args...)			\
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_in_rcu,		\
@@ -93,26 +96,26 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
 				   fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...)				\
-	_dynamic_func_call_no_desc(fmt, btrfs_printk_ratelimited,	\
+	_dynamic_func_call_no_desc(fmt, btrfs_printk_rl_in_rcu,		\
 				   fs_info, KERN_DEBUG fmt, ##args)
 #elif defined(DEBUG)
 #define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_printk_rl_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #else
 #define btrfs_debug(fs_info, fmt, args...) \
-	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_in_rcu(fs_info, fmt, args...) \
 	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #define btrfs_debug_rl(fs_info, fmt, args...) \
-	btrfs_no_printk(fs_info, KERN_DEBUG fmt, ##args)
+	btrfs_no_printk_in_rcu(fs_info, KERN_DEBUG fmt, ##args)
 #endif
 
 #define btrfs_printk_in_rcu(fs_info, fmt, args...)	\
-- 
2.49.0


