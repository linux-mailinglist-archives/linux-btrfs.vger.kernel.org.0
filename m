Return-Path: <linux-btrfs+bounces-13175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0F4A94212
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 09:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB6619E2683
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF71A2860;
	Sat, 19 Apr 2025 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ca/pQX5X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ca/pQX5X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0D35893
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745047078; cv=none; b=udsCt2UDIrAC0T9NTsdEGwY7/zsusYfvNZTyi6h69wLU5Qz2VWo7HY7R5Q6BbbpCvVStTXoBe8B3x2BR5w6mxwCYFzwJGk2j53Ju8LEWlDtKz8Mim42gYPSCSLm3a04Cx10R1Tqvw4drhV5SYLm3GQl7E+OZJ9nTq9EQ2y+8CJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745047078; c=relaxed/simple;
	bh=qt7jhI6aOqvRXvvKCH3tyfe0kyHCZ4IIWsZqb3J6aOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz8Y3xo78icKELqHtq1A34zq/u+ZizaGquvlJBcVgQlnmeMDb/MSQJyBGB31PJyayFEdSLespWXl14x/0WootUGyl9IgXGZJcalAezCgzenU5WYkt7/IgUrFjl++fbL7yXscQG3jFjmYvajbImTSwaFYmkzAZ/QtxzfJeAbvMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ca/pQX5X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ca/pQX5X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B0101F443;
	Sat, 19 Apr 2025 07:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpIXXs9jkmoQWKLVc9mxglGimt6DiYfx779I3e3eTng=;
	b=Ca/pQX5XbEQ2iiGpb4O+byWobmVvuP6sqDIDUHOCplYweUAXA4PvgRvt2+v2uys5YQiqVx
	f0BMqVOaIWq9BeJ5jN+SDPdSF/oS0yNLarnHliscqCK5oly2C52pAvUVUrakteTshKHX1A
	140szm41qdAeV0E9RGLN/QjvMeF/f50=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Ca/pQX5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745047071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TpIXXs9jkmoQWKLVc9mxglGimt6DiYfx779I3e3eTng=;
	b=Ca/pQX5XbEQ2iiGpb4O+byWobmVvuP6sqDIDUHOCplYweUAXA4PvgRvt2+v2uys5YQiqVx
	f0BMqVOaIWq9BeJ5jN+SDPdSF/oS0yNLarnHliscqCK5oly2C52pAvUVUrakteTshKHX1A
	140szm41qdAeV0E9RGLN/QjvMeF/f50=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3843713942;
	Sat, 19 Apr 2025 07:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SP8nOx1OA2jSSQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 19 Apr 2025 07:17:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 8/8] btrfs: use bvec_kmap_local in btrfs_decompress_buf2page
Date: Sat, 19 Apr 2025 16:47:15 +0930
Message-ID: <5230c0f2403080cca48b3734e8219ca386bb7d14.1745024799.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745024799.git.wqu@suse.com>
References: <cover.1745024799.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B0101F443
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:dkim,suse.com:mid,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

This removes the last direct poke into bvec internals in btrfs.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6911eaa6b408..1f8bc9e4acb6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1198,6 +1198,7 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		u32 copy_start;
 		/* Offset inside the full decompressed extent */
 		u32 bvec_offset;
+		void *kaddr;
 
 		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
 		/*
@@ -1220,10 +1221,12 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 		 * @buf + @buf_len.
 		 */
 		ASSERT(copy_start - decompressed < buf_len);
-		memcpy_to_page(bvec.bv_page, bvec.bv_offset,
-			       buf + copy_start - decompressed, copy_len);
-		cur_offset += copy_len;
 
+		kaddr = bvec_kmap_local(&bvec);
+		memcpy(kaddr, buf + copy_start - decompressed, copy_len);
+		kunmap_local(kaddr);
+
+		cur_offset += copy_len;
 		bio_advance(orig_bio, copy_len);
 		/* Finished the bio */
 		if (!orig_bio->bi_iter.bi_size)
-- 
2.49.0


