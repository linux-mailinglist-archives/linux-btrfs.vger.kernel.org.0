Return-Path: <linux-btrfs+bounces-12252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50817A5EA84
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 05:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686C97AC0CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Mar 2025 04:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907A13D521;
	Thu, 13 Mar 2025 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F6FGqyP0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="F6FGqyP0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07FF15E90
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839692; cv=none; b=LPBE9GjzIlUHvYrDspwaBodyg0oBg7JTSj2pd0OKoaKxT9B1Y25KKPoSsm+TRl/bLRbYkFPBKqi+u3Gj8Z21jgYoy4Tj7dyM2nuZ8YKq7hi+LZn1HwyzRSzfyjRyIK/6ACi+aBytjH/CH3Ckt+3NThCrQZQBTnxrRsN8yKRbDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839692; c=relaxed/simple;
	bh=GEN3iJkWeDvE/KSQxPiVSF1LRJQphDfycxGUh2NOZUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfHZHZXl+5BZ5YbHeKDAEtQcQrMyDBnvXDI9Xy/FmGLtB+qzaUhA6VnjkwW0SQ8loE60OeomRHPNi4NNyUOuDTKNsKNziMcnftYZqyI92qQAYoO6oQ70Z8EyNexNpjvIRkcBfxTYscMJzWa6NVrJdE4oY1eH7draSF+cyUaq9b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F6FGqyP0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=F6FGqyP0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B47821F449
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=F6FGqyP0ckqsQnBOMu2fo4SI2uATNHkU13bK8fT5RKOiyqNLP8AdO0AqKoaZo+4PoW4b1t
	Dus+Mw0fjSP8TnhsbsoyBvt2sVpddfVtqU+r2cNArKXRs4+LwIRT+fonJ1wEKUNzgwo5qQ
	hbVLfXi6u86K0qDm2jK6NJWSXfGEFac=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741839676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjRDK+DEmvOJ6nnT06bW82e6DneaDQkEOgvkFEgxBIA=;
	b=F6FGqyP0ckqsQnBOMu2fo4SI2uATNHkU13bK8fT5RKOiyqNLP8AdO0AqKoaZo+4PoW4b1t
	Dus+Mw0fjSP8TnhsbsoyBvt2sVpddfVtqU+r2cNArKXRs4+LwIRT+fonJ1wEKUNzgwo5qQ
	hbVLfXi6u86K0qDm2jK6NJWSXfGEFac=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE5813797
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GK8HJztd0mcrYQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Mar 2025 04:21:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: zlib: prepare copy_data_into_buffer() for larger data folios
Date: Thu, 13 Mar 2025 14:50:49 +1030
Message-ID: <7704f5f57ab91f295ccb6f8427455789d59721c5.1741839616.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741839616.git.wqu@suse.com>
References: <cover.1741839616.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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

The function itself is already taking larger folios into consideration,
just remove the ASSERT(!folio_test_large()) line.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 3a7d136f57b4..b32aa05b288e 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -120,8 +120,6 @@ static int copy_data_into_buffer(struct address_space *mapping,
 		ret = btrfs_compress_filemap_get_folio(mapping, cur, &folio);
 		if (ret < 0)
 			return ret;
-		/* No larger folio support yet. */
-		ASSERT(!folio_test_large(folio));
 
 		offset = offset_in_folio(folio, cur);
 		copy_length = min(folio_size(folio) - offset,
-- 
2.48.1


