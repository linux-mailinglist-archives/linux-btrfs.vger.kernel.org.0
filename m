Return-Path: <linux-btrfs+bounces-1463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D22982E842
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 04:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE551F23A4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 03:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A7848A;
	Tue, 16 Jan 2024 03:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPqmdh80";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPqmdh80"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0D7490
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 509F81FB5F
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR1uWFOmaNeyg2XcKhzIWTV8QTWnZxzClwhXfqKSgoE=;
	b=HPqmdh80pPbpj9F+Zg60hnACl/geQYVllxpAB6+enUMnzuQ4g7z1OLqBQrcuwWGbnPin7k
	aljOCeij+LcHLBPh+FCa4ytl7i2XlgQtmBdm8/a+iMacQBYyey3GNO7o020yCpxDWi9f9a
	jxPeb9sr+KSNBSy9UsII7K5sXCLmoG8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705375909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR1uWFOmaNeyg2XcKhzIWTV8QTWnZxzClwhXfqKSgoE=;
	b=HPqmdh80pPbpj9F+Zg60hnACl/geQYVllxpAB6+enUMnzuQ4g7z1OLqBQrcuwWGbnPin7k
	aljOCeij+LcHLBPh+FCa4ytl7i2XlgQtmBdm8/a+iMacQBYyey3GNO7o020yCpxDWi9f9a
	jxPeb9sr+KSNBSy9UsII7K5sXCLmoG8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DC44132FA
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oP+6BKT4pWUKOgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 03:31:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: add extra chunk alignment checks
Date: Tue, 16 Jan 2024 14:01:25 +1030
Message-ID: <cd582deb540064fbf01b10f0651f00809b643e2e.1705375819.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705375819.git.wqu@suse.com>
References: <cover.1705375819.git.wqu@suse.com>
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
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-0.999];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Recently we have a scrub use-after-free caused by unaligned chunk
length, although the fix is submitted, we may want to do extra checks
for a chunk's alignment.

This patch would add such check for the starting bytenr and length of a
chunk, to make sure they are properly aligned to 64K stripe boundary.

By default, the check would only lead to a warning but not treated as an
error, as we expect kernel to handle such unalignment without any
problem.

But if the new debug environmental variable,
BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT, is specified, then we would
treat it as an error.
So that we can detect unexpected chunks from btrfs-progs, and fix them
before reaching the end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/common.h      |  1 +
 check/main.c        | 20 ++++++++++++++++++++
 check/mode-lowmem.c | 11 +++++++++++
 common/utils.c      | 19 +++++++++++++++++++
 common/utils.h      |  1 +
 5 files changed, 52 insertions(+)

diff --git a/check/common.h b/check/common.h
index 2d5db2131ba5..d1c8e8de4af9 100644
--- a/check/common.h
+++ b/check/common.h
@@ -78,6 +78,7 @@ struct chunk_record {
 	u32 io_align;
 	u32 io_width;
 	u32 sector_size;
+	bool unaligned;
 	struct stripe stripes[0];
 };
 
diff --git a/check/main.c b/check/main.c
index 108818688132..99643f0ad7e0 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5265,6 +5265,9 @@ struct chunk_record *btrfs_new_chunk_record(struct extent_buffer *leaf,
 	rec->num_stripes = num_stripes;
 	rec->sub_stripes = btrfs_chunk_sub_stripes(leaf, ptr);
 
+	if (!IS_ALIGNED(rec->cache.start, BTRFS_STRIPE_LEN)||
+	    !IS_ALIGNED(rec->cache.size, BTRFS_STRIPE_LEN))
+		rec->unaligned = true;
 	for (i = 0; i < rec->num_stripes; ++i) {
 		rec->stripes[i].devid =
 			btrfs_stripe_devid_nr(leaf, ptr, i);
@@ -8386,6 +8389,7 @@ int check_chunks(struct cache_tree *chunk_cache,
 	struct chunk_record *chunk_rec;
 	struct block_group_record *bg_rec;
 	struct device_extent_record *dext_rec;
+	bool strict_alignment = get_env_bool("BTRFS_DEBUG_STRICT_CHUNK_ALIGNMENT");
 	int err;
 	int ret = 0;
 
@@ -8393,6 +8397,22 @@ int check_chunks(struct cache_tree *chunk_cache,
 	while (chunk_item) {
 		chunk_rec = container_of(chunk_item, struct chunk_record,
 					 cache);
+		if (chunk_rec->unaligned && !silent) {
+			if (strict_alignment) {
+				error(
+		"chunk[%llu %llu) is not fully aligned to BTRFS_STRIPE_LEN(%u)",
+				      chunk_rec->cache.start,
+				      chunk_rec->cache.start + chunk_rec->cache.size,
+				      BTRFS_STRIPE_LEN);
+				ret = -EINVAL;
+			} else {
+				warning(
+		"chunk[%llu %llu) is not fully aligned to BTRFS_STRIPE_LEN(%u)",
+				      chunk_rec->cache.start,
+				      chunk_rec->cache.start + chunk_rec->cache.size,
+				      BTRFS_STRIPE_LEN);
+			}
+		}
 		err = check_chunk_refs(chunk_rec, block_group_cache,
 				       dev_extent_cache, silent);
 		if (err < 0)
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 19b7b1a72a1f..39944c5430ec 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4719,6 +4719,17 @@ static int check_chunk_item(struct extent_buffer *eb, int slot)
 	chunk = btrfs_item_ptr(eb, slot, struct btrfs_chunk);
 	length = btrfs_chunk_length(eb, chunk);
 	chunk_end = chunk_key.offset + length;
+	if (!IS_ALIGNED(chunk_key.offset, BTRFS_STRIPE_LEN) ||
+	    !IS_ALIGNED(length, BTRFS_STRIPE_LEN)) {
+		if (get_env_bool("BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT")) {
+			error("chunk[%llu %llu) is not fully aligned to BTRFS_STRIPE_LEN(%u)",
+				chunk_key.offset, length, BTRFS_STRIPE_LEN);
+			err |= BYTES_UNALIGNED;
+			goto out;
+		}
+		warning("chunk[%llu %llu) is not fully aligned to BTRFS_STRIPE_LEN(%u)",
+			chunk_key.offset, length, BTRFS_STRIPE_LEN);
+	}
 	ret = btrfs_check_chunk_valid(eb, chunk, chunk_key.offset);
 	if (ret < 0) {
 		error("chunk[%llu %llu) is invalid", chunk_key.offset,
diff --git a/common/utils.c b/common/utils.c
index e6070791f5cc..68fa95ece6f8 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -1018,6 +1018,25 @@ int get_env_u64(const char *env_name, u64 *value_ret)
 	return 0;
 }
 
+/*
+ * Parse a boolean value from an environment variable.
+ *
+ * As long as the environment variable is not set to "0", "n" or "\0",
+ * it would return true.
+ */
+bool get_env_bool(const char *env_name)
+{
+	char *env_value_str;
+
+	env_value_str = getenv(env_name);
+	if (!env_value_str)
+		return false;
+	if (env_value_str[0] == '0' || env_value_str[0] == 'n' ||
+	    env_value_str[0] == '\0')
+		return false;
+	return true;
+}
+
 void btrfs_config_init(void)
 {
 	bconf.output_format = CMD_FORMAT_TEXT;
diff --git a/common/utils.h b/common/utils.h
index 30c75339b05b..5bdeeab44bb4 100644
--- a/common/utils.h
+++ b/common/utils.h
@@ -133,6 +133,7 @@ u64 rand_u64(void);
 unsigned int rand_range(unsigned int upper);
 void init_rand_seed(u64 seed);
 int get_env_u64(const char *env_name, u64 *value_ret);
+bool get_env_bool(const char *env_name);
 
 char *btrfs_test_for_multiple_profiles(int fd);
 int btrfs_warn_multiple_profiles(int fd);
-- 
2.43.0


