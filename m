Return-Path: <linux-btrfs+bounces-13329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB728A99461
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E71446C95
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C490284677;
	Wed, 23 Apr 2025 15:58:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A5283C98
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423898; cv=none; b=C5xuRlscvmf4Io+cE+t4lJvq+L9FcOVLU25T4Hnozf0HosMn1gfe3yfO9LY4JH1rx1x4vkwh62/JxOJg6p8LVPmjoqCVsL/sU3bGWaPzGykxGuBrvp5ZC4Q4bsnNCvCJJyllCB2Aq26cXq/DAC0BwK9jr7+YKkppGkJTjxGBc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423898; c=relaxed/simple;
	bh=baPjKBS1UY4bOAx6ikhA3AYEqJsm7jyNcZcDrGKRs04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDz+SP00YOo1QWYYGgY1MjThfYGzGp5vIPx36K6+EEi3KBGrXYJwfrhqfa9LJQ68lpPPMolmq38WB53Ici0AzoWQfc/QNLCkkXqApObpIjKOwB5eLLWffyYbfSbzgrx991XDexnoLSTtAuCp20CdkG05nVm1oEtSjALzqENHc08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 004C02118F;
	Wed, 23 Apr 2025 15:58:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE1613691;
	Wed, 23 Apr 2025 15:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jqrSORYOCWi1CQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/12] btrfs: rename error to ret in btrfs_submit_chunk()
Date: Wed, 23 Apr 2025 17:57:19 +0200
Message-ID: <5c3b34173d9eaf56f3b93f546df72ff3e8e1a571.1745422901.git.dsterba@suse.com>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 004C02118F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

We can now rename 'error' to 'ret' and use it for generic errors.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7ea56856e9dedc..05a1bc450c1ccf 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -675,7 +675,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
 	blk_status_t status;
-	int error;
+	int ret;
 
 	if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
 		smap.rst_search_commit_root = true;
@@ -683,10 +683,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		smap.rst_search_commit_root = false;
 
 	btrfs_bio_counter_inc_blocked(fs_info);
-	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
-				&bioc, &smap, &mirror_num);
-	if (error) {
-		status = errno_to_blk_status(error);
+	ret = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
+			      &bioc, &smap, &mirror_num);
+	if (ret) {
+		status = errno_to_blk_status(ret);
 		btrfs_bio_counter_dec(fs_info);
 		goto end_bbio;
 	}
@@ -714,8 +714,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	 */
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
 		bbio->saved_iter = bio->bi_iter;
-		error = btrfs_lookup_bio_sums(bbio);
-		status = errno_to_blk_status(error);
+		ret = btrfs_lookup_bio_sums(bbio);
+		status = errno_to_blk_status(ret);
 		if (status)
 			goto fail;
 	}
@@ -748,8 +748,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
 				goto done;
 
-			error = btrfs_bio_csum(bbio);
-			status = errno_to_blk_status(error);
+			ret = btrfs_bio_csum(bbio);
+			status = errno_to_blk_status(ret);
 			if (status)
 				goto fail;
 		} else if (use_append ||
-- 
2.49.0


