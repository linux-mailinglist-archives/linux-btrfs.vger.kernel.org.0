Return-Path: <linux-btrfs+bounces-20479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0CDD1C16E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8A430206AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 02:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A68D21D3F6;
	Wed, 14 Jan 2026 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kjBihVLV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZTGMjHcq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965892F3C3D
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768356528; cv=none; b=mKdWpYEnSyQ+OVLctc/ZoUtQEdUOxmeotENmkeVqW43VeHtafHTMw8gJOfs8RAzDe/yI4YHFxD18/+j7gqetGRzK7eBj4Zn5mHslKhi1n7ToX0vjUvrGb2kg/70PBvzQ8eC+4kM6n+87pJpJEEZL201gPq9+oQ2TsbMmlQEJM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768356528; c=relaxed/simple;
	bh=aupGFnwQ3YTOMyuzX6zAaHe3ujPVOd2OmuwPRowOrDY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eDv+VWLTE4M7Vd+dwW/6AxbNcIr7rfmc6Y+/YZamtAJ9wgkk8WukG1iU8422MDXsrqFEurWWijCZyTwxv1cltxd72ghQ1192LV4/KbTdTP0NSSQJ9akSysfqg7/i0SVqoIH1Kra8zj5JPvxwBZC7M/ngnqUvHaF1YH/gtT0PchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kjBihVLV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZTGMjHcq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB5225BCCA
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768356519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BvK/NbW4wO1NP1OSuBObBH4VZrsiaU1T2nxwongRvww=;
	b=kjBihVLVfty6B35FPnjMOymSRojcnbBpOQ1guRAPWT9Eb7BU2WlmW2GqeDkvKjzZ5gh/VW
	Xb8GGJDDk6Bo0SGk/OHegpl3FEDglrFY3TkY/soixfrcejuNHTwhLR/ZlF3I/tyGN8jdsB
	fBh6C77NCLpJe3K453hk6wPSqlXMm34=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768356518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BvK/NbW4wO1NP1OSuBObBH4VZrsiaU1T2nxwongRvww=;
	b=ZTGMjHcq6F6MBPWk+ZJa1PDO+d9o2MQzSxJ8YEP2atpNJqObpPwHZRBbs3wk0ed4K6NuKW
	a6QZE39UunM6vEX65FFOb3+4HFg5xqsp1H0NaS9Kd6OeTiLwts7KqsTZOvEnDxEiWMBREg
	iC7O4ISrsxZSrg4n3OX8/mtQpRprzsI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 159553EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 02:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LxTIMaX6Zmk3bQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 02:08:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: minor improvement on cow_file_range() error handling
Date: Wed, 14 Jan 2026 12:38:16 +1030
Message-ID: <179097dcd57ea022d37d97eb0bcc69dcd24243ba.1768356495.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There are some minor problems related to the error handling of
cow_file_range():

- The label out_unlock: is not obvious
  In fact we only go that tag for error handling.

- mapping_set_error() is not always called
  It's only called if we have processed some range.

Enhance those minor problems by:

- Rename out_unlock: to error:
  So it's clear we only go there for error handling, not some generic
  handling shared by the common path.

- Always call mapping_set_error()
  Not hiding it behind certain error pattern nor behind @lock_folio
  parameter, which is always provided for all call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 67220ed62000..62d43b5bf910 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1456,12 +1456,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	if (unlikely(btrfs_is_shutdown(fs_info))) {
 		ret = -EIO;
-		goto out_unlock;
+		goto error;
 	}
 
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
-		goto out_unlock;
+		goto error;
 	}
 
 	num_bytes = ALIGN(end - start + 1, blocksize);
@@ -1553,7 +1553,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			ret = -ENOSPC;
 		}
 		if (ret < 0)
-			goto out_unlock;
+			goto error;
 
 		/* We should not allocate an extent larger than requested.*/
 		ASSERT(cur_alloc_size <= num_bytes);
@@ -1570,7 +1570,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		*done_offset = end;
 	return ret;
 
-out_unlock:
+error:
+	mapping_set_error(inode->vfs_inode.i_mapping, ret);
 	/*
 	 * Now, we have three regions to clean up:
 	 *
@@ -1593,9 +1594,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC;
 		page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
-		if (!locked_folio)
-			mapping_set_error(inode->vfs_inode.i_mapping, ret);
-
 		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_folio, NULL, clear_bits, page_ops);
-- 
2.52.0


