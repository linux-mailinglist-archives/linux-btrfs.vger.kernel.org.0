Return-Path: <linux-btrfs+bounces-14570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBC9AD24CE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C9C7A8D9C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BB521CA16;
	Mon,  9 Jun 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SS4dtPCI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SS4dtPCI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BB21D3D2
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489007; cv=none; b=oT6StbbzvaeWRpYwZql7kC5Rmg/l7psL3iYSwkSQ+dMKNQidLy+GO8kmCpTmzpgKNDrMwL30pUpxoBBL2RRyTuZfoRx7c30jKec5cXqrMQ65f7CNTr+DzHEheFeXuXYYad931qmCl8KGYzNGpgLeQL+sIy9mSbHbTfwg9wsSs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489007; c=relaxed/simple;
	bh=aH4X4VwxtOWCPNIutQOVvKVMp6c7RAk5kC4QkvrxORU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnvnv1eeIJT68vU3azHNrKa/b2x8l6UEcZv573a9btm1xr9VKjn4x4WlJL/Xv7SlBomKQpz8ecyRhYbb06UgGwdZanzGpjGg5VAZ6l7sjqSqkFyXUsWQLrpc4IuFuyrlUEepi9xKkB4oCV4QxQwOLuNXrgi+aWIbzpS/ZUK8u9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SS4dtPCI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SS4dtPCI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A6B51F766;
	Mon,  9 Jun 2025 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl8ZHvA9SDvBpR6910p3UElMavKi06SJNvAyc/tB6AM=;
	b=SS4dtPCI61Q8XWthHAicpwEhthJFEUu+2Ns8TpF+NQqwG63/DeT3ZxZKd/Ya9KUOhktISc
	JDp5ssTVAxlzeLSaUmGtC094nEyddonRavjb9yQ3AhyasaFIhyrVW2IPMbsyWDoFCMTULf
	h9N53KQWwnZJasOjl2JbcVtXmgGf7r4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SS4dtPCI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kl8ZHvA9SDvBpR6910p3UElMavKi06SJNvAyc/tB6AM=;
	b=SS4dtPCI61Q8XWthHAicpwEhthJFEUu+2Ns8TpF+NQqwG63/DeT3ZxZKd/Ya9KUOhktISc
	JDp5ssTVAxlzeLSaUmGtC094nEyddonRavjb9yQ3AhyasaFIhyrVW2IPMbsyWDoFCMTULf
	h9N53KQWwnZJasOjl2JbcVtXmgGf7r4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72F3D137FE;
	Mon,  9 Jun 2025 17:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xIsMHGoVR2izHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:10:02 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/11] btrfs: remove remaining unused message helpers
Date: Mon,  9 Jun 2025 19:09:29 +0200
Message-ID: <8f3b25aabdad97c3df0b0be427b134b0487fd744.1749488829.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7A6B51F766
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Remove the critical level message helpers as they're not used, the RCU
protection is provided by the plain helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 659889faec8518..9b78600efe0eb1 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -49,18 +49,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 #define btrfs_info(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
-/*
- * Wrappers that use printk in RCU
- */
-#define btrfs_crit_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-
-/*
- * Wrappers that use a ratelimited printk in RCU
- */
-#define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-
 /*
  * Wrappers that use a ratelimited printk
  */
-- 
2.49.0


