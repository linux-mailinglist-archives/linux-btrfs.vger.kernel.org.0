Return-Path: <linux-btrfs+bounces-17229-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B5DBA56F5
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Sep 2025 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001BD1C2330E
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Sep 2025 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B026A1DFE0B;
	Sat, 27 Sep 2025 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g3yG8l9p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g3yG8l9p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9073A18DB16
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Sep 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758934278; cv=none; b=VXIb4pX7CHiDuhf5QltgCK92/7uiN7fBnAPU+yOr3EJ8Ecy/KGZqZHEpklwb3JB3rP8gItL9EVIYfJGQ/zXp3fxCMuNadH7EWicQAsni3nIYLpWF0gV+DZ7cdnRnB1JYFQi1edSSiM7vXWPo34dYYvRUcT1Wgirrly1uhZ03Nzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758934278; c=relaxed/simple;
	bh=AAc4Gh61JVA2OeT506lu5CtQmPQRAqtNYCejfuKPpcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCCk+RtuDv5M6OYER+P+KuQ2vnZNeUwxUpq/4pE3jFT/XTFFnACJR+CWfpTJAwwh0kWQ0z/VUsPxv2XNlrdLkbW3khjdcsaE54QI7pViet1eGto7y9lBMB+KshPuWQBtN2HMF7EhJ3BCwyBJAT1OCl8v0AB0ufG4BetMHpIMG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g3yG8l9p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g3yG8l9p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66D5122D82;
	Sat, 27 Sep 2025 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758934273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L2g5ASjHWqCjh1GD/6o7NGdpCEsTF3fDGcEsbNK4P18=;
	b=g3yG8l9pxNnA1k2F4Rm/05WUEEjbkAMIE3r44x7lYoDfvBc3E/nIBe1QhSY8nZuVIQ4ovu
	kCq7qbmb/u+H8/Gc596Tb8x3MynN3ewJ+5Bmp67AK2/Lp9Y79zIJN2ArxEVnqwk04XMj9h
	9Erj89plQTKIIIPHxAceafznX0RDW4o=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758934273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=L2g5ASjHWqCjh1GD/6o7NGdpCEsTF3fDGcEsbNK4P18=;
	b=g3yG8l9pxNnA1k2F4Rm/05WUEEjbkAMIE3r44x7lYoDfvBc3E/nIBe1QhSY8nZuVIQ4ovu
	kCq7qbmb/u+H8/Gc596Tb8x3MynN3ewJ+5Bmp67AK2/Lp9Y79zIJN2ArxEVnqwk04XMj9h
	9Erj89plQTKIIIPHxAceafznX0RDW4o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68F121373E;
	Sat, 27 Sep 2025 00:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NVQbCwA112ioQgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 27 Sep 2025 00:51:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] btrfs-progs: remove btrfs_fs_info::leaf_data_size
Date: Sat, 27 Sep 2025 10:20:54 +0930
Message-ID: <635a605be3627ff476d47620f195a74fe5d634a2.1758934058.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
There is a bug report that legacy code of "btrfs rescue chunk-recover"
is triggering false alerts from tree-checker, and refuse to work:

  # btrfs rescue chunk-recover /dev/nvme1n1p1
  Scanning: DONE in dev0
  corrupt leaf: root=1 block=13924671995904 slot=0, unexpected item end, have 16283 expect 0 <<< Note the "expect 0"
  leaf 13924671995904 items 11 free space 12709 generation 1589644 owner ROOT_TREE
  leaf 13924671995904 flags 0x1(WRITTEN) backref revision 1
  [...]
  Couldn't read tree root
  open with broken chunk error

[CAUSE]
The item end checks is from __btrfs_check_leaf() from tree-checker,
and for the first slot of a leaf, the expected end should be
BTRFS_LEAF_DATA_SIZE(), which is fetched from fs_info->leaf_data_size.

However for the fs_info opened by chunk recover, it's not going through
the regular open_ctree(), but open_ctree_with_broken_chunk(), which
doesn't populate that member and resulting BTRFS_LEAF_DATA_SIZE() to
return 0.

[FIX]
There is no need to cache leaf_data_size, as it can be easily calulated
using nodesize.

And kernel is already doing that, so follow the kernel to remove
btrfs_fs_info::leaf_data_size, and use a simple inline function to do
the calculation instead.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CABXGCsOug_bxVZ5CN1EM0sd9U4JAz=Jf5EB2TQe8gs9=KZvWEA@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h   | 8 +++++---
 kernel-shared/disk-io.c | 1 -
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b08e078b5a16..07334208abdf 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -69,8 +69,6 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 #define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
 #endif
 
-#define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
-
 #define BTRFS_SUPER_INFO_OFFSET			(65536)
 #define BTRFS_SUPER_INFO_SIZE			(4096)
 
@@ -401,7 +399,6 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
-	u32 leaf_data_size;
 
 	/*
 	 * For open_ctree_fs_info() to hold the initial fd until close.
@@ -426,6 +423,11 @@ struct btrfs_fs_info {
 	struct super_block *sb;
 };
 
+static inline u32 BTRFS_LEAF_DATA_SIZE(const struct btrfs_fs_info *fs_info)
+{
+	return __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
+}
+
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
 	return fs_info->zoned != 0;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index e8fbc1f986ee..dff800f55a74 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1604,7 +1604,6 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *oca
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 	fs_info->csum_type = btrfs_super_csum_type(disk_super);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
-	fs_info->leaf_data_size = __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
 
 	ret = btrfs_check_fs_compatibility(fs_info->super_copy, flags);
 	if (ret)
-- 
2.50.1


