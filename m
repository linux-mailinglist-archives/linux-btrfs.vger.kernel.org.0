Return-Path: <linux-btrfs+bounces-6218-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC759281C4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 08:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161811F22F1E
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 06:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D87D142E6F;
	Fri,  5 Jul 2024 06:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aCKK8WIm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aCKK8WIm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73EC8565E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160170; cv=none; b=JRIM9VxRBgQskOwcFe3B1M4PsyOtSpatOXphFBtbLiXBIASfd1XX/M6QaXhkHdQY7G+jihvckhF3hfxOuSRe9+/UUg9WRsfQ3i3Jn85xe2a8V4C+3LCdLDISjzL4/b9T4DA5/3SVcqqO7ahs1VHu+GPaOF3m4yXOtqRZPE4Vs4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160170; c=relaxed/simple;
	bh=e9dnkGu14neSQjhQ3dx50Jyyc8TMT+qoTmjB2WGwvAk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgL7bxE9RpOL6VlLhvuKVp0Jey50C7Pz6g/a4EkSV5n3J6jJp6XzfM6InLO1TYBK8G5dMAOfNiHEG9BO2kmg/qcMANKO/dCah5JlUnFGyHWSJ7C+KYrhRvzmectkZIZLGVSh0APF5BkPMgA4gOyN+qrV5f0YWyDG1CuSw6Pp7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aCKK8WIm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aCKK8WIm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1910621A90
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNHV49s15rk/afsSK8Rxirz/6gr0wrm2UGbZqyfH7Ro=;
	b=aCKK8WImB4xNjCujYgBEoeO/6ljbJoWHo2lum/4whB1PrPdE2hMUStlPqFvwgTIpy4LXwL
	hWQ6CtR/GglYALhOd7EaccuRppbcp5AwsCuC+jbOpe7v5hYS3WGYlnEhmKhOyQuhvwwTpI
	iofy4ThZsCmRo92PR/34l6k1XQkJH5o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720160166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNHV49s15rk/afsSK8Rxirz/6gr0wrm2UGbZqyfH7Ro=;
	b=aCKK8WImB4xNjCujYgBEoeO/6ljbJoWHo2lum/4whB1PrPdE2hMUStlPqFvwgTIpy4LXwL
	hWQ6CtR/GglYALhOd7EaccuRppbcp5AwsCuC+jbOpe7v5hYS3WGYlnEhmKhOyQuhvwwTpI
	iofy4ThZsCmRo92PR/34l6k1XQkJH5o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38E591396E
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Jul 2024 06:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2GCOOKSPh2YQFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2024 06:16:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: do not use __GFP_NOFAIL flag for attach_eb_folio_to_filemap()
Date: Fri,  5 Jul 2024 15:45:39 +0930
Message-ID: <d6a9c038e12f1f2dae353f1ba657ba0666f0aaaa.1720159494.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720159494.git.wqu@suse.com>
References: <cover.1720159494.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The gfp_flag passed into filemap_add_folio() is utilized by two
locations:

- mem_cgroup_charge()
  I'm not confident mem cgroup is going to handle the different
  combinations of folio order and __GFP_NOFAIL that well.
  In fact I'm already hitting various soft lockup in mem cgroup related
  code during larger metadata folio tests.

- Xarray split
  I believe this is mostly fine.

Although extent buffer allocation is very critical, we can still handle
the errors, the worst case is to abort the current transaction.

So to enable more testing and hopefully to provide a smooth transaction,
for CONFIG_BTRFS_DEBUG builds do not use __GFP_NOFAIL flag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d43a3a9fc650..97c3f272fcaa 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2966,6 +2966,7 @@ static int check_eb_alignment(struct btrfs_fs_info *fs_info, u64 start)
  * and @found_eb_ret would be updated.
  * Return -EAGAIN if the filemap has an existing folio but with different size
  * than @eb.
+ * Return -ENOMEM if the memory allocation failed.
  * The caller needs to free the existing folios and retry using the same order.
  */
 static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
@@ -2977,6 +2978,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
 	struct folio *existing_folio = NULL;
+	const bool debug = IS_ENABLED(CONFIG_BTRFS_DEBUG);
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -2986,10 +2988,13 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 retry:
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
-				GFP_NOFS | __GFP_NOFAIL);
+				GFP_NOFS | (!debug ? __GFP_NOFAIL : 0));
 	if (!ret)
 		goto finish;
+	if (unlikely(ret == -ENOMEM))
+		return ret;
 
+	ASSERT(ret == -EEXIST);
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
 	if (IS_ERR(existing_folio)) {
@@ -3126,6 +3131,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 			ASSERT(existing_eb);
 			goto out;
 		}
+		if (unlikely(ret == -ENOMEM))
+			goto out;
 
 		/*
 		 * TODO: Special handling for a corner case where the order of
-- 
2.45.2


