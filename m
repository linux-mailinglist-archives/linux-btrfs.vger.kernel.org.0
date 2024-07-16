Return-Path: <linux-btrfs+bounces-6493-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44193228D
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 11:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4DC1F23325
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 09:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406DE195997;
	Tue, 16 Jul 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QyCYAM5Z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QyCYAM5Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEF5FEE6;
	Tue, 16 Jul 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121373; cv=none; b=FlgkAFwXr/rwCp7CabVEONVRULck8rSmnFH4xZIInRVDla+mzo09Ozkr4JA9Rb23K8aduizASDUpsDwz0RlUnFgnm9xR5XyAE/4+tuBQWUXfv0ofnpuY+/1/jGfuEm2visNgrj3TWpxV6H2U/S+qozUYk4awDxbdUNGS7232JZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121373; c=relaxed/simple;
	bh=5cP7OIQVR2dmtsz4oIsA7AaRpuCuToiZVD2PLIJ19Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnm1HhDxRgdP93ocowa+MRhew1hTeJD0+ux3O9HhTbsXZxNtw3i3bgVyYcggJzhI4uRVdfaiPQzZ8fmRnPS3f7F5n4UjiDKLCvdl5YGQFP+F7cfdoANTGZ+zk9ZnT6VpigFWiwrjCB+pBmc2EvQIotb64zWlXme8ubgWKcrwOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QyCYAM5Z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QyCYAM5Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99A631F898;
	Tue, 16 Jul 2024 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721121369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=11ZY7PLYj426xE59CvkeEnqZyKq2GcDcCyy0siAsbsU=;
	b=QyCYAM5Z5PJwjm5k8PXO/1+FlbmHbfJNS2SECdQ7Dx9NG35Ha/bu9j1WJF4l0O1CZvVML7
	7GhBahuFCOnZsC2I59ropZsx+3REzApI0StzRLHxhzv3NIBVt5dUM2ai3RtJ0Rf95HdnAC
	peIUeJzGr++70ocORbv99B4OqEdghnc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QyCYAM5Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721121369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=11ZY7PLYj426xE59CvkeEnqZyKq2GcDcCyy0siAsbsU=;
	b=QyCYAM5Z5PJwjm5k8PXO/1+FlbmHbfJNS2SECdQ7Dx9NG35Ha/bu9j1WJF4l0O1CZvVML7
	7GhBahuFCOnZsC2I59ropZsx+3REzApI0StzRLHxhzv3NIBVt5dUM2ai3RtJ0Rf95HdnAC
	peIUeJzGr++70ocORbv99B4OqEdghnc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4F6F13795;
	Tue, 16 Jul 2024 09:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id odRhJ1c6lmagGAAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 16 Jul 2024 09:16:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6] btrfs: tree-checker: add type and sequence check for inline backrefs
Date: Tue, 16 Jul 2024 18:45:49 +0930
Message-ID: <63189f5d922db2bc525f5251be46fe857e00a2d6.1721120987.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 99A631F898

commit 1645c283a87c61f84b2bffd81f50724df959b11a upstream.

[BUG]
There is a bug report that ntfs2btrfs had a bug that it can lead to
transaction abort and the filesystem flips to read-only.

[CAUSE]
For inline backref items, kernel has a strict requirement for their
ordered, they must follow the following rules:

- All btrfs_extent_inline_ref::type should be in an ascending order

- Within the same type, the items should follow a descending order by
  their sequence number

  For EXTENT_DATA_REF type, the sequence number is result from
  hash_extent_data_ref().
  For other types, their sequence numbers are
  btrfs_extent_inline_ref::offset.

Thus if there is any code not following above rules, the resulted
inline backrefs can prevent the kernel to locate the needed inline
backref and lead to transaction abort.

[FIX]
Ntrfs2btrfs has already fixed the problem, and btrfs-progs has added the
ability to detect such problems.

For kernel, let's be more noisy and be more specific about the order, so
that the next time kernel hits such problem we would reject it in the
first place, without leading to transaction abort.

Cc: stable@vger.kernel.org # 6.6
Link: https://github.com/kdave/btrfs-progs/pull/622
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
[ Fix a conflict due to header cleanup. ]
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-checker.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index cc6bc5985120..5d6cfa618dc4 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -29,6 +29,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "inode-item.h"
+#include "extent-tree.h"
 
 /*
  * Error message should follow the following format:
@@ -1274,6 +1275,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 	unsigned long ptr;	/* Current pointer inside inline refs */
 	unsigned long end;	/* Extent item end */
 	const u32 item_size = btrfs_item_size(leaf, slot);
+	u8 last_type = 0;
+	u64 last_seq = U64_MAX;
 	u64 flags;
 	u64 generation;
 	u64 total_refs;		/* Total refs in btrfs_extent_item */
@@ -1320,6 +1323,18 @@ static int check_extent_item(struct extent_buffer *leaf,
 	 *    2.2) Ref type specific data
 	 *         Either using btrfs_extent_inline_ref::offset, or specific
 	 *         data structure.
+	 *
+	 *    All above inline items should follow the order:
+	 *
+	 *    - All btrfs_extent_inline_ref::type should be in an ascending
+	 *      order
+	 *
+	 *    - Within the same type, the items should follow a descending
+	 *      order by their sequence number. The sequence number is
+	 *      determined by:
+	 *      * btrfs_extent_inline_ref::offset for all types  other than
+	 *        EXTENT_DATA_REF
+	 *      * hash_extent_data_ref() for EXTENT_DATA_REF
 	 */
 	if (unlikely(item_size < sizeof(*ei))) {
 		extent_err(leaf, slot,
@@ -1401,6 +1416,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_extent_inline_ref *iref;
 		struct btrfs_extent_data_ref *dref;
 		struct btrfs_shared_data_ref *sref;
+		u64 seq;
 		u64 dref_offset;
 		u64 inline_offset;
 		u8 inline_type;
@@ -1414,6 +1430,7 @@ static int check_extent_item(struct extent_buffer *leaf,
 		iref = (struct btrfs_extent_inline_ref *)ptr;
 		inline_type = btrfs_extent_inline_ref_type(leaf, iref);
 		inline_offset = btrfs_extent_inline_ref_offset(leaf, iref);
+		seq = inline_offset;
 		if (unlikely(ptr + btrfs_extent_inline_ref_size(inline_type) > end)) {
 			extent_err(leaf, slot,
 "inline ref item overflows extent item, ptr %lu iref size %u end %lu",
@@ -1444,6 +1461,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
+			seq = hash_extent_data_ref(
+					btrfs_extent_data_ref_root(leaf, dref),
+					btrfs_extent_data_ref_objectid(leaf, dref),
+					btrfs_extent_data_ref_offset(leaf, dref));
 			if (unlikely(!IS_ALIGNED(dref_offset,
 						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
@@ -1470,6 +1491,24 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   inline_type);
 			return -EUCLEAN;
 		}
+		if (inline_type < last_type) {
+			extent_err(leaf, slot,
+				   "inline ref out-of-order: has type %u, prev type %u",
+				   inline_type, last_type);
+			return -EUCLEAN;
+		}
+		/* Type changed, allow the sequence starts from U64_MAX again. */
+		if (inline_type > last_type)
+			last_seq = U64_MAX;
+		if (seq > last_seq) {
+			extent_err(leaf, slot,
+"inline ref out-of-order: has type %u offset %llu seq 0x%llx, prev type %u seq 0x%llx",
+				   inline_type, inline_offset, seq,
+				   last_type, last_seq);
+			return -EUCLEAN;
+		}
+		last_type = inline_type;
+		last_seq = seq;
 		ptr += btrfs_extent_inline_ref_size(inline_type);
 	}
 	/* No padding is allowed */
-- 
2.45.2


