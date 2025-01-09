Return-Path: <linux-btrfs+bounces-10824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C55A0731B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 583F23A2881
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD06216E02;
	Thu,  9 Jan 2025 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kxfWBygO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kxfWBygO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0266B215779
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418263; cv=none; b=WTWy4pRnGDMWw+6UItwFPVIBykTscdYnngFVcURElz421+n2/UhdMjHr2tuO4Y+3MDqIrqJP4txb/kHBdvxAzm1rGGO1cLerwnINbMxSZB+21UE6613Xj26tcMzk+YvHwArAZK4e5viXfBZQZu1UodKXTrvrG8Kx9MDVb5jATu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418263; c=relaxed/simple;
	bh=yUwk2er14QgmeVNSKbhYv0PDvVn3eadWyY4ZpRApqes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtC3WodyIr8UK/4PqWAYPIvlSZTKpNo93k9578ubXunsijrBXAsBSd3+ItzZWssGdb2SEYWn35zaphmYhyzkzuNCE53S4d9FROoxkw5mw9X/6gsCZS1gbzGJ1oj3R3vPK8JYfdrYstUPSEHZcNV8m6V+eeKYxcBX9N/nP9y0a4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kxfWBygO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kxfWBygO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC561F385;
	Thu,  9 Jan 2025 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIu1/UHHcDutifia47Scin1PY9pK52fz2bBlp31exFM=;
	b=kxfWBygOawcPDDYOWCsOBtGC8OI2KeNQnMsmRM91fCCjSqC7OAjsrjnHekYf1KbAM13wEk
	btoJ5F/NyNd/pBxBF8rEmXGb7xDmTG0zt+chWC1DcC3OrpglBUKvNzK6lgnj26jGCP1i03
	UqNLUtBjeidwh8MmL5g3t87H2LTQ85M=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIu1/UHHcDutifia47Scin1PY9pK52fz2bBlp31exFM=;
	b=kxfWBygOawcPDDYOWCsOBtGC8OI2KeNQnMsmRM91fCCjSqC7OAjsrjnHekYf1KbAM13wEk
	btoJ5F/NyNd/pBxBF8rEmXGb7xDmTG0zt+chWC1DcC3OrpglBUKvNzK6lgnj26jGCP1i03
	UqNLUtBjeidwh8MmL5g3t87H2LTQ85M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36980139AB;
	Thu,  9 Jan 2025 10:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ww1SDdSjf2c6EQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/18] btrfs: make wait_on_extent_buffer_writeback() static inline
Date: Thu,  9 Jan 2025 11:24:19 +0100
Message-ID: <363561b208d610b0a2989bb5b3435676b8513848.1736418116.git.dsterba@suse.com>
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
X-Spam-Score: -2.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The simple helper can be inlined, no need for the separate function.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 6 ------
 fs/btrfs/extent_io.h | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index eca28c99bbc8..4f71877f9b76 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1518,12 +1518,6 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	return ret;
 }
 
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
-{
-	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
-		       TASK_UNINTERRUPTIBLE);
-}
-
 /*
  * Lock extent buffer status and pages for writeback.
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index d14bda928e7b..986f15022fef 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -266,7 +266,12 @@ void free_extent_buffer_stale(struct extent_buffer *eb);
 #define WAIT_PAGE_LOCK	2
 int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			     const struct btrfs_tree_parent_check *parent_check);
-void wait_on_extent_buffer_writeback(struct extent_buffer *eb);
+static inline void wait_on_extent_buffer_writeback(struct extent_buffer *eb)
+{
+	wait_on_bit_io(&eb->bflags, EXTENT_BUFFER_WRITEBACK,
+		       TASK_UNINTERRUPTIBLE);
+}
+
 void btrfs_readahead_tree_block(struct btrfs_fs_info *fs_info,
 				u64 bytenr, u64 owner_root, u64 gen, int level);
 void btrfs_readahead_node_child(struct extent_buffer *node, int slot);
-- 
2.47.1


