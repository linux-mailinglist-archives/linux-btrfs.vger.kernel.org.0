Return-Path: <linux-btrfs+bounces-17850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24EBDFC50
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC43C3C61
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD69933768B;
	Wed, 15 Oct 2025 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFrLu9cT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MFrLu9cT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36332C11D4
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547047; cv=none; b=OkyEa7I/RmgpTlcB8CG5bHcO0uAilj+/kS85SLTcPaJCzG8d3ivWmvT+lxIvZYBUM+VcIh1ky+X9zJEvfk92EDjWvBddcxarlQGNCVjtwup8Ek+kbfFV0aDMhMtX8gmjaUtl2VUMvycW0iOtppCuZ4mtRy9qCtZL9u9QvxpHFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547047; c=relaxed/simple;
	bh=/5/gwif7D91Kd60hYRjrO+ILl/a4JRo2PamhEFAsir0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6M3BHGdE28KoCkiCMyyKJwKIfV6pcFGx3HDfNwS/iwbqKX/1UX2yktufWnODF6SANAh32517bICXnLcrUaJWe/maUFtDSFjzsM8KIOBChKG2+IMrSrSIKSvKeDQiqNPEIsdpP7NBk8CyZz8oqHxmTW1VyIZ5o+c0E8qorKL/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFrLu9cT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MFrLu9cT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC405BCC8;
	Wed, 15 Oct 2025 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760547042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zy756eevkW1tFsjDJvbq45zWGdffgftrXk51kRwVojI=;
	b=MFrLu9cTrw6ktOnj2NpXcjpPrckeB+oPct0C8YIJNwhC8H55xhYS8tYDciKtnGt6z3RAiV
	eiS5YGadPaI/FYIpnBtutjyyDo051FRimet9K0RMK6Qiy1oUJMM2XrDmRCkUL7mIpmbXQg
	FMxJwAFLltvG7rbjqr21yJE8kh01CC4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1760547042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zy756eevkW1tFsjDJvbq45zWGdffgftrXk51kRwVojI=;
	b=MFrLu9cTrw6ktOnj2NpXcjpPrckeB+oPct0C8YIJNwhC8H55xhYS8tYDciKtnGt6z3RAiV
	eiS5YGadPaI/FYIpnBtutjyyDo051FRimet9K0RMK6Qiy1oUJMM2XrDmRCkUL7mIpmbXQg
	FMxJwAFLltvG7rbjqr21yJE8kh01CC4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6957613A29;
	Wed, 15 Oct 2025 16:50:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHNoGeLQ72h9FQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 15 Oct 2025 16:50:42 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: move and rename CSUM_FMT definition
Date: Wed, 15 Oct 2025 18:48:37 +0200
Message-ID: <20251015165038.1995430-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.904];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.78
X-Spam-Level: 

Move the CSUM_FMT* definitions to fs.h where will be the BTRFS_KEY_FMT
and add the prefix for consistency.

Signed-off-by: David Sterba <dsterba@suse.com>
---

Related to https://lore.kernel.org/linux-btrfs/c488454c158cdb7f394e561a1fb1ee774bbfbea9.1760530704.git.fdmanana@suse.com/
but the lines get longer than necessary, I'm not sure the prefix is
worth it.

 fs/btrfs/btrfs_inode.h |  4 ----
 fs/btrfs/disk-io.c     |  6 +++---
 fs/btrfs/fs.h          |  4 ++++
 fs/btrfs/inode.c       | 24 ++++++++++++------------
 fs/btrfs/scrub.c       |  6 +++---
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index af373d50a901f2..4f048d61b67070 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -543,10 +543,6 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 #endif
 }
 
-/* Array of bytes with variable length, hexadecimal format 0x1234 */
-#define CSUM_FMT				"0x%*phN"
-#define CSUM_FMT_VALUE(size, bytes)		size, bytes
-
 void btrfs_calculate_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr,
 				u8 *dest);
 int btrfs_check_block_csum(struct btrfs_fs_info *fs_info, phys_addr_t paddr, u8 *csum,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f6c..efa968090f4c99 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -398,10 +398,10 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
-"checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d%s",
+"checksum verify failed on logical %llu mirror %u wanted " BTRFS_CSUM_FMT " found " BTRFS_CSUM_FMT " level %d%s",
 			      eb->start, eb->read_mirror,
-			      CSUM_FMT_VALUE(csum_size, header_csum),
-			      CSUM_FMT_VALUE(csum_size, result),
+			      BTRFS_CSUM_FMT_VALUE(csum_size, header_csum),
+			      BTRFS_CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb),
 			      ignore_csum ? ", ignored" : "");
 		if (unlikely(!ignore_csum)) {
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0bb0c01d795222..68da0aa406f806 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -74,6 +74,10 @@ struct btrfs_space_info;
 #define BTRFS_SUPER_INFO_SIZE			4096
 static_assert(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
+/* Array of bytes with variable length, hexadecimal format 0x1234 */
+#define BTRFS_CSUM_FMT				"0x%*phN"
+#define BTRFS_CSUM_FMT_VALUE(size, bytes)	size, bytes
+
 /*
  * Number of metadata items necessary for an unlink operation:
  *
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bd953146eda765..7a36db0567d517 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -233,21 +233,21 @@ static void print_data_reloc_error(const struct btrfs_inode *inode, u64 file_off
 	if (logical == U64_MAX) {
 		btrfs_warn_rl(fs_info, "has data reloc tree but no running relocation");
 		btrfs_warn_rl(fs_info,
-"csum failed root %lld ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+"csum failed root %lld ino %llu off %llu csum " BTRFS_CSUM_FMT " expected csum " BTRFS_CSUM_FMT " mirror %d",
 			btrfs_root_id(inode->root), btrfs_ino(inode), file_off,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum_expected),
 			mirror_num);
 		return;
 	}
 
 	logical += file_off;
 	btrfs_warn_rl(fs_info,
-"csum failed root %lld ino %llu off %llu logical %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+"csum failed root %lld ino %llu off %llu logical %llu csum " BTRFS_CSUM_FMT " expected csum " BTRFS_CSUM_FMT " mirror %d",
 			btrfs_root_id(inode->root),
 			btrfs_ino(inode), file_off, logical,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum_expected),
 			mirror_num);
 
 	ret = extent_from_logical(fs_info, logical, &path, &found_key, &flags);
@@ -318,19 +318,19 @@ static void __cold btrfs_print_data_csum_error(struct btrfs_inode *inode,
 	/* Output without objectid, which is more meaningful */
 	if (btrfs_root_id(root) >= BTRFS_LAST_FREE_OBJECTID) {
 		btrfs_warn_rl(root->fs_info,
-"csum failed root %lld ino %lld off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+"csum failed root %lld ino %lld off %llu csum " BTRFS_CSUM_FMT " expected csum " BTRFS_CSUM_FMT " mirror %d",
 			btrfs_root_id(root), btrfs_ino(inode),
 			logical_start,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum_expected),
 			mirror_num);
 	} else {
 		btrfs_warn_rl(root->fs_info,
-"csum failed root %llu ino %llu off %llu csum " CSUM_FMT " expected csum " CSUM_FMT " mirror %d",
+"csum failed root %llu ino %llu off %llu csum " BTRFS_CSUM_FMT " expected csum " BTRFS_CSUM_FMT " mirror %d",
 			btrfs_root_id(root), btrfs_ino(inode),
 			logical_start,
-			CSUM_FMT_VALUE(csum_size, csum),
-			CSUM_FMT_VALUE(csum_size, csum_expected),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum),
+			BTRFS_CSUM_FMT_VALUE(csum_size, csum_expected),
 			mirror_num);
 	}
 }
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index fe266785804e19..7f8ccf76d5dad7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -777,10 +777,10 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-"scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
+"scrub: tree block %llu mirror %u has bad csum, has " BTRFS_CSUM_FMT " want " BTRFS_CSUM_FMT,
 			      logical, stripe->mirror_num,
-			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
-			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
+			      BTRFS_CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
+			      BTRFS_CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
 		return;
 	}
 	if (stripe->sectors[sector_nr].generation !=
-- 
2.51.0


