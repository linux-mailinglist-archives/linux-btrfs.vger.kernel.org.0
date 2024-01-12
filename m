Return-Path: <linux-btrfs+bounces-1406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79982B9B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 03:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF0D1F231CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 02:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F68C0F;
	Fri, 12 Jan 2024 02:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h9IN0dgy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="h9IN0dgy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD9A539E
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 02:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 33C0A1FB76
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 02:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705027599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yC8G9HiRSatx4Dgr37rhvIUCb/i6NuIjZMc88NPoV9I=;
	b=h9IN0dgyZIDXcbpWZLWxl26F0fWxnJdsID3R2P6jF0GF8ehSseSUku+e32QnIFBF4bLJL4
	G+u3uy1CdWDqbtwyHnV6AUy+77tAUOIQE2zLAWlWCNlqNvWW4vlA642JF5xgtqQua1SSc/
	VDGAN+/Pk7gU2YOipu8sCZNZEfQpsa8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705027599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=yC8G9HiRSatx4Dgr37rhvIUCb/i6NuIjZMc88NPoV9I=;
	b=h9IN0dgyZIDXcbpWZLWxl26F0fWxnJdsID3R2P6jF0GF8ehSseSUku+e32QnIFBF4bLJL4
	G+u3uy1CdWDqbtwyHnV6AUy+77tAUOIQE2zLAWlWCNlqNvWW4vlA642JF5xgtqQua1SSc/
	VDGAN+/Pk7gU2YOipu8sCZNZEfQpsa8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A57C13680
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 02:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9yTzBA6ooGX6WwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 02:46:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tree-checker: dump the tree block when hitting an error
Date: Fri, 12 Jan 2024 13:16:20 +1030
Message-ID: <a5ab0e98ae40df23b3bb65235f7bd9296e3b0be4.1705027543.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=h9IN0dgy
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 33C0A1FB76
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Unlike kernel where tree-checker would provide enough info so later we
can use "btrfs inspect dump-tree" to catch the offending tree block, in
progs we may not even have a btrfs to start "btrfs inspect dump-tree".
E.g during btrfs-convert.

To make later debug easier, let's call btrfs_print_tree() for every
error we hit inside tree-checker.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/tree-checker.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 003156795a43..a98553985402 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -33,6 +33,7 @@
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/file-item.h"
 #include "kernel-shared/extent_io.h"
+#include "kernel-shared/print-tree.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/internal.h"
@@ -95,6 +96,8 @@ static void generic_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
 		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 /*
@@ -123,6 +126,8 @@ static void file_extent_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
 		key.objectid, key.offset, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 /*
@@ -183,6 +188,8 @@ static void dir_item_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
 		key.objectid, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 /*
@@ -669,6 +676,8 @@ static void block_group_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
 		key.objectid, key.offset, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 static int check_block_group_item(struct extent_buffer *leaf,
@@ -800,6 +809,8 @@ static void chunk_err(const struct extent_buffer *leaf,
 			   BTRFS_CHUNK_TREE_OBJECTID, leaf->start, slot,
 			   logical, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)leaf, 0);
 }
 
 /*
@@ -1025,6 +1036,8 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_owner(eb), btrfs_header_bytenr(eb), slot,
 		key.objectid, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 static int check_dev_item(struct extent_buffer *leaf,
@@ -1279,6 +1292,8 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 		btrfs_header_level(eb) == 0 ? "leaf" : "node",
 		eb->start, slot, bytenr, len, &vaf);
 	va_end(args);
+
+	btrfs_print_tree((struct extent_buffer *)eb, 0);
 }
 
 static int check_extent_item(struct extent_buffer *leaf,
-- 
2.43.0


