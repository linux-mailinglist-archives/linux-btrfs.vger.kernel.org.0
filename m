Return-Path: <linux-btrfs+bounces-11833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AECDA45452
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281D1189906C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58C20AF8E;
	Wed, 26 Feb 2025 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W2MUVCeK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M+/D/O2e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF6266B6C
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740543053; cv=none; b=vAyX/6diHSuiWYZVbScd26+ajTSWlpNyq13e3ayfxsMHzxDbaNgN/w/qBxrwI8zbRDCT6nhk4T6gdwcfPBoBu4OJIyhklIqnT4jng7wLrKy8BF4DCFiJdK8AWpt47y0L6JBdSTDGIx8Xoy3XunbDoTlT5MyWYvyVrlbDizOPNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740543053; c=relaxed/simple;
	bh=s3/JU27zjV+7frws4hdIX9efskI0iXkfsG2wYoCVaXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPJLyI3/hGCQJR3g5DCyX72cUj1zsybZBgZQEVgduhwmIP3mQ3shFOzlv7I76VqaPKVjFtP6Xdeg/kth4XXICZoRLM7q45TR9Gq2eUBgAtoWWLdINle5PGMEemctTWRMwDNst1H/HrAsSQE6gKUudJHg7egoVh7tzITogz35zGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W2MUVCeK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M+/D/O2e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9012221195
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jj9HRI+jOIEZx365uuzCdaFPwh7Jd9VdBiZfbn0W6I=;
	b=W2MUVCeK4gnEUtvAvq7V47HU6OlPdBS0uc3agJZra4NhKaTkQZs3XVtujR9qz2R/15xLgF
	bUyNFkArNY05dYwNa81L2JZ7HFzHR9svG1b684juVjo/YYAbobZAf9pp/ma79Ta3xV80Rf
	3AqH+ab674Eiz1qXIdxdOWWEBgZT550=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="M+/D/O2e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740543045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jj9HRI+jOIEZx365uuzCdaFPwh7Jd9VdBiZfbn0W6I=;
	b=M+/D/O2eDaepYwiI/eXUqroRbsxZq9G/zX+wFeNPD64SpMzsHZbAdtIWarbbdaA0qE6/fs
	rXF1rV8zXHTaf5NnzZZFbpbK5WiCSRqC29o3bql+dnWlskk0+XoqY2pfRmDDPTkBhUp32l
	DJI+pxWWDF/XBbBJFiH/an4SYdHvhmI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3FC41377F
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YFCnIESUvmcgfQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 04:10:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: allow debug builds to accept 2K block size
Date: Wed, 26 Feb 2025 14:40:22 +1030
Message-ID: <b89134d1353accb08c92c472814a39caeb44bc1e.1740542375.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542375.git.wqu@suse.com>
References: <cover.1740542375.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9012221195
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently we only support two block sizes, 4K and PAGE_SIZE.

This means on the most common architecture x86_64, we have no way to
test subpage block size.
And that's exactly I have an aarch64 machine dedicated for subpage
tests.

But this is still a hurdle for a lot of btrfs developers, and to improve
the test coverage mostly on x86_64, here we enable debug builds to
accept 2K block size.

This involves:

- Introduce a dedicated minimal block size macro
  BTRFS_MIN_BLOCKSIZE, which depends on if CONFIG_BTRFS_DEBUG is set.
  If so it's 2K, otherwise it's 4K as usual.

- Allow 4K, PAGE_SIZE and BTRFS_MIN_BLOCKSIZE as block size

- Update subpage block size checks to be based on BTRFS_MIN_BLOCKSIZE

- Export the new supported blocksize through sysfs interfaces

As most of the subpage support is already pretty mature, there is no
extra work needed to support the extra 2K block size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 12 +++++++++---
 fs/btrfs/fs.h      | 12 ++++++++++++
 fs/btrfs/subpage.h |  2 +-
 fs/btrfs/sysfs.c   |  3 ++-
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c0b40dedceb5..6a8368421fbc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2446,21 +2446,27 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	 * Check sectorsize and nodesize first, other check will need it.
 	 * Check all possible sectorsize(4K, 8K, 16K, 32K, 64K) here.
 	 */
-	if (!is_power_of_2(sectorsize) || sectorsize < 4096 ||
+	if (!is_power_of_2(sectorsize) || sectorsize < BTRFS_MIN_BLOCKSIZE ||
 	    sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		btrfs_err(fs_info, "invalid sectorsize %llu", sectorsize);
 		ret = -EINVAL;
 	}
 
 	/*
-	 * We only support at most two sectorsizes: 4K and PAGE_SIZE.
+	 * We only support at most 3 sectorsizes: 4K, PAGE_SIZE, MIN_BLOCKSIZE.
+	 *
+	 * For 4K page sized systems with non-debug builds, all 3 matches (4K).
+	 * For 4K page sized systems with debug builds, there are two block sizes
+	 * supported. (4K and 2K)
 	 *
 	 * We can support 16K sectorsize with 64K page size without problem,
 	 * but such sectorsize/pagesize combination doesn't make much sense.
 	 * 4K will be our future standard, PAGE_SIZE is supported from the very
 	 * beginning.
 	 */
-	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K && sectorsize != PAGE_SIZE)) {
+	if (sectorsize > PAGE_SIZE || (sectorsize != SZ_4K &&
+				       sectorsize != PAGE_SIZE &&
+				       sectorsize != BTRFS_MIN_BLOCKSIZE)) {
 		btrfs_err(fs_info,
 			"sectorsize %llu not yet supported for page size %lu",
 			sectorsize, PAGE_SIZE);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 8e8ac7db1355..b8c2e59ffc43 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -47,6 +47,18 @@ struct btrfs_subpage_info;
 struct btrfs_stripe_hash_table;
 struct btrfs_space_info;
 
+/*
+ * Minimal data and metadata block size.
+ *
+ * Normally it's 4K, but for testing subpage block size on 4K page systems,
+ * we allow DEBUG builds to accept 2K page size.
+ */
+#ifdef CONFIG_BTRFS_DEBUG
+#define BTRFS_MIN_BLOCKSIZE	(SZ_2K)
+#else
+#define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
+#endif
+
 #define BTRFS_MAX_EXTENT_SIZE SZ_128M
 
 #define BTRFS_OLDEST_GENERATION	0ULL
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index f8d1efa1a227..5327093cf466 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -70,7 +70,7 @@ enum btrfs_subpage_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
-#if PAGE_SIZE > SZ_4K
+#if PAGE_SIZE > BTRFS_MIN_BLOCKSIZE
 /*
  * Subpage support for metadata is more complex, as we can have dummy extent
  * buffers, where folios have no mapping to determine the owning inode.
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 53b846d99ece..4be612cab10f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -411,7 +411,8 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 {
 	ssize_t ret = 0;
 
-	/* An artificial limit to only support 4K and PAGE_SIZE */
+	if (BTRFS_MIN_BLOCKSIZE != SZ_4K && BTRFS_MIN_BLOCKSIZE != PAGE_SIZE)
+		ret += sysfs_emit_at(buf, ret, "%u ", BTRFS_MIN_BLOCKSIZE);
 	if (PAGE_SIZE > SZ_4K)
 		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
 	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
-- 
2.48.1


