Return-Path: <linux-btrfs+bounces-7579-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A673296198A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 23:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C1F285227
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CE21D365F;
	Tue, 27 Aug 2024 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpFY7GCG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpFY7GCG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31681D3652
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2024 21:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724795724; cv=none; b=h1hSDojNW39R4aSTQByTY64nX/uJHI72pkEk8DxBcRXosFG0welHnDUBLcfUWSr8sgXm2va0Kj3x9s951+i6y1PQ2j4BfJH08tq1SmWNWPZ5p+JJ0Kvhbuhq1xL/8cAYZ/wxvdy8OL18mUuqhak0q9D5BFCyHmQuX0CRPmh5WaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724795724; c=relaxed/simple;
	bh=Qj/ufifKcpVVU2nVfuGEJ3uZQhw2cEJDBuwJ/qejh4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhnH7/CWpt93yxvc1t2IAPnvuE5rg5g/V2JRrnvePXTiAjp/dx16N4yM1C/CbZTtxczkeV6gCTOgJSJdPUJ2dmjskIglHUUldp4c5U8MfhjuKiVn4wyeCBTnfYPy5da1QCt/aQkuNF6p9LO8ULZ4sQe9LnydWFUoylrLb/4tGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpFY7GCG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpFY7GCG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 029CB21B2E;
	Tue, 27 Aug 2024 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo+Hbe09W3ybfavOKN6BiCmuq/mEaIpAIwARRX0hp/8=;
	b=KpFY7GCGh7FPeaXecMJ0KNvP1pmlQavcJSkS3/pbtzuEQxXQo4YpumJ2rgdjie9Kk6U/e4
	48gQQqcMVwuhUyw2x/Y0jLhSYtuSvLsV+wxHcyQjFxR8Fs+zVr392NsnxEVr3jg5iB1qxd
	raClTgKq0M3pe7HM/JqbJ1X0jNmsseE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KpFY7GCG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724795720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vo+Hbe09W3ybfavOKN6BiCmuq/mEaIpAIwARRX0hp/8=;
	b=KpFY7GCGh7FPeaXecMJ0KNvP1pmlQavcJSkS3/pbtzuEQxXQo4YpumJ2rgdjie9Kk6U/e4
	48gQQqcMVwuhUyw2x/Y0jLhSYtuSvLsV+wxHcyQjFxR8Fs+zVr392NsnxEVr3jg5iB1qxd
	raClTgKq0M3pe7HM/JqbJ1X0jNmsseE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F088013A20;
	Tue, 27 Aug 2024 21:55:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id elW3OkdLzmZbGgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 27 Aug 2024 21:55:19 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/12] btrfs: rename btrfs_submit_bio() to btrfs_submit_bbio()
Date: Tue, 27 Aug 2024 23:55:15 +0200
Message-ID: <85f2f0100ddace4ddb76173f0fb35de5b4ca0574.1724795623.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1724795623.git.dsterba@suse.com>
References: <cover.1724795623.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 029CB21B2E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function name is a bit misleading as it submits the btrfs_bio
(bbio), rename it so we can use btrfs_submit_bio() when an actual bio is
submitted.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c         | 10 +++++-----
 fs/btrfs/bio.h         |  6 +++---
 fs/btrfs/compression.c |  4 ++--
 fs/btrfs/direct-io.c   |  2 +-
 fs/btrfs/extent_io.c   |  6 +++---
 fs/btrfs/inode.c       |  4 ++--
 fs/btrfs/scrub.c       | 10 +++++-----
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index f6cb58d7f16a..4f3e265880bf 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -53,7 +53,7 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_fs_info *fs_info,
 
 /*
  * Allocate a btrfs_bio structure.  The btrfs_bio is the main I/O container for
- * btrfs, and is used for all I/O submitted through btrfs_submit_bio.
+ * btrfs, and is used for all I/O submitted through btrfs_submit_bbio().
  *
  * Just like the underlying bio_alloc_bioset it will not fail as it is backed by
  * a mempool.
@@ -211,7 +211,7 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 			goto done;
 		}
 
-		btrfs_submit_bio(repair_bbio, mirror);
+		btrfs_submit_bbio(repair_bbio, mirror);
 		return;
 	}
 
@@ -280,7 +280,7 @@ static struct btrfs_failed_bio *repair_one_sector(struct btrfs_bio *failed_bbio,
 
 	mirror = next_repair_mirror(fbio, failed_bbio->mirror_num);
 	btrfs_debug(fs_info, "submitting repair read to mirror %d", mirror);
-	btrfs_submit_bio(repair_bbio, mirror);
+	btrfs_submit_bbio(repair_bbio, mirror);
 	return fbio;
 }
 
@@ -777,7 +777,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	return true;
 }
 
-void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
+void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
 {
 	/* If bbio->inode is not populated, its file_offset must be 0. */
 	ASSERT(bbio->inode || bbio->file_offset == 0);
@@ -789,7 +789,7 @@ void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num)
 /*
  * Submit a repair write.
  *
- * This bypasses btrfs_submit_bio deliberately, as that writes all copies in a
+ * This bypasses btrfs_submit_bbio() deliberately, as that writes all copies in a
  * RAID setup.  Here we only want to write the one bad copy, so we do the
  * mapping ourselves and submit the bio directly.
  *
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index d9dd5276093d..e48612340745 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -29,7 +29,7 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
 /*
  * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
- * passed to btrfs_submit_bio for mapping to the physical devices.
+ * passed to btrfs_submit_bbio() for mapping to the physical devices.
  */
 struct btrfs_bio {
 	/*
@@ -42,7 +42,7 @@ struct btrfs_bio {
 	union {
 		/*
 		 * For data reads: checksumming and original I/O information.
-		 * (for internal use in the btrfs_submit_bio machinery only)
+		 * (for internal use in the btrfs_submit_bbio() machinery only)
 		 */
 		struct {
 			u8 *csum;
@@ -104,7 +104,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status);
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
 
-void btrfs_submit_bio(struct btrfs_bio *bbio, int mirror_num);
+void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num);
 void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_replace);
 int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			    u64 length, u64 logical, struct folio *folio,
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 832ab8984c41..39cd2ed1974b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -395,7 +395,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->bbio.ordered = ordered;
 	btrfs_add_compressed_bio_folios(cb);
 
-	btrfs_submit_bio(&cb->bbio, 0);
+	btrfs_submit_bbio(&cb->bbio, 0);
 }
 
 /*
@@ -630,7 +630,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	btrfs_submit_bio(&cb->bbio, 0);
+	btrfs_submit_bbio(&cb->bbio, 0);
 	return;
 
 out_free_compressed_pages:
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 67adbe9d294a..855255b4481d 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -726,7 +726,7 @@ static void btrfs_dio_submit_io(const struct iomap_iter *iter, struct bio *bio,
 		}
 	}
 
-	btrfs_submit_bio(bbio, 0);
+	btrfs_submit_bbio(bbio, 0);
 }
 
 static const struct iomap_ops btrfs_dio_iomap_ops = {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 643dd948054f..8de6d226475d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -117,7 +117,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
 	else
-		btrfs_submit_bio(bbio, 0);
+		btrfs_submit_bbio(bbio, 0);
 
 	/* The bbio is owned by the end_io handler now */
 	bio_ctrl->bbio = NULL;
@@ -1800,7 +1800,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			folio_unlock(folio);
 		}
 	}
-	btrfs_submit_bio(bbio, 0);
+	btrfs_submit_bbio(bbio, 0);
 }
 
 /*
@@ -3572,7 +3572,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
 			ASSERT(ret);
 		}
 	}
-	btrfs_submit_bio(bbio, mirror_num);
+	btrfs_submit_bbio(bbio, mirror_num);
 
 done:
 	if (wait == WAIT_COMPLETE) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8ad540d6de2..7dffe241dd15 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9152,7 +9152,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
 			atomic_inc(&priv.pending);
-			btrfs_submit_bio(bbio, 0);
+			btrfs_submit_bbio(bbio, 0);
 
 			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
 					       btrfs_encoded_read_endio, &priv);
@@ -9167,7 +9167,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	} while (disk_io_size);
 
 	atomic_inc(&priv.pending);
-	btrfs_submit_bio(bbio, 0);
+	btrfs_submit_bbio(bbio, 0);
 
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b3afa6365823..3a3427428074 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -838,7 +838,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 			     bbio->bio.bi_iter.bi_size >= blocksize)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
-			btrfs_submit_bio(bbio, mirror);
+			btrfs_submit_bbio(bbio, mirror);
 			if (wait)
 				wait_scrub_stripe_io(stripe);
 			bbio = NULL;
@@ -857,7 +857,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
 	if (bbio) {
 		ASSERT(bbio->bio.bi_iter.bi_size);
 		atomic_inc(&stripe->pending_io);
-		btrfs_submit_bio(bbio, mirror);
+		btrfs_submit_bbio(bbio, mirror);
 		if (wait)
 			wait_scrub_stripe_io(stripe);
 	}
@@ -1683,7 +1683,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 		     bbio->bio.bi_iter.bi_size >= stripe_len)) {
 			ASSERT(bbio->bio.bi_iter.bi_size);
 			atomic_inc(&stripe->pending_io);
-			btrfs_submit_bio(bbio, mirror);
+			btrfs_submit_bbio(bbio, mirror);
 			bbio = NULL;
 		}
 
@@ -1720,7 +1720,7 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 	if (bbio) {
 		ASSERT(bbio->bio.bi_iter.bi_size);
 		atomic_inc(&stripe->pending_io);
-		btrfs_submit_bio(bbio, mirror);
+		btrfs_submit_bbio(bbio, mirror);
 	}
 
 	if (atomic_dec_and_test(&stripe->pending_io)) {
@@ -1776,7 +1776,7 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 
 		mirror = calc_next_mirror(mirror, num_copies);
 	}
-	btrfs_submit_bio(bbio, mirror);
+	btrfs_submit_bbio(bbio, mirror);
 }
 
 static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
-- 
2.45.0


