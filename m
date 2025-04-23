Return-Path: <linux-btrfs+bounces-13333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AEA99458
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0F84A1FC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCD2857CD;
	Wed, 23 Apr 2025 15:58:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981B283CB5
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423919; cv=none; b=Aq87lxMtEEonzbjBIdm5UUqT3tyTxtsMXxbLnXlnYY8nse/BZgyqenMx3TALkacxPehSW7bJSHtXyJsrV4Q29t2tipghcZAW0AMpmw1jknvsithpjyD3VlSnw2aeNGsghvBEiONmcz25OtdD6pujb3g4ivzw6Lx10jdmMDi2hqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423919; c=relaxed/simple;
	bh=OyxCNXFqvNExmeaTM/NJ1ZRCCv6ryTzLsLx0mBJNbJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlNXSa8MwY8J8tFeETjVnAICfOYmE6aPcyTIoPk8hUrkprm6mE5iaWxmkK/Ha6KXI3bh811KZA+FrM/E6lkhFvz1tRhU3XE0QmIlmxIBiDo1dWJt7lVo1IbDklu2sdaTwSd7JKgkki438Btp2UNWnsCRw1vzjj5oCPf/5hqKhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA5521F38E;
	Wed, 23 Apr 2025 15:58:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1CCB13691;
	Wed, 23 Apr 2025 15:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6181MysOCWjJCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:35 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 11/12] btrfs: change return type of btrfs_alloc_dummy_sum() to int
Date: Wed, 23 Apr 2025 17:57:23 +0200
Message-ID: <df1e6706ed339125075822f79452194f0b1d25b6.1745422901.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745422901.git.dsterba@suse.com>
References: <cover.1745422901.git.dsterba@suse.com>
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
X-Rspamd-Queue-Id: DA5521F38E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The type blk_status_t is from block layer and not related to checksums
in our context. Use int internally and do the conversions to blk_status_t
as needed in btrfs_submit_chunk().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c       | 3 ++-
 fs/btrfs/file-item.c | 4 ++--
 fs/btrfs/file-item.h | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 05a1bc450c1ccf..f7d8958b732792 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -755,7 +755,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		} else if (use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
-			status = btrfs_alloc_dummy_sum(bbio);
+			ret = btrfs_alloc_dummy_sum(bbio);
+			status = errno_to_blk_status(ret);
 			if (status)
 				goto fail;
 		}
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 293dd3298b98bb..54d523d4f42126 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -794,11 +794,11 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
  * record the updated logical address on Zone Append completion.
  * Allocate just the structure with an empty sums array here for that case.
  */
-blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
+int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio)
 {
 	bbio->sums = kmalloc(sizeof(*bbio->sums), GFP_NOFS);
 	if (!bbio->sums)
-		return BLK_STS_RESOURCE;
+		return -ENOMEM;
 	bbio->sums->len = bbio->bio.bi_iter.bi_size;
 	bbio->sums->logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	btrfs_add_ordered_sum(bbio->ordered, bbio->sums);
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 323dfb84f16c1d..63216c43676def 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -65,7 +65,7 @@ int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
 			   struct btrfs_root *root,
 			   struct btrfs_ordered_sum *sums);
 int btrfs_csum_one_bio(struct btrfs_bio *bbio);
-blk_status_t btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
+int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
 int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			     struct list_head *list, int search_commit,
 			     bool nowait);
-- 
2.49.0


