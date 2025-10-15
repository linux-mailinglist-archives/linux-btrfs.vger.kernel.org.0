Return-Path: <linux-btrfs+bounces-17842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6977BDE6A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 419A7504F55
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D90C326D51;
	Wed, 15 Oct 2025 12:12:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD58324B17
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530347; cv=none; b=SPfRe6WMgVnUF6t0vGaanpXiwEQf+mMN4RnQtoEmGB0jW0I6YBqLW1BZgnqLNY39yw34urfsA5JEANu1edC6VP2LQhr7OI911nYCFLZtWmEH3oYDWzopp0Vkmv4PO7tSJkSBWAVBti1FdmiVqcUFpt5igu3LY6MRqDzlaYpvmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530347; c=relaxed/simple;
	bh=nNm8k8a+QhjGWebAm94N4ZLgr/4gfZyxRMmhgMF2+SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI1lW/hSUZHXyRxGRpAG8Qgobu6kJfu7qqAp0+z6A4JRbXiN3NXLSUm4g6uCHQJaCzlZRKV4sMjR5179ajWMjSc1UGi1Zeoc7K7VLztG2z77bwaA2ZlRNl8qSHwCvjUi20ztExkzSuiqqCB81Ys2B1M4sCYYUkbspqxaNERJ5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0ACC33859;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDE9813AEB;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sJW7NZKP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
Date: Wed, 15 Oct 2025 14:11:53 +0200
Message-ID: <20251015121157.1348124-6-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015121157.1348124-1-neelx@suse.com>
References: <20251015121157.1348124-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: F0ACC33859
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Encrypted file extents now have the 'encryption' field set to a
encryption type plus a context length, and have an extent context
appended to the item.  This necessitates adjusting the struct to have a
variable-length fscrypt_context member at the end, and printing contexts
if one is provided.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               | 10 +++++++---
 kernel-shared/print-tree.c | 23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 054a22d3..d3d65854 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1777,7 +1777,6 @@ static int process_file_extent(struct btrfs_root *root,
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (extent_type == BTRFS_FILE_EXTENT_PREALLOC &&
 		    (btrfs_file_extent_compression(eb, fi) ||
-		     btrfs_file_extent_encryption(eb, fi) ||
 		     btrfs_file_extent_other_encoding(eb, fi)))
 			rec->errors |= I_ERR_BAD_FILE_EXTENT;
 		if (compression && rec->nodatasum)
@@ -6495,6 +6494,7 @@ static int run_next_block(struct btrfs_root *root,
 		for (i = 0; i < nritems; i++) {
 			struct btrfs_file_extent_item *fi;
 			unsigned long inline_offset;
+			size_t extra_size = 0;
 
 			inline_offset = offsetof(struct btrfs_file_extent_item,
 						 disk_bytenr);
@@ -6630,13 +6630,17 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 
 			/* Prealloc/regular extent must have fixed item size */
+			if (btrfs_file_extent_encryption(buf, fi))
+				extra_size = btrfs_file_extent_encryption_info_size(buf, fi) +
+						sizeof(struct btrfs_encryption_info);
+
 			if (btrfs_item_size(buf, i) !=
-			    sizeof(struct btrfs_file_extent_item)) {
+			    (sizeof(struct btrfs_file_extent_item) + extra_size)) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file extent item size, have %u expect %zu",
 					btrfs_item_size(buf, i),
-					sizeof(struct btrfs_file_extent_item));
+					sizeof(struct btrfs_file_extent_item) + extra_size);
 				continue;
 			}
 			/* key.offset (file offset) must be aligned */
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 2a624a1c..060bf997 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -421,6 +421,25 @@ static void compress_type_to_str(u8 compress_type, char *ret)
 	}
 }
 
+static void generate_encryption_string(struct extent_buffer *leaf,
+				       struct btrfs_file_extent_item *fi,
+				       char *ret)
+{
+	u8 policy = btrfs_file_extent_encryption(leaf, fi);
+	u32 ctxsize = btrfs_file_extent_encryption_ctx_size(leaf, fi);
+	const __u8 *ctx = (__u8 *)(leaf->data + btrfs_file_extent_encryption_ctx_offset(fi));
+
+	ret += sprintf(ret, "(%hhu, %u", policy, ctxsize);
+
+	if (ctxsize) {
+		int i;
+		ret += sprintf(ret, ": context ");
+		for (i = 0; i < ctxsize; i++)
+			ret += sprintf(ret, "%02hhx", ctx[i]);
+	}
+	sprintf(ret, ")");
+}
+
 static const char* file_extent_type_to_str(u8 type)
 {
 	switch (type) {
@@ -437,9 +456,11 @@ static void print_file_extent_item(struct extent_buffer *eb,
 {
 	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
 	char compress_str[16];
+	char encrypt_str[16];
 
 	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
 			     compress_str);
+	generate_encryption_string(eb, fi, encrypt_str);
 
 	printf("\t\tgeneration %llu type %hhu (%s)\n",
 			btrfs_file_extent_generation(eb, fi),
@@ -472,6 +493,8 @@ static void print_file_extent_item(struct extent_buffer *eb,
 	printf("\t\textent compression %hhu (%s)\n",
 			btrfs_file_extent_compression(eb, fi),
 			compress_str);
+	printf("\t\textent encryption %hhu (%s)\n",
+			btrfs_file_extent_encryption(eb, fi), encrypt_str);
 }
 
 /* Caller should ensure sizeof(*ret) >= 16("DATA|TREE_BLOCK") */
-- 
2.51.0


