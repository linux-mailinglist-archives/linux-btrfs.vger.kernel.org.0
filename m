Return-Path: <linux-btrfs+bounces-5753-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450390A384
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 07:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B752B21255
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 05:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D556181CE9;
	Mon, 17 Jun 2024 05:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LVTaqsBn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d0k/URMd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F2929410
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718603948; cv=none; b=pJvtLont7Rc8Nb2U4XobYVV1jCUWi3EKg2S5ZdZQUbIBm9tP/odi6/kM1UnUirm6D4a7LQTNEojlHitFA/JiRZRvHrzrHROTXKX9jm9ukRj8bD3h7Qf0tJut1J5en+L7SYAgIpZBDPmGkAKAnGD4DomNBW2xoADaw+mkGm0ISwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718603948; c=relaxed/simple;
	bh=6SjAxcP+RKPAlZ/OuzjAUVALnvzCnOSvMyIjpTZA1Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtH2G0B2WGYgfOtdBuHnCGS6HEwot943cYZ2QUexCy7Jb4G40dk4UyMQPDwZaV8sa3LWSErwbNFy4WLnPKOS/4QQreaSYE6/aC5aU8qfzmZ10+I+51iYs371xYswSemBeyERlUokFOgn2oMM9da+lVnz5BcJOy+GDji3DWJ66SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LVTaqsBn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d0k/URMd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD9B737D2E;
	Mon, 17 Jun 2024 05:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718603944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QaY0VrF1QSLQ1LEoce+WmM08wd2qRxemARN3zI+wK7c=;
	b=LVTaqsBnX2i2e6dGi/x4LEcFJF/q0PMyHky9LH2+KdH4xzVhRtSh9Ws0939/FjtD7nTIzb
	x3EenzsFTTzidjrODhDneBiywGexdUyawuvA5eclO5pFHrd9dKcYWJ/H8j8xAX7VuBvCrh
	nKqnie5DHWNHKcd2yi96S6bfXgoiRzI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="d0k/URMd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718603943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QaY0VrF1QSLQ1LEoce+WmM08wd2qRxemARN3zI+wK7c=;
	b=d0k/URMdqVVp6i0EUbD9hA7UGV0DdofOIuQ5ifTYduJ+K8EGdPDp2qT5t0fVtNdAybmeNC
	6+rvNqwl01UruKk86NcQ+1KECf9aqlH4LLBKQZVHZooFiTEBvdgG9XuYQgYPuYAyz7vOcp
	m3lQUYFv3xHuj8/JuNInxQ4RPWSU1Hk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993C2139AB;
	Mon, 17 Jun 2024 05:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJRhE6bQb2Y+NwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 17 Jun 2024 05:59:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com
Subject: [PATCH] btrfs: scrub: handle RST lookup error correctly
Date: Mon, 17 Jun 2024 15:28:44 +0930
Message-ID: <b3980b6129aa8cb3326cb1c0e7a130bf622afac6.1718603905.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD9B737D2E
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

[BUG]
When running btrfs/060 with forced RST feature, it would crash the
following ASSERT() inside scrub_read_endio():

	ASSERT(sector_nr < stripe->nr_sectors);

Before that, we would have tree dump from
btrfs_get_raid_extent_offset(), as we failed to find the RST entry for
the range.

[CAUSE]
Inside scrub_submit_extent_sector_read() every time we allocated a new
bbio we immediate call btrfs_map_block() to make sure there is some RST
range covering the scrub target.

But if btrfs_map_block() failed, we immediately call endio for the bbio,
meanwhile since the bbio is newly allocated, it's completely empty.

Then inside scrub_read_endio(), we go through the bvecs to find
the sector number (as bi_sector is no longer reliable if the bio is
submitted to lower layers).

And since the bio is empty, such bvecs iteration would not find any
sector matching the sector, and return sector_nr == stripe->nr_sectors,
triggering the ASSERT().

[FIX]
Instead of calling btrfs_map_block() after allocating a new bbio, call
btrfs_map_block() first.

Since our only objective of calling btrfs_map_block() is only to update
stripe_len, there is really no need to do that after btrfs_alloc_bio().

This new timing would avoid the problem of handling empty bbio
completely, and in fact fixes a possible race window for the old code,
where if the submission thread is the only owner of the pending_io, the
scrub would never finish (since we didn't decrease the pending_io
counter).

Although the root cause of RST lookup failure still needs to be
addressed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
In fact, with this bug patched, I still hit an RST related problem, and
it's from OE finishing, thus I believe there are still other bugs in the
RST related code.

Changelog:
RFC->v1:
- Fix the bug by altering the btrfs_map_block()
  Now we have no chance to create empty bbio, and much easier to handle
  the RST error.
---
 fs/btrfs/scrub.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 188a9c42c9eb..70b1f7c3047e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,20 +1688,25 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					    (i << fs_info->sectorsize_bits);
 			int err;
 
+			io_stripe.is_scrub = true;
+			stripe_len = (nr_sectors - i) << fs_info->sectorsize_bits;
+			/*
+			 * For RST cases, we need to manually split the bbio to
+			 * follow the RST boundary.
+			 */
+			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+					&stripe_len, &bioc, &io_stripe, &mirror);
+			btrfs_put_bioc(bioc);
+			if (err < 0) {
+				/* Mark the remaining sectors as error. */
+				bitmap_set(&stripe->io_error_bitmap, i, nr_sectors - i);
+				bitmap_set(&stripe->error_bitmap, i, nr_sectors - i);
+				goto out;
+			}
+
 			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
 					       fs_info, scrub_read_endio, stripe);
 			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
-
-			io_stripe.is_scrub = true;
-			err = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-					      &stripe_len, &bioc, &io_stripe,
-					      &mirror);
-			btrfs_put_bioc(bioc);
-			if (err) {
-				btrfs_bio_end_io(bbio,
-						 errno_to_blk_status(err));
-				return;
-			}
 		}
 
 		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
@@ -1713,6 +1718,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 		btrfs_submit_bio(bbio, mirror);
 	}
 
+out:
 	if (atomic_dec_and_test(&stripe->pending_io)) {
 		wake_up(&stripe->io_wait);
 		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
-- 
2.45.2


