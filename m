Return-Path: <linux-btrfs+bounces-4913-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6D38C2DE8
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 02:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A072284B95
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 May 2024 00:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C50EEA9;
	Sat, 11 May 2024 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXb3ROwl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rXb3ROwl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89B8C13
	for <linux-btrfs@vger.kernel.org>; Sat, 11 May 2024 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715386548; cv=none; b=MQekCWLYcMAQ2amDDz5tlEvLfdblMgv26fhPm3Xpa0eZd+RHp5HmgdG+bDDsrJnTLgrhKGmi7sk9SgcK7ZIADUjq2r4WiJzkmFql/WM9J4egdK8njAfwbkM51OopT5Z3Bo23N0RJvauNow5U+eGv1xOyGEkzCvALNzJqinMPNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715386548; c=relaxed/simple;
	bh=zdTDgGR6p5QzGaWkdvucLvm9uznH/h0+KtSXe9lsFaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWLAOX4rauOImMLL850xD4iqoEOMevs2i3rLtl86S4Ar+Jh0rdhMJuCYG+bLxLM+W393I628LDsmWRE+lGNauJZTU56gaf2XKk/d32S1oVYGrD2Rq2BpQG2Ce5uo3ctZUNef0GwmYoRXdHm+DAykEuimJCdTQoK6fXHeCiUpWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXb3ROwl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rXb3ROwl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B48F200E9;
	Sat, 11 May 2024 00:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxHSz+duSW+jvy8esroAnCx8Z5oMT+SxYui/oH7iW5E=;
	b=rXb3ROwl+/aHsdcP7Yt61NOZj+9WxqHmWFPLxlKbn/2Wnfovz2xJeofyGV2W44HKn5jVDE
	Wd8AtfrfeRG+FqKwJACWmaeEMas6EQotBsQCqDXA21obPAs+egP2ZLDxOWgJputvVCNIp6
	F+EwwopMqYkxJTw8GDhAvdvjiyFU4cs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rXb3ROwl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1715386544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxHSz+duSW+jvy8esroAnCx8Z5oMT+SxYui/oH7iW5E=;
	b=rXb3ROwl+/aHsdcP7Yt61NOZj+9WxqHmWFPLxlKbn/2Wnfovz2xJeofyGV2W44HKn5jVDE
	Wd8AtfrfeRG+FqKwJACWmaeEMas6EQotBsQCqDXA21obPAs+egP2ZLDxOWgJputvVCNIp6
	F+EwwopMqYkxJTw8GDhAvdvjiyFU4cs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0480C13A3D;
	Sat, 11 May 2024 00:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCmILK64PmYcPAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 May 2024 00:15:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: josef@toxicpanda.com,
	Johannes.Thumshirn@wdc.com
Subject: [PATCH v4 6/6] btrfs: make extent_write_locked_range() to handle subpage writeback correctly
Date: Sat, 11 May 2024 09:45:22 +0930
Message-ID: <05bc1dfe0d2769eb4f5e1e19fa6ecb76efe78931.1715386434.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1715386434.git.wqu@suse.com>
References: <cover.1715386434.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.05 / 50.00];
	BAYES_HAM(-1.04)[87.64%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8B48F200E9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -1.05

When extent_write_locked_range() generated an inline extent, it would
set and finish the writeback for the whole page.

Although currently it's safe since subpage disables inline creation,
for the sake of consistency, let it go with subpage helpers to set and
clear the writeback flags.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 08556db4b4de..7275bd919a3e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2309,6 +2309,7 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
 		u32 cur_len = cur_end + 1 - cur;
 		struct page *page;
+		struct folio *folio;
 		int nr = 0;
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
@@ -2323,8 +2324,9 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
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
2.45.0


