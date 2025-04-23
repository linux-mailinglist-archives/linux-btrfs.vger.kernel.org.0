Return-Path: <linux-btrfs+bounces-13328-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66315A994CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C0F1BC5D06
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABD283C82;
	Wed, 23 Apr 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hq7tIpZ9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hq7tIpZ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4F283689
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423892; cv=none; b=qHLaLayYsM0FOLyzYKQCCbM6e/Ykqe6dZ5GdLAJ5M4btKDlpxiogT3RMW/D9zQIn6/uvFg37AGy+0JlTdBgjMsL3ItVahuDbEm1BHMg3rIqXHpyyZLGWTf1vrsgHMLonejQgQKOcj2IE6l8iwXTQ2oZZkKLfcxOIOmsMPACcTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423892; c=relaxed/simple;
	bh=CZz6m3sIsWN+SG244CU9kZcRYwxM2mSdCWtYuPMCBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVY/uA4MHyOba62xO52dS5RGqn+Fw5LW7FVX9qxnp6ztpy5yEJQC41BeJ36JqhSG0/R8L0G4iLjhJfUyjlCcCp3J0HOZatHfeh3ySXkabpPsAGg3kf1D1n6xEAQPUydPhIwsNse2qefjTjdYLfpMSgadLJlfthl8KsxF3dC/xhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hq7tIpZ9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hq7tIpZ9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B4E841F38D;
	Wed, 23 Apr 2025 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+vNciFCXxQOI4WsPhOrOlaGnUypKIlCRCLTACUGOqQ=;
	b=hq7tIpZ947IAI94Fs75KbMSAejYpMmWjSsYMhZX89xh3MC1eMBtdFrBCAkT7wlMYrGY16X
	HV/w3Oj+7d5O5sA435hBUj3tporIai4HTTPemZitC29IpUfpYy/uwiqyNzGMF5f2m/IU6P
	GF+jMqSnYZ7vnGT2HoRiyFYNg9lTUOI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+vNciFCXxQOI4WsPhOrOlaGnUypKIlCRCLTACUGOqQ=;
	b=hq7tIpZ947IAI94Fs75KbMSAejYpMmWjSsYMhZX89xh3MC1eMBtdFrBCAkT7wlMYrGY16X
	HV/w3Oj+7d5O5sA435hBUj3tporIai4HTTPemZitC29IpUfpYy/uwiqyNzGMF5f2m/IU6P
	GF+jMqSnYZ7vnGT2HoRiyFYNg9lTUOI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB8CC13691;
	Wed, 23 Apr 2025 15:58:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8vvfKRAOCWiuCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:58:08 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/12] btrfs: rename ret to status in btrfs_submit_chunk()
Date: Wed, 23 Apr 2025 17:57:18 +0200
Message-ID: <184b567efa1802c36ff7c9c8578b6097e8fe9abb.1745422901.git.dsterba@suse.com>
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
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

We're using 'status' for the blk_status_t variables, rename 'ret' so we
can use it for proper return type.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a534c6793e38fa..7ea56856e9dedc 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -674,7 +674,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	bool use_append = btrfs_use_zone_append(bbio);
 	struct btrfs_io_context *bioc = NULL;
 	struct btrfs_io_stripe smap;
-	blk_status_t ret;
+	blk_status_t status;
 	int error;
 
 	if (!bbio->inode || btrfs_is_data_reloc_root(inode->root))
@@ -686,7 +686,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
 				&bioc, &smap, &mirror_num);
 	if (error) {
-		ret = errno_to_blk_status(error);
+		status = errno_to_blk_status(error);
 		btrfs_bio_counter_dec(fs_info);
 		goto end_bbio;
 	}
@@ -700,7 +700,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 
 		split = btrfs_split_bio(fs_info, bbio, map_length);
 		if (IS_ERR(split)) {
-			ret = errno_to_blk_status(PTR_ERR(split));
+			status = errno_to_blk_status(PTR_ERR(split));
 			btrfs_bio_counter_dec(fs_info);
 			goto end_bbio;
 		}
@@ -715,8 +715,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	if (bio_op(bio) == REQ_OP_READ && is_data_bbio(bbio)) {
 		bbio->saved_iter = bio->bi_iter;
 		error = btrfs_lookup_bio_sums(bbio);
-		ret = errno_to_blk_status(error);
-		if (ret)
+		status = errno_to_blk_status(error);
+		if (status)
 			goto fail;
 	}
 
@@ -749,14 +749,14 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 				goto done;
 
 			error = btrfs_bio_csum(bbio);
-			ret = errno_to_blk_status(error);
-			if (ret)
+			status = errno_to_blk_status(error);
+			if (status)
 				goto fail;
 		} else if (use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
-			ret = btrfs_alloc_dummy_sum(bbio);
-			if (ret)
+			status = btrfs_alloc_dummy_sum(bbio);
+			if (status)
 				goto fail;
 		}
 	}
@@ -777,10 +777,10 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
 		ASSERT(remaining);
 
-		btrfs_bio_end_io(remaining, ret);
+		btrfs_bio_end_io(remaining, status);
 	}
 end_bbio:
-	btrfs_bio_end_io(bbio, ret);
+	btrfs_bio_end_io(bbio, status);
 	/* Do not submit another chunk */
 	return true;
 }
-- 
2.49.0


