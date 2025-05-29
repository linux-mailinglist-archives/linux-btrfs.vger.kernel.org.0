Return-Path: <linux-btrfs+bounces-14293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21529AC79C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 09:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169DB9E166B
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4A2571A0;
	Thu, 29 May 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZLcr5hzi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZLcr5hzi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5411373
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748503715; cv=none; b=eCs5gxEhcEUEVdjaGQdz4agGdxH7G8dPeC4Yp938au5w8v1NEAnWGwtkKTyzvmo4aOlq3JLChU1UF0byRySIcqqZm7FqcWr53sgQMUq12X8YSuFn0Uj4zFfLTVvxNT8HWtPjeVMwoQqT5B/pd0W9VaKYxkNBQAQhxsZDpiJtSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748503715; c=relaxed/simple;
	bh=qK83q2kTxZ2UyBv06mPwriKK8otYzzklEO2cRdbchQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tq2w94wuB5n0DNLgwR41zEDAMZH0Cvw+u2n4aWZrdzxDVrSJG9qJWBX93wjAXDIQrWSsQMKMVwObbSHiLbBcPM00cqDkZXpOLx0nvV00ywKjFpST/zocuylRYJ/F/3oIw0NURd78z1oLUVOF1jTe4uJT98dev81zWk+2IQhlg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZLcr5hzi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZLcr5hzi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21E0B1F45E
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748503705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAWi7NrkhrdFGclTvA49lOQ2X4HnVLa5qsBjZU9m/tY=;
	b=ZLcr5hzi77lllZGWJZyY4Nzo7ZlLIz6WqpxgmbxuwefNZu4PnzEV1uJd5Sl2Vrax7pfSAB
	pPcnBaKCA14p8Cvh7GEpi2ggkUrjgh4b8UV+R2Mh7EQwkQtTMnHQ5jAwHEnzTfYWzmhoMl
	C36Jxv6ihOQ0HK4/cgY4i61ZgkNM990=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748503705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zAWi7NrkhrdFGclTvA49lOQ2X4HnVLa5qsBjZU9m/tY=;
	b=ZLcr5hzi77lllZGWJZyY4Nzo7ZlLIz6WqpxgmbxuwefNZu4PnzEV1uJd5Sl2Vrax7pfSAB
	pPcnBaKCA14p8Cvh7GEpi2ggkUrjgh4b8UV+R2Mh7EQwkQtTMnHQ5jAwHEnzTfYWzmhoMl
	C36Jxv6ihOQ0HK4/cgY4i61ZgkNM990=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DB0C136E0
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EB2iCJgMOGjiUwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 29 May 2025 07:28:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check/lowmem: fix a false alert when counting the refs
Date: Thu, 29 May 2025 16:58:19 +0930
Message-ID: <5c0b299c0088f4d1a3f4a004fa45ad06c7e6a8ea.1748503407.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748503407.git.wqu@suse.com>
References: <cover.1748503407.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]

For a btrfs which is under metadata balance and interrupted (powerloss
etc), we can have the following extent backref item for a data extent:

        item 22 key (13631488 EXTENT_ITEM 524288) itemoff 3161 itemsize 108
                refs 180 gen 9 flags DATA
                (178 0xdfb591fbbf5f519) extent data backref root FS_TREE objectid 258 offset 0 count 77
                (178 0xdfb591fa80d95ea) extent data backref root FS_TREE objectid 257 offset 0 count 1
                (184 0x151e000) shared data backref parent 22142976 count 51
                (184 0x512000) shared data backref parent 5316608 count 51

Then lowmem mode will cause the following false alert:

[3/8] checking extents
ERROR: extent[13631488, 524288] referencer count mismatch (root: 5, owner: 258, offset: 0) wanted: 77, have: 128
ERROR: errors found in extent allocation tree or chunk allocation

[CAUSE]
When shared and keyed backref items are found, we must follow the
following rules to avoid incorrect refs count:

- If the leaf belongs to the shared backref parent
  Then any found EXTENT_DATA inside the leaf will be contributed to the
  shared backref values.

- Otherwise any found EXTENT_DATA can contributed to the keyed backref

In above case, if our leaf is 5316608 or 22142976, then we should not
contribute the number of found EXTENT_DATA to the keyed backref.

Unfortunately the original fix d53d42fa2183 ("btrfs-progs: lowmem: fix
false alerts of referencer count mismatch for blocks relocated") is not
following the above strict rule, but relying on the flag of the leaf.

However that RELOC flag is not a correct indicator, e.g in above case
the leaf at 5316608 is not yet being relocated, thus no RELOC flag.

[FIX]
Instead of check the unreliable RELOC flag, follow the correct rule when
checking the leaf.

Before we start checking the content of a leaf for EXTENT_DATA items,
make sure the leaf's bytenr is not in any shared backref item.
If so skip to the next leaf.

Fixes: d53d42fa2183 ("btrfs-progs: lowmem: fix false alerts of referencer count mismatch for blocks relocated")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 145 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 139 insertions(+), 6 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 34af77f88437..713ddc3d8842 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -3977,6 +3977,139 @@ out:
 	return 0;
 }
 
+/*
+ * A read-only version of lookup_inline_extent_backref().
+ * We can not reuse that function as it always assume COW.
+ */
+static int has_inline_shared_backref(u64 data_bytenr, u64 data_len, u64 parent)
+{
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, data_bytenr);
+	struct btrfs_extent_inline_ref *iref;
+	struct btrfs_extent_item *ei;
+	struct btrfs_path path = { 0 };
+	struct extent_buffer *leaf;
+	struct btrfs_key key;
+	unsigned long ptr;
+	unsigned long end;
+	bool found = false;
+	u32 item_size;
+	u64 flags;
+	int ret;
+
+	key.objectid = data_bytenr;
+	key.type = BTRFS_EXTENT_ITEM_KEY;
+	key.offset = data_len;
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		goto out;
+
+	leaf = path.nodes[0];
+	item_size = btrfs_item_size(leaf, path.slots[0]);
+	if (item_size < sizeof(*ei)) {
+		error("extent item size %u < %zu, leaf %llu slot %u",
+		      item_size, sizeof(*ei), leaf->start, path.slots[0]);
+		ret = -EUCLEAN;
+		goto out;
+	}
+	ei = btrfs_item_ptr(leaf, path.slots[0], struct btrfs_extent_item);
+	flags = btrfs_extent_flags(leaf, ei);
+
+	if (!(flags & BTRFS_EXTENT_FLAG_DATA)) {
+		error("backref item flag for bytenr %llu is not data",
+			data_bytenr);
+		ret = -EUCLEAN;
+		goto out;
+	}
+
+	ptr = (unsigned long)(ei + 1);
+	end = (unsigned long)ei + item_size;
+
+	while (true) {
+		u64 ref_parent;
+		u8 type;
+
+		if (ptr >= end) {
+			if (ptr > end) {
+				error("inline extent item for %llu is not properly ended",
+				      data_bytenr);
+				ret = -EUCLEAN;
+				goto out;
+			}
+			break;
+		}
+		iref = (struct btrfs_extent_inline_ref *)ptr;
+		type = btrfs_extent_inline_ref_type(leaf, iref);
+		if (type != BTRFS_SHARED_DATA_REF_KEY)
+			goto next;
+
+		ref_parent = btrfs_extent_inline_ref_offset(leaf, iref);
+		if (ref_parent == parent) {
+			found = true;
+			goto out;
+		}
+next:
+		ptr += btrfs_extent_inline_ref_size(type);
+	}
+
+out:
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+	return found;
+}
+
+static int has_keyed_shared_backref(u64 data_bytenr, u64 parent)
+{
+	struct btrfs_root *extent_root = btrfs_extent_root(gfs_info, data_bytenr);
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	key.objectid = data_bytenr;
+	key.type = BTRFS_SHARED_DATA_REF_KEY;
+	key.offset = parent;
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+	/* No keyed ref found, return 0. */
+	if (ret > 0)
+		return 0;
+	return 1;
+}
+
+/*
+ * A helper to determine if the @leaf already belongs to a shared data backref item.
+ * (with parent bytenr)
+ *
+ * Return >0 if the @leaf belongs to a shared data backref.
+ * Return 0 if not.
+ * Return <0 for critical error.
+ */
+static int is_leaf_shared(struct extent_buffer *leaf, u64 data_bytenr, u64 data_len)
+{
+	int ret;
+
+	ret = has_inline_shared_backref(data_bytenr, data_len, leaf->start);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search inlined shared backref for logical %llu len %llu, %m",
+			data_bytenr, data_len);
+		return ret;
+	}
+	if (ret > 0)
+		return ret;
+	ret = has_keyed_shared_backref(data_bytenr, leaf->start);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search keyed shared backref for logical %llu len %llu, %m",
+			data_bytenr, data_len);
+	}
+	return ret;
+}
+
 /*
  * Check referencer for normal (inlined) data ref
  * If len == 0, it will be resolved by searching in extent tree
@@ -4049,13 +4182,13 @@ static int check_extent_data_backref(u64 root_id, u64 objectid, u64 offset,
 		    btrfs_header_owner(leaf) != root_id)
 			goto next;
 		/*
-		 * For tree blocks have been relocated, data backref are
-		 * shared instead of keyed. Do not account it.
+		 * If the node belongs to a shared backref item, we should not
+		 * account the number.
 		 */
-		if (btrfs_header_flag(leaf, BTRFS_HEADER_FLAG_RELOC)) {
-			/*
-			 * skip the leaf to speed up.
-			 */
+		ret = is_leaf_shared(leaf, bytenr, len);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
 			slot = btrfs_header_nritems(leaf);
 			goto next;
 		}
-- 
2.49.0


