Return-Path: <linux-btrfs+bounces-5220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB18CC9D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 01:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4EE283187
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A3C14D2AC;
	Wed, 22 May 2024 23:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U3n6rpT+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U3n6rpT+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD7014C5BF
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716421698; cv=none; b=olpobGvi2MaBUwm4mTFCS6IRnt6HRV7a4iMHkrGjEuo/pjduf4ua7qZYNe5HQ1h+f6q3QjYGBjtXuvu6VR1Fh4lPuTS3aVHznwU586gGgSJpm/gnb2SnSzgc0xfhdFeqbe9fCL/wVCstKJysl1Jc92eqZfSxtQlduPYduHCkL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716421698; c=relaxed/simple;
	bh=HRgYvZg+6n6aYzXHV4jo8tLCY5yWQaJNyTy543B4I7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S71881jxDFUyhHPWzHYu6WEuhaK+jGzqbssAhzsiFFbQo3DmDnPgDlMD6BKHMtCZSwQj5ES6giPkKYUQ5em8bXRhBCh3vaAM4a7FT5Lh4XUY3p6UnkgMvpIi6urMUq+kMefN/zMPzDoSWfQfa9+h/XBRFeVQJy0M8iLA0NbBv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U3n6rpT+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U3n6rpT+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0128221A2F
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVDf8PK66sR9MaDx73uAjx1lTiyvLJgIc+eHfxXT5CI=;
	b=U3n6rpT+0yBN5MJe9LVoCkVW++QfnLXzSad++rx3bpEpRKvPn4uEovi/Y796lgE7rd/2XX
	ZweYUkdeGLXWI14qQNoxlAlOkY9PlUkXcqI3S5E92gl7poUVUB5LAmB5sK1iJejotFU41v
	AeeOr+PEsuRxbxY+/EjoJo01lvLBvV4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=U3n6rpT+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716421695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVDf8PK66sR9MaDx73uAjx1lTiyvLJgIc+eHfxXT5CI=;
	b=U3n6rpT+0yBN5MJe9LVoCkVW++QfnLXzSad++rx3bpEpRKvPn4uEovi/Y796lgE7rd/2XX
	ZweYUkdeGLXWI14qQNoxlAlOkY9PlUkXcqI3S5E92gl7poUVUB5LAmB5sK1iJejotFU41v
	AeeOr+PEsuRxbxY+/EjoJo01lvLBvV4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E3B913A1E
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2AO5KT2ETmb6aQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 23:48:13 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: remove the BUG_ON() inside extent_range_clear_dirty_for_io()
Date: Thu, 23 May 2024 09:17:47 +0930
Message-ID: <167cb36269f6f08bf0e14d8a564ad75a62c102a8.1716421534.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716421534.git.wqu@suse.com>
References: <cover.1716421534.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0128221A2F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

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
index dda47a273813..18b833e58d19 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -890,24 +890,29 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 		btrfs_add_inode_defrag(NULL, inode, small_write);
 }
 
-static void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
+static int extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	const u64 len = end + 1 - start;
-	unsigned long index = start >> PAGE_SHIFT;
 	unsigned long end_index = end >> PAGE_SHIFT;
+	int ret = 0;
 
 	/* We should not have such large range. */
 	ASSERT(len < U32_MAX);
-	while (index <= end_index) {
+	for (unsigned long index = start >> PAGE_SHIFT;
+	     index <= end_index; index++) {
 		struct folio *folio;
 
 		folio = filemap_get_folio(inode->i_mapping, index);
-		BUG_ON(IS_ERR(folio)); /* Pages should have been locked. */
+		if (IS_ERR(folio)) {
+			if (!ret)
+				ret = PTR_ERR(folio);
+			continue;
+		}
 		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
 		folio_put(folio);
-		index++;
 	}
+	return ret;
 }
 
 /*
@@ -951,7 +956,16 @@ static void compress_file_range(struct btrfs_work *work)
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


