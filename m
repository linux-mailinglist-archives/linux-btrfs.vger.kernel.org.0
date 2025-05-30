Return-Path: <linux-btrfs+bounces-14327-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A72AC9353
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 18:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA217C9BE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 16:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DB21A5B9D;
	Fri, 30 May 2025 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l++wHxqx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l++wHxqx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F53C2E401
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621880; cv=none; b=e5GTXFd0+MiHQ/GzZnIyN5ipZiGXQZVhKdhKJ3kEuRyDguTY14gMi7RFKdb0B1O60QOTVVfnyqMzebzoViPEnxVytwDFTtlo8i7NSLq4bsc2Ktws0/ZhiPTz51kpZk+vQCR24thDF8rIcG/5K+lFL3ziCnO5+hN+Ns9ZJncAHkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621880; c=relaxed/simple;
	bh=MnlRDIT4qhBzrJR2gP2zmTldv12R/urgl2imkUUlkr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjjoulHy4SE5WntQYgCl8LesF52/Sub/nTAcgXrenVxNSYDcsBTYr4OeQFU4Z/c4QVhUoVcXm393hggr91zAiqRQum7mzDLNhekFE9raPcQ3IdphIiLKrSBlPL8Y85oFgObHVc9fI9681BzuLkZfdufR4BumrCYMyZ10z1mDNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l++wHxqx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l++wHxqx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8AF61F7F2;
	Fri, 30 May 2025 16:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8p4dwrBZOrtrvzhcOaH6g4SvPEizuWvQ7y8sDWlI2I=;
	b=l++wHxqxd77GyqiYzPGbMEhfxim17zH+y+5XbGMtFmX2ZPQpE0n86mtlTrEBcePRYYfrkf
	MOTM8iTfPQdREATm2osx1yDgh4TB8NYnpXSIy9l6KA4C+mvwd9HDx2vYj8hmSACDt0VSct
	z6XzusITPQS2JzHOaOcw79R6Sr+WiCU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748621876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8p4dwrBZOrtrvzhcOaH6g4SvPEizuWvQ7y8sDWlI2I=;
	b=l++wHxqxd77GyqiYzPGbMEhfxim17zH+y+5XbGMtFmX2ZPQpE0n86mtlTrEBcePRYYfrkf
	MOTM8iTfPQdREATm2osx1yDgh4TB8NYnpXSIy9l6KA4C+mvwd9HDx2vYj8hmSACDt0VSct
	z6XzusITPQS2JzHOaOcw79R6Sr+WiCU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C092713889;
	Fri, 30 May 2025 16:17:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nNn/LjTaOWiqZwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 30 May 2025 16:17:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/22] btrfs: rename err to ret in btrfs_try_lock_extent_bits()
Date: Fri, 30 May 2025 18:17:48 +0200
Message-ID: <a88a68f8d0d8a72b23715a27864e1d1a3b104dd8.1748621715.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1748621715.git.dsterba@suse.com>
References: <cover.1748621715.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

Unify naming of return value to the preferred way.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index b1b96eb5f64e..0f4c0b234573 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1882,12 +1882,11 @@ int btrfs_clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 e
 bool btrfs_try_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 				u32 bits, struct extent_state **cached)
 {
-	int err;
+	int ret;
 	u64 failed_start;
 
-	err = set_extent_bit(tree, start, end, bits, &failed_start, NULL,
-			     cached, NULL);
-	if (err == -EEXIST) {
+	ret = set_extent_bit(tree, start, end, bits, &failed_start, NULL, cached, NULL);
+	if (ret == -EEXIST) {
 		if (failed_start > start)
 			btrfs_clear_extent_bit(tree, start, failed_start - 1,
 					       bits, cached);
-- 
2.47.1


