Return-Path: <linux-btrfs+bounces-12372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28886A67069
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 10:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3F1897AF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4B206F3E;
	Tue, 18 Mar 2025 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PJ4FIxhn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PJ4FIxhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501532045BF
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291711; cv=none; b=meHEIFONbrqe5RmA29r/Ps0rGmfiPCv+K97r880/GRrYTMGRpQixyNmMKIqJzm8v90APv4JKFukiTZK8+r9FdL9QT75Lf87Tht0v/nTcNJn5UEfZzbO/J8WV0TjhNJBEPdZekP8OuWbT9xQPP3Msb1TKHuSDBjagyjyPJheeYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291711; c=relaxed/simple;
	bh=dJGpA1Bq3w6eHpYpPf/GMUmD3Op7VvFGzqk47E3cz9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+O0fM6jDauKj1AALidSSFRF3YhnT3GuNt3Z1mIgZ8Zw2Ny3BZJcxf3yLnefcF180zjTvIxt/1J+tG+va5/4i+wmUBt4aqAnvwGrGLCieecsRGUYCvLA4CEnejaz2utZ7LzHMUFVCeLp3EkE4jnfhweJ7FB2vYTdAdqbg3GA3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PJ4FIxhn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PJ4FIxhn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D7CF21D02;
	Tue, 18 Mar 2025 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742291707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2to0HAdGiMzihgin3pJ2A8LakWQXvSfnOMLv0YvSiGw=;
	b=PJ4FIxhnvU3bXorSkoocpKrLhnLGQD4O1/BKgFPND/W+c8Von94SfEk04YoyV/tExtsgpo
	wj+jWgHx9He0aiAMT6gRm5tQNeT2UdX8pNceNuv/mVwcw5UCJWIdOXRDLbH9wa/8kakXrb
	aHHW/SnQPUV3rz6s7XC8tezt1pI71Gw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742291707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2to0HAdGiMzihgin3pJ2A8LakWQXvSfnOMLv0YvSiGw=;
	b=PJ4FIxhnvU3bXorSkoocpKrLhnLGQD4O1/BKgFPND/W+c8Von94SfEk04YoyV/tExtsgpo
	wj+jWgHx9He0aiAMT6gRm5tQNeT2UdX8pNceNuv/mVwcw5UCJWIdOXRDLbH9wa/8kakXrb
	aHHW/SnQPUV3rz6s7XC8tezt1pI71Gw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55A491379A;
	Tue, 18 Mar 2025 09:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2OxUFPtC2WdcKwAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 18 Mar 2025 09:55:07 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: remove EXTENT_BUFFER_IN_TREE flag
Date: Tue, 18 Mar 2025 10:54:38 +0100
Message-ID: <20250318095440.436685-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

This flag is set after inserting the eb to the buffer tree and cleared on
it's removal. But it does not bring any added value. Just kill it for good.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/extent_io.c | 18 ++++++------------
 fs/btrfs/extent_io.h |  1 -
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b168dc354f20b..864bdffaa1123 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3048,7 +3048,6 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 			goto again;
 	}
 	check_buffer_tree_ref(eb);
-	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
 
 	return eb;
 free_eb:
@@ -3368,7 +3367,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	/* add one reference for the tree */
 	check_buffer_tree_ref(eb);
-	set_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags);
 
 	/*
 	 * Now it's safe to unlock the pages because any calls to
@@ -3432,18 +3430,14 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 	WARN_ON(atomic_read(&eb->refs) == 0);
 	if (atomic_dec_and_test(&eb->refs)) {
-		if (test_and_clear_bit(EXTENT_BUFFER_IN_TREE, &eb->bflags)) {
-			struct btrfs_fs_info *fs_info = eb->fs_info;
+		struct btrfs_fs_info *fs_info = eb->fs_info;
 
-			spin_unlock(&eb->refs_lock);
+		spin_unlock(&eb->refs_lock);
 
-			spin_lock(&fs_info->buffer_lock);
-			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> fs_info->sectorsize_bits);
-			spin_unlock(&fs_info->buffer_lock);
-		} else {
-			spin_unlock(&eb->refs_lock);
-		}
+		spin_lock(&fs_info->buffer_lock);
+		radix_tree_delete_item(&fs_info->buffer_radix,
+				       eb->start >> fs_info->sectorsize_bits, eb);
+		spin_unlock(&fs_info->buffer_lock);
 
 		btrfs_leak_debug_del_eb(eb);
 		/* Should be safe to release folios at this point. */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2e261892c7bc7..9cfb1e8f9b42d 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -47,7 +47,6 @@ enum {
 	/* read IO error */
 	EXTENT_BUFFER_READ_ERR,
 	EXTENT_BUFFER_UNMAPPED,
-	EXTENT_BUFFER_IN_TREE,
 	/* write IO error */
 	EXTENT_BUFFER_WRITE_ERR,
 	/* Indicate the extent buffer is written zeroed out (for zoned) */
-- 
2.47.2


