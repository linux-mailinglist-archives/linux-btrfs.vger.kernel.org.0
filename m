Return-Path: <linux-btrfs+bounces-18389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2EBC184FF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 06:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252F43A75F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 05:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4958630CD8E;
	Wed, 29 Oct 2025 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fqgn4+xD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fqgn4+xD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE422FE053
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716092; cv=none; b=De2U3vGGGlTswk0e90hPHpwYSVdTAdajncm9dtXqfxUm/LxxSI7gJq61zDpVgYfhbJ9IDtUeRg6Kv81rT0oUM702Mz5V4WE6DF664ZjB19dhhbiOhpfugT4dj46PtitHH1VpllcDmKc5xpCQN0Dg84/fUHkLAH9RhujAaST+M6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716092; c=relaxed/simple;
	bh=wW6bGYVA22wDV42jAbw8ql8zWEOiMFaBfOS3kW04Fg4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbhLGCGlmhG8UNtNTbA4gaAZeCZ89EFrUGEKQuPuNBQGYBNfov24PcXzmLbJerTEBYQ9a0xaL/Y8Pma9f0xqkiHYLmVs44xA3a4oSg22Y72x5id9tq0+v2zCPnMYwZJnApGgK0GIeezI3tit5tPwG260sDAtctDX+yXnSIhg24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fqgn4+xD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fqgn4+xD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1AE321C75
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBEyj0jlFJyPlCalqIFt8IM7eGxLD6Cq+7ilwaYHoU=;
	b=Fqgn4+xDZ2nxl3S16ZgpatY6Y/bBPPyMWwWMTeikxcHThcuYtTyBFWGXPPwxbmBiBBRjo0
	beK4s6O1IuSOx8h+H8v/PilT4cOT4nFac7ywkgDS8AXVW8AJ9bVlG+Ofug3ayhyoMR1Wzq
	quaCQcDUnvRX6Csg3fu0Vc+0NONmAvw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1761716077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBEyj0jlFJyPlCalqIFt8IM7eGxLD6Cq+7ilwaYHoU=;
	b=Fqgn4+xDZ2nxl3S16ZgpatY6Y/bBPPyMWwWMTeikxcHThcuYtTyBFWGXPPwxbmBiBBRjo0
	beK4s6O1IuSOx8h+H8v/PilT4cOT4nFac7ywkgDS8AXVW8AJ9bVlG+Ofug3ayhyoMR1Wzq
	quaCQcDUnvRX6Csg3fu0Vc+0NONmAvw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7FB513886
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CKPKJWynAWlZHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 05:34:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs: replace BTRFS_MAX_BIO_SECTORS with BIO_MAX_VECS
Date: Wed, 29 Oct 2025 16:04:11 +1030
Message-ID: <e21fa23101139546c852659510353da73cf56d36.1761715649.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761715649.git.wqu@suse.com>
References: <cover.1761715649.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

It's impossible to have a btrfs bio with more than BIO_MAX_VECS vectors
anyway.

And there is only one location utilizing that macro, just replace it
with BIO_MAX_VECS.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.h       | 7 -------
 fs/btrfs/direct-io.c | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 00883aea55d7..3cc0fe23898f 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -18,13 +18,6 @@ struct btrfs_inode;
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
-/*
- * Maximum number of sectors for a single bio to limit the size of the
- * checksum array.  This matches the number of bio_vecs per bio and thus the
- * I/O size for buffered I/O.
- */
-#define BTRFS_MAX_BIO_SECTORS		(256)
-
 typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
 /*
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 802d4dbe5b38..db0191567b8d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -385,7 +385,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to allocate a contiguous array for the checksums.
 	 */
 	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_SECTORS);
+		len = min_t(u64, len, fs_info->sectorsize * BIO_MAX_VECS);
 
 	lockstart = start;
 	lockend = start + len - 1;
-- 
2.51.0


