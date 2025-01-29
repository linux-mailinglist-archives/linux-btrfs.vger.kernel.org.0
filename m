Return-Path: <linux-btrfs+bounces-11128-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F61A2183F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F534188644D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BF19CC22;
	Wed, 29 Jan 2025 07:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aX91TxuM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aX91TxuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DC019A28D
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136278; cv=none; b=A8WUSC8+ZrTmQGB7DLCMaOI7wmmw1/OrB5IDEICSoIWoKMtiTeBg8gG0B5pPltXiZ9sGMhE5LNs3/QgAzoEl3E65CXtglUQSCBv/dFmzIZndtHzkAGNzldajQpRzoVZjdfybKoKTlXU/Qu272TRrcnpizd4lAbzHFl3d1Ik6NQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136278; c=relaxed/simple;
	bh=zHcJENGaHoTgYYwK5phbnUL2IAw/oDu4JnOqpe9fhJ4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxcB8lOuZOnO2sMVknm+klxoqdzpsU4vhWdpB0GgvzsEFR6OwHS9Z/GHAQhSOeXJdtFimfbnw9yokbLTtsgTk9bv1Yh1Tri3/7nRFGavejNAlBxAbd6gAyHc7eMtQpGkulxLUx9o4vLxI243htrgqC2t1s5yGQF6LYhCYZhezFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aX91TxuM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aX91TxuM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1077210F4
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ9U7L8w+Ea7ijI909NhRyxjTwgZiC4pdrjEXqQ+6ZE=;
	b=aX91TxuMChlt1PsONn7uwJTNDIKDGDmh+gze9kkk9KxWJfeb3upyDPFwh/KG/x/hx4X1gH
	guB7LZO7nK683KCDK3UZhKTOP+TUZKrr1FjdqmzJP7u/srAXEdPve6h9XUdyJnVCQXyYKf
	W/1eECUjadetu6RDoUDA/gi13PrgoIY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQ9U7L8w+Ea7ijI909NhRyxjTwgZiC4pdrjEXqQ+6ZE=;
	b=aX91TxuMChlt1PsONn7uwJTNDIKDGDmh+gze9kkk9KxWJfeb3upyDPFwh/KG/x/hx4X1gH
	guB7LZO7nK683KCDK3UZhKTOP+TUZKrr1FjdqmzJP7u/srAXEdPve6h9XUdyJnVCQXyYKf
	W/1eECUjadetu6RDoUDA/gi13PrgoIY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18B1B137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFi6MdDamWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: make subpage attach and detach to handle metadata properly
Date: Wed, 29 Jan 2025 18:07:18 +1030
Message-ID: <bf552fed1f5b9ecd3c14b30c7ffc59448a583b90.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently subpage attach/detach is not doing proper dummy extent buffer
subpage check, as btrfs_is_subpage() is not reliable for dummy extent
buffer folios.

Since we have a metadata specific check now, use that for
btrfs_attach_subpage() first.

Then enhance btrfs_detach_subpage() to accept a type parameter, so that
we can do extra checks for dummy extent buffers properly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  6 +++---
 fs/btrfs/subpage.c   | 15 ++++++++++++---
 fs/btrfs/subpage.h   |  3 ++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6b9fe7ea3ffb..5fb52e2f67bb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -889,7 +889,7 @@ void clear_folio_extent_mapped(struct folio *folio)
 
 	fs_info = folio_to_fs_info(folio);
 	if (btrfs_is_subpage(fs_info, folio->mapping))
-		return btrfs_detach_subpage(fs_info, folio);
+		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_detach_private(folio);
 }
@@ -2604,7 +2604,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * attached to one dummy eb, no sharing.
 	 */
 	if (!mapped) {
-		btrfs_detach_subpage(fs_info, folio);
+		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 		return;
 	}
 
@@ -2615,7 +2615,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 	 * page range and no unfinished IO.
 	 */
 	if (!folio_range_has_eb(folio))
-		btrfs_detach_subpage(fs_info, folio);
+		btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_METADATA);
 
 	spin_unlock(&folio->mapping->i_private_lock);
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5638715c3ee6..61163e3ca42f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -104,7 +104,11 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		ASSERT(folio_test_locked(folio));
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, folio->mapping) || folio_test_private(folio))
+	if (folio_test_private(folio))
+		return 0;
+	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
+		return 0;
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
 		return 0;
 
 	subpage = btrfs_alloc_subpage(fs_info, type);
@@ -115,12 +119,17 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio)
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio,
+			  enum btrfs_subpage_type type)
 {
 	struct btrfs_subpage *subpage;
 
 	/* Either not subpage, or the folio already has private attached. */
-	if (!btrfs_is_subpage(fs_info, folio->mapping) || !folio_test_private(folio))
+	if (!folio_test_private(folio))
+		return;
+	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
+		return;
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
 		return;
 
 	subpage = folio_detach_private(folio);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 8093baf69636..0046403774f2 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -98,7 +98,8 @@ static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type);
-void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio);
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio,
+			  enum btrfs_subpage_type type);
 
 /* Allocate additional data where page represents more than one sector */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-- 
2.48.1


