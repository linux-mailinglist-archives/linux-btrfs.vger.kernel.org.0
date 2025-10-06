Return-Path: <linux-btrfs+bounces-17454-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B976FBBD772
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 11:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73B74E9E42
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFB51F63FF;
	Mon,  6 Oct 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OuSJVzkF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OuSJVzkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1A1F37D3
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743530; cv=none; b=vC6OjclYhZNyWeKhBBGkj6WjOK7g/GBamCBI291DXbbV3cmwZB3osMekYPWTNeASYYZUa1y6zVRhho2ialUGIIassthla1eOIEk7TMzinujfXgVo0ursJijcGvRWBzhmC3mT2Mi2Lqs7DD/eSu1YkYepYbELqPkV4Nfa0Z/VUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743530; c=relaxed/simple;
	bh=IpW8dZb8SsjRz1Xv7DkDyu9AvoaheB4C1bSxICP0o88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlAatEfFFhg2wu1KEGg+GpnEC2tsvrYDjC6qshY+fLlwpxdJVSQ6mh1WAYe3cZ1g7e8ih1evki6zrHVL7p4SEIsqZuMbugN9LWCeeKDEjJpMiV8qvJCBMFEEpWi79hZuUhhs1U7hDDuVXjqwDz1Y8R1/p+iGZequTlXfHkdMZU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OuSJVzkF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OuSJVzkF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A7171F45B
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCu6sfCKd4RCcOUvhDkShCFaygHqez3WKuWbbgkrf7M=;
	b=OuSJVzkFFQsxPz7obj414BfOYnjnWx0ptiYnVn3DAuADS4EXaUXtUH4j1RazGOOJdjs06J
	AgBuWKQdRCVzgxvlXKfb2ZZJtz3hqy1sRIq+iXW7GZD2rUdvitJcMZeaLp9903IPLVCNyH
	VZWV/VquaQSFjEFKVWT+18ijGQc9p/0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759743525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCu6sfCKd4RCcOUvhDkShCFaygHqez3WKuWbbgkrf7M=;
	b=OuSJVzkFFQsxPz7obj414BfOYnjnWx0ptiYnVn3DAuADS4EXaUXtUH4j1RazGOOJdjs06J
	AgBuWKQdRCVzgxvlXKfb2ZZJtz3hqy1sRIq+iXW7GZD2rUdvitJcMZeaLp9903IPLVCNyH
	VZWV/VquaQSFjEFKVWT+18ijGQc9p/0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0B713700
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 09:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wJ81HySO42iUQgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 06 Oct 2025 09:38:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: add repair functionality for orphan dev extents
Date: Mon,  6 Oct 2025 20:08:24 +1030
Message-ID: <4648965f74cd36baa596315c805d811111e57b0b.1759743405.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1759743405.git.wqu@suse.com>
References: <cover.1759743405.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

There is a bug report that btrfs-check --repair didn't repair an orphan
dev extent, which makes kernel to reject the fs due to the overly strict
chunk related checks.

However for btrfs-check, it's pretty easy to remove orphan device
extents (which do not have corresponding chunks), and update the device
item to reflect the used_bytes changes.

Add a repair function, btrfs_remove_dev_extent() which does the repair,
and call that function for both original and lowmem modes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  6 +++-
 check/mode-lowmem.c |  7 +++-
 check/repair.c      | 78 +++++++++++++++++++++++++++++++++++++++++++++
 check/repair.h      |  1 +
 4 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 91ce6d7401a1..e457c9073bfb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8601,7 +8601,11 @@ int check_chunks(struct cache_tree *chunk_cache,
 				dext_rec->objectid,
 				dext_rec->offset,
 				dext_rec->length);
-		if (!ret)
+		err = -ENOENT;
+		if (opt_check_repair)
+			err = btrfs_remove_dev_extent(gfs_info, dext_rec->objectid,
+						      dext_rec->offset);
+		if (err && !ret)
 			ret = 1;
 	}
 	return ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 774a57c861a4..363dc4ae1904 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4749,7 +4749,12 @@ out:
 		error(
 		"device extent[%llu, %llu, %llu] did not find the related chunk",
 			devext_key.objectid, devext_key.offset, length);
-		return REFERENCER_MISSING;
+		ret = -ENOENT;
+		if (opt_check_repair)
+			ret = btrfs_remove_dev_extent(gfs_info, devext_key.objectid,
+						      devext_key.offset);
+		if (ret < 0)
+			return REFERENCER_MISSING;
 	}
 	return 0;
 }
diff --git a/check/repair.c b/check/repair.c
index e500c4fa0a3a..729b040ce2fd 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -31,7 +31,9 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/tree-checker.h"
+#include "kernel-shared/volumes.h"
 #include "common/extent-cache.h"
+#include "common/messages.h"
 #include "check/repair.h"
 
 int opt_check_repair = 0;
@@ -354,6 +356,82 @@ out:
 	return ret;
 }
 
+int btrfs_remove_dev_extent(struct btrfs_fs_info *fs_info, u64 devid, u64 physical)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *dev_root = fs_info->dev_root;
+	struct btrfs_key key = {
+		.objectid = devid,
+		.type = BTRFS_DEV_EXTENT_KEY,
+		.offset = physical,
+	};
+	struct btrfs_path path = { 0 };
+	struct btrfs_dev_extent *dext;
+	struct btrfs_device *dev;
+	u64 length;
+	int ret;
+
+	dev = btrfs_find_device_by_devid(fs_info->fs_devices, devid, 0);
+	if (!dev) {
+		ret = -ENOENT;
+		error("failed to find devid %llu", devid);
+		return ret;
+	}
+	trans = btrfs_start_transaction(dev_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		return ret;
+	}
+	ret = btrfs_search_slot(trans, dev_root, &key, &path, -1, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to locate dev extent, devid %llu physical %llu: %m",
+		      devid, physical);
+		goto abort;
+	}
+	dext = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_dev_extent);
+	length = btrfs_dev_extent_length(path.nodes[0], dext);
+	ret = btrfs_del_item(trans, dev_root, &path);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to delete dev extent, devid %llu physical %llu: %m",
+		      devid, physical);
+		goto abort;
+	}
+	btrfs_release_path(&path);
+	if (dev->bytes_used < length) {
+		warning("devid %llu has bytes_used %llu, smaller than %llu",
+			devid, dev->bytes_used, length);
+		dev->bytes_used = 0;
+	} else {
+		dev->bytes_used -= length;
+	}
+	ret = btrfs_update_device(trans, dev);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to update device, devid %llu: %m", devid);
+		goto abort;
+	}
+	ret = btrfs_commit_transaction(trans, dev_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+	} else {
+		printf("removed orphan dev extent, devid %llu physical %llu length %llu\n",
+			devid, physical, length);
+	}
+	return ret;
+
+abort:
+	btrfs_release_path(&path);
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
 enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *eb,
 							  struct btrfs_key *first_key)
 {
diff --git a/check/repair.h b/check/repair.h
index 4d59ca1dd115..d8a191b89fc8 100644
--- a/check/repair.h
+++ b/check/repair.h
@@ -48,6 +48,7 @@ int btrfs_mark_used_tree_blocks(struct btrfs_fs_info *fs_info,
 				struct extent_io_tree *tree);
 int btrfs_mark_used_blocks(struct btrfs_fs_info *fs_info,
 			   struct extent_io_tree *tree);
+int btrfs_remove_dev_extent(struct btrfs_fs_info *fs_info, u64 devid, u64 physical);
 enum btrfs_tree_block_status btrfs_check_block_for_repair(struct extent_buffer *eb,
 							  struct btrfs_key *first_key);
 void btrfs_set_item_key_unsafe(struct btrfs_root *root, struct btrfs_path *path,
-- 
2.50.1


