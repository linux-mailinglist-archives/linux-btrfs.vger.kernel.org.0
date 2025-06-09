Return-Path: <linux-btrfs+bounces-14566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604BEAD24C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE9E3AD154
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943D21C18D;
	Mon,  9 Jun 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cd/Fp/KQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cd/Fp/KQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0CD21B9F2
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488994; cv=none; b=Y8YLUBlOtZRmrSFkugHMSBXuWi8Jj4gfzUHt0LsGOoDITliFde//AUG6gt4d4hnilF102XYRIkOqg9bOug/+LF3hbvDeOUAcE69+XbyHTcLTfVVr3DzGMbic5cXRvLT1ijUsdRTqgaYjSUNA3olYV6SLzkPYDAXep/7jg9MyiNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488994; c=relaxed/simple;
	bh=JwKqNXVmr0wdpwDfUof6EL9dUUpmHESzrps/O7CtYlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYxlcHPwLKvxahuSZM46J3AEQpjKz+Mh7E8OFXWBlRRaKp4sMIEJk5r1VsVRuve54PTsFeddOL4WTOkjgv36Ee8+GIeQG12/lCRrHN0/mdnXG6q+T9AtZqOw7gfEThHWYyZJrjNYhrgQdzAWJB6LnA50iDwW78bU1cSJrOhyyPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cd/Fp/KQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cd/Fp/KQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AA2B1F766;
	Mon,  9 Jun 2025 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/A+eriHLf4CKsKOlLn+PNgX0q1dQbbN3KfWHfXD73Ic=;
	b=cd/Fp/KQq0p71+4GQ68lAOTcZnBq8dBbMoLV+3sVK55kCTfglkOx0tKILG7fPQy2N71999
	79VoqenvDtO/K02aCmOpIZNV0Mdt+x4msiIlsXW/QUK7O6j/F7MSJhFauO7XsGtfZXBV73
	XkQFC2lO1OAEGw/VH9Lj9KY6Kz5WmFY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="cd/Fp/KQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/A+eriHLf4CKsKOlLn+PNgX0q1dQbbN3KfWHfXD73Ic=;
	b=cd/Fp/KQq0p71+4GQ68lAOTcZnBq8dBbMoLV+3sVK55kCTfglkOx0tKILG7fPQy2N71999
	79VoqenvDtO/K02aCmOpIZNV0Mdt+x4msiIlsXW/QUK7O6j/F7MSJhFauO7XsGtfZXBV73
	XkQFC2lO1OAEGw/VH9Lj9KY6Kz5WmFY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12A01137FE;
	Mon,  9 Jun 2025 17:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TjSKBFUVR2iOHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 03/11] btrfs: remove unused levels of message helpers
Date: Mon,  9 Jun 2025 19:09:23 +0200
Message-ID: <94ecc86cb13913270b96163ef77362064e9a2b3b.1749488829.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 1AA2B1F766
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

We're using the following levels: crit, err, warn, info, debug. This
covers our needs and further specializations is not needed, so let's
remove emerg, alert and notice.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 12d798802a010f..f6b3989939b56f 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -37,72 +37,48 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
 	btrfs_no_printk(fs_info, fmt, ##args)
 #endif
 
-#define btrfs_emerg(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_ALERT fmt, ##args)
 #define btrfs_crit(fs_info, fmt, args...) \
 	btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err(fs_info, fmt, args...) \
 	btrfs_printk(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn(fs_info, fmt, args...) \
 	btrfs_printk(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice(fs_info, fmt, args...) \
-	btrfs_printk(fs_info, KERN_NOTICE fmt, ##args)
 #define btrfs_info(fs_info, fmt, args...) \
 	btrfs_printk(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use printk in RCU
  */
-#define btrfs_emerg_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_ALERT fmt, ##args)
 #define btrfs_crit_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
 #define btrfs_info_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use a ratelimited printk in RCU
  */
-#define btrfs_emerg_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_ALERT fmt, ##args)
 #define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_NOTICE fmt, ##args)
 #define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use a ratelimited printk
  */
-#define btrfs_emerg_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_EMERG fmt, ##args)
-#define btrfs_alert_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_ALERT fmt, ##args)
 #define btrfs_crit_rl(fs_info, fmt, args...) \
 	btrfs_printk_ratelimited(fs_info, KERN_CRIT fmt, ##args)
 #define btrfs_err_rl(fs_info, fmt, args...) \
 	btrfs_printk_ratelimited(fs_info, KERN_ERR fmt, ##args)
 #define btrfs_warn_rl(fs_info, fmt, args...) \
 	btrfs_printk_ratelimited(fs_info, KERN_WARNING fmt, ##args)
-#define btrfs_notice_rl(fs_info, fmt, args...) \
-	btrfs_printk_ratelimited(fs_info, KERN_NOTICE fmt, ##args)
 #define btrfs_info_rl(fs_info, fmt, args...) \
 	btrfs_printk_ratelimited(fs_info, KERN_INFO fmt, ##args)
 
-- 
2.49.0


