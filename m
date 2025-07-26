Return-Path: <linux-btrfs+bounces-15690-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65FB12CF9
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE8A17A0C0
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F02045B7;
	Sat, 26 Jul 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CpPflj2x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CpPflj2x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735F262BE
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569221; cv=none; b=TOY9OQq6AD3VcQwESBmrwH7bZohNW03mPonHneUYs3nVhqMctqY1+N3yK/kHpQfAlaD1ejiMDnF4CZiU+nRHkQuO+Lg+ExBasn8SNkd0I2VxBy9yMcojKRyiIG6hTkwcKixmqNVU1QBQ1mebqufrq2dca25qpcZ+wwNfBS5h5CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569221; c=relaxed/simple;
	bh=mYOPzPr41nwiYn1ZcrK9nrzlunfeTCzXZHOCxoZXNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoUADaU+AgZIKNLPXgLPoWOT63vwVu7QoZmE4uN3Z8OflmsWW8QYDJG8EreVNlOwf+iTx0MhydHFQnSu7B4HvV+pVwDyvYUaZNBjx1tX+mGS/ftndyWfO66QApp7xGcRBImEmiBIvPQhQhGR/HlzGCww7rrd+9TJapbw3s3jKdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CpPflj2x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CpPflj2x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FEFA1F44F;
	Sat, 26 Jul 2025 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXccSAdb0LhQRg0BThgdhssAEXMeLHtCk5sQug0zWKA=;
	b=CpPflj2xtnGA+Nrc5gOuxxYpVYxydEYR+fC3pmPMAyx3pIDN1KRZiyjUikI4WdaczYqw4v
	maKnbmJGpTlKwbU1Y4/qdVadVCZJijko6XyUe6u38CpALvRG4haAyV+xjLhnrR5FF409eR
	oSmS1em3AF8LcZYxzYMbKrFxEEGJMFI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CpPflj2x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXccSAdb0LhQRg0BThgdhssAEXMeLHtCk5sQug0zWKA=;
	b=CpPflj2xtnGA+Nrc5gOuxxYpVYxydEYR+fC3pmPMAyx3pIDN1KRZiyjUikI4WdaczYqw4v
	maKnbmJGpTlKwbU1Y4/qdVadVCZJijko6XyUe6u38CpALvRG4haAyV+xjLhnrR5FF409eR
	oSmS1em3AF8LcZYxzYMbKrFxEEGJMFI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E0F1388B;
	Sat, 26 Jul 2025 22:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OOkdFrZXhWjWLAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 26 Jul 2025 22:33:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v2 2/3] btrfs-progs: check/lowmem: detect missing orphan items correctly
Date: Sun, 27 Jul 2025 08:03:01 +0930
Message-ID: <6f5fcc446d67c01954caddc3362665800ac8a699.1753569083.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753569082.git.wqu@suse.com>
References: <cover.1753569082.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9FEFA1F44F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

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

Reviewed-by: Boris Burkov <boris@bur.io>
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
2.50.1


