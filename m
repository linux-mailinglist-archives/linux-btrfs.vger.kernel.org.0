Return-Path: <linux-btrfs+bounces-10826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF4A0730A
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5730E7A056C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BFA216E0A;
	Thu,  9 Jan 2025 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pnlsK3nO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pnlsK3nO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF5215F40
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418270; cv=none; b=Pr7rCPX0eYMDxj/+81rbVqYOdcZPdjpFcwbmEmeEsxBYuCIxQ8v3aAebW+2JVjeFDn14T6B41elhXu/edOqH8R2q5zMkCswaOgVKD/IWJ8pA1Usta4KKBD6LxgQQ0XFbRIQlhxQ1ip28Cd/skzWI8U8D/0UieJzQ0bZMLdi9FLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418270; c=relaxed/simple;
	bh=5DEsOevAo4IwBe7bDvrzU6nDgussPjKMtfrAUaqLkqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DI//yE+a+Hxcqi91mU3DHHaIENpGlVR9hajSeEStFVRSfYjsg5XErN0lj68qii6nz7MT79r7aUk0XFrroNkJqdvTipZE3ta2LM/HTGPxy1PDF+mWAQ9aglak5MmntgGBiAemzmwP8JT6Wq9IsqadF6DMrW1imA5UW1dsIXb/yEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pnlsK3nO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pnlsK3nO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A03221101;
	Thu,  9 Jan 2025 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rueJaToJMe0EX+3gNuhpo9l7knC2yFj3yosmes3AOSA=;
	b=pnlsK3nOxVoRXWCf/D1XTpfqNT+eBLrPMJ9uEcmHrMDYyIt59hzrp7iwSTTfGR6LJfiJ9G
	3Cc6mx+QpyZSSjEXb3QlGxzpclpcfCXiDh1Lt8qY4PAA3IH7HqOHnBdpMIxdC111MASAJk
	xXcrrzp4lXiRl/93cBMjNsIMlOIjAD8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736418265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rueJaToJMe0EX+3gNuhpo9l7knC2yFj3yosmes3AOSA=;
	b=pnlsK3nOxVoRXWCf/D1XTpfqNT+eBLrPMJ9uEcmHrMDYyIt59hzrp7iwSTTfGR6LJfiJ9G
	3Cc6mx+QpyZSSjEXb3QlGxzpclpcfCXiDh1Lt8qY4PAA3IH7HqOHnBdpMIxdC111MASAJk
	xXcrrzp4lXiRl/93cBMjNsIMlOIjAD8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F36139AB;
	Thu,  9 Jan 2025 10:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hd31ANmjf2dFEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 09 Jan 2025 10:24:25 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 10/18] btrfs: open code __free_extent_buffer()
Date: Thu,  9 Jan 2025 11:24:24 +0100
Message-ID: <0e02a7fb8c49ad91ed019d0b820f49a63762b153.1736418116.git.dsterba@suse.com>
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

Using the kmem cache freeing directly is clear enough, we don't need to
wrap it.  All the users are in the same file.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6466f74bd2bb..1a00a46a681b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2481,11 +2481,6 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 	return try_release_extent_state(io_tree, folio);
 }
 
-static void __free_extent_buffer(struct extent_buffer *eb)
-{
-	kmem_cache_free(extent_buffer_cache, eb);
-}
-
 static int extent_buffer_under_io(const struct extent_buffer *eb)
 {
 	return (test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
@@ -2591,7 +2586,7 @@ static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
 	btrfs_release_extent_buffer_pages(eb);
 	btrfs_leak_debug_del_eb(eb);
-	__free_extent_buffer(eb);
+	kmem_cache_free(extent_buffer_cache, eb);
 }
 
 static struct extent_buffer *
@@ -2689,7 +2684,7 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 			folio_put(eb->folios[i]);
 		}
 	}
-	__free_extent_buffer(eb);
+	kmem_cache_free(extent_buffer_cache, eb);
 	return NULL;
 }
 
@@ -3181,7 +3176,7 @@ static inline void btrfs_release_extent_buffer_rcu(struct rcu_head *head)
 	struct extent_buffer *eb =
 			container_of(head, struct extent_buffer, rcu_head);
 
-	__free_extent_buffer(eb);
+	kmem_cache_free(extent_buffer_cache, eb);
 }
 
 static int release_extent_buffer(struct extent_buffer *eb)
@@ -3209,7 +3204,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 		btrfs_release_extent_buffer_pages(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 		if (unlikely(test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags))) {
-			__free_extent_buffer(eb);
+			kmem_cache_free(extent_buffer_cache, eb);
 			return 1;
 		}
 #endif
-- 
2.47.1


