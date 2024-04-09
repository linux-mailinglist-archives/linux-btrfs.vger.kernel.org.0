Return-Path: <linux-btrfs+bounces-4060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A8089DC30
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 16:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116CD1C21C3D
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 14:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FC12FF67;
	Tue,  9 Apr 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GaAXinL6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GaAXinL6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9A612FB16
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672843; cv=none; b=OGeTIO4m3ADuOT0IP3ZGFKlkw3BwCnQX503EXik4bJzwYKvTSiZbbVuM9/qQyU7PjjQcD875HlULzwoA8+hm2vSuxoBhcl2DsrhIktMcuJtjkg67h7W6WxNr0lMlxRIlQg6tWvmn8u8s08sObtfeq/vumieqp3FeDPwIv5NJZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672843; c=relaxed/simple;
	bh=swgpWewYdl0vXacBLuMHT0i4Xgx/NvdRyAt8o3RTphc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svqKMuFk4rdrY/eDLYALiWVKb9RHDi1sIMATPgfPRXsxabR49UTV6D76dnbxf7H+1L98mSIcy235iTxWiyYwTI/Z+PeEUbBrzwhTnbWNZTRbPHbSy2ADveYPW/yNtqWJNDFmsIPu/mgvgjvFHw05rOpw269Liw7PV1KeUMmWZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GaAXinL6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GaAXinL6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97E4E20A46;
	Tue,  9 Apr 2024 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712672839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pi7mFlpJhug8sKMT9SE4fmEdPpz65QT9XUkIJ00MRVk=;
	b=GaAXinL6Qjr4FgOZBRWH4HBvgTtTLPSshDMEDvzhMpjEBppzyDbEdjeZt/g6BkCWaj31VT
	kkAmx7AN6R0/0Xv+MH1bDIa5vv4BiyIKDA91sgeCGiRAS7SxpFbdIeSUfM6mWUcpE7KUYW
	R8yOuCxL1aF9urIWIwKin2FTSZx/id8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GaAXinL6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712672839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Pi7mFlpJhug8sKMT9SE4fmEdPpz65QT9XUkIJ00MRVk=;
	b=GaAXinL6Qjr4FgOZBRWH4HBvgTtTLPSshDMEDvzhMpjEBppzyDbEdjeZt/g6BkCWaj31VT
	kkAmx7AN6R0/0Xv+MH1bDIa5vv4BiyIKDA91sgeCGiRAS7SxpFbdIeSUfM6mWUcpE7KUYW
	R8yOuCxL1aF9urIWIwKin2FTSZx/id8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9222A13253;
	Tue,  9 Apr 2024 14:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id C2SkI0dQFWbgCwAAn2gu4w
	(envelope-from <dsterba@suse.com>); Tue, 09 Apr 2024 14:27:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove colon from messages with state
Date: Tue,  9 Apr 2024 16:19:54 +0200
Message-ID: <20240409141954.16446-1-dsterba@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[31.78%];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 97E4E20A46
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Spamd-Bar: /

The message format in syslog is usually made of two parts:

  prefix ":" message

Various tools parse the prefix up to the first ":". When there's
an additional status of a btrfs filesystem like

  [5.199782] BTRFS info (device nvme1n1p1: state M): use zstd compression, level 9

where 'M' is for remount, there's one more ":" that does not conform to
the format. Remove it.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index c96dd66fd0f7..210d9c82e2ae 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_PRINTK
 
-#define STATE_STRING_PREFACE	": state "
+#define STATE_STRING_PREFACE	" state "
 #define STATE_STRING_BUF_LEN	(sizeof(STATE_STRING_PREFACE) + BTRFS_FS_STATE_COUNT + 1)
 
 /*
-- 
2.44.0


