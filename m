Return-Path: <linux-btrfs+bounces-13065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FCBA8B4CB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 11:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B04190245F
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE232356B0;
	Wed, 16 Apr 2025 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P52+1qu+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P52+1qu+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782B2376FA
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794512; cv=none; b=IMIj2Olva8BkMsaD2PuIzKMLHVRy44qulzrUZyJjFefIhyLLlTjdRwdYx8pXq+wsxFrtlmrVB3eSIOh6kuG0Lol0sxF1GWkNO7Rb9OhJ7zaxjwFG6f7YwFR8Uxv4jljdSjGsm3DgSrpb/tsi4AptqmEYEEDLf2igNz5hlGraRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794512; c=relaxed/simple;
	bh=SQSZvjC1Aj6nJbcnqmkz90x8lKeRtBGYRAFn2C16cpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuVQLBVRCKUbDAW/pnqdgHzuKcNTNz3iJY23/qLdiRc9z69COXOIlZehtnf+VtP+buOnpZ/JpAZQzqvsQ8CzAsIiFEZjbDQb0tt0ulW5EEWcH65WRigptL+cdSRQDb2Wc2zWT+Hzd7Nfin8rHeydH5iWKPL2XCyr/Xqu+829cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P52+1qu+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P52+1qu+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 291041F452;
	Wed, 16 Apr 2025 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mh5lm9juX4Ew9IhraQBZR3t6iXwqyKETfokCWmcAfWM=;
	b=P52+1qu+MI1SQoeqGZngGG8jX1b2k+Cey6ZsPY6vMNJLyObBIyoNy/6SVdaksk8kvQZ4hA
	oTwm5ASAHhhJkvSBb7SNLIKY0SgAu+cPb5OsRf5QbcEjhYELYRDHzPf/fT9Wzhg+5T4x1s
	HgN6/dtFMUargn9DrH/5ORKhbQ3JXrE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=P52+1qu+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744794509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mh5lm9juX4Ew9IhraQBZR3t6iXwqyKETfokCWmcAfWM=;
	b=P52+1qu+MI1SQoeqGZngGG8jX1b2k+Cey6ZsPY6vMNJLyObBIyoNy/6SVdaksk8kvQZ4hA
	oTwm5ASAHhhJkvSBb7SNLIKY0SgAu+cPb5OsRf5QbcEjhYELYRDHzPf/fT9Wzhg+5T4x1s
	HgN6/dtFMUargn9DrH/5ORKhbQ3JXrE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22D5813976;
	Wed, 16 Apr 2025 09:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Em57CI1z/2dWbAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 16 Apr 2025 09:08:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: add debug build only WARN
Date: Wed, 16 Apr 2025 11:08:10 +0200
Message-ID: <6f48b375412c74e9e41422068f9777804b522169.1744794336.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 291041F452
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Add conditional WARN() wrapper that's enabled only in debug build. It
should be used for unexpected condtions that should be noisy.  Use it
instead of ASSERT(0). As it will not lead to BUG() make sure that
continuing is still possible, e.g. the error is handled anyway.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 8cca9d834b274d..31f9a2597a1c96 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -204,6 +204,13 @@ static inline void btrfs_assertfail_verbose(const char *str_expr,
 #define VASSERT(expr, fmt, ...)		(void)(expr)
 #endif
 
+#ifdef CONFIG_BTRFS_DEBUG
+/* Verbose warning only under debug build. */
+#define DEBUG_WARN(args...)	WARN(1, KERN_ERR args)
+#else
+#define DEBUG_WARN(...)		do {} while(0)
+#endif
+
 __printf(5, 6)
 __cold
 void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function,
-- 
2.49.0


