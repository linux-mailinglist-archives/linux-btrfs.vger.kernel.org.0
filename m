Return-Path: <linux-btrfs+bounces-11838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DF5A45804
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064EA171C88
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6AB226CF9;
	Wed, 26 Feb 2025 08:22:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1B224237
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 08:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558153; cv=none; b=hrrzrBbmVi4R/fNdBc3PUL0deaFPF720pwnfTz3aZOrQ85fdf8g+BYwW/oH2KhTbjLYfGzxlvcfmoqIkVu6aw2p0AfCwpGKz4+VYs2MxvEoPlFMMCWkA1W53wPIw6gYdL0x5jJtg81ZiADV1dffDwdPqrlcQxmOq5j/oQ4xmbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558153; c=relaxed/simple;
	bh=os4Dj/i0sqg+5wvyrwYO3TkYVCmX9SKMptQ+djJhnEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+pbu1P9FLUJ10i3NC52sCBEiORv+teKGxIp8GlKsNRt9ss1xQIVhUh3w/MwK1OxXN/MWLQF2vCzGVFi8Xslx74Pr+tsTHXUiIGQHmKqqJXOVmENnC2/pkGDuvzQO8H2yLAlQhX//BV3uyvRjkohKTfc/6Z7K5DnugiSfme94Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 27EDF1F387;
	Wed, 26 Feb 2025 08:22:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 162AB1377F;
	Wed, 26 Feb 2025 08:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rxZhBUbPvmdwRAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 08:22:30 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: don't pass nodesize to __alloc_extent_buffer()
Date: Wed, 26 Feb 2025 09:22:25 +0100
Message-ID: <eef5086760762321e6f93ce9e21ec47c15617b39.1740558001.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740558001.git.dsterba@suse.com>
References: <cover.1740558001.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 27EDF1F387
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

All callers pass a valid fs_info so we can read the nodesize from that
instead of passing it as parameter.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c             | 20 +++++++++-----------
 fs/btrfs/extent_io.h             |  2 +-
 fs/btrfs/tests/extent-io-tests.c |  6 +++---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..6ba332dcb7dc 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2652,15 +2652,14 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
-static struct extent_buffer *
-__alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
-		      unsigned long len)
+static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info,
+						   u64 start)
 {
 	struct extent_buffer *eb = NULL;
 
 	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
 	eb->start = start;
-	eb->len = len;
+	eb->len = fs_info->nodesize;
 	eb->fs_info = fs_info;
 	init_rwsem(&eb->lock);
 
@@ -2669,7 +2668,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	spin_lock_init(&eb->refs_lock);
 	atomic_set(&eb->refs, 1);
 
-	ASSERT(len <= BTRFS_MAX_METADATA_BLOCKSIZE);
+	ASSERT(eb->len <= BTRFS_MAX_METADATA_BLOCKSIZE);
 
 	return eb;
 }
@@ -2680,7 +2679,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	int num_folios = num_extent_folios(src);
 	int ret;
 
-	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
+	new = __alloc_extent_buffer(src->fs_info, src->start);
 	if (new == NULL)
 		return NULL;
 
@@ -2714,13 +2713,13 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 }
 
 struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start, unsigned long len)
+						  u64 start)
 {
 	struct extent_buffer *eb;
 	int num_folios = 0;
 	int ret;
 
-	eb = __alloc_extent_buffer(fs_info, start, len);
+	eb = __alloc_extent_buffer(fs_info, start);
 	if (!eb)
 		return NULL;
 
@@ -2754,7 +2753,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 start)
 {
-	return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
+	return __alloc_dummy_extent_buffer(fs_info, start);
 }
 
 static void check_buffer_tree_ref(struct extent_buffer *eb)
@@ -3031,7 +3030,6 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
-	unsigned long len = fs_info->nodesize;
 	int num_folios;
 	int attached = 0;
 	struct extent_buffer *eb;
@@ -3060,7 +3058,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	if (eb)
 		return eb;
 
-	eb = __alloc_extent_buffer(fs_info, start, len);
+	eb = __alloc_extent_buffer(fs_info, start);
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 6c5328bfabc2..3413a34585c8 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -253,7 +253,7 @@ void clear_folio_extent_mapped(struct folio *folio);
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
 struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start, unsigned long len);
+						  u64 start);
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 start);
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 0a2dbfaaf49e..5847cbdc1e90 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -525,7 +525,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	eb = __alloc_dummy_extent_buffer(fs_info, 0, nodesize);
+	eb = __alloc_dummy_extent_buffer(fs_info, 0);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
@@ -542,7 +542,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 	 * Test again for case where the tree block is sectorsize aligned but
 	 * not nodesize aligned.
 	 */
-	eb = __alloc_dummy_extent_buffer(fs_info, sectorsize, nodesize);
+	eb = __alloc_dummy_extent_buffer(fs_info, sectorsize);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
@@ -730,7 +730,7 @@ static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	eb = __alloc_dummy_extent_buffer(fs_info, SZ_1M, nodesize);
+	eb = __alloc_dummy_extent_buffer(fs_info, SZ_1M);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
 		ret = -ENOMEM;
-- 
2.47.1


