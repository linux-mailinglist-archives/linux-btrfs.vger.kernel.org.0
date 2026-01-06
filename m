Return-Path: <linux-btrfs+bounces-20168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DED71CF9582
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB42302F698
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC1335091;
	Tue,  6 Jan 2026 16:21:15 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE9326933
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716474; cv=none; b=Mfnq9wb9fsgwjmBKuCb3ozl26lbBlBIyezRezqIBRMQTJjz9oqRp2MY9BYjF1RMKCOdCa++8Up5i840yKjYVKMF7fS5HpgNBc9AL0NXfwriZ8Ro6kUydXGSpYu+pg6GRDp+ef1nnYItjlOvS0ZYcTJqEewFYMzrHwdmEn97cFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716474; c=relaxed/simple;
	bh=xx4Ziklrv1X/fYvuvBVhGa14eFdxKJUrjRz6rgSxpxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkCwOEDaNwjC/Vs6tvILc4i7aFju215hSmDVbgN2bU5hKMyWjtuSUESXb2Tlb/SehqxkbwfU6LeToykJP1jFFmZY/EGh6EG8OGKi9Iy3v/0Sfi9FhiWx9sSs5f468d05CjXCsMh6Y5i/RRXX1UsjoK77IDoAGutef03nOcXFbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F0D35BCD1;
	Tue,  6 Jan 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 494513EA63;
	Tue,  6 Jan 2026 16:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ajHgEXc2XWm/WQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:11 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 09/12] btrfs: zlib: remove local variable nr_dest_folios in zlib_compress_folios()
Date: Tue,  6 Jan 2026 17:20:32 +0100
Message-ID: <6a4a71802a5f26209bed59b492fd07029d52686f.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4F0D35BCD1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

The value of *out_folios does not change and nr_dest_folios is only a
local copy, we can remove it. This saves 8 bytes of stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zlib.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index bb4a9f70714682..fa35513267ae42 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -158,8 +158,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	struct folio *in_folio = NULL;
 	struct folio *out_folio = NULL;
 	unsigned long len = *total_out;
-	unsigned long nr_dest_folios = *out_folios;
-	const unsigned long max_out = nr_dest_folios << min_folio_shift;
+	const unsigned long max_out = *out_folios << min_folio_shift;
 	const u64 orig_end = start + len;
 
 	*out_folios = 0;
@@ -257,7 +256,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		 * the stream end if required
 		 */
 		if (workspace->strm.avail_out == 0) {
-			if (nr_folios == nr_dest_folios) {
+			if (nr_folios == *out_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
@@ -292,7 +291,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 			goto out;
 		} else if (workspace->strm.avail_out == 0) {
 			/* Get another folio for the stream end. */
-			if (nr_folios == nr_dest_folios) {
+			if (nr_folios == *out_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
-- 
2.51.1


