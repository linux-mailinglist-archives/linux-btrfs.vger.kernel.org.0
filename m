Return-Path: <linux-btrfs+bounces-1558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B7B831FDB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 20:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3A32858AA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 19:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C52E63C;
	Thu, 18 Jan 2024 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="obGBS5L2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M4qz+HCZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="obGBS5L2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M4qz+HCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FF2E636
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607167; cv=none; b=MFyu/eDHQukqAW4+dwxi6bs7WoL/aTKJa4s5ulRxkU5IUyD8HJHDzkDb4nEWa1abZv9NMv/83ELMcmA7QqLjAU+e9gUaoxbqctPt9vkJiAfqLswF3AOEqlIEzWv6dmj6rwb1lno7mHmgADojV4aRe/T7I5uHSg5WCK8ZxxiFkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607167; c=relaxed/simple;
	bh=YW3UAvSHFC2Q+0/W0QxQ4yNw4EzKhPiH8V8nNQNyCeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXtrJHEOQkWAisw4qDyIUN85sSto6jEMcYkjwMwP6QHJkfKU1KeSUNB0fMFw0n0oSO3WeHwKV1Wq4tx8BIU7btujJZ42X12bzYiq2sFOVOsYGKGrZ6nfqYT+PPfRPjvUepVoC8OVaUqg88PRYzyVaS7qH3rgBer6Vgx2SSBZvMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=obGBS5L2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M4qz+HCZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=obGBS5L2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M4qz+HCZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 443091F7B1;
	Thu, 18 Jan 2024 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgPjuXDEbzhkctXiSBhikWu3zqZDImzfP3ch9OKJ/Uw=;
	b=obGBS5L2/WlXDX4qOmSSmsfL9xusBL2+/3Ec2J0guqngDSy2wL9TT6xM2S76uDygdoMbiX
	ekmoEuYwkiwRuVjH8G+3Ivhqy8n0Fjfk0Z/8uUqhEtI840NnAxz0eB+0rtlr+OYh7C7OeT
	STCL9Td9VeKLFtdsiH/cZW0AYGHewFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgPjuXDEbzhkctXiSBhikWu3zqZDImzfP3ch9OKJ/Uw=;
	b=M4qz+HCZkstZyIzGqQU9p4I2S2Yo4qq9U6RIdD39z3LbKSZXfocxsWP3pHhGBhzX065iLF
	ukxHHSTtQvPLvCDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgPjuXDEbzhkctXiSBhikWu3zqZDImzfP3ch9OKJ/Uw=;
	b=obGBS5L2/WlXDX4qOmSSmsfL9xusBL2+/3Ec2J0guqngDSy2wL9TT6xM2S76uDygdoMbiX
	ekmoEuYwkiwRuVjH8G+3Ivhqy8n0Fjfk0Z/8uUqhEtI840NnAxz0eB+0rtlr+OYh7C7OeT
	STCL9Td9VeKLFtdsiH/cZW0AYGHewFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgPjuXDEbzhkctXiSBhikWu3zqZDImzfP3ch9OKJ/Uw=;
	b=M4qz+HCZkstZyIzGqQU9p4I2S2Yo4qq9U6RIdD39z3LbKSZXfocxsWP3pHhGBhzX065iLF
	ukxHHSTtQvPLvCDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E97271377F;
	Thu, 18 Jan 2024 19:45:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tz8BKPN/qWXBBQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Jan 2024 19:45:55 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/4] btrfs: page to folio conversion: prealloc_file_extent_cluster()
Date: Thu, 18 Jan 2024 13:46:38 -0600
Message-ID: <55f236028fe97c2119ad8aa51cc6e5fe0cb04d0b.1705605787.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705605787.git.rgoldwyn@suse.com>
References: <cover.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[24.58%]
X-Spam-Level: ***
X-Spam-Score: 3.90
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Convert usage of page to folio in prealloc_file_extent_cluster(). This converts
all page-based function calls to folio-based.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/relocation.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index abe594f77f99..c365bfc60652 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2858,7 +2858,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		struct address_space *mapping = inode->vfs_inode.i_mapping;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
 		const u32 sectorsize = fs_info->sectorsize;
-		struct page *page;
+		struct folio *folio;
 
 		ASSERT(sectorsize < PAGE_SIZE);
 		ASSERT(IS_ALIGNED(i_size, sectorsize));
@@ -2889,16 +2889,16 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 		clear_extent_bits(&inode->io_tree, i_size,
 				  round_up(i_size, PAGE_SIZE) - 1,
 				  EXTENT_UPTODATE);
-		page = find_lock_page(mapping, i_size >> PAGE_SHIFT);
+		folio = filemap_lock_folio(mapping, i_size >> PAGE_SHIFT);
 		/*
 		 * If page is freed we don't need to do anything then, as we
 		 * will re-read the whole page anyway.
 		 */
-		if (page) {
-			btrfs_subpage_clear_uptodate(fs_info, page_folio(page), i_size,
+		if (!IS_ERR(folio)) {
+			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
 					round_up(i_size, PAGE_SIZE) - i_size);
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 	}
 
-- 
2.43.0


