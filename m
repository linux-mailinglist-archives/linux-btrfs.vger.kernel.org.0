Return-Path: <linux-btrfs+bounces-18934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8913C56A28
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DBF42135E
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E762330B0B;
	Thu, 13 Nov 2025 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gk8LHruY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Gk8LHruY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0AD32ED20
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026281; cv=none; b=pFUAkdzm0n4oEKKpZBR6gFQlTetSU0CvZRCEA1plDw4uAO59SohuatrxMAkaeMuddtB1suEzInKH+kdhRnDIjfbHlr9ysYgokYaWVerVHz4hyFgtM+j9DI1ZO5Tg2vw3uK3MbcUNUUNW8ZQO1OBWHM1xBIU0gTsHwQF00huCI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026281; c=relaxed/simple;
	bh=roGW0J1nkok8VY2tkIAysrKT4AC3ihAMuoWBge8IYW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oo1rrG3l3dUfEpjQ9vowHZLaERQuJN8K5iqL7PmynM3TokWRRoyZB653GF/IJPLsEsfXtko6SMpe+0emsxkHfxF2rPpvVDI0dsqSoXFkCbqlIys15JAhL5AG4qBD8ekXG81M0aq5du54BaMCKmgrEz3C/DPMD/0bIdADr+w4bMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gk8LHruY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Gk8LHruY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9221F7D3;
	Thu, 13 Nov 2025 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763026276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zVnqbEqTlQ0N33trDfhQPbhXbYt0EJdQnaYBCHpvu9U=;
	b=Gk8LHruYLhl6Sv/7nhIjbLykUyuhAfmlUskpzJi/5f+2F+F2cmYXKyzmuEfQWZodJekwsp
	hGNPcOnV0UEo9SUwcqUjyXtBr0QPsmdhuIez3aaLYHENggSC+sZqQ6h8fqJeMuhIPLCYwv
	emSjtxnMWS1TplYE6wOZ9YKJzmQvY0Y=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763026276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zVnqbEqTlQ0N33trDfhQPbhXbYt0EJdQnaYBCHpvu9U=;
	b=Gk8LHruYLhl6Sv/7nhIjbLykUyuhAfmlUskpzJi/5f+2F+F2cmYXKyzmuEfQWZodJekwsp
	hGNPcOnV0UEo9SUwcqUjyXtBr0QPsmdhuIez3aaLYHENggSC+sZqQ6h8fqJeMuhIPLCYwv
	emSjtxnMWS1TplYE6wOZ9YKJzmQvY0Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 443273EA61;
	Thu, 13 Nov 2025 09:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dRcDEGSlFWnHdQAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 13 Nov 2025 09:31:16 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>,
	Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: simplify async csum synchronization
Date: Thu, 13 Nov 2025 10:31:09 +0100
Message-ID: <20251113093110.2619692-1-neelx@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

We don't need the completion csum_done which marks the csum work
has been executed. We can simply flush_work() instead.

This way we can slim down the btrfs_bio structure by 32 bytes matching
it's size to what it used to be before introducing the async csums.
Hence not making any change with respect to the structure size.
---
This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
for-next and can be squashed into it.
---
 fs/btrfs/bio.c       | 2 +-
 fs/btrfs/bio.h       | 1 -
 fs/btrfs/file-item.c | 6 +++---
 3 files changed, 4 insertions(+), 5 deletions(-)

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
index 72be3ede0edf..3e9241f360c8 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -792,7 +792,6 @@ static void csum_one_bio_work(struct work_struct *work)
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
 	ASSERT(bbio->async_csum == true);
 	csum_one_bio(bbio, &bbio->csum_saved_iter);
-	complete(&bbio->csum_done);
 }
 
 /*
@@ -805,6 +804,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct bio *bio = &bbio->bio;
 	struct btrfs_ordered_sum *sums;
+	struct workqueue_struct *wq;
 	unsigned nofs_flag;
 
 	nofs_flag = memalloc_nofs_save();
@@ -825,11 +825,11 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
 		csum_one_bio(bbio, &bbio->bio.bi_iter);
 		return 0;
 	}
-	init_completion(&bbio->csum_done);
 	bbio->async_csum = true;
 	bbio->csum_saved_iter = bbio->bio.bi_iter;
 	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
-	schedule_work(&bbio->csum_work);
+	wq = bio->bi_opf & REQ_META? fs_info->endio_meta_workers: fs_info->endio_workers;
+	queue_work(wq, &bbio->csum_work);
 	return 0;
 }
 
-- 
2.43.0


