Return-Path: <linux-btrfs+bounces-4666-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 376A98B972C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 11:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2801C21463
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 09:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538253379;
	Thu,  2 May 2024 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g0n1ZWz1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="g0n1ZWz1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603547772
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640900; cv=none; b=iJ785Uk7fZbQJqhUHMIQkrEF/SOdkXBB75Na0bLR160760BBmwV2klOCy3mIVIMgHffUfKuwplboKJarFrAGRKlY8AfcOeZqG0l0nZB4/jcSS1ytbwiqG0ZdThMmOE5fYYlaRZgLMpWNvOOy6pqpNAkc9FdrJdhjhw4SU+yO1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640900; c=relaxed/simple;
	bh=JqUSTZhLCyvKaz6onISwYB82AImKxk/JDVc2eK2nr8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aesq+HD96gOv0Aj/ws0DGyMxPbH29Rm8/oUyFzr4mkfMI4aB19xgTjKseXn7E0L2hWUwaxaHO7DCtqBdzXQ0bgg7OHgVb87yFXjtj4QuoyqxW3OFTZJfJZex4hFQurGxSKJXiKId454NgwrMtHBDxcjFcgNkr5xOXYujRHIzQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g0n1ZWz1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=g0n1ZWz1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9981F1FBDB
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEFjm3L55zz33ExDCw708NJKMIWxIU8WoFUm4qcscVk=;
	b=g0n1ZWz1E6WpcyGtg06rnExn7AbAIPKAft9zdDI2NHb22vxnmQAJFsmAcA3izs/wjeBE+X
	hwvFnSl/aQafvkGIArxY7dL+JfKG8P60Y04lXkFqOmglX7f16kmRGXI2jYrWmnfaO6eOgo
	HHj5jOQqDwLGJD4rHhoUb56KiJIUuaE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=g0n1ZWz1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714640896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xEFjm3L55zz33ExDCw708NJKMIWxIU8WoFUm4qcscVk=;
	b=g0n1ZWz1E6WpcyGtg06rnExn7AbAIPKAft9zdDI2NHb22vxnmQAJFsmAcA3izs/wjeBE+X
	hwvFnSl/aQafvkGIArxY7dL+JfKG8P60Y04lXkFqOmglX7f16kmRGXI2jYrWmnfaO6eOgo
	HHj5jOQqDwLGJD4rHhoUb56KiJIUuaE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADF941386E
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 09:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MHDNGf9XM2ZZcAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 02 May 2024 09:08:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: detect and repair mismatched ram_bytes
Date: Thu,  2 May 2024 18:37:53 +0930
Message-ID: <eb2fc3aeed032dfa887ae39740528d0d17ce71a6.1714640642.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714640642.git.wqu@suse.com>
References: <cover.1714640642.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9981F1FBDB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

For non-compressed non-hole file extent items, the ram_bytes should
match disk_num_bytes.

But due to kernel bugs, we have several cases where ram_bytes is not
correctly updated.

Thankfully this is really a very minor mismatch and can never cause data
corruption since the kernel does not utilize ram_bytes for
non-compressed extents at all.

So here we just detect and repair it for lowmem mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 check/mode-lowmem.h |  1 +
 2 files changed, 70 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index fd9b975c4e5f..99e1305b1f3e 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2081,6 +2081,61 @@ static int check_file_extent_inline(struct btrfs_root *root,
 	return err;
 }
 
+static int repair_ram_bytes_mismatch(struct btrfs_root *root,
+				     struct btrfs_path *path)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *fi;
+	u64 disk_num_bytes;
+	int recover_ret;
+	int ret;
+
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	btrfs_release_path(path);
+	UASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		return ret;
+	}
+
+	ret = btrfs_search_slot(trans, root, &key, path, 0, 1);
+	/* Not really possible. */
+	if (ret > 0) {
+		ret = -ENOENT;
+		btrfs_release_path(path);
+		goto recover;
+	}
+
+	if (ret < 0)
+		goto recover;
+
+	fi = btrfs_item_ptr(path->nodes[0], path->slots[0],
+			    struct btrfs_file_extent_item);
+	disk_num_bytes = btrfs_file_extent_disk_num_bytes(path->nodes[0], fi);
+	btrfs_set_file_extent_ram_bytes(path->nodes[0], fi, disk_num_bytes);
+	btrfs_mark_buffer_dirty(path->nodes[0]);
+
+	ret = btrfs_commit_transaction(trans, root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+	} else {
+		printf(
+	"Successfully repaired ram_bytes for non-compressed extent at root %llu ino %llu file_pos %llu\n",
+			root->objectid, key.objectid, key.offset);
+	}
+	return ret;
+recover:
+	recover_ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	UASSERT(recover_ret == 0);
+	return ret;
+}
+
 /*
  * Check file extent datasum/hole, update the size of the file extents,
  * check and update the last offset of the file extent.
@@ -2106,6 +2161,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	u64 csum_found;		/* In byte size, sectorsize aligned */
 	u64 search_start;	/* Logical range start we search for csum */
 	u64 search_len;		/* Logical range len we search for csum */
+	u64 ram_bytes;
 	u64 gen;
 	u64 super_gen;
 	unsigned int extent_type;
@@ -2140,6 +2196,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	extent_num_bytes = btrfs_file_extent_num_bytes(node, fi);
 	extent_offset = btrfs_file_extent_offset(node, fi);
 	compressed = btrfs_file_extent_compression(node, fi);
+	ram_bytes = btrfs_file_extent_ram_bytes(node, fi);
 	is_hole = (disk_bytenr == 0) && (disk_num_bytes == 0);
 	super_gen = btrfs_super_generation(gfs_info->super_copy);
 
@@ -2150,6 +2207,18 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 		err |= INVALID_GENERATION;
 	}
 
+	if (!compressed && disk_bytenr && disk_num_bytes != ram_bytes) {
+		error(
+		"minor ram_bytes mismatch for non-compressed data extents, have %llu expect %llu",
+		      ram_bytes, disk_num_bytes);
+		if (opt_check_repair) {
+			ret = repair_ram_bytes_mismatch(root, path);
+			if (ret < 0)
+				err |= RAM_BYTES_MISMATCH;
+		} else {
+			err |= RAM_BYTES_MISMATCH;
+		}
+	}
 	/*
 	 * Check EXTENT_DATA csum
 	 *
diff --git a/check/mode-lowmem.h b/check/mode-lowmem.h
index b45e6bc137f3..b3e212165519 100644
--- a/check/mode-lowmem.h
+++ b/check/mode-lowmem.h
@@ -47,6 +47,7 @@
 #define INODE_MODE_ERROR	(1U << 25)	/* Bad inode mode */
 #define INVALID_GENERATION	(1U << 26)	/* Generation is too new */
 #define SUPER_BYTES_USED_ERROR	(1U << 27)	/* Super bytes_used is invalid */
+#define RAM_BYTES_MISMATCH	(1U << 27)	/* Non-compressed extent has wrong ram_bytes */
 
 /*
  * Error bit for low memory mode check.
-- 
2.45.0


