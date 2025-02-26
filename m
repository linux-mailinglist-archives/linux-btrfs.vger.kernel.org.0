Return-Path: <linux-btrfs+bounces-11839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A881BA45805
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297AB175CAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 08:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE97E226D1C;
	Wed, 26 Feb 2025 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Iq6wP4Xz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Iq6wP4Xz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454C1226CF4
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558156; cv=none; b=DXndoIClwIG96J61CbtU/dGQG+ufMwYTHYt0FWrfnnLQQD/gyabyFJZZclIXMWKU5ixMvl5PKmdOp4w8lMvVXTVVhFweToMUc8Wdm7+R+IbvnooA4UuK6vfALXMZHHddGrhFSEOeSKuKKRvhcFYbUmlzj+mPfkR5My0GNGSdmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558156; c=relaxed/simple;
	bh=sGLMOC7SNnJTaRE44GLyWua2cmA7LC9qDkkzUGLrYLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ7b1culubdKAB6QrL4u+s7YUvrunWRO4w4Izr954tPmR+Nef+jzXaTpQLMQLnBAXVbT6H9Pz7O5Q/1M1Zp7NgytAek8un1OEOHUoBX9hVSEcRMzMsMeQK/7IzZBLUjM5cxymDFdM2FHnwZsWge+qczeclR4BJ7cb3MMy1Skh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Iq6wP4Xz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Iq6wP4Xz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7714121193;
	Wed, 26 Feb 2025 08:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740558152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ehv//LtdfQrnLvoXC9yMfdZgyZN0QDUbf8DZV6yL9jM=;
	b=Iq6wP4XzRh+ng6FjFN/9alUHVYQ+zIvE+FFY+gyuU8slBdNYAOGHBN7iETh3qwvTRnWbc6
	6QwXXAS33DxtmU6aF4Uy0T2VPbAoZETg8+SxhDXsVa/lBfL+UvGRuARGaRkUfNKZTX6wgr
	6M78AezX8BtePg9M0iskntapSMwtj1s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740558152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ehv//LtdfQrnLvoXC9yMfdZgyZN0QDUbf8DZV6yL9jM=;
	b=Iq6wP4XzRh+ng6FjFN/9alUHVYQ+zIvE+FFY+gyuU8slBdNYAOGHBN7iETh3qwvTRnWbc6
	6QwXXAS33DxtmU6aF4Uy0T2VPbAoZETg8+SxhDXsVa/lBfL+UvGRuARGaRkUfNKZTX6wgr
	6M78AezX8BtePg9M0iskntapSMwtj1s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7128B1377F;
	Wed, 26 Feb 2025 08:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oQ+hG0jPvmd+RAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 08:22:32 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: merge alloc_dummy_extent_buffer() helpers
Date: Wed, 26 Feb 2025 09:22:32 +0100
Message-ID: <336c4f1ed9a5ead704b334474c7f8b3ae66155bf.1740558001.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

After previous patch removing nodesize from parameters,
__alloc_dummy_extent_buffer() and alloc_dummy_extent_buffer() are
identical so we can drop one.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c             | 10 ++--------
 fs/btrfs/extent_io.h             |  2 --
 fs/btrfs/tests/extent-io-tests.c |  6 +++---
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6ba332dcb7dc..9cefe6030335 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2712,8 +2712,8 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 	return new;
 }
 
-struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start)
+struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
+						u64 start)
 {
 	struct extent_buffer *eb;
 	int num_folios = 0;
@@ -2750,12 +2750,6 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	return NULL;
 }
 
-struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						u64 start)
-{
-	return __alloc_dummy_extent_buffer(fs_info, start);
-}
-
 static void check_buffer_tree_ref(struct extent_buffer *eb)
 {
 	int refs;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 3413a34585c8..ae0c04019a7e 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -252,8 +252,6 @@ void clear_folio_extent_mapped(struct folio *folio);
 
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level);
-struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
-						  u64 start);
 struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						u64 start);
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src);
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 5847cbdc1e90..74aca7180a5a 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -525,7 +525,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	eb = __alloc_dummy_extent_buffer(fs_info, 0);
+	eb = alloc_dummy_extent_buffer(fs_info, 0);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
@@ -542,7 +542,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 	 * Test again for case where the tree block is sectorsize aligned but
 	 * not nodesize aligned.
 	 */
-	eb = __alloc_dummy_extent_buffer(fs_info, sectorsize);
+	eb = alloc_dummy_extent_buffer(fs_info, sectorsize);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
@@ -730,7 +730,7 @@ static int test_eb_mem_ops(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	eb = __alloc_dummy_extent_buffer(fs_info, SZ_1M);
+	eb = alloc_dummy_extent_buffer(fs_info, SZ_1M);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_EXTENT_BUFFER);
 		ret = -ENOMEM;
-- 
2.47.1


