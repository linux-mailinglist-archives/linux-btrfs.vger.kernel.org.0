Return-Path: <linux-btrfs+bounces-5933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A0915393
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FD51F24401
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8719FA88;
	Mon, 24 Jun 2024 16:23:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7A19DF72
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246203; cv=none; b=s2uaAuCFNLKoUbGMx336vRfRgiGHznM8R2gtgSLF8l1OCPl5cCVNPkZ/sDO48XjJi3/VTkWV6tcf4U58jJbND1iUymv5eOmVulRBmrYKrmZ0XIdeFY1rjRbaC7CjIAMfI7WIm7SNJefm7/63Uc5pkJg76/2orKg1zdE89t2zGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246203; c=relaxed/simple;
	bh=a91OSJZ5xkzGL+sdTHvKnuuCJFrvnDowjd/k9Oi+Dk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBJML52ecvZpWF2yetgDo7ppFA2GTkNFR5hm7yGM5gB1fqa5a0P5vlr4VdSlzCabPbr4WAouy4DI8QioxNHsIwIXK4OLCPGAX4Xc4C1Z8zcT3cFf23GmxaJiNNeHlXN5B71HjGFz7PyS8VnpbPAAqfwH5u95CLoG4BoN/hDKg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD9C2122D;
	Mon, 24 Jun 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 250F91384C;
	Mon, 24 Jun 2024 16:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KsUKCXideWbwLQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 24 Jun 2024 16:23:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 08/11] btrfs: pass a btrfs_inode to btrfs_compress_heuristic()
Date: Mon, 24 Jun 2024 18:23:19 +0200
Message-ID: <5a5be9541e21407595f09fa4506efa679048f71f.1719246104.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719246104.git.dsterba@suse.com>
References: <cover.1719246104.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 2BD9C2122D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Pass a struct btrfs_inode to btrfs_compress_heuristic() as it's an
internal interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 4 ++--
 fs/btrfs/compression.h | 2 +-
 fs/btrfs/inode.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index de136ef3a2f8..85eb2cadbbf6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1507,7 +1507,7 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
  *
  * Return non-zero if the compression should be done, 0 otherwise.
  */
-int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end)
+int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end)
 {
 	struct list_head *ws_list = get_workspace(0, 0);
 	struct heuristic_ws *ws;
@@ -1517,7 +1517,7 @@ int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end)
 
 	ws = list_entry(ws_list, struct heuristic_ws, list);
 
-	heuristic_collect_sample(inode, start, end, ws);
+	heuristic_collect_sample(&inode->vfs_inode, start, end, ws);
 
 	if (sample_repeated_patterns(ws)) {
 		ret = 1;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index c20c1a1b09d5..cfdc64319186 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -144,7 +144,7 @@ extern const struct btrfs_compress_op btrfs_zstd_compress;
 const char* btrfs_compress_type2str(enum btrfs_compression_type type);
 bool btrfs_compress_is_valid_type(const char *str, size_t len);
 
-int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);
+int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end);
 
 int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 				     struct folio **in_folio_ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a6c460675a2d..e9744392fe51 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -876,7 +876,7 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 	if (btrfs_test_opt(fs_info, COMPRESS) ||
 	    inode->flags & BTRFS_INODE_COMPRESS ||
 	    inode->prop_compress)
-		return btrfs_compress_heuristic(&inode->vfs_inode, start, end);
+		return btrfs_compress_heuristic(inode, start, end);
 	return 0;
 }
 
-- 
2.45.0


