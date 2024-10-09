Return-Path: <linux-btrfs+bounces-8720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9620996E00
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1741F1C21A30
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F1A19DF5F;
	Wed,  9 Oct 2024 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ElR8pS/5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ElR8pS/5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC7199FB4
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484353; cv=none; b=XnqGZ94Q0t6d05yrB1p3l/nQnUASY/WKfv74pOh2fNt9N9tKJP32IEA8j/eg6q5ocUYFvoDoJCFEUnhkrKdgFrNVMkk0FjqNfp43m7QZa59lZ/KXqSomBrUlwDIHoPrdtSUv6UIFZdR237/7f/MybaGr6JP/O9xuhfUzq5vAd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484353; c=relaxed/simple;
	bh=lXZP8rSMVEg25/CRgiWvAiJ1XDHZXFVk9awSWCkQFrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nj07PVyZWvQoD/XpHkJKK8oPafW1P7GyofaZLA7wggC1HdhUdluoNkMwuHozTwoA2d2QJEVXwG6ZVXFNozPnr+d2JinDDpcKOD104f0QxDN+/ezeNBCKsndPDg7S5Vx4j8xbWjFwXFB0U+KSpS+mvixLyffz1dyrZM1eJ2fR7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ElR8pS/5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ElR8pS/5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA22221EB2;
	Wed,  9 Oct 2024 14:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95IGy7cHJg9X4EkgSqMpw/JXQ2N/BakD0/wmivDKCQk=;
	b=ElR8pS/5SPsVa0a7zw785xc78bFqjGfktpzlsApz/kB6+GL+rtZiBx5jLG+WjjgZz+sA97
	1gjdYdXBRUIkdMcNRuxvqwjRt6OHvuy6b39Sh94UNqz5HiV4Z6ZL+YhD8yI4JLVrYH1Eou
	4AQh0k7nxWqlFi2lMicQVfZpCxSSn4k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728484349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95IGy7cHJg9X4EkgSqMpw/JXQ2N/BakD0/wmivDKCQk=;
	b=ElR8pS/5SPsVa0a7zw785xc78bFqjGfktpzlsApz/kB6+GL+rtZiBx5jLG+WjjgZz+sA97
	1gjdYdXBRUIkdMcNRuxvqwjRt6OHvuy6b39Sh94UNqz5HiV4Z6ZL+YhD8yI4JLVrYH1Eou
	4AQh0k7nxWqlFi2lMicQVfZpCxSSn4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C45CC136BA;
	Wed,  9 Oct 2024 14:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MdvtL/2TBmecRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:32:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 25/25] btrfs: drop unused parameter level from alloc_heuristic_ws()
Date: Wed,  9 Oct 2024 16:32:25 +0200
Message-ID: <b536b709dc678dd514850dea60fb64130cf63b96.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

The compression heuristic pass does not need a level, so we can drop the
parameter.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 655e3212b409..abcf8ed06afc 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -702,7 +702,7 @@ static void free_heuristic_ws(struct list_head *ws)
 	kfree(workspace);
 }
 
-static struct list_head *alloc_heuristic_ws(unsigned int level)
+static struct list_head *alloc_heuristic_ws(void)
 {
 	struct heuristic_ws *ws;
 
@@ -744,7 +744,7 @@ static const struct btrfs_compress_op * const btrfs_compress_op[] = {
 static struct list_head *alloc_workspace(int type, unsigned int level)
 {
 	switch (type) {
-	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(level);
+	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws();
 	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(level);
 	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace();
 	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(level);
-- 
2.45.0


