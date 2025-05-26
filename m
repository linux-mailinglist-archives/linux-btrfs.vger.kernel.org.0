Return-Path: <linux-btrfs+bounces-14231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DAFAC385F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 06:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649B516EC42
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3718C02E;
	Mon, 26 May 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="i06tO2we";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OEm9q+zQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0323136E
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748232190; cv=none; b=bkXILcCmEDgfPQ/CncOwqol22l+g1M0asgIVqA9L4gU/0o7ABgApA7AqZXv6Zx6AFufvNHH/JPCwA2ktUNhrf5005jGAO7Ut639lh50D3fwFOMELUTck6qRwcVBySP/Lhg7v0zlNCSCzk8z1rtJ6GRE8x7DFvJw123FgNNHZxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748232190; c=relaxed/simple;
	bh=oWOl+siBr2/Mc0GVh7OPdhSN6XIXzmA6BhQs4675wL4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNCvgdpEyAKzLDXzbwKYEY5OAczDUAt9FAiC8+NTYqK/n1oIqKXnjKZJmakWuNsRN+qIuoDxgL18AYCR8qxkO6UaGwk3kkywtymXAUURlDFAezuIJpkCMWG79gUIT6ZFoxAyLSdKyclpOVv+nvjPolX7xqFTn8Cd+xQroZNfor4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=i06tO2we; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OEm9q+zQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFC5A1FDAC
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4Wd/on5CA8leNMmdM3ezEzpuYj+cAwxAeo0PEdLskI=;
	b=i06tO2weBVBwCXHPSSTKVfLe9enDSrWmdIC1La8nejKtXvN6KtIT/MsHu5Uwrz1C+HKtFN
	nTj63HI6Yi5cPBjynqGn80ZFuzzPzAggGqR2Ka/CCScBoF48mRKUT57BDBNeF3xUO4/wGL
	8LoV069qNMNDXUJNWYbZsz0GLg58Mw8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OEm9q+zQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748232176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4Wd/on5CA8leNMmdM3ezEzpuYj+cAwxAeo0PEdLskI=;
	b=OEm9q+zQ0AOdVL1DSiimx3wm+K5rtf6sl0wqBZfGmcpQTDgxwKKT+eYOC6E64FcQVY7FCG
	7LjapcuiSO5pcsROlQ2fgYCWKiEOLuoTMxFhyOdXvGMzjI+aPBTFyilI8T3LtZMjz2N2fv
	wUZceMW6mz8JAXsh56JezfSqBK/ryTs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2484013770
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qB/BNe/nM2g3ewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 04:02:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: remove the unused fs_info parameter for btrfs_csum_data()
Date: Mon, 26 May 2025 13:32:35 +0930
Message-ID: <c40ac545ab7da66339e9943dbad83409521d2347.1748232037.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748232037.git.wqu@suse.com>
References: <cover.1748232037.git.wqu@suse.com>
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
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: DFC5A1FDAC
X-Spam-Level: 
X-Spam-Flag: NO

The parameter @fs_info is not utilized at all, and there are already
several call sites passing NULL as @fs_info.

And there is no counter-part in kernel (we use crypto_shash_* interface
instead), there is no need to keep the parameter list the same.

So just remove the unused parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c                    |  2 +-
 cmds/rescue-chunk-recover.c     |  2 +-
 cmds/rescue-fix-data-checksum.c |  4 ++--
 convert/common.c                |  2 +-
 convert/main.c                  |  2 +-
 kernel-shared/disk-io.c         | 12 +++++-------
 kernel-shared/disk-io.h         |  3 +--
 kernel-shared/file-item.c       |  3 +--
 kernel-shared/print-tree.c      |  4 ++--
 tune/change-csum.c              |  7 +++----
 10 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/check/main.c b/check/main.c
index bf250c41eb07..b78eb59d0c50 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5831,7 +5831,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			while (data_checked < read_len) {
 				tmp = offset + data_checked;
 
-				btrfs_csum_data(gfs_info, csum_type, data + tmp,
+				btrfs_csum_data(csum_type, data + tmp,
 						result, gfs_info->sectorsize);
 
 				csum_offset = leaf_offset +
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 60a705817c80..1a5a2a39c640 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1896,7 +1896,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 	}
 	ret = 0;
 	put_unaligned_le32(tree_csum, expected_csum);
-	btrfs_csum_data(NULL, csum_type, (u8 *)data, result, len);
+	btrfs_csum_data(csum_type, (u8 *)data, result, len);
 	if (memcmp(result, expected_csum, csum_size) != 0)
 		ret = 1;
 out:
diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
index 23b59fffe2f7..0e3b5cdbb217 100644
--- a/cmds/rescue-fix-data-checksum.c
+++ b/cmds/rescue-fix-data-checksum.c
@@ -135,7 +135,7 @@ static int verify_one_data_block(struct btrfs_fs_info *fs_info,
 				break;
 		}
 		/* Verify the data checksum. */
-		btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, blocksize);
+		btrfs_csum_data(fs_info->csum_type, buf, csum, blocksize);
 		read_extent_buffer(leaf, csum_expected, leaf_offset, csum_size);
 		if (memcmp(csum_expected, csum, csum_size) != 0) {
 			ret = add_corrupted_block(fs_info, logical, mirror, num_mirrors);
@@ -364,7 +364,7 @@ static int update_csum_item(struct btrfs_fs_info *fs_info, u64 logical,
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, fs_info->sectorsize);
+	btrfs_csum_data(fs_info->csum_type, buf, csum, fs_info->sectorsize);
 	write_extent_buffer(path.nodes[0], csum, (unsigned long)citem, fs_info->csum_size);
 	btrfs_release_path(&path);
 	ret = btrfs_commit_transaction(trans, csum_root);
diff --git a/convert/common.c b/convert/common.c
index 2cbe45180ce9..8c64c2ce80ff 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -80,7 +80,7 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
        u16 csum_type = btrfs_super_csum_type(sb);
        int ret;
 
-       btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+       btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 		       result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
        memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
        ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
diff --git a/convert/main.c b/convert/main.c
index 0dc75c9eb1c6..8784192fefc5 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1060,7 +1060,7 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	BUG_ON(btrfs_super_bytenr(&super) != old_bytenr);
 	btrfs_set_super_bytenr(&super, BTRFS_SUPER_INFO_OFFSET);
 
-	btrfs_csum_data(NULL, btrfs_super_csum_type(&super),
+	btrfs_csum_data(btrfs_super_csum_type(&super),
 			(u8 *)&super + BTRFS_CSUM_SIZE, result,
 			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	memcpy(&super.csum[0], result, BTRFS_CSUM_SIZE);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index b7d478007ae8..95e1504fd07e 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -162,8 +162,7 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
 	}
 }
 
-int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type, const u8 *data,
-		    u8 *out, size_t len)
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 {
 	memset(out, 0, BTRFS_CSUM_SIZE);
 
@@ -191,8 +190,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	u32 len;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	btrfs_csum_data(buf->fs_info, csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE,
-			result, len);
+	btrfs_csum_data(csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE, result, len);
 
 	if (verify) {
 		if (buf->fs_info && buf->fs_info->skip_csum_check) {
@@ -1770,7 +1768,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 	csum_size = btrfs_super_csum_size(sb);
 
-	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	if (memcmp(result, sb->csum, csum_size)) {
@@ -2028,7 +2026,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 	}
 	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
 		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
-		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 				result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
@@ -2061,7 +2059,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 				result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index f57bc1b18ad1..dd2dabdf3731 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -223,8 +223,7 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
-int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type, const u8 *data,
-		    u8 *out, size_t len);
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
 
 int btrfs_open_device(struct btrfs_device *dev);
 int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 503ad657c661..6b7c47ce642b 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -298,8 +298,7 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result,
-			sectorsize);
+	btrfs_csum_data(csum_type, (u8 *)data, csum_result, sectorsize);
 	write_extent_buffer(leaf, csum_result, (unsigned long)item,
 			    csum_size);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 06c50ad8db09..6ed1191948d8 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1392,7 +1392,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 		printf("%02hhx", (int)(eb->data[i]));
 	printf("\n");
 	memset(csum, 0, sizeof(csum));
-	btrfs_csum_data(fs_info, btrfs_super_csum_type(fs_info->super_copy),
+	btrfs_csum_data(btrfs_super_csum_type(fs_info->super_copy),
 			(u8 *)eb->data + BTRFS_CSUM_SIZE,
 			csum, fs_info->nodesize - BTRFS_CSUM_SIZE);
 	printf("checksum calced ");
@@ -1902,7 +1902,7 @@ static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 
-	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
diff --git a/tune/change-csum.c b/tune/change-csum.c
index 46aa96237960..1efb6fd60758 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -158,8 +158,7 @@ static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 			error("failed to read logical %llu: %m", logical);
 			continue;
 		}
-		btrfs_csum_data(fs_info, fs_info->csum_type, data_buf, csum_has,
-				sectorsize);
+		btrfs_csum_data(fs_info->csum_type, data_buf, csum_has, sectorsize);
 		if (memcmp(csum_has, old_csums, fs_info->csum_size) == 0) {
 			found_good = true;
 			break;
@@ -577,9 +576,9 @@ static int rewrite_tree_block_csum(struct btrfs_fs_info *fs_info, u64 logical,
 	}
 
 	/* Verify the csum first. */
-	btrfs_csum_data(fs_info, fs_info->csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(fs_info->csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
 			result_old, fs_info->nodesize - BTRFS_CSUM_SIZE);
-	btrfs_csum_data(fs_info, new_csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(new_csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
 			result_new, fs_info->nodesize - BTRFS_CSUM_SIZE);
 
 	/* Matches old csum, rewrite. */
-- 
2.49.0


