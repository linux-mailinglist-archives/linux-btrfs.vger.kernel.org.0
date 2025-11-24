Return-Path: <linux-btrfs+bounces-19278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FACC7EEDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 05:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 495F33462EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA308276028;
	Mon, 24 Nov 2025 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s9/wlpIl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MI7jqYC2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68998A945
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763956859; cv=none; b=mV3YA5ApEHXGZeeVYsu3etvYE7voHZh48JxlFTy1r6eTFgZFa2O4r4Hn87UzyonYZQYD9U4jgRX/f1Ncndh8MmvcyaEC2AA2gAFLhKyADd7z0UxjimGBD3ZnOsW+/pB4QLA7XLEiUa9QtggI4ZiFsJrHnIZZhAC4WzdFgO77s1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763956859; c=relaxed/simple;
	bh=VFLgDiv4ElAuZTy/x7jrzYxFDS8nWzgopnsAeIiH5wU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cVr9TBdLv12Na66uB1mXSLxzISm2h44/X+KZVyUWBAZDtMGjTiZWAXSk/APM6oQi1iJoCjBz+UWfEky1NYpj2iNI7+8Iz7GghHxf3xPPzGsd7i6slIL7/dxoB0BKelZoF/ygzVOaFHDXFSlWubhxz+BIFbJtnaiJq64VY6i0J3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s9/wlpIl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MI7jqYC2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5229021E9D
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763956855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ItHOkPjw8qrHf+jk3h+OyGYxIw7bn4CZ7cMayil14Nk=;
	b=s9/wlpIlyz+pMFntzkz18g+ICHL7jxhBb2UTz4mtg70OcBjeHqY0W3cB66pYncMutiY1Iv
	iW0UM0wsVFlGlvo+Wom59Q+mjTx6zYKwbWHqEbcKFkSQ9INEzn0Ly1sFn6hDAWxjCBUohG
	v9YfMRgLYVACcMBuDQd5/A6F7OwNz6E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763956854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ItHOkPjw8qrHf+jk3h+OyGYxIw7bn4CZ7cMayil14Nk=;
	b=MI7jqYC2tmm+BZA8FNeDZmMwSGqrfg6SbpcPVNtZ7lws5j3HUVjri8m1oqLAvU7ffVRm65
	39YYFeY/z4vEc1GJxOdZTwJTGdfT/Gt5iEwv2M9v8RwEcn4sSYEqxNDcLUijqIeU/LHTbQ
	iIzDv3jNzHpMSXOrL61Fklywbudrz/U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 897A73EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:00:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FdGbEnXYI2nWOQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:00:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor the error handling of __btrfs_free_extent()
Date: Mon, 24 Nov 2025 14:30:35 +1030
Message-ID: <8063427f63eccedb762657d6fa9ede4c7881c20e.1763956827.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The error handling of the lookup_extent_backref() call is pretty
uncommon, normally we handle the error first so the most common cases
follows (thus has no extra indent).

But in this case we handle the common case inside a big if block, then
followed by extra error handling.

Furthermore the error handling is also inconsistent, for
no-backref-found errors, we call abort_and_dump() with a proper error
message, but for other error codes we just abort silently.

Refactor the error handling by:

- Unifty the error handling for ENOENT and other error codes
  For ret == -ENOENT case, the @path is not released thus we can dump
  the leaf. But for other error codes @path is released.

  Update abort_and_dump() to check if path->nodes[0] is populated, then
  dump the leaf.
  So that abort_and_dump() can handle all error codes from
  lookup_extent_backref().

  This also means we removes the "WARN_ON(ret == -ENOENT)", which should
  be fine as btrfs_abort_transaction() will also trigger a call trace
  for errors other than -EIO.

- Add extra error code to the abort_and_dump() call for
  lookup_extent_backref() error

- Handle the error cases first for lookup_extent_backref()

- Move the common case handling out of the big if block
  So we can reduce one level of indent.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 192 ++++++++++++++++++++---------------------
 1 file changed, 95 insertions(+), 97 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a3646440c4fe..dad2dd5fb56d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3015,7 +3015,8 @@ static int do_free_extent_accounting(struct btrfs_trans_handle *trans,
 #define abort_and_dump(trans, path, fmt, args...)	\
 ({							\
 	btrfs_abort_transaction(trans, -EUCLEAN);	\
-	btrfs_print_leaf(path->nodes[0]);		\
+	if (path->nodes[0])				\
+		btrfs_print_leaf(path->nodes[0]);	\
 	btrfs_crit(trans->fs_info, fmt, ##args);	\
 })
 
@@ -3129,112 +3130,109 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 	ret = lookup_extent_backref(trans, path, &iref, bytenr, num_bytes,
 				    node->parent, node->ref_root, owner_objectid,
 				    owner_offset);
-	if (ret == 0) {
-		/*
-		 * Either the inline backref or the SHARED_DATA_REF/
-		 * SHARED_BLOCK_REF is found
-		 *
-		 * Here is a quick path to locate EXTENT/METADATA_ITEM.
-		 * It's possible the EXTENT/METADATA_ITEM is near current slot.
-		 */
-		extent_slot = path->slots[0];
-		while (extent_slot >= 0) {
-			btrfs_item_key_to_cpu(path->nodes[0], &key,
-					      extent_slot);
-			if (key.objectid != bytenr)
-				break;
-			if (key.type == BTRFS_EXTENT_ITEM_KEY &&
-			    key.offset == num_bytes) {
-				found_extent = 1;
-				break;
-			}
-			if (key.type == BTRFS_METADATA_ITEM_KEY &&
-			    key.offset == owner_objectid) {
-				found_extent = 1;
-				break;
-			}
+	if (ret) {
+		abort_and_dump(trans, path,
+"unable to find ref byte nr %llu parent %llu root %llu owner %llu offset %llu slot %d ret %d",
+			       bytenr, node->parent, node->ref_root, owner_objectid,
+			       owner_offset, path->slots[0], ret);
+		goto out;
+	}
 
-			/* Quick path didn't find the EXTENT/METADATA_ITEM */
-			if (path->slots[0] - extent_slot > 5)
-				break;
-			extent_slot--;
+	/*
+	 * Either the inline backref or the SHARED_DATA_REF/SHARED_BLOCK_REF
+	 * is found
+	 *
+	 * Here is a quick path to locate EXTENT/METADATA_ITEM.
+	 * It's possible the EXTENT/METADATA_ITEM is near current slot.
+	 */
+	extent_slot = path->slots[0];
+	while (extent_slot >= 0) {
+		btrfs_item_key_to_cpu(path->nodes[0], &key,
+				      extent_slot);
+		if (key.objectid != bytenr)
+			break;
+		if (key.type == BTRFS_EXTENT_ITEM_KEY &&
+		    key.offset == num_bytes) {
+			found_extent = 1;
+			break;
+		}
+		if (key.type == BTRFS_METADATA_ITEM_KEY &&
+		    key.offset == owner_objectid) {
+			found_extent = 1;
+			break;
 		}
 
-		if (!found_extent) {
-			if (unlikely(iref)) {
-				abort_and_dump(trans, path,
-"invalid iref slot %u, no EXTENT/METADATA_ITEM found but has inline extent ref",
-					   path->slots[0]);
-				ret = -EUCLEAN;
-				goto out;
-			}
-			/* Must be SHARED_* item, remove the backref first */
-			ret = remove_extent_backref(trans, extent_root, path,
-						    NULL, refs_to_drop, is_data);
-			if (unlikely(ret)) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
-			btrfs_release_path(path);
+		/* Quick path didn't find the EXTENT/METADATA_ITEM */
+		if (path->slots[0] - extent_slot > 5)
+			break;
+		extent_slot--;
+	}
 
-			/* Slow path to locate EXTENT/METADATA_ITEM */
+	if (!found_extent) {
+		if (unlikely(iref)) {
+			abort_and_dump(trans, path,
+"invalid iref slot %u, no EXTENT/METADATA_ITEM found but has inline extent ref",
+				   path->slots[0]);
+			ret = -EUCLEAN;
+			goto out;
+		}
+		/* Must be SHARED_* item, remove the backref first */
+		ret = remove_extent_backref(trans, extent_root, path,
+					    NULL, refs_to_drop, is_data);
+		if (unlikely(ret)) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+		btrfs_release_path(path);
+
+		/* Slow path to locate EXTENT/METADATA_ITEM */
+		key.objectid = bytenr;
+		key.type = BTRFS_EXTENT_ITEM_KEY;
+		key.offset = num_bytes;
+
+		if (!is_data && skinny_metadata) {
+			key.type = BTRFS_METADATA_ITEM_KEY;
+			key.offset = owner_objectid;
+		}
+
+		ret = btrfs_search_slot(trans, extent_root,
+					&key, path, -1, 1);
+		if (ret > 0 && skinny_metadata && path->slots[0]) {
+			/*
+			 * Couldn't find our skinny metadata item,
+			 * see if we have ye olde extent item.
+			 */
+			path->slots[0]--;
+			btrfs_item_key_to_cpu(path->nodes[0], &key,
+					      path->slots[0]);
+			if (key.objectid == bytenr &&
+			    key.type == BTRFS_EXTENT_ITEM_KEY &&
+			    key.offset == num_bytes)
+				ret = 0;
+		}
+
+		if (ret > 0 && skinny_metadata) {
+			skinny_metadata = false;
 			key.objectid = bytenr;
 			key.type = BTRFS_EXTENT_ITEM_KEY;
 			key.offset = num_bytes;
-
-			if (!is_data && skinny_metadata) {
-				key.type = BTRFS_METADATA_ITEM_KEY;
-				key.offset = owner_objectid;
-			}
-
+			btrfs_release_path(path);
 			ret = btrfs_search_slot(trans, extent_root,
 						&key, path, -1, 1);
-			if (ret > 0 && skinny_metadata && path->slots[0]) {
-				/*
-				 * Couldn't find our skinny metadata item,
-				 * see if we have ye olde extent item.
-				 */
-				path->slots[0]--;
-				btrfs_item_key_to_cpu(path->nodes[0], &key,
-						      path->slots[0]);
-				if (key.objectid == bytenr &&
-				    key.type == BTRFS_EXTENT_ITEM_KEY &&
-				    key.offset == num_bytes)
-					ret = 0;
-			}
-
-			if (ret > 0 && skinny_metadata) {
-				skinny_metadata = false;
-				key.objectid = bytenr;
-				key.type = BTRFS_EXTENT_ITEM_KEY;
-				key.offset = num_bytes;
-				btrfs_release_path(path);
-				ret = btrfs_search_slot(trans, extent_root,
-							&key, path, -1, 1);
-			}
-
-			if (ret) {
-				if (ret > 0)
-					btrfs_print_leaf(path->nodes[0]);
-				btrfs_err(info,
-			"umm, got %d back from search, was looking for %llu, slot %d",
-					  ret, bytenr, path->slots[0]);
-			}
-			if (unlikely(ret < 0)) {
-				btrfs_abort_transaction(trans, ret);
-				goto out;
-			}
-			extent_slot = path->slots[0];
 		}
-	} else if (WARN_ON(ret == -ENOENT)) {
-		abort_and_dump(trans, path,
-"unable to find ref byte nr %llu parent %llu root %llu owner %llu offset %llu slot %d",
-			       bytenr, node->parent, node->ref_root, owner_objectid,
-			       owner_offset, path->slots[0]);
-		goto out;
-	} else {
-		btrfs_abort_transaction(trans, ret);
-		goto out;
+
+		if (ret) {
+			if (ret > 0)
+				btrfs_print_leaf(path->nodes[0]);
+			btrfs_err(info,
+		"umm, got %d back from search, was looking for %llu, slot %d",
+				  ret, bytenr, path->slots[0]);
+		}
+		if (unlikely(ret < 0)) {
+			btrfs_abort_transaction(trans, ret);
+			goto out;
+		}
+		extent_slot = path->slots[0];
 	}
 
 	leaf = path->nodes[0];
-- 
2.52.0


