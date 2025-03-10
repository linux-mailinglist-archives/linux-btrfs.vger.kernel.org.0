Return-Path: <linux-btrfs+bounces-12125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 964B8A58CFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65F516A68F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DEC221715;
	Mon, 10 Mar 2025 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FgXA24j6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FgXA24j6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E82206B7
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592188; cv=none; b=YuEMXYovq1BJhK1SulPSJqyvU+Qq/AvF0Nuj6J7R2AlaenYsAHRXP9yR6rNIycMF5/eYH4CNWPwFPB+l04c7soD6CedrXbts7iYsq1cb9YCj7tZdmGOFYZael2W1/bIFvqcIcZaVFczBelPdIlRBJAzWZ1tF12kc8mIwAFwgchU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592188; c=relaxed/simple;
	bh=89BjmmEhvQRbBtb1HyzwqPFSyXZvdZqG+Ee5t2XfwLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utcd3VwzgPJvDV1S7Cd+eTTWfodZ3mQmZ85iz/OwjCcfgj2Qf8prcBsgEBZKpGA7gYPRi1SgyaViTSGBZ1pumnjEo9iHN1PHLXrySIzJ9r/wNtZRk0FyRU86dZOcaZcqxfIJaaz3+xqXCjxv4iIOam9aH7Nw8u334aT1EP+1PmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FgXA24j6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FgXA24j6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE35921187
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUTm8WIOT9Y/QTRDHRtLHlFOtxXoFC9SyCGu6IqZyB8=;
	b=FgXA24j6qQIr2uGFZCQnKM5++GzOWkKLFq7Fh/mhoHFsk485LO/ddjqn6qTthOVxV3pSM8
	qu56glz4+LSFLAPGSSk+vgg6KEoLvky8IbRx+lzJYpYMcR1BeU3SIxYsEcNw9NSLOdkS8B
	crhZ+vPGlTu6x538gLpb40RgFS/tsKo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FgXA24j6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUTm8WIOT9Y/QTRDHRtLHlFOtxXoFC9SyCGu6IqZyB8=;
	b=FgXA24j6qQIr2uGFZCQnKM5++GzOWkKLFq7Fh/mhoHFsk485LO/ddjqn6qTthOVxV3pSM8
	qu56glz4+LSFLAPGSSk+vgg6KEoLvky8IbRx+lzJYpYMcR1BeU3SIxYsEcNw9NSLOdkS8B
	crhZ+vPGlTu6x538gLpb40RgFS/tsKo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DF5913A70
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aHjRL3aWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: add a @fsize parameter to btrfs_alloc_subpage()
Date: Mon, 10 Mar 2025 18:05:58 +1030
Message-ID: <b99b96a2099d9d2150909b93b7ccf1d220dbc168.1741591823.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: CE35921187
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
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
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

Since we can no longer assume page sized folio for data filemap folios,
allow btrfs_alloc_subpage() to accept a new parameter, @fsize,
indicating the folio size.

This doesn't follow the regular behavior of passing a folio directly,
because this function is shared by both data and metadata folios, and
for metadata folios we have extra allocation policy to ensure no larger
folios whose sizes are larger than nodesize (unless it's page sized).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/subpage.c   | 8 ++++----
 fs/btrfs/subpage.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d2a7472f28b6..337d2bed98d9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3257,7 +3257,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * manually if we exit earlier.
 	 */
 	if (btrfs_meta_is_subpage(fs_info)) {
-		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
+		prealloc = btrfs_alloc_subpage(fs_info, PAGE_SIZE, BTRFS_SUBPAGE_METADATA);
 		if (IS_ERR(prealloc)) {
 			ret = PTR_ERR(prealloc);
 			goto out;
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 1392b4eaa1f9..6e776c3bd873 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -86,7 +86,7 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio))
 		return 0;
 
-	subpage = btrfs_alloc_subpage(fs_info, type);
+	subpage = btrfs_alloc_subpage(fs_info, folio_size(folio), type);
 	if (IS_ERR(subpage))
 		return  PTR_ERR(subpage);
 
@@ -113,16 +113,16 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 }
 
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-					  enum btrfs_subpage_type type)
+				size_t fsize, enum btrfs_subpage_type type)
 {
 	struct btrfs_subpage *ret;
 	unsigned int real_size;
 
-	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+	ASSERT(fs_info->sectorsize < fsize);
 
 	real_size = struct_size(ret, bitmaps,
 			BITS_TO_LONGS(btrfs_bitmap_nr_max *
-				      (PAGE_SIZE >> fs_info->sectorsize_bits)));
+				      (fsize >> fs_info->sectorsize_bits)));
 	ret = kzalloc(real_size, GFP_NOFS);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index baa23258e7fa..083390e76d13 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -112,7 +112,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 
 /* Allocate additional data where page represents more than one sector */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-					  enum btrfs_subpage_type type);
+				size_t fsize, enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
 
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
-- 
2.48.1


