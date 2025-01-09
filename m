Return-Path: <linux-btrfs+bounces-10827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8F0A0730D
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62197188AA7B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4458216E11;
	Thu,  9 Jan 2025 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uv9gXxK3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uv9gXxK3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24285215779
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418271; cv=none; b=ZlvzjhUuKnTDjRcMDHBiVqgJ6UNuZCnUaiLl+8HXOhVll6ZJpx3jMCFQRqaZ4RhsU4w45mSdh+JkwzErVr9ziMGuHwF7mH4IPcArfVVVutTdglEigBuAk33CIjTCmlxPop6OC6fN8G//44qaPxFkvK2+y+bI4XbtJFNRO2TsTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418271; c=relaxed/simple;
	bh=MA+bSa88SWjqUNO1ft61i3P7HC4XV7B8TKrOnt2ntvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlpUFW/mCovWMCc3QoLl2SbkXe+SLD7QfIyRIpljtmi1yxL+OXwR381T9ZU96FeXZgc+Yd35E8meV0QD37/1wwspNvIhT3XdXUdASU4cnq1o6jtq1I/zt/uOMdYrKx1r9QZK6c0pTWtpfyzrK1O+z6opvcDdEOGNRiKi6JQ+a8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uv9gXxK3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uv9gXxK3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C35D21102;
	Thu,  9 Jan 2025 10:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hs5AxFCAxzy/2RCrfGgbgURUv8rEcvI92nC2zI+ekM=;
	b=uv9gXxK34WzGnUwON3FzpCgJm77LqpUUMLVTJIqM/6TIvcZfvPMlSoa1XHs3Q13Ue2zl5e
	N7OxfLaXGv+7ALyJ2+Y+aBjAF0Oy+1amUU8HUhoWpL41whnPqcJAnmJFxtgWDT31GSGkRj
	sFEzNh/SnMpLkQDrACVUC0OtYEsoOF4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9hs5AxFCAxzy/2RCrfGgbgURUv8rEcvI92nC2zI+ekM=;
	b=uv9gXxK34WzGnUwON3FzpCgJm77LqpUUMLVTJIqM/6TIvcZfvPMlSoa1XHs3Q13Ue2zl5e
	N7OxfLaXGv+7ALyJ2+Y+aBjAF0Oy+1amUU8HUhoWpL41whnPqcJAnmJFxtgWDT31GSGkRj
	sFEzNh/SnMpLkQDrACVUC0OtYEsoOF4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61B68139AB;
	Thu,  9 Jan 2025 10:24:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DDXYF9ujf2dJEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/18] btrfs: rename btrfs_release_extent_buffer_pages() to mention folios
Date: Thu,  9 Jan 2025 11:24:27 +0100
Message-ID: <e3a4660b7abe7d40fb1f520b37cc9dea58f344b6.1736418116.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Continue page to folio updates, sync what the function does with it's
name.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a00a46a681b..2815972f69ec 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2561,8 +2561,8 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	spin_unlock(&folio->mapping->i_private_lock);
 }
 
-/* Release all pages attached to the extent buffer */
-static void btrfs_release_extent_buffer_pages(const struct extent_buffer *eb)
+/* Release all folios attached to the extent buffer */
+static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
 {
 	ASSERT(!extent_buffer_under_io(eb));
 
@@ -2584,7 +2584,7 @@ static void btrfs_release_extent_buffer_pages(const struct extent_buffer *eb)
  */
 static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
-	btrfs_release_extent_buffer_pages(eb);
+	btrfs_release_extent_buffer_folios(eb);
 	btrfs_leak_debug_del_eb(eb);
 	kmem_cache_free(extent_buffer_cache, eb);
 }
@@ -3200,8 +3200,8 @@ static int release_extent_buffer(struct extent_buffer *eb)
 		}
 
 		btrfs_leak_debug_del_eb(eb);
-		/* Should be safe to release our pages at this point */
-		btrfs_release_extent_buffer_pages(eb);
+		/* Should be safe to release folios at this point. */
+		btrfs_release_extent_buffer_folios(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
 			kmem_cache_free(extent_buffer_cache, eb);
-- 
2.47.1


