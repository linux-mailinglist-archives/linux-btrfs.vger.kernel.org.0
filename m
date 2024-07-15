Return-Path: <linux-btrfs+bounces-6459-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E96930F79
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 10:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88529B2109E
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812618307B;
	Mon, 15 Jul 2024 08:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NUZTEtkj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NUZTEtkj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6E24B5B
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jul 2024 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721031726; cv=none; b=YCIBpNPD2hPvUMAiucDpHBsldBDL0+HAy2EDRNZ4oarDS8W4ECLmvCG1VfTt0ULWdXxqKh6VjuAvhVESa05zyCq9eji1VsH9UCDYY1tw3Lw8ZOHRpa8iNX/vOUXG5g/h8D0BLjjgjAv52DK7mbTbtr+ruRpZoA/XQWZQDler/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721031726; c=relaxed/simple;
	bh=xzpAtu1HBftvM7uP9fxG7ffsnRHAkwLHA+kFr9iWdTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kSLDpSxosn6snz4jDXnbo+Yb8CDfw1OAh/S363zSawrIqikZHQyzurq4Dsqu665GAH7mDPJSzoLAMRG5xSqxzUZlNIv4csJXHVlp7No+Oxye1tr4QFQoiE56Xu9qJPhQRHDJQLKozpBZ9WkrKIAMUTucmeYtGE1vFzJWmpb5G8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NUZTEtkj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NUZTEtkj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D67902199A;
	Mon, 15 Jul 2024 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721031722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tf6EaJjPnNNvQC5SHo8un062xiq3IV7C3GYp+YBxrWQ=;
	b=NUZTEtkjiD+rWRP2seN87vT2noV98W2Wk7u5jINBvJeiQcXHMSxPMhdn1AhtnafZnVzsXA
	XCJVZ1/vgCl+utVP4a+oq/zezSAzs7gnyh5JK+Xti8/09KZgal4zmR9JW0ChDVoTPiB0jS
	mQ7FIHSR0/5y2qI5gKkRXtj5O+uGdpo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721031722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tf6EaJjPnNNvQC5SHo8un062xiq3IV7C3GYp+YBxrWQ=;
	b=NUZTEtkjiD+rWRP2seN87vT2noV98W2Wk7u5jINBvJeiQcXHMSxPMhdn1AhtnafZnVzsXA
	XCJVZ1/vgCl+utVP4a+oq/zezSAzs7gnyh5JK+Xti8/09KZgal4zmR9JW0ChDVoTPiB0jS
	mQ7FIHSR0/5y2qI5gKkRXtj5O+uGdpo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E48137EB;
	Mon, 15 Jul 2024 08:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uayuGynclGY2eQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 15 Jul 2024 08:22:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Kai Krakow <hurikhan77@gmail.com>
Subject: [PATCH] btrfs: tree-checker: validate dref root and objectid
Date: Mon, 15 Jul 2024 17:51:35 +0930
Message-ID: <2b16a2e2f704d80edfb0f52ed91ba50fbd39dbaa.1721031688.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[CORRUPTION]
There is a bug report that btrfs flips RO due to a corruption in the
extent tree, the involved dumps looks like this:

 	item 188 key (402811572224 168 4096) itemoff 14598 itemsize 79
 		extent refs 3 gen 3678544 flags 1
 		ref#0: extent data backref root 13835058055282163977 objectid 281473384125923 offset 81432576 count 1
 		ref#1: shared data backref parent 1947073626112 count 1
 		ref#2: shared data backref parent 1156030103552 count 1
 BTRFS critical (device vdc1: state EA): unable to find ref byte nr 402811572224 parent 0 root 265 owner 28703026 offset 81432576 slot 189
 BTRFS error (device vdc1: state EA): failed to run delayed ref for logical 402811572224 num_bytes 4096 type 178 action 2 ref_mod 1: -2

[CAUSE]
The corrupted entry is ref#0 of item 188.
The root number 13835058055282163977 is beyond the upper limit for root
items (the current limit is 1 << 48), and the objectid also looks
suspicious.

Only the offset and count is correct.

[ENHANCEMENT]
Although it's still unknown why we have such many bytes corrupted
randomly, we can still enhance the tree-checker for data backrefs by:

- Validate the root value
  For now there should only be 3 types of roots can have data backref:
  * subvolume trees
  * data reloc trees
  * root tree
    Only for v1 space cache

- validate the objectid value
  The objectid should be a valid inode number.

Hopefully we can catch such problem in the future with the new checkers.

Reported-by: Kai Krakow <hurikhan77@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAMthOuPjg5RDT-G_LXeBBUUtzt3cq=JywF+D1_h+JYxe=WKp-Q@mail.gmail.com/#t
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 6388786fd8b5..d9d0f1f91feb 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1289,6 +1289,19 @@ static void extent_err(const struct extent_buffer *eb, int slot,
 	va_end(args);
 }
 
+static int is_valid_dref_root(u64 rootid)
+{
+	/*
+	 * The following tree root objectid are allowed to have a data backref:
+	 * - subvolume trees
+	 * - data reloc tree
+	 * - tree root
+	 *   For v1 space cache
+	 */
+	return is_fstree(rootid) || rootid == BTRFS_DATA_RELOC_TREE_OBJECTID ||
+	       rootid == BTRFS_ROOT_TREE_OBJECTID;
+}
+
 static int check_extent_item(struct extent_buffer *leaf,
 			     struct btrfs_key *key, int slot,
 			     struct btrfs_key *prev_key)
@@ -1441,6 +1454,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 		struct btrfs_extent_data_ref *dref;
 		struct btrfs_shared_data_ref *sref;
 		u64 seq;
+		u64 dref_root;
+		u64 dref_objectid;
 		u64 dref_offset;
 		u64 inline_offset;
 		u8 inline_type;
@@ -1484,11 +1499,26 @@ static int check_extent_item(struct extent_buffer *leaf,
 		 */
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
+			dref_root = btrfs_extent_data_ref_root(leaf, dref);
+			dref_objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 			dref_offset = btrfs_extent_data_ref_offset(leaf, dref);
 			seq = hash_extent_data_ref(
 					btrfs_extent_data_ref_root(leaf, dref),
 					btrfs_extent_data_ref_objectid(leaf, dref),
 					btrfs_extent_data_ref_offset(leaf, dref));
+			if (unlikely(!is_valid_dref_root(dref_root))) {
+				extent_err(leaf, slot,
+					   "invalid data ref root value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
+			if (unlikely(dref_objectid < BTRFS_FIRST_FREE_OBJECTID ||
+				     dref_objectid > BTRFS_LAST_FREE_OBJECTID)) {
+				extent_err(leaf, slot,
+					   "invalid data ref objectid value %llu",
+					   dref_root);
+				return -EUCLEAN;
+			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
 						 fs_info->sectorsize))) {
 				extent_err(leaf, slot,
@@ -1627,6 +1657,8 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
+		u64 root;
+		u64 objectid;
 		u64 offset;
 
 		/*
@@ -1634,7 +1666,22 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		 * overflow from the leaf due to hash collisions.
 		 */
 		dref = (struct btrfs_extent_data_ref *)ptr;
+		root = btrfs_extent_data_ref_root(leaf, dref);
+		objectid = btrfs_extent_data_ref_objectid(leaf, dref);
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
+		if (unlikely(!is_valid_dref_root(root))) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref root value %llu",
+				   root);
+			return -EUCLEAN;
+		}
+		if (unlikely(objectid < BTRFS_FIRST_FREE_OBJECTID ||
+			     objectid > BTRFS_LAST_FREE_OBJECTID)) {
+			extent_err(leaf, slot,
+				   "invalid extent data backref objectid value %llu",
+				   root);
+			return -EUCLEAN;
+		}
 		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-- 
2.45.2


