Return-Path: <linux-btrfs+bounces-8711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91180996DEF
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EEB1C2025B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E571A257C;
	Wed,  9 Oct 2024 14:31:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240321A0BE3
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484310; cv=none; b=XVffhr2qJ3iA85L/gvaF6iQBfl5OUl0GkYpFFK4LMyxMXcO97icq/Xnhkaxs/EyFcAIKe357hBDdr0NQe2xlQaB9F57msQl2xZ6Xkn+HV7hDR9hkYxKTROIavBGK1GFHhn0xrkOdsqZFLLBo6FGylwuM7QFZ7YtVPuhLBAjHjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484310; c=relaxed/simple;
	bh=XfBmmWgRrcYFusMfPkwnJcOsg7M857dyjKtnwj54wmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt5Hr/Q9GhWKoWWCceEiPeZwg7KZFR9IuQnjL14Y4DGavJsTmxxuZS70TKnrQYS8mDjrHkk7YUf5iOkKI20gm9BPMuUPOEHGf+LS52DZmcfAyTYNEyRQxGHALCRUbr6W/2bNabUvcU6YVlcxuzm1zCI4qHn3FSdmBdNk6hzZTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 916EB21EB2;
	Wed,  9 Oct 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A8C9136BA;
	Wed,  9 Oct 2024 14:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eI3OIdOTBmdSRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Oct 2024 14:31:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 16/25] btrfs: drop unused parameter file_offset from btrfs_encoded_read_regular_fill_pages()
Date: Wed,  9 Oct 2024 16:31:47 +0200
Message-ID: <4179d2ec4278c45f7025518fe8dac1b1da597d1f.1728484021.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 916EB21EB2
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The file_offset parameter used to be passed to encoded read struct but
was removed in commit b665affe93d8 ("btrfs: remove unused members from
struct btrfs_encoded_read_private").

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 3 +--
 fs/btrfs/inode.c       | 6 +++---
 fs/btrfs/send.c        | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index e152fde888fc..5e2d93c2dfb5 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -613,8 +613,7 @@ int btrfs_writepage_cow_fixup(struct folio *folio);
 int btrfs_encoded_io_compression_from_extent(struct btrfs_fs_info *fs_info,
 					     int compress_type);
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
-					  u64 file_offset, u64 disk_bytenr,
-					  u64 disk_io_size,
+					  u64 disk_bytenr, u64 disk_io_size,
 					  struct page **pages);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a865ae8e88b9..83ac76a0caef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9103,8 +9103,8 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 }
 
 int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
-					  u64 file_offset, u64 disk_bytenr,
-					  u64 disk_io_size, struct page **pages)
+					  u64 disk_bytenr, u64 disk_io_size,
+					  struct page **pages)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
@@ -9174,7 +9174,7 @@ static ssize_t btrfs_encoded_read_regular(struct kiocb *iocb,
 		goto out;
 		}
 
-	ret = btrfs_encoded_read_regular_fill_pages(inode, start, disk_bytenr,
+	ret = btrfs_encoded_read_regular_fill_pages(inode, disk_bytenr,
 						    disk_io_size, pages);
 	if (ret)
 		goto out;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index db16879c798f..75bcfbda8d47 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5667,7 +5667,7 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	 * Note that send_buf is a mapping of send_buf_pages, so this is really
 	 * reading into send_buf.
 	 */
-	ret = btrfs_encoded_read_regular_fill_pages(BTRFS_I(inode), offset,
+	ret = btrfs_encoded_read_regular_fill_pages(BTRFS_I(inode),
 						    disk_bytenr, disk_num_bytes,
 						    sctx->send_buf_pages +
 						    (data_offset >> PAGE_SHIFT));
-- 
2.45.0


