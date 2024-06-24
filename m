Return-Path: <linux-btrfs+bounces-5910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5216914193
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 06:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F9EB1C21C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BE1401C;
	Mon, 24 Jun 2024 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UeExf8ie";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UeExf8ie"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB711713
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 04:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719205162; cv=none; b=Yqv8y8msKb0exsQguA3OPyU49KzxmUML3p8ljk37dYWU6dfS5ddC5i0xfHSQaSmsHDdtQwJP6CwMLnOZiX38ne6NRwxumUW8m1oFFXaITSZQRJeq3CMaH77PrjIu7ODRgjyq3vllhR9rbTvXZJvXnZWux6p+HVVSqm2msvgptmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719205162; c=relaxed/simple;
	bh=D4A8ommd+UQwB7R+F2+OgXtwLGO5RqVbofTtG896/o4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JR6dQXNIei/LJGdPgpHAvWvr4bm2ijYry6r2RrXoMPtuu28/1pS84mhQFBAJd34CywYPP0KIJ0xhGiqP8hweoDo7jxJD3Svo0rM4Dw8o1yrPPIaXqm7S/nymYVQhSYuSPGHFXdG2pWim2H/P3RGgSqJ47m/3h9AiOs3d9REuQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UeExf8ie; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UeExf8ie; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBA3C1F7A7
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 04:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719205157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JaFb8TGs3akcIR6lrhSnVgmErMXa9SV+Gsea20rmDSw=;
	b=UeExf8ie8zh8oCCwTjqKkZLqflQhbArGPxvc8/YXN0Dz+jEMrMUhzC9ObIL6VOApOSQO6L
	/u63FqlJcpwTTZzy3Cwn1bHSr9DpCfJizI+wOjZsvv+p1AocxA5L3HyNG9Rr9TCSM5gIya
	90DCqNiQo38c13Z3I2J0M2koo5PFYLw=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719205157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=JaFb8TGs3akcIR6lrhSnVgmErMXa9SV+Gsea20rmDSw=;
	b=UeExf8ie8zh8oCCwTjqKkZLqflQhbArGPxvc8/YXN0Dz+jEMrMUhzC9ObIL6VOApOSQO6L
	/u63FqlJcpwTTZzy3Cwn1bHSr9DpCfJizI+wOjZsvv+p1AocxA5L3HyNG9Rr9TCSM5gIya
	90DCqNiQo38c13Z3I2J0M2koo5PFYLw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D51A113ACD
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 04:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7hDVIST9eGZNSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 04:59:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: print-tree: add generation and type dump for EXTENT_DATA_KEY
Date: Mon, 24 Jun 2024 14:28:54 +0930
Message-ID: <0ff7d2afbab9518e677a725935c3f4e3224a4229.1719205115.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

When debugging the recent ram_bytes mismatch bug, I can hit it with
enhanced tree-checker for file extent items at write time.

But the bug is not that easy to trigger (mostly triggered with
btrfs/06*, which uses 20 threads fsstress), and when I hit it, the only
info is the kernel leaf dump, but it doesn't include things like the
file extent type (REGULAR or PREALLOC).

Add the dump for generation and type (although only numeric output) to
make debugging a little easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/print-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7e46aa8a0444..bb2d497b421c 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -310,6 +310,9 @@ void btrfs_print_leaf(const struct extent_buffer *l)
 		case BTRFS_EXTENT_DATA_KEY:
 			fi = btrfs_item_ptr(l, i,
 					    struct btrfs_file_extent_item);
+			pr_info("\t\tgeneration %llu type %hhu\n",
+				btrfs_file_extent_generation(l, fi),
+				btrfs_file_extent_type(l, fi));
 			if (btrfs_file_extent_type(l, fi) ==
 			    BTRFS_FILE_EXTENT_INLINE) {
 				pr_info("\t\tinline extent data size %llu\n",
-- 
2.45.2


