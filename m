Return-Path: <linux-btrfs+bounces-10821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAA0A0730C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79522188AEC6
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4122165FF;
	Thu,  9 Jan 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BY+MMW0S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BY+MMW0S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F72165F2
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418256; cv=none; b=tilnxnz8gJYDukY9p4lFUJ5u1cBvgIpKs2NgwMcKvTlhO/9HVe2CKMEZ2kuSVQSeqlyK6atOlSlffXrAwT1PPhYlpDEBzgylK7pmgVyaxb69T+txwU3Z2KZbL07Xm+hYzZg2UiIH0hU94bPSgpADKldZDOYsi1w3xoXZKi5DGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418256; c=relaxed/simple;
	bh=F67dmp8pgR/4fieMJUC+L+WZlAnnCnxsbwV+WQAxVhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6Lbd1jJBLBPBSWh4Mql3kcJngbCnL/tL8ykZJQxohy83FhK9QYOf6FvhKwmzVzQ5DaZ3JZeewN8wfzRZYrGdMziZaschvTu9FYC7wE2iHBZyQKqgNV7bsQhEmZbA8rpqJ4dmYTO5p3i8vNJngQhP6dbTogEFl/WYNwsHre0ASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BY+MMW0S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BY+MMW0S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BD9D21101;
	Thu,  9 Jan 2025 10:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4VjboKATCJgV0HJvOl0kUmP89xZYwbUpxQXpKe46nQ=;
	b=BY+MMW0SDdKvt18ZckE5bgRj/Y21rVc2MKglrgZ4ymMzF9EtZcC5RgVWcjJq1nRko0WwWH
	JkHiIPRfXR60y8Fyavj3dlsnyJrQtPM6M6YkqHt9Sg9ivz1k2LdI5mA/D7UQvKLi/Xqaxf
	cUeOIi2K0M3t+lrxaPOJfY1bgczvw+4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BY+MMW0S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4VjboKATCJgV0HJvOl0kUmP89xZYwbUpxQXpKe46nQ=;
	b=BY+MMW0SDdKvt18ZckE5bgRj/Y21rVc2MKglrgZ4ymMzF9EtZcC5RgVWcjJq1nRko0WwWH
	JkHiIPRfXR60y8Fyavj3dlsnyJrQtPM6M6YkqHt9Sg9ivz1k2LdI5mA/D7UQvKLi/Xqaxf
	cUeOIi2K0M3t+lrxaPOJfY1bgczvw+4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14EF7139AB;
	Thu,  9 Jan 2025 10:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1yQcBc2jf2cuEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:13 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/18] btrfs: open code set_page_extent_mapped()
Date: Thu,  9 Jan 2025 11:24:12 +0100
Message-ID: <b1f8fdc5b03b3bf9ae0478e09039dd82208d0087.1736418116.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 1BD9D21101
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function set_page_extent_mapped() is now a simple wrapper so use the
folio helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c        | 5 -----
 fs/btrfs/extent_io.h        | 1 -
 fs/btrfs/free-space-cache.c | 2 +-
 fs/btrfs/relocation.c       | 2 +-
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8c472560e43e..39113772241b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -861,11 +861,6 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 	return ret;
 }
 
-int set_page_extent_mapped(struct page *page)
-{
-	return set_folio_extent_mapped(page_folio(page));
-}
-
 int set_folio_extent_mapped(struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8a36117ed453..d14bda928e7b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -248,7 +248,6 @@ int btree_write_cache_pages(struct address_space *mapping,
 			    struct writeback_control *wbc);
 void btrfs_readahead(struct readahead_control *rac);
 int set_folio_extent_mapped(struct folio *folio);
-int set_page_extent_mapped(struct page *page);
 void clear_folio_extent_mapped(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3048cb38dc80..d42b6f882f57 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -461,7 +461,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 			return -ENOMEM;
 		}
 
-		ret = set_page_extent_mapped(page);
+		ret = set_folio_extent_mapped(page_folio(page));
 		if (ret < 0) {
 			unlock_page(page);
 			put_page(page);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index d4100e58172f..af0969b70b53 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2870,7 +2870,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 
 	/*
 	 * We could have lost folio private when we dropped the lock to read the
-	 * folio above, make sure we set_page_extent_mapped here so we have any
+	 * folio above, make sure we set_folio_extent_mapped() here so we have any
 	 * of the subpage blocksize stuff we need in place.
 	 */
 	ret = set_folio_extent_mapped(folio);
-- 
2.47.1


