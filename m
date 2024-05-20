Return-Path: <linux-btrfs+bounces-5121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15028CA2EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B421281383
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40F139562;
	Mon, 20 May 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BRWQy/mP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BRWQy/mP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16B1E4BE
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234742; cv=none; b=dxrapLiracDeFsQ7vpfpyNxayiGAfZmdAcYejXWrFo0bvYIpx41WkmaWsbLm9I4bUWiI4+GmrCuoYnODTCQn5iY+m2PfjppJ8mo7aHmPur+1DD+GEobqj75g8q7mbq8SDnw6Pfv0/8bwgHsQryhLp/x7gjCh9xbSd++/WEdi+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234742; c=relaxed/simple;
	bh=BHqHM6O583ntJDViuLapf2uAL5IZYl2xQNXyRqYybdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPVF0670S6cb0sAJ7NMBNd/mI61VbqA1FDB7prXLUerch32HHtiCT00/JLv++Cv8nEj9ZGQqYf8j3KJLi/llEphORNgbNc5G+LElauCjheEL7fZYHh+LzGtvlqWCgYMN3l+LU1/3XSI64ypNLMbOk+falfmbQBmoOlbbMtAy5RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BRWQy/mP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BRWQy/mP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4578333EBC;
	Mon, 20 May 2024 19:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jmwnkLrpgjaU/INnBheCGd0ypxeuoa31ATUkpqDII=;
	b=BRWQy/mPViKaul2l/W6vxOmUnU0PPfDq9EwbEf/a1jQ1fEQd6h550oY52u8io3cP2PHuVy
	CBWYJ+bUcfg8kfqo+zluHsSPV1Ig4FL1FKxQQBGKK3K9N2bqa56OOT8GS0XC7iEMvBOCZn
	wvjaz8ELgwpUOI/4AZGGGLRrS6UlQ8o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="BRWQy/mP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0jmwnkLrpgjaU/INnBheCGd0ypxeuoa31ATUkpqDII=;
	b=BRWQy/mPViKaul2l/W6vxOmUnU0PPfDq9EwbEf/a1jQ1fEQd6h550oY52u8io3cP2PHuVy
	CBWYJ+bUcfg8kfqo+zluHsSPV1Ig4FL1FKxQQBGKK3K9N2bqa56OOT8GS0XC7iEMvBOCZn
	wvjaz8ELgwpUOI/4AZGGGLRrS6UlQ8o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EBE213A6B;
	Mon, 20 May 2024 19:52:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V3VMD/KpS2YZQwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: remove duplicate name variable declarations
Date: Mon, 20 May 2024 21:52:18 +0200
Message-ID: <092a8b338d6d5560b1cef1291c6e779a27e17366.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
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
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4578333EBC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

When running 'make W=2' there are a few reports where a variable of the
same name is declared in a nested block. In all the cases we can use the
one declared in the parent block, no problematic cases were found.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 4 +---
 fs/btrfs/inode.c     | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 597387e9f040..2d773c1cbaa7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3507,7 +3507,6 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio = new->folios[i];
-		int ret;
 
 		ret = attach_extent_buffer_folio(new, folio, NULL);
 		if (ret < 0) {
@@ -4587,8 +4586,7 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
 		return;
 
 	if (fs_info->nodesize < PAGE_SIZE) {
-		struct folio *folio = eb->folios[0];
-
+		folio = eb->folios[0];
 		ASSERT(i == 0);
 		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
 							 eb->start, eb->len)))
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3cf32bc721d2..87278d2f8447 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1617,10 +1617,8 @@ static noinline void submit_compressed_extents(struct btrfs_work *work, bool do_
 	u64 alloc_hint = 0;
 
 	if (do_free) {
-		struct async_chunk *async_chunk;
 		struct async_cow *async_cow;
 
-		async_chunk = container_of(work, struct async_chunk, work);
 		btrfs_add_delayed_iput(async_chunk->inode);
 		if (async_chunk->blkcg_css)
 			css_put(async_chunk->blkcg_css);
-- 
2.45.0


