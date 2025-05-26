Return-Path: <linux-btrfs+bounces-14233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41BAC3861
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041593AF09F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 04:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F7B18C02E;
	Mon, 26 May 2025 04:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b1E7LJ73";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b1E7LJ73"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD47136E
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748232205; cv=none; b=CUsCnZGoQMKqy1slsbEH47kvLH62mwF06gHTIl3Tcge0XfODZINFh29JZ9FK8WIel7ix7VVC7eu3WVfUSf/0VGEm1dx/8BQusyaIxlJTAgOzUnjVHfMQ2Zbn1Y9wA8KmWzrHgiFroZNpYMR5s+BRLz7KlRRfOQlyU7j4Ufuxts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748232205; c=relaxed/simple;
	bh=47D3IPbMCil1ACkrVyCwgwGqh7JisrUNRLghj1wk1PY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMbJ6rSujVJUoD08+ASS7y6fHopD7wVqEQkqFnuAUvf3giDqSvxnPXAbNhZbzo1GrQ9fpKZ1DLHjWtV/+G9I4tdhB3CAB8P9KQkWqIyIx+4bP6yqqFrposNTYVNgR6i60V3NZCAv9/1kS+i/ZWc757ys9FB9Z3ooL8lgfvTLsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b1E7LJ73; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b1E7LJ73; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6010B1FE35
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9/WkRC1b4LC3ffSu7bmv5AJE2KSJ+vLv23XTb7UCUA=;
	b=b1E7LJ73XeoVbIbr2cfh38CXi9vNYlReDgjLPqSKE0nWEPQYUlTKD2X3yK7wFnSDzRgqfo
	NSuWynifskO8kRYG1fV7IpiHyjrv3R8EPACT2cN1abOLtgPP522ioNxoaNDJ/xogHJ6vGn
	RkSfR9f8XRM2ejP0hKtqXOygKdPfC6k=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=b1E7LJ73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9/WkRC1b4LC3ffSu7bmv5AJE2KSJ+vLv23XTb7UCUA=;
	b=b1E7LJ73XeoVbIbr2cfh38CXi9vNYlReDgjLPqSKE0nWEPQYUlTKD2X3yK7wFnSDzRgqfo
	NSuWynifskO8kRYG1fV7IpiHyjrv3R8EPACT2cN1abOLtgPP522ioNxoaNDJ/xogHJ6vGn
	RkSfR9f8XRM2ejP0hKtqXOygKdPfC6k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99E6813770
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCfXFvLnM2g3ewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: enhance btrfs_print_leaf() to handle NULL fs_info
Date: Mon, 26 May 2025 13:32:37 +0930
Message-ID: <84c9b4e730b06d0fb4192a9a380c025f03685a29.1748232037.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748232037.git.wqu@suse.com>
References: <cover.1748232037.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 6010B1FE35
X-Spam-Level: 
X-Spam-Flag: NO

For mkfs and convert, we need to create a temporary fs without an
fs_info.

This makes debugging much harder that we can not use btrfs_print_leaf()
to print the temporary tree blocks.

There are only two things causing problems for btrfs_print_leaf() if
eb->fs_info is NULL:

- print_header_info()
  Which needs to grab the checksum type from eb->fs_info.

  This can be avoided by completely skipping checksum output if
  eb->fs_info is NULL.

- btrfs_leaf_free_space()
  Which have two BUG_ON()s checking eb->fs_info, and finally calling
  BTRFS_LEAF_DATA_SIZE().

  Which can be avoided by removing the two BUG_ON()s, and use
  __BTRFS_LEAF_DATA_SIZE(eb->len) to grab the same leaf data size.

  Thankfully all call sites inside mkfs and convert are setting eb->len
  to nodesize correctly.

- __btrfs_print_leaf()
  Which calls BTRFS_LEAF_DATA_SIZE(eb->fs_info).

  Can be avoided by the same method above.

With those changes, we can call btrfs_print_leaf() inside a debugger
for temporary fses created by mkfs and convert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.c      |  4 +---
 kernel-shared/print-tree.c | 32 +++++++++++++++++---------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index f90de606e7b1..7815101b2195 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -1888,9 +1888,7 @@ int btrfs_leaf_free_space(const struct extent_buffer *leaf)
 	u32 leaf_data_size;
 	int ret;
 
-	BUG_ON(!leaf->fs_info);
-	BUG_ON(leaf->fs_info->nodesize != leaf->len);
-	leaf_data_size = BTRFS_LEAF_DATA_SIZE(leaf->fs_info);
+	leaf_data_size = __BTRFS_LEAF_DATA_SIZE(leaf->len);
 	ret = leaf_data_size - leaf_space_used(leaf, 0 ,nritems);
 	if (ret < 0) {
 		printk("leaf free space ret %d, leaf data size %u, used %d nritems %d\n",
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 6ed1191948d8..1ca2cb90273e 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1345,7 +1345,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	u8 backref_rev;
 	char csum_str[2 * BTRFS_CSUM_SIZE + 8 /* strlen(" csum 0x") */ + 1];
 	int i;
-	int csum_size = fs_info->csum_size;
+	int csum_size = fs_info ? fs_info->csum_size : 0;
 
 	flags = btrfs_header_flags(eb) & ~BTRFS_BACKREF_REV_MASK;
 	backref_rev = btrfs_header_flags(eb) >> BTRFS_BACKREF_REV_SHIFT;
@@ -1387,18 +1387,20 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	       csum_str);
 
 #if EXPERIMENTAL
-	printf("checksum stored ");
-	for (i = 0; i < csum_size; i++)
-		printf("%02hhx", (int)(eb->data[i]));
-	printf("\n");
-	memset(csum, 0, sizeof(csum));
-	btrfs_csum_data(btrfs_super_csum_type(fs_info->super_copy),
-			(u8 *)eb->data + BTRFS_CSUM_SIZE,
-			csum, fs_info->nodesize - BTRFS_CSUM_SIZE);
-	printf("checksum calced ");
-	for (i = 0; i < csum_size; i++)
-		printf("%02hhx", (int)(csum[i]));
-	printf("\n");
+	if (fs_info) {
+		printf("checksum stored ");
+		for (i = 0; i < csum_size; i++)
+			printf("%02hhx", (int)(eb->data[i]));
+		printf("\n");
+		memset(csum, 0, sizeof(csum));
+		btrfs_csum_data(btrfs_super_csum_type(fs_info->super_copy),
+				(u8 *)eb->data + BTRFS_CSUM_SIZE,
+				csum, fs_info->nodesize - BTRFS_CSUM_SIZE);
+		printf("checksum calced ");
+		for (i = 0; i < csum_size; i++)
+			printf("%02hhx", (int)(csum[i]));
+		printf("\n");
+	}
 #endif
 
 	print_uuids(eb);
@@ -1478,10 +1480,10 @@ static void print_dev_replace_item(struct extent_buffer *eb, struct btrfs_dev_re
 void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
 	struct btrfs_disk_key disk_key;
-	u32 leaf_data_size = BTRFS_LEAF_DATA_SIZE(eb->fs_info);
+	u32 leaf_data_size = __BTRFS_LEAF_DATA_SIZE(eb->len);
 	u32 i;
 	u32 nr;
-	const bool print_csum_items = (mode & BTRFS_PRINT_TREE_CSUM_ITEMS);
+	const bool print_csum_items = (mode & BTRFS_PRINT_TREE_CSUM_ITEMS) && eb->fs_info;
 
 	print_header_info(eb, mode);
 	nr = btrfs_header_nritems(eb);
-- 
2.49.0


