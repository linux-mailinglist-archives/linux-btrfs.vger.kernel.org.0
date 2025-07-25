Return-Path: <linux-btrfs+bounces-15664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27013B11726
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 05:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F891CE2A5B
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jul 2025 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C09D23A997;
	Fri, 25 Jul 2025 03:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NEp0gtnt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NEp0gtnt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6D422F16E
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753414874; cv=none; b=W2DqN6JFOa01U/l4+LqZBMt3oVGH79B2/jUQ0LJOHS5Y5Wjnr84OOLeJOdjvUOpNLqafRlHkDXhkjWAPFIBiLs8hjIUWDzA2YeMVlVBc4LbKOHd4DWNOWUz4ActuCnbn3DSBtuWl1Rxe9NgJil5/BeMaawsP5QaD8WIAbVexBHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753414874; c=relaxed/simple;
	bh=r+KfEoyr3QHQDhqD64Eg+GJ6r1q6OvCNegiSHlYMT/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNxw52atx6NZbXDf4+gRBBfuwZ4q7nbmEithBURjlkUA2hNum3SJIoMAUBInDcltjzoPmMLPjzNlX000D+FdfvF7atrK8xrNTaDLWTRMrCcpKhLTa1Cq75mM4ahYXPjpYeEVZZdyxcevU4aMA9gdr+RwSJDbOyBm3c782nGGQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NEp0gtnt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NEp0gtnt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E44231F387
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUYgSK/kP8pDTzFukib24TRUIlhi/XcSBxMjiZT4lE0=;
	b=NEp0gtntKoNOqrySN13bEk1RNzdSkqgOKgI2EnlzxjJxVPApdz4GQszRyv8WpKYpA6q1ZR
	Dkz4mciPdfMH3xvhSDf7iNlmcpoZ/gb7UdUroZLmqNPYGZ1dIsQ0lHMHKSfl5zoiaa+fG7
	I8s9ryIWjxFuwrJl5VBtcNtzL11OZwU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753414864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUYgSK/kP8pDTzFukib24TRUIlhi/XcSBxMjiZT4lE0=;
	b=NEp0gtntKoNOqrySN13bEk1RNzdSkqgOKgI2EnlzxjJxVPApdz4GQszRyv8WpKYpA6q1ZR
	Dkz4mciPdfMH3xvhSDf7iNlmcpoZ/gb7UdUroZLmqNPYGZ1dIsQ0lHMHKSfl5zoiaa+fG7
	I8s9ryIWjxFuwrJl5VBtcNtzL11OZwU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CFE2134E8
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MF0rOM/8gmjbDQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Jul 2025 03:41:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/lowmem: detect missing orphan items correctly
Date: Fri, 25 Jul 2025 13:10:42 +0930
Message-ID: <1966102e66564d051a74b2f113fd66f050afaf76.1753414100.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753414100.git.wqu@suse.com>
References: <cover.1753414100.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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

[BUG]
If we have a filesystem with a subvolume that has 0 refs but without an
orphan item, btrfs check won't report any error on it.

  $ btrfs ins dump-tree -t root /dev/test/scratch1
  btrfs-progs v6.15
  root tree
  node 5242880 level 1 items 2 free space 119 generation 11 owner ROOT_TREE
  node 5242880 flags 0x1(WRITTEN) backref revision 1
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
  	key (EXTENT_TREE ROOT_ITEM 0) block 5267456 gen 11
  	key (ROOT_TREE_DIR DIR_ITEM 2378154706) block 5246976 gen 11
  leaf 5267456 items 6 free space 2339 generation 11 owner ROOT_TREE
  leaf 5267456 flags 0x1(WRITTEN) backref revision 1
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  	[...]
  leaf 5246976 items 6 free space 1613 generation 11 owner ROOT_TREE
  leaf 5246976 flags 0x1(WRITTEN) backref revision 1
  checksum stored 47620783
  checksum calced 47620783
  fs uuid ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  chunk uuid 6c373b6d-c866-4c8c-81fa-608bf5ef25e3
  	[...]
  	item 4 key (256 ROOT_ITEM 0) itemoff 2202 itemsize 439
  		generation 9 root_dirid 256 bytenr 5898240 byte_limit 0 bytes_used 581632
  		last_snapshot 0 flags 0x1000000000000(none) refs 0 <<<
  		drop_progress key (0 UNKNOWN.0 0) drop_level 0
  		level 2 generation_v2 9
  	item 5 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 1763 itemsize 439
  		generation 5 root_dirid 256 bytenr 5287936 byte_limit 0 bytes_used 4096
  		last_snapshot 0 flags 0x0(none) refs 1
  		drop_progress key (0 UNKNOWN.0 0) drop_level 0
  		level 0 generation_v2 5
  	^^^ No orphan item for subvolume 256.

Then "btrfs check --mode=lowmem" will not report anything wrong with it:

  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  [3/8] checking extents
  [4/8] checking free space tree
  [5/8] checking fs roots
  [6/8] checking only csums items (without verifying data)
  [7/8] checking root refs done with fs roots in lowmem mode, skipping
  [8/8] checking quota groups skipped (not enabled on this FS)
  found 638976 bytes used, no error found <<
  total csum bytes: 0
  total tree bytes: 638976
  total fs tree bytes: 589824
  total extent tree bytes: 16384
  btree space waste bytes: 289501
  file data blocks allocated: 0
   referenced 0

[CAUSE]
In lowmem's check_btrfs_root() we have no special handling for refs 0,
as long as there is no ROOT_BACKREF for the orphan root, everything will
be reported as OK.

But we should expect an orphan item for an orphan subvolume, this means
lowmem doesn't do any checks against the orphan item for a subvolume.

[FIX]
For subvolume trees, if its refs is 0, also check if we have an orphan
item for it.
If not, report this as an error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 5291070df025..e05bb0da1709 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5502,6 +5502,17 @@ static int check_btrfs_root(struct btrfs_root *root, int check_all)
 			}
 		}
 	}
+	/*
+	 * If this tree is a subvolume (not a reloc tree) and has no refs, there
+	 * should be an orphan item for it, or this subvolume will never be deleted.
+	 */
+	if (btrfs_root_refs(root_item) == 0 && is_fstree(btrfs_root_id(root))) {
+		if (!has_orphan_item(root->fs_info->tree_root,
+				     btrfs_root_id(root))) {
+			error("missing orphan item for root %lld", btrfs_root_id(root));
+			err |= REFERENCER_MISSING;
+		}
+	}
 	if (btrfs_root_refs(root_item) > 0 ||
 	    btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		path.nodes[level] = root->node;
-- 
2.50.0


