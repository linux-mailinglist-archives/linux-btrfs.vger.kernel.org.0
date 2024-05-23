Return-Path: <linux-btrfs+bounces-5241-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB4C8CCCB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 09:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40170283E01
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D5813CA8D;
	Thu, 23 May 2024 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t18n3Rxd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t18n3Rxd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5141413C9C8
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447984; cv=none; b=fMv7BohmfwMuhZ8xhLgCJEPZrbuCUzp9iRxQNWy2ct+ukf7dsgoQgq9T2THmNoBcwjDShMNHZQKIHpiVrVs/+u3QPk1s1l1n/uM82o/U8C0b3HlONTZIRSr7sEuPLKdPZXMBPRUzC2ytg2kxrULkpZ3jhSu+kA+o4oaP/irBbAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447984; c=relaxed/simple;
	bh=DDqLYl4NIyPAtnlMT2v3luTIDtK4rluu2Ki0MrFTulQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWEU07bjUK1/fna1jkHKZeIhSG8rHJVNZXDHzFSQIym6NkgHrpnHy2R6li8VHvvL+x9e3041v8DnUEnGeIAWmT/RYEJ2tOoPnaE3W0/SCMxFK1iEH3MXmfk9vT+sE+q2jR632kuJkz3waRAQtQou4p03ghpjn5eKm1FLCQ6serA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t18n3Rxd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t18n3Rxd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6682422293;
	Thu, 23 May 2024 07:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgvwEHu07nJ+BmswWnWW2Fe8xJQbIcRv+TCVL77ny4s=;
	b=t18n3Rxd+QrSp20oQM8/+us6qfBdk2BF8BfoHpdix8hODjQJpTXa9TxGFCYoLPyW9eQ/ci
	q6WmTeTmX8BVXltgICrddNA7IQwPp40ZABU1dUyCFF9L+sNkYvERt8QUjxnnBbyHfLI+mo
	NTi5MNHSI426728i3Q8dbEJl4YbtY58=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=t18n3Rxd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DgvwEHu07nJ+BmswWnWW2Fe8xJQbIcRv+TCVL77ny4s=;
	b=t18n3Rxd+QrSp20oQM8/+us6qfBdk2BF8BfoHpdix8hODjQJpTXa9TxGFCYoLPyW9eQ/ci
	q6WmTeTmX8BVXltgICrddNA7IQwPp40ZABU1dUyCFF9L+sNkYvERt8QUjxnnBbyHfLI+mo
	NTi5MNHSI426728i3Q8dbEJl4YbtY58=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87A8F13A7D;
	Thu, 23 May 2024 07:06:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLP+DurqTmb0bwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 07:06:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 5/5] btrfs: make extent_write_locked_range() to handle subpage writeback correctly
Date: Thu, 23 May 2024 16:35:46 +0930
Message-ID: <3013967ef7a76d7962ac8824a18f8e0eabee9945.1716445070.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716445070.git.wqu@suse.com>
References: <cover.1716445070.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.61 / 50.00];
	BAYES_HAM(-2.60)[98.21%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6682422293
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.61

When extent_write_locked_range() generated an inline extent, it would
set and finish the writeback for the whole page.

Although currently it's safe since subpage disables inline creation,
for the sake of consistency, let it go with subpage helpers to set and
clear the writeback flags.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2174c0e0fb15..1aac7b8fa7e2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2336,6 +2336,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
+		struct folio *folio;
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
@@ -2350,8 +2351,9 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
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
2.45.1


