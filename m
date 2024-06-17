Return-Path: <linux-btrfs+bounces-5748-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04D90A18A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFF1F21D29
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jun 2024 01:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343ED4C6F;
	Mon, 17 Jun 2024 01:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Huo82bO9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Huo82bO9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E133233
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Jun 2024 01:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586181; cv=none; b=SadFR1GEnA8FrLLtiKbjJhLYYpAGd6/A30pfmBmjCFl2pg3vJRPqeDA/7glCCYpggiMvHgW+qrvcSCnS1Ze2MsmUqoDeJhFVEUMFHw60/+qe9/PGXjh5mViidOqTU26MZBbwLtUZmDkOF7hbJi0MENUnZZ9DftsoBhFAwV534xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586181; c=relaxed/simple;
	bh=Ju/Rlpyr/YMJaAJ1/yBGgSyFDUVREH3hOI40rw+SvqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtguNpxOP7dbUGS4Ki0jJZscyS3lZM3v9/2Dx0We5LGCVJfuwleLeUrtnTvWc0ta4Th4ZJMwvHag9YZWioRt6ovjC8ChREx/Mi0hZZeJhD/Rxlz2ZdYDXAFZ/4YdZ0Du8poF23SFdSOQN2IAJ1VHEVPvd94dww7JhOkAvRq2Gxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Huo82bO9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Huo82bO9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB3D379D4;
	Mon, 17 Jun 2024 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718586175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0dEv9IgFvnh1SgkWkFeMUwtHO2KTCSFyJ4BxvPdzShA=;
	b=Huo82bO970HEP/PHqNDJ5BkC0PlIepfKlOfvyN5aqo84uZPkesEuAij1UWnIUyWlJsCcBq
	IWCnqC9ezdoZO0cMlgAASIav0k6gX9NyDVteWqKcqnledbRcSHxgYBOnEQdXW5jaQgXiVd
	8uQjHLXVJQ2qygUKvVVwGnDiqj2R8J4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Huo82bO9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718586175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0dEv9IgFvnh1SgkWkFeMUwtHO2KTCSFyJ4BxvPdzShA=;
	b=Huo82bO970HEP/PHqNDJ5BkC0PlIepfKlOfvyN5aqo84uZPkesEuAij1UWnIUyWlJsCcBq
	IWCnqC9ezdoZO0cMlgAASIav0k6gX9NyDVteWqKcqnledbRcSHxgYBOnEQdXW5jaQgXiVd
	8uQjHLXVJQ2qygUKvVVwGnDiqj2R8J4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F60C13AAA;
	Mon, 17 Jun 2024 01:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7XzCCT6Lb2YtdQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 17 Jun 2024 01:02:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com
Subject: [PATCH RFC] btrfs: scrub: handle RST lookup error correctly
Date: Mon, 17 Jun 2024 10:32:28 +0930
Message-ID: <8f5cb1da3e9bea64b133870d1d91e7818b6f2217.1718586112.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.988];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9EB3D379D4
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

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
Instead of going calc_sector_number() directly which expects a non-empty
bio, do an early bio length check first.

If the bio is empty, just grab the sector_nr using bi_sector, as the
bio never really got submitted bi_sector is untouched and reliable.
Then mark all the sectors until the stripe end as error.
Otherwise go the regular routine.

By this we have an extra safenet for possible RST related errors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
REASON FOR RFC:

This is only a fix for the direct cause, that we do not have proper
error handling for rst related errors.

But to be honest, I'm not that confident with the manual
btrfs_map_block() call inside scrub.

We may want to do the call before we allocate a new bbio, so that we can
avoid such empty bbio.

Furthermore we're still not sure why the RST lookup failed.
During the scrub we should have prevented a new transaction to be
committed, thus the RST lookup should match with extent_sector_bitmap,
but that's not the case.

Anyway for now just add a safenet until we pin down the root cause of
the RST error, then determine if we need to btrfs_map_block() at the
current location.
---
 fs/btrfs/scrub.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 188a9c42c9eb..fdfbd71c8682 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1099,15 +1099,35 @@ static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 	struct bio_vec *bvec;
-	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int sector_nr;
 	int num_sectors;
 	u32 bio_size = 0;
 	int i;
 
-	ASSERT(sector_nr < stripe->nr_sectors);
 	bio_for_each_bvec_all(bvec, &bbio->bio, i)
 		bio_size += bvec->bv_len;
-	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
+	/*
+	 * For RST scrub we can error out with empty bbio. In that case mark
+	 * the range until the end as error.
+	 */
+	if (unlikely(bio_size == 0)) {
+		/*
+		 * Since the bbio didn't really get submitted, the logical
+		 * (bi_sector) should be untouched.
+		 */
+		u64 logical = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+
+		ASSERT(logical >= stripe->logical &&
+		       logical < stripe->logical + BTRFS_STRIPE_LEN);
+		ASSERT(bbio->bio.bi_status);
+		sector_nr = (logical - stripe->logical) >>
+			    bbio->fs_info->sectorsize_bits;
+		num_sectors = stripe->nr_sectors - sector_nr;
+	} else {
+		sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+		ASSERT(sector_nr < stripe->nr_sectors);
+		num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
+	}
 
 	if (bbio->bio.bi_status) {
 		bitmap_set(&stripe->io_error_bitmap, sector_nr, num_sectors);
-- 
2.45.2


