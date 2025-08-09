Return-Path: <linux-btrfs+bounces-15943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0446EB1F21D
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Aug 2025 06:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31B23B6F33
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Aug 2025 04:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11E275AFF;
	Sat,  9 Aug 2025 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AezEny2A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lshz01FQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C81AF0A4
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754714471; cv=none; b=T44AgLAdgZdZtzZstSm1PcC0S5iG7Bm0cT1Q6WA19mkN3Hnl+VdHbSXcrA2fO/PPwywCyL42eaUGVZhoQmbGX9ckflOrjHBcGJe/NkYcJiNpLrWj9UNSmglNpRc4quYrWLFB/vBfH/CINdFPjaiKchcOzwx1EXiAt+nExSLm6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754714471; c=relaxed/simple;
	bh=QIqGxRjNwXJvnbnHm1JSfLcKluB67oFwxD/i/3Sz60U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=L4tV+ryEZRP5NEUOMhQECwb4iP3x4vjdiIk9LqI+Vz9X0A5kfseeeLEjnLnrc1agZzXyw+0TeUBuPH0vJE9WM3YjoJ6myghop1beVYdnXuiP/xS8ovLpE8kvk/rVarB7aEZQjofiuvjf11yzRaUni3ZZ3E02w/jtL5Lr1i7HadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AezEny2A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lshz01FQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED5F05BD73
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754714467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=loKN8Ej67GbhkBQDVZPhyHDxIROSoPKo+piVQbkMmk4=;
	b=AezEny2AJM0bEYIeDsmJFQOGOlVZGZansY4z6JW3qi0g5qTEOa21lsmEh5o62+qHoktbaw
	wa0Yr0Au+SVXcUZk+YbQbRGSArALQ1h8yr0IQsYqW8U8dcmrxRqPYSY13ojEKflqAtpAsi
	A8njyIFq4PIrVxMmdip/c0wh90H+UUo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754714466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=loKN8Ej67GbhkBQDVZPhyHDxIROSoPKo+piVQbkMmk4=;
	b=lshz01FQH93fxtWJQSPa8ZI5zj2GdAoINZs85L0F+DUhie0YfXlQmlDMvEqAg7b2w29tXA
	hxzdPcWF/Up7YxV850FQRq+OCHXeRSPcUN9AMHiSbWf47VBfhDv6DuEaIg5dCPTgAw3A8D
	7JI7NSW5Zlyu1YMP1ZetTPGU0n52Kos=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E6713A7E
	for <linux-btrfs@vger.kernel.org>; Sat,  9 Aug 2025 04:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bDmqOGHRlmjUCAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 09 Aug 2025 04:41:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: simplify support block size check
Date: Sat,  9 Aug 2025 14:10:48 +0930
Message-ID: <e21172a455354a71172de72b9af4d844fc6ea9d4.1754714176.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Currently we manually check the block size against 3 different values:
- 4K
- PAGE_SIZE
- MIN_BLOCKSIZE

Those 3 values can match or differ from each other.

This makes it pretty complex to output the supported block sizes.

Considering we're going to add block size > page size support soon, this
can make the support block size sysfs attribute much harder to
implement.

To make it easier, extract a helper, btrfs_supported_blocksize() to do a
simple check for the block size.

Then utilize it in the two locations:

- btrfs_validate_super()
  This is very straightforward

- supported_sectorsizes_show()
  Iterate through all valid block sizes, and only output supported ones.

  This is to make future full range block sizes support much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Uninline btrfs_supported_blocksize() helper
- Make supported_sectorsizes_show() to use a simpler handling
  If there were output before, output a space.
  So that the number outputting part is always the same.
---
 fs/btrfs/disk-io.c | 16 +---------------
 fs/btrfs/fs.c      | 26 ++++++++++++++++++++++++++
 fs/btrfs/fs.h      |  3 +++
 fs/btrfs/sysfs.c   | 17 +++++++++++------
 4 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9cc14ab35297..34e81ca2fc79 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2442,21 +2442,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	/*
-	 * We only support at most 3 sectorsizes: 4K, PAGE_SIZE, MIN_BLOCKSIZE.
-	 *
-	 * For 4K page sized systems with non-debug builds, all 3 matches (4K).
-	 * For 4K page sized systems with debug builds, there are two block sizes
-	 * supported. (4K and 2K)
-	 *
-	 * We can support 16K sectorsize with 64K page size without problem,
-	 * but such sectorsize/pagesize combination doesn't make much sense.
-	 * 4K will be our future standard, PAGE_SIZE is supported from the very
-	 * beginning.
-	 */
-	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K &&
-				       sectorsize != PAGE_SIZE &&
-				       sectorsize != BTRFS_MIN_BLOCKSIZE)) {
+	if (!btrfs_supported_blocksize(sectorsize)) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index b2bb86f8d7cf..64948934ec51 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -54,6 +54,32 @@ size_t __attribute_const__ btrfs_get_num_csums(void)
 	return ARRAY_SIZE(btrfs_csums);
 }
 
+/*
+ * We support the following block size for all systems:
+ * - 4K
+ *   This is the most common block size. For PAGE SIZE > 4K cases, btrfs
+ *   goes subpage routine to support it.
+ *
+ * - PAGE_SIZE
+ *   The easily block size to support.
+ *
+ * And extra support for the following block sizes based on the kernel config:
+ *
+ * - MIN_BLOCKSIZE
+ *   This is either 4K (regular builds) or 2K (debug builds)
+ *   This allows testing subpage routines on x86_64.
+ */
+bool btrfs_supported_blocksize(u32 blocksize)
+{
+	/* @blocksize should be validated first. */
+	ASSERT(is_power_of_2(blocksize) && blocksize >= BTRFS_MIN_BLOCKSIZE &&
+	       blocksize <= BTRFS_MAX_BLOCKSIZE);
+
+	if (blocksize == PAGE_SIZE || blocksize == SZ_4K || blocksize == BTRFS_MIN_BLOCKSIZE)
+		return true;
+	return false;
+}
+
 /*
  * Start exclusive operation @type, return true on success.
  */
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8cc07cc70b12..90148e6ff120 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -59,6 +59,8 @@ struct btrfs_space_info;
 #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
 #endif
 
+#define BTRFS_MAX_BLOCKSIZE	(SZ_64K)
+
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 #define BTRFS_OLDEST_GENERATION	0ULL
@@ -997,6 +999,7 @@ static inline unsigned int btrfs_blocks_per_folio(const struct btrfs_fs_info *fs
 	return folio_size(folio) >> fs_info->sectorsize_bits;
 }
 
+bool btrfs_supported_blocksize(u32 blocksize);
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type);
 bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9d398f7a36ad..31af46f1f750 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -409,13 +409,18 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 					  char *buf)
 {
 	ssize_t ret = 0;
+	bool has_output = false;
 
-	if (BTRFS_MIN_BLOCKSIZE != SZ_4K && BTRFS_MIN_BLOCKSIZE != PAGE_SIZE)
-		ret += sysfs_emit_at(buf, ret, "%u ", BTRFS_MIN_BLOCKSIZE);
-	if (PAGE_SIZE > SZ_4K)
-		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
-	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
-
+	for (u32 cur = BTRFS_MIN_BLOCKSIZE; cur <= BTRFS_MAX_BLOCKSIZE;
+	     cur *= 2) {
+		if (!btrfs_supported_blocksize(cur))
+			continue;
+		if (has_output)
+			ret += sysfs_emit_at(buf, ret, " ");
+		ret += sysfs_emit_at(buf, ret, "%u", cur);
+		has_output = true;
+	}
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_sectorsizes,
-- 
2.50.1


