Return-Path: <linux-btrfs+bounces-1817-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096A83D2EA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165241F240AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 03:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00676A947;
	Fri, 26 Jan 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nUOeyXsg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nUOeyXsg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8BAD21
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706239325; cv=none; b=e7AMXFSCYhUqVy2vtcvOr1tHOaK6eplRkjltOx/6wRrgy13Rvy6vvmPrKkStX2LiGj6QyeLP5OsDgShsjNubfkVKW7UhXsb0T8cft5n08nHPxbKkn7YnxDqHS/ZMjNX4yIeAwbwzIwt8VqA3vvFMF6b2pRtRsAkY/XT0d/VUp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706239325; c=relaxed/simple;
	bh=mST//Zzp6Rtpjkgc2sQip8yxhLxujd9KsiSalZlLSNs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Z7dLOO8MjEwCCXP/6/yINLpJ2pp/fQ/qkZhITAwqv12k0vh6O9yVcx4kCwf61l+mA4OzZZH1rsv8ANNhkkTU3J2VmKa9/SIig5L2PVJYrJ1p2Sr1YsQi/NrC4sRdjkN6OZ4fwd8IdZrPIn0q0/sotyLFseqk6D2SMAWl45XjGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nUOeyXsg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nUOeyXsg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D95891FB47
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 03:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706239318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIkzlFI3JO/RoGVAVMvT21qPVfesNCyV+fmha/UN7mg=;
	b=nUOeyXsggzbj6VveZG7hdskUhY8gOBorDsZYpbNOJtOMDTFvGXxExnJYVffJ5i0QTdIyoc
	kwRu452h7jr/OJqqCEAhHkrXiVdGnQb5X2h8kl/R1udaSV6aClNQlqcTJKHdZv9FQ99ZFe
	F65ApWd9hDQkWbufSmxXC8TPBMaL3ZY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706239318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KIkzlFI3JO/RoGVAVMvT21qPVfesNCyV+fmha/UN7mg=;
	b=nUOeyXsggzbj6VveZG7hdskUhY8gOBorDsZYpbNOJtOMDTFvGXxExnJYVffJ5i0QTdIyoc
	kwRu452h7jr/OJqqCEAhHkrXiVdGnQb5X2h8kl/R1udaSV6aClNQlqcTJKHdZv9FQ99ZFe
	F65ApWd9hDQkWbufSmxXC8TPBMaL3ZY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E77A134C3
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 03:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PAA6NFUls2XZKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 03:21:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: raid56: extra debug for raid6 syndrome generation
Date: Fri, 26 Jan 2024 13:51:32 +1030
Message-ID: <ceaa8a9d4a19dbe017012d5cdbd78aafeac31cc9.1706239278.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.99
X-Spamd-Result: default: False [0.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_SHORT(0.09)[0.031];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
I have got at least two crash report for RAID6 syndrome generation, no
matter if it's AVX2 or SSE2, they all seems to have a similar
calltrace with corrupted RAX:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 Workqueue: btrfs-rmw rmw_rbio_work [btrfs]
 RIP: 0010:raid6_sse21_gen_syndrome+0x9e/0x130 [raid6_pq]
 RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248
 RDX: 0000000000000000 RSI: ffffa0f74cfa3238 RDI: 0000000000000000
 Call Trace:
  <TASK>
  rmw_rbio+0x5c8/0xa80 [btrfs]
  process_one_work+0x1c7/0x3d0
  worker_thread+0x4d/0x380
  kthread+0xf3/0x120
  ret_from_fork+0x2c/0x50
  </TASK>

[CAUSE]
In fact I don't have any clue.

Recently I also hit this in AVX512 path, and that's even in v5.15
backport, which doesn't have any of my RAID56 rework.

Furthermore according to the registers:

 RAX: 0000000000000000 RBX: 0000000000001000 RCX: ffffa0ff4cfa3248

The RAX register is showing the number of stripes (including PQ),
which is not correct (0).
But the remaining two registers are all sane.

- RBX is the sectorsize
  For x86_64 it should always be 4K and matches the output.

- RCX is the pointers array
  Which is from rbio->finish_pointers, and it looks like a sane
  kernel address.

[WORKAROUND]
For now, I can only add extra debug ASSERT()s before we call raid6
gen_syndrome() helper and hopes to catch the problem.

The debug requires both CONFIG_BTRFS_DEBUG and CONFIG_BTRFS_ASSERT
enabled.

My current guess is some use-after-free, but every report is only having
corrupted RAX but seemingly valid pointers doesn't make much sense.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 5c4bf3f907c1..6f4a9cfeea44 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -917,6 +917,13 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	 */
 	ASSERT(stripe_nsectors <= BITS_PER_LONG);
 
+	/*
+	 * Real stripes must be between 2 (2 disks RAID5, aka RAID1) and 256
+	 * (limited by u8).
+	 */
+	ASSERT(real_stripes >= 2);
+	ASSERT(real_stripes <= U8_MAX);
+
 	rbio = kzalloc(sizeof(*rbio), GFP_NOFS);
 	if (!rbio)
 		return ERR_PTR(-ENOMEM);
@@ -954,6 +961,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 
 	ASSERT(btrfs_nr_parity_stripes(bioc->map_type));
 	rbio->nr_data = real_stripes - btrfs_nr_parity_stripes(bioc->map_type);
+	ASSERT(rbio->nr_data > 0);
 
 	return rbio;
 }
@@ -1180,6 +1188,26 @@ static inline void bio_list_put(struct bio_list *bio_list)
 		bio_put(bio);
 }
 
+static void assert_rbio(struct btrfs_raid_bio *rbio)
+{
+	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
+	    !IS_ENABLED(CONFIG_BTRFS_ASSERT))
+		return;
+
+	/*
+	 * At least two stripes (2 disks RAID5), and since real_stripes is U8,
+	 * we won't go beyond 256 disks anyway.
+	 */
+	ASSERT(rbio->real_stripes >= 2);
+	ASSERT(rbio->nr_data > 0);
+
+	/*
+	 * This is another check to make sure nr data stripes is smaller
+	 * than total stripes.
+	 */
+	ASSERT(rbio->nr_data < rbio->real_stripes);
+}
+
 /* Generate PQ for one vertical stripe. */
 static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 {
@@ -1211,6 +1239,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
 		pointers[stripe++] = kmap_local_page(sector->page) +
 				     sector->pgoff;
 
+		assert_rbio(rbio);
 		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
 					pointers);
 	} else {
@@ -2472,6 +2501,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
 		}
 
 		if (has_qstripe) {
+			assert_rbio(rbio);
 			/* RAID6, call the library function to fill in our P/Q */
 			raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
 						pointers);
-- 
2.43.0


