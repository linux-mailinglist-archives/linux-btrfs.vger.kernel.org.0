Return-Path: <linux-btrfs+bounces-5776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E641B90C312
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 07:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F79B22574
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 05:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A51C69C;
	Tue, 18 Jun 2024 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sAwexzgi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sAwexzgi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F9FC18
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2024 05:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688524; cv=none; b=NJ/tpnHYZgOsQ1JfZWsqZLF8DjJol5mCgMg+RuoFlCq8PckVJSLRx4asxOnAJRYT37UscIFtDlySrBi+urNZrbIcJz7wrwoE4R51YmYSHJN3m05ijS1xD0wf2eHYGPPQY6JaZ432/9r0k5uFyMCs0h21T/BcQog8u8fD2Wn+CuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688524; c=relaxed/simple;
	bh=NROnEcYmXe9OgTsdfmVj0z9pG2CMVoNE25bvP6j1kRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQggIPjSAx8X+NatbpsKBocBgfmrqBClje3jBwEV/KIcfUZ6HqG0Ev2FSVdF1Gizi1rMP4CHwPGsOZcogg/DthYPCkCTHMoGHzvASAjtmEW8AG+oMvwnSbKvuny1Mn8cNSBXjNnqku+PugHoJ2j+Z5TBCed/q/KZaDBJDrWVpgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sAwexzgi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sAwexzgi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 66FF821AE5;
	Tue, 18 Jun 2024 05:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718688520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/L+uRovF3fUT2dT3DDESjNBcL5xHWjWw6Izckaay0Tc=;
	b=sAwexzgibbfz2/IJZ1HrPzs9ddcbfJMqQKf34TnWuMG6cpqVkaPARJVBc5JyV+kDOvSv/C
	wzPM5zTgduMWYF2burpL5S3g36ptP/B74jTcMA5AJY0NQ39SLzfSzifrl39/dJN6C7O6a7
	XEHtWpv2FxUVGBL71F2fl49Fuhg9NA4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sAwexzgi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718688520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/L+uRovF3fUT2dT3DDESjNBcL5xHWjWw6Izckaay0Tc=;
	b=sAwexzgibbfz2/IJZ1HrPzs9ddcbfJMqQKf34TnWuMG6cpqVkaPARJVBc5JyV+kDOvSv/C
	wzPM5zTgduMWYF2burpL5S3g36ptP/B74jTcMA5AJY0NQ39SLzfSzifrl39/dJN6C7O6a7
	XEHtWpv2FxUVGBL71F2fl49Fuhg9NA4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3071A13A7F;
	Tue, 18 Jun 2024 05:28:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRpPNQYbcWYSTwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 18 Jun 2024 05:28:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com
Subject: [PATCH v2] btrfs: scrub: handle RST lookup error correctly
Date: Tue, 18 Jun 2024 14:58:20 +0930
Message-ID: <67e8eaaf47d261c3fb3f26dd1463c06dd3412d5e.1718688466.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66FF821AE5
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
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
v2:
- Only mark the current sector as error and continue to the next sector
  This would make the error handling of RST error more accurate, other
  than marking all the remaining sectors as error.

RFC->v1:
- Fix the bug by altering the btrfs_map_block()
  Now we have no chance to create empty bbio, and much easier to handle
  the RST error.
---
 fs/btrfs/scrub.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 188a9c42c9eb..35cf23a3a432 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1688,20 +1688,24 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
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
+				set_bit(i, &stripe->io_error_bitmap);
+				set_bit(i, &stripe->error_bitmap);
+				continue;
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
-- 
2.45.2


