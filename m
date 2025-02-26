Return-Path: <linux-btrfs+bounces-11866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F92FA45ACD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88103A7FD6
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF264268FD6;
	Wed, 26 Feb 2025 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LNaRp6bL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LNaRp6bL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C882686B7
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563550; cv=none; b=XZ//ePk/052jGouGKxzEMlNdFzIuJZdmN4xidAsDSVze8kinjr5hNNCFCybZy+RdLHOD9gW33nKiuBEcYzPJFGEKCYXN9Fiti8CKTNFwVhMPjFjXcTFuFC9c4pY58hte3sqfDCZIDN6148kP6KrIjn/X2oUe+fOhyJjn873uS4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563550; c=relaxed/simple;
	bh=u1kWw2AyWiTLXoDZeieGSbmS2DTjV6J7Mnhv4BAaBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PG/W0jVRuJpiRyS5txmAish9T2UT+PUrJTU6piFM2Mzl0y4QdLK0i9bouC3hbHVi6/ml/tVumAz7cEN/D7Y+30W49P0WvTnDV9puBrC04V+AP7rfE3QC+5E5/pDgTY1UgkIYAHBaPn9ed6ZRqJgMsmppJjE/cWhGG7TfmDiGI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LNaRp6bL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LNaRp6bL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9F191F453;
	Wed, 26 Feb 2025 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z79o/YwEGHu0MphdKGGiNUg8p0dIwNrLYrznfinUJNg=;
	b=LNaRp6bLW4A79SpQXUw1Cm5glAWl826xhwNRxUPkpM0Sn+Y1dyjQpW45AafGKjMdnFaDlU
	Z8WmONLb7Rt+U/6nErefRsw9EU9z86KuDkCrCCJV7avqpbS4CHHPCWtDWYCQ8a/rXHs4ak
	/8MVy/8r0OBhe021jO7TgqEtZr+2w/g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740563501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z79o/YwEGHu0MphdKGGiNUg8p0dIwNrLYrznfinUJNg=;
	b=LNaRp6bLW4A79SpQXUw1Cm5glAWl826xhwNRxUPkpM0Sn+Y1dyjQpW45AafGKjMdnFaDlU
	Z8WmONLb7Rt+U/6nErefRsw9EU9z86KuDkCrCCJV7avqpbS4CHHPCWtDWYCQ8a/rXHs4ak
	/8MVy/8r0OBhe021jO7TgqEtZr+2w/g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B37AF13A53;
	Wed, 26 Feb 2025 09:51:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G0bPKy3kvmdmYgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 26 Feb 2025 09:51:41 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 22/27] btrfs: use BTRFS_PATH_AUTO_FREE in btrfs_lookup_bio_sums()
Date: Wed, 26 Feb 2025 10:51:41 +0100
Message-ID: <175ae389f9dc227ddaff167a1ec01b4695437513.1740562070.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740562070.git.dsterba@suse.com>
References: <cover.1740562070.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the trivial pattern for path auto free, initialize at the
beginning and free at the end.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file-item.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 2f5e6cad8f55..e0475465ba51 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -341,7 +341,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
-	struct btrfs_path *path;
+	BTRFS_PATH_AUTO_FREE(path);
 	const u32 sectorsize = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	u32 orig_len = bio->bi_iter.bi_size;
@@ -373,10 +373,8 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 
 	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
 		bbio->csum = kmalloc_array(nblocks, csum_size, GFP_NOFS);
-		if (!bbio->csum) {
-			btrfs_free_path(path);
+		if (!bbio->csum)
 			return BLK_STS_RESOURCE;
-		}
 	} else {
 		bbio->csum = bbio->csum_inline;
 	}
@@ -444,7 +442,6 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		bio_offset += count * sectorsize;
 	}
 
-	btrfs_free_path(path);
 	return ret;
 }
 
-- 
2.47.1


