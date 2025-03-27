Return-Path: <linux-btrfs+bounces-12636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF01A740FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 23:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7C63B3E60
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437B1EFFB1;
	Thu, 27 Mar 2025 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8wp9YBD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8wp9YBD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4D1E1DF0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114710; cv=none; b=HkbikhGdi3yLsEOeQuYB18KxsbHvnPARC+dedR24E+37S4i6b0NVgeWFG8mwK5p5NFIHjLGSpokdVxaf8TIUoruBp8VbbzI4S1axL2tIHbT+medPybp3/zRxFcgdCtAtxQdazPwcZR5lx27YQn9NsYpXR1GuOa4Q/MZeRMaafsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114710; c=relaxed/simple;
	bh=XAtwXhZSIuG1VeqpH718NRDxfkAiQGiF99Rm7MoZl5Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8OYeWW9Z++z1RBGq1dltf/UehYh0Xqf/B3pjM5lg8XHyYAWsODTR221hecvYd9YZ9Au1yAsebFKLvuGscsvFYRwajgkWQEOKcH4SRBRZ43NLPEZsC9unShjsb8nmk2czlBwMmgAz4R6UFIRc1wRMc7R4EW22vU2ja/RSIrENVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8wp9YBD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8wp9YBD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 31328211BA
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+2YPOfBZyr5cHswAyt8J8lH/HMrl0X0cRxqfzdgEFg=;
	b=k8wp9YBDBv2WGLwSFKpjx8zr/4WC/+gWdnC8ITNs/BOp4iAE4a5AllwI4Mxry2hmUxjXdh
	3wGm5Uidgu9AKlRyBT+O35laxKujyd94xM5BgBDy1F6t61YUKUsY0TK6M5FXfm7Wthu+f8
	DMIJN9JIhkDoHeq1HHugaQlHh9FOjIE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=k8wp9YBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743114693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o+2YPOfBZyr5cHswAyt8J8lH/HMrl0X0cRxqfzdgEFg=;
	b=k8wp9YBDBv2WGLwSFKpjx8zr/4WC/+gWdnC8ITNs/BOp4iAE4a5AllwI4Mxry2hmUxjXdh
	3wGm5Uidgu9AKlRyBT+O35laxKujyd94xM5BgBDy1F6t61YUKUsY0TK6M5FXfm7Wthu+f8
	DMIJN9JIhkDoHeq1HHugaQlHh9FOjIE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C64E139D4
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GH3hC8TR5WfMagAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 22:31:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: prepare btrfs_punch_hole_lock_range() for large data folios
Date: Fri, 28 Mar 2025 09:01:05 +1030
Message-ID: <64d8a34bed1360c4771ead6a66e3c6df0ab86a7f.1743113694.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743113694.git.wqu@suse.com>
References: <cover.1743113694.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 31328211BA
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function btrfs_punch_hole_lock_range() needs to make sure there is
no other folio in the range, thus it goes with filemap_range_has_page(),
which works pretty fine.

But if we have large folios, under the following case
filemap_range_has_page() will always return true, forcing
btrfs_punch_hole_lock_range() to do a very time consuming busy loop:

        start                            end
        |                                |
  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
   \         /                         \   /
    Folio A                            Folio B

In above case, folio A and B contains our start/end index, and there is
no other folios in the range.
Thus there is no other folios and we do not need to retry inside
btrfs_punch_hole_lock_range().

To prepare for large data folios, introduce a helper,
check_range_has_page(), which will:

- Grab all the folios inside the range

- Skip any large folios that covers the start and end index

- If any other folios is found return true

- Otherwise return false

This new helper is going to handle both large folios and regular ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5d10ae321687..417c90ffc6fa 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2157,6 +2157,54 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	return ret;
 }
 
+/*
+ * The helper to check if there is no folio in the range.
+ *
+ * We can not utilized filemap_range_has_page() in a filemap with large folios
+ * as we can hit the following false postive:
+ *
+ *        start                            end
+ *        |                                |
+ *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
+ *   \         /                         \   /
+ *    Folio A                            Folio B
+ *
+ * That large folio A and B covers the start and end index.
+ * In that case filemap_range_has_page() will always return true, but the above
+ * case is fine for btrfs_punch_hole_lock_range() usage.
+ *
+ * So here we only ensure that no other folio is in the range, excluding the
+ * head/tail large folio.
+ */
+static bool check_range_has_page(struct inode *inode, u64 start, u64 end)
+{
+	struct folio_batch fbatch;
+	bool ret = false;
+	const pgoff_t start_index = start >> PAGE_SHIFT;
+	const pgoff_t end_index = end >> PAGE_SHIFT;
+	pgoff_t tmp = start_index;
+	int found_folios;
+
+	folio_batch_init(&fbatch);
+	found_folios = filemap_get_folios(inode->i_mapping, &tmp, end_index,
+					  &fbatch);
+	for (int i = 0; i < found_folios; i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		/* A large folio begins before the start. Not a target. */
+		if (folio->index < start_index)
+			continue;
+		/* A large folio extends beyond the end. Not a target. */
+		if (folio->index + folio_nr_pages(folio) > end_index)
+			continue;
+		/* A folio doesn't cover the head/tail index. Found a target. */
+		ret = true;
+		break;
+	}
+	folio_batch_release(&fbatch);
+	return ret;
+}
+
 static void btrfs_punch_hole_lock_range(struct inode *inode,
 					const u64 lockstart,
 					const u64 lockend,
@@ -2188,8 +2236,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * locking the range check if we have pages in the range, and if
 		 * we do, unlock the range and retry.
 		 */
-		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend))
+		if (!check_range_has_page(inode, page_lockstart, page_lockend))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.49.0


