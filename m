Return-Path: <linux-btrfs+bounces-6850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D50E93FEB2
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 22:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA605B21A22
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE8187348;
	Mon, 29 Jul 2024 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XWfolkSw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XWfolkSw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DB43152
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283583; cv=none; b=ny++xc4zf/HInzwwxfwFEpoH7NAMdm+3f8kZEjnmQgAu/g4eBf2zz2oG9HeYfghMau7WZsPJqvyGB4ps4kexFzXX8RYJNARke2pCgaXAPU+5vR74PeRrQpTYLIAN1Dc3zI3lL8mMfgbqDClOE4CRGqUV1e/Tp8Tkzf/25icTQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283583; c=relaxed/simple;
	bh=tBx3AoBBfGQ0HHYfU3ENIhWnO/rQFN58eBqdKx45eVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6dKJuvPzGuRCSW3HBlP7Lm8ZAt6IYt1uD9+ldgU2xOQGnQIvLtPXZGWi+pP6DOx1ai/bnx3yGz/o40ys9i4KUtU46ggXYQhTma1gHr+enuuJ1Pe0bhE3B2qjEGYvhzhS6eOIjYd7MQRjqPsIN37/o+IsJj73fnEmhvIFiv10n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XWfolkSw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XWfolkSw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B67B1F7B7;
	Mon, 29 Jul 2024 20:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722283579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qSO1ryA2phTW+7u38SfCAvS05JuIpMwc2Dtk2HQr4s4=;
	b=XWfolkSwEitRbkGOS2UtrOnZ4TPSayM8TlcjS+R2uYNHowPnfliTTuV6u2WVE81a43H8rt
	4xOZzY5MwzMdRxrq+sx04at2dCtsijN08neBzg1l0LKUgU0yaexpYkOOaIjKmF+ECcVZI7
	oN7UddaMbF8sYxWVvQ+vOuAFlmcJNls=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722283579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qSO1ryA2phTW+7u38SfCAvS05JuIpMwc2Dtk2HQr4s4=;
	b=XWfolkSwEitRbkGOS2UtrOnZ4TPSayM8TlcjS+R2uYNHowPnfliTTuV6u2WVE81a43H8rt
	4xOZzY5MwzMdRxrq+sx04at2dCtsijN08neBzg1l0LKUgU0yaexpYkOOaIjKmF+ECcVZI7
	oN7UddaMbF8sYxWVvQ+vOuAFlmcJNls=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 441481368A;
	Mon, 29 Jul 2024 20:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HPmZEDv2p2a+RQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 29 Jul 2024 20:06:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: geert@linux-m68k.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: initialize location to fix -Wmaybe-uninitialized in btrfs_lookup_dentry()
Date: Mon, 29 Jul 2024 22:06:08 +0200
Message-ID: <20240729200608.10722-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Some arch + compiler combinations report a potentially unused variable
location in btrfs_lookup_dentry(). This is a false alert as the variable
is passed by value and always valid or there's an error. The compilers
cannot probably reason about that although btrfs_inode_by_name() is in
the same file.

   >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.objectid' may be used
   +uninitialized in this function [-Werror=maybe-uninitialized]:  => 5603:9
   >  + /kisskb/src/fs/btrfs/inode.c: error: 'location.type' may be used
   +uninitialized in this function [-Werror=maybe-uninitialized]:  => 5674:5

   m68k-gcc8/m68k-allmodconfig
   mips-gcc8/mips-allmodconfig
   powerpc-gcc5/powerpc-all{mod,yes}config
   powerpc-gcc5/ppc64_defconfig

Initialize it to zero, this should fix the warnings and won't change the
behaviour as btrfs_inode_by_name() accepts only a root or inode item
types, otherwise returns an error.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/linux-btrfs/bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org/
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 32010127710d..333b0e8587a2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5667,7 +5667,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
-	struct btrfs_key location;
+	struct btrfs_key location = { 0 };
 	u8 di_type = 0;
 	int ret = 0;
 
-- 
2.45.0


