Return-Path: <linux-btrfs+bounces-5224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EB38CCA57
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89EF1C21188
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7B04C8C;
	Thu, 23 May 2024 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rlzAnYpq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rlzAnYpq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7F1C36
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716427204; cv=none; b=tUrzyE90CsQqPVQbakdvCcyVqnOZpTiWfru9efl5n4/9A7PGaqkGBH/8BElk3iLvydVyh/J/eCc5ffU3VasMOBQM4QBaI7ABkxfsiGKbBmAvSUSm3ijFPEH6JgMjyNKOmGRZZxMhf0Jl5smlrgMfJmH/QnW8aZeI/YnoAgLboNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716427204; c=relaxed/simple;
	bh=dKw0wS1/hxRdiiVrTtAwW97HkdniKQdxlz1A0Zfu2so=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AH6tpgowpqi9NAgX69Tiw+cRIIzsbsXvlQTczGtSXmCACSc8YNZgrAaww4RpXUtABQ1uIBQ5FCSgjYBR69r/e6zb6IiK6JFqClIBHHK9r8Y7nACAX2knLoUqdo8MeZ9O7Yeuj//4N6ZnxPP7Z3o85WttNhWwUCh6Wd2CBlgDWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rlzAnYpq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rlzAnYpq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7CFB81FD33
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phTPB3XELv7lIRf7WfdMKOqmlB7uITnjKD4HgRL0hRw=;
	b=rlzAnYpq0c/ZjyuSAEWMGMr5Rvgzjp37/BSBDwKRNYtdrVQ9K8X8alIaoG3ziZ5GnXlkAb
	orNKSRkbOVdR6VcwAYLolCKTF/lkiWnl2f7rOjZgzIYXVY0EPg95qittfT5JLgVVFGbooK
	jeoucszhwgQRZUeZzRR7XvXST2N4DAU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716427200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=phTPB3XELv7lIRf7WfdMKOqmlB7uITnjKD4HgRL0hRw=;
	b=rlzAnYpq0c/ZjyuSAEWMGMr5Rvgzjp37/BSBDwKRNYtdrVQ9K8X8alIaoG3ziZ5GnXlkAb
	orNKSRkbOVdR6VcwAYLolCKTF/lkiWnl2f7rOjZgzIYXVY0EPg95qittfT5JLgVVFGbooK
	jeoucszhwgQRZUeZzRR7XvXST2N4DAU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9559213A25
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBI4FL+ZTmYDJwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 01:19:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()
Date: Thu, 23 May 2024 10:49:38 +0930
Message-ID: <440b1e77fbf89ee8b4cc2b9871f45641bd234746.1716427131.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716427131.git.wqu@suse.com>
References: <cover.1716427131.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Previously we have BUG_ON() inside extent_range_clear_dirty_for_io(), as
we expect all involved folios are still locked, thus no folio should be
missing.

However for extent_range_clear_dirty_for_io() itself, we can skip the
missing folio and handling the remaining ones, and return an error if
there is anything wrong.

So this patch would remove the BUG_ON() and let the caller to handle the
error.
In the caller we do not have a quick way to cleanup the error, but all
the compression routines would handle the missing folio as an error and
properly error out, so we only need to do an ASSERT() for developers,
meanwhile for non-debug build the compression routine would handle the
error correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 99be256f4f0e..126457236427 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -890,19 +890,24 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 		btrfs_add_inode_defrag(NULL, inode, small_write);
 }
 
-static void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
-	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
 	struct page *page;
+	int ret = 0;
 
-	while (index <= end_index) {
+	for (unsigned long index = start >> PAGE_SHIFT;
+	     index <= end_index; index++) {
 		page = find_get_page(inode->i_mapping, index);
-		BUG_ON(!page); /* Pages should be in the extent_io_tree */
+		if (unlikely(!page)) {
+			if (!ret)
+				ret = -ENOENT;
+			continue;
+		}
 		clear_page_dirty_for_io(page);
 		put_page(page);
-		index++;
 	}
+	return ret;
 }
 
 /*
@@ -946,7 +951,16 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Otherwise applications with the file mmap'd can wander in and change
 	 * the page contents while we are compressing them.
 	 */
-	extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+	ret = extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+
+	/*
+	 * All the folios should have been locked thus no failure.
+	 *
+	 * And even some folios are missing, btrfs_compress_folios()
+	 * would handle them correctly, so here just do an ASSERT() check for
+	 * early logic errors.
+	 */
+	ASSERT(ret == 0);
 
 	/*
 	 * We need to save i_size before now because it could change in between
-- 
2.45.1


