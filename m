Return-Path: <linux-btrfs+bounces-12128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12886A58D02
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6AD3AAA3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE122173D;
	Mon, 10 Mar 2025 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hk+11JXW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hk+11JXW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B522154D
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592197; cv=none; b=U3vRu75bJgciRMbv1ASNyvGvWeahs3X9G4S3uzg3nATOsjhFL6wMEV9QMbHE8xRfiugr7xsQoOZyIAwsPqxGKLcj4PAaYH+VELTuKP2c7bRREwKa/rp0inyzC8NYypvCSwyzEJyny0WE7udW5qXh2NeOKyZMLfk/MuJfFOB79Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592197; c=relaxed/simple;
	bh=z03DzZjW0FEuSdru0Ksy2jtYdSsr0L9T+WVex8CHMNw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHKYfom3N82fiuvbd6eqiH29Ibw9MUvaK0w2ImIi0S17vFKtPTNYByiU+YzkyGGtHyW1S7UGOQHtA9XSZeKbdO2F2NHF2iFuBktjEeWvZ3YDm0MeR64WVF23Du+NZixR5WUwOfb27A858T8dORx8uBg08yXtq2UXL3h8EleGbko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hk+11JXW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hk+11JXW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D3A01F453
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOdmNImj35QoCoIkOgggwwsOaEecDCHaR92bpk6XE6o=;
	b=hk+11JXW1OjkWeu1gMzJOyrPGsRvBHJQr8VvAZExdJ0Vg6Ou7HkeGIKH56Kd2UHUwJltK4
	V6s9sx3j0uwTYvkzN69b0RggSGNIGf9tAiIP0t26P/u/7pt7FV5DHTujkwCVwmvjzr22hp
	iqXFBZ1Drswn9J9cOfhACdwfNPm/e4o=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hk+11JXW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOdmNImj35QoCoIkOgggwwsOaEecDCHaR92bpk6XE6o=;
	b=hk+11JXW1OjkWeu1gMzJOyrPGsRvBHJQr8VvAZExdJ0Vg6Ou7HkeGIKH56Kd2UHUwJltK4
	V6s9sx3j0uwTYvkzN69b0RggSGNIGf9tAiIP0t26P/u/7pt7FV5DHTujkwCVwmvjzr22hp
	iqXFBZ1Drswn9J9cOfhACdwfNPm/e4o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5192613A70
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WB24BHiWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/6] btrfs: replace PAGE_SIZE with folio_size for subpage.[ch]
Date: Mon, 10 Mar 2025 18:05:59 +1030
Message-ID: <195273fefbb7e9631e7a6ccd9ad11d31f5cca2b3.1741591823.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741591823.git.wqu@suse.com>
References: <cover.1741591823.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D3A01F453
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Since we can no longer assume all data filemap folios are page sized,
use proper folio_size() calls to determine the folio size, as a
preparation for future larger data filemap folios.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 6 +++---
 fs/btrfs/subpage.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 6e776c3bd873..834161f35a00 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -6,7 +6,7 @@
 #include "btrfs_inode.h"
 
 /*
- * Subpage (sectorsize < PAGE_SIZE) support overview:
+ * Subpage (block size < folio size) support overview:
  *
  * Limitations:
  *
@@ -194,7 +194,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 */
 	if (folio->mapping)
 		ASSERT(folio_pos(folio) <= start &&
-		       start + len <= folio_pos(folio) + PAGE_SIZE);
+		       start + len <= folio_pos(folio) + folio_size(folio));
 }
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
@@ -223,7 +223,7 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 	if (folio_pos(folio) >= orig_start + orig_len)
 		*len = 0;
 	else
-		*len = min_t(u64, folio_pos(folio) + PAGE_SIZE,
+		*len = min_t(u64, folio_pos(folio) + folio_size(folio),
 			     orig_start + orig_len) - *start;
 }
 
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 083390e76d13..3042c5ea840a 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -89,7 +89,7 @@ static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 {
 	if (folio->mapping && folio->mapping->host)
 		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
-	return fs_info->sectorsize < PAGE_SIZE;
+	return fs_info->sectorsize < folio_size(folio);
 }
 #else
 static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
-- 
2.48.1


