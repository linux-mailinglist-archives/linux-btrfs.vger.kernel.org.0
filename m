Return-Path: <linux-btrfs+bounces-1652-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A483D83997F
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF26A1C283B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527C85C41;
	Tue, 23 Jan 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UH9x50Rm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0Gd/pk0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UH9x50Rm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w0Gd/pk0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C02A823C6
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038041; cv=none; b=fPqGLe8HplkEM6chXqnCVdAMx1W/bB7V+5ud9MykovRnROnHGXoBYreaugh5dPCMwowWc32Er3FSBOLKwXIk8oILQ6HA4N/ibHJQsxYgjh9pnClsiAd3To+H7iQbTh+1Cs/iFnjmIPpPzAaOA2VqgE0E9JAAwvFyxWSOuby9EeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038041; c=relaxed/simple;
	bh=GpZ0xXw7MOrgIVSSk0ED3LJZnIMqQjiMsSqakAvdFP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSF1k2ozy/WKQbX8trixiYGta7+C30m3QonUEB5FupLDjm/LXhaNkFMuCco7jWMj07HVkLL52yQ+cAhLnQWkyBdnd0qZUQ2Dy8s/ECmAG5rhFepNLu6vc0pJMvMfRPhiCV93uK817lpdG++3ogCorAPrw/xwy08UfcTMId9P2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UH9x50Rm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0Gd/pk0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UH9x50Rm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w0Gd/pk0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FBF421E97;
	Tue, 23 Jan 2024 19:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luWdDWRCiQ6sJpxW3KU9/agaJ4rECbR0S4aQ+i5pLok=;
	b=UH9x50Rm0N5n0Tuy/PJn8L7VIn6K6SLf1Wr1owkxGPets9xaQa+D+z7WqkWZu89n6xqoQv
	MZms0GXFz6A2XO+UwTE65715WEXQ2DA0VK0FPrAN9AXYjPKeSZGzYXcTezGpqdLiRJgwpe
	VBiZn/TNNt9EGz0gxRLAdt00WS+nXQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luWdDWRCiQ6sJpxW3KU9/agaJ4rECbR0S4aQ+i5pLok=;
	b=w0Gd/pk0umoakCY+9ONThqAnWftns2mIWD6fiTZlumeDJ7fUgQWjiG1HFG4X3qUp2eZEKu
	5xpaAQRF2J6b5SAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luWdDWRCiQ6sJpxW3KU9/agaJ4rECbR0S4aQ+i5pLok=;
	b=UH9x50Rm0N5n0Tuy/PJn8L7VIn6K6SLf1Wr1owkxGPets9xaQa+D+z7WqkWZu89n6xqoQv
	MZms0GXFz6A2XO+UwTE65715WEXQ2DA0VK0FPrAN9AXYjPKeSZGzYXcTezGpqdLiRJgwpe
	VBiZn/TNNt9EGz0gxRLAdt00WS+nXQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luWdDWRCiQ6sJpxW3KU9/agaJ4rECbR0S4aQ+i5pLok=;
	b=w0Gd/pk0umoakCY+9ONThqAnWftns2mIWD6fiTZlumeDJ7fUgQWjiG1HFG4X3qUp2eZEKu
	5xpaAQRF2J6b5SAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 047B013786;
	Tue, 23 Jan 2024 19:27:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8kyuKBUTsGXSQAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Jan 2024 19:27:17 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: page to folio conversion: prealloc_file_extent_cluster()
Date: Tue, 23 Jan 2024 13:28:05 -0600
Message-ID: <1e3b81d212e9e6f9d43eb0325a6149bf1ed51f11.1706037337.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706037337.git.rgoldwyn@suse.com>
References: <cover.1706037337.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UH9x50Rm;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="w0Gd/pk0"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.20)[71.22%]
X-Spam-Score: 0.29
X-Rspamd-Queue-Id: 5FBF421E97
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Convert usage of page to folio in prealloc_file_extent_cluster()

Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
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


