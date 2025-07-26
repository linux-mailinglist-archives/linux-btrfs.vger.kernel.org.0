Return-Path: <linux-btrfs+bounces-15688-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74295B12CF7
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 00:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAF31C214D1
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Jul 2025 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5A20E33F;
	Sat, 26 Jul 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sCAUQb/x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sCAUQb/x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A1262BE
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569211; cv=none; b=T/h628zOKd4VPg1gq8xgdB0JFfOqX6wIM6otPmBlsCL5EKHAFmI23Iso9/Htr2xE9MP1MGn8bQpLdvvr0NTPv+zvAWLDplsAzawN5TuY+bEhygIafMsqRE4xcQLtSXjbA+Q7Cc0EI621b9RBKEL9fUdcrCNVkhZn//v+3dhqT4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569211; c=relaxed/simple;
	bh=u0vzQKlTkqU0CgBP/iw22cmaiN+xFvUAgd5bSfs+VfQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH5BjCQ+STo7O1ijqj/KC8QeIsD+XsILUZ30MYQLn/YqZVgsc/5eaP9+lbePltthQzolbr7sh44omPt1SjfoBh+64glO7nwbDNrosLIU8E1iMZCyU/aWlWCl05EmrFFnHKseYfRe1IknFRQm8yEpf65FiK+utLKAl5f6ZzuGYro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sCAUQb/x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sCAUQb/x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 257A521A1D
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeVFpRT3Q9+JpszLiyxzZYJNyzXHr0V2zxgAmSfhc90=;
	b=sCAUQb/x1Ps+Bb03+Jo5l7TIBaFuY7sO+hzMCD3F8sngLNoaqvkY0Jk7UHNCfiCLjcq22X
	4YGho1bb+fZZ8ccpmYbii37aEy1AwJtDKWD25ckp/DaVuhHKR8HhQhssP2BAi72tDY8flp
	8LKhKFThoEvNJhzOjHX4iawBeGOdyuU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="sCAUQb/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753569206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XeVFpRT3Q9+JpszLiyxzZYJNyzXHr0V2zxgAmSfhc90=;
	b=sCAUQb/x1Ps+Bb03+Jo5l7TIBaFuY7sO+hzMCD3F8sngLNoaqvkY0Jk7UHNCfiCLjcq22X
	4YGho1bb+fZZ8ccpmYbii37aEy1AwJtDKWD25ckp/DaVuhHKR8HhQhssP2BAi72tDY8flp
	8LKhKFThoEvNJhzOjHX4iawBeGOdyuU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 588B91388B
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2K+eBrVXhWjWLAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 26 Jul 2025 22:33:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs-progs: check/original: detect missing orphan items correctly
Date: Sun, 27 Jul 2025 08:03:00 +0930
Message-ID: <f70e15b0807b095d67520bba6025d4b34e012631.1753569083.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 257A521A1D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
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

Then "btrfs check" will not report anything wrong with it:

  Opening filesystem to check...
  Checking filesystem on /dev/test/scratch1
  UUID: ff32309e-4e90-4402-b1ef-0a1f9f28bfff
  [1/8] checking log skipped (none written)
  [2/8] checking root items
  [3/8] checking extents
  [4/8] checking free space tree
  [5/8] checking fs roots
  [6/8] checking only csums items (without verifying data)
  [7/8] checking root refs
  [8/8] checking quota groups skipped (not enabled on this FS)
  found 638976 bytes used, no error found <<<
  total csum bytes: 0
  total tree bytes: 638976
  total fs tree bytes: 589824
  total extent tree bytes: 16384
  btree space waste bytes: 289501
  file data blocks allocated: 0
   referenced 0

[CAUSE]
Although we have check_orphan_item() call inside check_root_refs(), it
relies the root record to have its 'found_root_item' member set.
Otherwise it will not report this as an error.

But that 'found_root_item' is always set to 0, if the subvolume has zero
ref. This means any subvolume with 0 refs will not have its orphan item
checked.

[FIX]
- Introduce root_record::expected_ref to record the refs in the root
  item
  So that we can properly compare the number of refs for each subvolume
  tree.

- Set root_record::found_root_item to one unconditionally in
  check_fs_root()
  Since we're accessing the fs root through the root item, the root item
  must exist, no need to bother if the root_refs is zero or not.

- Enhance check_root_refs()
  * Always check if btrfs_root_item::refs match root_record::found_ref
  * If the fs tree has no ref, check for the orphan item

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          | 39 +++++++++++++++++++++++----------------
 check/mode-original.h |  3 +++
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/check/main.c b/check/main.c
index b78eb59d0c50..84b6de597072 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3491,22 +3491,29 @@ static int check_root_refs(struct btrfs_root *root,
 		rec = container_of(cache, struct root_record, cache);
 		cache = next_cache_extent(cache);
 
-		if (rec->found_ref == 0 &&
-		    rec->objectid >= BTRFS_FIRST_FREE_OBJECTID &&
+		/* A subvolume tree, should check if its refs match. */
+		if (rec->objectid >= BTRFS_FIRST_CHUNK_TREE_OBJECTID &&
 		    rec->objectid <= BTRFS_LAST_FREE_OBJECTID) {
-			ret = check_orphan_item(gfs_info->tree_root, rec->objectid);
-			if (ret == 0)
+			if (rec->found_ref != rec->expected_ref) {
+				errors++;
+				fprintf(stderr, "fs tree %llu refs mismatch found %u expect %u\n",
+					rec->objectid, rec->found_ref, rec->expected_ref);
 				continue;
-
-			/*
-			 * If we don't have a root item then we likely just have
-			 * a dir item in a snapshot for this root but no actual
-			 * ref key or anything so it's meaningless.
-			 */
-			if (!rec->found_root_item)
-				continue;
-			errors++;
-			fprintf(stderr, "fs tree %llu not referenced\n", rec->objectid);
+			}
+			if (rec->expected_ref == 0) {
+				ret = check_orphan_item(gfs_info->tree_root, rec->objectid);
+				if (ret == 0)
+					continue;
+				/*
+				 * If we don't have a root item then we likely just have
+				 * a dir item in a snapshot for this root but no actual
+				 * ref key or anything so it's meaningless.
+				 */
+				if (!rec->found_root_item)
+					continue;
+				errors++;
+				fprintf(stderr, "fs tree %llu missing orphan item\n", rec->objectid);
+			}
 		}
 
 		error = 0;
@@ -3728,8 +3735,8 @@ static int check_fs_root(struct btrfs_root *root,
 	if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
 		rec = get_root_rec(root_cache, root->root_key.objectid);
 		BUG_ON(IS_ERR(rec));
-		if (btrfs_root_refs(root_item) > 0)
-			rec->found_root_item = 1;
+		rec->found_root_item = 1;
+		rec->expected_ref = btrfs_root_refs(&root->root_item);
 	}
 
 	memset(&root_node, 0, sizeof(root_node));
diff --git a/check/mode-original.h b/check/mode-original.h
index 24d245795714..d928389f8582 100644
--- a/check/mode-original.h
+++ b/check/mode-original.h
@@ -263,7 +263,10 @@ struct root_record {
 	struct cache_extent cache;
 	unsigned int found_root_item:1;
 	u64 objectid;
+	/* The found number of refs in tree root. */
 	u32 found_ref;
+	/* The expected number of refs in root item. */
+	u32 expected_ref;
 };
 
 struct ptr_node {
-- 
2.50.1


