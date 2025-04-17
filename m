Return-Path: <linux-btrfs+bounces-13119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4FAA9177A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B85190668C
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 09:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B392253B7;
	Thu, 17 Apr 2025 09:17:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28133FD
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744881448; cv=none; b=kAi70vlCUBTxRytVwddmHNt7K3xQNiRIsG1C/2+GwrAlIwBW0JbOLr+4G5MU2ZbDZhbTAuUqhNtUxRRHbPzhnRnF2vuEEikB9IrMRemhgOVIbo7tTaa/I9wkeOR6Wm5e/OdyZ2vr01zqhqMWTfb8ETnJVai+20tQcYvZhwy4p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744881448; c=relaxed/simple;
	bh=6IRxrQJX6E/ps6j2UGtjvOVWMbRNH2f65bixJ+uy15U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ko9n6UANeJg4cRqpVm21ZBcVXWunq7QkZ7LQxH0M+XZF7279QG/pBw1oQGbuM83xzblgWtET+Yt1I+xoGN4VeYtiNY+sMz7QkMpb5x/YIUOSWky0AOJGrGbXXiTVtLPWI5gAyPHbKlP0WDnWyRnSy8TcFXtGE6ZrRLXgYdfAr5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ECEA211A3;
	Thu, 17 Apr 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E46137CF;
	Thu, 17 Apr 2025 09:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YzO7CSXHAGjDcQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 17 Apr 2025 09:17:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/5] btrfs: add debug build only WARN
Date: Thu, 17 Apr 2025 11:17:01 +0200
Message-ID: <92c5aef49ac58f0c2017cf1562c1f04e6c22af75.1744881160.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744881159.git.dsterba@suse.com>
References: <cover.1744881159.git.dsterba@suse.com>
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
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 2ECEA211A3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Add conditional WARN() wrapper that's enabled only in debug build. It
should be used for unexpected conditions that should be noisy.  Use it
instead of ASSERT(0). As it will not lead to BUG() make sure that
continuing is still possible, e.g. the error is handled anyway.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/messages.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index c9031fee7169eb..6089bab3aca179 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -219,6 +219,13 @@ do {										\
 #define ASSERT(cond, args...)	(void)(cond)
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


