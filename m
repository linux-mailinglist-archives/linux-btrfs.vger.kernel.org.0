Return-Path: <linux-btrfs+bounces-11052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CCCA1AF5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 05:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30300188C45D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 04:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91201D6DBB;
	Fri, 24 Jan 2025 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L+3PPI5f";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L+3PPI5f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CF45016
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737692396; cv=none; b=ZHiQOR4LwizHNotIYDm2L75I8UGsCPkhciCepNnEJCOnJKhepWzJ6U9f+Giyy2qy8ruU8zYbafr+PnJDdTagEMYOOmTDVAFMC1yvnqH/vdtoJ36ora8OM6vsM9C+3mu7PQnkLKMGJJbMACOHaf0oUJZHFKBgG/4mteWty6Jzh8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737692396; c=relaxed/simple;
	bh=W/Ns04XdKxjyO/js6My3sSDUijCr+gxLtSeBaUb9RRk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fIPgEy+V6vw4V8M3IHpbUYQZn+s/DOa8MvGcjy6Qd8zxyKXVYc1WaVYV2SU64YdpqNv5bjDZ9K8CyGSbOv8SPJkq5U2NO9CY4amWlp+K9pw8eBUR0rr5li3uz8K+frziKlmuiXgng1srwrtTB67rfzBB2g249aTFP3V0X3ShNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L+3PPI5f; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L+3PPI5f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 853E421180
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 04:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737692392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tmXYu6d584qKwaLMUxqpG0dRiRcGhyfeWEcesL1GehI=;
	b=L+3PPI5fRYhMIcuBj8mF2goRUq6+OY8dxHxJoGrvRHzeYUAPIiRtB5lHULNBTwSG7QVNKT
	St0ZnTGVnoVLM2RhTzz8RSfrZ9ZEWdjDTZ2n5rdo6AJuMHkt77FT5BXDKWClTpX4rdkkNd
	Zv+QHUaVUsc11hJWLHpe1Y7ik8tFPlE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=L+3PPI5f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1737692392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tmXYu6d584qKwaLMUxqpG0dRiRcGhyfeWEcesL1GehI=;
	b=L+3PPI5fRYhMIcuBj8mF2goRUq6+OY8dxHxJoGrvRHzeYUAPIiRtB5lHULNBTwSG7QVNKT
	St0ZnTGVnoVLM2RhTzz8RSfrZ9ZEWdjDTZ2n5rdo6AJuMHkt77FT5BXDKWClTpX4rdkkNd
	Zv+QHUaVUsc11hJWLHpe1Y7ik8tFPlE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7426313999
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 04:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sHR5B+cUk2fzPwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 04:19:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: export per-inode stable writes flag
Date: Fri, 24 Jan 2025 14:49:28 +1030
Message-ID: <31652cd455fd5814440672e8bed8f1361d53f459.1737692275.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 853E421180
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The address space flag AS_STABLE_WRITES determine if FGP_STABLE for will
wait for the folio to finish its writeback.

For btrfs, due to the default data checksum behavior, if we modify the
folio while it's still under writeback, it will cause data checksum
mismatch.
Thus for quite some call sites we manually call folio_wait_writeback()
to prevent such problem from happneing.

Currently there is only one call site inside btrfs really utilize
FGP_STABLE, and in that case we also manually call folio_wait_writeback()
to do the wait.

But it's better to properly export the stable writes flag to a per-inode
basis.

This involves:

- Update the mapping's stable write flag when setting/clearing NODATASUM
  inode flag using ioctl
  This only works for empty files, so it should be fine.

- Update the mapping's stable write flag when reading an inode from disk

- Remove the explicitly folio_wait_writeback() for FGP_BEGINWRITE call
  site

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the superblock SB_I_STABLE_WRITES flag
  Since we're setting the proper flag for each inode, there is no need
  to bother the superblock flag anymore.
---
 fs/btrfs/btrfs_inode.h | 8 ++++++++
 fs/btrfs/file.c        | 1 -
 fs/btrfs/inode.c       | 2 ++
 fs/btrfs/ioctl.c       | 8 ++++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b2fa33911c28..b090a435675a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -516,6 +516,14 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
 	lockdep_assert_held(&inode->vfs_inode.i_rwsem);
 }
 
+static inline void btrfs_update_address_space_flags(struct btrfs_inode *inode)
+{
+	if (inode->flags & BTRFS_INODE_NODATASUM)
+		mapping_clear_stable_writes(inode->vfs_inode.i_mapping);
+	else
+		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
+}
+
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bb821fb89fc1..68b14ee1f85c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -875,7 +875,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 			ret = PTR_ERR(folio);
 		return ret;
 	}
-	folio_wait_writeback(folio);
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
 	ret = set_folio_extent_mapped(folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b3fdba10245..c4769c438859 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3948,6 +3948,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+	btrfs_update_address_space_flags(BTRFS_I(inode));
 
 cache_index:
 	/*
@@ -6363,6 +6364,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (btrfs_test_opt(fs_info, NODATACOW))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
+		btrfs_update_address_space_flags(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69c0444369b7..c70e4d2d9b27 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -325,9 +325,11 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 			 * Otherwise we want the flag to reflect the real COW
 			 * status of the file and will not set it.
 			 */
-			if (inode->i_size == 0)
+			if (inode->i_size == 0) {
 				binode_flags |= BTRFS_INODE_NODATACOW |
 						BTRFS_INODE_NODATASUM;
+				btrfs_update_address_space_flags(binode);
+			}
 		} else {
 			binode_flags |= BTRFS_INODE_NODATACOW;
 		}
@@ -336,9 +338,11 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 		 * Revert back under same assumptions as above
 		 */
 		if (S_ISREG(inode->i_mode)) {
-			if (inode->i_size == 0)
+			if (inode->i_size == 0) {
 				binode_flags &= ~(BTRFS_INODE_NODATACOW |
 						  BTRFS_INODE_NODATASUM);
+				btrfs_update_address_space_flags(binode);
+			}
 		} else {
 			binode_flags &= ~BTRFS_INODE_NODATACOW;
 		}
-- 
2.48.1


