Return-Path: <linux-btrfs+bounces-6030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D20991B5AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 06:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B98283E6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 04:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55915249ED;
	Fri, 28 Jun 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DA5hSYjf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DA5hSYjf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9571CAA2
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548518; cv=none; b=JsCwAmD6SpQ7Ln4WlXb0DQmmdM/t9Zt7h9heE9NuHk13FVxGHjmDnDjxpQIq/TiQAk/0StwcVupgVSJxTIDMjxoveSw2Vso7jD80/vtifiQ6P/jRHqgQiBoWOOBDMo0z3WKBqmcFbAmVYFCOSWCiBqp/oGOUw894Kk0oGZqGn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548518; c=relaxed/simple;
	bh=U6RWeUp6cDLliM+dsMuj0Y0jcTQHeMrLAEIOPsGpkS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=En7eOvc5xWx1G3Wv78rh/DR4GR1piOIIqCjJuQIYC13BYEMzYoeBASBI4ar8eic//MjlXlCgPUrmAuryUrladozKmV2Emx1SvvMkDaxANoXnyzvthKeRwmRvN3dqeJyvAD+g8fsPirqC5LVAbKmEzuWIAI5Rq0bo3uGDE/cybgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DA5hSYjf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DA5hSYjf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2ED021A59;
	Fri, 28 Jun 2024 04:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+IJy/B0lOD6/mre2eSW301GZhg/Cu6UsHg9qpTZySA=;
	b=DA5hSYjf+6mhO4ZcJcewUxVEu4TQ3DGaj9Hm9i+uXi3RSUs5e67kUAkCsNXNux76RD2c3G
	GONqmAcWZizHKft2EocIZKFvIl1juxKVa42GvQSwNhJj8fTHq7F0P67GSggOy0jGO3qAeX
	p8SDno3lTeO1VzrPOoUsPYU2U6FEJfk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DA5hSYjf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719548514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+IJy/B0lOD6/mre2eSW301GZhg/Cu6UsHg9qpTZySA=;
	b=DA5hSYjf+6mhO4ZcJcewUxVEu4TQ3DGaj9Hm9i+uXi3RSUs5e67kUAkCsNXNux76RD2c3G
	GONqmAcWZizHKft2EocIZKFvIl1juxKVa42GvQSwNhJj8fTHq7F0P67GSggOy0jGO3qAeX
	p8SDno3lTeO1VzrPOoUsPYU2U6FEJfk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83E351373E;
	Fri, 28 Jun 2024 04:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ELTHD2E6fmZXWwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 28 Jun 2024 04:21:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/2] btrfs: remove the extra_gfp parameter from btrfs_alloc_folio_array()
Date: Fri, 28 Jun 2024 13:51:29 +0930
Message-ID: <960fb7f5f1c39f0723a9d8f67057bc52d21b5fd1.1719548446.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719548446.git.wqu@suse.com>
References: <cover.1719548446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2ED021A59
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

The function btrfs_alloc_folio_array() is only utilized in
btrfs_submit_compressed_read() and no other location, and the only
caller is not utilizing the @extra_gfp parameter.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 +-
 fs/btrfs/extent_io.c   | 8 +++-----
 fs/btrfs/extent_io.h   | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 85eb2cadbbf6..a149f3659b15 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -609,7 +609,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 		goto out_free_bio;
 	}
 
-	ret2 = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios, 0);
+	ret2 = btrfs_alloc_folio_array(cb->nr_folios, cb->compressed_folios);
 	if (ret2) {
 		ret = BLK_STS_RESOURCE;
 		goto out_free_compressed_pages;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c7a9284e45e1..dc416bad9ad8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -667,24 +667,22 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 }
 
 /*
- * Populate every free slot in a provided array with folios.
+ * Populate every free slot in a provided array with folios using GFP_NOFS.
  *
  * @nr_folios:   number of folios to allocate
  * @folio_array: the array to fill with folios; any existing non-NULL entries in
  *		 the array will be skipped
- * @extra_gfp:	 the extra GFP flags for the allocation
  *
  * Return: 0        if all folios were able to be allocated;
  *         -ENOMEM  otherwise, the partially allocated folios would be freed and
  *                  the array slots zeroed
  */
-int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
-			    gfp_t extra_gfp)
+int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
 {
 	for (int i = 0; i < nr_folios; i++) {
 		if (folio_array[i])
 			continue;
-		folio_array[i] = folio_alloc(GFP_NOFS | extra_gfp, 0);
+		folio_array[i] = folio_alloc(GFP_NOFS, 0);
 		if (!folio_array[i])
 			goto error;
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8b33cfea6b75..8364dcb1ace3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -365,8 +365,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp);
-int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
-			    gfp_t extra_gfp);
+int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.45.2


