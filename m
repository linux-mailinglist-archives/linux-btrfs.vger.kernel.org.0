Return-Path: <linux-btrfs+bounces-15973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F0B1FD3B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC42D1895AD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1D014AA9;
	Mon, 11 Aug 2025 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AFANzuLZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AFANzuLZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BEB644
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871255; cv=none; b=TqxrmzX+4JYHrUeZdcBtcqSp329edGGPMlNwl04zKEEuvejsFbo2ziUGJ/I7cavXp01UPwDimZrblTT7HMa/kejnDJzFjfmiWB4N23sMuahJL7LKSoeaqKH3hJekM9Tup4oyFNVOl/jAcN8O2RNnd/Lv4y2JKA4+kzoTEnelHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871255; c=relaxed/simple;
	bh=r1fUTYJp2dOVsAOZxEyLi9d32JQMdy3Q+++6oFWdLkg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S8A81t10fGqETvsVGAKOHP+V3JyukK8gf4SprnvH4E6czmrro/ewwwQ86gVz1N+REV8is9Ceza5cQ2I1Kl+KgMwP8Z4nLFxO+RKHlV1HWCOK6qZ8FGbutSwmgFqURfBzoQ0tGNmj+okXzsNFrXPXLntFFm8pb3XQ7npqPWa8MPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AFANzuLZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AFANzuLZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5201420B1B
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 00:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754871245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DKPGdNAcvMFVHHSUhyQCn5JJvwGda8jcXpPPFgfVvD8=;
	b=AFANzuLZpfLdzwK9rheStRfqj2bnHyRtTW+YHNyFtMq/FstvJ+Q6RhY89keeLQuS3u6oSj
	ACCgbVPV8qC1nmBuFvT+clwEEmCv5H7k/6KgZnP5oLEci3YJ4p2jPUeJOUc1jV5NQUeyZu
	cpFAh57If1JKIkBM0rhHcaNP0OXw/RY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754871245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DKPGdNAcvMFVHHSUhyQCn5JJvwGda8jcXpPPFgfVvD8=;
	b=AFANzuLZpfLdzwK9rheStRfqj2bnHyRtTW+YHNyFtMq/FstvJ+Q6RhY89keeLQuS3u6oSj
	ACCgbVPV8qC1nmBuFvT+clwEEmCv5H7k/6KgZnP5oLEci3YJ4p2jPUeJOUc1jV5NQUeyZu
	cpFAh57If1JKIkBM0rhHcaNP0OXw/RY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B957136E4
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 00:14:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E/InE8w1mWjZbAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 00:14:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: use blocksize to check if compression is making things larger
Date: Mon, 11 Aug 2025 09:43:42 +0930
Message-ID: <14db816c702a3567faa0cd5efe2110b6ebfba970.1754871148.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[BEHAVIOR DIFFERENCE BETWEEN COMPRESSION ALGOS]
Currently LZO compression algorithm will check if we're making the
compressed data larger after compressing more than 2 blocks.

But zlib and zstd do the same checks after compressing more than 8192
bytes.

This is not a big deal, but since we're already supporting larger block
size (e.g. 64K block size if page size is also 64K), this check is not
suitable for all block sizes.

For example, if our page and block size are both 16KiB, and after the
first block compressed using zlib, the resulted compressed data is
slightly  larger than 16KiB, we will immediately abort the compression.

This makes zstd and zlib compression algorithms to behave slightly
different from LZO, which only aborts after compressing two blocks.

[ENHANCEMENT]
To unify the behavior, only abort the compression after compressing at
least two blocks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This relies on a previous patch which passes btrfs_inode pointer
directly into all the *_compress_folios() callbacks:
https://lore.kernel.org/linux-btrfs/fd12c8b1c7366dc82b04cc702a82703b3e7d3686.1754822695.git.wqu@suse.com/
---
 fs/btrfs/zlib.c | 3 ++-
 fs/btrfs/zstd.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 21af68f93a2d..33dc7e7b5c36 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -148,6 +148,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	unsigned long nr_dest_folios = *out_folios;
 	const unsigned long max_out = nr_dest_folios * PAGE_SIZE;
+	const u32 blocksize = inode->root->fs_info->sectorsize;
 	const u64 orig_end = start + len;
 
 	*out_folios = 0;
@@ -234,7 +235,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		}
 
 		/* we're making it bigger, give up */
-		if (workspace->strm.total_in > 8192 &&
+		if (workspace->strm.total_in > blocksize * 2 &&
 		    workspace->strm.total_in <
 		    workspace->strm.total_out) {
 			ret = -E2BIG;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 00159e0e921e..d521187336a5 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -400,6 +400,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	unsigned long len = *total_out;
 	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
+	const u32 blocksize = inode->root->fs_info->sectorsize;
 	unsigned long max_out = nr_dest_folios * PAGE_SIZE;
 	unsigned int cur_len;
 
@@ -456,7 +457,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		}
 
 		/* Check to see if we are making it bigger */
-		if (tot_in + workspace->in_buf.pos > 8192 &&
+		if (tot_in + workspace->in_buf.pos > blocksize * 2 &&
 				tot_in + workspace->in_buf.pos <
 				tot_out + workspace->out_buf.pos) {
 			ret = -E2BIG;
-- 
2.50.1


