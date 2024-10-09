Return-Path: <linux-btrfs+bounces-8710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5809996DEE
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A871F21B8E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C211A0BE5;
	Wed,  9 Oct 2024 14:31:49 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE121A0BC9
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484309; cv=none; b=emNCxM5nIZhtsi3zAer/LjsdSU0B96QkOAeUkWlWZoriKnrtCaOT3a0X2M0EEwL7V4RjmpngQrX3g9Xih+6XIIwjvuc4ikmFDxgmvrqWQVAsWRUH208wtZEkHgBH8ikPBYufgirN6QOO/unK+WJacAXE3hqJusksAa50vT9+EPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484309; c=relaxed/simple;
	bh=9KIsl2wyLx72HCPVcRz0WPDp3VG6EghOaLVLz6/Jm00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1SHN4NhVshucGag4FeZ8CgGYalPD0rmTVGRXUP8kbiFOZ4GfaXx2DMIJkRnVkxwq5YwY/4abMr7kse2BcCIhSvgF8steutpUCUHgdDcl3kume0hB7Dw7rfq6oRX2E7YoexkPWPrktM/qYM2OYYA1x6+CXNCGB5fAuOyQj7SHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2245B1F7C8;
	Wed,  9 Oct 2024 14:31:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B86F136BA;
	Wed,  9 Oct 2024 14:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mki0BtGTBmdLRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:45 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 15/25] btrfs: drop unused parameter offset from __cow_file_range_inline()
Date: Wed,  9 Oct 2024 16:31:36 +0200
Message-ID: <944b97ccca714864b4198bf37c0f5dc8b1f15084.1728484021.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1728484021.git.dsterba@suse.com>
References: <cover.1728484021.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: 2245B1F7C8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

We don't need offset for inline extents, they always start from 0.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1941939f3e48..a865ae8e88b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -646,7 +646,7 @@ static bool can_cow_file_range_inline(struct btrfs_inode *inode,
  * If being used directly, you must have already checked we're allowed to cow
  * the range by getting true from can_cow_file_range_inline().
  */
-static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
+static noinline int __cow_file_range_inline(struct btrfs_inode *inode,
 					    u64 size, size_t compressed_size,
 					    int compress_type,
 					    struct folio *compressed_folio,
@@ -736,7 +736,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode,
 		return 1;
 
 	lock_extent(&inode->io_tree, offset, end, &cached);
-	ret = __cow_file_range_inline(inode, offset, size, compressed_size,
+	ret = __cow_file_range_inline(inode, size, compressed_size,
 				      compress_type, compressed_folio,
 				      update_i_size);
 	if (ret > 0) {
@@ -9527,7 +9527,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (encoded->unencoded_len == encoded->len &&
 	    encoded->unencoded_offset == 0 &&
 	    can_cow_file_range_inline(inode, start, encoded->len, orig_count)) {
-		ret = __cow_file_range_inline(inode, start, encoded->len,
+		ret = __cow_file_range_inline(inode, encoded->len,
 					      orig_count, compression, folios[0],
 					      true);
 		if (ret <= 0) {
-- 
2.45.0


