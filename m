Return-Path: <linux-btrfs+bounces-13330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B26A9945C
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE6F1B84E45
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26A283689;
	Wed, 23 Apr 2025 15:58:26 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3714238C16
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423905; cv=none; b=lxcgVgwkLdM/APKtMgxwr7oYqTtK25FGNs6bpBE6M3uJaeEtR8THblT3NklVidiBauXFk8Qc/Yyaj6migMgBSWXD606DXGEVApNMdqJPm4jkvXNQ5GUhH23S1WXaBJ0Cil9nY/uu91qld36DiOOG+amJdj9o+8jpoxMquvYzkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423905; c=relaxed/simple;
	bh=52jLH2rg8FO1fXBRjJDYEgl3Oechj+ltf9Y1Kwul43M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSGNFYBB4cCclVeIAutG4teqg4/UsJIt4mhm343QXq9iBIvttms9XXTxS1x4FN6Wz6o5La76TdyUuMPcY6emxKhty0GV8KjGHvHgBaTgwIsmANxfhuCA8g1hoyT4namO2q1pf/+eZDNPFHBXyL9n/7vAiESAoFF109/h4ilok84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 357EB21190;
	Wed, 23 Apr 2025 15:58:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EC4813691;
	Wed, 23 Apr 2025 15:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XqFpCxkOCWi5CQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:17 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/12] btrfs: simplify reading bio status in end_compressed_writeback()
Date: Wed, 23 Apr 2025 17:57:20 +0200
Message-ID: <4449edabfc92dbfb133fbc483480621aaec2d640.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 357EB21190
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

We don't need to have a separate variable to read the bio status, 'ret'
works for that just fine so remove 'error'.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 79997e97f3b557..59075dd865c143 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -285,12 +285,12 @@ static noinline void end_compressed_writeback(const struct compressed_bio *cb)
 	unsigned long index = cb->start >> PAGE_SHIFT;
 	unsigned long end_index = (cb->start + cb->len - 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
-	const int error = blk_status_to_errno(cb->bbio.bio.bi_status);
 	int i;
 	int ret;
 
-	if (error)
-		mapping_set_error(inode->i_mapping, error);
+	ret = blk_status_to_errno(cb->bbio.bio.bi_status);
+	if (ret)
+		mapping_set_error(inode->i_mapping, ret);
 
 	folio_batch_init(&fbatch);
 	while (index <= end_index) {
-- 
2.49.0


