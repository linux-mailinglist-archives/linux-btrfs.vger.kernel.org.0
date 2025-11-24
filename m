Return-Path: <linux-btrfs+bounces-19281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52278C7EF04
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 05:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE9E3A5757
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Nov 2025 04:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E712BCF6C;
	Mon, 24 Nov 2025 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fvlJGnZw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fvlJGnZw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E271B4257
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763957771; cv=none; b=W1oWguIipEtyGrIQ8goo7GOycpsYvHJCcwbCfjEguuBvspohmLeCDoyGvFp6XNbX0Whc86bd5x2ewu/1yRSnBQMNhVdBQ2DQWfg+DG5O2vsO7bXqqDclniXt+FtUEBuOubCkcsb1tp8Bz4qV1meIzMGTfxd0Uqp4xoj8W0XL7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763957771; c=relaxed/simple;
	bh=0O3aCnmIkK/lUmZyD5RGJGI8FKnGN6G+V9JQfyX1kM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMjVfrlx5Z3PkpPAhErFH3BmqdH2BguN3e0yRA2+1kBtV00AjTne5SyWZlWW7OCXmjqNdZdbhzBwDoubEF/LSVDpaGkXcee8kOikiYnQMNdKhOvnrSn1qU0IXJW0mHL2e1Znyo9zDN16YBNtR9bWbXBTRHlzkrAyxGflz975/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fvlJGnZw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fvlJGnZw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BD865BD08
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DagxA1GvJKDN/4z6tUczqE/NN546sIm3Vs4QSkm0KyI=;
	b=fvlJGnZwSvIMBtRo6/u9PkEQy1hxMcr2VJzhyk47tt6gvSBC9MH/Eqnu8vKAn8BHROQitn
	IFkhbC5z9vKO6rsPXMgwH0yYaaYdzGiHNbv7tZuXvFURWli4s5Lto9NJxAfcbPO7oob5ov
	0G1xu2o6iRErUFYUPEukKITJLG9b/Cw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fvlJGnZw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763957752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DagxA1GvJKDN/4z6tUczqE/NN546sIm3Vs4QSkm0KyI=;
	b=fvlJGnZwSvIMBtRo6/u9PkEQy1hxMcr2VJzhyk47tt6gvSBC9MH/Eqnu8vKAn8BHROQitn
	IFkhbC5z9vKO6rsPXMgwH0yYaaYdzGiHNbv7tZuXvFURWli4s5Lto9NJxAfcbPO7oob5ov
	0G1xu2o6iRErUFYUPEukKITJLG9b/Cw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A39CE3EA61
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEgtGffbI2kDRwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Nov 2025 04:15:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: btrfs: refactor the error handling of __free_extent()
Date: Mon, 24 Nov 2025 14:45:27 +1030
Message-ID: <d60658bad5a253aff6b0a54a6484b9d17d1c34a3.1763957608.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763957608.git.wqu@suse.com>
References: <cover.1763957608.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6BD865BD08
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Just follow the kernel patch "btrfs: refactor the error handling of
__btrfs_free_extent()", to handle the error first for
lookup_extent_backref(), so we can reduce one indent level.

Furthermore remove the unnessary forced type casting of the error
message, and replace the old printk() with proper the error() helper.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/extent-tree.c | 150 +++++++++++++++++-------------------
 1 file changed, 72 insertions(+), 78 deletions(-)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 9d0155502d5e..c32999055ecf 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1980,84 +1980,10 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 				    bytenr, num_bytes, parent,
 				    root_objectid, owner_objectid,
 				    owner_offset);
-	if (ret == 0) {
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
-			if (path->slots[0] - extent_slot > 5)
-				break;
-			extent_slot--;
-		}
-		if (!found_extent) {
-			BUG_ON(iref);
-			ret = remove_extent_backref(trans, extent_root, path,
-						    NULL, refs_to_drop,
-						    is_data);
-			BUG_ON(ret);
-			btrfs_release_path(path);
-
-			key.objectid = bytenr;
-
-			if (skinny_metadata) {
-				key.type = BTRFS_METADATA_ITEM_KEY;
-				key.offset = owner_objectid;
-			} else {
-				key.type = BTRFS_EXTENT_ITEM_KEY;
-				key.offset = num_bytes;
-			}
-
-			ret = btrfs_search_slot(trans, extent_root,
-						&key, path, -1, 1);
-			if (ret > 0 && skinny_metadata && path->slots[0]) {
-				path->slots[0]--;
-				btrfs_item_key_to_cpu(path->nodes[0],
-						      &key,
-						      path->slots[0]);
-				if (key.objectid == bytenr &&
-				    key.type == BTRFS_EXTENT_ITEM_KEY &&
-				    key.offset == num_bytes)
-					ret = 0;
-			}
-
-			if (ret > 0 && skinny_metadata) {
-				skinny_metadata = 0;
-				btrfs_release_path(path);
-				key.type = BTRFS_EXTENT_ITEM_KEY;
-				key.offset = num_bytes;
-				ret = btrfs_search_slot(trans, extent_root,
-							&key, path, -1, 1);
-			}
-
-			if (ret) {
-				printk(KERN_ERR "umm, got %d back from search"
-				       ", was looking for %llu\n", ret,
-				       (unsigned long long)bytenr);
-				btrfs_print_leaf(path->nodes[0]);
-			}
-			BUG_ON(ret);
-			extent_slot = path->slots[0];
-		}
-	} else {
-		printk(KERN_ERR "btrfs unable to find ref byte nr %llu "
-		       "parent %llu root %llu  owner %llu offset %llu\n",
-		       (unsigned long long)bytenr,
-		       (unsigned long long)parent,
-		       (unsigned long long)root_objectid,
-		       (unsigned long long)owner_objectid,
-		       (unsigned long long)owner_offset);
+	if (ret) {
+		error("unable to find ref byte nr %llu parent %llu root %llu  owner %llu offset %llu ret %d\n",
+		       bytenr, parent, root_objectid, owner_objectid,
+		       owner_offset, ret);
 		if (path->nodes[0]) {
 			printf("path->slots[0]: %d path->nodes[0]:\n", path->slots[0]);
 			btrfs_print_leaf(path->nodes[0]);
@@ -2065,7 +1991,75 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		ret = -EIO;
 		goto fail;
 	}
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
+		}
+		if (path->slots[0] - extent_slot > 5)
+			break;
+		extent_slot--;
+	}
+	if (!found_extent) {
+		BUG_ON(iref);
+		ret = remove_extent_backref(trans, extent_root, path,
+					    NULL, refs_to_drop,
+					    is_data);
+		BUG_ON(ret);
+		btrfs_release_path(path);
 
+		key.objectid = bytenr;
+
+		if (skinny_metadata) {
+			key.type = BTRFS_METADATA_ITEM_KEY;
+			key.offset = owner_objectid;
+		} else {
+			key.type = BTRFS_EXTENT_ITEM_KEY;
+			key.offset = num_bytes;
+		}
+
+		ret = btrfs_search_slot(trans, extent_root,
+					&key, path, -1, 1);
+		if (ret > 0 && skinny_metadata && path->slots[0]) {
+			path->slots[0]--;
+			btrfs_item_key_to_cpu(path->nodes[0],
+					      &key,
+					      path->slots[0]);
+			if (key.objectid == bytenr &&
+			    key.type == BTRFS_EXTENT_ITEM_KEY &&
+			    key.offset == num_bytes)
+				ret = 0;
+		}
+
+		if (ret > 0 && skinny_metadata) {
+			skinny_metadata = 0;
+			btrfs_release_path(path);
+			key.type = BTRFS_EXTENT_ITEM_KEY;
+			key.offset = num_bytes;
+			ret = btrfs_search_slot(trans, extent_root,
+						&key, path, -1, 1);
+		}
+
+		if (ret) {
+			printk(KERN_ERR "umm, got %d back from search"
+			       ", was looking for %llu\n", ret,
+			       (unsigned long long)bytenr);
+			btrfs_print_leaf(path->nodes[0]);
+		}
+		BUG_ON(ret);
+		extent_slot = path->slots[0];
+	}
 	leaf = path->nodes[0];
 	item_size = btrfs_item_size(leaf, extent_slot);
 	if (item_size < sizeof(*ei)) {
-- 
2.52.0


