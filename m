Return-Path: <linux-btrfs+bounces-14572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7C3AD24C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFEE718908DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130DB21CC46;
	Mon,  9 Jun 2025 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ADjFiNZ+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ADjFiNZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557221C184
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489014; cv=none; b=ENRNc1fawybJFqFeHxNcZUNl5wgMG6eApX2D/TNyYzMIII3LA+rRrVmiyA26UFZFUyN9f6A9sdVZvFeJws8Qqz4GWL3vKlr2JU/UdT+edJcu2HSZ1MpLtQDJxmy692oXuew8T7KX5XRiiFALvWH1N2Y8cNpxV0RvhHXqZ0bBjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489014; c=relaxed/simple;
	bh=iSlmceSvsbMrwyCcBUdc/IxvGPnajPZOTVI98aGt7WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw7qTn3UZ/r2LuAPHU/u3BH4H32kifZS7jyIblSuP9Jotilo+zuyZ+X2ANO711wOZcyUQm8TZtLBJkJYu0SZ9CiTl7pSvXl8vWAktGwtbPvCPGOfXkp2asz8jWRnEKB03UW06XUskBUxXvKO2qbGm9V3uDUExo9oKoZyHHSyVNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ADjFiNZ+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ADjFiNZ+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17A511F79C;
	Mon,  9 Jun 2025 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7BuLvdZnDEJm1km0zGJ4pk77jefYwzDKmMUvlNltq8=;
	b=ADjFiNZ+rDYkmbxAaKt/i9Hrw8LsdLbtt/dDXzO4idPSxS3y7KhizJ2/rkiy1Z5sl4OMZ5
	HEbiTYSgi9ySsl8lpwUKn9bn2aRzqyGHzsol2CwRN+9GCN+HpJ3EuclNRwhNZVStkvXBVB
	4ls0qQwD9JjS80EzVT4OTyK8ayU7aLA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ADjFiNZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749489007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7BuLvdZnDEJm1km0zGJ4pk77jefYwzDKmMUvlNltq8=;
	b=ADjFiNZ+rDYkmbxAaKt/i9Hrw8LsdLbtt/dDXzO4idPSxS3y7KhizJ2/rkiy1Z5sl4OMZ5
	HEbiTYSgi9ySsl8lpwUKn9bn2aRzqyGHzsol2CwRN+9GCN+HpJ3EuclNRwhNZVStkvXBVB
	4ls0qQwD9JjS80EzVT4OTyK8ayU7aLA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBB6F137FE;
	Mon,  9 Jun 2025 17:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /H2KOW4VR2jAHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:10:06 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/11] btrfs: merge btrfs_printk_ratelimited() and it's only caller
Date: Mon,  9 Jun 2025 19:09:31 +0200
Message-ID: <3a6c7cc8be073c562638ebbc9e10c631527b0f34.1749488829.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 17A511F79C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

There's only one caller of btrfs_printk_ratelimited(), merge it there.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index cef7526236d989..c89b315fca8f4a 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -86,19 +86,15 @@ do {							\
 	rcu_read_unlock();				\
 } while (0)
 
-#define btrfs_printk_ratelimited(fs_info, fmt, args...)		\
+#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
 do {								\
 	static DEFINE_RATELIMIT_STATE(_rs,			\
 		DEFAULT_RATELIMIT_INTERVAL,			\
 		DEFAULT_RATELIMIT_BURST);			\
+								\
+	rcu_read_lock();					\
 	if (__ratelimit(&_rs))					\
 		btrfs_printk(fs_info, fmt, ##args);		\
-} while (0)
-
-#define btrfs_printk_rl_in_rcu(fs_info, fmt, args...)		\
-do {								\
-	rcu_read_lock();					\
-	btrfs_printk_ratelimited(fs_info, fmt, ##args);		\
 	rcu_read_unlock();					\
 } while (0)
 
-- 
2.49.0


