Return-Path: <linux-btrfs+bounces-13326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C796A994A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 18:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90331BC5C66
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E112820C8;
	Wed, 23 Apr 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HRvKZ60x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HRvKZ60x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45142381AF
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423882; cv=none; b=EGT8Iu9cIiX+mNeeWdXKCbuBu4RQ/ZfcA4elYNL77SO45FNsme8yR1sXeSeyVjZny84xdE5762rqMl07IxCg2fcX0FmO+Im91Skk9KhQRZQ6EI/SkGsInsGD6bMtzdmb2JsR7qhcJi3ptnZ/eVEeRqBWGTdfBTI2WMTjOYDUU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423882; c=relaxed/simple;
	bh=t4hH4ZgO1rb5I+vnHkrdmSeoRvq6363+7jEYC5nQeUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKaFtnywRAcxuN5H3kIiLLMBYQ13ybWdMGcQ7QGswLujlKC6/Q2wzetCte2IkPiepDH8D5fPU6FZouvK/0VLVFA4dQKx0PE0vQeZZW6Zq6VzaPmaud7TWd6stC2xkoki5mI5phl4jQM3DRvytRUNQ1Y9AzZpsj51G5aAQ8NT/eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HRvKZ60x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HRvKZ60x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D6781F38D;
	Wed, 23 Apr 2025 15:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec0VhMTS/JU+6rMNBxP+M8TcrN+lyEp1AOMbwHhMFzI=;
	b=HRvKZ60xRZw2dw1f2msQKI5A360YxPgHph3J3PMiCdM5Z5ag9nIL0EuZ+GLPWeTtQewOAU
	tz6smax1Frh6Krn7WA3mafjRmvWuMYg/t3ti8VYKXRYjJnthxUWCJ+jOgh2+mPhFwD6Sbk
	rGGsIG0y8Ae7+DnHDAWG3o2sknsms0s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745423878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec0VhMTS/JU+6rMNBxP+M8TcrN+lyEp1AOMbwHhMFzI=;
	b=HRvKZ60xRZw2dw1f2msQKI5A360YxPgHph3J3PMiCdM5Z5ag9nIL0EuZ+GLPWeTtQewOAU
	tz6smax1Frh6Krn7WA3mafjRmvWuMYg/t3ti8VYKXRYjJnthxUWCJ+jOgh2+mPhFwD6Sbk
	rGGsIG0y8Ae7+DnHDAWG3o2sknsms0s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B9C13691;
	Wed, 23 Apr 2025 15:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9Un5HAYOCWikCQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 23 Apr 2025 15:57:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 05/12] btrfs: change return type of btrfs_bio_csum() to int
Date: Wed, 23 Apr 2025 17:57:17 +0200
Message-ID: <d0552ad5c0e3be56fabfddb620c937e60653137d.1745422901.git.dsterba@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The type blk_status_t is from block layer and not related to checksums
in our context. Use int internally and do the conversions to blk_status_t
as needed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4ceb1bd511df1e..a534c6793e38fa 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -512,11 +512,11 @@ static void btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 	}
 }
 
-static blk_status_t btrfs_bio_csum(struct btrfs_bio *bbio)
+static int btrfs_bio_csum(struct btrfs_bio *bbio)
 {
 	if (bbio->bio.bi_opf & REQ_META)
-		return errno_to_blk_status(btree_csum_one_bio(bbio));
-	return errno_to_blk_status(btrfs_csum_one_bio(bbio));
+		return btree_csum_one_bio(bbio);
+	return btrfs_csum_one_bio(bbio);
 }
 
 /*
@@ -543,11 +543,11 @@ static void run_one_async_start(struct btrfs_work *work)
 {
 	struct async_submit_bio *async =
 		container_of(work, struct async_submit_bio, work);
-	blk_status_t ret;
+	int ret;
 
 	ret = btrfs_bio_csum(async->bbio);
 	if (ret)
-		async->bbio->bio.bi_status = ret;
+		async->bbio->bio.bi_status = errno_to_blk_status(ret);
 }
 
 /*
@@ -748,7 +748,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
 				goto done;
 
-			ret = btrfs_bio_csum(bbio);
+			error = btrfs_bio_csum(bbio);
+			ret = errno_to_blk_status(error);
 			if (ret)
 				goto fail;
 		} else if (use_append ||
-- 
2.49.0


