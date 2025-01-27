Return-Path: <linux-btrfs+bounces-11092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECDDA2017A
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2025 00:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1616571E
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4201DC9AD;
	Mon, 27 Jan 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sZcnxe5s";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sZcnxe5s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC452904
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 23:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738019928; cv=none; b=c5e5PWACHTatHoRQ/qBN27alLa7tpNubJmvxPD3ia/NMAvaN6zi8mPbFk8szRweigtxSo8e4qLFfJ67uIKZ6GdEnNvtuTfCDtDuTy3hcqOe0hJ+P813HINAOTol5ivbTNH+kBTgIwrZSMXBCJZR8lSv4ImdrDKZBZGvx1Obd4fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738019928; c=relaxed/simple;
	bh=B5Kp+VzpsNYT839iMyQbrLOUqt89q8D/miTuZNKFSsM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EEEdmSNkpwHxNbmLz3XqsN3hnhw/VoHqiywd61SUJH49p1CHn1enF487cZhZkh3FqZCT/K3nRuvO6g76VVgxwF4qrXkV37o0Y0FlgBg9WElef2xkeEwohXTi33+DsAZPERCblKEMgc07nEC6oZWIR0uBMBg3NQzdfEALTjsV82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sZcnxe5s; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sZcnxe5s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0A7921108
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738019924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V/hh5Ram7WaZH6+99qO3Z3IV+XkE85MSR89itZNsicI=;
	b=sZcnxe5soAswesBBXJUc1pucBo5kxrsGpVkdiA2x8uf0uATgTrKrj1TpYf1k9zGgTrbXat
	7Pe8fagS5yDkPo4+9jlgjfSfhq1RvIpoHHngkVoSY6tjlSnmNB0eiBg37N99xbBb7q6Bm2
	3VuVVCzMxoRscY+rwP+whBwjCbTJJxw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sZcnxe5s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738019924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V/hh5Ram7WaZH6+99qO3Z3IV+XkE85MSR89itZNsicI=;
	b=sZcnxe5soAswesBBXJUc1pucBo5kxrsGpVkdiA2x8uf0uATgTrKrj1TpYf1k9zGgTrbXat
	7Pe8fagS5yDkPo4+9jlgjfSfhq1RvIpoHHngkVoSY6tjlSnmNB0eiBg37N99xbBb7q6Bm2
	3VuVVCzMxoRscY+rwP+whBwjCbTJJxw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D12F413715
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 23:18:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Gfl9JFMUmGe8NAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 23:18:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: expose per-inode stable writes flag
Date: Tue, 28 Jan 2025 09:48:18 +1030
Message-ID: <d380f7c79d21ea2f5020d07da8518973b519afb4.1738019838.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A0A7921108
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
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
to prevent such problem from happening.

Currently there is only one call site inside btrfs really utilize
FGP_STABLE, and in that case we also manually call folio_wait_writeback()
to do the wait.

But it's better to properly expose the stable writes flag to a per-inode
basis, to allow call sites to fully benefit from FGP_STABLE flag.
E.g. for inodes with NODATASUM allowing beginning dirtying the page
without waiting for writeback.

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
v3:
- Rename "export" to "expose", and slightly update the commit message
  Currently the only usage of AS_STABLE_WRITES is to make
  FGP_STABLE/FGP_BEGINWRITE to wait for writeback.
  Make this point a little more explicit.

- Rename the helper to btrfs_update_inode_mapping_flags()

- Fix the call site inside btrfs_fileattr_set()
  We should only call the helper after btrfs_inode::flags got updated.

v2:
- Remove the superblock SB_I_STABLE_WRITES flag
  Since we're setting the proper flag for each inode, there is no need
  to bother the superblock flag anymore.
---
 fs/btrfs/btrfs_inode.h | 8 ++++++++
 fs/btrfs/file.c        | 1 -
 fs/btrfs/inode.c       | 2 ++
 fs/btrfs/ioctl.c       | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b2fa33911c28..029fba82b81d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -516,6 +516,14 @@ static inline void btrfs_assert_inode_locked(struct btrfs_inode *inode)
 	lockdep_assert_held(&inode->vfs_inode.i_rwsem);
 }
 
+static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
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
index 5b3fdba10245..31d9777c443a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3948,6 +3948,7 @@ static int btrfs_read_locked_inode(struct inode *inode, struct btrfs_path *path)
 
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&BTRFS_I(inode)->flags, &BTRFS_I(inode)->ro_flags);
+	btrfs_update_inode_mapping_flags(BTRFS_I(inode));
 
 cache_index:
 	/*
@@ -6363,6 +6364,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		if (btrfs_test_opt(fs_info, NODATACOW))
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
+		btrfs_update_inode_mapping_flags(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 69c0444369b7..f5f66623551c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -393,6 +393,7 @@ int btrfs_fileattr_set(struct mnt_idmap *idmap,
 
 update_flags:
 	binode->flags = binode_flags;
+	btrfs_update_inode_mapping_flags(binode);
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
 	inode_set_ctime_current(inode);
-- 
2.48.1


