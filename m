Return-Path: <linux-btrfs+bounces-15905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E348B1D2E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4204C3AB2E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0C4AEE2;
	Thu,  7 Aug 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hRDH0X9h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hRDH0X9h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0422577E
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550127; cv=none; b=nHrBS196o4xusgVbLaT/WqimxS/jAn9VHKZZSYDvWtXcFi6ecPsS/enYbOUYzd7K0/uz8DvnIt44K7TAc2K7xo0T3UMBBEXp/eVlteLE6X70LvCjzS+rXQgJF1bQzl5QIChv1B39NGIbafXZdEQgElp5SvLMX5GvlofoubF/8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550127; c=relaxed/simple;
	bh=PUmc/0qTjSJh8q6HqBG+rGE86dRZvO69Sk8TAl+zcJ0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Cy2kZ7/DiKjeTcLRoiA/ItwOdI/uAcG0ZWEQmkTTgOIrjsQlW39nRl2foGlv2tYWJAWIhSAGvh/hchzJVKJjT6Ocavmjn9B7RR7GXTWxvaK0zksatHItpP8vKeyOyL47Dp8dR76fRNOcf5RpCmQ8m3j4Abw4W3jeAzmRwJvAFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hRDH0X9h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hRDH0X9h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 292511F807
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 07:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754550117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TM3EndByd6NvGSqtQirb0IrOn2keXq/rgKHwUL11nIk=;
	b=hRDH0X9hgk/jpccalHOQmfU+XGqcqqxofwc1nNGQhcuLQ4n1PRT6EIJ0k2/r3h0zO0FO2d
	oLc0MTBFZHFgfcrSE2nv0lGx//UG46jYSJTWEoJCOPj+RjDWxvyPq2iXLZgJhe/e2tVhwl
	kAh7MMbkFSt2kAHiT83f/58cTRvxSyw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hRDH0X9h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754550117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TM3EndByd6NvGSqtQirb0IrOn2keXq/rgKHwUL11nIk=;
	b=hRDH0X9hgk/jpccalHOQmfU+XGqcqqxofwc1nNGQhcuLQ4n1PRT6EIJ0k2/r3h0zO0FO2d
	oLc0MTBFZHFgfcrSE2nv0lGx//UG46jYSJTWEoJCOPj+RjDWxvyPq2iXLZgJhe/e2tVhwl
	kAh7MMbkFSt2kAHiT83f/58cTRvxSyw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C293136DC
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 07:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HOwJCGRPlGhpDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 07 Aug 2025 07:01:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: simplify support block size check
Date: Thu,  7 Aug 2025 16:31:30 +0930
Message-ID: <c90d9b78c3c1bab713c301f643e32496471bc2bd.1754549826.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 292511F807
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently we manually check the block size against 3 different values:
- 4K
- PAGE_SIZE
- MIN_BLOCKSIZE

Those 3 values can match or differ from each other.

This makes it pretty complex to output the supported block sizes.

Considering we're going to add block size > page size support soon, this
can make the support block size sysfs attribute much harder to
implement.

To make it easier, extract a helper, btrfs_blocksize_support() to do a
simple check for the block size.

Then utilize it in the two locations:

- btrfs_validate_super()
  This is very straightforward

- supported_sectorsizes_show()
  Iterate through all valid block sizes, and only output supported ones.

  This is to make future full range block sizes support much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 17 +----------------
 fs/btrfs/fs.h      | 29 +++++++++++++++++++++++++++++
 fs/btrfs/sysfs.c   | 18 ++++++++++++------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9cc14ab35297..427480a8bcf8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2442,27 +2442,12 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
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
+	if (!btrfs_blocksize_supported(sectorsize)) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
 		ret = -EINVAL;
 	}
-
 	if (!is_power_of_2(nodesize) || nodesize < sectorsize ||
 	    nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		btrfs_err(fs_info, "invalid nodesize %llu", nodesize);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8cc07cc70b12..4548371ca10c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -29,6 +29,7 @@
 #include "extent-io-tree.h"
 #include "async-thread.h"
 #include "block-rsv.h"
+#include "messages.h"
 
 struct inode;
 struct super_block;
@@ -59,6 +60,8 @@ struct btrfs_space_info;
 #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
 #endif
 
+#define BTRFS_MAX_BLOCKSIZE	(SZ_64K)
+
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 #define BTRFS_OLDEST_GENERATION	0ULL
@@ -900,6 +903,32 @@ struct btrfs_fs_info {
 #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
 					   struct inode *: (_inode)))->root->fs_info)
 
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
+static inline bool btrfs_blocksize_supported(u32 blocksize)
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
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9d398f7a36ad..a3c3281a4949 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -409,13 +409,19 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
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
+	     cur <<= 1) {
+		if (!btrfs_blocksize_supported(cur))
+			continue;
+		if (has_output)
+			ret += sysfs_emit_at(buf, ret, " %u", cur);
+		else
+			ret += sysfs_emit_at(buf, ret, "%u", cur);
+		has_output = true;
+	}
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_sectorsizes,
-- 
2.50.1


