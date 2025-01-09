Return-Path: <linux-btrfs+bounces-10820-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18323A07305
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077D67A02E3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07F7214A6D;
	Thu,  9 Jan 2025 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RdRfWr4l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RdRfWr4l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D6218ADA
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418255; cv=none; b=qi9lu9fzHpY2v59WGG6Adb6FVUTkMD6prkYcExJZs107B8fA4M8fMOjzPlMo6vj7CVikdkZTyPzIyAdK/QQ3HAp44cug0UK6q77wQ2scchUCNsSbt1fsQbGH9PPO9AdZ7bzw/PnedMysvY3h+U9WnQwmaVcXwmt7kxmaLO49q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418255; c=relaxed/simple;
	bh=m6PK/+8rRnv7DBlnzYuiCatbTGWp9cYmOdjKLdvptRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b/w6kwCiWz6dapbLjmg11NdvOUur+n1q1mAlRbpJRtNlu9FLT1X1e01ogXLoG3XtPr9CZpL5fcxRLSKULB2xTth1AKq7IBGqoBaX3nW4jo9v7+Krw/EpqMqle09OfHw6IYuWhdYXrMWlGX9AdSg8K4ciW5DkbO2jEd5i1ZYUKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RdRfWr4l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RdRfWr4l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC5A61F450;
	Thu,  9 Jan 2025 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi/7vVN8HxgTYBclIKFjdwkxUUd2fSEG/W1KnJxYNsc=;
	b=RdRfWr4lCypsQOWc0y0PbqgR6rAv7mAmWSV69x4hat9EZNbyKAA2NHFORLOwtHmWMLanxu
	hVPdvTSOpMQYz0WMTc3D1H6fZd01FKPcaibxwyptYUHjtpJrXwRRbjn6+dXTs9TnUXfhv2
	QKtQtR9HVNihwXVlb0oWR5NWnYMtE4k=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi/7vVN8HxgTYBclIKFjdwkxUUd2fSEG/W1KnJxYNsc=;
	b=RdRfWr4lCypsQOWc0y0PbqgR6rAv7mAmWSV69x4hat9EZNbyKAA2NHFORLOwtHmWMLanxu
	hVPdvTSOpMQYz0WMTc3D1H6fZd01FKPcaibxwyptYUHjtpJrXwRRbjn6+dXTs9TnUXfhv2
	QKtQtR9HVNihwXVlb0oWR5NWnYMtE4k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4525139AB;
	Thu,  9 Jan 2025 10:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p34aKMqjf2cpEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:10 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/18] btrfs: rename __unlock_for_delalloc() and drop underscores
Date: Thu,  9 Jan 2025 11:24:10 +0100
Message-ID: <cb2e56cec569be6600b2a159f8ecf98907ad87e6.1736418116.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736418116.git.dsterba@suse.com>
References: <cover.1736418116.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

Drop the underscores as the naming scheme does not apply here and to
have the unlock for parity with lock_delalloc_folios().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9725ff7f274d..8c472560e43e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_space *mapping,
 	}
 }
 
-static noinline void __unlock_for_delalloc(const struct inode *inode,
+static noinline void unlock_delalloc_folio(const struct inode *inode,
 					   const struct folio *locked_folio,
 					   u64 start, u64 end)
 {
@@ -288,8 +288,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 out:
 	folio_batch_release(&fbatch);
 	if (processed_end > start)
-		__unlock_for_delalloc(inode, locked_folio, start,
-				      processed_end);
+		unlock_delalloc_folio(inode, locked_folio, start, processed_end);
 	return -EAGAIN;
 }
 
@@ -390,7 +389,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 	unlock_extent(tree, delalloc_start, delalloc_end, &cached_state);
 	if (!ret) {
-		__unlock_for_delalloc(inode, locked_folio, delalloc_start,
+		unlock_delalloc_folio(inode, locked_folio, delalloc_start,
 				      delalloc_end);
 		cond_resched();
 		goto again;
@@ -1247,7 +1246,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			 */
 			unlock_extent(&inode->io_tree, found_start,
 				      found_start + found_len - 1, NULL);
-			__unlock_for_delalloc(&inode->vfs_inode, folio,
+			unlock_delalloc_folio(&inode->vfs_inode, folio,
 					      found_start,
 					      found_start + found_len - 1);
 		}
-- 
2.47.1


