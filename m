Return-Path: <linux-btrfs+bounces-3031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB08872A04
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 23:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D431C23B97
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 22:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7512D20E;
	Tue,  5 Mar 2024 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nXqd7E9H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nXqd7E9H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7014E12D1E4
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676972; cv=none; b=KjkQm2Ym8pAVFFko70v6D6OBRChnYA6dougRQASuVdtK3XNr6ik7s38K7DYyn6UbSq7dphTo59cTy0q3hjvejaWgxhRirtCMLUbtS8nPiSxiG2TZq448FeDN4j25MXO6BEyyrceV7bFN766iPT+MntDzWO+wNXyfLkKNu412SCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676972; c=relaxed/simple;
	bh=5Lwv7mIfXvlXqrVRYvtcI80LGYf3xwA3K7d5HLJAxt4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Smu7EA6WFHUR8a9Kgcxp4cJ9MyH/ZMqKRvy/BwwAi8sQB5+sZvFRKZGPXDUqkKdMbTfg0N/mHPYUfUfADyRYlGMUAgc4oAKaDe5+RhyzY/TMOwqVLpIeqz8MADIUVlP9N6WopduK3lOnVKzL3Q3PeRWZlDU6eUqRfYavbZ5lMe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nXqd7E9H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nXqd7E9H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8B2E20F59
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRn0nq1aN5yyOlaiwloEJ4sSHkRdf/opBRe+WS5CEig=;
	b=nXqd7E9Hqn+tb2wz6D0whanqIEHulsGwXw2n3KrCrX+kKPSpe9/F5WIJE5hZrIKqHqYYy7
	d9uDaggC/dMBcBbub7P9T6AsC/KzHuJ7uLkdESkMKPHKb0pwOhzsZjbtz2kGWeyMUVAXrh
	mkNeNI53qEh9ORwQYc0R5BhVB5IAjcw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709676967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRn0nq1aN5yyOlaiwloEJ4sSHkRdf/opBRe+WS5CEig=;
	b=nXqd7E9Hqn+tb2wz6D0whanqIEHulsGwXw2n3KrCrX+kKPSpe9/F5WIJE5hZrIKqHqYYy7
	d9uDaggC/dMBcBbub7P9T6AsC/KzHuJ7uLkdESkMKPHKb0pwOhzsZjbtz2kGWeyMUVAXrh
	mkNeNI53qEh9ORwQYc0R5BhVB5IAjcw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFDC13A5D
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Mar 2024 22:16:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KMtxJ6aZ52XsJgAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Mar 2024 22:16:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: make extent_write_locked_range() to handle subpage writeback correctly
Date: Wed,  6 Mar 2024 08:45:37 +1030
Message-ID: <7b32acdcbc1779f12f0296d72d711471e260499e.1709676577.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1709676577.git.wqu@suse.com>
References: <cover.1709676577.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nXqd7E9H
X-Spamd-Result: default: False [4.67 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[54.48%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.67
X-Rspamd-Queue-Id: B8B2E20F59
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

When extent_write_locked_range() generated an inline extent, it would
set and finish the writeback for the whole page.

Although currently it's safe since subpage disables inline creation,
for the sake of consistency, let it go with subpage helpers to set and
clear the writeback flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bdd0e29ba848..0a194dd659e7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2286,6 +2286,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
+		struct folio *folio;
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
@@ -2300,8 +2301,9 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		/* Make sure the mapping tag for page dirty gets cleared. */
 		if (nr == 0) {
-			set_page_writeback(page);
-			end_page_writeback(page);
+			folio = page_folio(page);
+			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
+			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
 		}
 		if (ret) {
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), page,
-- 
2.44.0


