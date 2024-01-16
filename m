Return-Path: <linux-btrfs+bounces-1461-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DE82E840
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 04:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608091F239FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA17779EC;
	Tue, 16 Jan 2024 03:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tWFlX+ml";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tWFlX+ml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A296FD0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0C1D21B5D
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZq9Ydy4cUMLjE91rFzLCQ8WgMXRGIQfSvcUhxBrvdc=;
	b=tWFlX+mlN9mSsasiN+tSaTLl1pKvZ8QROTP9MaMXE6llCDBYo25SOz3EGdX2p2firWLdHZ
	5vHwGhi1CvL0XPKFENGQAZMpmhRqpx0YIKGZ8IHQFb6uYI4fGGqvVt9rDYVqAQ6QmzGL++
	YwlXElE8ZDf3cDidSZ0UYZwNwgdeR/I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZq9Ydy4cUMLjE91rFzLCQ8WgMXRGIQfSvcUhxBrvdc=;
	b=tWFlX+mlN9mSsasiN+tSaTLl1pKvZ8QROTP9MaMXE6llCDBYo25SOz3EGdX2p2firWLdHZ
	5vHwGhi1CvL0XPKFENGQAZMpmhRqpx0YIKGZ8IHQFb6uYI4fGGqvVt9rDYVqAQ6QmzGL++
	YwlXElE8ZDf3cDidSZ0UYZwNwgdeR/I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF034132FA
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aABFIKL4pWUKOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: convert: make sure the length of data chunks are also stripe aligned
Date: Tue, 16 Jan 2024 14:01:24 +1030
Message-ID: <6ce46f8501e65e023b8860f44faf822e3448adb8.1705375819.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705375819.git.wqu@suse.com>
References: <cover.1705375819.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.71%]
X-Spam-Flag: NO

Although scrub code is updated to handle the unaligned chunk length,
there is also no harm if we can alloc data chunk with both start and
length aligned.

This patch would handle this by rounding up the end bytenr when
allocating data chunks for the conversion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/convert/main.c b/convert/main.c
index c9e50c036f92..77b7c0516ae5 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -984,7 +984,8 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 			u64 cur_backup = cur;
 
 			len = min(max_chunk_size,
-				  cache->start + cache->size - cur);
+				  round_up(cache->start + cache->size,
+					   BTRFS_STRIPE_LEN) - cur);
 			ret = btrfs_alloc_data_chunk(trans, fs_info, &cur_backup, len);
 			if (ret < 0)
 				break;
-- 
2.43.0


