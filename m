Return-Path: <linux-btrfs+bounces-17843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5F5BDE6A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 14:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74DF64F44BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41235326D51;
	Wed, 15 Oct 2025 12:12:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF029CE1
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530353; cv=none; b=qfGIlc/mYHfPA5stE+gaioJH50Jm2L2PsHG953Zw9xf1puOOiSIUwvwrokeEQYHn7KrVxkbwnYlLkqoDLPNe/iNQdxsFU8mcN/lFGT7Msp0/Bygfr5BKou5mENOsf26moJU8yzA73VsYrrh++ULWOeHp5NhxUoaYSykmwffDbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530353; c=relaxed/simple;
	bh=F5kJkWlo7gjcXbrWFcj09Fq82IEf7zrMkRtsREc+3yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drEtSHk9qbRxkrjjXx2sd4aSYWujuzo4nzeUpXn6piE85uq/R3m8gc8UOcI5F37kR9fmF7AhOTtxfqd2m9vKC5iByCJ9mO8FRzEjw4LCd//muPnB6lD38LCWFx//r+SITKl4//DupZsRhTCywlD+g7/6fi+dSpPbQV1NefP3aH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F5D93385A;
	Wed, 15 Oct 2025 12:12:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F171513A42;
	Wed, 15 Oct 2025 12:12:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLl9OpKP72i2fAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Oct 2025 12:12:02 +0000
From: Daniel Vacek <neelx@suse.com>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 6/8] btrfs-progs: handle fscrypt context items
Date: Wed, 15 Oct 2025 14:11:54 +0200
Message-ID: <20251015121157.1348124-7-neelx@suse.com>
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
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0F5D93385A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

Encrypted inodes have a new associated item, the fscrypt context, which
can be printed as a pure hex string in dump-tree.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 kernel-shared/print-tree.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 060bf997..cde07ab1 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -117,6 +117,20 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 	}
 }
 
+static void print_fscrypt_context(struct extent_buffer *eb, int slot)
+{
+	int i;
+	unsigned long ptr = btrfs_item_ptr_offset(eb, slot);
+	u32 item_size = btrfs_item_size(eb, slot);
+	u8 ctx_buf[item_size];
+
+	read_extent_buffer(eb, ctx_buf, ptr, item_size);
+	printf("\t\tvalue: ");
+	for(i = 0; i < item_size; i++)
+		printf("%02x", ctx_buf[i]);
+	printf("\n");
+}
+
 static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
 		struct btrfs_inode_extref *extref)
 {
@@ -756,6 +770,7 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 		[BTRFS_DIR_LOG_ITEM_KEY]	= "DIR_LOG_ITEM",
 		[BTRFS_DIR_LOG_INDEX_KEY]	= "DIR_LOG_INDEX",
 		[BTRFS_XATTR_ITEM_KEY]		= "XATTR_ITEM",
+		[BTRFS_FSCRYPT_CTXT_ITEM_KEY]   = "FSCRYPT_CTXT_ITEM",
 		[BTRFS_VERITY_DESC_ITEM_KEY]	= "VERITY_DESC_ITEM",
 		[BTRFS_VERITY_MERKLE_ITEM_KEY]	= "VERITY_MERKLE_ITEM",
 		[BTRFS_ORPHAN_ITEM_KEY]		= "ORPHAN_ITEM",
@@ -1566,6 +1581,9 @@ void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_XATTR_ITEM_KEY:
 			print_dir_item(eb, item_size, ptr);
 			break;
+		case BTRFS_FSCRYPT_CTXT_ITEM_KEY:
+			print_fscrypt_context(eb, i);
+			break;
 		case BTRFS_DIR_LOG_INDEX_KEY:
 		case BTRFS_DIR_LOG_ITEM_KEY: {
 			struct btrfs_dir_log_item *dlog;
-- 
2.51.0


