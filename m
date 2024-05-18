Return-Path: <linux-btrfs+bounces-5090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCF8C8FAB
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 07:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B901E1C20D37
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB0710A11;
	Sat, 18 May 2024 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mzLI4Q2H";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r/1tEt0W"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C870ADF6B
	for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716008898; cv=none; b=KyUhtmMBYWgMAAR/TrASQZOtpyVTUzzLkyrMeYtKZTRoZ/h3clSqzYv6cVvYxq77o5vSpu1QIVfcImmIKSMc2Q4ki8Lmg+qwZkuuFRscsSn70N2FH3iW+esFWIv6xXEGPGROwZvedf54DstQmxKzaxzn4dE+c3rEoej5ZIrkaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716008898; c=relaxed/simple;
	bh=T9cw1kBNbzZjPF2Z/vl+gXEa/zW9REL92fOjiWPJ4fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghEF4n2ziWQIfVbSDbYwH/IwHtxWEvGY8K7xMTN09SHjgxxOnebUAI/xwxtMbe7OLvAv5PsyJlJBwF3/pSRWdIDcKnEo/rm8vqxgVGBagEI3jyGpxAcU2dOlDoh8KCsO8u4dSgQ8/uua6+SsI0OSflsI0FQ4SXxUeE4S12nTt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mzLI4Q2H; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r/1tEt0W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D94405F82B;
	Sat, 18 May 2024 05:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCtAUZLE+wqkPnZ/ScV39M/4z1w4/4K1jfV0VIXATLE=;
	b=mzLI4Q2HbKgKYIELhSIpA0e2JBUt9RDDcLrV8hoX7VAi5yY2opxQkoAHOyZyEAsIACX+1b
	zuanV4GfZeNoUzIss5CbNlIjHnfe2IoAaFdjLBAEvAcS/VdAHISAuE1FctZ45bONaPGmp9
	o5iZ4lPb/JCrc+sO8sNSvwjdqGDRWEM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCtAUZLE+wqkPnZ/ScV39M/4z1w4/4K1jfV0VIXATLE=;
	b=r/1tEt0WgQdjRX7uwLdcYMIUl25fMPxFh8FieiXnAkicyg2v4okz4SIWrDuKJxTCpk2sJ5
	1D8UAnh+uK688hDDu7FtOPRawl1N6rN4Q6/+X9ge03qn4jkrOtr0ztdNpfd7uHPxYsMAW2
	VehuZIk3fM6DS/pZebPxgDn8gwVZayU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0585B13942;
	Sat, 18 May 2024 05:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CL/RKrw3SGbnXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 18 May 2024 05:08:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com,
	josef@toxicpanda.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 5/5] btrfs: make extent_write_locked_range() to handle subpage writeback correctly
Date: Sat, 18 May 2024 14:37:43 +0930
Message-ID: <cde3e15ca5b4a3a3a2df8749a7944243bcc29bd4.1716008374.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716008374.git.wqu@suse.com>
References: <cover.1716008374.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.56 / 50.00];
	BAYES_HAM(-1.76)[93.54%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.56
X-Spam-Flag: NO

When extent_write_locked_range() generated an inline extent, it would
set and finish the writeback for the whole page.

Although currently it's safe since subpage disables inline creation,
for the sake of consistency, let it go with subpage helpers to set and
clear the writeback flags.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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


