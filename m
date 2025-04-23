Return-Path: <linux-btrfs+bounces-13282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46EA98428
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8BE73B3DC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455D51C6FF9;
	Wed, 23 Apr 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lyhT9U2A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lyhT9U2A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92513535D8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398298; cv=none; b=K0fjhpJ70qE18LOB15oi1oQ+wSyfg6TYoB8cOfKhxjsENREL8VKH+GOqvQwmeoLSbKxYqu22qBAF9QYjN8TX4YFRbYzBHvGtUENQi6mkphVLbZdOSeiqSftyK56+omOa0IbnTQ7db+yA9NFO5DuQMAUt08eBD/BsYkESSUKTICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398298; c=relaxed/simple;
	bh=D9/V6BAueUg9tsVWiAKhJtuIZPIfkAkNRDK1THCBbok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvyM++WmD8OZ/Y4gt8nVFyIUcnoj4/rW6Zkp9UqRxRcVjXML29VsRfXwZz0GpMLG9qQvQpRdOTtLUiZmFiS9Cc1jACeB65HCVoLpKcJJg3iPj0DSYV1fGgDbz8+DFHZtkMBaSKE0nvRNbe8Mpe8ntPeQQccA4+SJ2lphne8QDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lyhT9U2A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lyhT9U2A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BA8CF1F38E;
	Wed, 23 Apr 2025 08:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745398294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5lbL4HDSH9vg67l6nnz0LvwIaQuYIbLmkbq1JnPLTA=;
	b=lyhT9U2AGkr1mpZaSRj9kNj/fvdSvjeEG6GhR+fgtnVXeSP8vAH2SOqf+xVdPo/0DMjW1d
	OfJgB6dls0uUyfjqM1XMJwgVW+mzFn2MHddHQ/9n2g5R4U91CEKldQoaV2jEY51JVgoglC
	3fvUfRuB/mxE1rNpOzHyGzGRyf1c5f0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745398294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=X5lbL4HDSH9vg67l6nnz0LvwIaQuYIbLmkbq1JnPLTA=;
	b=lyhT9U2AGkr1mpZaSRj9kNj/fvdSvjeEG6GhR+fgtnVXeSP8vAH2SOqf+xVdPo/0DMjW1d
	OfJgB6dls0uUyfjqM1XMJwgVW+mzFn2MHddHQ/9n2g5R4U91CEKldQoaV2jEY51JVgoglC
	3fvUfRuB/mxE1rNpOzHyGzGRyf1c5f0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4EB613A3D;
	Wed, 23 Apr 2025 08:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U1LKJxaqCGjvfwAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 23 Apr 2025 08:51:34 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: a small cleanup in attach_eb_folio_to_filemap()
Date: Wed, 23 Apr 2025 10:51:22 +0200
Message-ID: <20250423085123.4029320-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is just a trivial change. The code looks a bit more readable this way, IMO.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7023dd527d3e7..cab4cc5583400 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3139,7 +3139,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
-	struct folio *existing_folio = NULL;
+	struct folio *existing_folio;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -3148,6 +3148,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	ASSERT(eb->folios[i]);
 
 retry:
+	existing_folio = NULL;
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
@@ -3155,10 +3156,8 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
-	if (IS_ERR(existing_folio)) {
-		existing_folio = NULL;
+	if (IS_ERR(existing_folio))
 		goto retry;
-	}
 
 	/* For now, we should only have single-page folios for btree inode. */
 	ASSERT(folio_nr_pages(existing_folio) == 1);
-- 
2.47.2


