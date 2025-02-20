Return-Path: <linux-btrfs+bounces-11614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE81A3D5CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB76189F591
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5811F1927;
	Thu, 20 Feb 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="biwMKlVo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="biwMKlVo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E911F153E
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045652; cv=none; b=InrBZzBKJkjSBcGSVssst2eCUKfXjHkoAr6VJVZGAX220cYS69bukASejiY54TfVc1nsK/8B5NamLBvbdVb6oHs1jmrc0NSaWnR0RiDcfmMDn+cAy6mL/mFEByx2YRcMzENq1L+E4ASLHi446y2B5W7EnNTSDlOGi0jvPmyPnpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045652; c=relaxed/simple;
	bh=rO5NMQ32sQ5OCSJV/IIqvtQYUWJS+tG7fTR/aekvMGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWMT379lvSQtWrLv8DnEgkdzqhqNpX0EspWXMsGgyNIc+BeCFH299DgI323kaGN4RqIyG9q+TBxO7ConddjeGIXlcf9hft7FBPDrGZR9xEKzbj523hg79S+Zi0JlvZyKDychtwa1ROVo6kjPAaIGnlggW1BP0b/ow7N8jbKgWrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=biwMKlVo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=biwMKlVo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E25B721180;
	Thu, 20 Feb 2025 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcpEpWoNMhKFppOh6JYyEjw6uYxfxD5mmIaR+6wabD0=;
	b=biwMKlVojgV4CHl2ebaAQUOUhZ0dUhXbCCx+4rqeoD+dY1vPokuQQiA/tQhHZeg2bsn6Ca
	/zq+jcU3zZDJqzXZnXXjMogFT9ECEc0EUYXJIT0rmeRCSODbEJB5SbP29caRRXhBI+WJJs
	j8PY8Y13MovLzY+RTSbQjDjdQzP70so=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=biwMKlVo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcpEpWoNMhKFppOh6JYyEjw6uYxfxD5mmIaR+6wabD0=;
	b=biwMKlVojgV4CHl2ebaAQUOUhZ0dUhXbCCx+4rqeoD+dY1vPokuQQiA/tQhHZeg2bsn6Ca
	/zq+jcU3zZDJqzXZnXXjMogFT9ECEc0EUYXJIT0rmeRCSODbEJB5SbP29caRRXhBI+WJJs
	j8PY8Y13MovLzY+RTSbQjDjdQzP70so=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFBB13301;
	Thu, 20 Feb 2025 10:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wGx0NVD9tmdLfwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:00:48 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 02/22] btrfs: pass struct btrfs_inode to extent_range_clear_dirty_for_io()
Date: Thu, 20 Feb 2025 11:00:40 +0100
Message-ID: <92292e96190d2745fd8c626f4cb172c7e36d9c88.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E25B721180
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Pass a struct btrfs_inode to extent_range_clear_dirty_for_io() as it's
an internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f53f50a324b..2311d1b0d5a9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -819,7 +819,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 		btrfs_add_inode_defrag(inode, small_write);
 }
 
-static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+static int extent_range_clear_dirty_for_io(struct btrfs_inode *inode, u64 start, u64 end)
 {
 	unsigned long end_index = end >> PAGE_SHIFT;
 	struct folio *folio;
@@ -827,13 +827,13 @@ static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 e
 
 	for (unsigned long index = start >> PAGE_SHIFT;
 	     index <= end_index; index++) {
-		folio = filemap_get_folio(inode->i_mapping, index);
+		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
 		if (IS_ERR(folio)) {
 			if (!ret)
 				ret = PTR_ERR(folio);
 			continue;
 		}
-		btrfs_folio_clamp_clear_dirty(inode_to_fs_info(inode), folio, start,
+		btrfs_folio_clamp_clear_dirty(inode->root->fs_info, folio, start,
 					      end + 1 - start);
 		folio_put(folio);
 	}
@@ -881,7 +881,7 @@ static void compress_file_range(struct btrfs_work *work)
 	 * Otherwise applications with the file mmap'd can wander in and change
 	 * the page contents while we are compressing them.
 	 */
-	ret = extent_range_clear_dirty_for_io(&inode->vfs_inode, start, end);
+	ret = extent_range_clear_dirty_for_io(inode, start, end);
 
 	/*
 	 * All the folios should have been locked thus no failure.
-- 
2.47.1


