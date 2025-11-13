Return-Path: <linux-btrfs+bounces-18937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D00C56CEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 11:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195D34E9F88
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000512FDC30;
	Thu, 13 Nov 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j7uLGewB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j7uLGewB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AA14AD20
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029061; cv=none; b=sNZ9K+hI0pTKu5BRAfYrjcrlkz+kR+nwGbbpzkmQpdY9TL/vYQo5Ky+Qjr8hXcPkhnfloGILP6xwkj92PTkMgNOvIqnT57+8Kh+SM25ahlkgBFtFP6Gm7uC+HNomDHB204votpdNttf8W63/IjhBgk8dCkWOTqMJjlfL59sSFO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029061; c=relaxed/simple;
	bh=pT1+a8UnyQQwWALRqvV+mDSdj+vBXw9UCY9HpsgTIOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBx3ceDxbLjgbrYkPjcB0SO4yxuBmRDdp5sFmAk/MJjq3ug13AZi/juiW+RXO1V1Pc9sKRs64d+O8MOCPj7xL3s/sAnHKqLfVnmQvFrVMAiTEGc7K5ta8Hyg07su7E6uW5eCDbOXWX9KnwSBE8yGH7/Oyzgzu8lurqyGrvlhTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j7uLGewB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j7uLGewB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE87C1F80F;
	Thu, 13 Nov 2025 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763029057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tu4GchAU3/yHNzR3tzRAq9UZ80NgMWJ7Ch8TO55ZiDo=;
	b=j7uLGewBRU1WDhewESRiaVrhzcnJkgyfe6YrJvtezh2zH07P97iZFU0gYX2DVBq5tXu48w
	NBFZhft7qRgO25/LmUIBMmLtgjjwO3I9w0rRT1MMnaFo/Ve4/lJ8VdNL/iZ/zQ48/NWNtg
	wjFlwTNDtjI155VhG7XtInwZxw+XqnY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=j7uLGewB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763029057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tu4GchAU3/yHNzR3tzRAq9UZ80NgMWJ7Ch8TO55ZiDo=;
	b=j7uLGewBRU1WDhewESRiaVrhzcnJkgyfe6YrJvtezh2zH07P97iZFU0gYX2DVBq5tXu48w
	NBFZhft7qRgO25/LmUIBMmLtgjjwO3I9w0rRT1MMnaFo/Ve4/lJ8VdNL/iZ/zQ48/NWNtg
	wjFlwTNDtjI155VhG7XtInwZxw+XqnY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D214C3EA61;
	Thu, 13 Nov 2025 10:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z6WUMkCwFWnZJAAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 13 Nov 2025 10:17:36 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: simplify async csum synchronization
Date: Thu, 13 Nov 2025 11:17:30 +0100
Message-ID: <20251113101731.2624000-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EE87C1F80F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

We don't need the redundant completion csum_done which marks the
csum work has been executed. We can simply flush_work() instead.

This way we can slim down the btrfs_bio structure by 32 bytes matching
it's size to what it used to be before introducing the async csums.
Hence not making any change with respect to the structure size.
---
This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
for-next and can be squashed into it.

v2: metadata is not checksummed here so use the endio_workers workqueue
    unconditionally. Thanks to Qu Wenruo.
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/bio.h       | 1 -
 fs/btrfs/file-item.c | 4 +---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a73652b8724a..fd6e4278a62f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -106,7 +106,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	ASSERT(in_task());
 
 	if (bbio->async_csum)
-		wait_for_completion(&bbio->csum_done);
+		flush_work(&bbio->csum_work);
 
 	bbio->bio.bi_status = status;
 	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index deaeea3becf4..0b09d9122fa2 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -57,7 +57,6 @@ struct btrfs_bio {
 			struct btrfs_ordered_extent *ordered;
 			struct btrfs_ordered_sum *sums;
 			struct work_struct csum_work;
-			struct completion csum_done;
 			struct bvec_iter csum_saved_iter;
 			u64 orig_physical;
 		};
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 72be3ede0edf..fb7d87da87ea 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -792,7 +792,6 @@ static void csum_one_bio_work(struct work_struct *work)
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
 	ASSERT(bbio->async_csum == true);
 	csum_one_bio(bbio, &bbio->csum_saved_iter);
-	complete(&bbio->csum_done);
 }
 
 /*
@@ -825,11 +824,10 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 		csum_one_bio(bbio, &bbio->bio.bi_iter);
 		return 0;
 	}
-	init_completion(&bbio->csum_done);
 	bbio->async_csum = true;
 	bbio->csum_saved_iter = bbio->bio.bi_iter;
 	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
-	schedule_work(&bbio->csum_work);
+	queue_work(fs_info->endio_workers, &bbio->csum_work);
 	return 0;
 }
 
-- 
2.43.0


