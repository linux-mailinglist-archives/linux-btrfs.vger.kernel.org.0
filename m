Return-Path: <linux-btrfs+bounces-21798-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBkDNyrYl2m79QIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21798-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:42:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731B164705
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B433039EC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 03:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243B2E8E09;
	Fri, 20 Feb 2026 03:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OvkGKgZB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tZf63gdd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFFF2DECDE
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558926; cv=none; b=cTE3GiOrKXrb0Mn/DO+pIaZoOGU35VsF1MKc3ePI3yIh8RBCadj25axuaQQzzGafLgUR3RUo9JqFcW06jCrDH+55GANKYUsYF/RveqItsijsnNe+5dH1ty8sGPF4OvfUenXbPHQmEUFuD+wtKgxlaNm1hSVO/w3rez7kCr0FfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558926; c=relaxed/simple;
	bh=ytEPq+g6EKkKRAf8dZGrabH0HP4/3Q/hp606SoN6gR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TulnMjRmKWT6WtkkEBQzM2UV0nSFsr6CpOddBdTQC0zjrU0P3FqHEQz6k56YDNWsuq0jsTaINFgCPD3fx9uuqmSd43ULLtRQwVZGfmXnmpQi7pitdhIq9Hw6zCBb/hs4NQgxZt6TGVwbm+4/f1TeqExNfoCFw6ynlVFi91IY2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OvkGKgZB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tZf63gdd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D56955BCC7
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771558917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyjGptBbo+/uERrLTdtjlpwuOF+9YrtwXhGoYU0uPnw=;
	b=OvkGKgZBwAIf3gnJhKBWCDqMLY7klbLUP/TMqwPGvu2WTexflwbhF7klewf/4vfD/4Y9SL
	Z41BCkQ4y+P/EMpCJIuhJBvjG5x8B0g6S58ShwsJAMucKgCXDEBoPv5DVRNSDtB8K0PC4/
	qeYSPwXnG9QkmhxCZmqH81FYU639x6s=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tZf63gdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771558916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LyjGptBbo+/uERrLTdtjlpwuOF+9YrtwXhGoYU0uPnw=;
	b=tZf63gddVDhbT/76bezzJkh7AJPXMHpgLYvD93Rnpsi58jKs9boZ2Go3W98+XWjpkLi7bk
	Y5aOH4L+oCqtwmiuKUNQjMD1l8u30fhR1WoXsR++wtsswakMzNM7+qyKXD/s7sj1OLqxfO
	qYqeSrXr+49/LSnLc613HvMJ+c1Jkfo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1488A3EA65
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eLBUMgPYl2nODgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: introduce a common helper to calculate the size of a bio
Date: Fri, 20 Feb 2026 14:11:50 +1030
Message-ID: <4392c94fea9644702e3985c30cf0a30c434aa3d5.1771558832.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771558832.git.wqu@suse.com>
References: <cover.1771558832.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21798-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 6731B164705
X-Rspamd-Action: no action

We have several call sites doing the same work to calculate the size of
a bio:

	struct bio_vec *bvec;
	u32 bio_size = 0;
	int i;

	bio_for_each_bvec_all(bvec, bio, i)
		bio_size += bvec->bv_len;

We can use a common helper instead of open-coding it everywhere.

This also allows us to constify the @bio_size variables used in all the
call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/misc.h   | 15 +++++++++++----
 fs/btrfs/raid56.c |  9 ++-------
 fs/btrfs/scrub.c  | 22 ++++------------------
 3 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
index 12c5a9d6564f..189c25cc5eff 100644
--- a/fs/btrfs/misc.h
+++ b/fs/btrfs/misc.h
@@ -52,15 +52,22 @@ static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
 	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
 	     bio_advance_iter_single((bio), (iter), (blocksize)))
 
-/* Initialize a bvec_iter to the size of the specified bio. */
-static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
+/* Can only be called on a non-cloned bio. */
+static inline u32 bio_get_size(struct bio *bio)
 {
 	struct bio_vec *bvec;
-	u32 bio_size = 0;
+	u32 ret = 0;
 	int i;
 
 	bio_for_each_bvec_all(bvec, bio, i)
-		bio_size += bvec->bv_len;
+		ret += bvec->bv_len;
+	return ret;
+}
+
+/* Initialize a bvec_iter to the size of the specified bio. */
+static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
+{
+	const u32 bio_size = bio_get_size(bio);
 
 	return (struct bvec_iter) {
 		.bi_sector = 0,
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 230dd93dad6e..da2f57cbf07c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1651,12 +1651,7 @@ static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
 static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bio)
 {
 	int total_sector_nr = get_bio_sector_nr(rbio, bio);
-	u32 bio_size = 0;
-	struct bio_vec *bvec;
-	int i;
-
-	bio_for_each_bvec_all(bvec, bio, i)
-		bio_size += bvec->bv_len;
+	const u32 bio_size = bio_get_size(bio);
 
 	/*
 	 * Since we can have multiple bios touching the error_bitmap, we cannot
@@ -1664,7 +1659,7 @@ static void rbio_update_error_bitmap(struct btrfs_raid_bio *rbio, struct bio *bi
 	 *
 	 * Instead use set_bit() for each bit, as set_bit() itself is atomic.
 	 */
-	for (i = total_sector_nr; i < total_sector_nr +
+	for (int i = total_sector_nr; i < total_sector_nr +
 	     (bio_size >> rbio->bioc->fs_info->sectorsize_bits); i++)
 		set_bit(i, rbio->error_bitmap);
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2a64e2d50ced..9be663526672 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -892,16 +892,11 @@ static void scrub_repair_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	struct bio_vec *bvec;
 	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
-	u32 bio_size = 0;
-	int i;
+	const u32 bio_size = bio_get_size(&bbio->bio);
 
 	ASSERT(sector_nr < stripe->nr_sectors);
 
-	bio_for_each_bvec_all(bvec, &bbio->bio, i)
-		bio_size += bvec->bv_len;
-
 	if (bbio->bio.bi_status) {
 		scrub_bitmap_set_io_error(stripe, sector_nr,
 					  bio_size >> fs_info->sectorsize_bits);
@@ -1250,15 +1245,11 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
 static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
-	struct bio_vec *bvec;
 	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
 	int num_sectors;
-	u32 bio_size = 0;
-	int i;
+	const u32 bio_size = bio_get_size(&bbio->bio);
 
 	ASSERT(sector_nr < stripe->nr_sectors);
-	bio_for_each_bvec_all(bvec, &bbio->bio, i)
-		bio_size += bvec->bv_len;
 	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
 
 	if (bbio->bio.bi_status) {
@@ -1279,13 +1270,8 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
 	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
-	struct bio_vec *bvec;
 	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
-	u32 bio_size = 0;
-	int i;
-
-	bio_for_each_bvec_all(bvec, &bbio->bio, i)
-		bio_size += bvec->bv_len;
+	const u32 bio_size = bio_get_size(&bbio->bio);
 
 	if (bbio->bio.bi_status) {
 		unsigned long flags;
@@ -1294,7 +1280,7 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		bitmap_set(&stripe->write_error_bitmap, sector_nr,
 			   bio_size >> fs_info->sectorsize_bits);
 		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
-		for (i = 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
+		for (int i = 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
 			btrfs_dev_stat_inc_and_print(stripe->dev,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
 	}
-- 
2.52.0


